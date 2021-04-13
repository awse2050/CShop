<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./includes/header.jsp" %>

<div class="uploadDiv">
	<input type='file' name='uploadFile' multiple>
	<div class='uploadResult'>
	<ul class="uploadUL">
	
	</ul>
	<ul class="guide">
		<li>*이미지1 썸네일 자동등록</li>
		<li>*업로드 가능한 이미지 최대 용량은 5MB 입니다.</li>
		<li>*이미지 최적 사이즈: PC: 600 x 480 / Mobile: 680 x 400</li>
	</ul>
</div>
</div>
<button id="sub">click</button>


<script>

	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	

		var subBtn = $("#sub");
		
		var index = 1;
		
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
					showUploadedFile(result);
				}
			}); // ajax
		});
		
		subBtn.on("click", function(e) {
			e.preventDefault();
		
			var str = "";
			// 첨부파일 이미지 정보
			$(".uploadUL li").each(function(i,obj) {
				console.log($(obj));
				// 각 li의 태그가 전송된다 따라서 그 값의 속성을 가져오기 위해서 $()을 써줘야함.
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+$(obj).data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+$(obj).data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+$(obj).data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+$(obj).data("type")+"'>";
			});
			
			console.log(str);
			
		});
		
		// 이미지 추가시 이미지를 보여주는 기능
		function showUploadedFile(uploadResultArr) {
			// 프로젝트 적용시 추가된 부분.
			console.log(uploadResultArr);
			if(!uploadResultArr || uploadResultArr.length == 0) {
				return;
			}
			
			var uploadUL = $(".uploadUL");
			
			var str = "";
			// 배열을 하나씩 뽑는다.
			$(uploadResultArr).each(function(i, obj) {
				console.log(obj);
				// 한글이름 문제 방지를 위한 encodeURIComponent사용
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' class='uploadLi'>";
				str += "<button data-type='image'>X</button>"
				str += "<img class='uploadImage' src='"+obj.thumbnail+"'>";
				str += "<p>";
				str += "이미지" + index;
				str +=  "</p></li>";
				
				index += 1;
			});
			
			uploadUL.append(str);
		}
		
		$(".uploadResult").on("click","button", function(e) {
			e.preventDefault();
			
			// 태그 제거용 선언
			var targetLi = $(this).closest("li");
			console.log(targetLi);
			var path = targetLi.data("path");
			var uuid = targetLi.data("uuid");
			var name = targetLi.data("filename");
			console.log(path);
			console.log(uuid);
			console.log(name);
			var callpath = path + "/" + uuid + "_" + name;
			console.log(callpath);
			
			$.ajax({
				type: 'post',
				url: '/s3Remove',
				data: {path: callpath},
				dataType: 'text',
				success: function(result) {
					console.log(result);
					targetLi.remove(); //  태그제거
				}
			})
		});
	})
	

</script>


<%@ include file="./includes/footer.jsp" %>