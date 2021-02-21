package com.cs.mapper;

import com.cs.domain.AuthVO;

public interface AuthMapper {

	public int insert(AuthVO vo);

	public AuthVO read(String userid);
	
}
