<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>

<h2> modfiy .jsp..</h2>
<div>
	<form class="subForm">
		<div>
			<input type='text' name='nno' value="${notice.nno }"  readonly="readonly">
		</div>
		<div>
			<input type='text' name='title' value="${notice.title }" >
		</div>
		<div>
			<input type='text' name='content' value="${notice.content }"  >
		</div>
		<div>
			<input type='text' name='writer' value="${notice.writer }" readonly="readonly">
		</div>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
		
		<div class="form-group uploadDiv">
			<input type="file" name="uploadFile" multiple>
			
		</div>
		<div class="uploadResult">
			<ul>
			</ul>	
		</div>
	
		<button class="subBtn" data-oper="modify" >변경</button>
		<button class="subBtn" data-oper="remove" >삭제</button>
		<button class="subBtn"  data-oper="list" >목록</button>
</div>
		
<form class="objForm">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" value="${cri.amount }">
	<input type="hidden" name="type" value="${cri.type }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
</form>		

<script>
	
	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfToken = "${_csrf.token}";
		
		(function() {
			var nno = "${notice.nno}";
			
			$.getJSON("/notice/getAttachList", {nno: nno}, function(arr) {
				console.log(arr);
				
				var str = "";
				
				$(arr).each(function(i, obj) {
					if(obj.fileType) {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						str += "<div data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>" 
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "<button class='btn btn-primary btn-circle' data-type='image' data-file=\'"+fileCallPath+"\'>X</button></div>"
					
					} else {
						
					}
				});
				$(".uploadResult ul").append(str);
			});
		})();
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		var uploadDiv = $(".uploadDiv");
		var uploadResult = $(".uploadResult ul");
		
		var subBtn = $(".subBtn");
		var objForm = $(".objForm");
		var subForm = $(".subForm");
		
		subBtn.on("click", function(e) {
			e.preventDefault();
			
			var oper = $(this).data("oper");
			
			if(oper === "modify") {
				
				var str = "";
				$(".uploadResult ul div").each(function(i, obj) {
					var jobj = $(obj);
					
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
					
				})
				subForm.append(objForm.html()).append(str);
				subForm.attr("action", "/notice/modify").attr("method", "post");
				
				subForm.submit();
			} else if(oper === "remove" ) {
				objForm.append('<input type="hidden" name="nno" value="${notice.nno }">');
				objForm.attr("action" , "/notice/remove").attr("method", "post");
				objForm.submit();
				
			} else if(oper === "list") {
				objForm.attr("action", "/notice/list");
				objForm.submit();
			}
		})
		
		$(".uploadResult").on("click", "button", function(e) {
			e.preventDefault();
			
			console.log("delete File");
			
			if(confirm("삭제하시겠습니까?")) {
				var targetDiv = $(this).closest("div");
				targetDiv.remove();
			}
			
		});

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
					
					str += "<div data-uuid='"+obj.uuid+"' data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
					str += "<button class='btn btn-dark btn-circle' data-type='image' data-file=\'"+fileCallPath+"\'>X</button><br>"
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>"
					
				} else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					
					str += "<div>" + obj.fileName;
					str += "<span data-type='image' data-file=\'"+fileCallPath+"\'> x </span></div>"
				}
			});
			// uploadResult ul
			$(".uploadResult ul").append(str);
			
		}
		
		function checkExtension(fileName, fileSize) {
			if(regex.test(fileName)) {
				return false;
			}

			if(fileSize > maxSize) {
				return false;
			}
			return true;
		}
	})

</script>



</body>
</html>