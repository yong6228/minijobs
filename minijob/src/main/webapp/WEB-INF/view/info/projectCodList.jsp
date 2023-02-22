<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalCntComnGrpCod eq 0 }">
								<tr>
									<td colspan="10">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCntComnGrpCod > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
								<c:forEach items="${listProjectCod}" var="list">
									<tr>
										<td>${list.corname}</td>
										<td>
											<a href="javascript:fPopModal('${list.projectID}');"><span>${list.projectname}</span></a>
										</td>
										<td>${list.area}</td>
										<td>${list.job}</td>
										<td>${list.industry}</td>
										<td>${list.recvstart}</td>
										<td>${list.recvend}</td>
										<td>${list.wname}</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCntComnGrpCod" name="totalCntComnGrpCod" value ="${totalCntComnGrpCod}"/>
