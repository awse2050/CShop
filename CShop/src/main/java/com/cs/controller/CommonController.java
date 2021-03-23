package com.cs.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.MemberVO;
import com.cs.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class CommonController {

	private final MemberService memberService;
	
	@GetMapping("/accessError") 
	public void aceessError(Authentication auth) {
		log.info("error page ..");
		
		log.info("auth ... : " + auth);
	}
	
	@GetMapping("/signUp")
	public void getSignUp() {
		log.info("Move SignUp Page...");
	}
	
	@PostMapping("/signUp")
	public String postSignUp(MemberVO vo, RedirectAttributes rttr) {
		log.info("Sign Up In Controller");
		log.info("Regist Data : " + vo);
		
		int result = memberService.register(vo);
		log.info("result : " + result);
		return null;
	}
	
}
