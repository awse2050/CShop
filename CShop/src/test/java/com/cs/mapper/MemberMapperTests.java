package com.cs.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.cs.domain.AuthVO;
import com.cs.domain.MemberVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})

public class MemberMapperTests {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private AuthMapper authMapper;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	public void insertTest() {
		
		for(int i=0; i<50; i++) {
			MemberVO vo = new MemberVO();
			
			if(i < 30) {
				vo.setUserid("user"+i);
				vo.setPassword(encoder.encode("pw"+i));
				vo.setUsername("일반사용자"+i);
			} else if(i < 40) {
				vo.setUserid("member"+i);
				vo.setPassword(encoder.encode("pw"+i));
				vo.setUsername("매니저"+i);
			} else {
				vo.setUserid("admin"+i);
				vo.setPassword(encoder.encode("pw"+i));
				vo.setUsername("관리자"+i);
			}
			
			log.info(mapper.insert(vo));
		}
	}
	
	@Test
	public void readTest() {
		log.info(mapper.read("awse2050"));
	}
	
	@Test
	public void customMemberInsertTest() {
		MemberVO vo = new MemberVO();
		
		vo.setUserid("hide12");
		vo.setPassword(encoder.encode("pw22"));
		vo.setUsername("윤환121");
		vo.setNickname("3845839ww");
		vo.setPhone("01039593222");
		vo.setRoadAddress("시흥시 은계남로 11");
		vo.setDetailsAddress("904-1332");
		vo.setEmail("kyh1111@naver.com");
		
		AuthVO auth = new AuthVO();
		auth.setUserid(vo.getUserid());
		auth.setAuth("ROLE_MEMBER");
		
		log.info(vo);
		log.info(auth);
//		log.info(mapper.insert(vo));
	
		log.info(authMapper.insert(auth));
	}
	
	@Test
	public void readByEmailTest() {
		
		log.info(mapper.readByEmail("tntn@naver.com"));
		
	}
	
	@Test
	public void updateTest() {
		MemberVO vo = mapper.read("admin44");
		log.info(vo);
		
		vo.setPassword(encoder.encode("pw44"));
		vo.setEmail("admin44@gmail.com");
		vo.setPhone("01034845222");
		
		log.info(mapper.update(vo));
		
		log.info( mapper.read("admin44"));
	}
}
