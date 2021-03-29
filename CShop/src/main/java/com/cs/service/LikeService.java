package com.cs.service;

import java.util.List;

import com.cs.domain.LikeVO;
import com.cs.domain.category.ClothesVO;

public interface LikeService {

	public int register(LikeVO vo);
	
	public List<ClothesVO> getLikeListByUserid(String userid);
	
	public boolean remove(Long cno, String userid);
}

