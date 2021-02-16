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



	<h2> notice  Page .. </h2>
	<table>
		<ul>
			<c:forEach items="${list }" var="list" >
				<li>${list.nno } </li>
				<!-- 사진으로 대체 -->
				<li><a class="getBtn" href="${list.nno }">${list.title }</a></li>
				<li>${list.content } </li>
				<li>${list.writer } </li>
				<li><fmt:formatDate  pattern="yyyy-MM-dd" value="${list.moddate }"/></li>
			</c:forEach>
		</ul>
	</table>
	
	<div>
		<ul>
			<c:if test="${pageMaker.prev }">
				<li><a class="pageBtn" href="${pageMaker.startPage - 1 }">prev</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
				<li><a class="pageBtn" href="${num }" > ${num }</a></li>					
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<li><a class="pageBtn" href="${pageMaker.endPage+1 }">next</a></li>
			</c:if>
		</ul>
	</div>

	<form class="searchForm" action="/notice/list">
		<select name="type">
			<option value="t">제목</option>
			<option value="c">내용</option>
			<option value="w">작성자</option>
			<input type='text' name='keyword'>
			<button class="searchBtn">검색하기</button>
			<input type='hidden' name='pageNum' value="${pageMaker.cri.pageNum }">
			<input type='hidden' name='amount' value="${pageMaker.cri.amount }">
		</select>
	</form>
		
	
<form class="moveForm">
	<input type='hidden' name='pageNum' value="${pageMaker.cri.pageNum }">
	<input type='hidden' name='amount' value="${pageMaker.cri.amount }">

</form>

<script>

	$(document).ready(function() {
		
		var getBtn = $(".getBtn");
		var moveForm = $(".moveForm");
		var pageBtn = $(".pageBtn");
		var searchForm = $(".searchForm");
		var searchBtn = $(".searchBtn");
		
		getBtn.on("click", function(e) {
			e.preventDefault();
			
			var nno = $(this).attr("href");
			
			moveForm.append("<input type='hidden' name='nno' value='"+nno+"'>");
			moveForm.attr("action", "/notice/get");
			moveForm.submit();
		})
		
		pageBtn.on("click", function(e) {
			e.preventDefault();
	
			var page = $(this).attr("href");
			console.log(page);
			
			moveForm.find("input[name='pageNum']").val(page);
			moveForm.attr("action", "/notice/list");
			moveForm.submit();
		});
		
		searchBtn.on("click", function(e) {
			e.preventDefault();
			// 검색시 1페이지로 변경 후 전송
			searchForm.find("input[name='pageNum']").val(1);
			searchForm.submit();
			
		});
		
		
	});

</script>


</body>
</html>