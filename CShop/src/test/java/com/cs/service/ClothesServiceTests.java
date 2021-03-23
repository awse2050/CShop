package com.cs.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesVO;
import com.cs.mapper.MemberMapperTests;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class ClothesServiceTests {
	
	@Autowired
	private ClothesService service;
	
	@Test
	public void registerTest() {
		ClothesVO vo = new ClothesVO();
		
		vo.setCount(1);
		vo.setDescription("설명 테스트..");
		vo.setPrice(30000);
		vo.setProductName("의류..");
		vo.setWriter("작성자444");
		
		log.info(service.register(vo));
	}

	@Test
	public void getTest() {
		log.info(service.get(243L));
	}
	
	@Test
	public void getListTest() {
		log.info(service.getList(new Criteria()));
		
		List<ClothesVO> list = service.getList(new Criteria());
		
		list.forEach( i -> System.out.println(i.getAttachList()));
	}

	@Test
	public void updateTest() {
		ClothesVO vo = new ClothesVO();
		vo.setCno(243L);
		vo.setCount(1);
		vo.setDescription("설명변경테스트");
		vo.setPrice(32000);
		vo.setProductName("가죽자켓");
		vo.setWriter("윤환");
		
		log.info(service.modify(vo));
		
	}
	
	@Test
	public void removeTest() {
		log.info(service.remove(242L));
	}
	
	
}


