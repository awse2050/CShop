package com.cs.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {

	private Long Nno;
	private String title, content, writer;
	
	private Date regdate, moddate;
}
