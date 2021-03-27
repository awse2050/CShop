package com.cs.domain.category;

import java.util.Date;

import lombok.Data;

@Data
public class ClothesReply {

	// 게시물번호, 댓글번호, 댓글내용, 댓글 작성자, 날짜
	private Long cno, rno;
	
	private String reply, replyer;
	
	private Date regdate, moddate;
	
}
