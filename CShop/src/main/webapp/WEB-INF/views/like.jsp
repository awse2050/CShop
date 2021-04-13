<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<div class="bodyHeader">
				<div class="header-title">
					찜리스트
				</div>
				<div class="header-location">
					HOME > 찜리스트
				</div>
			</div>
			
			<div style="border: 5px solid #e8e8e8; margin:30px 0px;">
				<div style="padding: 25px;">
					<sec:authentication property="principal.vo.username" /> 님은 [일반회원] 입니다.
				</div>
			</div>
		
			<div class="tableDiv">
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
			
			var tableDiv = $(".tableDiv");
			var likeBody = $(".likeBody");
			
			var userid = "<sec:authentication property='principal.username'/>";
			
			$.getJSON("/like/"+userid, function(list) {
				var str = "";
				
				if(list.length == 0) {
					str += "<div style='text-align: center;'>";
					str += "<img src='/resources/images/accessError.jpg'>"
					str += "<div style='font-size: 24px; font-weight: 700;'> 찜하신 게시물이 없습니다. </div>";
					
					tableDiv.html(str);
					return false;
				}
				
		 		$.each(list, function(i, obj) {
					str += "<tr data-cno='"+obj.cno+"'>";
					str += "<td>"+obj.cno+"</td>";
					str += "<td style='text-align:left;'>"
					if(obj.thumbnailUrl == null) {
						str += "<a href='"+obj.cno+"'><img style='width: 100px; height: 100px;' src='/resources/images/noimage.png'></a>";
						str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					} else {
						str += "<a href='"+obj.cno+"'><img style='width: 100px; height: 100px;' src='"+obj.thumbnailUrl+"'></a>"; 
						str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					}
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
			var userid = "<sec:authentication property='principal.username'/>";
			
			if(confirm("찜목록에서 삭제하겠습니까?")) {
				$.ajax({
					type: 'delete',
					url: '/like/'+cno+"/"+userid,
					contentType: "application/json; charset=utf-8",
					success: function(msg) {
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