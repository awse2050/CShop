package com.cs.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cs.domain.ClothesAttachVO;
import com.cs.domain.Criteria;
import com.cs.domain.LikeVO;
import com.cs.domain.PageDTO;
import com.cs.domain.category.ClothesVO;
import com.cs.service.ClothesService;
import com.cs.service.LikeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/clothes/*")
public class ClothesController {
	
	private final ClothesService service;
	
	private final LikeService likeService;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("item list jsp.. ");
		
		log.info("In Controller Cri : " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
		model.addAttribute("asideHeader", "clothes");
	}
	
	@GetMapping("/register")
	public void getRegister() {
		log.info("get Register Page...");
	}
	
	@PostMapping("/register")
	public String postRegister(ClothesVO vo, RedirectAttributes rttr) {
		
		log.info("In Controller Regist VO : " + vo);
				
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach( attach -> log.info(attach));
		}

		Long result = service.register(vo);
		
		log.info("register result : " + result);
		
		return "redirect:/clothes/list";
		
	}
	
	// 목록, 수정, 삭제는 등록설정이 다 된 이후 추가 할것.
	@GetMapping({"/get"})
	public void get(Long cno, Criteria cri, Authentication auth, Model model) {
		log.info("In Controller Get Page Cno : " + cno);
		log.info("Criteria : " + cri);
		if(auth != null) {
			boolean isLike = likeService.isLike(new LikeVO(auth.getName(), cno));
			log.info("isLike ? " + isLike);
			if(isLike) {
				model.addAttribute("like", "isLike");
			} else {
				model.addAttribute("like", "noLike");
			}
		}
		
		model.addAttribute("clothes", service.get(cno));
		model.addAttribute("cri", cri);
	}
	
	@GetMapping({"/modify"})
	public void modify(Long cno, Criteria cri, HttpServletRequest request, Model model) {
		log.info("In Controller Modify Page Cno : " + cno);
		log.info("Criteria : " + cri);
		
		String uri = getUri(request);
		
		model.addAttribute("clothes", service.modify(cno));
		model.addAttribute("cri", cri);
		model.addAttribute("requestUri", uri);
	}
	
	@PreAuthorize("principal.username == #vo.writer")
	@PostMapping("/modify") 
	public String modify(ClothesVO vo, Criteria cri, HttpServletRequest request, RedirectAttributes rttr) {
		log.info("In Controller Modify VO : " + vo);
		log.info("cri : " + cri);
		
		boolean modifyResult = service.modify(vo);
		
		String uri = request.getParameter("requestUri");
		
		if(modifyResult) {
			
			if(uri.contains("mypage")) {
				return "redirect:"+uri;
			}
			
			rttr.addAttribute("cno", vo.getCno());
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
			
		}
		return "redirect:/clothes/get";
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(Long cno, String writer, Criteria cri, HttpServletRequest request, RedirectAttributes rttr) {
		
		log.info("In Controller Remove Cno : " + cno);
		log.info("In Controller Remove With Writer : " + writer);
		
		List<ClothesAttachVO> attachList = service.getAttachList(cno);
		log.info("Cno have AttachList : " + attachList);
		
		String uri = request.getParameter("requestUri");
		
		boolean result = service.remove(cno);
		
		if(result) {
			
			deleteFile(attachList);
			
			if(uri != null && uri.length() != 0 && uri.contains("mypage")) {
				return "redirect:"+uri;
			}
			
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		}
		
		return "redirect:/clothes/list";
	}

	// 첨부파일 불러오기
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<ClothesAttachVO>> getAttachList(Long cno) {
		
		log.info("get Attach List Cno : " + cno );
		return new ResponseEntity<>(service.getAttachList(cno), HttpStatus.OK);
	}
	
	//첨부파일 삭제
	private void deleteFile(List<ClothesAttachVO> attachList) {
		
		log.info("Deleting File In deleteFile Method ....");
		
		if(attachList == null || attachList.size() == 0) {
			log.info("Attach List is Null");
			return;
		}
		
		log.info("delete attach file List. ... ");

		attachList.forEach(attach -> {
			try { 
				File file = new File("c:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				// 파일이 있으면 지운다.
				Files.deleteIfExists(file.toPath());
				
				if(Files.probeContentType(file.toPath()).startsWith("image")) {
					file = new File("c:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
				
					Files.delete(file.toPath());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
	
	private String getUri(HttpServletRequest request) {
		StringBuffer referer = new StringBuffer(request.getHeader("referer"));
		String host = request.getHeader("Host");
		
		String uri = referer.delete(0, host.length() + referer.indexOf(host)).toString();
		
		return uri;
		
	}
}
