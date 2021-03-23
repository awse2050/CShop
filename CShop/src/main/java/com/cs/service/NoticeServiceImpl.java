package com.cs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cs.domain.Criteria;
import com.cs.domain.NoticeAttachVO;
import com.cs.domain.NoticeVO;
import com.cs.mapper.NoticeAttachMapper;
import com.cs.mapper.NoticeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Setter(onMethod_ =@Autowired)
	private NoticeMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeAttachMapper attachMapper;
	
	@Transactional
	@Override
	public int register(NoticeVO vo) {
		// TODO Auto-generated method stub
		log.info("register vo ... : " + vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return 0;
		}
		
		int result = mapper.insert(vo);
		
		vo.getAttachList().forEach(attach -> {
		
			attach.setNno(mapper.getLastNno());
			attachMapper.insert(attach);
		});

		return result;
	}

	@Transactional
	@Override
	public NoticeVO get(Long nno) {
		
		log.info("Notice number : " + nno);
		// 조회수 추가
		if(mapper.read(nno) != null || mapper.read(nno).equals("")) {
			mapper.updateViewCnt(nno, 1);
		}
		return mapper.read(nno);
	}

	@Override
	public List<NoticeVO> getList(Criteria cri) {
		
		log.info("cri... : " + cri);
		return mapper.getList(cri);
	}

	@Transactional
	@Override
	public boolean remove(Long nno) {
		
		log.info("remove Notice number : " + nno);
		attachMapper.deleteAll(nno);
		
		return mapper.delete(nno) == 1;
	}

	@Transactional
	@Override
	public boolean modify(NoticeVO vo) {
		
		log.info("modify Notice .... : " + vo);
		attachMapper.deleteAll(vo.getNno());
		
		boolean result = mapper.update(vo) == 1;
		
		if(result && vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach -> {
				attach.setNno(vo.getNno());
				attachMapper.insert(attach);
			});
		}
		return result;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotal(cri);
	}
	
	@Override
	public Long getLastNno() {
		return mapper.getLastNno();
	}
	
	@Override
	public List<NoticeAttachVO> getAttachList(Long nno) {
		
		log.info("get attach number : " + nno);
		
		return attachMapper.findByNno(nno);
	}
}
