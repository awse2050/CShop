<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp"%>

<section class="section" style="padding:20px 0px;">
	<div class="container">
		<div class="row">
			<!-- <div style="text-align: center;">
			  +이미지.
				<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDA3MTBfNjAg%2FMDAxNTk0MzYyMTgxMDA5.B9ywGytTEKcRnmPvjlHdOPgDk-GaQjAOUI3TFvRpITog.fsNX9J3JEnEbok0gP44cfTAZ0xtqToURwJnxtVnG9Mog.JPEG.wsw6088%2FIMG_3850.JPG&type=sc960_832">
				<div style="font-size: 24px; font-weight: 700;"> 로그인 이후 이용할 수 있습니다. </div>
			</div> -->
			
			<div class="signUp-header">
				<div class="header-title">
					찜리스트
				</div>
				<div style="float: right; font-size: 12px; font-weight: 700;">
					HOME > 찜리스트
				</div>
			</div>
			
			<div style="border: 5px solid #e8e8e8; margin:30px 0px;">
				<div style="padding: 25px;">
					xxx 님은 [일반회원] 입니다.
				</div>
			</div>
		
			<div>
				<table class="like-table">
					<thead>
						<tr>
							 <th style="width: 10%;">번호</th>
							<th>상품정보</th>
							<th style="width: 10%;">판매가</th>
							<th style="width: 10%;">선택</th> 
						</tr>
					</thead>
					<tbody class="likeBody">
				
					</tbody>
				</table>
			</div> 
		</div>
	</div>
</section>
		
<form class="objForm">
	<input type="hidden" name="cno" >
</form>		
		
<script>

	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		(function() {
			
			$.getJSON("/like/admin44", function(list) {
				var str = "";
				
				
				if(list.length == 0) {
					console.log("No Like List");
					
					return false;
				}
				
				var likeBody = $(".likeBody");
				
		 		$.each(list, function(i, obj) {
					var fileCallPath = encodeURIComponent(obj.thumbnailUrl);
					/*  data-user => 로그인한 유저로 변경 */
					str += "<tr data-cno='"+obj.cno+"' data-user='admin44'>";
					str += "<td>"+obj.cno+"</td>";
					str += "<td style='text-align:left;'>"
					str += "<a href='"+obj.cno+"'><img src='/display?fileName="+obj.thumbnailUrl+"'></a>"; 
					str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					str += "<td>"+obj.price+"원</td>";
					str += "<td><button class='small-btn'>삭제</button></td>";
					str += "</tr>"
				});
				
				likeBody.html(str); 
			})
			
		})();
		
		var objForm = $(".objForm");
		var likeBody = $(".likeBody");
		
		likeBody.on("click", "button", function(e) {
			e.preventDefault();
			
			var trTag = $(this).closest("tr");
			var cno = trTag.data("cno");
			var userid = trTag.data("user");
			console.log(cno);
			console.log(userid);
			
			if(confirm("찜목록에서 삭제하겠습니까?")) {
				$.ajax({
					type: 'delete',
					url: '/like/'+cno+"/"+userid,
					contentType: "application/json; charset=utf-8",
					success: function(msg) {
						console.log(msg);
						trTag.remove();
					}
				});
			}
		});
		
		likeBody.on("click", "a", function(e) {
			e.preventDefault();
			var cno = $(this).attr("href");
			
			objForm.find("input[name='cno']").val(cno)
			objForm.attr("action", "/clothes/get").submit();
		});
		
		
	});
	
</script>
		
<%@ include file="./includes/footer.jsp"%>