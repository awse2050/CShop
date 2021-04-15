package com.cs.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.service.ClothesServiceTests;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class JavaMailSenderTests {

	@Autowired
	private JavaMailSender mailSender;
	
	@Test
	public void sendTest() {
		
		MimeMessage message = mailSender.createMimeMessage();
	    log.info(message);
		try {
	    	MimeMessageHelper helper = new MimeMessageHelper(message, true);
	        
	        helper.setFrom("cshopManager@cshop.com");
	        helper.setTo("kyh3964@naver.com");
	        helper.setSubject("반갑습니다");
	        helper.setText("안녕하세요?");
	            
	        mailSender.send(message);
	        
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
}
