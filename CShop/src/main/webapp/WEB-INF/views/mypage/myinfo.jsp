<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<%@ include file="../includes/aside.jsp"%>
			<div class="bodyRow">
				<div class="bodyHeader">
					<div class="header-title">회원정보 수정</div>
					<div class="header-location" >
							HOME > 마이페이지 > 회원정보 수정
					</div>
				</div>
				<form class="signUpForm">
					<div style="font-size: 16px; font-weight: 700;">
						개인정보
					</div>
					<table class="input-table">
						<tbody>
						<tr>
							<th>이름</th>
							<td>
							<input type="text" name="username" readonly>
							</td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td>
							<input type="text" name="nickname" readonly>
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" name="userid" readonly>
							 	<button class="existcheck-btn" id="isExistUserIdBtn">중복확인</button>
							</td>
						</tr>
						<tr>
							<th class="required">패스워드</th>
							<td>
							<input type="password" name="password" placeholder="비밀번호를 입력해주세요.">
							<ul class="guide">
								<li>8자 이상, 16자 이하로 영문과 숫자를 포함하여 입력하여주세요.</li>
							</ul>
							</td>
						</tr>
						<tr>
							<th class="required">패스워드 확인</th>
							<td>
							<input type="password" name="confirmPassword" placeholder="비밀번호를 한번 더 입력해주세요.">
							<ul class="guide">
								<li>비밀번호 확인을 위해 한번 더 입력하여 주세요.</li>
							</ul>
							</td>
						</div>
						</tr>
						<tr>
							<th class="required">휴대폰 번호</th>
							<td>
							<input type="text" name="phone" placeholder="휴대폰 번호를 입력해주세요.">
							</td>
						</tr>
						<tr>
							<th class="required">이메일</th>
							<td>
							<input type="text" name="email" placeholder="이메일을 입력해주세요.">
							<button class="existcheck-btn" id="isExistEmailBtn">중복확인</button>
							</td>
						</tr>
						<tr>
						<!-- 특정 라이브러리 요구? -->
							<th class="required">주소</th>
							<td>
								<input type="text" id="postCode" class="wid85-input" readonly="readonly">
								<button class="existcheck-btn" id="searchAddressBtn">우편번호 찾기</button>
								<div class="addressDiv">
									<input type="text" id="roadAddress" placeholder="도로명 주소" readonly="readonly">
									<input type="text" id="extraRoadAddress"  placeholder="참고항목" readonly="readonly">
								</div>
								<div class="addressDiv">
									<input type="text" id="detailsAddress" placeholder="상세주소를 입력하세요.">
								</div>
							</td>
						</tr>
		 				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
						</tbody>
					</table>
					<div class="signup-buttonRow">
						<button class="signUp-btn">회원가입</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>