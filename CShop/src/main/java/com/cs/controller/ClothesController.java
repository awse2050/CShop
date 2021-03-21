package com.cs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.ClothesAttachVO;
import com.cs.domain.Criteria;
import com.cs.domain.PageDTO;
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
	public void list(Criteria cri, Model model) {
		log.info("item list jsp.. ");
		
		log.info("In Controller Cri : " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
		
	}
	
	@GetMapping("/register")
	public void getRegister() {
		log.info("get Register Page...");
	}
	
	@PostMapping("/register")
	public String postRegister(ClothesVO vo, RedirectAttributes rttr) {
		
		log.info("In Controller Regist VO : " + vo);
				
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach( attach -> log.info(attach));
		}

		Long result = service.register(vo);
		
		log.info("register result : " + result);
		
		return "redirect:/clothes/list";
		
	}
	
	// 목록, 수정, 삭제는 등록설정이 다 된 이후 추가 할것.
	@GetMapping("/get")
	public void get(Long cno, Criteria cri, Model model) {
		log.info("In Controller Get Page Cno : " + cno);
		log.info("Criteria : " + cri);
		
		model.addAttribute("clothes", service.get(cno));
		model.addAttribute("cri", cri);
		
	}
	
	
	// 첨부파일 불러오기
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<ClothesAttachVO>> getAttachList(Long cno) {
		
		log.info("get Attach List Cno : " + cno );
		return new ResponseEntity<>(service.getAttachList(cno), HttpStatus.OK);
	}
	
}
