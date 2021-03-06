<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<%@ include file="../includes/board-Aside.jsp"%>
			<div class="bodyRow">
				<div class="header-location">
					HOME > 패션 > 팝니다
				</div>
				<div class="bodyHeader">
					<div class="header-title">
						상품목록
					</div>
				</div>
				<div class="filterDiv"> <!-- 분류, 갯수선택 select  -->
					<select class="filterSelect" name="amount">
						<option value="10"
						${pageMaker.cri.amount eq 10 ? "selected" : "" }>10개</option>
						<option value="20"
						${pageMaker.cri.amount eq 20 ? "selected" : "" }>20개</option>
						<option value="40"
						${pageMaker.cri.amount eq 40 ? "selected" : "" }>40개</option>
						<option value="60"
						${pageMaker.cri.amount eq 60 ? "selected" : "" }>60개</option>
						<option value="80"
						${pageMaker.cri.amount eq 80 ? "selected" : "" }>80개</option>
					</select>
				</div>
				<div class="itemsDiv"> <!-- 게시글 목록 큰틀 -->
					<c:forEach items="${list }" var="list">
						<div class="pickItem"> <!-- 작은틀 하나하나 -->
							<a class="getBtn" href='<c:out value="${list.cno }" />'>
								<!-- background-image : url(경로) -->
								<c:if test="${!empty list.thumbnailUrl }">
									<img src="${list.thumbnailUrl}" class="listImg">
								</c:if>
								<c:if test="${empty list.thumbnailUrl }">
									<img class="listImg" src='/resources/images/noimage.png'>
								</c:if>
								<div style="margin: 15px 0px;">
									<b>${list.productName }</b>
									<div>
										<strong>${list.price }원</strong>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- /.row -->
		
		<div class="clothesSearch"> <!-- searchDiv -->
			<form class="searchForm" action="/clothes/list">
				<select class="filterSelect" name="type">
					<option value="">--</option>
					<option value="p"
					${pageMaker.cri.type eq p ? "selected" : "" }>상품명</option>
				</select>
				<input style="border: 1px solid #ccc;" type="text" name="keyword" placeholder="검색어를 입력하세요">
				<input type="hidden" name="pageNum" value=${pageMaker.cri.pageNum }>
				<input type="hidden" name="amount" value=${pageMaker.cri.amount }>
				<button id="searchBtn"><i class="fas fa-search"></i></button> 
			</form>
		</div>
		
		<div class="text-center">
			<ul class="pageRow">
				<c:if test="${pageMaker.prev }">
					<a class="pageBtn" href="${pageMaker.startPage - 1 }">
						<li class="prevBtn">prev</li>
					</a>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
					<a class="pageBtn ${pageMaker.cri.pageNum == num  ? "active" : ""}" href='<c:out value="${num }"/>'>
						<li>
							${num }
						</li>
					</a>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<a class="pageBtn" href="${pageMaker.endPage + 1 }">
						<li class="nextBtn">
							Next
						</li>
					</a>
				</c:if>
			</ul>
        </div>
	</div>
</section>

<form class="objForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>

<script>

	$(document).ready(function() {
		
		var objForm = $(".objForm");
		var getBtn = $(".getBtn"); // 상품클릭 ( 상세페이지로 이동 )
		var pageBtn = $(".pageBtn"); // 페이지 이동 버튼
		var msgBtn = $("#msg");
		var searchBtn = $("#searchBtn");
		var searchForm = $(".searchForm");
		
		var filterSelect = $(".filterSelect");
		// 페이지 이동시
		pageBtn.on("click", function(e) {
			e.preventDefault();
			
			var pageNum = $(this).attr("href");

			objForm.find("input[name='pageNum']").val(pageNum);
			objForm.attr("action", "/clothes/list").submit();
		});
		
		// 검색 버튼 클릭시
		searchBtn.on("click", function(e) {
			e.preventDefault();
			
			var type = searchForm.find("select[name='type']").val();
			var keyword = searchForm.find("input[name='keyword']").val();
			
			if(type == "") {
				alert("검색종류를 선택하세요.");
				return false;
			} 
			if(keyword == "") {
				alert("검색할 내용을 입력하세요.");
				return false;
			}   
			
			searchForm.find("input[name='pageNum']").val(1);
			searchForm.submit();
		});
		
		filterSelect.on("change", function(e) {
			e.preventDefault();
		
			var amount = this.options[this.selectedIndex].value;
			
			objForm.find("input[name='amount']").val(amount);
			objForm.attr("action","/clothes/list").submit(); 
			
		})
		
		getBtn.on("click", function(e) {
			e.preventDefault();
			
			var cno = $(this).attr("href");
			
			objForm.append("<input type='hidden' name='cno' value='"+cno+"'>");
			objForm.attr("action", "/clothes/get").submit();
			
		})
	}); // end document

</script>

<%@ include file="../includes/footer.jsp"%>