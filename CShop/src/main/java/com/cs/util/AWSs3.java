package com.cs.util;

import org.springframework.stereotype.Component;

import com.amazonaws.auth.ClasspathPropertiesFileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class AWSs3 {

	private AmazonS3 s3Client;

	public AWSs3() {
		try {
            this.s3Client = AmazonS3ClientBuilder
                    .standard()
                    .withCredentials(new ClasspathPropertiesFileCredentialsProvider())
                    .withRegion("ap-northeast-2")
                    .build();
        } catch(Exception e) {
            System.out.println(e);
            e.printStackTrace();
        }
	}
}
