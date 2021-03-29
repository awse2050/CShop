package com.cs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cs.domain.LikeVO;

public interface LikeMapper {

	// 찜하기 ( 추가 )
	public int insert(LikeVO vo);
	// 찜 목록 확인
	public List<LikeVO> getLikeListByUserid(String userid);
	
	public boolean delete(@Param("cno")Long cno, @Param("userid")String userid);
	
	public LikeVO getByCnoWithUserid(@Param("vo")LikeVO vo);
}
