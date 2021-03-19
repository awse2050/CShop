package com.cs.domain.category;

import java.util.Date;
import java.util.List;

import com.cs.domain.NoticeAttachVO;

import lombok.Data;

@Data
public class ClothesVO {

	// 번호, 카테고리 선택, 이미지, 상품명, 수량, 판매가, 상세설명
	private Long cno;
	
	private String category;
	
	private String productName;

	private String description;
	
	private String writer;
	
	private int price, count, viewCnt;

	private List<NoticeAttachVO> attachList;
	
	private Date regdate, moddate;

}
