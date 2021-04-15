<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<div class="bodyHeader">
				<div class="header-title">아이디 찾기</div>
				<div class="header-location" >
						HOME > 아이디 찾기
				</div>
			</div>
 			<div class="findWrap">
				<div class="findForm-title">
					<h2>아이디 찾기</h2>
					<span >아이디를 찾으시려면 아래 내용을 제출하여 주세요.</span>
				</div>
				<form class="findForm" >
					<fieldset class="findField">
						<dl>
							<dt>이름</dt>
							<dd>
								<input type="text" name="username" style="border: 1px solid #c8c8c8; height: 20px;">
							</dd>
						</dl>
						<dl>
							<dt>이메일</dt>
							<dd>
								<input type="email" name="email" style="border: 1px solid #c8c8c8; height: 20px;">
							</dd>
						</dl>
					</fieldset>
					<div class="findWrap-button" >
						<button class="findId-btn" id="confirm">확인</button>
						<button class="findId-btn2" id="cancel">취소</button>
					</div>
				</form>
 			</div>			
		</div>
	</div>
</section>

<script>

	$(document).ready(function() {
		
	});

</script>

<%@ include file="./includes/footer.jsp"%>