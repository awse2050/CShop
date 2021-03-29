package com.cs.mapper;

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
public class LikeMapperTests {

	@Autowired
	private LikeMapper mapper;
	
	@Test
	public void insertTest() {
		
		LikeVO vo = new LikeVO();
		
		vo.setUserid("admin44");
		vo.setCno(374L);

		log.info(mapper.insert(vo));
	}
	
	@Test
	public void getListTest() {
		log.info(mapper.getLikeListByUserid("admin44"));
	}
	
	@Test
	public void deleteTest() {
		log.info(mapper.delete(374L, "admin44"));
	}
	
}
