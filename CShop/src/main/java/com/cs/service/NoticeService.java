package com.cs.service;

import java.util.List;

import com.cs.domain.Criteria;
import com.cs.domain.NoticeVO;

public interface NoticeService {
	public int register(NoticeVO vo);
	
	public NoticeVO get(Long nno);
	
	public List<NoticeVO> getList(Criteria cri);
	
	public boolean remove(Long nno);
	
	public boolean modify(NoticeVO vo);
	
	public int getTotal(Criteria cri);
}
