package com.cs.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesReply;
import com.cs.domain.category.ReplyPageDTO;
import com.cs.mapper.ClothesReplyMapper;
import com.cs.service.ClothesReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/clothes/replies/*")
@RequiredArgsConstructor
public class ClothesReplyController {

	private final ClothesReplyService service;
	
	@PostMapping(value = "/new" , consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody ClothesReply reply) {
		log.info("In Controller Add reply : " + reply);
		
		int result = service.register(reply);
		
		return result == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) 
				: new ResponseEntity<String>("fail" , HttpStatus.BAD_REQUEST);
	}
	
	@GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ClothesReply> get(@PathVariable("rno") Long rno) {
		
		log.info("In Controller Get Rno : " + rno);
		
		return new ResponseEntity<ClothesReply>(service.getByRno(rno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{cno}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE} )
	public ResponseEntity<ReplyPageDTO<ClothesReply>> getList(@PathVariable("cno") Long cno, @PathVariable("page")int page) {
		log.info("In Controller Get List By Cno : " + cno);
		
		Criteria cri = new Criteria(page, 10);
		
		return new ResponseEntity<>(service.getReplyListWithPaging(cri, cno), HttpStatus.OK);
	}

	@DeleteMapping(value = "/{rno}",  produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		log.info("In Controller Remove Rno : " + rno);
		
		boolean result = service.remove(rno);
		
		return result ? new ResponseEntity<String>("delete Success", HttpStatus.OK) 
				: new ResponseEntity<String>(HttpStatus.BAD_GATEWAY);
	}
	
	@PutMapping(value = "/{rno}", consumes = "application/json",  
				produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ClothesReply> modify(@PathVariable("rno")Long rno, @RequestBody ClothesReply reply) {
		log.info("In Controller Modify : " + rno);
		log.info("In Controller Modify : " + reply);
		reply.setRno(rno);
		
		boolean result = service.modify(reply);
		
		if(result) {
			ClothesReply modifyReply = service.getByRno(reply.getRno());
			log.info(modifyReply);
			return new ResponseEntity<>(modifyReply, HttpStatus.OK);
		}
		
		return null;
	}
}
