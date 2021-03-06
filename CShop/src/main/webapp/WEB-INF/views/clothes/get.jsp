<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div id="writeModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background: #2C3E50; padding: 20px;">
        <h5 class="modal-title" style="color: white;">메세지 보내기</h5>
      </div>
      <div class="modal-body" style="padding: 15px 30px; background: #f7f7f7;">
	      <table class="msg-table">
			 <tbody>
				<tr style="border-top: 1px solid #e8e8e8;">
					<td style="width: 20%;">수신자</td>
					<td style="text-align: left; padding-left: 5px;" >${clothes.writer }</td>
				</tr>
				<tr>
					<td class="required" style="width: 20%;">내용</td>
					<td style="padding: 10px 3px 5px 3px;">
					<!-- 높이 직접변경 -->
						<textarea class="msg-input" type="text" name="text" style="height: 150px;"></textarea>
					</td>
				</tr>
			 </tbody>
		  </table>
      </div>
      <div class="modal-footer">
        <button class="small-btn" id="sendMsg">보내기</button>
        <button class="small-btn2" id="cancelMsg">취소</button>
      </div>
    </div>
  </div>
</div>


<section class="section" style="padding: 0 0;">
	<div class="container">
		<div class="row">
			<div class="locationDiv">
				<h3>HOME > 패션 > 팝니다</h3>
				<!-- 현재위치 -->
			</div>
			<div class="lastUpdate">
				<span>마지막 업데이트 : <fmt:formatDate
						pattern="yyyy-MM-dd HH:mm:ss" value="${clothes.moddate }" />
				</span>
				<!-- 수정날짜 -->
			</div>
			<div class="sellerRow">
				<p class="sellerBox">판매자</p>
				<p class="seller">${clothes.writer }</p>
			</div>
			<div class="getBody">
				<div class="uploadResult imgBox">
					<!-- 대표이미지 -->
					<ul class="mainImg">
					</ul>
					<!-- 그외 썸네일 이미지 -->
					<ul class="thumbImg">
						
					</ul>
					<div class='bigPictureWrapper'>
						<div class='bigPicture'>
						</div>
					</div>
				</div>
				<!-- /. imgBox -->
				<div class="infoBox">
					<div class="infoBoxHead">
						<div class="detailsRow" >
						<sec:authentication property="principal" var="pinfo" />
							<sec:authorize access="isAuthenticated()">
								<c:if test="${pinfo.username ne clothes.writer }">
									<c:if test="${like eq 'noLike'}">
										<a id="like" href="#"><i class="far fa-heart"></i></a>
									</c:if>
									<c:if test="${like eq 'isLike'}">
										<a id="like" href="#"><i class="fas fa-heart"></i></a>
									</c:if>
								</c:if>
							</sec:authorize>
							<span style="padding-left: 5px;">조회수: ${clothes.viewCnt }</span>
						</div>
						<div class="detailsInfo">
							<div class="pName" > ${clothes.productName }</div>
							<div class="isTrade">교환가능 여부 : 불가</div>
							<div class="priceRow">
								<span>가격</span> 
								<span>${clothes.price }</span>
							</div>
							<div class="countRow">
								<span class="count">수량</span> 
								<span>${clothes.count }</span>
							</div>
						</div>
					</div>
					<!-- 로그인한 사용자랑 일치할 경우 보여주게 처리함. -->
					<sec:authentication property="principal" var="pinfo" />
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.username eq clothes.writer }">
								<div class="infoBoxFoot">
									<button id="modify">수정하기</button>
									<button id="remove">삭제하기</button>
								</div>
							</c:if>
						</sec:authorize>
 					<div class="infoBoxFoot">
						 <button id="msg">판매자에게 메세지 발송</button>
					</div> 
				</div>
				<!-- /. infoBox -->
			</div>
		</div>
	</div>
</section>

<section class="section" style="padding-top: 40px">
	<div class="container">
		<div class="row" style="border-bottom: 1px solid #dedede">
			<h2 class="title">상세 정보</h2>
		</div>
		<div class="descriptRow">
		<!-- 	<div>*사이즈 :  <br/> *구성 :  <br/>  *퀄리티 : <br/>   *하자 : <br/>  </div> -->
			<div>${clothes.description }</div>
		</div>
	</div>
</section>

<section class="section" style="padding-top: 40px">
	<div class="container">
		<div class="row" style="border-bottom: 1px solid #dedede">
			<h2 class="title">댓글</h2>
		</div>
		<div class="row replyBox">
			<div class="replyDiv">
				<ul class="replyUL">
					<div>
						<li>작성된 댓글이 없습니다.</li>
					</div>
				</ul>
			</div>
			<div class="replyWriteBox">
				<textarea type="text" name="reply" cols="10"></textarea>
				<button class="existcheck-btn" id="addReplyBtn">댓글등록</button>
			</div>
		</div>
		<div class="replyPage">
			
        </div>
	</div>
</section>

<form class="objForm">
	<input type="hidden" name="pageNum" value="${cri.pageNum }"> 
	<input type="hidden" name="amount" value="${cri.amount }"> 
	<input type="hidden" name="type" value="${cri.type }"> 
	<input type="hidden" name="keyword" value="${cri.keyword }"> 

</form>

<script type="text/javascript" src="../resources/js/reply.js?ver=3"></script>

<script>
	$(document).ready(function() {

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		var objForm = $(".objForm");
		var removeBtn = $("#remove");
		var modifyBtn = $("#modify");
		var likeBtn = $("#like");
		
		var thumbImg = $(".thumbImg");
		var mainImg = $(".mainImg");
		
		var writeModal = $("#writeModal");
		var msgBtn = $("#msg");
		var sendBtn = $("#sendMsg");
		var cancelBtn = $("#cancelMsg");
		
		var replyBox = $(".replyBox");
		var replyWriteBox = $(".replyWriteBox");
		var replyDiv = $(".replyDiv");
		var addReplyBtn = $("#addReplyBtn");
		var cno = '<c:out value="${clothes.cno}"/>';
		
		var pageNum = 1;
		var replyPage = $(".replyPage");
		var loginUserid = null; // 비로그인사용자.
		
		<sec:authorize access="isAuthenticated()">
			loginUserid = "<sec:authentication property='principal.username'/>";
		</sec:authorize>
		
		showReplyList(1);
		
		(function() {
			var cno = '<c:out value="${clothes.cno}"/>';
			
			$.getJSON("/clothes/getAttachList", {cno : cno},function(arr) {
				// 대표이미지
				var strUL = "";
				
				var strDiv = "";
				if(arr.length == 0) {
					strUL += "<div>";
					strUL += "<img class='listImg' style='width: 100%; min-height: 400px; max-height: 400px' src='/resources/images/noimage.png' >";
					strUL += "</div>";

					$(".mainImg").html(strUL);
					return false;
				}
				
				$.each(arr,function(i, obj) {
					if (obj.fileType) {
						
						if(i == 0) {
							strUL += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
							strUL += "<div><img src='"+obj.thumbnail+"' style='width: 100%; min-height: 400px; max-height: 400px' ></div></li>";
						}
						
						strDiv += "<li style='margin-right: 5px;' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						strDiv += "<div><img src='"+obj.thumbnail+"' style='width: 112px; height: 112px;' ></div></li>";
						
					} else {
						// 이미지파일이 아닐 때
						strDiv += "<li style='margin-right: 5px;' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						strDiv += "<div><span>"+ obj.fileName+ "</span><br/>";
						strDiv += "<img src='/resources/data/X.svg.png'></div></li>";
					}
				});
				
				$(".mainImg").html(strUL);
				$(".thumbImg").html(strDiv);
				
			});
		})();

		removeBtn.on("click", function(e) {
			e.preventDefault();

			if(confirm("지우시겠습니까?")) {
				
				objForm.append('<input type="hidden" name="cno" value="${clothes.cno}">');
				objForm.append('<input type="hidden" name="writer" value="${clothes.writer}">');
				objForm.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">');
				objForm.attr("action","/clothes/remove").attr("method", "post");
				objForm.submit();
			}
		});
		
		modifyBtn.on("click", function(e) {
			e.preventDefault();

			objForm.append('<input type="hidden" name="cno" value="${clothes.cno}">');
			objForm.attr("action","/clothes/modify").attr("method", "get");
			objForm.submit();
		})
		
		likeBtn.on("click", "i", function(e) {
			e.preventDefault();
			var likeIcon = $(this).find("svg");
			var text = $(this).find("span");
			var likeClass = likeIcon.data("prefix");
			
			if(likeClass == "far") {
				
				$.ajax({
					type: 'post',
					url: '/like/add',
					data: JSON.stringify({cno: cno , userid: loginUserid }),
					contentType: "application/json; charset=utf-8",
					success: function(msg) {
						if(msg == "like") {
							likeIcon.attr("data-prefix", "fas");
							if(confirm("찜 목록에 등록되었습니다. 목록페이지로 이동하시겠습니까?")) {
								self.location = "/like";
							}
						}
					}
				})
			} else if(likeClass == "fas") {
				
				$.ajax({
					type: 'delete',
					url: '/like/'+cno+"/"+loginUserid,
					contentType: "application/json; charset=utf-8",
					success: function(msg) {
						likeIcon.attr("data-prefix", "far");
					}
				});
			}
		});
		
		msgBtn.on("click", function(e) {
			e.preventDefault();
			// 로그인한 사용자일 경우에만 나타나게한다. 비로그인 = null
			if(!loginUserid) {
				alert("로그인이 필요한 서비스입니다.")
				return false;
			}
			$("textarea[name='text']").val("");
			writeModal.modal("show");
		});
		
		sendBtn.on("click", function(e) {
			e.preventDefault();
			var text = $("textarea[name='text']").val();
			var receiver = '<c:out value="${clothes.writer}"/>'
			if(text.length >= 500) {
				alert("내용이 너무 깁니다.");
				return false;
			}
			
			$.ajax({
				type: 'post',
				url: '/message/write',
				data: JSON.stringify({sender: loginUserid, receiver: receiver, text: text}),
				contentType: "application/json; charset=utf-8",
				success: function(msg) {
					if(msg) {
						alert("성공적으로 메세지를 보냈습니다.");
						writeModal.modal("hide");
					}
				}
			}); 
		})
		
		cancelBtn.on("click", function(e) {
			e.preventDefault();
			
			writeModal.modal("hide");
		});
		
		mainImg.on("click", "img", function(e) {
			e.preventDefault();
			showImage($(this).attr('src'));
		});
		
		thumbImg.on("click", "img", function(e) {
			e.preventDefault();
			var str = "";
			
			var liTag = $(this).closest("li");
			
			var uuid = liTag.data("uuid");
			var path = liTag.data("path");
			var filename = liTag.data("filename");
			var type = liTag.data("type");
			
			var thumbnail = $(this).attr('src');
			
			str += "<li data-path='"+path+"' data-uuid='"+uuid+"' data-filename='"+filename+"' data-type='"+type+"'>"
			str += "<div><img src='"+thumbnail+ "' style='width: 100%; min-height: 400px  max-height: 400px' ></div></li>";
			
			mainImg.html(str);
			
		});
		// 등록기능
		addReplyBtn.on("click", function(e) {
			e.preventDefault();
		
			var replyBox = replyWriteBox.find("textarea[name='reply']");
			var reply = replyBox.val();
			var data = {cno: cno, reply: reply , replyer: loginUserid};
			
			replyService.add(data, function(result) {
				replyBox.val("");
				showReplyList(pageNum);
			}) 
		});
		
		replyDiv.on("click", "a", function(e) {
			e.preventDefault();
			
			var oper = $(this).data("oper");
			var parentDiv = $(this).closest("div");
			var cno = parentDiv.data("cno");
			var rno = parentDiv.data("rno");
			var str = "";
			
			var reply = parentDiv.find("li.reply").html();
			var replyer = parentDiv.find("li.replyer").html();
			var moddate = parentDiv.find("li.moddate").html();
			
			if(oper == "remove") {
				if(confirm("지우시겠습니까?")) {
					replyService.remove(rno, replyer, function(result) {
						showReplyList(pageNum);
					});
				}
			} else if(oper == "modify") {
				str += "<textarea type='text' name='reply' cols='10' data-oper='"+reply+"' style='width: 100%;'>"+reply+"</textarea>";			
				str += "<button class='small-btn' data-oper='modify' style='margin-right: 4px;'>수정</button>"
				str += "<button class='small-btn2' data-oper='cancel'>취소</button>"
				str += "<input type='hidden' name='replyer' value='"+replyer+"'>";
				str += "<input type='hidden' name='moddate' value='"+moddate+"'>";
				
				parentDiv.html(str);
			}
		});
		
		replyDiv.on("click", "button", function(e) {
			e.preventDefault();
			var str = "";
			var oper = $(this).data("oper");
			var parentDiv = $(this).closest("div");
			var rno = parentDiv.data("rno");
			var replyer = parentDiv.find("input[name='replyer']").val();
			var moddate = parentDiv.find("input[name='moddate']").val();
			var reply = parentDiv.find("textarea[name='reply']").val();
			var originalReply = parentDiv.find("textarea[name='reply']").data("oper");
			
			if(oper == "cancel") {
				
				str += "<i class='fas fa-user'></i> ";
				if(replyer == loginUserid) {
					str += "<a href='#' data-oper='modify' style='color: #999; font-size: 12px; margin: 0px 4px;'>수정하기</a>";
					str += "<a href='#' data-oper='remove' style='color: #999; font-size: 12px; margin: 0px 4px;'>삭제하기</a>";
				}
				str += "<li class='replyer'>"+replyer+"</li>";
				str += "<li class='reply'>"+originalReply+"</li>";
				str += "<li class='moddate'>"+moddate+"</li>";
				
				parentDiv.html(str);
				
			} else if(oper == "modify") {
				replyService.modify({rno:rno, reply:reply, replyer: loginUserid}, function(reply) {
				
					str += "<i class='fas fa-user'></i> ";
					if(replyer == loginUserid) {
						str += "<a href='#' data-oper='modify' style='color: #999; font-size: 12px; margin: 0px 4px;'>수정하기</a>";
						str += "<a href='#' data-oper='remove' style='color: #999; font-size: 12px; margin: 0px 4px;'>삭제하기</a>";
					}
					str += "<li class='replyer'>"+reply.replyer+"</li>";
					str += "<li class='reply'>"+reply.reply+"</li>";
					str += "<li class='moddate'>"+replyService.formatTime(moddate)+"</li>";
					
					parentDiv.html(str);
					showReplyList(pageNum);
				});
			}
		});
		
		function showReplyList(page) {
			var param = {page: page, cno: cno};
			
			if(!loginUserid) {
				var inputBox = replyWriteBox.find("textarea[name='reply']");
				inputBox.attr("readonly", "readonly").attr("placeholder", "로그인 후 입력가능합니다.");
				addReplyBtn.hide();
			}
			
			
			replyService.getList(param, function(list, replyCnt) {
				var str = "";
				if(!list || list.length == 0) {
					str += "<ul class='replyUL'>"
					str += "<li>작성된 댓글이 없습니다.</li></ul>";
					replyDiv.html(str);
					return false;
				}				
				
				$.each(list, function(i,obj) {
					
					str += "<ul class='replyUL'>";	
					str += "<div data-cno='"+obj.cno+"' data-rno='"+obj.rno+"'><i class='fas fa-user'></i> ";
					if(obj.replyer == loginUserid) {
						str += "<a href='#' data-oper='modify' style='color: #999; font-size: 12px; margin: 0px 4px;'>수정하기</a>";
						str += "<a href='#' data-oper='remove' style='color: #999; font-size: 12px; margin: 0px 4px;'>삭제하기</a>";
					}
					str += "<li class='replyer'>"+obj.replyer+"</li>";
					str += "<li class='reply'>"+obj.reply+"</li>";
					str += "<li class='moddate'>"+replyService.formatTime(obj.moddate)+"</li></div>";
					str += "</ul>";
					
				})
				replyDiv.html(str);
				showReplyPage(replyCnt);
			})
		}
		
		function showReplyPage(replyCnt) {
			
			var endNum = Math.ceil(pageNum / 10.0 ) * 10; 
			var startNum = endNum - 9;
			
			var prev = startNum > 1 ;
			var next = false;
			
			if(endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);
			}

			if(endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = "<ul class='pageRow'>";
			
			//  이전버튼 생성
			if(prev) {
				str += "<a class='pageBtn' href='"+(startNum-1)+"'><li class='prevBtn'>prev</li></a>";
			}

			for(var i = startNum; i <= endNum; i++) {
				var active = pageNum == i ? "active" : "";
				
				str += "<a class='pageBtn "+active+" ' href='"+i+"'><li>"+i+"</li></a>"
			}
		
			if(next) {
				str += "<a class='pageBtn' href='"+(endNum + 1)+"'><li class='nextBtn'>Next</li></a> ";
			}
			
			str += "</ul>";
			
			replyPage.html(str);
		}
		
		replyPage.on("click", "a", function(e) {
		
			e.preventDefault();
			
			var href = $(this).attr("href");
			
			pageNum = href; // 전역변수의 값을 덮어씀.
			
			showReplyList(pageNum);
			
		}) 
		
		function showImage(fileCallPath){
		    
		    $(".bigPictureWrapper").css("display","flex").show();
		    
		    $(".bigPicture")
		    .html("<img src='"+fileCallPath+"' >")
		    .animate({width:'80%', height: '80%'}, 1000);
		    
		  }//end fileCallPath
		  
		$(".bigPictureWrapper").on("click", function(e){
		    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function(){
		      $('.bigPictureWrapper').hide();
		    }, 1000);
		  });//end bigWrapperClick event
	});
</script>

<%@ include file="../includes/footer.jsp"%>