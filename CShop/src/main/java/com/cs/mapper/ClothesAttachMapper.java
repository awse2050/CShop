package com.cs.mapper;

import java.util.List;

import com.cs.domain.ClothesAttachVO;

public interface ClothesAttachMapper {
	// 추가..
	public void insert(ClothesAttachVO vo);
	// 삭제...
	public void delete(String uuid);
	// 게시물의 첨부파일 찾기
	public List<ClothesAttachVO> findByCno(Long cno);
	// 게시물삭제시 전체삭제
	public void deleteAll(Long cno);
		
}
