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
import com.cs.domain.LikeVO;
import com.cs.domain.NoticeAttachVO;
import com.cs.domain.category.ClothesVO;
import com.cs.mapper.ClothesAttachMapper;
import com.cs.mapper.ClothesMapper;
import com.cs.mapper.ClothesReplyMapper;
import com.cs.mapper.LikeMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ClothesServiceImpl implements ClothesService {
	
	private final ClothesMapper mapper;

	private final ClothesAttachMapper attachMapper;
	
	private final ClothesReplyMapper replyMapper;
	
	private final LikeMapper likeMapper;
	
	// 두 테이블에서 작업을 하므로 동기화식으로 진행 ACID를 유지
	@Transactional 
	@Override
	public Long register(ClothesVO vo) {
		
		log.info("regist vo : " + vo);

		Long result = mapper.insert(vo);
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> {
				
				attach.setCno(mapper.getLastCno());
				attachMapper.insert(attach);
				
			});
		} else {
			log.warn("No Attach List");
		}
		
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
		
		return formatData(clothesList);
	}

	@Transactional
	@Override
	public boolean remove(Long cno) {
		log.warn("remove cno : " + cno);

		likeMapper.deleteAllByCno(cno);
		log.warn("delete Like By Cno: "+ cno);
		
		replyMapper.deleteAll(cno);
		log.warn("delete reply With Cno : " + cno);
		
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
	
	@Override
	public List<ClothesVO> getByUserid(String userid) {
		log.info("get Clothes List By Userid : " + userid);
		
		List<ClothesVO> clothesList = mapper.getByUserid(userid);
		
		return formatData(clothesList);
	}
	
	private List<ClothesVO> formatData(List<ClothesVO> listObj) {
		List<ClothesVO> clothesList = listObj;
		
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
				
				list.setThumbnailUrl(makeThumbnailURL(attachVO));
			});
			
			return clothesList;
		} else {
			return null;
		}
	}
	
	private String makeThumbnailURL(ClothesAttachVO attachVO) {
		String url = null;
		
		try  {
			url = URLEncoder.encode(attachVO.getUploadPath() + "/s_" 
										+ attachVO.getUuid() + "_" + attachVO.getFileName(),"UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return url;
	}
}
