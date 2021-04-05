<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../includes/header.jsp"%>

<section class="section" >
	<div class="container">
		<div class="row">
			<%@ include file="../../includes/msg-Aside.jsp"%>
			<div class="bodyRow">
				<div class="bodyHeader">
					<div class="header-title">
						보낸 메세지
					</div>
					<div class="header-location">
						HOME > 마이페이지 > 메세지 관리 > 보낸 메세지
					</div>
				</div>
				<div class="tableDiv"> <!-- 이상이 있으면 해당 div 제거 -->
					<table class="msg-table">
						<thead>
							<tr>
								<th style="width: 15%;">받은사람</th>
								<th class="thText" style="border-left: 1px solid #e8e8e8; border-right: 1px solid #e8e8e8;">내용</th>
								<th style="width: 25%;">보낸날짜</th>
							</tr> 
						</thead>
						<c:forEach items="${sentMsg }" var="msg">
							<tbody class="msgBody">
								<tr class="trMsg">
									<input type="hidden" name="mno" value="${msg.mno }">
									<td>${msg.receiver }</td>
									<td style="text-align: left; padding-left: 5px;">
										<a href="${msg.mno }" class="read">${msg.text }</a>
									</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${msg.sentdate }"/></td>
								</tr>
							</tbody>
						</c:forEach>
					</table> 
				</div>
			</div>		
		</div>
	</div>
</section>

<form class="objForm">
	
</form>

<script>

	$(document).ready(function() {
		var readBtn = $(".read");
		var objForm = $(".objForm");
		
		readBtn.on("click", function(e) {
			e.preventDefault();
			var mno = $(this).attr("href");
			
			objForm.append("<input type='hidden' name='mno' value='"+mno+"'>");
			objForm.attr("action", "/message/sent/get").submit();
		})
	})

</script>

<%@ include file="../../includes/footer.jsp"%>
			