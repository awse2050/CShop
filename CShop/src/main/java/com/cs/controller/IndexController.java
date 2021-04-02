package com.cs.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cs.domain.MemberVO;
import com.cs.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/")
public class IndexController {

	@GetMapping("/index")
	public void index() {
		log.info("index page...");
	}
	
	@GetMapping("/loginPage")
	public void loginPage(String error, String logout, HttpServletRequest request, Model model) {

		String saveUri = null;
		
		log.info("login page...");
		
		if(error != null || logout != null) {
			log.info("login error ... : " + error);
			log.info("logout.... : "  + logout);
			saveUri = "http://localhost:8080/index";
		} else {
			saveUri = request.getHeader("referer");
		}
		
		log.info("save Uri : " + saveUri);
		
		model.addAttribute("referer", saveUri );
	}
}
