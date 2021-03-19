package com.cs.service;

import java.util.List;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesVO;

public interface ClothesService {

	public Long register(ClothesVO vo);

	public ClothesVO get(Long nno);

	public List<ClothesVO> getList(Criteria cri);

	public boolean remove(Long nno);

	public boolean modify(ClothesVO vo);

	public int getTotal(Criteria cri);

}
