package com.cs.service;

import java.util.List;

import com.cs.domain.MemberVO;

public interface MemberService {

	public int register(MemberVO vo);
	
	public MemberVO getByUserId(String userid);
	// 이메일로 존재여부 체크
	public MemberVO getByEmail(String email);
	
}