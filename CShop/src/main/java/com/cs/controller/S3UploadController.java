package com.cs.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cs.domain.AttachFileDTO;
import com.cs.domain.ClothesAttachVO;
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
	public ResponseEntity<List<AttachFileDTO>> s3upload(MultipartFile[] uploadFile) throws IOException {
		log.info("S3 Upload In Controller to s3upload");
		List<AttachFileDTO> list = new ArrayList<>();
		
		for(MultipartFile multipartfile : uploadFile) {
			AttachFileDTO attach = new AttachFileDTO();
			
			File file = s3Service.makeUploadFile(multipartfile);
			
			String uploadPath = LocalDate.now().toString();
			UUID uuid = UUID.randomUUID();
			String originalName = file.getName();
			
			String fileName = uploadPath + "/" + uuid + "_" + originalName;
			log.info("fileName ... : " + fileName);
			
			// 업로드한다. putS3
			String thumbnailUrl = s3Service.putS3(file, fileName);
			log.info(thumbnailUrl);
			// 객체 추가 후 던진다.
			attach.setUuid(uuid.toString());
			attach.setUploadPath(uploadPath);
			attach.setFileName(originalName);
			attach.setThumbnail(thumbnailUrl);
			attach.setImage(true);
			
			list.add(attach);
		}
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/s3Remove", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public ResponseEntity<String> s3Remove(String path) {
		log.info("fileName in S3 : " + path);
		s3Service.removeFile(path);
		
		return new ResponseEntity<String>("delete", HttpStatus.OK);
	}
	
}
