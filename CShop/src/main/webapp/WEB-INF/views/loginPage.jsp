<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp" %>

<div id="alertModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="height: 300px;">
      <div class="modal-header">
        <h5 class="modal-title">로그인 실패</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="border-top: 1px solid #e8e8e8; border-bottom: 1px solid #e8e8e8">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

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
	 				<span><a href="/findID">Forgot ID ?</a></span>
	 				<span><a href="/findPW">Forgot Password ?</a></span>
	 				<span>
		 				<input type="checkbox" name="remember"> 아이디 저장</input>
	 				</span>
	 			</div>
				<div class="form-group loginButton">
					<button class="btn btn-dark login" >LOGIN</button>
					<button class="btn btn-default" id="joinUs">Join Us</button>
				</div>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" >
				<input type="hidden" name="referer" value="${referer }">
	 		</form>
 		 </div>
 	</div>
</section>
    
<script>
	
	$(document).ready(function() {
	
		var signUpBtn = $("#joinUs");
		var modalBody = $(".modal-body");
		var alertModal = $("#alertModal");
		var errormsg = '<c:out value="${errorMsg}" />';
		
		signUpBtn.on("click", function(e) {
			e.preventDefault();
		
			self.location = "/signUp";
		})
		
		if(errormsg) {
			modalBody.html("<p>"+errormsg+"</p>");
			alertModal.modal("show");
		}
	})
	
</script>
    
<%@ include file="./includes/footer.jsp" %>