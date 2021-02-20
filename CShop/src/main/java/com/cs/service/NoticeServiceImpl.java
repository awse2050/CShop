package com.cs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cs.domain.Criteria;
import com.cs.domain.NoticeVO;
import com.cs.mapper.NoticeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Setter(onMethod_ =@Autowired)
	private NoticeMapper mapper;
	
	
	@Override
	public int register(NoticeVO vo) {
		// TODO Auto-generated method stub
		log.info("register vo ... : " + vo);
		
		return mapper.insert(vo);
	}

	@Transactional
	@Override
	public NoticeVO get(Long nno) {
		// TODO Auto-generated method stub
		log.info("Notice number : " + nno);
		// 조회수 추가
		if(mapper.read(nno) != null || mapper.read(nno).equals("")) {
			mapper.updateViewCnt(nno, 1);
		}
		
		return mapper.read(nno);
	}

	@Override
	public List<NoticeVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("cri... : " + cri);
		return mapper.getList(cri);
	}

	@Override
	public boolean remove(Long nno) {
		// TODO Auto-generated method stub
		log.info("remove Notice number : " + nno);
		return mapper.delete(nno) == 1;
	}

	@Override
	public boolean modify(NoticeVO vo) {
		// TODO Auto-generated method stub
		log.info("modify Notice .... : " + vo);
		
		return mapper.update(vo) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotal(cri);
	}
}
