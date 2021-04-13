package com.cs.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cs.domain.ClothesAttachVO;
import com.cs.domain.LikeVO;
import com.cs.domain.category.ClothesVO;
import com.cs.mapper.ClothesAttachMapper;
import com.cs.mapper.ClothesMapper;
import com.cs.mapper.LikeMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class LikeServiceImpl implements LikeService {
	
	private final LikeMapper likeMapper;
	
	private final ClothesMapper clothesMapper;

	private final ClothesAttachMapper clothesAttachMapper;
	
	private final S3UploadService s3Service;
	
	@Override
	public int register(LikeVO vo) {
		// TODO Auto-generated method stub
		log.info("regist vo : " +vo);
		return likeMapper.insert(vo);
	}

	@Transactional
	@Override
	public List<ClothesVO> getLikeListByUserid(String userid) {
		// TODO Auto-generated method stub
		log.warn("get Like List with userid : " + userid);
		List<LikeVO> likeList = likeMapper.getLikeListByUserid(userid);

		List<ClothesVO> clothesList = new ArrayList<ClothesVO>();
		if(Objects.isNull(likeList)) {
			return null;
		}
		likeList.forEach(i -> {
			ClothesVO vo = clothesMapper.read(i.getCno());
			List<ClothesAttachVO> attachList = clothesAttachMapper.findByCno(i.getCno());
			
			if(Objects.isNull(attachList) || attachList.size() == 0) {
				log.warn("No have Attach By Cno : " + i.getCno());
			} else {
				ClothesAttachVO attachVO = clothesAttachMapper.findByCno(i.getCno()).get(0);
				
				String path = attachVO.getUploadPath() + "/" + attachVO.getUuid() + "_" + attachVO.getFileName();
				vo.setThumbnailUrl(s3Service.getThumbnailUrl(path));
				
				log.warn("make ThumbnailUrl");
			}
			
			clothesList.add(vo);
		});
		
		return clothesList;
	}
	
	@Override
	public boolean remove(Long cno, String userid) {
		log.info("Cancel Like Cno : " + cno);
		log.info("Cancel Like User : " + userid);
		return likeMapper.delete(cno, userid);
	}

	@Override
	public LikeVO getByCnoWithUserid(LikeVO vo) {
		log.info("search Like Cno : " + vo.getCno());
		log.info("search Like User : " + vo.getUserid());
		return likeMapper.getByCnoWithUserid(vo);
	}
	
	@Override
	public boolean isLike(LikeVO vo) {
		return likeMapper.getByCnoWithUserid(vo) != null ;
	}

}
