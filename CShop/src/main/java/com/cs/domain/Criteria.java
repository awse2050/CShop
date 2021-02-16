package com.cs.domain;

import lombok.Data;

@Data
public class Criteria {
	
	// 페이지 번호, 보여줄 목록 개숫
	private Integer pageNum;
	private Integer amount;
	
	// 타입, 검색어
	private String type, keyword;
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(Integer pageNum, Integer amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getSkip() {
		return (this.pageNum -1) * this.amount;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
