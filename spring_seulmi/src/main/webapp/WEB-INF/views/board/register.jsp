<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/Nav.jsp" />
<style>
	.container{
		height: 80%;
	}
</style>

<div class="container">

<h1>Board Register</h1>
<br>

	<form action="/board/register" method="post" enctype="multipart/form-data">

		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"><h4>Title</h4></label>
			<input type="text" class="form-control" name="title" id="exampleFormControlInput1">
		</div>
		<sec:authorize access="isAuthenticated()">
	    <sec:authentication property="principal.mvo.email" var="authEmail"/>
	    <sec:authentication property="principal.mvo.nickName" var="authNick"/>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"><h4>Writer</h4></label>
			<input type="text" class="form-control" name="writer" id="exampleFormControlInput1" value="${authEmail }" style="font-weight: bold;">
		</div>
		</sec:authorize>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label"><h4>Content</h4></label>
			<textarea class="form-control" name="content" id="exampleFormControlTextarea1" rows="3"></textarea>
		</div>

		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a href="/"><button class="btn btn-secondary me-md-2" type="button">cancle</button></a>
			<button class="btn btn-primary" type="submit" id="regBtn">Register</button>
		</div>
		
		<!-- file 입력 라인 추가 -->
 		<div class="mb-3">
			<label for="file" class="form-label">files...</label> 
			<br>
			<input type="file" name="files" class="form-control" id="files" multiple="multiple" style="display : none">
			<!-- 파일 버튼 트리거 사용하기 위해서 주는 버튼 -->
			<button type="button" class="btn btn-primary" id="trigger">fileUpload</button>	
		</div>
		<!-- 파일 목록 표시라인 -->
		<div class="mb-3" id="fileZone">
		</div>
		
	</form>


</div>

<script src="/resources/js/boardRegister.js"></script>

<jsp:include page="../layout/footer.jsp" />