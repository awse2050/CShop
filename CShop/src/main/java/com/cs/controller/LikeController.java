package com.cs.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@GetMapping(value ="/like/{userid}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<ClothesVO>> getLikeListWithUserid(@PathVariable("userid") String userid) {
		// 유저아이디를 받는다.
		log.info("In Controller Userid : " + userid);

		return new ResponseEntity<>(likeService.getLikeListByUserid(userid), HttpStatus.OK);
	}
	
}
