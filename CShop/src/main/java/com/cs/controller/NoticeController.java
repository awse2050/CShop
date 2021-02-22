package com.cs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.Criteria;
import com.cs.domain.NoticeVO;
import com.cs.domain.PageDTO;
import com.cs.service.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService service;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("notice list..");
		log.info("cri : " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
	}
	
	@GetMapping("/register") 
	public void register() {
		log.info("register page...");
	}
		
	@PostMapping("/register")
	public String postRegsiter(NoticeVO vo, RedirectAttributes rttr) {
		log.info("regist VO : " + vo);
		log.info("post register....");

		int result = service.register(vo);
		
		if(result == 1) { 
			// 등록한 번호로 이동하게 변경할 것.
			// service.getLastNno
		}
		return "redirect:/notice/list";
		
	}
	
	@GetMapping({"/get","/modify"})
	public void getPage(Model model,Criteria cri, Long nno) { 
		
		log.info("notice number : " + nno);
		log.info("cri... : " + cri);
		model.addAttribute("notice", service.get(nno));
		model.addAttribute("cri", cri);
	}
	
	@PostMapping("/modify")
	public String modify(NoticeVO vo, Criteria cri, RedirectAttributes rttr) {
		log.info("modify vo ... " + vo);
		
		boolean result = service.modify(vo);
		
		if(result) {
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		}
		
		return result ? "redirect:/notice/list" : null;
		
	}
	
	@PostMapping("/remove")
	public String remove(Long nno, Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove notice nno : " + nno);
		
		boolean result = service.remove(nno);
		if(result) {
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		}
		
		return result ? "redirect:/notice/list" : null;
		
	}
	
	
	
}
