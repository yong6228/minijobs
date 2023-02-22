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

function init() {
	check = new Vue({
		el: '#layer1',
		data : {
			langitems: [],
			langitems1: [],
			langitems2: [],
			langitems3: [],	
			langitemss: [],
			langitemarea1: [],
			langitemarea2: [],
			langitemarea3: [],
			listlistCod: '',
			weblistCod:'',
			dblistCod:'',
			wslistCod:'',
			sklcdlistCod:'',
			areacdlistCod:'',
			skillgrpcd:'',
			skilldtlcd:''
			
		}
	})
 }
 
/*체크리스트 콜백함수*/
function checklistResult(data){ 	
	
	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/checklist.do',
		type : 'post',
		data : data,
		dataType : 'json',
		async : true,
		success : function(data) {
			check.check = [];
			check.langitems = data.listlistCod;
			check.langitems1 = data.weblistCod;
			check.langitems2 = data.dblistCod;
			check.langitems3 = data.wslistCod;
			check.langitemss = data.sklcdlistCod;
			check.langitemarea1 = data.areacdlistCod;
			check.langitemarea2 = data.areacdlistCod;
			check.langitemarea3 = data.areacdlistCod;
			}
		});
}

$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
});

var chk_arr = [];
$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
	chk_arr.push(chk);
});
		
		
function checkclear(){	
	$("input[type=checkbox]").prop("checked", false);
}
	
		


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
<input type="hidden" name="WSCD" id="WSCD" value="WSCD">
	
	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="overflow:scroll; height:800px; width: 1000px; ">
		<dl>
			<dt>
				
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				
				
				<table class="row">
				<tr>
				<td>     
				    
				<div>
					<br>
					<br>
					<strong style="font-size:120%">&nbsp;&nbsp;&nbsp;&nbsp;기본정보</strong>
					<br>
					<br>
				</div>
					<table class="row">
						<tbody>
							<tr class="hidden">
								<td><input type="text" name="div_cd" id="div_cd" /></td>
								<td><input type="text" name="del_cd" id="del_cd" /></td>
						 		<td><input type="text" name="user_type" id="user_type" /></td> 
								<td><input type="text" name="approval_cd" id="approval_cd" /></td>
							</tr>
						</tbody>
						</table>
					<table class="row" width="2000px">
					<tbody>
							<tr>
								<th scope="row" width="200px">아이디<span class="font_red">*</span></th>
								<td width="400px"><input type="text" class="inputTxt p100"
									name="loginID" placeholder="숫자, 영문자 조합으로 6~20자리 "
									id="registerId" /></td>
							</tr>
						
							
							<tr>
								<th scope="row" width="200px">이름 <span class="font_red">*</span></th>
								<td width="400px"><input type="text" class="inputTxt p100" name="name"
									id="registerName" /></td>
							
								<th scope="row" width="200px">성별</th>
								<td width="400px">
								<input type="text" class="inputTxt p100" name="gender_cd"
									id="rggender" />
								</td>
							</tr>
					</tbody>
					</table>
					<table class="row">
					<tbody>
							<tr>
								<th scope="row" width="200px">생년월일 <span class="font_red"></span></th>
								<td width="400px"><input type="text" class="inputTxt p100"
									name="birthday" id="birthday" style="font-size: 15px" /></td>
							</tr>
							<tr>
								<th scope="row" width="200px">이메일<span class="font_red">*</span></th>
									<td width="400px"><input type="text" class="inputTxt p100"
									name="user_email" id="registerEmail" /></td>
									
							</tr>
						
							<tr>
								<th scope="row" width="200px">우편번호<span class="font_red">*</span></th>
								<td width="400px"><input type="text" class="inputTxt p100"
									name="user_zipcode" id="detailaddr" /></td>
							</tr>
							<tr>
								<th scope="row" width="200px">주소<span class="font_red">*</span></th>
								<td width="400px"><input type="text" class="inputTxt p100"
									name="user_address" id="loginaddr" /></td>
							</tr>
							<tr>
								<th scope="row" width="200px">상세주소</th>
								<td width="400px"><input type="text" class="inputTxt p100"
									name="user_dt_address" id="loginaddr1" /></td>
							</tr>
							</tbody>
					</table>
					<table class="row" >
					<tbody>
							<tr>

								<th scope="row" width="200px">전화번호<span class="font_red">*</span></th>
								<td width="400px"><input class="inputTxt"
									style="width: 150px" maxlength="3" type="text" id="tel1"
									name="user_tel1"> - <input class="inputTxt"
									style="width: 150px" maxlength="4" type="text" id="tel2"
									name="user_tel2"> - <input class="inputTxt"
									style="width: 150px" maxlength="4" type="text" id="tel3"
									name="user_tel3"></td>
							</tr>
							</tbody>
				</table>
<!-- 							<tr id="user_type_li">
								<th scope="row"><span class="font_red">*</span></th>
								<td colspan="3"><select name="user_type" id="user_type"
									style="width: 400px; height: 28px;">
								</select></td>
							</tr> -->
						<table class="row" >
						<tbody>	
							<tr>
								<th scope="row" width="200px">선호직무분야<span class="font_red">*</span></th>
								<td width="400px" colspan="5"><input type="text" class="inputTxt p100"
									name="user_hope_work" id="user_hope_work" /></td>
							</tr>
							
							<tr>
								<th scope="row" width="200px">경력기간<span class="font_red">*</span></th>
								<td width="400px"><input type="text" class="inputTxt p100"
									name="career_yn" id="career_yn" />
								<span>년</span>
							</td>
							<td width="400px"><input type="text" class="inputTxt p100"
									name="career_mm" id="career_mm" />
								<span>월</span>
							</td>
							</tr>


								
							
							<tr>
							<th scope="row" width="200px">희망연봉<span class="font_red">*</span></th>
								<td width="400px"><input type="text" class="inputTxt p100"
									name="salary" id="salary" />만원</td>
							
								<th scope="row" width="200px">협의가능여부</th>
								<td width="400px">
								<input type="text" class="inputTxt p100"
									name="consult_yn" id="consult_yn" /></td>
							</tr>
							<tr>
							<th scope="row" width="200px">회원상태<span class="font_red">*</span></th>
							<td width="400px"><input type="text" class="inputTxt p100"
									name="state_cd" id="state_cd" /></td>
							
							<th scope="row" width="200px">참여구분</th>
							<td width="400px">
							<input type="checkbox" name="SI" id="SI" />SI
							<input type="checkbox" name="SM" id="SM" />SM
							<input type="checkbox" name="Solution" id="Solution" />솔루션
							</td>
							</tr>
					</tbody>
					</table>
					
					</td>
					
				      
				 
				      <td>  
				      <!-- 경력정보 ---------------------------------------------------------------------->
				<div>
					<br>
					<br>
					<strong style="font-size:120%">&nbsp;&nbsp;&nbsp;&nbsp;경력정보</strong>
					<br>
					<br>
				</div>
				
					<!-- 추가기술 -->
					<table class="row" id="describe1">
					<tr>
						<th scope="row">제목<span class="font_red">*</span></th>
							<td colspan=3>
								<input type="text" class="inputTxt p100" name="user_describe" id="user_describe" />
							</td>
					</tr>
					</table>
					<!-- 체크리스트 -->
					<div class="dtl_cod">
 						<table class="row">
 						<tr>
								<th scope="row">Language<span class="font_red">*</span></th>
									<td colspan="2">
									    <table>
									      <template v-for="(row, index) in langitems" v-if="langitems.length" v-model="chkbox"> 
									      <tr>
									        <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
										    <td>{{ row.dtl_cod }}</td>
										  </tr>  
										  </template>
									    </table>
                                   </td>
                                  
								<th scope="row">web<span class="font_red">*</span></th>
									<td colspan="2">
									    <table>
									      <template v-for="(row, index) in langitems1" v-if="langitems1.length" v-model="chkbox"> 
									      <tr>
									          <td><input type="checkbox"  :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
										      <td>{{ row.dtl_cod }}</td>
										  </tr>    
										  </template>
									    </table>
								    </td>	    
						</tr>
						<tr>
								<th scope="row">DB<span class="font_red">*</span></th>
								<td colspan="2">
								      <table>
								       <template v-for="(row, index) in langitems2" v-if="langitems2.length" v-model="chkbox"> 
								         <tr>
								             <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
									         <td>{{ row.dtl_cod_nm }}</td>
									     </tr>
									    </template> 
								     </table>
                                </td>
								<th scope="row">WS<span class="font_red">*</span></th>
								<td colspan="2">
								    <table>
								      <template v-for="(row, index) in langitems3" v-if="langitems3.length" v-model="chkbox"> 
								       <tr>
								          <td><input type="checkbox" :id="row.dtl_cod" :name="row.dtl_cod"  style="width: 15px; height: 15px;" ></td>								
									      <td>{{ row.dtl_cod }}</td>
									   </tr>   
									   </template>
								    </table>
						        </td>
						        
						       
						</tr>
					</table> 
					</div>
					<table class="row">
					<!-- 등급 -->
				
						<tr>
							<th scope="row">등급<span class="font_red">*</span></th>			
								<td>			
									<input type="text" class="inputTxt p100" name="user_grade" id="user_grade" />
								</td>
						</tr>
						
												
				
					<!-- 희망 근무지 -->				
						<tr>
							<th scope="row">희망근무지역<span class="font_red">*</span></th>								
								<td>
									<span>1순위</span>					
									
									<input type="text" class="inputTxt p100" name="user_hope_area1" id="user_hope_area1" />
									
								
									<span>2순위</span>			
									
									<input type="text" class="inputTxt p100" name="user_hope_area2" id="user_hope_area2" />
									
								
									<span>3순위</span>		
									
									<input type="text" class="inputTxt p100" name="user_hope_area3" id="user_hope_area3" />
									
								</td>
						</tr>					
					</table>
					
					<table class="row">
						<tr>
							<th scope="row">경력내용<span class="font_red">*</span></th>
								<td>
									<textarea class="inputTxt p100" name="user_contents" id="user_contents" laceholder="경력사항을 입력하세요." /></textarea>
								</td>
						</tr>					
					</table>
					
					<table class="row">
						<tr>
							<th scope="row">특이사항<span class="font_red">*</span></th>
								<td>
									<textarea class="inputTxt p100" name="singular_facts" id="singular_facts" laceholder="특이사항을 입력하세요." /></textarea>
								</td>
						</tr>					
					</table>
					
					<table class="row">
						<tr>
							<th scope="row" >파일<span class="font_red">*</span></th>
								<td colspan="5">
									<!--multiple="multiple" -->
									<input type="file" name="file_nm" id="wfile_nm"  ></input>
									<!-- <img v-if="file_nm !='' "src="/images/treeview/minus.gif" @click="minusClickEvent"> -->
									
								</td>
						</tr>	
					</table>
				      </td> 				   
				   
				   </tr>
				
				
				</table>
				
				
				
				
				
				

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id=btnSaveEngCod name="btnInfo"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteGrpCod" name="btnInfo"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnCloseEngCod" name="btnInfo"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
	</div>
					

		
</form>
</body>
</html>