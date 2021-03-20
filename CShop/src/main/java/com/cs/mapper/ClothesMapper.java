package com.cs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesVO;

public interface ClothesMapper {
	
	//추가
	public Long insert(ClothesVO vo);
	//상세(목록)
	public ClothesVO read(Long cno);
	//수정
	public boolean update(ClothesVO vo);
	//삭제
	public boolean delete(Long cno);
	//전체 목록
	public List<ClothesVO> getList(Criteria cri);
	// 조회수 증가 및 감소
	public void updateViewCnt(@Param("cno")Long cno, @Param("count")int count);
	
	public int getTotal(Criteria cri);
	// 마지막번호
	public Long getLastCno();
}
