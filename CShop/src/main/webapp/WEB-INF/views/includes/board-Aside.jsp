<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="asideRow">
	<c:if test="${asideHeader eq 'clothes' }">
		<a href="/clothes/list">
			<aside-header class="asideHeader">패션</aside-header>
		</a>
	</c:if>
	<nav class="asideMenu">
		 <ul>
		 	<li class="t">팝니다</li>
		 	<!-- <a href="/mypage/goods">
				<li class="b">상품목록</li>
		 	</a>
		 	<a href="#">
				<li class="t">메세지 관리</li>
		 	</a>
			<li class="t">회원정보 변경</li>
			<a href="#">
				<li class="b">회원정보 수정</li>
			</a>
			<a href="#">
				<li class="b">회원탈퇴</li>
			</a> -->
		</ul> 
	</nav>
</aside>