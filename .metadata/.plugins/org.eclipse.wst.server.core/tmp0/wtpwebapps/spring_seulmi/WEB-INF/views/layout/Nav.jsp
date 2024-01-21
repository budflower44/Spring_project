<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

	<ul class="nav justify-content-end">
		<sec:authorize access="isAnonymous()">
		<li class="nav-item"><a class="nav-link active" aria-current="page" href="/member/login">Login</a></li>
		<li class="nav-item"><a class="nav-link active" href="/member/register">Member Register</a></li>
		</sec:authorize>
	<!-- 현재 인증한 사용자의 정보를 가져와서 해당 권한이 있는지 확인 -->
	<!-- 현재 사용자의 정보는 principal에 저장되어 있음 -->
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.mvo.email" var="authEmail" />
		<sec:authentication property="principal.mvo.nickName" var="authNick" />
		<sec:authentication property="principal.mvo.authList" var="auths" />
		<li class="nav-item"><a class="nav-link text-info" href="/member/modify">${authNick} (${authEmail })</a></li>
		<li class="nav-item"><a class="nav-link text-secondary" aria-disabled="true" href="/member/logout">Logout</a></li>
	</ul>
		<form action="/member/logout" method="post" id="logoutForm">
		 <input type="hidden" name="email" value="${authEmail }">
		</form>
	</sec:authorize>
