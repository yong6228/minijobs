<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 개인회원정보 </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정 
	var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
	var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수
	
	/* onload 이벤트  */
	$(function(){
		//debugger;
		fSelectPersCod();
		
	});
	
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
	function fButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault(); // ?? 
					
			var btnId = $(this).attr('id');
			
			//alert("btnId : " + btnId);
			
			switch(btnId){
			case 'btnSaveNotice' : fSaveNotice(); // save 안에 저장,수정
				//alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDeleteNotice' : fDeleteNotice();	// 만들자 
				//alert("삭제버튼 클릭!!!이벤트!!");		
				break;
			case 'btnClose' : gfCloseModal();  // 모달닫기 
			selectNoticeList(); // 첫페이지 다시 로딩 
				break;
			case 'btnUpdateNotice' : fUpdateNotice();  // 수정하기
				break;
			case 'searchBtn' : selectNoticeList();  // 검색하기
				break;
				
			//case 'commentWrite' : fCommentInsert();   // 댓글--> 답변글로 변경 // 저장 
				//break;
			}
		});
	}
	
	 // 로그인한 회원 정보 조회
	 
	 function fSelectPersCod() {
			//debugger;
			var param = { };
			
			var resultCallback = function(data) {
				fSelectPersCodResult(data);
			};
			
			callAjax("/myinfo/fSelectPersCod.do", "post", "json", true, param, resultCallback);
		}
	 
	 
	 function fSelectPersCodResult(data) {	
		    //alert("fSelectGrpCodResult : " + JSON.stringify(data));
		    console.log("fSelectPersCodResult : " + JSON.stringify(data));
		 
		 
			
			var model = data.modelC;
			
			//alert("loginID : " +model.loginID);
			//alert("loginID : " +model.password);
			
			$('#loginID').val(model.loginID);
			$('#password').val(model.password);
			$('#name').val(model.name);
			$('#user_email').val(model.user_email);
			$('#birthday').val(model.birthday);
			$('#user_tel1').val(model.user_tel1);
			
			
		}
	 
	 
	 /* 공지사항 게시판 1건 삭제 */
	 /* function fDeleteNotice(){
		 var con = confirm("정말 삭제하겠습니까? \n 삭제시 복구불가합니다."); 
		 if(con){
			 var resultCallback3 = function(data){
				 fSaveNoticeResult(data);
			 }
			 $("#action").val("D");  // delete
			 callAjax("/system/noticeDelete.do", "post", "json", true, $("#myNotice").serialize(), resultCallback3);
			 // num만 넘겨도되지만 그냥 귀찮으니깐...^^... 
		 }else{
			 gfCloseModal();	// 모달 닫기
			 selectNoticeList(currentPage); // 목록조회 함수 다시 출력 
			 frealPopModal();// 입력폼 초기화
		 }
	 } */
	 
	 
	
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myNotice" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="tmpList" value=""> <!-- ★ 이거뭐임??? -->
	<input type="hidden" id="tmpListNum" value=""> <!-- 스크립트에서 값을 설정해서 넘길거임 / 임시 리스트 넘버 -->
	<input type="hidden" name="action" id="action" value="">  
	<input type="hidden" id="session" name="session" value="${loginID}"> <!-- 작성자 session에서 java에서 넘어온값 -->
	
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav bold">마이페이지</a> 
								<span class="btn_nav bold">기업회원</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
					<!--검색창  -->
					<table width="100%" cellpadding="5" cellspacing="0" border="3"   align="left"    style="border-collapse: collapse; border: 1px #50bcdf;"> 
                               <caption>회사회원 정보</caption>
								<colgroup>
									<col width="10%">
									<col width="23%">
									<col width="10%">
									<col width="23%">
									<col width="10%">
									<col width="23%">
								</colgroup>
								<thead>
								       <tr>
								              <td height="40" style="font-size: 100%">아이디</td>
                                              <td height="40" style="font-size: 100%">
                                                              <input type="text" style="width: 120px" id="loginID" name="loginID">
                                              </td>  		 
 								              <td height="40" style="font-size: 100%">비밀번호</td>
                                              <td height="40" style="font-size: 100%">
                                                              <input type="text" style="width: 120px" id="password" name="password">
                                              </td>  	  
 								              <td height="40" style="font-size: 100%">회사명</td>
                                              <td height="40" style="font-size: 100%">
                                                              <input type="text" style="width: 120px" id="name" name="name">
                                              </td>  	   
								       </tr>
								       <tr>
                                               <td height="40" style="font-size: 100%">이메일</td>
                                               <td colspan=3>
                                                      <input type="text" style="width: 150px" id="user_email" name="user_email">@
                                                       <select name = "email">
									                            	<option value = "">직접입력</option>
									                            	<option value = "apple.com">Apple</option>
									                            	<option value = "google.com">Google</option>
									                            	<option value = "naver.com">네이년</option>
									                            	<option value = "hanmail.net">카카오</option>
                            						 </select>
                                               </td>
 								              <td height="40" style="font-size: 100%">담당자명</td>
                                              <td height="40" style="font-size: 100%">
                                                              <input type="text" style="width: 120px" id="title" name="title">
                                              </td>  
								       </tr>
								        <tr>
 								              <td height="40" style="font-size: 100%">생년월일</td>
                                              <td height="40" style="font-size: 100%">
                                                              <input type="date" style="width: 120px" id="birthday" name="birthday">
                                              </td>  
 								              <td height="40" style="font-size: 100%">전화번호</td>
                                              <td height="40" style="font-size: 100%"colspan=3>
                                                              <select style  = "width:50px" name = "phone">
										                            	<option value = "010">010</option>
										                            	<option value = "011">011</option>
										                            	<option value = "017">017</option>
										                            	<option value = "본드">007</option>
                           								    </select>
                                                           <input type="text" style="width: 150px height: 40px" id="user_tel1" name="user_tel1">
                                              </td>  
								        </tr>
                                        <tr>
 								              <td height="40" style="font-size: 100%">내역정보</td>
                                              <td height="40" style="font-size: 100%" colspan=5>
																<textarea id="story" name="story"   rows="10" >
																          
																</textarea>
                                              </td>  
								        </tr>
                                        <tr>
 								              <td align="center" height="40" colspan=6> 
							                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>수정 취소</span></a> 
							                           <a href="" class="btnType blue" id="searchBtn" name="btn"><span>수정 완료</span></a>
 								              </td>
								        </tr>
								        
								</thead>
                        </table> 
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

 

</form>

</body>
</html>
