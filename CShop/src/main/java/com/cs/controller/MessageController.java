package com.cs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cs.service.MessageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/message/*")
public class MessageController {
	
	private final MessageService msgService;
	
	@GetMapping("/receive")
	public void receive(Model model) {
		log.info("Receive Message Page....");
		// 추후 로그인 사용자 넣기로 변경.	
		model.addAttribute("getMsg", msgService.getReceivedList("admin44"));
	}
	
	@GetMapping("/sent")
	public void sent(Model model) {
		log.info("Sent Message Page....");
		
		model.addAttribute("sentMsg", msgService.getSentList("admin44"));
	}

	
}
