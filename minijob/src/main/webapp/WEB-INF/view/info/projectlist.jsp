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
	var pageSizeinf  = 5;
	var pageBlockSizeinquiry  = 5;
	
	/* onload 이벤트  */
	$(function(){
		
		init();
		
		var usertype = $("#usertype").val();
		
		if(usertype == "A") {	
			$('#btnInsertProCod').show();
			$('#btnSaveProCod').show();
			$('#btnDeleteProCod').show();
			$('#btnApplyProCod').hide();
		} else {
			$('#projectname').attr("readonly", true);
			$('#corname').attr("readonly", true);
			$('#rgareaall').not(":selected").attr("disabled", "disabled");
			$('#rgjoball').not(":selected").attr("disabled", "disabled");
			$('#rgindustryall').not(":selected").attr("disabled", "disabled");
			$('#swcdall').not(":selected").attr("disabled", "disabled");
			$('#first').attr("readonly", true);
			$('#mid').attr("readonly", true);
			$('#high').attr("readonly", true);
			$('#special').attr("readonly", true);
			$('#recvstart').attr("readonly", true);
			$('#recvend').attr("readonly", true);
			$('#workstart').attr("readonly", true);
			$('#workend').attr("readonly", true);
			$('#note').attr("readonly", true);
			$('#prime').attr("readonly", true);
			$('#etc').attr("readonly", true);
			$('#workareaall').not(":selected").attr("disabled", "disabled");
			$('#workareadetail').attr("readonly", true);
			
			// 체크박스 수정불가
			$(function() {
			    $(':checkbox').change(function() {
			      this.checked = !this.checked;
			    });
			    $(':checkbox').focus(function() {
			      this.blur();
			    });
			});	

			$('#rgareaall').css("color", "#000000");
			$('#rgjoball').css("color", "#000000");
			$('#rgindustryall').css("color", "#000000");
			$('#swcdall').css("color", "#000000");
			$('#workareaall').css("color", "#000000");
			
			$('#btnInsertProCod').hide();
			$('#btnSaveProCod').hide();
			$('#btnDeleteProCod').hide();
			$('#btnApplyProCod').show();
		}
		
		
		checklistResult();
		
		comcombo("areaCD", "areaall", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
		comcombo("JOBCD", "joball", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
		comcombo("industryCD", "industryall", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value ) 
		comcombo("areaCD", "rgareaall", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
		comcombo("JOBCD", "rgjoball", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
		comcombo("industryCD", "rgindustryall", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )
		comcombo("SWCD", "swcdall", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )
		comcombo("WACD", "workareaall", "all");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )
		
		fListInf();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				switch (btnId) {
					
					case 'searchBtn' :
						// 프로젝트 조회
						fListInf();
						break;
						
					case 'btnCloseProCod' :
						$("input:checkbox").attr("checked", false);
						gfCloseModal();
						break;
						
					case 'btnSaveProCod' :
						fSaveProCod();
						break;
					
					case 'btnApplyProCod':
						fApplyProCod();
						break;
						
					case 'btnDeleteProCod' :
						$("input:checkbox").attr("checked", false);
						fDeleteProCod();
						break;
			}
		});
	}
	
	// 신규등록 리스트 눌렀을때 모달팝업 실행
	function fPopModal(projectID) {
			// 신규등록
			if (projectID == null || projectID == "") {
				$("#action").val("I");
				console.log($("#action").val());
				// 프로젝트 폼 초기화
				fInitModalList();
				
				// 모달 팝업
				gfModalPop("#layer1");
				
			// 개발자 정보 업데이트 시
			} else {
				$("#action").val("U");
				
				fModalList(projectID);
				
				gfModalPop("#layer1");
			}
			
		}
	
	// 프로젝트 폼 초기화
	function fInitModalList(object) {
		
		$("#projectID").focus();
		
		if( object == "" || object == null || object == undefined) {
			
			$('#projectID').val("");
			$('#projectname').val("");
			$('#corname').val("");
			$('#rgareaall').val("");
			$('#rgjoball').val("");
			$('#rgindustryall').val("");
			$('#swcdall').val("");
			$('#first').val("");
			$('#mid').val("");
			$('#high').val("");
			$('#special').val("");
			$('#recvstart').val("");
			$('#recvend').val("");
			$('#workstart').val("");
			$('#workend').val("");
			$('#note').val("");
			$('#prime').val("");
			$('#etc').val("");
			$('#workareaall').val("");
			$('#workareadetail').val("");

			$("input:radio[name=rgnotebookyn]:radio[value='Y']").attr("checked", true);
			$("input:radio[name=rghouseyn]:radio[value='Y']").attr("checked", true);
			$("input:radio[name=rgfoodyn]:radio[value='Y']").attr("checked", true);
			
			$('#wname').attr("readonly", true);
			
			$("input:checkbox").attr("checked", false);
			$('#btnDeleteProCod').hide();
		} else {
			$('#projectID').val(object.projectID);
			$('#loginID').val(object.loginID);
			$('#projectname').val(object.projectname);
			$('#corname').val(object.corname);
			$('#rgareaall').val(object.area);
			$('#rgjoball').val(object.job);
			$('#rgindustryall').val(object.industry);
			$('#swcdall').val(object.swtype);
			$('#first').val(object.first);
			$('#mid').val(object.mid);
			$('#high').val(object.high);
			$('#special').val(object.special);
			$('#recvstart').val(object.recvstart);
			$('#recvend').val(object.recvend);
			$('#workstart').val(object.workstart);
			$('#workend').val(object.workend);
			$('#note').val(object.note);
			$('#prime').val(object.prime);
			$('#etc').val(object.etc);
			$('#workareaall').val(object.workarea);
			$('#workareadetail').val(object.workareadetail);
			$('#wname').val(object.wname);

			$('#projectname').focus();
			$("#btnDeleteProCod").show();	
		}
	}
	
	/** 프로젝트 조회 */
	function fListInf(currentPage) {
		currentPage = currentPage || 1;
		
		console.log("currentPage : " + currentPage);
		
		var areaall = $('#areaall').val();
		var joball = $('#joball').val();
		var industryall = $('#industryall').val();
		
		var param = {
				areaall : areaall
			,	joball : joball
			, 	industryall : industryall
			,	currentPage : currentPage
			,	pageSize : pageSizeinf
		}
		
		var resultCallback = function(data) {
			fListInfResult(data, currentPage);
		};
		
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		//html로 받을거라 text
		callAjax("/info/listProjectCod.do", "post", "text", true, param, resultCallback);
	}
	
	/** 프로젝트 조회 콜백 함수 */
	function fListInfResult(data, currentPage) {
					//alert(data);
			console.log(data);		
			
			// 기존 목록 삭제
			$('#listInf').empty();
			$("#listInf").append(data);
			 
			// 총 개수 추출
			var totalCntlistInf = $("#totalCntlistInf").val();
			var list = $("#selectedInfNo").val();
			
			// 페이지 네비게이션 생성
			var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, pageSizeinf, pageBlockSizeinquiry, 'fListInf');
			console.log("paginationHtml : " + paginationHtml);
		
			$("#listProjectPagination").empty().append( paginationHtml );
		
			// 현재 페이지 설정
			$("#currentPageComnGrpCod").val(currentPage);
		}
	
	// 프로젝트 정보 id로 조회하기위해 ajax param값 넘기기
	function fModalList(projectID) {
		
		var param = { projectID : projectID };
		
		var resultCallback = function(data) {
			fModalListResult(data);
		};
		
		callAjax("/info/listProjectAll.do", "post", "json", true, param, resultCallback);
	};
	
	// 각각 input 위치와 db 연결 시키기
	function fModalListResult(data) {	
		
		console.log("fModalListResult : " + JSON.stringify(data));
		
		var model = data.model;
		var skill = data.skill;
		var interviewtype = data.interviewtype;
		
		$('#projectID').val(model.projectID);
		$('#loginID').val(model.loginID);
		$('#projectname').val(model.projectname);
		$('#corname').val(model.corname);
		$('#rgareaall').val(model.area);
		$('#rgjoball').val(model.job);
		$('#rgindustryall').val(model.industry);
		$('#swcdall').val(model.swtype);
		$('#first').val(model.first);
		$('#mid').val(model.mid);
		$('#high').val(model.high);
		$('#special').val(model.special);
		$('#recvstart').val(model.recvstart);
		$('#recvend').val(model.recvend);
		$('#workstart').val(model.workstart);
		$('#workend').val(model.workend);
		$('#note').val(model.note);
		$('#prime').val(model.prime);
		$('#etc').val(model.etc);
		$('#workareaall').val(model.workarea);
		$('#workareadetail').val(model.workareadetail);
		$("input:radio[name=rgnotebookyn]:radio[value='"+model.notebookyn+"']").attr("checked", true);
		$("input:radio[name=rghouseyn]:radio[value='"+model.houseyn+"']").attr("checked", true);
		$("input:radio[name=rgfoodyn]:radio[value='"+model.foodyn+"']").attr("checked", true);
		$('#wname').val(model.wname);
		
		$('#wname').attr("readonly", true);
		
		
		//debugger;
		// each문 2번써서 json에서 string 추출
		// 저장된 배열에서 string 가져오기
		// 가져온 값에 prop으로 체크설정 하기
		$.each(data.skill, function(key, value){
			
			console.log("loop : " + key + " : " + value);  
		  
			$.each(value, function(key1, value1){
			  
				console.log("loop 2 : " + key1 + " : " + value1);  
			  
				if(key1 == "detail_code") {
					console.log("check : " + value1);
	
					$("input:checkbox[id='" + value1 + "']").prop("checked", true);
				
				}
			  
		  	}); 
		}); 
		debugger;
		$.each(data.interviewtype, function(key, value){
			
			console.log("loop : " + key + " : " + value);  
		  
			$.each(value, function(key1, value1){
			  
				console.log("loop 2 : " + key1 + " : " + value1);  
			  
				if(key1 == "interviewtype") {
					console.log("check : " + value1);
	
					$("input:checkbox[id='" + value1 + "']").prop("checked", true);
				
				}
			  
		  	}); 
		}); 
	}
	
	
	/* 프로젝트 저장*/
	function fSaveProCod() {
		// vaildation 체크
		if ( ! fValidateProCod() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveProCodResult(data);
		};
		
		callAjax("/info/saveProjectCod.do", "post", "json", true, $("#myForm1").serialize(), resultCallback);
	}
	
	/** 그룹코드 저장 콜백 함수 */
	function fSaveProCodResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageComnGrpCod").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			$("input:checkbox").attr("checked", false);
			
			// 모달 닫기
			gfCloseModal();
			
			// 목록 조회
			fListInf(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitModalList();
	}
	
	function fDeleteProCod() {
		swal("정말 삭제하겠습니까? \n삭제시 복구불가합니다.", {
			  buttons:{
				  yes : "예",
				  no : "아니오"
			  }
			}).then((value) => {  /* 이건 이클립스가 게을러서 뜨는 에러!  */
				switch(value){
				case "yes":
					
					var resultCallback = function(data) {
					fDeleteProjectCodResult(data);
					};
				
					callAjax("/info/deleteProjectCod.do", "post", "json", true, $("#myForm1").serialize(), resultCallback);
				
					break;
				case "no": 
					break;
				}
			});
	}
	
	/** 그룹코드 삭제 콜백 함수 */
	function fDeleteProjectCodResult(data) {
		
		var currentPage = $("#currentPageComnGrpCod").val();
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			// 그룹코드 목록 조회
			fListInf(currentPage);
			
		} else {
			swal(data.resultMsg);
		}	
	}
	
	
	/** 프로젝트 저장 validation */
	function fValidateProCod() {

		var chk = checkNotEmpty(
			[
				[ "corname", "회사명을 입력해 주세요" ], 
				[ "projectname", "프로젝트명을 입력해 주세요." ]
			]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
</script>

</head>
<body>
<form id="myForm"  method="">
<input type="hidden" id="currentPageComnGrpCod" value="1">
<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="selectedInfNo" value="">
<input type="hidden" id="usertype" value="${usertype}">

	<!-- 모달 배경 -->
	<div id="mask"></div>
	
	<div id="wrap_area">
		
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include 
					page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				<li class="contents" style="padding:0 20px;width:1060px;background:#fff;">
					<!-- contents -->
					<h2 class="hidden">contents 영역</h2> <!-- content -->
					
					<div class="content" style="margin-bottom:20px;">
					
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">정보목록 / 프로젝트목록</span>  <a href="../info/projectMain.do"
								class="btn_set refresh">새로고침</a>
						</p>
						
						<!-- 프로젝트 조회 -->
						<p class="conTitle" style="margin-bottom: 1%;">
							<span>프로젝트 조회</span> 
							<span class="fr"> 
								<a class="btnType blue"  href="javascript:fPopModal()" name="modal" id="btnInsertProCod"><span>신규등록</span></a>
							</span>
						</p>
							<div class="selectProject">
							<table width="100%" cellpadding="5" cellspacing="0" border="1" 
							align="left" 
							style="border-collapse: collapse; border: 10px #50bcdf; ">
								<tr style="border: 10px; border-color: blue">
									<td width="20" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
									<td width="250" height="25" style="font-size: 150%; font-weight: bold;">프로젝트 조회</td>
									<td width="20" height="25" style="font-size: 100%"></td>
									<td width="60" height="25" style="font-size: 100%">지역&nbsp;</td>
									<td>
										<select id="areaall" name="areaall"></select>
									</td>          
									<td width="20" height="25" style="font-size: 100%"></td>
									<td width="60" height="25" style="font-size: 100%">직무&nbsp;</td>
									<td>
										<select id="joball" name="joball">	</select>
									</td>          
									<td width="20" height="25" style="font-size: 100%"></td>
									<td width="60" height="25" style="font-size: 100%">산업&nbsp;</td>
									<td>
										<select id="industryall" name="industryall">	</select>
									</td>          
									<td width="120" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>        
									<td width="100" height="60" style="font-size: 120%">
										<a href="javascript:fListInf()" class="btnType blue" id="searchBtn" name="btn"><span>검  색</span></a>
									</td>
									<td width="20" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>        
								</tr>
							</table>
						</div>
						
						<div class="divListProject">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="8%">
									<col width="32%">
									<col width="5%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">회사명</th>
										<th scope="col">프로젝트명</th>
										<th scope="col">지역</th>
										<th scope="col">직무</th>
										<th scope="col">산업</th>
										<th scope="col">모집시작일</th>
										<th scope="col">모집마감일</th>
										<th scope="col">작성회사</th>
									</tr>
								</thead>
								<tbody id="listInf">
									<tr>
										<td colspan="10">조건에 맞는 프로젝트가 조회됩니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="listProjectPagination"> </div>
						
					</div>
				</li>
			</ul>
		</div>
	</div>
</form>
</body>
</html>


















