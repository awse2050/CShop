package com.cs.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.domain.LikeVO;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class LikeServiceTests {

	@Autowired
	private LikeService service;
	
	@Test
	public void getListTest() {
		service.getLikeListByUserid("admin44");
	}
	
	@Test
	public void isLikeTest() {
		log.info(service.isLike(new LikeVO("admin44", 37L)));
	}
}
