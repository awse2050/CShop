<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <!-- JQuery -->
  <script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
  
  	<div class="uploadDiv">
  		<input type="file" name="uploadFile" multiple="multiple" >
		<button class="uploadBtn" >업로드하기</button>
  	</div>




<script type="text/javascript">

	$(document).ready(function() {
		
		var uploadDiv = $(".uploadDiv");
		var uploadBtn = $(".uploadBtn");
		
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		

		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		// 가상form 태그
		// 해당 property
		uploadBtn.on("click", function(e) {
			
			 e.preventDefault();
			 
			 var formData = new FormData();
			 var inputFiles = $("input[name='uploadFile']");
			 console.log(inputFiles);
			 
			 var files = inputFiles[0].files;
			console.log(files);
			
			for(var i=0; i < files.length; i++) {
				// 확장자 및 크기체크 미통과시
				formData.append("uploadFile", files[i]);
				
			}
			
			$.ajax({
				type: 'post',
				url: '/uploadAjax',
				processData: false,
				contentType: false,
				data: formData,
				success: function(result) {
					console.log(result);  				
  				}
  			}); // ajax
		});
		 
		
		
		
	})


</script>

	

</body>
</html>