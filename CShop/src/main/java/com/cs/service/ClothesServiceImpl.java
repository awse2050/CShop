package com.cs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesVO;
import com.cs.mapper.ClothesMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ClothesServiceImpl implements ClothesService {
	
	private final ClothesMapper mapper;

	@Override
	public Long register(ClothesVO vo) {
		// TODO Auto-generated method stub
		log.info("regist vo : " + vo);
		return mapper.insert(vo);
	}

	@Override
	public ClothesVO get(Long cno) {
		// TODO Auto-generated method stub
		log.info("cno : " + cno);
		return mapper.read(cno);
	}

	@Override
	public List<ClothesVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getList(cri);
	}

	@Override
	public boolean remove(Long cno) {
		// TODO Auto-generated method stub
		log.info("remove cno : " + cno);
		return mapper.delete(cno);
	}

	@Override
	public boolean modify(ClothesVO vo) {
		// TODO Auto-generated method stub
		log.info("modify vo : " + vo);
		return mapper.update(vo);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("cri : " + cri);
		return mapper.getTotal(cri);
	}

	
	
}
