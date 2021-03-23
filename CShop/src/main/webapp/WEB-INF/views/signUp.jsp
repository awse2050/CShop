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
					<span>아이디</span>
					<input type="text" name="userid">
				<div>
				<button class="isExistBtn">중복확인</button>
				<div>
					<span>닉네임</span>
					<input type="text" name="nickname">
				</div>
				<div>
					<span>이름</span>
					<input type="text" name="username">
				</div>
					<span>패스워드</span>
					<input type="password" name="password">
				</div>
				<div>
					<span>패스워드 확인</span>
					<input type="password" name="confirmPassword">
				</div>
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
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		// Security 적용시 ajax 통신에 추가설정필요
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		var signUpForm = $(".signUpForm");
		var signUpBtn = $(".signUpBtn");
		var isExistBtn = $(".isExistBtn");
		var memberObj = {};
		var errorMsg;
		var checkUserId;
		
		isExistBtn.on("click", function(e) {
			e.preventDefault();
			console.log("isExistBtn click");
			
			checkUserid = false;
			
			var userid = signUpForm.find("input[name='userid']").val();
			console.log("userid : " + userid);
			
			$.get("/signUp/"+userid, function(checkResult) {
				console.log(checkResult);
				if(checkResult == "exist") {
					console.log("exist Result is 'exist'" );
					alert("이미 존재하는 아이디 입니다.");
				} else {
					checkUserId = true;
					alert("사용 가능한 아이디 입니다.");
				}		
			}); // ajax
		});
		
		signUpBtn.on("click", function(e) {
			e.preventDefault();
			console.log("sign Up Btn Click");
			
			errorMsg = "";
			/* 
				1. 클릭을 한다
				2. 우선 input의 데이터를 추합한다.
				3. 추합해서 하나의 input이 비어있거나 null이면 false
				4. 이후 패스워드 일치 여부를 체크
				5. 통과 시 회원가입 완료 ( alert 발송 )
			*/
			// 우선 value를 모아서 memberObj에 저장한다.
			setMemberObj(); 
			// value를 체크한다.
			if(isEmptyInputValue()) {
				// alert or append to tag
				alert(errorMsg);
				return false;
			}
			// 패스워드가 일치하는 지 체크한다.
			if(!isEqualsPassword()) {
				// alert or append to tag
				alert(errorMsg);
				return false;	
			}
			
			if(!isClickExistButton()) {
				alert(errorMsg);
				return false;
			}
			
			console.log("complete Sign Up");
			alert("가입이 완료되었습니다.");
			signUpForm.submit();
		});
		
	 	function isEmptyInputValue() {
			console.log("isEmptyInputValue()");
			
			if(!memberObj.userid) {
				errorMsg = "아이디를 입력하세요";
				console.log("Empty UserId");
				return true;
			} else if(!memberObj.password) {
				errorMsg = "비밀번호를 입력하세요";
				console.log("Empty Password");
				return true;
			} else if(!memberObj.username) {
				errorMsg = "이름을 입력하세요";
				console.log("Empty Username");
				return true;
			} else if(!memberObj.nickname) {
				errorMsg = "닉네임을 입력하세요";
				console.log("Empty Nickname");
				return true;
			} else if(!memberObj.phone) {
				errorMsg = "휴대폰 번호를 입력하세요";
				console.log("Empty PhoneNumber");
				return true;
			} else if(!memberObj.email) {
				errorMsg = "이메일을 입력하세요";
				console.log("Empty Email");
				return true;
			} else if(!memberObj.address) {
				errorMsg = "주소를 입력하세요";
				console.log("Empty Address");
				return true;
			}
			
			return false;
		}  
		
		function isEqualsPassword() {
			console.log("isEqualsPassword()");
			
			var password = signUpForm.find("input[name='password']").val();
			var confirmPassword = signUpForm.find("input[name='confirmPassword']").val();
			
			console.log("password: ", password);
			console.log("confirmPassword: ", confirmPassword);
			
			if(password === confirmPassword) {
				return true;
			} else {
				console.log("Not Equals Password");
				errorMsg = "패스워드를 일치시켜주세요";
				return false;
			}
		}
	
		function setMemberObj() {
			
			console.log("set Member Obj");
			
			memberObj = { 
					userid: signUpForm.find("input[name='userid']").val(),
					username: signUpForm.find("input[name='username']").val(),
					password: signUpForm.find("input[name='password']").val(),
					nickname: signUpForm.find("input[name='nickname']").val(),
					phone: signUpForm.find("input[name='phone']").val(),
					email: signUpForm.find("input[name='email']").val(),
					address: signUpForm.find("input[name='address']").val()
				}
		}
		
		function isClickExistButton() {
			console.log("is Click Exist Button ? ");
			console.log(checkUserId);			
			if(checkUserId) { 
				console.log("checkUserId is true");
				return true;
			}
			errorMsg = "중복확인을 해주세요.";
			return false;
		}
		
	});

</script>



<%@ include file="./includes/footer.jsp"%>