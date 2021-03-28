package com.cs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesReply;
import com.cs.domain.category.ReplyPageDTO;
import com.cs.mapper.ClothesReplyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ClothesReplyServiceImpl implements ClothesReplyService {

	private final ClothesReplyMapper mapper;
	
	@Override
	public int register(ClothesReply reply) {
		// TODO Auto-generated method stub
		log.info(reply);
		return mapper.insert(reply);
	}

	@Override
	public ClothesReply getByRno(Long rno) {
		// TODO Auto-generated method stub
		log.info("rno : " + rno);
		return mapper.read(rno);
	}

	@Override
	public List<ClothesReply> getReplyList(Long cno, Criteria cri ) {
		// TODO Auto-generated method stub
		log.info("cno : " + cno);
		log.info("cri : " + cri);
		return mapper.getReplyList(cno, cri);
	}

	@Override
	public boolean modify(ClothesReply reply) {
		// TODO Auto-generated method stub
		log.info(reply);
		return mapper.update(reply);
	}

	@Override
	public boolean remove(Long rno) {
		// TODO Auto-generated method stub
		log.info("rno : " + rno);
		return mapper.delete(rno);
	}

	@Override
	public int getCountByCno(Long cno) {
		// TODO Auto-generated method stub
		return mapper.getCountByCno(cno);
	}

	@Override
	public ReplyPageDTO<ClothesReply> getReplyListWithPaging(Criteria cri, Long cno) {
		
		return new ReplyPageDTO<ClothesReply>(mapper.getReplyList(cno, cri), mapper.getCountByCno(cno));
	}
	
	
}
