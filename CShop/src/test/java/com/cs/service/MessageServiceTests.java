package com.cs.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.domain.MessageVO;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MessageServiceTests {

	@Autowired
	private MessageService service;
	
	@Test
	public void registerTest() {
		MessageVO msg = new MessageVO();
		msg.setReceiver("hide44");
		msg.setSender("admin44");
		msg.setText("안녕하세요??");
		
		log.info(service.register(msg));
	}
	
	@Test
	public void getTest() {
		log.info(service.getByMno(2L));
		log.info(service.getSentList("admin44"));
		log.info(service.getReceivedList("hide44"));
		
	}
	
	@Test
	public void deleteTest() {
		log.info(service.remove(2L));
	}
}
