<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../includes/header.jsp"%>
    
<sec:authentication property="principal" var="pinfo"/>

<section class="section" >
	<div class="container">
		<div class="row">
			<%@ include file="../../includes/msg-Aside.jsp"%>
			<div class="bodyRow">
				<div class="bodyHeader">
					<button class="small-btn">답장</button>
					<button class="small-btn2">삭제</button>
					<button class="small-btn3">목록</button>
				</div>
				<div class="tableDiv"> <!-- 이상이 있으면 해당 div 제거 -->
					<table class="msg-table">
					 <tbody>
						<tr>
							<td style="width: 20%;">보낸사람</td>
							<td style="text-align: left;">${msg.sender }</td>
						</tr>
						<tr>
							<td style="width: 20%;">받은날짜</td>
							<td style="text-align: left;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${msg.sentdate }" /></td>
						</tr>
						<tr>
							<td style="width: 20%;">내용</td>
							<td style="text-align: left;">${msg.text }</td>
						</tr>
					 </tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</section>

<form class="objForm">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>

<script>
	
	$(document).ready(function() {
		
		var objForm = $(".objForm");
		var replyBtn = $(".small-btn");
		var removeBtn = $(".small-btn2");
		var listBtn = $(".small-btn3");
		
		var mno = '<c:out value="${msg.mno}" />';
		
		replyBtn.on("click", function(e) {
			
			objForm.append("<input type='hidden' name='mno' value='"+mno+"'>");
			objForm.attr("action", "/message/reply").submit();			
		})
	
		removeBtn.on("click", function(e) {
			e.preventDefault();
			
			if(confirm("삭제하시겠습니까?")){
				objForm.append("<input type='hidden' name='mno' value='"+mno+"'>");
				objForm.attr("action", "/message/removeReceivedMsg").attr("method", "post").submit();		
			}
		});
		
		listBtn.on("click", function(e) {
			e.preventDefault();
		
			self.location = "/message/receive/list";
		});
	})
	
</script>

<%@ include file="../../includes/footer.jsp"%>