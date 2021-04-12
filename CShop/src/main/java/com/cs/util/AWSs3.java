package com.cs.util;

import org.springframework.stereotype.Component;

import com.amazonaws.ClientConfiguration;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class AWSs3 {

	private AmazonS3 s3Client;
	
	private final String accesskey = "AKIAY5B6DUXL4Q5QSXVR";
	private final String secretkey = "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";

	public AWSs3() {
		try{
            BasicAWSCredentials creds = new BasicAWSCredentials(accesskey, secretkey);
            this.s3Client = AmazonS3ClientBuilder
                    .standard()
                    .withCredentials(new AWSStaticCredentialsProvider(creds))
                    .withRegion("ap-northeast-2")
                    .build();
        }catch(Exception e){
            System.out.println(e);
            e.printStackTrace();
        }
	}
}
