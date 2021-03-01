package com.cs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cs.domain.Criteria;
import com.cs.domain.NoticeVO;

public interface NoticeMapper {
	// 추가
	public int insert(NoticeVO vo);
	// 읽기
	public NoticeVO read(Long nno);
	// 전체 레시피 목록
	public List<NoticeVO> getList(Criteria cri);
	// 삭제
	public int delete(Long nno);
	// 수정
	public int update(NoticeVO vo);
	// 갯수
	public int getTotal(Criteria cri);
	// 조회수
	public void updateViewCnt(@Param("nno")Long nno, @Param("count")int count);
	// 마지막번호
	public Long getLastNno();
}
