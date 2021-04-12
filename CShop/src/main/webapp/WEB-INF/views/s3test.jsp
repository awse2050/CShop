<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp" %>

<div class="uploadDiv">
	<input type='file' name='uploadFile' multiple>
</div>
<div>
	<img src ="https://spring-cshop.s3.ap-northeast-2.amazonaws.com/2021-04-12/c5eeba9c-50e8-4b52-bbfa-974c9d7ac4c6_coke.png">
</div>

<script>

	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		
		$("input[type='file']").on("change", function(e) {
			// 가상의 form태그와 같다.
			var formData = new FormData(); // 필수로 만들어줘야한다.
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for (var i = 0; i < files.length; i++) {
				
	/* 			if(!checkExtension(files[i].name, files[i].size)){
					return false;
				} */
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: "/s3upload",
				processData: false,
				contentType: false,
				data: formData,
				type: 'post',
				dataType: 'json',
				success: function(result) {
					console.log(result);
				}
			}); // ajax
		});
		
	})
	

</script>


<%@ include file="./includes/footer.jsp" %>