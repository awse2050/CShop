<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row">
			<div class="signUp-header">
				<div class="header-title">
					찜리스트
				</div>
				<div style="float: right; font-size: 12px; font-weight: 700;">
					HOME > 찜리스트
				</div>
			</div>
			<div style="border: 5px solid #e8e8e8; margin:30px 0px;">
				<div style="padding: 15px;">
					xxx 님은 [일반회원] 입니다.
				</div>
			</div>
		
			<div>
				<table class="like-table">
					<thead>
						<tr>
							<th>번호</th>
							<th>상품정보</th>
							<th>판매가</th>
							<th>선택</th>
						</tr>
					</thead>
					<!-- 찜리스트가 들어갈 공간 -->
					<tbody>
						<tr>
							<td>11</td>
							<td>사진과 정보들</td>
							<td>1000원</td>
							<td><button>삭제</button></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>
		
<script>

	$(document).ready(function() {
		
		(function() {
			
			$.getJSON("/like/admin44", function(result) {
				console.log(result);
				console.log(typeof result);
				console.log(Boolean(result));
				console.log(result.length)
			})
			
		})();
		
		
	});
	
</script>
		
		
		
<%@ include file="./includes/footer.jsp"%>