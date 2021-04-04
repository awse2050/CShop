package com.cs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cs.domain.MessageVO;
import com.cs.mapper.MessageMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {

	private final MessageMapper messageMapper;
	
	@Override
	public int register(MessageVO msg) {
		
		return messageMapper.insert(msg);
	}

	@Override
	public MessageVO getByMno(Long mno) {
		
		return messageMapper.read(mno);
	}

	@Override
	public List<MessageVO> getReceivedList(String userid) {
		
		return messageMapper.getReceivedList(userid);
	}

	@Override
	public List<MessageVO> getSentList(String userid) {
		
		return messageMapper.getSentList(userid);
	}

	@Override
	public boolean remove(Long mno) {
		
		return messageMapper.delete(mno);
	}

	
}
