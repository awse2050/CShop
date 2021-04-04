<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section" >
	<div class="container">
		<div class="row">
			<%@ include file="../includes/msg-Aside.jsp"%>
			<div class="bodyRow">
				<div class="bodyHeader">
					<div class="header-title">
						메세지 관리
					</div>
					<div class="header-location">
						HOME > 마이페이지 > 메세지 관리 > 받은 메세지
					</div>
				</div>
				
				<div class="tableDiv"> <!-- 이상이 있으면 해당 div 제거 -->
					<table class="like-table">
						<thead>
							<tr>
								 <th style="width: 10%;">보낸사람</th>
								<th style="width: 10%;">내용</th>
							</tr>
						</thead>
						<tbody class="likeBody">
							
						</tbody>
					</table>
				</div>
			</div>		
		</div>
	</div>
</section>

<%@ include file="../includes/footer.jsp"%>
			