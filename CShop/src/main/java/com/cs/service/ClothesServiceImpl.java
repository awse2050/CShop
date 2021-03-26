package com.cs.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cs.domain.ClothesAttachVO;
import com.cs.domain.Criteria;
import com.cs.domain.NoticeAttachVO;
import com.cs.domain.category.ClothesVO;
import com.cs.mapper.ClothesAttachMapper;
import com.cs.mapper.ClothesMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ClothesServiceImpl implements ClothesService {
	
	private final ClothesMapper mapper;

	private final ClothesAttachMapper attachMapper;
	
	// 두 테이블에서 작업을 하므로 동기화식으로 진행 ACID를 유지
	@Transactional 
	@Override
	public Long register(ClothesVO vo) {
		
		log.info("regist vo : " + vo);
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			log.info("No Attach List");
			return 0L;
		}
		
		Long result = mapper.insert(vo);
		
		vo.getAttachList().forEach(attach -> {
		
			attach.setCno(mapper.getLastCno());
			attachMapper.insert(attach);
		});
		
		return result;
	}

	@Override
	public ClothesVO get(Long cno) {
		
		log.info("get cno : " + cno);
		
		mapper.updateViewCnt(cno, +1);
		
		return mapper.read(cno);
	}
	
	@Override
	public ClothesVO modify(Long cno) {
		
		log.info("modify cno : " + cno);
		
		return mapper.read(cno);
	}

	@Override
	public List<ClothesVO> getList(Criteria cri) {
		 
		List<ClothesVO> clothesList = mapper.getList(cri);
		
		if(Objects.nonNull(clothesList)) {
			log.info("Not Null ClothesList");
			
			clothesList.forEach(list -> {
				list.setAttachList(attachMapper.findByCno(list.getCno()));
				
				if(list.getAttachList() == null || list.getAttachList().size() == 0) {
					log.info(list.getCno() + " haven't AttachList..");
					return;
				}
				
				ClothesAttachVO attachVO;
				
				attachVO = list.getAttachList().get(0);
				log.info("attachVO : " + attachVO);
				
				try  {
					list.setThumbnailUrl(URLEncoder.encode(attachVO.getUploadPath() + "/s_" + attachVO.getUuid() + "_" + attachVO.getFileName(),"UTF-8"));
					
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			});
		}
		
		return clothesList;
	}

	@Transactional
	@Override
	public boolean remove(Long cno) {
		
		log.warn("remove cno : " + cno);
		
		attachMapper.deleteAll(cno);
		log.warn("delete Attach File in DataBase");
		
		return mapper.delete(cno);
	}

	@Transactional
	@Override
	public boolean modify(ClothesVO vo) {

		log.info("modify vo : " + vo);
		// 우선 DB에 있는 데이터를 지운다.
		attachMapper.deleteAll(vo.getCno());
		
		boolean updateResult = mapper.update(vo);
		if(updateResult && Objects.nonNull(vo.getAttachList())) {
			vo.getAttachList().forEach(attach -> {
				attach.setCno(vo.getCno());
				attachMapper.insert(attach);
			});
		}
		
		return updateResult;
	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("cri : " + cri);
		
		return mapper.getTotal(cri);
	}
	
	@Override
	public List<ClothesAttachVO> getAttachList(Long cno) {
		
		log.info("get attach number : " + cno);
		
		return attachMapper.findByCno(cno);
	}
}
