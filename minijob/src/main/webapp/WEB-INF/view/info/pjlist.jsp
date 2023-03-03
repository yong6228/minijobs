<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						    
							<c:if test="${searchlistcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${searchlistcnt > 0 }">
								<c:forEach items="${searchlist}" var="list">
									<tr>
										<td>${list.projectID}</td>
										<td><a href="javascript:pselectone(${list.projectID})">${list.projectname}</a></td>
										<td>${list.corname}</td>
										<td>${list.area}</td>
										<td>${list.job}</td>
										<td>${list.industry}</td>
										<td>${list.recvstart}</td>
										<td>${list.recvend}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>