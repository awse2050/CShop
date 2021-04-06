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
		msg.setReceiver("admin44");
		msg.setSender("nubi");
		msg.setText("혹시 운포인지 궁금해서 연락드려요.");
		
		log.info(service.register(msg));
	}
	
	@Test
	public void getTest() {
		log.info(service.getSentMsgByMno(56L));
		log.info(service.getReceivedMsgByMno(1L));
	}
	
	@Test
	public void getListTest() {
		log.info(service.getReceivedList("admin44"));
		log.info(service.getSentList("admin44"));
	}

	@Test
	public void removeTest() {
		log.info(service.removeReceivedMsgByMno(1L));
		log.info(service.removeSentMsgByMno(56L));
	}
}
