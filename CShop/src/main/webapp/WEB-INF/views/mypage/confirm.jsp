<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<%@ include file="../includes/aside.jsp"%>
			<div class="bodyRow">
				<div class="bodyHeader">
					<div class="header-title">회원정보 확인</div>
					<div class="header-location" >
							HOME > 마이페이지 > 회원정보 확인
					</div>
				</div>
				<form class="confirmForm" style="text-align: center;">
					<div style="padding: 100px 0 40px 0px; font-weight: 700;" >
						<span>회원 확인을 위해 한번 더 입력해주세요.</span>
					</div>
					<div>
						<input class="confirmPw-input" type="password" name="password">
					</div>
					<div style="padding: 80px 0px;">
						<button class="myinfo-btn" id="confirm">확인</button>
						<button class="myinfo-btn2" id="cancel">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<script>

	$(document).ready(function() {
		var confirmForm = $(".confirmForm");
		var confirmBtn = $("#confirm");
		var cancelBtn = $("#cancel");
		
		confirmBtn.on("click", function(e) {
			e.preventDefault();
		
			var userid = '<c:out value="${myInfo.userid}" />'
			var pw = confirmForm.find("input[name='password']").val();

			if(!pw || pw.length == 0) {
				alert("패스워드를 입력하세요.");
				return false;
			}
			
			$.get("/mypage/pwConfirm/"+userid+"/"+pw, function(result) {
				if(result == "right") {
					self.location = "/mypage/myinfo";
				} else {
					alert("패스워드가 일치하지 않습니다.");
				}
			});
		});
		
		cancelBtn.on("click", function(e) {
			e.preventDefault();
		
			self.location = "/mypage/index";
		});
	});

</script>


<%@ include file="../includes/footer.jsp"%>