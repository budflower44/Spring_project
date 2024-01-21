<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/Nav.jsp" />

<div class="container-md">
	<br>
	<h2>Member List Page</h2>
	<br>
		<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">Email</th>
				<th scope="col">Nick_Name</th>
				<th scope="col">Reg_Date</th>
				<th scope="col">Last_Login</th>
				<th scope="col">Auths</th>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${mvoList }" var="mvoList" varStatus="i">
				<tr>
					<th>${i.count}</th>
					<td><a href="/member/modify?email=${mvoList.email }">${mvoList.email }</a></td>
					<td>${mvoList.nickName }</td>
					<td>${mvoList.regAt }</td>
					<td>${mvoList.lastLogin }</td>
					<c:set value="${mvoList.authList }" var="authList" />
					<td>
						<c:choose>
							<c:when test="${authList.stream().anyMatch(AuthVO -> AuthVO.auth.contains('ROLE_ADMIN')).get() }">
								<p>ADMIN / USER</p>
							</c:when>
							<c:otherwise>
								<p>USER</p>
							</c:otherwise>
						</c:choose>		
					</td>		 
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
	
	
<jsp:include page="../layout/footer.jsp"></jsp:include>