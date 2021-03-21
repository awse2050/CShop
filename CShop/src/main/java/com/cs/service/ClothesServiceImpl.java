package com.cs.service;

import java.util.List;

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
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
		log.info("cno : " + cno);
		
		mapper.updateViewCnt(cno, +1);
		
		return mapper.read(cno);
	}

	@Override
	public List<ClothesVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getList(cri);
	}

	@Override
	public boolean remove(Long cno) {
		// TODO Auto-generated method stub
		log.info("remove cno : " + cno);
		return mapper.delete(cno);
	}

	@Override
	public boolean modify(ClothesVO vo) {
		// TODO Auto-generated method stub
		log.info("modify vo : " + vo);
		return mapper.update(vo);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("cri : " + cri);
		return mapper.getTotal(cri);
	}
	
	@Override
	public List<ClothesAttachVO> getAttachList(Long cno) {
		log.info("get attach number : " + cno);
		
		return attachMapper.findByCno(cno);
	}
	
}
