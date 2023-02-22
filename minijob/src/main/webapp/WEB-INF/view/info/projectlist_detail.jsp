<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 프로젝트 상세조회</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<link rel="stylesheet" type="text/css"	href="${CTX_PATH}/css/admin/login.css" />
<style type="text/css">

.content	input.inputText{
	/* display:inline-table; */
	width: 40%;
	height: 28px;
	border: 1px solid #cdcdcd;
	line-height: 23px;
}

.content	input.dates{
	/* display:inline-table; */
	width: 60%;
	height: 28px;
	border: 1px solid #cdcdcd;
	line-height: 23px;
}

div.layerType2 > dl  dd table.row4 > tbody > tr > th {
	background: #bbc2cd;
}
	
table.row4 {
	width: 100%;
}
table.row4 > tbody > tr > th	{
	padding:0 15px;
	width: 130px;
	height: 37px;
	font-weight: bold;
	border: 1px solid #e5e5e5;
	background-color: #f4f4f4;
}
table.row4 > tbody > tr > td	{
	height: 27px;
	padding:5px 10px;
	border: 1px solid #e5e5e5;
	color:#868686;
}

table.row4 > tbody > tr > td.a {
	width: 50px;
}

table tbody td textarea.textareas	{
	width: 100%;
	padding-left:2px;
	height: 100px;
	text-align:left;
	vertical-align: top;
}

</style>
<script type="text/javascript">





</script>

</head>
<body>
<form id="myForm1" action=""  method="">
<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="selectedInfNo" value="">
<input type="hidden" name="action" id="action" value="">
<input type="hidden" name="webCD" id="webCD" value="webCD">
<input type="hidden" name="DBCD" id="DBCD" value="DBCD">
<input type="hidden" name="LanguageCD" id="LanguageCD" value="LanguageCD">
<input type="hidden" name="OSCD" id="OSCD" value="OSCD">
<input type="hidden" name="FWCD" id="FWCD" value="FWCD">
<input type="hidden" name="NTCD" id="NTCD" value="NTCD">
<input type="hidden" name="WSCD" id="WSCD" value="WSCD">

	<!-- 모달 배경 -->
	<div id="layer1" class="layerPop layerType2" style="overflow:scroll; height:800px; width: 1000px; ">
		<dl>
			<dt>
				<strong>프로젝트 상세정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row4">
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
							<td colspan="8">
								<input type="text" class="inputTxt p100" name="corname" id="corname" />
							</td>
						</tr>
						<tr>
							<th>프로젝트명 <span class="font_red">*</span></th>
							<td colspan="8">
								<input type="text" class="inputTxt p100" name="projectname" id="projectname" />
							</td>
						</tr>
						<tr>
							<th rowspan="2">선택 <span class="font_red">*</span></th>
							<td class="a">지역</td>
							<td colspan="3">
								<select id="rgareaall" name="rgareaall"></select>
							</td>
							<td class="a">직무</td>
							<td colspan="3">
								<select id="rgjoball" name="rgjoball">	</select>
							</td>
						</tr>
						<tr>
							<td class="a">산업</td>
							<td colspan="3">
								<select id="rgindustryall" name="rgindustryall">	</select>
							</td>
							<td class="a">구분</td>
							<td colspan="3">
								<select id="swcdall" name="swcdall">	</select>
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
								<div class="dtl_cod">
			 						<table class="row4">
				 						<tr>
											<th>Language <span class="font_red">*</span></th>
												<td colspan="2">
												    <table>
												      <template v-for="(row, index) in langitems1" v-if="langitems1.length" v-model="chkbox"> 
												      <tr>
												        <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
													    <td>{{ row.dtl_cod_nm }}</td>
													  </tr>  
													  </template>
												    </table>
			                                   </td>
											<th>WEB <span class="font_red">*</span></th>
												<td colspan="2">
												    <table>
												      <template v-for="(row, index) in langitems2" v-if="langitems2.length" v-model="chkbox"> 
												      <tr>
												          <td><input type="checkbox"  :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
													      <td>{{ row.dtl_cod_nm }}</td>
													  </tr>    
													  </template>
												    </table>
											    </td>	    
										</tr>
										<tr>
											<th>DB <span class="font_red">*</span></th>
											<td colspan="2">
											      <table>
											       <template v-for="(row, index) in langitems3" v-if="langitems3.length" v-model="chkbox"> 
											         <tr>
											             <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
												         <td>{{ row.dtl_cod_nm }}</td>
												     </tr>
												    </template> 
											     </table>
			                                </td>
											<th>Web Server <span class="font_red">*</span></th>
											<td colspan="2">
											    <table>
											      <template v-for="(row, index) in langitems4" v-if="langitems4.length" v-model="chkbox"> 
											       <tr>
											          <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
												      <td>{{ row.dtl_cod_nm }}</td>
												   </tr>   
												   </template>
											    </table>
									        </td>
										</tr>
										<tr>
											<th>OS <span class="font_red">*</span></th>
											<td colspan="2">
											      <table>
											       <template v-for="(row, index) in langitems5" v-if="langitems5.length" v-model="chkbox"> 
											         <tr>
											             <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
												         <td>{{ row.dtl_cod_nm }}</td>
												     </tr>
												    </template> 
											     </table>
			                                </td>
											<th>FrameWork <span class="font_red">*</span></th>
											<td colspan="2">
											    <table>
											      <template v-for="(row, index) in langitems6" v-if="langitems6.length" v-model="chkbox"> 
											       <tr>
											          <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
												      <td>{{ row.dtl_cod_nm }}</td>
												   </tr>   
												   </template>
											    </table>
									        </td>
										</tr>
										<tr>
											<th>Network <span class="font_red">*</span></th>
											<td colspan="2">
											      <table>
											       <template v-for="(row, index) in langitems7" v-if="langitems7.length" v-model="chkbox"> 
											         <tr>
											             <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
												         <td>{{ row.dtl_cod_nm }}</td>
												     </tr>
												    </template> 
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
								<input type="text" class="inputTxt p100" name="wname" id="wname" value="${wName}" />
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveProCod" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteProCod" name="btn"><span>삭제</span></a>
					<a href="" class="btnType blue" id="btnApplyProCod" name="btn"><span>지원하기</span></a>
					<a href=""	class="btnType gray"  id="btnCloseProCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>
</body>
</html>