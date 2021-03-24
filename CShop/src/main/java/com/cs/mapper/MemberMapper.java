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

}
