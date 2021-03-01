package com.cs.domain;

import lombok.Data;

@Data
public class NoticeAttachVO {

	private String uuid, uploadPath, fileName;
	private boolean fileType;
	private Long nno;
	
}
