package com.cs.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.util.EmailForm;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class EmailSendServiceTests {
	
	@Autowired
	private EmailSendService service;
	
	@Test
	public void sendTest() {
		EmailForm emailForm = new EmailForm();
		emailForm.setTo("kyh3964@naver.com");
		emailForm.setSubject("안녕하세요?");
		emailForm.setText("반가워요!!");
		
		service.sendEmailToUser(emailForm);
	}

}
