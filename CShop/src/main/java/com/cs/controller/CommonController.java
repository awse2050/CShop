package com.cs.controller;

import java.net.URLEncoder;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.MemberVO;
import com.cs.service.EmailSendService;
import com.cs.service.MemberService;
import com.cs.util.EmailForm;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class CommonController {

	private final MemberService memberService;
	
	private final EmailSendService emailSendService;
	
	private final PasswordEncoder encoder;
	
	@GetMapping({"/","/index"})
	public String index() {
		log.info("index page...");
		return "index";
	}
	
	@GetMapping("/findID")
	public void findIdPage() {
		log.info("find Id Page...");
	}
	
	@GetMapping("/findPW")
	public void findPwPage() {
		log.info("find PW Page...");
	}
	
	@GetMapping("/accessError") 
	public void aceessError(Authentication auth) {
		log.info("error page ..");
		
		log.info("auth ... : " + auth);
	}
	
	@GetMapping("/loginPage")
	public void loginPage(String error, String logout, HttpServletRequest request, Model model) {

		String saveUri = null;
		String errorMsg = null;
		log.info("login page...");
		
		if(error != null) {
			log.info("login error ... : " + error);
			errorMsg = "로그인 정보를 다시 입력해 주세요.";
			
			saveUri = "http://localhost:8080/index";
		} else {
			saveUri = request.getHeader("referer");
		}
		
		log.info("save Uri : " + saveUri);
		model.addAttribute("errorMsg", errorMsg);
		model.addAttribute("referer", saveUri );
	}
	
	@GetMapping("/signUp")
	public void getSignUp() {
		log.info("Move SignUp Page...");
	}

	@PostMapping(value = "/signUp/{userid}", consumes = "application/json")
	@ResponseBody
	public ResponseEntity<String> signUp(@RequestBody MemberVO vo, @PathVariable("userid")String userid) {
		log.info("Sign Up In Controller");
		log.info("Regist Data : " + vo);
		
		int result = memberService.register(vo);
		
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>("", HttpStatus.OK);
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
	
	@GetMapping(value = "/signUp/email/{email:.+}")
	@ResponseBody
	public ResponseEntity<String> isExistEmail(@PathVariable("email") String email) {
		log.info("is Exist Email : "+ email);
		
		boolean checkResult = Objects.nonNull(memberService.getByEmail(email));
		log.info("checkResult : "+ checkResult);
		
		return checkResult ? new ResponseEntity<>("exist", HttpStatus.OK)
				: new ResponseEntity<String>("not exist", HttpStatus.OK);
	}
	
	@GetMapping(value = "/verifyId/{username}/{email:.+}")
	@ResponseBody
	public ResponseEntity<String> verifyByUsernameWithEmail(@PathVariable("username")String username,
												@PathVariable("email")String email) {
		MemberVO member = memberService.verifyMember(new MemberVO(username, email));
		log.info(member);
		
		boolean verify = Objects.nonNull(member);
		log.info(verify);
		
		if(verify) {
			sendEmailWhenLookingForId(member);
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		return null;
	}

	@GetMapping(value = "/verifyPw/{userid}/{username}/{email:.+}")
	@ResponseBody
	public ResponseEntity<String> verifyMember(@PathVariable("userid")String userid, 
												@PathVariable("username")String username,
												@PathVariable("email")String email) {
		log.info(userid + "," + username + "," + email);
		
		MemberVO member = memberService.verifyMember(new MemberVO(userid, username, email));
		boolean verify = Objects.nonNull(member);
		log.info(verify);
		
		if(verify) {
			sendEmailWhenLookingForPw(member);
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		return null;
	}
	
	private void sendEmailWhenLookingForId(MemberVO member) {
		
		EmailForm email = new EmailForm();
		email.setTo(member.getEmail());
		email.setSubject("안녕하세요 CShop 입니다!");
		email.setText("귀하의 아이디는 \""+member.getUserid()+"\" 입니다.");
		
		emailSendService.sendEmailToUser(email);
	}
	
	private void sendEmailWhenLookingForPw(MemberVO member) {
		String modifyPw = memberService.modifyPassword(member);
		
		EmailForm email = new EmailForm();
		email.setTo(member.getEmail());
		email.setSubject("안녕하세요 CShop 입니다!");
		email.setText(member.getUsername()+"님이 요청하신 아이디의 변경된 임시 비밀번호는  \""+modifyPw+"\" 입니다.");
		
		emailSendService.sendEmailToUser(email);
		
	}
	
}
