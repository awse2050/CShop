package com.cs.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.cs.util.AWSs3;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class S3UploadServiceImpl implements S3UploadService {

	private final AWSs3 awsS3;
	
	@Override
	public String upload(MultipartFile multipartfile) throws IOException {
	    log.info(multipartfile.getOriginalFilename());
        File uploadFile = convert(multipartfile)
                .orElseThrow(() -> 
                new IllegalArgumentException("MultipartFile -> File로 전환이 실패했습니다."));

        //저장할 폴더명
        String todayDir = LocalDate.now().toString();

        return upload(uploadFile, todayDir);
	}

	@Override
	public String upload(File uploadFile, String dirName) {
		// TODO Auto-generated method stub
		 String fileName = dirName +
	                "/" + UUID.randomUUID() +
	                "_" + uploadFile.getName();

	        String uploadImageUrl = putS3(uploadFile, fileName);
	        removeFile(uploadFile);
	        return uploadImageUrl;
	}

	@Override
	public String putS3(File uploadFile, String fileName) {
		// TODO Auto-generated method stub
		 awsS3.getS3Client()
         .putObject(new PutObjectRequest("spring-cshop", fileName, uploadFile)
                 .withCannedAcl(CannedAccessControlList.PublicRead));

		 return awsS3.getS3Client().getUrl("spring-cshop", fileName).toString();
	}

	@Override
	public boolean removeFile(File file) {
		// TODO Auto-generated method stub
		if(file.delete()) {
            log.info("파일이 삭제되었습니다.");
            return true;
        } else {
            log.info("파일이 삭제되지 못했습니다.");
            return false;
        }
	}

	@Override
	public Optional<File> convert(MultipartFile file) throws IOException {
		// TODO Auto-generated method stub
		File convertFile = new File(file.getOriginalFilename());
        if (convertFile.createNewFile()) {
            try (FileOutputStream fos = new FileOutputStream(convertFile)) {
                fos.write(file.getBytes());
            }
            return Optional.of(convertFile);
        }

        return Optional.empty();
	}

}
