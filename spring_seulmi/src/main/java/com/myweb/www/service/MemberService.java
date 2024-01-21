package com.myweb.www.service;

import java.util.List;

import com.myweb.www.security.MemberVO;

public interface MemberService {

	MemberVO emailCheck(String email);

	void insert(MemberVO mvo);

	boolean updateLastLogin(String authEmail);

	void updateNoPwd(MemberVO mvo);

	void updateWithPwd(MemberVO mvo);

	List<MemberVO> mvoList();

	void delete(String name);

}
