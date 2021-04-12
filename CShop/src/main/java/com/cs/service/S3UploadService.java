package com.cs.service;

import java.io.File;
import java.io.IOException;
import java.util.Optional;

import org.springframework.web.multipart.MultipartFile;

public interface S3UploadService {

	public String upload(MultipartFile multipartfile) throws IOException;
	
	public String upload(File uploadFile, String dirName);
	
	public String putS3(File uploadFile, String fileName);
	
	public boolean removeFile(File file);
	
	public Optional<File> convert(MultipartFile file) throws IOException;
}
