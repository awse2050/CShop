package com.cs.service;

import com.cs.domain.MemberVO;

public interface MemberService {

	public int register(MemberVO vo);
	
	public MemberVO getByUserId(String userid);
}
