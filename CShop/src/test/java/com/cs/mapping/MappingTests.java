package com.cs.mapping;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cs.mapper.MemberMapperTests;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MappingTests {

	@Test
	public void test1() {
		StringBuffer url = new StringBuffer("http://localhost:8080/index");
		url.delete(0,"localhost:8080".length() + url.indexOf("localhost:8080"));
		log.info(url);
//		log.info(url.indexOf("localhost:8080"));
//		log.info(url.lastIndexOf("localhost:8080"));
//		log.info(url.substring(0, "localhost:8080".length() + url.indexOf("localhost:8080")));
	}
}
