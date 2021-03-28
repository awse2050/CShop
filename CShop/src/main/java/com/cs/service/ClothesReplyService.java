package com.cs.service;

import java.util.List;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesReply;
import com.cs.domain.category.ReplyPageDTO;

public interface ClothesReplyService {
	
	public int register(ClothesReply reply);
	
	public ClothesReply getByRno(Long rno);
	
	public List<ClothesReply> getReplyList(Long cno, Criteria cri);
	
	public boolean modify(ClothesReply reply);
	
	public boolean remove(Long rno);
	
	public int getCountByCno(Long cno);
	
	public ReplyPageDTO<ClothesReply> getReplyListWithPaging(Criteria cri, Long cno);
	
}
