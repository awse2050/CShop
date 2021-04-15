package com.cs.mapper;

import java.util.List;

import com.cs.domain.MemberVO;

public interface MemberMapper {
	// 아이디로 찾기
	public MemberVO read(String userid);
	// 저장하기
	public int insert(MemberVO vo);
	// 이메일 중복체크를 위한 조회
	public MemberVO readByEmail(String email);
	// 회원정보 수정
	public boolean update(MemberVO vo);
	// 아이디,비밀번호 찾기
	public MemberVO verifyMember(MemberVO vo);
	 
	public void modifyPassword(MemberVO vo);
}
