<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<%@ include file="../includes/aside.jsp"%>
			<div class="bodyRow">
				<header style="width:100%; border:1px solid #ccc; height:135px;">
					<div class="profile">
						<div class="profile_img" style="width: 75px; height: 75px; margin: 30px 30px 0; float: left;">
							<img src='/resources/images/noimage.png' style="width: 100%;">
						</div>
						<div class="profile_text" style="margin-top:30px; float: left;">
							<p style="font-size:18px; color: #000; magrin-bottom: 10px;">
								<sec:authentication property="principal.vo.username" />	님
							</p>
							<p style="font-size: 13px; color:#666; margin-bottom: 15px;">
								<sec:authentication property="principal.username" />	
							</p>
						</div>
					</div>
					<div class="new_message" style="float: right; text-align:center; margin: 60px 30px;" >
						<a href="/message/receive/list">
							<i class="fas fa-sms"></i>
							새로운 메세지 0통
						</a>
					</div>
				</header>
				
				<h2><i class="fas fa-user-check"></i>판매</h2>
				<section style="border: 3px solid #e8e8e8; width: 100%;">
					<!-- css에서 배경이미지 추후 넣을 것. -->
					<a href="/mypage/goods" class="admin_cat 01">
						판매관리
						<img src="/resources/images/sale.png">
					</a>
					<a href="/message/receive/list" class="admin_cat 02">
						메세지 관리
						<img src="/resources/images/message.png">
					</a>
				</section>
			</div>
		</div>
	</div>
</section>

<%@ include file="../includes/footer.jsp"%>