<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<div class="bodyHeader">
				<div class="header-title">비밀번호 찾기</div>
				<div class="header-location" >
						HOME > 비밀번호 찾기
				</div>
			</div>
 			<div class="findWrap">
				<div class="findForm-title">
					<h2>비밀번호 찾기</h2>
					<span >비밀번호를 찾으시려면 아래 내용을 제출하여 주세요.</span>
				</div>
				<form class="findForm" >
					<fieldset class="findField">
						<dl>
							<dt>사용자 이름</dt>
							<dd>
								<input type="text" name="username" style="border: 1px solid #c8c8c8; height: 25px;">
							</dd>
						</dl>
						<dl>
							<dt>아이디</dt>
							<dd>
								<input type="text" name="userid" style="border: 1px solid #c8c8c8; height: 25px;">
							</dd>
						</dl>
						<dl>
							<dt>이메일</dt>
							<dd>
								<input type="email" name="email" style="border: 1px solid #c8c8c8; height: 25px;">
							</dd>
						</dl>
					</fieldset>
					<div class="findWrap-button">
						<button class="find-btn" id="confirm">확인</button>
						<button class="find-btn2" id="cancel">취소</button>
					</div>
				</form>
 			</div>			
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
		
		var findForm = $(".findForm");
		var confirm = $("#confirm");
		var cancel = $("#cancel");
		
		confirm.on("click", function(e) {
			e.preventDefault();
			
			var userid = findForm.find("input[name='userid']").val();
			var username = findForm.find("input[name='username']").val();
			var email = findForm.find("input[name='email']").val();
			
			$.get("/verifyPw/"+userid+"/"+username+"/"+email, function(result) {
				if(result) {
					alert("등록하신 이메일로 변경된 비밀번호를 발송했습니다.");
					self.location = "/index";
				} else {
					alert("잘못 입력하였습니다. 정확하게 입력하세요.");
				}
			});
		});
		
		cancel.on("click", function(e) {
			e.preventDefault();
			self.location = "/index";
		});
	});

</script>

<%@ include file="./includes/footer.jsp"%>