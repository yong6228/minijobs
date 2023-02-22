<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 프로젝트 조회</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/info/projectlist_detail.jsp"></jsp:include>

<script type="text/javascript">
	
var pagesize = 10;
var pagenumsize = 10;

var today = new Date();   

var year = today.getFullYear(); // 년도
var month = today.getMonth() + 1;  // 월
var date = today.getDate();  // 날짜 

/** OnLoad event */ 
$(function() {

	// 게시판 조회
	PJ();
	
	PButtonClickEvent();
	
	$("#searchvalue").keydown(function (key) {
        if (key.keyCode == 13) {
            $("#btnSearch").click();
        }
});
$("#searchvalue").focus();

});

/** 버튼 이벤트 등록 */
function PButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');
		
		switch (btnId) {
			case 'btnSearch' : // 검색 버튼
				PJ();
				break;
			case 'btnSave' :  // 수정버튼
				updatedelete();
				break;					
			case 'btnInsert' :  //신규 등록 버튼
				updatedelete();
				break;
			case 'btnClose' : // 목록보기 버튼
				gfCloseModal();
				break;	
			case 'btnDelete' : // 삭제 버튼
				$("#action").val("D"); // action html에 input타입에서 컨트롤러로 보내주고있음
				updatedelete();
				break;		
		}
	});
}




function PJ(clickpagenum) {
	
	clickpagenum = clickpagenum || 1;
	
	var param = {
			startDate : $("#startDate").val() ,
			endDate : $("#endDate").val() ,
			searchtype : $("#searchtype").val() ,
			searchvalue : $("#searchvalue").val() ,
			clickpagenum : clickpagenum,
			pagesize : pagesize
	};
	
	var searchcallback = function(returndata) {
		console.log("returndata : " + returndata);
		
		searchcallbackprocess(returndata,clickpagenum);
		
	}
	
	callAjax("/info/pjlist.do", "post", "text", true, param, searchcallback);
	
	
}

function searchcallbackprocess(returndata,clickpagenum) {
	
	$("#pjlist").empty().append(returndata);
	
	var totalcnt = $("#searchlistcnt").val();
	
	var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'PJ');
	console.log("paginationHtml : " + paginationHtml);
	//swal(paginationHtml);
	$("#comnfileuploadPagination").empty().append( paginationHtml );
	
	$("#hclickpagenum").val(clickpagenum);
}


	
function fPopModal() {		// 신규등록 버트에 모달
	$("#action").val("I");
	
	superinit();
	
	gfModalPop("#layer5");
}  
	
function superinit(object) {
	
	if (object == null || object=="") {
		$("#projectID").val(""); // 플젝 번호
		$("#corname").val(""); // 회사명
		$("#first").val(""); // 초급
		$("#mid").val(""); // 중급
		$("#high").val(""); // 고급
		$("#special").val(""); // 특급
		$("#swtype").val(""); // 회사 구분
		$("#projectname").val(""); //프로젝트이름
		$("#area").val(""); // 지역
		$("#job").val(""); // 직무
		$("#industry").val(""); // 산업
		$("#recvstart").val(""); // 모집시작일
		$("#recvend").val(""); // 모집마감일
		$("#workstart").val(""); // 근무시작일
		$("#workend").val(""); // 근무마감일
		$("#note").val(""); // 상새설명
		$("#prime").val(""); // 필수 우대 사항
		$("#etc").val(""); // 특이사항
		$("#workareadetail").val(""); // 근무장소
		$("#notebookyn").val(""); // 장비지원
		$("#houseyn").val(""); // 숙박제공
		$("#foodyn").val(""); //식사제공
		$("#corp_name").val(""); //파견회사
		
		
	
		$("#btnDelete").hide(); // 삭제버튼
		$("#btnSave").hide();  // 수정버튼
	
		$("#btnInsert").show();
	
		
		$("#projectname").focus();
	} else {
	
		$("#projectID").val(object.projectID); // 플젝 번호
		$("#corname").val(object.corname); // 회사명
		$("#swtype").val(object.swtype); // 회사 구분
		$("#first").val(object.first); // 초급
		$("#mid").val(object.mid); // 중급
		$("#high").val(object.high); // 고급
		$("#special").val(object.special); // 특급
		$("#projectname").val(object.projectname); //프로젝트이름
		$("#area").val(object.area); // 지역
		$("#job").val(object.projectID); // 직무
		$("#industry").val(object.job); // 산업
		$("#recvstart").val(object.recvstart); // 모집시작일
		$("#recvend").val(object.recvend); // 모집마감일
		$("#workstart").val(object.workstart); // 근무시작일
		$("#workend").val(object.workend); // 근무마감일
		$("#note").val(object.note); // 상새설명
		$("#prime").val(object.prime); // 필수 우대 사항
		$("#etc").val(object.etc); // 특이사항
		$("#workareadetail").val(object.workareadetail); // 근무장소
		$("#notebookyn").val(object.notebookyn); // 장비지원
		$("#houseyn").val(object.houseyn); // 숙박제공
		$("#foodyn").val(object.foodyn); //식사제공
		
		$("#btnSave").show();  // 수정버튼
		$("#btnDelete").show(); // 삭제버튼
		$("#btnInsert").hide(); // 등록버튼
		$("#corp_name").val(object.corp_name); //파견회사
		
	
	}
}

//단건조회 함수
function fselectone(projectID) {
	
	var param = {
			projectID : projectID
	}


	var resultcall = function( datas ) {
		console.log(JSON.stringify(datas));
		//console.log(JSON.stringify(selectonersn.searchone));
		
		$("#action").val("U");			
		superinit(datas.searchone);
		
		gfModalPop("#layer5");
	
}
	
callAjax("/info/selectlist.do", "post", "json", true, param, resultcall);
}


//업데이트(등록,수정) 하는  메소드
function updatedelete() {
	
	var param = {
			projectID : $("#projectID").val(),
			corname : $("#corname").val(),
			swtype : $("#swtype").val(),
			first : $("#first").val(),
			mid : $("#mid").val(),
			high : $("#high").val(),
			special : $("#special").val(),
			projectname : $("#projectname").val(),
			area : $("#area").val(),
			job : $("#job").val(),
			industry : $("#industry").val(),
			recvstart : $("#recvstart").val(),
			recvend : $("#recvend").val(),
			workstart : $("#workstart").val(),
			workend : $("#workend").val(),
			note : $("#note").val(),
			prime : $("#prime").val(),
			workareadetail : $("#workareadetail").val(),
			notebookyn : $("#notebookyn").val(),
			houseyn : $("#houseyn").val(),
			foodyn : $("#foodyn").val(),
			etc : $("#etc").val(),
			corp_name : $("#corp_name").val()
			
			
			
			
	};
	
	var savecallback= function(rtn) {
		console.log(JSON.stringify(rtn));
		
		alert("저장 하시겠습니까?");
		
		gfCloseModal();
		
		var savepageno = 1;
		
		if($("#action").val() == "U") {
			savepageno = $("#hclickpagenum").val();
		}
		
		PJ(savepageno);
		
	}
	callAjax("/info/savelist.do", "post", "json", true,  $("#myForm").serialize(), savecallback);
}


</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="projectID" name="projectID"  value="${projectID}" />
	<input type="hidden" id="loginID" value="${loginId}">
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
		                        class="btn_nav bold">정보 목록</span> <span class="btn_nav bold">프로젝트 목록</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
		                  </p>
		
		                  <p class="conTitle" style="height:100px;">
		                     <span style="line-height:100px">프로젝트 목록</span> <span class="fr">
		                     
		                     <select id="searchtype" name="searchtype" style="width: 150px;" >
			                     <option value="" >전체</option>
			                     <option value="p">프로젝트</option>
			                     <option value="a">지역</option>
			                     <option value="j">직무</option>
			                     <option value="i">산업</option>
			         
		                  	</select>
		                  	접수기간 :
		                  	<input type="date" id="startDate" name="startDate" style="width:100px;height:20px; text-align:center;"> ~
							<input type="date" id="endDate" name="endDate" style="width:100px;height:20px; text-align:center; margin-right:30px;">
		                 
		              
		                   
		                  <input type="text" id="searchvalue" name="searchvalue" style="width: 180px; height: 28px;margin:10px 10px;">
		                  	<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a><br>
		                  <a class="btnType blue" style= "float:right" href="javascript:fPopModal();" name="modal"><span>신규등록</span></a>
		                     </span>
		                  </p>
	                           
						<div class="divNoticeList">
							<table class="col" id="dateDay">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">회사</th>
										<th scope="col">구분</th>
										<th scope="col">프로젝트</th>
										<th scope="col">지역</th>
										<th scope="col">직무</th>
										<th scope="col">산업</th>
										<th scope="col">모집시작일</th>
										<th scope="col">모집마감일</th>
									</tr>
								</thead>
								<tbody id="pjlist"></tbody>
							</table>
						</div>
									<!--// 공지사항 테이블 페이지 네비게이션 -->
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
 
 		<!-- 모달팝업 -->
<div id="layer5" class="layerPop layerType2" style="overflow:scroll;  height : 800px; width: 1000px;">
		<dl>
			<dt>
				<strong>프로젝트 상세정보</strong>
			</dt>
			
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<tbody>
					<tr class="hidden">
						<th>아이디</th>
							<td colspan="8">
								<input type="hidden" class="inputTxt p100" name="projectID" id="projectID"/>
								<input type="hidden"class="inputTxt p100"   name="loginID" id="loginID" value="${loginID}">
							</td>
						</tr>
						<tr>
							<th>회사명 <span class="font_red">*</span></th>
							<td colspan="4">
								<input type="text" class="inputTxt p100" name="corname" id="corname" />
							</td>
							<th>프로젝트명 <span class="font_red">*</span></th>
							<td colspan="4">
								<input type="text" class="inputTxt p100" name="projectname" id="projectname" />
							</td>
						</tr>
						
						<tr>
							<th rowspan="2">상세 <span class="font_red">*</span></th>
							<td class="a">지역</td>
							<td colspan="3">
								<input type="text" class="inputTxt p100" name="area" id="area" />
							</td>
							<td class="a">직무</td>
							<td colspan="3">
								<input type="text" class="inputTxt p100" name="job" id="job" />
							</td>
						</tr>
						<tr>
							<td class="a">산업</td>
							<td colspan="3">
								<input type="text" class="inputTxt p100" name="industry" id="industry" />
							</td>
							<td class="a">구분</td>
							<td colspan="3">
								<input type="text" class="inputTxt p100" name="swtype" id="swtype" />
							</td>   
						</tr>
						
						<tr>
							<th>기술등급 <span class="font_red">*</span></th>
							<td class="a">초급</td>
							<td>
								<input type="text" class="inputText" name="first" id="first" /> 명
							</td>
							<td class="a">중급</td>
							<td>
								<input type="text" class="inputText" name="mid" id="mid" /> 명
							</td>
							<td class="a">고급</td>
							<td>
								<input type="text" class="inputText" name="high" id="high" /> 명
							</td>
							<td class="a">특급</td>
							<td>
								<input type="text" class="inputText" name="special" id="special" /> 명
							</td>
						</tr>
						<tr>
							<th>접수기간 <span class="font_red">*</span></th>
							<td colspan="4"> 시작 : &nbsp;&nbsp;
								<input type="text" class="inputText dates" name="recvstart" id="recvstart" style="font-size: 15px" />
							</td>
							<td colspan="4"> 마감 : &nbsp;&nbsp;
								<input type="text" class="inputText dates" name="recvend" id="recvend" style="font-size: 15px" />
							</td>
						</tr>
						<tr>
							<th>근무기간 <span class="font_red">*</span></th>
							<td colspan="4"> 시작 : &nbsp;&nbsp;
								<input type="text" class="inputText dates" name="workstart" id="workstart" style="font-size: 15px" />
							</td>
							<td colspan="4"> 종료 : &nbsp;&nbsp;
								<input type="text" class="inputText dates" name="workend" id="workend" style="font-size: 15px" />
							</td>
						</tr>
						<tr>
							<th>전문기술<span class="font_red">*</span></th>
							<td colspan="8">
								<div class="detail">
									<table class="row4">
										<tr>
										<th>Language<span class = "font_red"></span></th>
												<td colspan="2">
												<table>
												
													<input type="text" class="inputText" name="detail" id="detail" style="font-size: 15px" />
												
												</table>
												</td>
										
										
										<th>Language<span class = "font_red"></span></th>
												<td colspan="2">
												<table>
												
														<input type="text" class="inputText" name="detail" id="detail" style="font-size: 15px" />
														
												</table>
												</td>
										</tr>
									<tr>
										<th>Language<span class = "font_red"></span></th>
												<td colspan="2">
												<table>
												
														<input type="text" class="inputText" name="detail" id="detail" style="font-size: 15px" />
												
												</table>
												</td>
										
										
										<th>Language<span class = "font_red"></span></th>
												<td colspan="2">
												<table>
												
														<input type="text" class="inputText" name="detail" id="detail" style="font-size: 15px" />
														
												</table>
												</td>
										</tr>
										<tr>
										<th>Language<span class = "font_red"></span></th>
												<td colspan="2">
												<table>
												
														<input type="text" class="inputText" name="detail" id="detail" style="font-size: 15px" />
												
												</table>
												</td>
										
										
										<th>Language<span class = "font_red"></span></th>
												<td colspan="2">
												<table>
												
														<input type="text" class="inputText" name="detail" id="detail" style="font-size: 15px" >
														
												</table>
												</td>
										</tr>
									
									</table>
								</div>
							</td>
						</tr>
						
						<tr>
							<th>상세설명 <span class="font_red">*</span></th>
							<td colspan="8">
								<textarea rows="7" cols="80" class="inputTxt textareas" name="note" id="note" ></textarea>
							</td>
						</tr>
						<tr>
							<th>필수/우대사항 <span class="font_red">*</span></th>
							<td colspan="8">
								<textarea rows="7" cols="80" class="inputTxt textareas" name="prime" id="prime" ></textarea>
							</td>
						</tr>
						<tr>
							<th>특이사항 <span class="font_red">*</span></th>
							<td colspan="8">
								<textarea rows="7" cols="80" class="inputTxt textareas" name="etc" id="etc" ></textarea>
							</td>
						</tr>
						<tr>
						<th>근무장소 <span class="font_red">*</span></th>
							<td colspan="9">
								<select id="workareaall" name="workareaall"></select>&nbsp;&nbsp;<input type="text" class="inputText" name="workareadetail" id="workareadetail" /> 구/읍/면
							</td>
						</tr>
						<tr>
							<th>장비지원<span class="font_red">*</span></th>
							<td colspan="8">
								<input type="radio" id="notebookyn1" name="rgnotebookyn" value="Y" /> <label for="radio1-1">지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="notebookyn2" name="rgnotebookyn" value="N" /> <label for="radio1-2">미지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="notebookyn3" name="rgnotebookyn" value="M" /> <label for="radio1-3">추후협의</label>
							</td>
						</tr>
						<tr>
							<th>숙박제공 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="radio" id="houseyn1" name="rghouseyn" value="Y" /> <label for="radio1-1">지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="houseyn2" name="rghouseyn" value="N" /> <label for="radio1-2">미지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="houseyn3" name="rghouseyn" value="M" /> <label for="radio1-3">추후협의</label>
							</td>
						</tr>
						<tr>
							<th>식사제공 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="radio" id="foodyn1" name="rgfoodyn" value="Y" /> <label for="radio1-1">지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="foodyn2" name="rgfoodyn" value="N" /> <label for="radio1-2">미지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="foodyn3" name="rgfoodyn" value="M" /> <label for="radio1-3">추후협의</label>
							</td>
						</tr>
						<tr>
							<th>면접형태 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="checkbox" id="tel" name="tel">전화면접
								&nbsp;&nbsp;
								<input type="checkbox" id="join" name="join">직접면접
							</td>
						</tr>
						<tr>
							<th>작성회사</th>
							<td colspan="8">
								<input type="text" class="inputTxt p100" name="corp_name" id="corp_name" />
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
					<a href="" class="btnType blue" id="btnApplyProCod" name="btn"><span>지원하기</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>



</body>
</html>


















