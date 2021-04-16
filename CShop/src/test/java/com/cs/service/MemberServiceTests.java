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
	
	@Test
	public void updateTest() {
		MemberVO vo = service.getByUserId("admin44");
		log.info(vo);
		
		vo.setPassword(encoder.encode("pw44"));
		vo.setEmail("admin44@naver.com");
		vo.setPhone("01030909402");
		
		log.info(service.modifyMyInfo(vo));
		
		log.info(service.getByUserId("admin44"));
	}
	
	@Test
	public void passwordEqualsTest() {
		MemberVO vo = service.getByUserId("test33");
		
		// 비암호화된 값, 암호화된 값. 
		log.info(encoder.matches("pwpw1212", vo.getPassword())); // true
		log.info(encoder.matches(vo.getPassword(), encoder.encode("pw44"))); // false
	}
	
	@Test
	public void successByUsernameWithEmailTest() {
		MemberVO vo = new MemberVO();
		vo.setUsername("윤환");
		vo.setEmail("kyh3964@naver.com");
		log.info(vo);
		
		log.info(service.verifyMember(vo));
		
	}
	
	@Test
	public void failByUsernameWithEmailTest() {
		MemberVO vo = new MemberVO();
		vo.setUsername("김윤환");
		vo.setEmail("kyh3964@naver.com");
		log.info(vo);
		
		log.info(service.verifyMember(vo));
	}
	
	@Test
	public void successByUsernameWithEmailAndUseridTest() {
		MemberVO vo = new MemberVO();
		vo.setUsername("윤환");
		vo.setEmail("kyh3964@naver.com");
		vo.setUserid("awse2050");
		log.info(vo);
		
		log.info(service.verifyMember(vo));
	}
	
	@Test
	public void failByUsernameWithEmailAndUseridTest() {
		MemberVO vo = new MemberVO();
		vo.setUsername("윤환");
		vo.setEmail("kyh3964@naver.com");
		vo.setUserid("awse205");
		log.info(vo);
		
		log.info(service.verifyMember(vo));
	}
	
	@Test
	public void test() {
		MemberVO vo = service.getByUserId("hide");
		log.info(vo.getPassword().length());
	}
}
