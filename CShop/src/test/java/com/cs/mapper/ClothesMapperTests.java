package com.cs.mapper;

import javax.swing.Spring;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesVO;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class ClothesMapperTests {

	@Autowired
	private ClothesMapper mapper;
	
	@Test
	public void insertTest() {
		for(int i = 0; i < 120; i++) {
		ClothesVO vo = new ClothesVO();
		
		vo.setCount(1);
		vo.setDescription("설명 테스트.."+i);
		vo.setPrice(i * 100);
		vo.setProductName("의류.."+i);
		vo.setWriter("작성자"+i);
		
		log.info(mapper.insert(vo));
		}
		
	}
	
	@Test
	public void readTest() {
		log.info(mapper.read(1L));
	}
	
	@Test
	public void getListTest() {
		log.info(mapper.getList(new Criteria()));
	}
	
	@Test
	public void searchTest() {
		Criteria cri = new Criteria();
		cri.setType("t");
		cri.setKeyword("5");
		log.info(cri);
		log.info(mapper.getTotal(cri));
	}
	
	@Test
	public void updateTest() {
		ClothesVO vo = new ClothesVO();
		vo.setCno(243L);
		vo.setCategory("의류");
		vo.setDescription("설명변경..");
		vo.setPrice(15000);
		vo.setProductName("상품명11");
		vo.setWriter("윤환");
		
		log.info(mapper.update(vo));
		
	}
	
	@Test
	public void deleteTest() {
		log.info(mapper.delete(1L));
	}
	
}
