package com.cs.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.Criteria;
import com.cs.domain.NoticeAttachVO;
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
		
		log.info("post register....");
		log.info("regist VO : " + vo);
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach( attach -> log.info(attach));
		}

		int result = service.register(vo);
		
		if(result == 1) { 
			rttr.addAttribute("nno", service.getLastNno());
		}
		
		return "redirect:/notice/get";
		
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
			deleteFiles(service.getAttachList(nno));
			
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		}
		
		return result ? "redirect:/notice/list" : null;
		
	}
	
	// 첨부파일 불러오기
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<NoticeAttachVO>> getAttachList(Long nno) {
		
		log.info("nno : " + nno);
		
		return new ResponseEntity<List<NoticeAttachVO>> ( service.getAttachList(nno), HttpStatus.OK );
	}
	
	// 첨부파일 삭제
	private void deleteFiles(List<NoticeAttachVO> attachList) {
	
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete Files...");
		log.info(attachList);
		
		attachList.forEach( attach -> {
				
			try {
				File file = new File("c:\\upload\\"+attach.getUploadPath()+ "\\"+ attach.getUuid()+"_"+attach.getFileName());
				
				file.delete();
				
				if(Files.probeContentType(file.toPath()).startsWith("image")) {
					file = new File("c:\\upload\\"+attach.getUploadPath()+ "\\s_"+ attach.getUuid()+"_"+attach.getFileName());
					
					file.delete();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
}
