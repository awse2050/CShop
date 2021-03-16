package com.cs.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.cs.domain.MemberVO;
import com.cs.mapper.MemberMapper;
import com.cs.security.domain.CustomUser;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		log.warn("load user By Username : " + username);
		
		MemberVO vo = mapper.read(username);
		
		log.warn("vo.. : " + vo);
		return vo != null ? new CustomUser(vo) : null;
	}
}
