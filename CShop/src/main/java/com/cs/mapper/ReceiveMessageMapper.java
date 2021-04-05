package com.cs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cs.domain.MessageVO;

public interface ReceiveMessageMapper {
	// 추가
	public int insert(MessageVO msg);
	// 받은 메세지
	public List<MessageVO> getReceivedList(@Param("receiver")String userid);
	// 보낸 메세지
	public List<MessageVO> getSentList(@Param("sender")String userid);
	// 읽기
	public MessageVO read(Long mno);
	// 삭제
	public boolean delete(Long mno);
}
