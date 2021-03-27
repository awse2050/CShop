<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div class="container" style="border-bottom: 1px solid #dedede">
	<div class="index-category">
		<div class="index-category-div">
			<div class="index-category-child-div">
				<a href="/item/list">
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

<section class="section" style="padding: 0 0;">
	<div class="container">
		<div class="row">
			<div class="locationDiv">
				<h3>HOME > 패션 > 팝니다</h3>
				<!-- 현재위치 -->
			</div>
			<div class="lastUpdate">
				<span>마지막 업데이트 : <fmt:formatDate
						pattern="yyyy-MM-dd HH:mm:ss" value="${clothes.moddate }" />
				</span>
				<!-- 수정날짜 -->
			</div>
			<div class="sellerRow">
				<p class="sellerBox">판매자</p>
				<p class="seller">${clothes.writer }</p>
			</div>
			<div class="getBody">
				<div class="uploadResult imgBox">
					<!-- 대표이미지 -->
					<ul class="mainImg" style="border: 1px solid #999; padding: 40px 0;">
					</ul>
					<!-- 그외 썸네일 이미지 -->
					<ul class="thumbImg"style="padding: 15px 10px; text-align: left; display: flex; flex-wrap: wrap; ">
						
					</ul>
					<div class='bigPictureWrapper'>
						<div class='bigPicture'>
						</div>
					</div>
				</div>
				<!-- /. imgBox -->
				<div class="infoBox">
					<div class="infoBoxHead">
						<div class="detailsRow" style="text-align: right; font-size: 14px;">조회수: ${clothes.viewCnt }</div>
						<div class="detailsInfo">
							<div class="pName"> 상품명 : ${clothes.productName }</div>
							<div class="isTrade">교환가능 여부 : 불가</div>
							<div class="priceRow">
								<span>가격</span> <span>${clothes.price }</span>
							</div>
							<div class="countRow">
								<span>수량</span> <span>${clothes.count }</span>
							</div>
						</div>
					</div>
					<!-- 로그인한 사용자랑 일치할 경우 보여주게 처리함. -->
					<div class="infoBoxFoot">
						<button style="width: 45%; font-size: 17px; line-height: 54px; font-weight: 700;" id="modify">수정하기</button>
						<button style="width: 45%; font-size: 17px; line-height: 54px; font-weight: 700;" id="remove">삭제하기</button>
					</div>
<!-- 					<div class="infoBoxFoot">
						<button style="width: 45%; font-size: 17px; line-height: 54px; font-weight: 700;" >판매자에게 메세지 발송</button>
						<button style="width: 45%; font-size: 17px; line-height: 54px; font-weight: 700;">찜</button>
					</div> -->
				</div>
				<!-- /. infoBox -->
			</div>
		</div>
	</div>
</section>

<section class="section" style="padding-top: 40px">
	<div class="container">
		<div class="row" style="border-bottom: 1px solid #dedede">
			<h2 class="title">상세 정보</h2>
		</div>
		<div style="padding-top: 15px;">
		<!-- 	<div>*사이즈 :  <br/> *구성 :  <br/>  *퀄리티 : <br/>   *하자 : <br/>  </div> -->
			<div>${clothes.description }</div>
		</div>
	</div>
</section>

<form class="objForm">
	<input type="hidden" name="pageNum" value="${cri.pageNum }"> 
	<input type="hidden" name="amount" value="${cri.amount }"> 
	<input type="hidden" name="type" value="${cri.type }"> 
	<input type="hidden" name="keyword" value="${cri.keyword }"> 

</form>

<script>
	$(document).ready(function() {

		var objForm = $(".objForm");
		var removeBtn = $("#remove");
		var modifyBtn = $("#modify");
		
		var thumbImg = $(".thumbImg");
		var mainImg = $(".mainImg");
		
		(function() {
			var cno = '<c:out value="${clothes.cno}"/>';
			
			$.getJSON("/clothes/getAttachList", {cno : cno},function(arr) {
				console.log(arr);
				// 대표이미지
				var strUL = "";
				
				var strDiv = "";
				
				$.each(arr,function(i, obj) {
					if (obj.fileType) {
						var fileCallPath = encodeURIComponent(obj.uploadPath+ "/"+ obj.uuid+ "_"+ obj.fileName);
						
						if(i == 0) {
							strUL += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
							strUL += "<div><img src='/display?fileName="+ fileCallPath+ "' style='width: 100%; min-height: 400px; max-height: 400px' ></div></li>";
						}
						
						strDiv += "<li style='margin-right: 5px;' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						strDiv += "<div><img src='/display?fileName="+ fileCallPath+ "' style='width: 112px; height: 112px;' ></div></li>";
						
					} else {

						strDiv += "<li style='margin-right: 5px;' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						strDiv += "<div><span>"+ obj.fileName+ "</span><br/>";
						strDiv += "<img src='/resources/data/X.svg.png'></div></li>";
					}
				});
				
				$(".mainImg").html(strUL);
				$(".thumbImg").html(strDiv);
				
			});
		})();

		removeBtn.on("click", function(e) {
			e.preventDefault();

			console.log("remove click");

			objForm.append('<input type="hidden" name="cno" value="${clothes.cno}">');
			objForm.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">');
			objForm.attr("action","/clothes/remove").attr("method", "post");
			objForm.submit();

		});
		
		modifyBtn.on("click", function(e) {
			e.preventDefault();

			objForm.append('<input type="hidden" name="cno" value="${clothes.cno}">');
			objForm.attr("action","/clothes/modify").attr("method", "get");
			objForm.submit();
		})
		
		mainImg.on("click", "img" , function(e) {
			e.preventDefault();
			
			showImage($(this).attr('src'));
		});
		
		thumbImg.on("click", "img" , function(e) {
			e.preventDefault();
			var str = "";
			
			var liTag = $(this).closest("li");
			
			var uuid = liTag.data("uuid");
			var path = liTag.data("path");
			var filename = liTag.data("filename");
			var type = liTag.data("type");
			
			var fileCallPath = encodeURIComponent(path + "/" + uuid + "_" + filename);
			
			str += "<li data-path='"+path+"' data-uuid='"+uuid+"' data-filename='"+filename+"' data-type='"+type+"'>"
			str += "<div><img src='/display?fileName="+ fileCallPath+ "' style='width: 100%; min-height: 400px  max-height: 400px' ></div></li>";
			
			mainImg.html(str);
			
		});
		
		function showImage(fileCallPath){
		    
		    $(".bigPictureWrapper").css("display","flex").show();
		    
		    $(".bigPicture")
		    .html("<img src='"+fileCallPath+"' >")
		    .animate({width:'100%', height: '100%'}, 1000);
		    
		  }//end fileCallPath
		  
		$(".bigPictureWrapper").on("click", function(e){
		    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function(){
		      $('.bigPictureWrapper').hide();
		    }, 1000);
		  });//end bigWrapperClick event
		
		
	});
</script>

<%@ include file="../includes/footer.jsp"%>