package com.cs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public void loginPage() {
		log.info("login page....");
	}
	
}
