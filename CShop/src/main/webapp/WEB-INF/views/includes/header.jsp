<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
  
<!DOCTYPE html>
<html lang="en">
<head>

  <!-- Basic Page Needs
  ================================================== -->
  <meta charset="utf-8">
  <title>CShop | E-commerce template</title>

  <!-- Mobile Specific Metas
  ================================================== -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Construction Html5 Template">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
  <meta name="author" content="Themefisher">
  <meta name="generator" content="Themefisher Constra HTML Template v1.0">
  
  <!-- JQuery -->
  <script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
  <!-- Favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="/resources/images/favicon.png" />
  <!-- icon -->
  <script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
  <!-- Themefisher Icon font -->
  <link rel="stylesheet" href="/resources/plugins/themefisher-font/style.css">
  <!-- bootstrap.min css -->
  <link rel="stylesheet" href="/resources/plugins/bootstrap/css/bootstrap.min.css?ver=2">
  
  <!-- Animate css -->
  <link rel="stylesheet" href="/resources/plugins/animate/animate.css">
  <!-- Slick Carousel -->
  <link rel="stylesheet" href="/resources/plugins/slick/slick.css">
  <link rel="stylesheet" href="/resources/plugins/slick/slick-theme.css">
  
  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="/resources/css/style.css?ver=2">
  <!-- CShop  Stylesheet -->
  <link rel="stylesheet" href="/resources/css/cshop.css?ver=3">
  
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" data-auto-replace-svg="nest"></script>

</head>

<body id="body">

<!-- Start Top Header Bar -->
<section class="top-header">
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-xs-12 col-sm-4">
				<div class="contact-number">
					<i class="tf-ion-ios-telephone"></i>
					<span>010.3194.3287</span>
				</div>
			</div>
			<div class="col-md-4 col-xs-12 col-sm-4">
				<!-- Site Logo -->
				<div class="logo text-center">
					<a href="/index">
						<!-- replace logo here -->
						<svg width="135px" height="29px" viewBox="0 0 155 29" version="1.1" xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink">
							<g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" font-size="40"
								font-family="AustinBold, Austin" font-weight="bold">
								<g id="Group" transform="translate(-108.000000, -297.000000)" fill="#000000">
									<text id="AVIATO">
										<tspan x="108.94" y="325">CSHOP</tspan>
									</text>
								</g>
							</g>
						</svg>
					</a>
				</div>
			</div>
			<div class="col-md-4 col-xs-12 col-sm-4">
				<!-- Cart -->
				<ul class="top-menu text-right list-inline">
					<li>
						<a href="/notice/list">
						공지사항
						</a>
					</li>
					<sec:authorize access="isAuthenticated()">
						<li>
							<a href="/like">
							찜리스트
							</a>
						</li>
					</sec:authorize>
					<li>
						<sec:authorize access="isAnonymous()">
							<a class="loginBtn" href="/loginPage">
							로그인
							</a>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<%-- <sec:authentication property="principal.vo.username"/>님 환영합니다. --%>
							<a href="/mypage/index">
								마이페이지
							</a>
						</sec:authorize>
					</li>				
					<sec:authorize access="isAuthenticated()">
					<li>
						<form class="logoutForm" action='/logout' method='post'>
							<a class="logoutBtn" href="/logout">로그아웃</a>
							<input type='hidden' name='${_csrf.parameterName }' value='${_csrf.token }'>
						</form>
					</li>
					</sec:authorize>	
				</ul><!-- / .nav .navbar-nav .navbar-right -->
			</div>
		</div> <!-- /.row  -->
		<div class="goods-add-btn">
			<button class="addBtn"><i class="fas fa-plus-circle" style="padding-right:3px"></i> 물품등록</button>
		</div>
	</div>
</section><!-- End Top Header Bar -->

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

<!-- Main Menu Section -->
<script>

	$(document).ready(function() {
		
		var loginModal = $("#loginModal");
		var logoutBtn = $(".logoutBtn");
		var addBtn = $(".addBtn");
		var loginUserid = null;
		
		<sec:authorize access="isAuthenticated()">
		 	loginUserid = '<sec:authentication property="principal.username" />';
		</sec:authorize>
		
		logoutBtn.on("click", function(e) {
			e.preventDefault();
			
			$(".logoutForm").submit();
			
		});
		
		addBtn.on("click", function(e) {
			e.preventDefault();
		
			if(!loginUserid) {
				alert("권한이 없습니다. 로그인을 해주세요.");
				self.location="/loginPage";
			} else {
				self.location="/clothes/register";
			}
		});
	});

</script>
