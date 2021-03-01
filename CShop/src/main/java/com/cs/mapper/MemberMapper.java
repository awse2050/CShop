package com.cs.mapper;

import com.cs.domain.MemberVO;

public interface MemberMapper {
	// 읽기
	public MemberVO read(String userid);
	// 저장하기
	public int insert(MemberVO vo);
}
