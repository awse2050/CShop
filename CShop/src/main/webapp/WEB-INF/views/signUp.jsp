<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp"%>

<div class="container" style="border-bottom: 1px solid #dedede">
	<div class="index-category">
		<div class="index-category-div">
			<div class="index-category-child-div">
				<a href="/clothes/list">
					<div class="category">
						<h3>패션</h3>
					</div>
				</a>	
			</div>
			<div class="index-category-child-div">
				<a href="/mobile/list"> 
					<div class="category">
						<h3>휴대폰/통신</h3>
					</div>
				</a>	
			</div>
			<div class="index-category-child-div">
				<a href="/office/list">
					<div class="category">
						<h3>사무용품</h3>
					</div>
				</a>	
			</div>
		</div>
	</div>
</div>
<!-- end category header -->

<section class="section" style="padding: 0 0;">
	<div class="container">
		<div class="row">
			<h2>회원가입 정보입력</h2>
			<div>
				홈 > 회원가입 정보입력
			</div>	
			<form class="signUpForm" action="/signUp" method="post">
				<div>
					<span>이름</span>
					<input type="text" name="username">
				</div>
				<div>
					<span>닉네임</span>
					<input type="text" name="nickname">
				</div>
					<span>아이디</span>
					<input type="text" name="userid">
				<div>
					<span>패스워드</span>
					<input type="password" name="password">
				</div>
				<!-- <span>패스워드 확인</span>
				<input type="text" name="confirmPassword"> -->
				
				<div>
					<span>휴대폰 번호</span>
					<input type="text" name="phone">
				</div>
				<div>
					<span>이메일</span>
					<input type="text" name="email">
				</div>				
				<!-- 특정 라이브러리 요구? -->
				<div>
					<span>주소</span>
					<input type="text" name="address">
				</div>
 				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
				<button class="signUpBtn">회원가입</button>
			</form>
		</div>
	</div>
</section>	
		
<script>
	
	$(document).ready(function() {
		var signUpForm = $(".signUpForm");
		var signUpBtn = $(".signUpBtn");
		
		signUpBtn.on("click", function(e) {
			e.preventDefault();
			console.log("sign Up Btn Click");
			signUpForm.submit();
		})
	});

</script>



<%@ include file="./includes/footer.jsp"%>