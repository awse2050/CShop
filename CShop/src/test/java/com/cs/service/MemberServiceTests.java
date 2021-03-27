package com.cs.service;

import java.util.List;
import java.util.stream.Stream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MemberServiceTests {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test 
	public void insertTest() {
		MemberVO vo = new MemberVO();
		
		vo.setUserid("awse205011");
		vo.setPassword(encoder.encode("pw22"));
		vo.setUsername("준섭");
		vo.setNickname("wesaq");
		vo.setPhone("010-3194-3287");
		vo.setAddress("시흥시 은계남로 11");
		vo.setEmail("kyh3964@naver.com");
		
		log.info(service.register(vo));
		
	}
	
	@Test
	public void getByUserIdTest() {
		log.info(service.getByUserId("awse2050"));
	}
	
	@Test
	public void getByEmailTest() {
		log.info(service.getByEmail("tntn@naver.com"));
	}
}