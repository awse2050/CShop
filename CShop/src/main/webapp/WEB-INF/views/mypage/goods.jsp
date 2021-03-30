<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section" >
	<div class="container">
		<div class="row">
			<%@ include file="../includes/aside.jsp"%>
			
			<div class="bodyRow">
				<!-- <div style="border: 5px solid #e8e8e8; margin:30px 0px;">
					<div style="padding: 25px;">
						
					</div>
				</div> -->
				<div class="tableDiv"> <!-- 이상이 있으면 해당 div 제거 -->
					<c:if test="${empty list }">
						 <div style="text-align: center;">
							<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDA3MTBfNjAg%2FMDAxNTk0MzYyMTgxMDA5.B9ywGytTEKcRnmPvjlHdOPgDk-GaQjAOUI3TFvRpITog.fsNX9J3JEnEbok0gP44cfTAZ0xtqToURwJnxtVnG9Mog.JPEG.wsw6088%2FIMG_3850.JPG&type=sc960_832">
							<div style="font-size: 24px; font-weight: 700;"> 등록하신 상품이 없습니다. </div>
						</div> 
					</c:if>
					<c:if test="${!empty list }">
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
								<c:forEach items="${list }" var="list">
									<tr data-cno="${list.cno }" data-user="${list.writer }">
										<td>${list.cno }</td>			
										<td style='text-align: left;'>
											<a href="${list.cno }">
												<img src="/display?fileName=${list.thumbnailUrl }">
											</a>
											<span style="margin-left: 15px; font-weight: 700;">상품명 : ${list.productName }</span>
										</td>
										<td>${list.price }</td>
										<td>
											<button class="small-btn" style="margin-right: 5px;">수정</button>
											<button class="small-btn2">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
			</div>		
		</div>
	</div>
</section>

<script>
	
	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		 (function() {
			
			var userid = "hide";
			var likeBody = $(".likeBody");
			
			$.getJSON("/clothes/goods/"+userid, function(list) {
				console.log(list);
				if(list.length == 0 ) {
					console.log("No Goods");
					return false;
				}
				
				var str = "";
				
				$.each(list, function(i, obj) {
					var fileCallPath = encodeURIComponent(obj.thumbnailUrl);
					/*  data-user => 로그인한 유저로 변경 */
					str += "<tr data-cno='"+obj.cno+"' data-user='"+userid+"'>";
					str += "<td>"+obj.cno+"</td>";
					str += "<td style='text-align:left;'>"
					str += "<a href='"+obj.cno+"'><img src='/display?fileName="+obj.thumbnailUrl+"'></a>"; 
					str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					str += "<td>"+obj.price+"원</td>";
					str += "<td>";
					str += "<button class='small-btn' style='margin-right: 5px;'>수정</button>"
					str += "<button class='small-btn2'>삭제</button>"
					str += "</td>";
					str += "</tr>"
				});
				
				//likeBody.html(str); 
			});
		})(); 
		
		
		
		
		
	});
	
</script>
		

<%@ include file="../includes/footer.jsp"%>
			