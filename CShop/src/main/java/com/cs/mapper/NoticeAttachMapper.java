package com.cs.mapper;

import java.util.List;

import com.cs.domain.NoticeAttachVO;

public interface NoticeAttachMapper {
	// 추가..
	public void insert(NoticeAttachVO vo);
	// 삭제...
	public void delete(String uuid);
	// 게시물의 첨부파일 찾기
	public List<NoticeAttachVO> findByNno(Long nno);
	// 게시물삭제시 전체삭제
	public void deleteAll(Long nno);
		
}
