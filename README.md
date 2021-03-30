# CShop (**진행 중**)


중고 매물 구매 및 판매 사이트

 > 기존의 백엔드만 구현했던 연습과 더불어 직접 프론트엔트 조작을 익히기 위한 목적으로 작성되는 프로젝트
 
 > Front-End CSS는 Header, Footer를 제외한 body는 모두 직접 구현하는 방식으로 진행함.
 
 > 클론하기에 조금 데이터가 부족한 웹사이트이므로 우선 만들어져있는 부분을 구현 한 후에
 
 > 추가적으로 넣을 기능을 넣는 방식으로 진행
---------------------
**사용되는 기술**
- Spring
- MyBatis
- MySQL
- JQuery
- etc...

------------------------

**진행 상황**

## 3.21
+ 공지사항
  + 목록 (O)
  + 댓글 
  + 등록페이지 
> 댓글 및 등록페이지를 알 수 없으므로 임의로 설정
  
+ 등록화면
  + 번호, 카테고리 선택(우선 1개), 이미지, 상품명, 수량, 판매가, 상세설명 (O)
  + 입력창 CSS (O)
> 추후 로그인 한 유저의 마이페이지에서 등록할수 있게 변경 (기존 사이트 기준)

+ 목록화면
  + 목록 뿌리기 (O)
  + 해당 게시글의 이미지 표출 (O)
  + 페이지 이동 및 게시글 표시 개수 필터링 (O)
  + 검색 ( CSS 조정 필요 ) (O)
> 검색창 위치 변경 

+ 상세페이지
  + 전체적인 CSS 작업 필요
  + 이미지 및 상세한 설명 표시 (O)
  + 댓글(O)
> 수정 및 삭제의 경우 1차적으로 게시물 상세페이지를 통해서 버튼으로 가능하게하며
>  
> 추후 마이페이지에서 수정 및 삭제하도록 변경
 
 + 회원가입
   + 약관 (2)
   + 가입 상세 페이지 (O)
   + 가입 페이지 CSS (90%)
   + 주소 API 적용 (O)
   

> DB 테이블 칼럼 변경 (id, name, nickname, password, email, phone, address) (O)

## 3.29
 + 찜목록(진행중)
   + 컨트롤러 설계 (O)
   + 찜 리스트 화면 (O)
   + 화면단 CSS
 ### 간단한 로직 구현 ( 시큐리티 미적용 ) 
 
## 3.30 
 + 마이페이지
   + 판매목록
   + 회원 정보(수정, 탈퇴)
  
