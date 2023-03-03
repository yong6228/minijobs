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
				등록수정();
				break;					
			case 'btnInsert' :  //신규 등록 버튼
				등록수정();
				break;
			case 'btnClose' : // 목록보기 버튼
				gfCloseModal();
				break;	
			case 'btnDelete' : // 삭제 버튼
				$("#action").val("D"); // action html에 input타입에서 컨트롤러로 보내주고있음
				등록수정();
				break;		
		}
	});
}

function PJ(clickpagenum) {
	console.log("검색 리스트 확인");
	clickpagenum = clickpagenum || 1;
	
	var param = {
			loginID : $("#loginID").val() ,
			projectID : $("#projectID").val() ,
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
	
	
function pPopModal() {		// 신규등록 버트에 모달
	$("#action").val("I");
	
	PJ_forminit();
	
	gfModalPop("#layer7");
}  

function PJ_forminit(object) {
	console.log("모달창에 데이터를 뿌려봅니다~!");
	if (object == null || object=="") {
		console.log("값이 있는지 없는지 테스트");
		$("#projectID").val(""); // 프로젝트 번호
		$("#projectname").val(""); // 프로젝트 이름
		$("#loginID").val("");
		$("#corname").val("");
		$("#area").val("");
		$("#job").val("");
		$("#industry").val("");
		$("#swtype").val("");
		$("#first").val("");
		$("#mid").val("");
		$("#high").val("");
		$("#special").val("");
		$("#workstart").val("");
		$("#workend").val("");
		$("#note").val("");
		$("#prime").val("");
		$("#etc").val("");
		$("#workarea").val("");
		$("#workareadetail").val("");
		$("input:radio[name=notebookyn]:radio[value='Y']").attr("checked", true);
		$("input:radio[name=houseyn]:radio[value='Y']").attr("checked", true);
		$("input:radio[name=foodyn]:radio[value='Y']").attr("checked", true);
		$("#recvstart").val("");
		$("#recvend").val("");
		$("#detail").val("");
		$("#interviewtype").val("");
		
		
		$("#btnApply").hide(); // 지원버튼
		$("#btnDelete").hide(); // 삭제버튼
		$("#btnSave").hide();  // 수정버튼
		
		$("#btnInsert").show(); //등록
	
		
		$("#projectname").focus();
	} else {
		
		console.log("else 값 들어가나 확인합니다");
		
		$("#projectID").val(object.projectID); // 프로젝트 번호
		$("#projectname").val(object.projectname); // 프로젝트 이름
		$("#loginID").val(object.loginID); // 로그인;
		$("#corname").val(object.corname); // 회사이름
		$("#area").val(object.area); // 지역
		$("#job").val(object.job); // 직무
		$("#industry").val(object.industry); // 산업 
		$("#swtype").val(object.swtype); // 구분
		$("#first").val(object.first); // 초급
		$("#mid").val(object.mid); // 중급
		$("#high").val(object.high); // 고급
		$("#special").val(object.special); // 특급
		$("#workstart").val(object.workstart); // 일시작일
		$("#workend").val(object.workend); // 일끝내는일
		$("#note").val(object.note); // 상세설명
		$("#prime").val(object.prime); // 우대사항
		$("#etc").val(object.etc); // 특이사항
		$("#workarea").val(object.workarea); // 일하는곳
		$("#workareadetail").val(object.workareadetail); // 상세주소
		$("#notebookyn").val(object.notebookyn); // 장비지원 
		$("#foodyn").val(object.foodyn); // 식사제공
		$("#houseyn").val(object.houseyn); // 숙박제공
		$("#recvstart").val(object.recvstart); // 접수기간 시작
		$("#recvend").val(object.recvend); // 접수기간 종료
		$("#detail").val(object.detail); // 전문기술
		$("#interviewtype").val(object.interviewtype); // 인터뷰 타입
		
		
		$("#btnSave").show();  // 수정버튼
		$("#btnDelete").show(); // 삭제버튼
		$("#btnInsert").hide(); // 등록버튼
		$("#btnApply").hide(); // 지원버튼
		$("#projectname").hide(); // 제목
		
	
	}
}


//단건조회 함수
function pselectone(projectID) {
	console.log("단건 조회 함수");
	var param = {
			projectID : projectID
	}


	var searchAll = function( selectoneALL ) {
		console.log(JSON.stringify(selectoneALL));
		//console.log(JSON.stringify(selectoneALL.searchone + "이거 문제 있나요?"));
		
		$("#action").val("U");			
		PJ_forminit(selectoneALL.searchone);
		
		gfModalPop("#layer7");
	
}
	callAjax("/info/selectpjlist.do", "post", "json", true, param, searchAll);
}



</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="projectID" name="projectID"  value="" />
	<input type="hidden" id="loginID" value="${loginID}">

	
	
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
		                        class="btn_nav bold">정보목록</span> <span class="btn_nav bold">프로젝트 목록</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
		                  </p>
		
		                  <p class="conTitle" style="height:100px;">
		                     <span style="line-height:100px">프로젝트 목록</span> <span class="fr">
		                     
		                     <select id="searchtype" name="searchtype" style="width: 150px;" >
			                     <option value="" >전체</option>
			                     <option value="pjn">프로젝트이름</option>
			                     <option value="cn">회사이름</option>
			                      <option value="area">지역</option>
			                     <option value="recvend">마감일</option>
		                  	</select>
		                   <input type="date" id="startDate" name="startDate" style="width:100px;height:20px; text-align:center;"> ~
							<input type="date" id="endDate" name="endDate" style="width:100px;height:20px; text-align:center; margin-right:30px;">
		                  <input type="text" id="searchvalue" name="searchvalue" style="width: 180px; height: 28px;margin:10px 10px;">
		                  	<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a><br>
		                      <a class="btnType blue" style= "float:right" href="javascript:pPopModal();" ><span>신규등록</span></a>
		                     </span>
		                  </p>
	                           
						<div class="divNoticeList">
							<table class="col" id="dateDay">
								<caption>caption</caption>
								<colgroup>
									<col width="12%">
									<col width="25%">
									<col width="10%">
									<col width="5%">
									<col width="5%">
									<col width="8%">
									<col width="22.5%">
									<col width="22.5%">
								</colgroup>
								
								<thead>
									<tr>
									<th scope="col">프로젝트 번호</th>
										<th scope="col">프로젝트 이름</th>
										<th scope="col">회사명</th>
										<th scope="col">지역</th>
										<th scope="col">직무</th>
										<th scope="col">산업</th>
										<th scope="col">작성일</th>
										<th scope="col">모집마감</th>
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
<div id="layer7" class="layerPop layerType1" style="overflow:scroll; height:800px; width: 1000px; ">
		<dl>
			<dt>
				<strong>프로젝트 상세정보</strong>
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
					<tr class="hidden">
						<th>아이디</th>
							<td colspan="8">
								<input type="hidden" class="inputTxt p100" name="projectID" id="projectID"/>
								<input type="hidden"class="inputTxt p100"   name="loginID" id="loginID" value="${loginID}">
							</td>
						</tr>
						<tr>
							<th>프로젝트명 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="text" class="inputTxt p1000" name="projectname" id="projectname" />
							</td>
						</tr>
						<tr>
							<th>회사명 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="text" class="inputTxt p1000" name="corname" id="corname" />
							</td>
						</tr>
						<tr>
							<th rowspan="2">선택 <span class="font_red">*</span></th>
							<td class="a">지역</td>
							<td colspan="3">
								<input type="text" class="inputText" name="area" id="area" /> 
							</td>
							<td class="a">직무</td>
							<td colspan="3">
								<input type="text" class="inputText" name="job" id="job" /> 
							</td>
						</tr>
						<tr>
							<td class="a">산업</td>
							<td colspan="3">
								<input type="text" class="inputText" name="industry" id="industry" /> 
							</td>
							<td class="a">구분</td>
							<td colspan="3">
								<input type="text" class="inputText" name="swtype" id="swtype" /> 
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
							<th>전문기술 <span class="font_red">*</span></th>
							<td colspan="8">
							     <input type="text" class="inputTxt p1000" name="detail" id="detail" style="font-size: 15px" />
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
							<input type="text" class="inputText" name="workareadetail" id="workareadetail" /> 구/읍/면
							</td>
						</tr>
					<tr>
							<th>장비지원<span class="font_red">*</span></th>
							<td colspan="8">
								<input type="radio" id="notebookyn1" name="notebookyn" value="Y" /> <label for="radio1-1">지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="notebookyn2" name="notebookyn" value="N" /> <label for="radio1-2">미지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="notebookyn3" name="notebookyn" value="M" /> <label for="radio1-3">추후협의</label>
							</td>
						</tr>
						<tr>
							<th>숙박제공 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="radio" id="houseyn1" name="houseyn" value="Y" /> <label for="radio1-1">지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="houseyn2" name="houseyn" value="N" /> <label for="radio1-2">미지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="houseyn3" name="houseyn" value="M" /> <label for="radio1-3">추후협의</label>
							</td>
						</tr>
						<tr>
							<th>식사제공 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="radio" id="foodyn1" name="foodyn" value="Y" /> <label for="radio1-1">지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="foodyn2" name="foodyn" value="N" /> <label for="radio1-2">미지원</label>
								&nbsp;&nbsp;
								<input type="radio" id="foodyn3" name="foodyn" value="M" /> <label for="radio1-3">추후협의</label>
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
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30" style="display:flex; justify-content:space-between;">
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>목록보기</span></a> 
					<span>
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
					<a href="" class="btnType blue" id="btnApply" name="btn"><span>지원하기</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
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


















