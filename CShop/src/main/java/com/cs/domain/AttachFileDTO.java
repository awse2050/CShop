package com.cs.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	// uuid , uploadPath , fileName, image
	private String uuid , uploadPath , fileName, thumbnail;
	
	private boolean image;
	
}
