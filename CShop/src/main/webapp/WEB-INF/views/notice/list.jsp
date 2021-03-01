<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div class="container" style="border-bottom: 1px solid #dedede; padding-top:20px; padding-bottom: 20px;">
	<div class="notice-header-title">
	 	<div>CS Service</div>
	</div>
	<div class="notice-header-subTitle">
		<div> 
			<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
			<p>공지사항</p>
		</div>
		<div>
			<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
			<p>FAQ</p>
		</div>
		<div>
			<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
			<p>1:1문의</p>
		</div>
	</div>
</div>

<section class="product-category section" style="padding-top: 50px;">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="title">
					<h2  style="text-align: left; font-size: 30px">공지사항</h2>
				</div>
			</div>
			<table class="table table-secondary">
				<thead>
					<tr class="listTh">
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">조회수</th>
						<th scope="col">등록일</th>
					</tr>
				</thead>
				<tbody class="listTablebody">
					<c:forEach items="${list }" var="list">
						<tr class="listRow">
							<td id="nno" scope="row">${list.nno }</td>
							<td id="title"><a class="getBtn" href="${list.nno }">${list.title }</a></td>
							<td id="writer">${list.writer }</td>
							<td id="viewCnt">${list.viewCnt }</td>
							<td id="moddate"><fmt:formatDate pattern="yyyy-MM-dd"
									value="${list.moddate }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="min-height: 25px">
				<button class="registerBtn customBtn" style="float: right;">글쓰기</button>
			</div>
	
			<div class="searchDiv">
				<form class="searchForm" action="/notice/list">
					<select name="type" style="margin-right: 3px">
						<option value="t">제목</option>
						<option value="c">내용</option>
						<option value="w">작성자</option>
						<input type='text' name='keyword' style="height: 25px">
						<button class="searchBtn customBtn">검색하기</button>
						<input type='hidden' name='pageNum'value="${pageMaker.cri.pageNum }">
						<input type='hidden' name='amount' value="${pageMaker.cri.amount }">
					</select>
				</form>
			</div>
			<div class="pagingDiv">
				<nav aria-label="Page navigation example">
  					<ul class="pagination">
  					<c:if test="${pageMaker.prev }">
				    	<li class="page-item"><a class="page-link pageBtn" href="${pageMaker.startPage - 1 }">Previous</a></li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
					    <li class="page-item ${pageMaker.cri.pageNum == num ? "active" : "" }">
					    	<a class="page-link pageBtn"href="${num }"> ${num }</a>
					    </li>
				    </c:forEach>
				    <c:if test="${pageMaker.next }">
				    	<li class="page-item"><a class="page-link pageBtn" href="${pageMaker.endPage + 1 }">Next</a></li>
				 	</c:if>
				  </ul>
				</nav>
			</div>

		</div>
	</div>
</section>

<form class="moveForm">
	<input type='hidden' name='pageNum' value="${pageMaker.cri.pageNum }">
	<input type='hidden' name='amount' value="${pageMaker.cri.amount }">
	<input type='hidden' name='type' value="${pageMaker.cri.type }">
	<input type='hidden' name='keyword' value="${pageMaker.cri.keyword }">

</form>

<script>
	$(document).ready(function() {

		var getBtn = $(".getBtn");
		var moveForm = $(".moveForm");
		var pageBtn = $(".pageBtn");
		var searchForm = $(".searchForm");
		var searchBtn = $(".searchBtn");
		var registerBtn = $('.registerBtn');
		
		registerBtn.on("click", function(e) {
			e.preventDefault();
			
			console.log("register btn ...");	
			
			location.href = "/notice/register";
		});
		
		getBtn.on("click", function(e) {
			e.preventDefault();

			var nno = $(this).attr("href");

			moveForm.append("<input type='hidden' name='nno' value='"+nno+"'>");
			moveForm.attr("action","/notice/get");
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

<%@ include file="../includes/footer.jsp"%>
