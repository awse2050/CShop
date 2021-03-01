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
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() * 0.1)) * 10;
		
		this.realPage = (int)(Math.ceil(this.total / (cri.getAmount()*1.0)));
		
		this.startPage = this.endPage - 9;
		
		this.prev = this.startPage > 1;

		this.endPage = this.endPage >= this.realPage ? this.realPage : this.endPage;
		
		this.next = this.realPage > this.endPage;
	}
}
