package com.cs.controller;

import java.util.List;
import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cs.domain.LikeVO;
import com.cs.domain.category.ClothesVO;
import com.cs.service.LikeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class LikeController {

	private final LikeService likeService;
	
	@GetMapping("/like")
	public void index() {
		log.info("like page ");
	}
	
	@GetMapping(value = "/like/{userid}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<ClothesVO>> getLikeListWithUserid(@PathVariable("userid") String userid) {
		// 유저아이디를 받는다.
		log.info("In Controller Userid : " + userid);

		return new ResponseEntity<>(likeService.getLikeListByUserid(userid), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/like/{cno}/{userid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("cno")Long cno, @PathVariable("userid")String userid) {
		log.info("In Controller Delete Like List Cno : " + cno);
		log.info("In Controller Delete Like List Userid : " + userid);
		
		boolean removeResult = likeService.remove(cno, userid);
		
		return removeResult ? new ResponseEntity<String>("unlike", HttpStatus.OK) 
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PostMapping(value = "/like/add", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody LikeVO vo) {
		log.info("In Controller like regist VO : " + vo);
		
		LikeVO likeVO = likeService.getByCnoWithUserid(vo);
		
		log.info("exist Like ... : " + likeVO);
		
		if(Objects.nonNull(likeVO)) {
			log.info("Already Like...");
			return new ResponseEntity<String>("Already Like", HttpStatus.OK);
		}
		
		int result = likeService.register(vo);
		log.info(result);
		return new ResponseEntity<String>("like", HttpStatus.OK );
					
	}
	
}
