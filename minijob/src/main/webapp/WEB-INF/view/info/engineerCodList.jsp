<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntComnGrpCod eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntComnGrpCod > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
								<c:forEach items="${listEngineerCod}" var="list">
									<tr onclick="javascript:fPopModal('${list.loginID}');">
										<td>${list.name}</td>
										<td>${list.user_contents}</td>
										<td>${list.user_hope_area1}, ${list.user_hope_area2}, ${list.user_hope_area3}</td>
										<td>${list.user_grade}</td>
										<td>${list.detail_code}</td>
										<td>${list.state_cd}</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" value ="${totalCntComnGrpCod}"/>