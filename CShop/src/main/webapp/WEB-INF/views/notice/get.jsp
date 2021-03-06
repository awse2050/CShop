<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp"%>

<section class="product-category section">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="title getTitle">
					<div>공지사항</div>
				</div>
			</div>
			<div class="">
				<div class="getHeader">
					<div>
						<c:out value="${notice.title }" />
					</div>
					<ul>
						<li>이름 : <c:out value="${notice.writer }" /> </li>
						<li>등록일 : <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${notice.regdate }"/> </li>
						<li>조회수 : <c:out value="${notice.viewCnt }" /> </li>
					</ul>
				</div>
			</div>
			<div class="getContent">
				<c:out value="${notice.content }" />
			</div>
			<div class="getFooter">
				<div style="border-bottom: 1px solid #dedede; height: 25px;"></div>
			
				<div class="footerBtn">
					<button class="subBtn customBtn" data-oper="list" >목록</button>
				</div>
			</div>
		</div>
	</div>
</section>	
				
		
<form class="subForm">
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" value="${cri.amount }">
	<input type="hidden" name="type" value="${cri.type }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
</form>		
		
<script>

	$(document).ready(function() {
		
		(function() {
			var nno = "${notice.nno}";
			
			$.getJSON("/notice/getAttachList", {nno: nno}, function(result) {
				
				var str = "";
				
				$(result).each(function(i, obj) {
					if(obj.fileType) {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						str += "<div><img src='/display?fileName="+fileCallPath+"'></div>";
					}
				});
				$(".getContent").append(str);
				
			})
		})();
		
		var subForm = $(".subForm");
		var subBtn = $('.subBtn');
		
		subBtn.on("click", function(e) {
			e.preventDefault();
			
			var oper = $(this).data("oper");
			
			if(oper === "list") {
				subForm.attr("action", "/notice/list");
				subForm.submit();
			}
		})
	})

</script>

<%@ include file="../includes/footer.jsp"%>