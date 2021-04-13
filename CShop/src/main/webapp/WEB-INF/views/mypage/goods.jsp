<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section" >
	<div class="container">
		<div class="row">
			<%@ include file="../includes/aside.jsp"%>
			<div class="bodyRow">
					<!-- 검색 -->
				<!-- <div style="border: 5px solid #e8e8e8; margin:30px 0px;">
					<div style="padding: 25px;">
					</div>
				</div> -->
				<div class="bodyHeader">
					<div class="header-title">
						상품목록
					</div>
					<div class="header-location">
						HOME > 마이페이지 > 상품목록
					</div>
				</div>
				<div class="tableDiv"> <!-- 이상이 있으면 해당 div 제거 -->
					<table class="like-table">
						<thead>
							<tr>
								 <th style="width: 10%;">번호</th>
								<th>상품정보</th>
								<th style="width: 10%;">판매가</th>
								<th style="width: 20%;">선택</th> 
							</tr>
						</thead>
						<tbody class="likeBody">
							
						</tbody>
					</table>
				</div>
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
			
			var userid = '<sec:authentication property="principal.username" />';
			var likeBody = $(".likeBody");
			var tableDiv = $(".tableDiv");
			
			$.getJSON("/mypage/goods/"+userid, function(list) {
				var str = "";
				
				if(list.length == 0 ) {
					str += "<div style='text-align: center;'>";
					str += "<img src='/resources/images/accessError.jpg'>"
					str += "<div style='font-size: 24px; font-weight: 700;'> 등록하신 게시물이 없습니다. </div>";
					
					tableDiv.html(str);
					return false;
				}
				
				$.each(list, function(i, obj) {
					
					str += "<tr data-cno='"+obj.cno+"' data-user='"+userid+"'>";
					str += "<td>"+obj.cno+"</td>";
					str += "<td style='text-align:left;'>"
					if(obj.thumbnailUrl == null) {
						str += "<a href='"+obj.cno+"'><img style='width:100px; height: 100px;' src='/resources/images/noimage.png'></a>"; 
						str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					} else {
						str += "<a href='"+obj.cno+"'><img style='width:100px; height: 100px;' src='"+obj.thumbnailUrl+"'></a>"; 
						str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					}
					str += "<td>"+obj.price+"원</td>";
					str += "<td>";
					str += "<button class='small-btn' style='margin-right: 5px;' data-oper='modify'>수정</button>"
					str += "<button class='small-btn2' data-oper='remove'>삭제</button>"
					str += "</td>";
					str += "</tr>"
				});
				
				likeBody.html(str); 
			});
		})(); 
				
		var imgTag = $(".imgTag");
		var objForm = $(".objForm");
		
		var likeBody = $(".likeBody");
		
		likeBody.on("click", "button", function(e) {
			e.preventDefault();
			var oper = $(this).data("oper");
			var parentTr = $(this).closest("tr");
			var cno = parentTr.data("cno");
			var writer = '<sec:authentication property="principal.username"/>';
			
			if(oper == "modify") {
				
				objForm.find("input[name='cno']").val(cno);
				objForm.attr("action", "/clothes/modify").submit();
				
			} else if(oper == "remove") {

				if(confirm("지우시겠습니까?")) {
					objForm.find("input[name='cno']").val(cno);
					objForm.append("<input type='hidden' name='writer' value='"+writer+"'>");
					objForm.append("<input type='hidden' name='requestUri' value='/mypage/goods'>");
					objForm.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">');
					objForm.attr("action","/clothes/remove").attr("method", "post");
					objForm.submit();
				}
			}
		});
		
		likeBody.on("click", "a", function(e) {
			e.preventDefault();
		
			var cno = $(this).attr("href");
			
			objForm.find("input[name='cno']").val(cno);
			objForm.attr("action", "/clothes/get").submit();
		});
	});
	
</script>

<%@ include file="../includes/footer.jsp"%>
			