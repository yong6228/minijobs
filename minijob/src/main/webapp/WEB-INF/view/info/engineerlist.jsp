<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/info/engineerlist_detail.jsp"></jsp:include>

<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}
}
</style>
<script type="text/javascript">
        var pageSizeinf  = 10;
        var pageBlockSizeinquiry  = 10;

		/* onload 이벤트  */
		$(function(){
			
			init();
			
			checklistResult();
			
			comcombo("areaCD", "areaall", "all", "");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
			comcombo("SKLCD", "sklall", "all", "");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
			//comcombo("industryCD", "industryall", "allindustry", "");   // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
			
			fListInf();
			
			// 버튼 이벤트 등록
			fRegisterButtonClickEvent();			
		});
		

		
		/** 버튼 이벤트 등록 */
		function fRegisterButtonClickEvent() {
			$('a[name=btnInfo]').click(function(e) {
				e.preventDefault();
					
				var btnId = $(this).attr('id');
				switch (btnId) {
					
					case 'searchBtn' :
						//debugger;
						// 개발자 조회
						fListInf();
						break;
					case 'btnCloseEngCod' :
						gfCloseModal();
						break;
	
					case 'btnSaveEngCod' :
						//debugger;
						fSaveEngCod();
						break;
			}
		});
	}
				  
				
		/** 개발자 조회 */
		function fListInf(currentPage) {
			//debugger;
			currentPage = currentPage || 1;
			
			console.log("currentPage : " + currentPage);
			
			var areaall = $('#areaall').val();
			var sklall = $('#sklall').val();
			var name = $('#name').val();
			
			console.log("areaall : " + areaall);
			console.log("sklall : " + sklall);
			
			var param = {
						areaall : areaall
					,	sklall : sklall
					,   name : name
					,	currentPage : currentPage
					,	pageSize : pageSizeinf
			}
			
			var resultCallback = function(data) {
				fListInfResult(data, currentPage);
			};
			
			//Ajax실행 방식
			//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
			//html로 받을거라 text
			callAjax("/info/listEngineerCod.do", "post", "text", true, param, resultCallback);
		}
		
		
		/** 개발자 조회 콜백 함수 */
		function fListInfResult(data, currentPage) {
			//debugger;
					//alert(data);
			console.log(data);		
			
			// 기존 목록 삭제
			$('#listInf').empty();
			$("#listInf").append(data);
			
			// 총 개수 추출
			var totalCntlistInf = $("#totcnt").val();
			var list = $("#selectedInfNo").val();
			// 페이지 네비게이션 생성
			var paginationHtml = getPaginationHtml(currentPage, totalCntlistInf, pageSizeinf, pageBlockSizeinquiry, 'fListInf',[list]);
			console.log("paginationHtml : " + paginationHtml);
		
			$("#listProjectPagination").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPageComnGrpCod").val(currentPage);
		}
	
	// 검색 리스트 눌렀을때 모달팝업 실행
	function fPopModal(registerId) {
			
			// 개발자 정보 인서트 시
			if (registerId == null || registerId == "") {
				$('#action').val("I");
				fInitModalList();
				gfModalPop("#layer1");
				
			// 개발자 정보 업데이트 시
			} else {
				$('#action').val("U");
				debugger;
				fModalList(registerId);
				gfModalPop("#layer1");
			}
			
			
		}
		
	// 개발자 정보 id로 조회하기위해 ajax param값 넘기기
	function fModalList(registerId) {
		debugger;
		var param = { registerId : registerId };
		
		var resultCallback = function(data) {
			fModalListResult(data);
		};
		
		callAjax("/info/listEngineerAll.do", "post", "json", true, param, resultCallback);
	};
	
	// 각각 input 위치와 db 연결 시키기
	function fModalListResult(data) {	
		
		console.log("fModalListResult : " + JSON.stringify(data));
		
		
		
		var model = data.model;
		var skill = data.skill;
		var category = data.category;
		
		$('#registerId').val(model.loginID);
		$('#registerName').val(model.name);
		$('#rggender').val(model.gender_cd);
		$('#birthday').val(model.birthday);
		$('#registerEmail').val(model.user_email);
		$('#detailaddr').val(model.user_zipcode);
		$('#loginaddr').val(model.user_address);
		$('#loginaddr1').val(model.user_dt_address);
		$('#tel1').val(model.user_tel1);
		$('#tel2').val(model.user_tel2);
		$('#tel3').val(model.user_tel3);
		$('#user_hope_work').val(model.user_hope_work);
		$('#career_yn').val(model.career_yn);
		$('#career_mm').val(model.career_mm);
		$('#salary').val(model.salary);
		$('#consult_yn').val(model.consult_yn);
		$('#user_describe').val(model.user_contents);
		$('#user_hope_area1').val(model.user_hope_area1);
		$('#user_hope_area2').val(model.user_hope_area2);
		$('#user_hope_area3').val(model.user_hope_area3);
		$('#user_grade').val(model.user_grade);
		$('#user_contents').val(model.user_describe);
		$('#singular_facts').val(model.singular_facts);
		$('#state_cd').val(model.state_cd);
		
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
		$.each(data.category, function(key, value){
			
			console.log("loop : " + key + " : " + value);  
		  
			$.each(value, function(key1, value1){
			  
				console.log("loop 2 : " + key1 + " : " + value1);  
			  
				if(key1 == "category") {
					console.log("check : " + value1);
	
					$("input:checkbox[id='" + value1 + "']").prop("checked", true);
				
				}
			  
		  	}); 
		}); 
		
		
		
		//$("input:checkbox[id='SI']").prop("checked", true);
		//$("input:checkbox[id='SM']").prop("checked", true);
		//$("input:checkbox[id='Solution']").prop("checked", true);
		
		
	}
	

	
	// 개발자 폼 초기화
	// 여기서 체크박스 항목을 초기화 시켜줘야 되는데 초기화 되지 않아 모달창을 열때마다 체크가 누적된다.(수정요)
	function fInitModalList(object) {
		$("#registerId").focus();
		
		
		if( object == "" || object == null || object == undefined) {
			$('#registerId').val("");
			$('#registerName').val("");
			$('#rggender').val("");
			$('#birthday').val("");
			$('#registerEmail').val("");
			$('#detailaddr').val("");
			$('#loginaddr').val("");
			$('#loginaddr1').val("");
			$('#tel1').val("");
			$('#tel2').val("");
			$('#tel3').val("");
			$('#user_hope_work').val("");
			$('#career_yn').val("");
			$('#career_mm').val("");
			$('#salary').val("");
			$('#consult_yn').val("");
			$('#user_describe').val("");
			$('#user_hope_area1').val("");
			$('#user_hope_area2').val("");
			$('#user_hope_area3').val("");
			$('#user_grade').val("");
			$('#user_contents').val("");
			$('#singular_facts').val("");
			$('#state_cd').val("");
			$('#btnDeleteGrpCod').hide();
			
			checkclear();
			
			
		} else {
			
			$('#registerId').val(object.loginID);
			$('#registerName').val(object.name);
			$('#rggender').val(object.gender_cd);
			$('#birthday').val(object.birthday);
			$('#registerEmail').val(object.user_email);
			$('#detailaddr').val(object.user_zipcode);
			$('#loginaddr').val(object.user_address);
			$('#loginaddr1').val(object.user_dt_address);
			$('#tel1').val(object.user_tel1);
			$('#tel2').val(object.user_tel2);
			$('#tel3').val(object.user_tel3);
			$('#user_hope_work').val(object.user_hope_work);
			$('#career_yn').val(object.career_yn);
			$('#career_mm').val(object.career_mm);
			$('#salary').val(object.salary);
			$('#consult_yn').val(object.consult_yn);
			$('#user_describe').val(object.user_contents);
			$('#user_hope_area1').val(object.user_hope_area1);
			$('#user_hope_area2').val(object.user_hope_area2);
			$('#user_hope_area3').val(object.user_hope_area3);
			$('#user_grade').val(object.user_grade);
			$('#user_contents').val(object.user_describe);
			$('#singular_facts').val(object.singular_facts);
			$('#state_cd').val(object.state_cd);
			
			
			
			
		}
	}	
	
	/** 그룹코드 저장 */
	function fSaveEngCod() {
		//debugger;
		// vaildation 체크
		if ( ! fValidateEngCod() ) {
			return;
		}
		
		var resultCallback = function(data) {
			fSaveEngCodResult(data);
		};
		
		callAjax("/info/saveEngineerCod.do", "post", "json", true, $("#myForm1").serialize(), resultCallback);
	}
	
	/** 그룹코드 저장 콜백 함수 */
	function fSaveEngCodResult(data) {
		
		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageComnGrpCod").val();
		}
		
		if (data.result == "SUCCESS") {
			
			// 응답 메시지 출력
			swal(data.resultMsg);
			
			// 모달 닫기
			gfCloseModal();
			
			checkclear();
			
			// 목록 조회
			fListInf(currentPage);
			
		} else {
			// 오류 응답 메시지 출력
			swal(data.resultMsg);
		}
		
		// 입력폼 초기화
		fInitFormGrpCod();
	}
	
	
	/** 그룹코드 저장 validation */
	function fValidateEngCod() {

		var chk = checkNotEmpty(
				[
						[ "registerId", "아이디를 입력해 주세요." ]
					,	[ "registerName", "이름을 입력해 주세요" ]
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
<form id="myForm" method="">
<input type="hidden" id="currentPageComnGrpCod" value="1">
<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="selectedInfNo" value="">
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

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
	               
					<div class="content" style="margin-bottom:20px;">
                       
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">정보목록 / 개발자목록</span> <a href="../info/engineerlist.do"
								class="btn_set refresh">새로고침</a>
						</p>

					   <!-- 개발자 조회 -->
						<div class="selectProject" >
							<table width="100%" cellpadding="5" cellspacing="0" border="1"
		                        align="left" 
		                        style="border-collapse: collapse; border: 10px #50bcdf; ">
		                        <tr style="border: 10px; border-color: blue">
		                           <td width="150" height="25" style="font-size: 150%; font-weight: bold;">개발자 조회</td>
		                           <td width="30" height="25" style="font-size: 100%"></td>
		                           <td width="100" height="25" style="font-size: 100%">지역전체&nbsp;</td><td><select id="areaall" name="areaall">	</select></td>          
		                           <td width="30" height="25" style="font-size: 100%"></td>
		                           <td width="100" height="25" style="font-size: 100%">초급&nbsp;</td><td><select id="sklall" name="sklall">	</select></td>          
		                    	   <td width="30" height="25" style="font-size: 100%"></td>
		                           <td width="100" height="25" style="font-size: 100%">이름&nbsp;</td><td><input id="name" name="name"></input></td>          
		                     
		                           <td width="120" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>        
		                           <td width="100" height="60" style="font-size: 120%">
		                           <a href="javascript:fListInf()" class="btnType blue" id="searchBtn" name="btnInfo"><span>검  색</span></a></td> 
		                           <td width="20" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>        
		                        </tr>
		                        <tr>
		                        	<td width="100" height="60" align="right">
		                        	<a href="javascript:fPopModal();" class="btnType blue" name="modal"><span>신규등록</span></a></td> 
		                     </table>    
						</div>
				
						<div class="divListProject">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
						
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">성명</th>
										<th scope="col">제목</th>
										<th scope="col">희망지역</th>
										<th scope="col">등급</th>
										<th scope="col">전문기술</th>
										<th scope="col">회원상태</th>
									</tr>
								</thead>
								<tbody id="listInf">
									<tr>
										<td colspan="12">조건에 맞는 개발자 목록이 조회됩니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="listProjectPagination"> </div>
						
			
						
					</div> <!--// content -->

					</li>
			</ul>
		</div>
	</div>
	

	
	
					

		
</form>
</body>
</html>


