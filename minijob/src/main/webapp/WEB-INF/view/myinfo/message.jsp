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

var pagesize = 5;
var pagenumsize = 5;

/** OnLoad event */ 
$(function() {

	// 게시판 조회

	message_1();
	
	MButtonClickEvent();
	
	$("#searchvalue").keydown(function (key) {
        if (key.keyCode == 13) {
            $("#btnSearch").click();
        }
});
$("#searchvalue").focus();

});

/** 버튼 이벤트 등록 */
function MButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');
		
		switch (btnId) {
			case 'btnSearch' : // 검색 버튼
				message_1();
			break;
			case 'btnSave' :  // 수정버튼
				titlenone();
				break;					
			case 'btnInsert' :  //신규 등록 버튼
				titlenone();
				break;
			case 'btnClose' : // 목록보기 버튼
				gfCloseModal();
				break;	
			case 'btnDelete' : // 삭제 버튼
				$("#action").val("D"); // action html에 input타입에서 컨트롤러로 보내주고있음
				fsaveNotice();
				break;			
			
			
		}
	});
}
function message_1(clickpagenum) {
	console.log("나오나");
	
	clickpagenum = clickpagenum || 1;
	
	var param = {
			
			searchtype : $("#searchtype").val() ,
			searchvalue : $("#searchvalue").val() ,
		
			clickpagenum : clickpagenum,
			pagesize : pagesize
	};
	
	var searchcallback = function(returndata) {
		console.log("returndata : " + returndata);
		
		searchcallbackprocess(returndata,clickpagenum);
		
	}
	
	callAjax("/myinfo/message1.do", "post", "text", true, param, searchcallback);
	
	
}

function searchcallbackprocess(returndata,clickpagenum) {
	console.log("뭐가문제지");
	$("#message1").empty().append(returndata);
	
	var totalcnt = $("#searchlistcnt").val();
	
	var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'message_1');
	console.log("paginationHtml : " + paginationHtml);
	//swal(paginationHtml);
	$("#comnfileuploadPagination").empty().append( paginationHtml );
	
	$("#hclickpagenum").val(clickpagenum);
}

function fPopModal() {		// 신규등록 버트에 모달
	$("#action").val("I");
	
	JJ();
	
	gfModalPop("#layer1");
}  

function JJ(object) {
	console.log("뭐가 null을 타는거지?");
	if (object == null || object=="") {
		$("#note_id").val(""); // 순번 텍스트
		$("#loginID").val(""); // 로그인 텍스트
		$("#note_date").text(year + '-' + month + '-' + date); // 오늘날짜 텍스트
		$("#note_date").val(""); // 날짜 텍스트
		$("#note_content").text("");// 내용 텍스트
		$("#send_id").text($("#send_id").val()); // 받는자 텍스트
		$("#recd_id").text($("#recd_id").val()); // 작성자 텍스트
		
		$("#btnDelete").hide(); // 삭제버튼
		$("#btnSave").hide();  // 수정버튼
		$("#btnInsert").show();
		
		$("#note_title").show(); // 제목  텍스트 
		
		$("#note_title").focus();
	} else {
		$("#note_id").val(object.note_id); // 순번 텍스트
		$("#loginID").val(object.loginID); // 로그인 텍스트
		$("#note_title").val(object.note_title); // 제목 텍스트
		$("#note_date").text(object.note_date); // 등록일 텍스트
		$("#note_content").val(object.note_content); // 내용 텍스트
		$("#send_id").text(object.send_id); // 작성자 텍스트
		$("#recd_id").text(object.recd_id); // 작성자 텍스트
		
		
		$("#btnSave").show();  // 수정버튼
		$("#btnDelete").show(); // 삭제버튼
		$("#btnInsert").hide(); // 등록버튼

		$("#note_title").hide(); // 제목  텍스트 
	
	}

	
}


//단건조회 함수
function fselectone(note_id) {
	console.log("로그인 아이디를 타나 안타나???");
	var param = {
			note_id : note_id
	}


	var searchcb = function( selectonersn ) {
		console.log(JSON.stringify(selectonersn));
		//console.log(JSON.stringify(selectonersn.searchone));
		
		$("#action").val("U");			
		JJ(selectonersn.searchone);
		
		gfModalPop("#layer1");
	
}
	
callAjax("/myinfo/selectj.do", "post", "json", true, param, searchcb);
}

//업데이트(등록,수정) 하는  메소드
function ud() {
	
	var param = {
			note_id : $("#note_id").val(),
			loginID : $("#loginID").val(),
			note_title : $("#note_title").val(),
			note_date : $("#note_date").val(),
			note_content : $("#note_content").val(),
			send_id : $("#send_id").val(),
			recd_id : $("#recd_id").val(),
			action : $("#action").val()
	};
	
	var savecallback= function(rtn) {
		console.log(JSON.stringify(rtn));
		
		alert("저장 하시겠습니까?");
		
		gfCloseModal();
		
		var savepageno = 1;
		
		if($("#action").val() == "U") {
			savepageno = $("#hclickpagenum").val();
		}
		
		message_1(savepageno);
		
	}
	callAjax("/info/savenote.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
}

	
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="note_id" name="note_id"  value="${note_id}" />
	<input type="hidden" id="swriter" value="${loginId}">
	<input type="hidden" id="sortflag" value="1">
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				
				<li class="contents">
		               <!-- contents -->
		               <h3 class="hidden">contents 영역</h3> <!-- content -->
		               <div class="content">
		               
		               <p class="Location">
		                     <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
		                        class="btn_nav bold">마이페이지</span> <span class="btn_nav bold">쪽지</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
		                  </p>
		
		                  <p class="conTitle" style="height:100px;">
		                     <span style="line-height:100px">쪽지</span> <span class="fr">
		                   
		                    <label><input type="checkbox" name="check1"  id="check1" value="blue"> 수신</label>
    						  <label><input type="checkbox" name="check2"  id="check2"  value="red"> 발신</label>
									
						
									
								<label style="margin-left: 5%"> 일자 </label> 
								<input class="datetype" style="margin-left: 1%" type="date" name = "startDate" id="startDate" >
								<input class="datetype" type="date" name = "endDate" id="endDate">
		                  
		                  사용자:
		                  <input type="text" id="searchvalue" name="searchvalue" style="width: 180px; height: 28px;margin:10px 10px;">
		                  	<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
		                      <a class="btnType blue" style= "float:right" href="javascript:fPopModal();" name="modal"><span>쪽지쓰기</span></a>
		                     </span>
		                  </p>
	                           
						<div class="divNoticeList">
							<table class="col" id="dateDay">
								<caption>caption</caption>
								<colgroup>
									<col width="60%">
									<col width="40%">
									
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">일자</th>
										<th scope="col">작성자</th>
										
									</tr>
								</thead>
								<tbody id="message1"></tbody>
							</table>
						</div>
									<!--// 공지사항 테이블 페이지 네비게이션 -->
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
						
					
 
 <div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				
			</dt>
			
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="300px">
						<col width="*">
					</colgroup>

					<tbody>
					
						<tr>
							<th> <strong id="note_id"></strong> <strong id="loginID">
							</strong><strong id="note_title">제목</strong></th>
							<td><input type="text" class="inputTxt p100" name="note_title" id="note_title" /></td>
						</tr>
							<th><strong>작성자</strong></th>
							
							<td style="display:flex; justify-content:space-between; line-height:27px;">
							 	<strong><span id="recd_id"></span></strong>
							 	<th><strong>작성자</strong></th>
							
							<td style="display:flex; justify-content:space-between; line-height:27px;">
							 	<strong><span id="send_id"></span></strong>
							 	<span>
								<strong>작성일 :<span id="note_date"></span></strong>           
								
								</span>							
							</td>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="note_content" id="note_content" > </textarea>
						   </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30" style="display:flex; justify-content:space-between;">
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>목록보기</span></a> 
					<span>
					<a href="" class="btnType blue" id="btnInsert" name="btn"><span>등록</span></a>
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
					</span> 
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div> 

	<!--// 모달팝업 -->
</form>

</body>
</html>
