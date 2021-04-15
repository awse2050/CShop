package com.cs.service;

import java.util.List;
import java.util.Objects;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.firewall.RequestRejectedException;
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

	private final PasswordEncoder encoder;
	
	@Transactional
	@Override
	public int register(MemberVO vo) {
		
		log.info("Register MemberVO : " + vo);

		vo.setPassword(encoder.encode(vo.getPassword()));
		// 추가로 권한을 넣어줘야한다... 트랜잭션 추가
		int addResult = memberMapper.insert(vo);
		
		if(addResult == 1) {
			log.warn("Add Complete User Data");
			log.warn("By inserting Auth");
			authMapper.insert(new AuthVO(vo.getUserid(), "ROLE_MEMBER"));
		}
		
		return addResult;
	}
	
	@Override
	public MemberVO getByUserId(String userid) {
	
		log.info("get By User Id : " + userid);
	
		return memberMapper.read(userid);
	}
	
	@Override
	public MemberVO getByEmail(String email) {
		
		log.info("get By Email : " + email);

		return memberMapper.readByEmail(email);
	}
	
	@Override
	public boolean modifyMyInfo(MemberVO vo) {
		log.warn("modify Member VO : " + vo);
		
		log.warn("Encoding Password...");
		vo.setPassword(encoder.encode(vo.getPassword()));
		log.warn("after VO ... : " + vo);
		
		return memberMapper.update(vo);
	}
	
	@Override
	public MemberVO verifyMember(MemberVO vo) {
		log.warn("verify email :" + vo.getEmail() + "\n verify Username : " + vo.getUsername());
		log.warn("verify Userid: " + vo.getUserid());
		
		return memberMapper.verifyMember(vo);
	}
}
