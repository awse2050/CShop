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
		<div class="row" style="padding-top: 30px;">
			<div class="signUp-header">
				<div class="header-title">회원가입 정보입력</div>
			</div>
			<form class="signUpForm">
				<table class="input-table">
					<tbody>
					<tr>
						<th class="required">이름</th>
						<td>
						<input type="text" name="username" placeholder="이름을 입력해 주세요.">
						</td>
					</tr>
					<tr>
						<th class="required">닉네임</th>
						<td>
						<input type="text" name="nickname" placeholder="닉네임을 입력해주세요.">
						</td>
					</tr>
					<tr>
						<th class="required">아이디</th>
						<td>
							<input type="text" name="userid" placeholder="아이디를 입력해주세요.">
						 	<button class="existcheck-btn" id="isExistUserIdBtn">중복확인</button>
						<ul class="guide">
							<li>영어 소문자, 숫자만 4자 이상 가능</li>
						</ul>
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
							<input type="text" id="postCode" style="width:85px;" readonly="readonly">
							<button class="existcheck-btn" id="searchAddressBtn">우편번호 찾기</button>
							<div class="addressDiv">
								<input type="text" id="roadAddress"  placeholder="도로명 주소" readonly="readonly">
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
</section>	
		
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>		
	
<script>
	
	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		// Security 적용시 ajax 통신에 추가설정필요
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		var signUpForm = $(".signUpForm");
		var signUpBtn = $(".signUp-btn");
		var isExistUserIdBtn = $("#isExistUserIdBtn");
		var isExistEmailBtn = $("#isExistEmailBtn");
		var memberObj = {};
		var errorMsg;
		var checkUserId;
		var checkEmail;
		
		var searchAddressBtn = $("#searchAddressBtn");
		var roadAddress = $("#roadAddress");
		var detailsAddress = $("#detailsAddress");
		var extraRoadAddress = $("#extraRoadAddress");
		var postCode = $("#postCode");
		
		$("input[name='email']").on("change", function(e) {
			checkEmail = false;
		})
		
		$(".input[name='userid']").on("change", function(e) {
			checkUserId = false;
		})
		
		searchAddressBtn.on("click", function(e) {
			e.preventDefault();
			
			openAddressSearchWindow();
			
		});
		
		isExistUserIdBtn.on("click", function(e) {
			e.preventDefault();
			
			checkUserid = false;
			
			var regExp = /^[A-Za-z0-9]{4,12}$/ 
			 
			var userid = signUpForm.find("input[name='userid']").val();
			console.log("userid : " + userid);
			
			if(!userid) {
				alert("아이디를 입력하세요.");
				return false;
			}
			
			if(!regExp.test(userid)) {
				alert("영문, 숫자, 영문+숫자 조합으로 입력해주세요.");
				return false;
			}
			
			$.get("/signUp/userid/"+userid, function(checkResult) {
				if(checkResult == "exist") {
					alert("이미 존재하는 아이디 입니다.");
				} else {
					checkUserId = true;
					alert("사용 가능한 아이디 입니다.");
				}		
			}); // ajax
		});
		
		isExistEmailBtn.on("click", function(e) {
			e.preventDefault();
			
			checkEmail = false;
			
			var email = signUpForm.find("input[name='email']").val();
			
			if(!isEmail(email)) {
				alert(errorMsg);
				return false;
			}
			
			$.get("/signUp/email/"+email, function(checkResult) {
				if(checkResult == "exist") {
					alert("이미 존재하는 이메일 입니다.");
				} else {
					checkEmail = true;
					alert("사용 가능한 이메일 입니다.");
				}		
			}); // ajax 
		})

		signUpBtn.on("click", function(e) {
			e.preventDefault();
			console.log("sign Up Btn Click");
			
			errorMsg = "";
			// 우선 value를 모아서 memberObj에 저장한다.
			setMemberObj(); 
			
			console.log(memberObj);
			
			if(!isName(memberObj.username)) {
				alert(errorMsg);
				return false;
			} else if(!isNickname(memberObj.nickname)) {
				alert(errorMsg);
				return false;
			} else if(!isUserid(memberObj.userid)) {
				alert(errorMsg);
				return false;
			} else if(!isPassword(memberObj.password, memberObj.confirmPassword)) {
				alert(errorMsg);
				return false;	
			} else if(!isPhone(memberObj.phone)) {
				alert(errorMsg);
				return false;
			} else if(!isEmail(memberObj.email)) {
				alert(errorMsg);
				return false;
			} else if(!isAddress(detailsAddress.val())) {
				alert(errorMsg);
				return false;
			} else if(!clickExistButton()) {
				alert(errorMsg);
				return false;
			}
		
			console.log("passed");
			signUpForm.attr("action", "/signUp").attr("method", "post").submit();
			
		});
	 	
		function clickExistButton() {
			
			console.log("is Click Exist Button ? ");
			
			if(!checkUserId) { 
				errorMsg = "아이디 중복확인을 해주세요.";
				return false;
			} else if (!checkEmail) {
				errorMsg = "이메일 중복확인을 해주세요.";
				return false;
			}
			return true;
		}
		
		function isAddress(address) {
			if(!address) {
				errorMsg = "상세주소를 입력하세요.";
				return false;
			}
			console.log("address complete");
			return true;
		}
		
		function isEmail(email) {
			// 이메일 형식
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			
			if(regExp.test(email)) {
				return true;
			} else {
				errorMsg = "이메일 형식으로 입력해주세요.";
				return false;
			}
		}
		
		function isNickname(nickname) {
			if(!nickname) {
				errorMsg = "닉네임을 입력하세요";
				return false;
			}
			return true;
		}
		
		function isName(username) {
			var regExp = /^[가-힣]*$/;
			
			if(!username) {
				errorMsg = "이름을 입력하세요";
				return false;
			} else if (!regExp.test(username)) {
				errorMsg = "이름을 정확하게 입력하세요."
				return false;
			}
			return true;
		}
		
		function isUserid(userid) {
			if(!userid) {
				errorMsg = "아이디을 입력하세요";
				return false;
			}
			return true;
		}
		
		function isPhone(phone) {
			// 숫자만 + 11자리이상.
			var regExp = /^[0-9]{10,}$/;
			
			if(regExp.test(phone)) {
				return true;
			} else {
				errorMsg = "휴대폰번호를 정확하게 입력하세요.";
				return false;
			}
		}
	 	
	 	function isPassword(password, confirmPassword) {
	 		// -- 비밀번호,아이디체크 영문,숫자만허용, 4~10자리
	 		var regExp = /^[A-Za-z0-9]{8,16}$/ 
			
	 		if(!isEqualsPassword(password, confirmPassword)) {
				errorMsg = "패스워드를 일치시켜주세요";
	 			return false;
	 		} else if(!checkPasswordLength(password)) {
	 			errorMsg = "비밀번호를 8~16자리로 입력해주세요.";
	 			return false;
	 		} else if(!regExp.test(password)) {
	 			errorMsg = "영문+숫자 조합의 비밀번호를 입력하세요.";
	 			return false;
	 		}
	 		return true;
	 	}
	 	
	 	function checkPasswordLength(password) {
	 		
	 		console.log(password.length);
	 		
	 		var equalsResult = password.length >= 8;
	 		
	 		if(!equalsResult) {
	 			return false;
	 		}
			return true;	 	
	 	}
		
		function isEqualsPassword(password, confirmPassword) {
			
			console.log("isEqualsPassword()");
			
			if(password === confirmPassword) {
				return true;                                    
			} else {
				console.log("Not Equals Password");
				return false;
			}
		}
	
		function setMemberObj() {
			
			console.log("set Member Obj");
			
			var address = getAddress();
			
			memberObj = { 
					userid: signUpForm.find("input[name='userid']").val(),
					username: signUpForm.find("input[name='username']").val(),
					password: signUpForm.find("input[name='password']").val(),
					confirmPassword: signUpForm.find("input[name='confirmPassword']").val(),
					nickname: signUpForm.find("input[name='nickname']").val(),
					phone: signUpForm.find("input[name='phone']").val(),
					email: signUpForm.find("input[name='email']").val(),
					address: address
				}
		}
		
		function getAddress() {
			console.log("Making Address...");
			if(!detailsAddress.val()) {
				return "";
			}
			return roadAddress.val() + detailsAddress.val() + extraRoadAddress.val();
		}
		
		function openAddressSearchWindow() {
			new daum.Postcode({
				oncomplete: function(data) {
					console.log(data);
					
					var roadAddr = data.roadAddress; // 도로명 주소 변수
		            var extraRoadAddr = ''; // 참고 항목 변수
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
					
	                // 우편 주소와 해당 필드 넣기
	                postCode.val(data.zonecode);
	                roadAddress.val(roadAddr+" ");
	                
	                if(roadAddr !== ''){
	                	extraRoadAddress.val(extraRoadAddr);
	                } else {
	                	extraRoadAddress.val("");
	                }
	                
	                // 혹시모르는 필수 주소 표시항목
	                console.log(data.bname);
	                console.log(data.bcode);
	                console.log(data.sido);
	                console.log(data.sigungu);
				}
			}).open();
		}
	});
	
</script>



<%@ include file="./includes/footer.jsp"%>