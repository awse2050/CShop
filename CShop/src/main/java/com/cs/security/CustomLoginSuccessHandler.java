package com.cs.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		// 로그인 체크
		// 로그인했을때 authentication에 로그인을 시도한 사람의 정보가 들어간다.
		
		// 권한을 담을 List
		List<String> roleNames = new ArrayList<String>();
		
		// 하나하나 뽑아서 추가
		authentication.getAuthorities().forEach( auth ->
			roleNames.add(auth.getAuthority())
		);
		
		log.info("로그인 대상자가 가진 권한 : " + roleNames);
		
		// 관리자권한을 가졌을 경우를 먼저 처리한다.
		if(roleNames.contains("ROLE_ADMIN")) {
			
			log.info("has ROLE_ADMIN...");
			response.sendRedirect("/sample/admin");
			return;
		} else if(roleNames.contains("ROLE_MEMBER")) {
			log.info("has ROLE_MEMBER...");
			
			response.sendRedirect("/sample/member");
			return;
		}
		
		// 아무것도 아니라면 그 페이지 그대로 이동한다.
		response.sendRedirect("/");
		
		
	}

	
	
}
