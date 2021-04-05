package com.cs.service;

import java.util.List;

import com.cs.domain.MessageVO;

public interface MessageService {

	// 추가
	public int register(MessageVO msg);
	// 받은메세지 읽기
	public MessageVO getReceivedMsgByMno(Long mno);
	// 보낸메세지 읽기
	public MessageVO getSentMsgByMno(Long mno);
	// 보낸 메세지
	public List<MessageVO> getReceivedList(String userid);
	// 받은 메세지 삭제
	public List<MessageVO> getSentList(String userid);
	// 받은 메세지
	public boolean removeReceivedMsgByMno(Long mno);
	// 보낸 메세지 삭제
	public boolean removeSentMsgByMno(Long mno);
}
