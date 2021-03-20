package com.cs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.category.ClothesVO;
import com.cs.service.ClothesService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/clothes/*")
public class ClothesController {
	
	@Autowired
	private ClothesService service;
	
	@GetMapping("/list")
	public void list() {
		log.info("item list jsp.. ");
	}
	
	@GetMapping("/register")
	public void getRegister() {
		log.info("get Register Page...");
	}
	
	@PostMapping("/register")
	public String postRegister(ClothesVO vo, RedirectAttributes rttr) {
		
		log.info("In Controller Regist VO : " + vo);
		
		service.register(vo);
	
		return "redirect:/clothes/list";
		
	}
	

	// 목록, 수정, 삭제는 등록설정이 다 된 이후 추가 할것.

}
