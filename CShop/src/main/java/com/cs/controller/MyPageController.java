package com.cs.controller;

import java.util.List;
import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		List<ClothesVO> list = clothesService.getByUserid("hide");
	
		model.addAttribute("list", list);
	}
	
	@GetMapping(value = "/goods/{userid}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<ClothesVO>> getByUserid(@PathVariable("userid") String userid) {
		log.info("In Controller Get goodsList By Userid : "+ userid);
		
		List<ClothesVO> list = clothesService.getByUserid(userid);
		
		if(Objects.nonNull(list)) {
			log.info("There are list");
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		
		return null;
	}
	
}
