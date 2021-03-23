package com.cs.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	// 아이디 ,비밀번호 ,닉네임(username), 만든시간, enabled, 권한
	private String userid, password, username;
	
	private Date regdate, moddate;
	private boolean enabled;
	// 권한 리스트
	private List<AuthVO> authList;

	// 회원가입시 데이터 추가
	private String nickname, email, phone, address;
}
