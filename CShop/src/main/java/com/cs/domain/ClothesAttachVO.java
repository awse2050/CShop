package com.cs.domain;

import lombok.Data;

@Data
public class ClothesAttachVO {
	
	private String uuid, uploadPath, fileName;
	
	private boolean fileType;
	
	private Long cno;
		
}
