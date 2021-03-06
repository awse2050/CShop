<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row"> 
			<!-- start form tag -->
			<h2 class="title"> 게시물 수정</h2>
			<form class="actionForm">	
				<fieldset>
				<ul class="tabTitle">
					<li class="active">
						<p>카테고리 등록</p>
					</li>
					<li>
						<p>이미지 등록</p>
					</li>
					<li>
						<p>상품기본정보</p>
					</li>
					<li>
						<p>상품상세설명</p>
					</li>
				</ul>
				<div class="categoryDiv">
					<select class="filterSelect" name="category">
						<option value="">선택</option>
						<option value="clothes" 
						 ${clothes.category eq "clothes" ? "selected" : "" }>패션</option>
						<option value="mobile" 
						${clothes.category eq "mobile" ? "selected" : "" }>휴대폰/통신</option>
						<option value="office" 
						${clothes.category eq "office" ? "selected" : "" }>사무용품</option>
					</select>
				</div>
				</fieldset>
				<fieldset>
				<ul class="tabTitle" >
					<li>
						<p>카테고리 등록</p>
					</li>
					<li class="active">
						<p>이미지 등록</p>
					</li>
					<li>
						<p>상품기본정보</p>
					</li>
					<li>
						<p>상품상세설명</p>
					</li>
				</ul>
				<div class="uploadRow">
					<div class="uploadDiv">
						<input type='file' name='uploadFile' multiple>
					</div>
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
				</fieldset>
				<fieldset>
					<ul class="tabTitle" >
						<li>
							<p>카테고리 등록</p>
						</li>
						<li>
							<p>이미지 등록</p>
						</li>
						<li class="active">
							<p>상품기본정보</p>
						</li>
						<li>
							<p>상품상세설명</p>
						</li>
					</ul>
					<table class="input-table" style="margin-top:0px; width: 100%; border-top-width: 0px;">
						<tbody>
							<tr>
								<th>상품명(40자리 이하)</th>
								<td>
									<input type="text" maxlength="40" name="productName" value="${clothes.productName }" style="height: 25px; width:100%;">
								</td>
							</tr>
							<tr>
								<th>수량</th>
								<td>
									<input type="text" maxlength="5" name="count" value="${clothes.count }" style="height: 25px; width:100px; text-align: right;"> 개
								</td>
							</tr>
							<tr>
								<th>판매가(10자리 이하)</th>
								<td>
									<input type="text" maxlength="10" name="price" value="${clothes.price }" style="height: 25px; width: 160px; text-align: right;" > 원
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>
									<input type="text" name="writer" value="${clothes.writer }" style="height: 25px;">
								</td>
							</tr>
						</tbody>
						<input type="hidden" name="viewCnt" value="${clothes.viewCnt }" >
						<input type="hidden" name="cno" value="${clothes.cno }" >
					</table>
				</fieldset>
				<fieldset>
					<ul class="tabTitle" >
						<li>
							<p>카테고리 등록</p>
						</li>
						<li>
							<p>이미지 등록</p>
						</li>
						<li>
							<p>상품기본정보</p>
						</li>
						<li class="active">
							<p>상품상세설명</p>
						</li>
					</ul>
					<div>
						<textarea style="width: 100%; height: 300px" name="description">
						${clothes.description }
						</textarea>
					</div>
				</fieldset>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<div class="register-buttonRow">
					<button class="small-btn" id="modBtn"> 수정완료 </button>
					<button class="small-btn2" id="backBtn"> 뒤로가기 </button>
				</div>
			</form>
		</div>
	</div>
</section>

<form class="objForm">
	<input type="hidden" name="pageNum" value="${cri.pageNum }">
	<input type="hidden" name="amount" value="${cri.amount }">
	<input type="hidden" name="type" value="${cri.type }">
	<input type="hidden" name="keyword" value="${cri.keyword }">
</form>

<script>
	
	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		// Security 적용시 ajax 통신에 추가설정필요
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	

		(function() {
			var cno = '<c:out value="${clothes.cno}" />';
			
			var uploadUL = $(".uploadUL");
			
			$.get("/clothes/getAttachList/", {cno: cno}, function(attachArr) {
				if(!attachArr) {
					return false;
				}
				var str ="";
				
				$(attachArr).each(function(i, obj) {
					if(obj.fileType) {
						
						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' class='uploadLi'>";
						str += "<button data-type='image'>X</button>"
						str += "<img class='uploadImage' style='width: 150px' src='"+obj.thumbnail+"'>";
						str += "<p>";
						str += "이미지"+(i+1);
						str +=  "</p></li>";
					} // is Image
					// not image 
				}); 
				uploadUL.append(str);
			});
		})(); // function 

		//확장자 크기 제한
		var regex = new RegExp("(.*?)\.(exe|sh|zio|alz)$");
		var maxSize = 5242880;
		
		var actionForm = $(".actionForm");
		var objForm = $(".objForm");
		var uploadUL = $(".uploadUL");
		var modBtn = $("#modBtn");
		var backBtn = $("#backBtn");
		var requestUri = '<c:out value="${requestUri}"/>';
		
		modBtn.on("click", function(e) {
			e.preventDefault();
			
			var str ="";
			// 업로드 목록 추출
			$(".uploadUL li").each(function(i, obj) {
				
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+$(obj).data("path")+"' >"
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+$(obj).data("type")+"' >"
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+$(obj).data("uuid")+"' >"
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+$(obj).data("filename")+"' >"
			});
			
			actionForm.append(objForm.html());
			actionForm.append(str);
			actionForm.append("<input type='hidden' name='requestUri' value='"+requestUri+"'>");
			//  form 전송
			actionForm.attr("action", "/clothes/modify").attr("method", "post").submit();
			
		})
	
		backBtn.on("click", function(e) {
			e.preventDefault();
			
			var uri = '<c:out value="${requestUri}"/>';
			if(uri.includes("mypage")){
				self.location = '/mypage/goods';
			} else {
				objForm.append("<input type='hidden' name='cno' value='"+${clothes.cno}+"'>");
				objForm.attr("action", "/clothes/get").submit();
			}		
		});
		
		// 업로드를 했을 경우
		$("input[type='file']").change(function(e) {
			var formData = new FormData();
			
			var inputFiles = $("input[name='uploadFile']");
			var files = inputFiles[0].files;
			
			for(var i = 0; i < files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				type: 'post',
				url: '/s3upload',
				processData: false,
				contentType: false,
				data: formData,
				dataType: 'json',
				success: function(result) {
					showUploadResult(result);
				}
			}); // end ajax
		}) //end change
		
		//삭제
		uploadUL.on("click", "button", function(e) {
			e.preventDefault();
			// 태그 제거용 선언
			var targetLi = $(this).closest("li");
			console.log(targetLi);
			var path = targetLi.data("path");
			var uuid = targetLi.data("uuid");
			var name = targetLi.data("filename");
			var callpath = path + "/" + uuid + "_" + name;
			
			if(confirm("삭제합니까?")) {
				$.ajax({
					type: 'post',
					url: '/s3Remove',
					data: {path: callpath},
					dataType: 'text',
					success: function(result) {
						targetLi.remove(); //  태그제거
					}
				})
			}  
		});
		
		// 확장자 검사
		function checkExtension(fileName, fileSize) {
			
			if(fileSize > maxSize) {
				alert("사이즈가 큽니다.");
				return false;
			}
			
			if(regex.test(fileName)) {
				alert("확장자를 확인하세요.");
				return false;
			}
			return true;
		}
		
		function showUploadResult(uploadArr) {
			if(!uploadArr || uploadArr.length == 0) {
				return ;
			}
			
			var uploadUL = $(".uploadUL");
			var str = "";
			
			$.each(uploadArr, function(i, obj) {
				if(obj.image) {
					
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"' class='uploadLi'>";
					str += "<button data-type='image'>X</button>"
					str += "<img class='uploadImage' style='width: 150px' src='"+obj.thumbnail+"'>";
					str += "<p>추가이미지"+(i+1)+"</p></li>";
					
				} else { // 이미지파일이 아닌경우
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+ obj.uuid+"_"+obj.fileName);
				
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
					str += "<div><span>"+obj.fileName+"</span>";
					str +="<button class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='file'>";
					str += "<i class='fa fa-times'></i></button><br>";
					str +="<img src='/resources/data/X.svg.png'></div></li>";
					
				} // else
			}); // end each
			 
			uploadUL.append(str);
		}
	});
	
</script>

<%@ include file="../includes/footer.jsp"%>

