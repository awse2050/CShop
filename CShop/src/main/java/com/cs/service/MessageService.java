package com.cs.service;

import java.util.List;

import com.cs.domain.MessageVO;

public interface MessageService {

	// 추가
	public int register(MessageVO msg);
	// 읽기
	public MessageVO getByMno(Long mno);
	// 받은 메세지
	public List<MessageVO> getReceivedList(String userid);
	// 전송한 메세지
	public List<MessageVO> getSentList(String userid);
	// 삭제
	public boolean remove(Long mno);
}
