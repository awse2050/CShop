package com.cs.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.cs.domain.ClothesAttachVO;
import com.cs.mapper.ClothesAttachMapper;
import com.cs.util.AWSs3;
import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Default;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class S3UploadServiceImpl implements S3UploadService {

	private final AWSs3 awsS3;
	
	private final ClothesAttachMapper attachMapper;
	
	@Override
	public File makeUploadFile(MultipartFile multipartfile) throws IOException {
		 log.warn(multipartfile.getOriginalFilename());
	     File uploadFile = convert(multipartfile)
            .orElseThrow(() -> 
            new IllegalArgumentException("MultipartFile -> File로 전환이 실패했습니다."));
	     
	     return uploadFile;
}
	
	@Override
	public String upload(MultipartFile multipartfile) throws IOException {
	    log.warn(multipartfile.getOriginalFilename());
        File uploadFile = convert(multipartfile)
                .orElseThrow(() -> 
                new IllegalArgumentException("MultipartFile -> File로 전환이 실패했습니다."));

        //저장할 폴더명
        String todayDir = LocalDate.now().toString();

        return upload(uploadFile, todayDir);
	}

	@Override
	@Transactional
	public String upload(File uploadFile, String dirName) {
		// TODO Auto-generated method stub
		UUID uuid = UUID.randomUUID();
		
		 String fileName = dirName +
	                "/" + uuid +
	                "_" + uploadFile.getName();
		 log.warn(fileName);

        String uploadImageUrl = putS3(uploadFile, fileName);
       // removeFile(uploadFile);
        
        attachMapper.insert(new ClothesAttachVO(uuid.toString(), dirName, uploadFile.getName(),uploadImageUrl, true, 333L));
        log.warn(uploadImageUrl);
        return uploadImageUrl;
	}
	
	@Override
	public List<ClothesAttachVO> test(MultipartFile multipartfile) throws IOException {
		// 파일이 들어온다.
		log.warn(multipartfile.getOriginalFilename());
        File uploadFile = convert(multipartfile)
                .orElseThrow(() -> 
                new IllegalArgumentException("MultipartFile -> File로 전환이 실패했습니다."));
        // 데이터를 담을 객체를 만든다.
        List<ClothesAttachVO> attachList = new ArrayList<ClothesAttachVO>();
        ClothesAttachVO attach;
		// 파일이름을 뺴온다.
        String todayDir = LocalDate.now().toString();
        UUID uuid = UUID.randomUUID();
        // 파일명, 날짜(path), uuid, cno를 따로 뺴내고 객체에 담아낸다. (insert 후 진행)
		
		 String fileName = todayDir +
	                "/" + uuid +
	                "_" + uploadFile.getName();
		 
		 log.warn(fileName);
		 log.warn("-----");
		 // 이후 해당 파일의 정보를 조합하여 S3에 업로드한다.
		 String uploadImageUrl = putS3(uploadFile, fileName);
		 log.warn(uploadFile);
		 
		 attach = new ClothesAttachVO(uuid.toString(), todayDir, uploadFile.getName(), uploadImageUrl, true, 333L);
		// 그리고 getUrl로 확인이 되면 ClothesAttachVO에 insert한다.
		 attachList.add(attach);
		// 보낸 객체를 리턴한다.
		
		// 화면에서 S3의 객체Url로 보여준다.
		
		return attachList;
	}

	@Override
	public String putS3(File uploadFile, String fileName) {
		// TODO Auto-generated method stub
		 awsS3.getS3Client()
         .putObject(new PutObjectRequest("spring-cshop", fileName, uploadFile)
                 .withCannedAcl(CannedAccessControlList.PublicRead));
		 
		 log.warn("uploaded file Url : " + awsS3.getS3Client().getUrl("spring-cshop", fileName).toString());
		 // fileNaem = 날짜+/+uuid+ _ + 파일이름
		 return awsS3.getS3Client().getUrl("spring-cshop", fileName).toString();
	}

	@Override
	public void removeFile(String path) {
		// TODO Auto-generated method stub
		log.warn("path... : " + path);
		 DeleteObjectRequest deleteObjectRequest = new DeleteObjectRequest("spring-cshop", path);
         //Delete
		 log.warn(deleteObjectRequest);
         awsS3.getS3Client().deleteObject(deleteObjectRequest);
	}

	@Override
	public Optional<File> convert(MultipartFile file) throws IOException {
		// TODO Auto-generated method stub
		File convertFile = new File(file.getOriginalFilename());
		log.warn(convertFile);
		
		boolean createResult = convertFile.createNewFile();
		
        if (createResult) {
        	log.warn("Already exist file..");
        	UUID uuid = UUID.randomUUID();
        	String tempName = uuid.toString().substring(0, 4);
        	convertFile = new File(tempName+"_"+ file.getOriginalFilename());
        } 
        
    	try (FileOutputStream fos = new FileOutputStream(convertFile)) {
            fos.write(file.getBytes());
    	}
    	
        return Optional.of(convertFile);
	}
	
	@Override
	public String getThumbnailUrl(String path) {
		return awsS3.getS3Client().getUrl("spring-cshop", path).toString();
	}
}
