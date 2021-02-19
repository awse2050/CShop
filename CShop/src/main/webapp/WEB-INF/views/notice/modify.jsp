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

<h2> modfiy .jsp..</h2>
<div>
	<form class="subForm">
		<div>
			<input type='text' name='nno' value="${notice.nno }"  readonly="readonly">
		</div>
		<div>
			<input type='text' name='title' value="${notice.title }" >
		</div>
		<div>
			<input type='text' name='content' value="${notice.content }"  >
		</div>
		<div>
			<input type='text' name='writer' value="${notice.writer }" readonly="readonly">
		</div>
	</form>
	
		<button class="subBtn" data-oper="modify" >변경</button>
		<button class="subBtn" data-oper="remove" >삭제</button>
		<button class="subBtn"  data-oper="list" >목록</button>
</div>
		
<form class="objForm">
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" value="${cri.amount }">
	<input type="hidden" name="type" value="${cri.type }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
</form>		

<script>
	
	$(document).ready(function() {
		
		var subBtn = $(".subBtn");
		var objForm = $(".objForm");
		var subForm = $(".subForm");
		
		
		subBtn.on("click", function(e) {
			e.preventDefault();
			
			var oper = $(this).data("oper");
			
			if(oper === "modify") {
				subForm.append(objForm.html());
				subForm.attr("action", "/notice/modify").attr("method", "post");
				subForm.submit();
			} else if(oper === "remove" ) {
				objForm.append('<input type="hidden" name="nno" value="${notice.nno }">');
				objForm.attr("action" , "/notice/remove").attr("method", "post");
				objForm.submit();
				
			} else if(oper === "list") {
				objForm.attr("action", "/notice/list");
				objForm.submit();
			}
		})
	})

</script>



</body>
</html>