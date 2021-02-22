<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<section class="product-category section">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="title">
					<div>공지사항 등록</div>
				</div>
			</div>
		
		<form class="subForm" action="/notice/register" method="post">
			<div class="form-group">
				<label>제목</label>
				<input class="form-control" name="title"> 
			</div>
			<div class="form-group">
				<label>내용</label>
				<textarea class="form-control" rows="5" cols="20" name="content" ></textarea>
			</div>
			<div class="form-group">
				<label>작성자</label>
				<input  class="form-control" name="writer">
			</div>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		</form>	
			
			<div>
				<p> 이미지 등록란 </p>
				<div class="uploadDiv">
					<input class="form-control" type="file" name="uploadFile" multiple>
				</div>
			</div>
			<div class="uploadResult">
				<ul>
					
				</ul>
			</div>
			
			<div class="footerBtn">
				<button class="customBtn" >등록</button>
			</div>
		</div>
	</div>
</section>

<script>

	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfToken = "${_csrf.token}";
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		var uploadDiv = $(".uploadDiv");
		var uploadResult = $(".uploadResult ul");
		
		var registerBtn = $(".customBtn");
		var subForm = $(".subForm");
		
		registerBtn.on("click", function(e) {
			e.preventDefault();
			console.log("register click");
			var str = "";
			$(".uploadResult ul li").each(function(i, obj) {
				
				var jobj = $(obj);
				
				console.log(jobj);
				
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				
				console.log(str);
			})
			subForm.append(str).submit();		
		})
		
		var cloneObj = uploadDiv.clone();
		
		$("input[name='uploadFile']").on("change", function(e) {
			
			 e.preventDefault();
			 
			 var formData = new FormData();
			 var inputFiles = $("input[name='uploadFile']");
			 console.log(inputFiles);
			 
			 var files = inputFiles[0].files;
			console.log(files);
			
			for(var i=0; i < files.length; i++) {
				// 확장자 및 크기체크 미통과시
				if(!checkExtension(files[i].name, files[i].size)) {
					console.log("return")
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfToken);
				},
				type: 'post',
				url: '/uploadAjax',
				processData: false,
				contentType: false,
				data: formData,
				dataType: 'json',
				success: function(result) {
					showUploadResult(result);
					 
					uploadDiv.html(cloneObj.html());
				}
  			}); // ajax
		});
		
		function showUploadResult(uploadArr) {
			console.log(uploadArr);
			
			if(!uploadArr || uploadArr.length == 0) {
				console.log("return..")
				return;
			}
			
			var str = "";
			
			$.each(uploadArr, function(i, obj) {
				console.log(obj);
				if(obj.image) {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					
					str += "<li data-uuid='"+obj.uuid+"' data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
					str += "<button class='btn btn-dark btn-circle' data-type='image' data-file=\'"+fileCallPath+"\'>X</button><br>"
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</li>"
					
				} else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					
					str += "<li>" + obj.fileName;
					str += "<span data-type='image' data-file=\'"+fileCallPath+"\'> x </span></li>"
				}
			});
			// uploadResult ul
			uploadResult.append(str);
			
		}
		
		$(".uploadResult").on("click", "button", function(e) {
			e.preventDefault();
			var file = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			
			$.ajax({
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfToken);
				},
				type: 'post',
				url: '/deleteFile',
				data: {fileName: file, type: type},
				success: function(result) {
					console.log(result);
					targetLi.remove();
				}
			});
		})
		
		function checkExtension(fileName, fileSize) {
			if(regex.test(fileName)) {
				return false;
			}

			if(fileSize > maxSize) {
				return false;
			}
			return true;
		}
	});	

</script>





<%@ include file="../includes/footer.jsp"%>
