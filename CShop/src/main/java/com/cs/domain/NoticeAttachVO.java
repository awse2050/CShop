package com.cs.domain;

import lombok.Data;

@Data
public class NoticeAttachVO {
	// uuid , uploadPath, fileName, fileType, nno

	private String uuid, uploadPath, fileName , fileType;
	
	private Long nno;
	
}
