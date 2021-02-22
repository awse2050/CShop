package com.cs.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.domain.Criteria;
import com.cs.domain.NoticeVO;
import com.cs.domain.PageDTO;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class NoticeMapperTests {

	@Autowired
	private NoticeMapper mapper;
	
	@Test
	public void insert() {
		NoticeVO vo = new NoticeVO();
		for(int i=0; i< 20; i++) {
			
		vo.setTitle("공지사항"+i);
		vo.setContent("공지사항입니다."+i);
		vo.setWriter("관리자"+i);
		
		log.info(mapper.insert(vo));
		}
	}
	@Test
	public void get() {
		Criteria cri = new Criteria();
		
		PageDTO pageDTO = new PageDTO(cri, 1);
		log.info(cri);
		log.info(pageDTO);
		log.info(191*1.0 / 10);
		log.info(2 * 0.1);
	}
	
	@Test
	public void viewCntTest() {
		
		mapper.updateViewCnt(22L, -1);
		log.info(mapper.read(22L));
	}
	
	@Test
	public void testee() {
		log.info(mapper.getLastNno());
	}
	
	
	@Test
	public void insert1() {
		NoticeVO vo = new NoticeVO();
			
		vo.setTitle("공지사항"+68);
		vo.setContent("공지사항입니다."+68);
		vo.setWriter("관리자"+68);
		
		log.info(mapper.insert(vo));
		log.info(mapper.getLastNno());
	}
	
}
