package com.cs.service;

import java.util.List;

import com.cs.domain.MemberVO;

public interface MemberService {

	public int register(MemberVO vo);
	
	public MemberVO getByUserId(String userid);
	// 이메일로 존재여부 체크
	public MemberVO getByEmail(String email);
	// 회원 정보 수정
	public boolean modifyMyInfo(MemberVO vo);
	// 아이디, 비밀번호 찾기
	public MemberVO verifyMember(MemberVO vo);
	// 비밀번호 수정
	public String modifyPassword(MemberVO vo);
}
