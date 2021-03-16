<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ include file="./includes/header.jsp" %>
 <section class="section">
 	<div class="container text-center" style="width: 300px;">
 		<div class="row" >
	 		<form action="/login" method="post">
	 			<div class="form-group idForm" >
	 				<div class="">
	 					<span>ID</span>
	 				</div>
					<input type="text" class="form-control loginInput" name="username">
	 			</div>
	 			<div class="form-group passwordForm" >
					<div class="">
		 				<span>PASSWORD</span>
					</div> 		
					<input type="password" class="form-control loginInput" name="password" >
	 			</div>
	 			<div class="form-group add-ons">
	 				<span>Forgot ID ?</span>
	 				<span>Forgot Password ?</span>
	 				<span>
		 				<input type="checkbox" name="remember">아이디 저장</input>
	 				</span>
	 			</div>
				<div class="form-group loginButton">
					<button class="btn btn-dark login" >LOGIN</button>
					<button class="btn btn-default joinUs">Join Us</button>
				</div>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
				<input type="hidden" name="referer" value="${referer }">
	 		</form>
 		 </div>
 	
 	</div>
 </section>
    
    
    <%@ include file="./includes/footer.jsp" %>