package com.cs.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesReply;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})

public class ClothesReplyMapperTests {

	@Autowired
	private ClothesReplyMapper mapper;
	
	@Test
	public void insertTest() {

		ClothesReply reply = new ClothesReply();

		Long[] arr = {373L , 365L, 364L, 363L };
		for(int i=0; i < 120; i++ ) {
			int r = (int)(Math.random() * 4) ;
			reply.setCno(arr[r]);
			reply.setReply("new Reply!!.."+i);
			reply.setReplyer("replyer.."+i);

			log.info(mapper.insert(reply));
		}
	}

	@Test
	public void getListTest() {
		log.info(mapper.getReplyList(373L, new Criteria()));
	}
	
	@Test
	public void countTest() {
		log.info(mapper.getCountByCno(373L));
	}
}
