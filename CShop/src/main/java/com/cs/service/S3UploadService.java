package com.cs.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.web.multipart.MultipartFile;

import com.cs.domain.ClothesAttachVO;

public interface S3UploadService {

	public String putS3(File uploadFile, String fileName);
	
	public void removeFile(String path);
	
	public Optional<File> convert(MultipartFile file) throws IOException;
	
	public String getThumbnailUrl(String path);
	
	public File makeUploadFile(MultipartFile multipartfile) throws IOException;
}
