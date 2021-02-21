package com.cs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sample/*")
public class SampleController {

	@GetMapping("/member")
	public void member() {
		log.info("member...");
	}
	
	@GetMapping("/admin")
	public void admin()	{
		
		log.info("admin...");
	}
}
