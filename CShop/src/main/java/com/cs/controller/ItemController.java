package com.cs.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/item/*")
public class ItemController {
	
	@GetMapping("/list")
	public void list() {
		log.info("item list jsp.. ");
	}
}
