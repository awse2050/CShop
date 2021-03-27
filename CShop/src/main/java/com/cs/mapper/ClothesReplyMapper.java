package com.cs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cs.domain.Criteria;
import com.cs.domain.category.ClothesReply;

public interface ClothesReplyMapper {

	//추가
	public int insert(ClothesReply reply);
	//읽기
	public ClothesReply read(Long rno);
	//모든 댓글 읽기
	public List<ClothesReply> getReplyList(@Param("cno")Long cno, @Param("cri")Criteria cri);
	//수정
	public boolean update(ClothesReply reply);
	//삭제
	public boolean delete(Long rno);
	// 댓글 갯수
	public int getCountByCno(Long cno);
	
	
}
