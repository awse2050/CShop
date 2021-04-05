<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<sec:authentication property="principal" var="pinfo"/>

<section class="section" >
	<div class="container">
		<div class="row">
			<%@ include file="../includes/msg-Aside.jsp"%>
			<div class="bodyRow">
				<div class="bodyHeader">
					<button class="small-btn">보내기</button>
					<button class="small-btn2">취소</button>
				</div>
				<div class="tableDiv" style="margin-top: 20px; border-top: 1px solid #e8e8e8;"> 
					<form class="replyForm">
						<table class="msg-table">
						 <tbody>
							<tr>
								<td style="width: 20%;">받는사람</td>
								<td style="text-align: left; padding-left: 5px;" >${msg.sender }</td>
							</tr>
							<tr>
								<td class="required" style="width: 20%;">내용</td>
								<td>
								<!-- 높이 직접변경 -->
									<textarea class="msg-input" type="text" name="text" style="height: 300px;"></textarea>
								</td>
							</tr>
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
						 </tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<form class="objForm">

</form>

<script> 

	$(document).ready(function() {
		var sendBtn = $(".small-btn");
		var backBtn = $(".small-btn2");
		var replyForm = $(".replyForm");
		var objForm = $(".objForm");
		var loginUser = '<sec:authentication property="principal.username" />'
		var receiver = '<c:out value="${msg.receiver}" />';
		var sender = '<c:out value="${msg.sender}" />';
		
		sendBtn.on("click", function(e) {
			e.preventDefault();
			
			replyForm.append("<input type='hidden' name='receiver' value='"+sender+"'>");
			replyForm.append("<input type='hidden' name='sender' value='"+loginUser+"'>")
			replyForm.attr("action", "/message/reply").attr("method", "post").submit();
		})
		
		backBtn.on("click", function(e) {
			e.preventDefault();
			var mno = '<c:out value="${msg.mno}"/>';
			
			objForm.append("<input type='hidden' name='mno' value='"+mno+"'>");
			objForm.attr("action", "/message/receive/get").submit();
		})
	});
	
</script>

<%@ include file="../includes/footer.jsp"%>