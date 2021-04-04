<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section">
	<div class="container">
		<div class="row"> 
			<!-- start form tag -->
			<h2 class="title"> 상품등록 </h2>
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
						<option value="clothes">패션</option>
						<option value="mobile">휴대폰/통신</option>
						<option value="office">사무용품</option>
					</select>
				</div>
				</fieldset>
				<fieldset style="margin-top: 50px">
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
						<ul class="uploadUL" style="padding: 10px;">
						
						</ul>
						<ul class="guide">
							<li>*이미지1 썸네일 자동등록</li>
							<li>*업로드 가능한 이미지 최대 용량은 5MB 입니다.</li>
							<li>*이미지 최적 사이즈: PC: 600 x 480 / Mobile: 680 x 400</li>
						</ul>
					</div>
				</div>
				</fieldset>
				<fieldset style="margin-top: 50px">
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
					<!-- class= " input-table" -->
					<table class="input-table" style="margin-top:0px; width: 100%;  border-top-width: 0px;">
						<tbody>
							<tr>
								<th>상품명(40자 이하)</th>
								<td>
									<input type="text" maxlength="40" name="productName" style="height: 25px; width:100%;">
								</td>
							</tr>
							<tr>
								<th>수량</th>
								<td>
									<input type="text" maxlength="5" name="count" style="height: 25px; width:100px; text-align: right;" value="0"> 개
								</td>
							</tr>
							<tr>
								<th>판매가(10자리 이하)</th>
								<td>
									<input type="text" maxlength="10" name="price" style="height: 25px; width: 160px; text-align: right;"> 원
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<sec:authentication property="principal" var="pinfo"/>
								<td>
									<input type="text" name="writer" value="${pinfo.username }" readonly="readonly" style="height: 25px;">
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
				<fieldset style="margin-top: 50px">
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
						</textarea>
					</div>
				</fieldset>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<div class="register-buttonRow">
					<button id="regBtn"> 상품등록 </button>
					<button id="listBtn"> 목록으로 </button>
				</div>
			</form>
		</div>
	</div>
</section>


<form class="objForm">

</form>
<script>
	
	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		// Security 적용시 ajax 통신에 추가설정필요
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		
		var regBtn = $("#regBtn");
		var listBtn = $("#listBtn");
		var actionForm = $(".actionForm");
		var index = 1;
		var filterSelect = $(".filterSelect");
		
		var categoryValue = "";
		var productName = "";
		var price = "";
		var desc = "";
		var count = "";
	
		regBtn.on("click", function(e) {
			e.preventDefault();
	
			if(!checkValue()) {
				return false;
			}
			
			var str = "";
			// 첨부파일 이미지 정보
			$(".uploadUL li").each(function(i,obj) {
				console.log(obj);	// 각 li의 태그가 전송된다 따라서 그 값의 속성을 가져오기 위해서 $()을 써줘야함.
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+$(obj).data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+$(obj).data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+$(obj).data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+$(obj).data("type")+"'>";
			});
			
			actionForm.append(str);
		 	actionForm.attr("action", "/clothes/register").attr("method", "post");
			actionForm.submit(); 
		});
		
		listBtn.on("click", function(e) {
			e.preventDefault();
		
			self.location="/clothes/list";
		
		});
		
		filterSelect.on("change", function(e) {
			e.preventDefault();
			var amount = this.options[this.selectedIndex].value;
			
			categoryValue = amount;
		});
		
		$("input[name='productName']").on("change", function(e) {
			e.preventDefault();
			productName = $(this).val();
		})
		
		$("input[name='price']").on("change", function(e) {
			e.preventDefault();
			price = $(this).val();
		});
		
		$("input[name='count']").on("change", function(e) {
			e.preventDefault();
			count = $(this).val();
		});
		
		$("textarea[name='description']").on("change", function(e) {
			e.preventDefault();
			desc = $(this).val();
		});
		
		// 이미지 추가시 동작
		$("input[type='file']").on("change", function(e) {
			// 가상의 form태그와 같다.
			var formData = new FormData(); // 필수로 만들어줘야한다.
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			console.log(files);
			
			for (var i = 0; i < files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: "/uploadAjaxAction",
				processData: false,
				contentType: false,
				data: formData,
				type: 'post',
				dataType: 'json',
				success: function(result) {
					console.log(result);
					
					showUploadedFile(result); 
//					$(".uploadDiv").html(cloneUpload.html()); // 업로드 후 내용 초기화
				}
			}); // ajax
		});
		
		function checkValue() {
			if(!categoryValue) {
				alert("카테고리를 지정해주세요.");
				return false;
			}
			if(!productName) {
				alert("상품명을 입력하세요.");
				return false;
			}
			if(!count) {
				alert("수량을 입력하세요.");
				return false;
			}
			if(!price) {
				alert("가격을 입력하세요.");
				return false;
			}
			if(!desc) {
				alert("상세 설명을 입력하세요.");
				return false;
			}
			return true;
		}
		
		function checkExtension(fileName, fileSize) {
			if(fileSize >= maxSize) {
				alert("파일 사이즈 초과")
				return false;
			}
			if(regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.")
				return false;
			}
			return true;
		}
		
		// 이미지 추가시 이미지를 보여주는 기능
		function showUploadedFile(uploadResultArr) {
			// 프로젝트 적용시 추가된 부분.
			if(!uploadResultArr || uploadResultArr.length == 0) {
				return;
			}
			
			var uploadUL = $(".uploadUL");
			
			var str = "";
			// 배열을 하나씩 뽑는다.
			$(uploadResultArr).each(function(i, obj) {
				console.log(obj);
				if(!obj.image) {
					
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"' class='uploadLi'>";
					str += "<button data-file='"+fileCallPath+"' data-type='file'>X</button>"
					str += "<ion-icon name='camera-outline' class='index-category-icon'></ion-icon>";
					str += "<p>그 외 파일</p></li>";
					
				} else {
					// 한글이름 문제 방지를 위한 encodeURIComponent사용
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"' class='uploadLi'>";
					str += "<button data-file='"+fileCallPath+"' data-type='image'>X</button>"
					str += "<img class='uploadImage' src='/display?fileName="+fileCallPath+"'>";
					str += "<p>";
					
					if(index==1) {
						str += "이미지"+(index)+"(대표이미지)";
						
					} else {
						str += "이미지"+(index);
					}
					str +=  "</p></li>";
					index++;
					
				}
			});
			console.log(str);
			uploadUL.append(str);
		}
		
		/* 삭제버튼 */
		$(".uploadResult").on("click","button", function(e) {
			e.preventDefault();
			
			console.log("delete file");
			
			var targetFile = $(this).data('file');
			var type = $(this).data('type');
			
			// 태그 제거용 선언
			var targetLi = $(this).closest("li");
			console.log(targetLi);
			
			$.ajax({
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type: 'post',
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				success: function(result) {
					index--;
					targetLi.remove(); //  태그제거
				}
			})
		});
	})

</script>



<%@ include file="../includes/footer.jsp"%>

