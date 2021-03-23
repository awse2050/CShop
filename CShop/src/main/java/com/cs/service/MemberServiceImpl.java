package com.cs.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cs.domain.AuthVO;
import com.cs.domain.MemberVO;
import com.cs.mapper.AuthMapper;
import com.cs.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	
	private final AuthMapper authMapper;

	@Transactional
	@Override
	public int register(MemberVO vo) {
		
		log.info("Register MemberVO : " + vo);
		// 추가로 권한을 넣어줘야한다... 트랜잭션 추가
		int addResult = memberMapper.insert(vo);
		
		if(addResult == 1) {
			log.info("Add Complete User Data");
			log.info("By inserting Auth");
			authMapper.insert(new AuthVO(vo.getUserid(), "ROLE_MEMBER"));
		}
		
		return addResult;
	}
	
	@Override
	public MemberVO getByUserId(String userid) {
	
		log.info("get By User Id : " + userid);
	
		return memberMapper.read(userid);
	}
	
	
}
