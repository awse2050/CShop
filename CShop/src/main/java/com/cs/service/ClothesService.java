package com.cs.service;

import java.util.List;

import com.cs.domain.ClothesAttachVO;
import com.cs.domain.Criteria;
import com.cs.domain.LikeVO;
import com.cs.domain.category.ClothesVO;

public interface ClothesService {

	public Long register(ClothesVO vo);

	public ClothesVO get(Long cno);
	
	public ClothesVO modify(Long cno);

	public List<ClothesVO> getList(Criteria cri);

	public boolean remove(Long cno);

	public boolean modify(ClothesVO vo);

	public int getTotal(Criteria cri);
	
	public List<ClothesAttachVO> getAttachList(Long cno);
	
	public List<ClothesVO> getByUserid(String userid);
	
}
