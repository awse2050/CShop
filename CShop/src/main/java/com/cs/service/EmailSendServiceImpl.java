package com.cs.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.cs.util.EmailForm;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class EmailSendServiceImpl implements EmailSendService {

	private final JavaMailSender mailSender;
	
	@Override
	public boolean sendEmailToUser(EmailForm emailForm) {
		log.warn("Send To Email is : " + emailForm.getTo());
		
		MimeMessage message = mailSender.createMimeMessage();
		try {
	    	MimeMessageHelper helper = new MimeMessageHelper(message, true);
	        
	        helper.setTo(emailForm.getTo());
	        helper.setSubject(emailForm.getSubject());
	        helper.setText(emailForm.getText());
	            
	        mailSender.send(message);
	        
	        log.warn("Email Send Complete..");
	        
	        return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
