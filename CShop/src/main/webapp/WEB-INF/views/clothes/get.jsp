<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div class="container" style="border-bottom: 1px solid #dedede">
	<div class="index-category">
		<div class="index-category-div">
			<div class="index-category-child-div">
				<a href="/item/list"> 
					<div>
						<h3  style="font-weight: 700; font-size: 15px; color: #555;">패션</h3>
					</div>
				</a>	
			</div>
			<div class="index-category-child-div">
				<a href="/mobile/list"> 
					<div >
						<h3 style="font-weight: 700; font-size: 15px; color: #555;">휴대폰/통신</h3>
					</div>
				</a>	
			</div>
			<div class="index-category-child-div">
				<a href="/office/list">	
					<div>
						<h3  style="font-weight: 700; font-size: 15px; color: #555;">사무용품</h3>
					</div>
				</a>	
			</div>
		</div>
	</div>
</div>

<section class="section" style="padding:0 0;">
	<div class="container">
		<div class="row"> 
			<div class="locationDiv">
				<h3>HOME > 패션 > 팝니다</h3> <!-- 현재위치 -->
			</div>
			<div class="lastUpdate">
				<span>마지막 업데이트 : <fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${clothes.moddate }" /> </span> <!-- 수정날짜 -->
			</div>
			<div class="sellerRow">
				<p class="sellerBox">판매자</p>
				<p class="seller">${clothes.writer }</p>
			</div>
			<div style="display: flex; flex:1; flex-direction: row;  ">
				<div class="uploadResult imgBox" style="width:50%; min-height: 600px; text-align: center;">
					<ul style="border: 1px solid #999">
					</ul>
					<div style="padding-top: 15px;">
						<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>						
					</div>
				</div>
				<div class="infoBox" style="width:50%; min-height: 600px;">
					<div class="pName">
						${clothes.productName }					
					</div>
					<div class="isTrade">
						 교환가능 여부 : 불가
					</div>
					<div class="priceRow">
						<span>가격</span>
						<span>${clothes.price }</span>
					</div>
					<div class="countRow">
						<span>수량</span>
						<span>${clothes.count }</span>
					</div>
					
				</div>	
			</div>
		</div>
	</div>
</section>

<section class="section" style="padding-top:40px">
	<div class="container" >
		<div class="row" style="border-bottom: 1px solid #dedede"> 
			<h2> 상세 정보 </h2>
		</div>
		<div style="padding-top: 15px;">
			<div>
			 	${clothes.description }
			</div>
		</div>
	</div>
</section>

<script>

	$(document).ready(function() {
		
		(function() {
			var cno = '<c:out value="${clothes.cno}"/>';
			
			
			$.getJSON("/clothes/getAttachList", {cno: cno}, function(arr) {
				console.log(arr);
				var str = "";
				
				$.each(arr, function(i, obj) {
					if(obj.fileType) {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						str += "<div><img src='/display?fileName="+fileCallPath+"' style='width: 90%; min-height: 400px' ></div></li>";
						
					} else {
						
						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						str += "<div><span>"+obj.fileName+"</span><br/>";
						str += "<img src='/resources/data/X.svg.png'></div></li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})();
		
	});

</script>







<%@ include file="../includes/footer.jsp"%>