package com.cs.domain;

import lombok.Data;

@Data
public class PageDTO {
	
	// 첫페이지 , 마지막페이지, 진짜페이지
	private int startPage, endPage, realPage, total;
	
	private boolean prev, next;
	
	private Criteria cri;
	
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		// cri에서 페이지 번호에따라서 끝페이지를 결정
		this.endPage = (int)(Math.ceil(cri.getPageNum() * 0.1)) * 10;
		// 182개 면 19이나와야함
		// 11  2페이지 1.1 10개씩보여준다
		// 182.1 * 10
		this.realPage = (int)(Math.ceil(this.total / (cri.getAmount()*1.0)));
		
		this.startPage = this.endPage - 9;
		
		this.prev = this.startPage > 1;
		 // 60 < 53 -> 
		this.endPage = this.endPage >= this.realPage ? this.realPage : this.endPage;
		
		this.next = this.realPage > this.endPage;
	}
	
	

}
