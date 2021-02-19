<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>



<section class="section">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="title text-center "> <!--  카테고리 나열 -->
				</div>
			</div>
			<div>
				<aside class="" style="float: left; width: 10%; text-align: center">
					<aside-header class="aside-header">ㅎㅎ</aside-header>
						<nav>
							<ul>
								<li>123123</li>
								<li>123123</li>
								<li>123123</li>
								<li>123123</li>
								<li>123123</li>
								<li>123123</li>
							</ul>
						</nav>
				</aside>
				<div> <!-- 본문 틀 -->
					<div>
						<h3 style="text-align: right; font-size: 8px">HOME > 중고</h3> <!-- 현재위치 -->
					</div>
					<div style="text-align: right; margin-bottom: 10px;"> <!-- 분류, 갯수선택 select  -->
						<select name="type" style="margin-right: 3px">
							<option value="t">제목</option>
							<option value="c">내용</option>
							<option value="w">작성자</option>
							<input type='text' name='keyword' style="height: 25px">
							<button class="searchBtn">검색하기</button>
						</select>
					</div>
					<div class="itemsDiv"> <!-- 게시글 목록 큰틀 -->
						<div class="pickItem"> <!-- 작은틀 하나하나 -->
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<b>하나1212212321412345325325</b>
							</div>
							<div>
								<span>운포</span>
								<strong>2700원</strong>
							</div>
						</div>
						<div class="pickItem"> <!-- 작은틀 하나하나 -->
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<b>하나1212212321412345325325</b>
							</div>
							<div>
								<span>운포</span>
								<strong>2700원</strong>
							</div>
						</div>
						<div class="pickItem"> <!-- 작은틀 하나하나 -->
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<b>하나1212212321412345325325</b>
							</div>
							<div>
								<span>운포</span>
								<strong>2700원</strong>
							</div>
						</div>
						<div class="pickItem"> <!-- 작은틀 하나하나 -->
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<b>하나1212212321412345325325</b>
							</div>
							<div>
								<span>운포</span>
								<strong>2700원</strong>
							</div>
						</div>
						<div class="pickItem"> <!-- 작은틀 하나하나 -->
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<b>하나1212212321412345325325</b>
							</div>
							<div>
								<span>운포</span>
								<strong>2700원</strong>
							</div>
						</div>
						<div class="pickItem"> <!-- 작은틀 하나하나 -->
							<ion-icon name="camera-outline" class="index-category-icon"></ion-icon>
							<div>
								<b>하나1212212321412345325325</b>
							</div>
							<div>
								<span>운포</span>
								<strong>2700원</strong>
							</div>
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
</section>










<%@ include file="../includes/footer.jsp"%>