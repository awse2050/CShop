package com.cs.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cs.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax... ");
	}
	
	@PostMapping(value = "/uploadAjax" , produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> ajaxPost(MultipartFile[] uploadFile) {

		//객체를 담을 List
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		
		String uploadFolder = "c:\\upload\\";
		
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		log.info("uploadPath.... : " + uploadPath);

		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attach = new AttachFileDTO();
			
			log.info("파일이름 : " + multipartFile.getOriginalFilename());
			log.info("파일크기 : " + multipartFile.getSize());

			// 이름을 따온다.
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE 처리
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("uploadFileName .. : " + uploadFileName);
			
			attach.setFileName(uploadFileName);
			
			// 같은 파일업로드시 중복 제거
			 UUID uuid = UUID.randomUUID();
			 // uuid를 사용해서 파일명칭을 바꿔저장한다.
			 uploadFileName = uuid + "_" + uploadFileName;
			log.info("uuid + fileName : " + uploadFileName);
			 
			try {
				File file = new File(uploadPath, uploadFileName);
				log.info(file.getAbsolutePath());
				
				multipartFile.transferTo(file);
				attach.setUuid(uuid.toString());
				attach.setUploadPath(uploadFolderPath);
				
				//이미지 파일을 업로드 했을 경우 썸네일 파일을 생성.
				if(checkImageType(file)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					log.info("thumbnail .. : " + thumbnail);
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				
					attach.setImage(true);
					
					thumbnail.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			list.add(attach);
		}
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}
	
	// 업로드한 파일 표시하기.
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> display(String fileName) {
		
		log.info("fileName : " + fileName);
		
		File file = new File("C:\\upload\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
 			HttpHeaders header = new HttpHeaders();
 			header.add("Content-Type", Files.probeContentType(file.toPath()));
 			result=  new ResponseEntity<byte[]> (FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@PostMapping(value = "/deleteFile", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public ResponseEntity<String> deleteFiles(String fileName, String type) {
		// fileName => 경로를 포함하는 내용
		// 이미지라면 "s_"를 포함한 경로가 나타난다.
		log.info("target Delete File : " + fileName);
		
		try {
			
			File file = new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			if(type.equals("image")) {
				log.info("this file is image...");
				 file = new File(file.getAbsolutePath().replace("s_", ""));
				 
				 file.delete();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<String>("Delete...", HttpStatus.OK);
	}
	
	// 날짜폴더 생성
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String today = sdf.format(date);
		
		return today.replace("-", File.separator);
		
	}
	// 파일타입 처리
	private boolean checkImageType(File file) {
		log.info("file Check....");
		log.info("file... : " + file);
		
		String contentType = null ;
		try {
			contentType  = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return contentType.startsWith("image");
	}
}
