package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.security.AuthVO;
import com.myweb.www.security.MemberVO;

public interface MemberDAO {

	MemberVO emailCheck(String email);

	void insert(MemberVO mvo);

	void insertAuth(String email);

	List<AuthVO> selectAuths(String username);

	int updateLastLogin(String authEmail);

	void updateNoPwd(MemberVO mvo);

	void updateWithPwd(MemberVO mvo);

	List<MemberVO> selectAllMember();

	List<AuthVO> selectAllAuth();

	void delete(String name);

	void deleteAuth(String name);

}
