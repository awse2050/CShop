package com.cs.domain;

import lombok.Data;

@Data
public class NoticeAttachVO {
	// uuid , uploadPath, fileName, fileType, nno

	private String uuid, uploadPath, fileName;
	private boolean fileType;
	private Long nno;
	
}
