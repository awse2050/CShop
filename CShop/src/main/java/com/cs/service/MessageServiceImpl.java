package com.cs.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cs.domain.MessageVO;
import com.cs.mapper.SentMessageMapper;
import com.cs.mapper.ReceiveMessageMapper;

import jdk.internal.org.jline.utils.Log;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class MessageServiceImpl implements MessageService {

	private final SentMessageMapper messageMapper;
	
	private final ReceiveMessageMapper receiveMsgMapper;
	
	@Transactional
	@Override
	public int register(MessageVO msg) {
		
		int firInsert = messageMapper.insert(msg);
		
		int ndInsult = receiveMsgMapper.insert(msg);
		
		boolean result = firInsert == 1 && ndInsult == 1;
		
		return result ? 1 : 0 ;
	}

	@Override
	public MessageVO getReceivedMsgByMno(Long mno) {
		
		return receiveMsgMapper.read(mno);
	}
	
	@Override
	public MessageVO getSentMsgByMno(Long mno) {
		return messageMapper.read(mno);
	}

	@Override
	public List<MessageVO> getReceivedList(String userid) {
		
		return receiveMsgMapper.getReceivedList(userid);
	}
	
	@Override
	public List<MessageVO> getSentList(String userid) {
		
		return messageMapper.getSentList(userid);
	}
	
	@Override
	public boolean removeReceivedMsgByMno(Long mno) {
		
		return receiveMsgMapper.delete(mno);
	}
	
	@Override
	public boolean removeSentMsgByMno(Long mno) {
		
		return messageMapper.delete(mno);
	}

	private MessageVO changeUser(MessageVO msg) {
		log.warn("Message Change Send & Receive User...");
		
		MessageVO vo = new MessageVO();
		vo.setSender(msg.getReceiver());
		vo.setReceiver(msg.getSender());
		vo.setText(msg.getText());
	
		return vo;
	}
	
}
