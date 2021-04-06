package com.cs.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
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
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/receive/list")
	public void receive(Authentication auth, Model model)  {
		log.info("Receive Message Page....");
		if( auth != null) {
			model.addAttribute("getMsg", msgService.getReceivedList(auth.getName()));
		} 
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/sent/list")
	public void sent(Authentication auth, Model model) {
		log.info("Sent Message Page....");
		if( auth != null) {
			model.addAttribute("sentMsg", msgService.getSentList(auth.getName()));
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping({"/receive/get","/reply"})
	public void get(Long mno, Authentication auth, Model model) {
		log.info("In Controller read Mno msg : " + mno);
		if( auth != null) {
			log.info("Login User.. : " + auth.getName());
		}
		model.addAttribute("msg", msgService.getReceivedMsgByMno(mno));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/sent/get")
	public void read(Long mno, Authentication auth, Model model) {
		log.info("In Controller read Mno msg : " + mno);
		if( auth != null) {
			log.info("Login User.. : " + auth.getName());
		}
		model.addAttribute("msg", msgService.getSentMsgByMno(mno));
	}

	// 답장보내기
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/reply")
	public String register(MessageVO msg, RedirectAttributes rttr) {
		log.info("Write Reply Message : " + msg);
		
		int sendResult = msgService.register(msg);
		
		return "redirect:/message/receive/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/removeSentMsg")
	public String removeSentMsg(Long mno, RedirectAttributes rttr) {
		log.info("Remove Message Mno : " + mno);
		
		boolean removeResult = msgService.removeSentMsgByMno(mno);
		log.info("remove ? : " +removeResult);
		
		return "redirect:/message/sent/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/removeReceivedMsg")
	public String removeReceivedMsg(Long mno, RedirectAttributes rttr) {
		log.info("Remove Message Mno : " + mno);
		
		boolean removeResult = msgService.removeReceivedMsgByMno(mno);
		log.info("remove ? : " +removeResult);
		
		return "redirect:/message/receive/list";
	}
	
	// 판매자에게 메세지 보내기
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/write", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public ResponseEntity<String> writeMsg(@RequestBody MessageVO msg) {
		log.info("Send Message info : " + msg);
		
		int sendResult = msgService.register(msg);
		
		return sendResult == 1 ? new ResponseEntity<>("Send", HttpStatus.OK) 
				: new ResponseEntity<>("", HttpStatus.OK);
	}
}
