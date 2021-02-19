<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
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
  <link rel="stylesheet" href="/resources/css/cshop.css?ver=2">

</head>

<body id="body">

<!-- Start Top Header Bar -->
<section class="top-header">
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-xs-12 col-sm-4">
				<div class="contact-number">
					<i class="tf-ion-ios-telephone"></i>
					<span>0129- 12323-123123</span>
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
										<tspan x="108.94" y="325">AVIATO</tspan>
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
					<a class="loginBtn" href="">
					로그인
					</a>
					</li>					

				</ul><!-- / .nav .navbar-nav .navbar-right -->
			</div>
		</div>

	</div>
</section><!-- End Top Header Bar -->

<div id="loginModal" class="modal" tabindex="-1" role="dialog" style="text-align: center;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">로그인</h3>
      </div>
      <div class="modal-body">
        <div class="form-group">
        	<input class="form-control" style="height: 50px; padding: 6px 25px" placeholder="아이디">
        </div>
        <div class="form-group">
        	<input class="form-control" style="height: 50px; padding: 6px 25px" placeholder="비밀번호">
        </div>
      </div>
      <div class="modal-footer" style="height: 75px; padding: 15px 100px;">
        <button type="button" class="btn btn-primary" style="width: 100%; height: 100%; margin:0px auto; padding-left: 55px; padding-right: 55px">로그인</button>
      </div>
      <div class="modal-footer">
		<h4> 회원가입 | 아이디/비밀번호 찾기</h4>      
      </div>
    </div>
  </div>
</div>

<!-- Main Menu Section -->
<script>

	$(document).ready(function() {
		
		var loginModal = $("#loginModal");
		var loginBtn = $(".loginBtn");
		
		loginBtn.on("click", function(e) {
			e.preventDefault();
			
			console.log("click");
			
			loginModal.modal("show");
		
		})
		
		
	})
	

</script>
