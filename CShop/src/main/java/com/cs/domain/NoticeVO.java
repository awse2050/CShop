package com.cs.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeVO {

	private Long Nno;
	private String title, content, writer;
	
	private Date regdate, moddate;
	private int viewCnt;
	// 첨부파일추가
	private List<NoticeAttachVO> attachList;
}
