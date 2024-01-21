package com.myweb.www.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.security.MemberVO;
import com.myweb.www.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/member/**")
@Controller
public class MemberController {
	
	private final MemberService msv;
	private final BCryptPasswordEncoder bcEncoder;
	
	@GetMapping("/register")
	public void registerPage() {}
	
	@GetMapping(value = "/emailCheck/{email}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> emailCheck(@PathVariable("email") String email){
		MemberVO mvo = msv.emailCheck(email);
		return (mvo == null) ? new ResponseEntity<String>("1", HttpStatus.OK) : 
			new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
		msv.insert(mvo);
		return "index";
	}
	
	@GetMapping("/login")
	public void loginPage() {}
	
	//@postMappting("/login") 대신 CustomAuthMemberService 로 바로 타게됨
	
	@PostMapping("/login")
	public String login(HttpServletRequest request, RedirectAttributes re) {
		//로그인 실패 시 다시 로그인 페이지로 돌아와 오류 메시지 전송
		//다시 로그인 유도
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		return "redirect:/member/login	";
	}
	
	@GetMapping("/modify")
	public void detailPage() {}
	
	@Transactional
	@PostMapping("/modify")
	public String modify(MemberVO mvo, HttpServletRequest request, HttpServletResponse respones) {
		//비번 없는 업데이트 진행
		if(mvo.getPwd().isEmpty()) {
			msv.updateNoPwd(mvo);			
		}else {
			mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
			msv.updateWithPwd(mvo);
		}
		//로그아웃 진행
		logout(request, respones);
		return "redirect:/member/login";
	}
	
	@GetMapping("/list")
	public void list(Model m) {
		m.addAttribute("mvoList", msv.mvoList());
	}
	
	@GetMapping("/delete")
	public String delete(Principal p, HttpServletRequest request, HttpServletResponse respones) {
		msv.delete(p.getName());
		//로그아웃 진행
		logout(request, respones);
		return "redirect:/";
	}
	

	private void logout(HttpServletRequest request, HttpServletResponse respones) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, respones, authentication);
	}
	
	
}
