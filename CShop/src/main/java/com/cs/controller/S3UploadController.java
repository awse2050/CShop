package com.cs.controller;

import java.io.IOException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cs.service.S3UploadService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class S3UploadController {

	private final S3UploadService s3Service;
	
	@GetMapping("/s3test")
	public void s3() {
		log.info("s3...");
	}
	
	@PostMapping(value ="/s3upload")
	@ResponseBody
	public ResponseEntity<String> s3upload(MultipartFile uploadFile) throws IOException {
		
		  return new ResponseEntity<String>(s3Service.upload(uploadFile), HttpStatus.OK);
	}
	
	
	
}
