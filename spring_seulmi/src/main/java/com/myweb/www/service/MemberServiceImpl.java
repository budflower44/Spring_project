package com.myweb.www.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.myweb.www.repository.MemberDAO;
import com.myweb.www.security.MemberVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

	private final MemberDAO mdao;

	@Override
	public MemberVO emailCheck(String email) {
		return mdao.emailCheck(email);
	}

	@Override
	public void insert(MemberVO mvo) {
		mdao.insert(mvo);
		mdao.insertAuth(mvo.getEmail());
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ seviceImpl mvo"+authEmail);
		return mdao.updateLastLogin(authEmail) >0 ? true : false;
	}

	@Override
	public void updateNoPwd(MemberVO mvo) {
		mdao.updateNoPwd(mvo);
	}

	@Override
	public void updateWithPwd(MemberVO mvo) {
		mdao.updateWithPwd(mvo);
		
	}

	@Override
	public List<MemberVO> mvoList() {
		List<MemberVO> mList = mdao.selectAllMember();
		for(MemberVO mvo : mList) {
			mvo.setAuthList(mdao.selectAllAuth());
		}
		return mList;
	}

	@Override
	public void delete(String name) {
		mdao.deleteAuth(name);
		mdao.delete(name);
	}
	
}
