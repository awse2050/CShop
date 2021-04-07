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
		</ul> 
	</nav>
</aside>