package com.cs.mapper;

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
public class MessageMapperTests {

	@Autowired
	private MessageMapper mapper;
	
	@Test
	public void insertTest() {
		MessageVO msg = new MessageVO();
		
		msg.setSender("admin44");
		msg.setReceiver("hide");
		msg.setText("안녕하세요");
		
		log.info(mapper.insert(msg));
	}
	
	@Test
	public void readTest() {
		log.info(mapper.read(1L));
		log.info(mapper.getReceivedList("hide"));
		log.info(mapper.getSentList("admin44"));
	}
	
	@Test
	public void deleteTest() {
		log.info(mapper.delete(1L));
	}
}
