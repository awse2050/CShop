<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<section class="section" >
	<div class="container">
		<div class="row">
			<%@ include file="../includes/aside.jsp"%>
			<div class="bodyRow">
					<!-- 검색 -->
				<!-- <div style="border: 5px solid #e8e8e8; margin:30px 0px;">
					<div style="padding: 25px;">
					</div>
				</div> -->
				<div class="bodyHeader">
					<div class="header-title">
						상품목록
					</div>
					<div class="header-location">
						HOME > 마이페이지 > 상품목록
					</div>
				</div>
				<div class="tableDiv"> <!-- 이상이 있으면 해당 div 제거 -->
					<table class="like-table">
						<thead>
							<tr>
								 <th style="width: 10%;">번호</th>
								<th>상품정보</th>
								<th style="width: 10%;">판매가</th>
								<th style="width: 20%;">선택</th> 
							</tr>
						</thead>
						<tbody class="likeBody">
							
						</tbody>
					</table>
				</div>
			</div>		
		</div>
	</div>
</section>

<form class="objForm">
	<input type="hidden" name="cno" >
</form>

<script>
	
	$(document).ready(function() {
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	
		
		(function() {
			
			var userid = '<sec:authentication property="principal.username" />';
			var likeBody = $(".likeBody");
			var tableDiv = $(".tableDiv");
			
			$.getJSON("/mypage/goods/"+userid, function(list) {
				var str = "";
				
				if(list.length == 0 ) {
					str += "<div style='text-align: center;'>";
					str += "<img src='https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDA3MTBfNjAg%2FMDAxNTk0MzYyMTgxMDA5.B9ywGytTEKcRnmPvjlHdOPgDk-GaQjAOUI3TFvRpITog.fsNX9J3JEnEbok0gP44cfTAZ0xtqToURwJnxtVnG9Mog.JPEG.wsw6088%2FIMG_3850.JPG&type=sc960_832'>"
					str += "<div style='font-size: 24px; font-weight: 700;'> 등록하신 게시물이 없습니다. </div>";
					
					tableDiv.html(str);
					return false;
				}
				
				$.each(list, function(i, obj) {
					var fileCallPath = encodeURIComponent(obj.thumbnailUrl);
					str += "<tr data-cno='"+obj.cno+"' data-user='"+userid+"'>";
					str += "<td>"+obj.cno+"</td>";
					str += "<td style='text-align:left;'>"
					if(obj.thumbnailUrl == null) {
						str += "<a href='"+obj.cno+"'><img style='width:100px; height: 100px;' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPsAAADJCAMAAADSHrQyAAAAY1BMVEX///+VlZWPj4/j4+O0tLT7+/ucnJyfn5/b29uSkpKkpKSrq6uurq7m5uZmZmaWlpbz8/OIiIjs7Ox5eXlkZGRsbGzNzc2BgYF0dHTU1NRvb2+7u7ve3t7w8PDCwsKKiopcXFxuhZvhAAAELklEQVR4nO3b25KiOhQG4HBIICgHUQgg6rz/U85Kgt3OlNDs6mrdrPm/Kwtzwc9KApIoBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAU3LBu8/tR8k23i2IW77xcxXqRaGq332OPyRSOviCVjwrX5dfRg+CsH33af6Eqerhc/fLouN3n+cPqF10rdvombzVfLNHrsNrlT//ulZ8s+e+6uVM9Ivi2+f9NDcbfaq65pjdT3PzHX4aD2fNL/uUTc91+MR3+HEM2WX301yQzDyyTVcmyEXKLns+DeY2f353m2bBUYieW/aPpzk981TjZzmKzq7u9dfP8KSMbFtu2Xdrogepa8ssexU+Sfr35QhH35hZ9shnV3N89sg35ph94Xep+wkT+i7PMnu50KBknj1ZaJDpz+zM7u/IvtCAeXb9D2dfXfd/ea5D9pec1ysg+0IDZPefMc+/5LxeAdkXGjxmb3m9o/4vz3W5vU7Msq+su1/AYLQGvT77/TU9n70Hq7N/sU67RWuz31fnGUVfmX2sta86q51Gq7Lra+KjRy87r1dYlT3wVQ9YVX1t9oDbNOeszs5rmnP8usxCg/JedWYdXny9LtP7suuS1zTn+LprtX9OhVN0flX/XIed2Tt87/AMqy4e5vF5DKc5776JaiE6u5vbh3r30b21fYjRbgB8bEDQesdxrN9d8iWckwMAAAAAAAAA/A/FqqyEONtliTExJptez1S7sxBXpXr6nCfKbTDJy+lvg73yDa/u7ySbfYsng6GhfOpE0bpuv+tM5Y5XByVF3DQZfW6bQdtj16Zxixd9YeJsuFX0vUo2nF2Ux+NOiISyx4P9y+Pg12Z89uFg6HPSGbdaVQadvRSyPF7oQpxSERfVG8/8+8qbogra7MqWPD/6/VNT9uxIXdvog627NLE2969ESn0gLi5vPffvKsNrEz1m37vDU5+/dqkQp7PLHnXpeaCwl8N9vXbz2W91Ec9mT81VpMVobPb2mPd2bnjMHlWXarsbrsqbMLe57EUdKnE1tcu+M1XenX32KI7jiMbEsevMdl/clzdJPTmbyV7tjcxK6bLfSn/UZu/DQ0HjvWn7vt9y3eU49LPZWyp9LGx2WVDNE2rj+rzsCwZz3U1Wh11STNnrP7NfquLc9S572jSnU9Pk03hPeWQXmQkKW1MauWP3eI8rLtIc6CZus8cDdXCa+UV1CyWX7BU9uJnCPrZdhcjsTC4+s4tk6IQb7+pAiauCap4N1KZ12Wmev2x2vMuQerpsml+USzfD0CQ+SmVKKfa/anp+S4Q8hjQY3J2tM1LUxjakobAvGhoI291QHdn/84+p3SFd9efzOFVRjhEN/lSKKrUjIRIydfeyiA6JCzXsc7oIqbXt51oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+K7fw2lApeR5FTgAAAAASUVORK5CYII='></a>"; 
						str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					} else {
						str += "<a href='"+obj.cno+"'><img src='/display?fileName="+obj.thumbnailUrl+"'></a>"; 
						str += "<span style='margin-left: 15px; font-weight: 700;'>상품명 : "+obj.productName+"</span></td>";
					}
					str += "<td>"+obj.price+"원</td>";
					str += "<td>";
					str += "<button class='small-btn' style='margin-right: 5px;' data-oper='modify'>수정</button>"
					str += "<button class='small-btn2' data-oper='remove'>삭제</button>"
					str += "</td>";
					str += "</tr>"
				});
				
				likeBody.html(str); 
			});
		})(); 
				
		var imgTag = $(".imgTag");
		var objForm = $(".objForm");
		
		var likeBody = $(".likeBody");
		
		likeBody.on("click", "button", function(e) {
			e.preventDefault();
			var oper = $(this).data("oper");
			var parentTr = $(this).closest("tr");
			var cno = parentTr.data("cno");
			var writer = '<sec:authentication property="principal.username"/>';
			
			if(oper == "modify") {
				
				objForm.find("input[name='cno']").val(cno);
				objForm.attr("action", "/clothes/modify").submit();
				
			} else if(oper == "remove") {

				if(confirm("지우시겠습니까?")) {
					objForm.find("input[name='cno']").val(cno);
					objForm.append("<input type='hidden' name='writer' value='"+writer+"'>");
					objForm.append("<input type='hidden' name='requestUri' value='/mypage/goods'>");
					objForm.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">');
					objForm.attr("action","/clothes/remove").attr("method", "post");
					objForm.submit();
				}
			}
		});
		
		likeBody.on("click", "a", function(e) {
			e.preventDefault();
		
			var cno = $(this).attr("href");
			
			objForm.find("input[name='cno']").val(cno);
			objForm.attr("action", "/clothes/get").submit();
			
		});
	});
	
</script>
		

<%@ include file="../includes/footer.jsp"%>
			