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
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
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
@Configuration
@PropertySource("classpath:AwsCredentials.properties")
public class S3UploadServiceImpl implements S3UploadService {

	private final AWSs3 awsS3;
	
	private final ClothesAttachMapper attachMapper;

	@Value("${cloud-bucketName}")
	private String bucketName;
	
	@Override
	public File makeUploadFile(MultipartFile multipartfile) throws IOException {
		 log.warn(multipartfile.getOriginalFilename());
	     File uploadFile = convert(multipartfile)
            .orElseThrow(() -> 
            new IllegalArgumentException("MultipartFile -> File로 전환이 실패했습니다."));
	     
	     return uploadFile;
	}
	
	@Override
	public String putS3(File uploadFile, String fileName) {
		log.warn(bucketName);
		// TODO Auto-generated method stub
		 awsS3.getS3Client()
         .putObject(new PutObjectRequest(bucketName, fileName, uploadFile)
                 .withCannedAcl(CannedAccessControlList.PublicRead));
		 
		 log.warn("uploaded file Url : " + awsS3.getS3Client().getUrl(bucketName, fileName).toString());
		 // fileNaem = 날짜+/+uuid+ _ + 파일이름
		 return awsS3.getS3Client().getUrl("spring-cshop", fileName).toString();
	}

	@Override
	public void removeFile(String path) {
		// TODO Auto-generated method stub
		log.warn("path... : " + path);
		 DeleteObjectRequest deleteObjectRequest = new DeleteObjectRequest(bucketName, path);
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
		return awsS3.getS3Client().getUrl(bucketName, path).toString();
	}
}
