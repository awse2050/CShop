<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>


<h2> get .jsp..</h2>
		
		<div>
			<input type='text' name='nno' value="${notice.nno }"  readonly="readonly">
		</div>
		<div>
			<input type='text' name='title' value="${notice.title }"  readonly="readonly">
		</div>
		<div>
			<input type='text' name='content' value="${notice.content }"  readonly="readonly">
		</div>
		<div>
			<input type='text' name='writer' value="${notice.writer }" readonly="readonly">
		</div>
		
		<button class="subBtn" data-oper="modify" >수정</button>
		<button class="subBtn"  data-oper="list" >목록</button>
		
		
<form class="subForm">
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" value="${cri.amount }">
	<input type="hidden" name="type" value="${cri.type }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
</form>		
		
<script>

	$(document).ready(function() {
		var subForm = $(".subForm");
		var subBtn = $('.subBtn');
		
		subBtn.on("click", function(e) {
			e.preventDefault();
			
			var oper = $(this).data("oper");
			console.log(oper);
			
			if(oper === "modify") {
				subForm.append("<input type='text' name='nno' value='${notice.nno }'>");
				subForm.attr("action", "/notice/modify")
				subForm.submit();
				
			} else if(oper === "list") {
				subForm.attr("action", "/notice/list");
				subForm.submit();
			}
			
		})
		
		
		
		
	})
	


</script>

</body>
</html>