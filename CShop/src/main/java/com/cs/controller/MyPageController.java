package com.cs.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cs.domain.category.ClothesVO;
import com.cs.service.ClothesService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage/*")
@RequiredArgsConstructor
public class MyPageController {
	
	private final ClothesService clothesService;

	@GetMapping("/index")
	public void index() {
		log.info("My Page....");
	}
	
	@GetMapping("/goods")
	public void goods(Model model) {
		// 인자로 @Authenticationprincipal을 사용하여 아이디로 찾게 한다 (이후변경)
		log.info("goods page...");
		List<ClothesVO> list = clothesService.getByUserid("admin44");
	
		model.addAttribute("list", list);
	}
	
}
