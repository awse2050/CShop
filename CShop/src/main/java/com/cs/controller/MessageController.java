package com.cs.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.MessageVO;
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
	
	@GetMapping({"/read","/reply"})
	public void read(Long mno, Model model) {
		log.info("In Controller read Mno msg : " + mno);
		// 로그인한 사용자와 비교해서 해당 사용자가 보낸사람이면 sender 를 보내고 아니라면 receiver를 보낸다.
		model.addAttribute("msg", msgService.getByMno(mno));
		model.addAttribute("sender", msgService.getByMno(mno).getSender());
	}

	// 답장보내기
	@PostMapping("/reply")
	public String register(MessageVO msg, RedirectAttributes rttr) {
		log.info("Write Reply Message : " + msg);
		
		int sendResult = msgService.register(msg);
		log.info(sendResult);
		return "redirect:/message/receive";
	}
	
	@PostMapping("/remove")
	public String remove(Long mno, RedirectAttributes rttr) {
		log.info("Remove Message Mno : " + mno);
		
		boolean removeResult = msgService.remove(mno);
		log.info("remove ? : " +removeResult);
		
		return "redirect:/message/receive";
	}
}
