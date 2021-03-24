package com.cs.controller;

import java.net.URLEncoder;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.MemberVO;
import com.cs.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class CommonController {

	private final MemberService memberService;
	
	@GetMapping("/accessError") 
	public void aceessError(Authentication auth) {
		log.info("error page ..");
		
		log.info("auth ... : " + auth);
	}
	
	@GetMapping("/signUp")
	public void getSignUp() {
		log.info("Move SignUp Page...");
	}
	
	@PostMapping("/signUp")
	public String postSignUp(MemberVO vo, RedirectAttributes rttr) {
		log.info("Sign Up In Controller");
		log.info("Regist Data : " + vo);
		
		int result = memberService.register(vo);
		log.info("result : " + result);
		
		return "redirect:/index";
	}
	
	@GetMapping(value = "/signUp/userid/{userid}", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public ResponseEntity<String> isExistUserId(@PathVariable("userid") String userid) {
		log.info("is Exist User Id : "+ userid);
		
		boolean checkResult = Objects.nonNull(memberService.getByUserId(userid));
		log.info("checkResult : "+ checkResult);
		
		return checkResult ? new ResponseEntity<String>("exist", HttpStatus.OK) 
				: new ResponseEntity<String>("not exist", HttpStatus.OK);
	}
	
//	@GetMapping(value = "/signUp/email/{email}",  produces = MediaType.TEXT_PLAIN_VALUE)
//	@ResponseBody
//	public ResponseEntity<String> isExistEmail(@PathVariable("email") String email) {
//		log.info("is Exist Email : "+ email);
//		
//		String reg = "/[@.]/g";
//		
//		boolean checkResult = Objects.nonNull(memberService.getByEmail(email));
//		log.info("checkResult : "+ checkResult);
//		
//		return checkResult ? new ResponseEntity<>("exist", HttpStatus.OK)
//				: new ResponseEntity<String>("not exist", HttpStatus.OK);
//	}
	
	@PostMapping(value = "/signUp/email",  produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public ResponseEntity<String> isExistEmail(String email) {
		log.info("is Exist Email : "+ email);
		
		boolean checkResult = Objects.nonNull(memberService.getByEmail(email));
		log.info("checkResult : "+ checkResult);
		
		return checkResult ? new ResponseEntity<>("exist", HttpStatus.OK)
				: new ResponseEntity<String>("not exist", HttpStatus.OK);
	}
}
