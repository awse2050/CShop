package com.cs.domain.category;

import java.util.Date;
import java.util.List;

import com.cs.domain.ClothesAttachVO;

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

	private List<ClothesAttachVO> attachList;
	
	private Date regdate, moddate;
	// 목록에서 보여줄 대표이미지 URL
	private String thumbnailUrl; 

}
