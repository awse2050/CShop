package com.cs.domain;

import lombok.Data;

@Data
public class MessageVO {

	//발신자, 수신자, 내용
	private Long mno;
	private String sender;
	private String receiver;
	private String text;
	
}
