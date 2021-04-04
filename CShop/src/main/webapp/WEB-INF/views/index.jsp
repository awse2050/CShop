<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@ include file="./includes/index-Header.jsp"  %>
	
<section class="product-category section">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="title text-center">
					<h2>Category</h2>
				</div>
			</div>
			<div class="index-category">
				<div class="index-category-div">
					<div class="index-category-child-div">
						<a href="/clothes/list">
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<h3>패션</h3>
							</div>
						</a>	
					</div>
					<div class="index-category-child-div">
						<a href="/mobile/list">
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<h3>휴대폰/통신</h3>
							</div>
						</a>	
					</div>
					<div class="index-category-child-div">
						<a href="/office/list">
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<h3>사무용품</h3>
							</div>
						</a>	
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

	<%@ include file="./includes/footer.jsp"  %>

