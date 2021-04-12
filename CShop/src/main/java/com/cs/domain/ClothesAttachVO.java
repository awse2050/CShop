package com.cs.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClothesAttachVO {
	
	private String uuid, uploadPath, fileName, thumbnail;
	
	private boolean fileType;
	
	private Long cno;
		
}
