<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/Nav.jsp" />
<style>
.container {
	height: 70%;
	display: flex;
	align-items: center;
	flex-direction: column;
}
.box1 {
	height: 600px;
	display: flex;
	align-items: center;
	
}
.box2{
	display: flex;
	align-items: center;
	flex-direction: column;
}
h1{
	font-size: 60px;
}

</style>

<div class="container">

	<div class="box1">
		<div class="box2">
		<h1>Hello Jibok's Page!</h1>
		<br>
		<p>Love truth, and pardon error</p>
		</div>
	</div>
</div>

<jsp:include page="layout/footer.jsp" />