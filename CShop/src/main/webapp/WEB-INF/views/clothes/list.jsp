<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div class="container" style="border-bottom: 1px solid #dedede">
	<div class="index-category">
		<div class="index-category-div">
			<div class="index-category-child-div">
				<a href="/clothes/list">
					<div class="category">
						<h3>패션</h3>
					</div>
				</a>	
			</div>
			<div class="index-category-child-div">
				<a href="/mobile/list"> 
					<div class="category">
						<h3>휴대폰/통신</h3>
					</div>
				</a>	
			</div>
			<div class="index-category-child-div">
				<a href="/office/list">
					<div class="category">
						<h3>사무용품</h3>
					</div>
				</a>	
			</div>
		</div>
	</div>
</div>

<section class="section">
	<div class="container">
		<div class="row">
			<div>
				<aside class="listAside">
					<aside-header class="aside-header">의류</aside-header>
						<nav>
							<ul>
								<li>팝니다</li>
								<li>삽니다</li>
							</ul>
						</nav>
				</aside>
				<div class="listBody"> <!-- 본문 틀 -->
					<div class="locationDiv">
						<h3>HOME > 팝니다</h3> <!-- 현재위치 -->
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
									<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
									<div>
										<b>${list.productName }</b>
									</div>
									<div>
										<div>운포</div>
										<strong>${list.price }원</strong>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<!-- /.row -->
		
		<div class="clothesSearch"> <!-- searchDiv -->
			<form class="searchForm" action="/clothes/list">
				<select name="type">
					<option value="">--</option>
					<option value="p"
					${pageMaker.cri.type eq p ? "selected" : "" }>상품명</option>
				</select>
				<input type="text" name="keyword" placeholder="검색어를 입력하세요">
				<input type="hidden" name="pageNum" value=${pageMaker.cri.pageNum }>
				<input type="hidden" name="amount" value=${pageMaker.cri.amount }>
				<button class="searchBtn"><i class="fas fa-search"></i></button> 
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
		
		var searchBtn = $(".searchBtn");
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
	/* 	
		$.getJSON("/clothes/getAttachList", {cno: 245}, function(result) {
			console.log(result);
		}) */
		
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