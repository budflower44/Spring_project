<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/Nav.jsp" />
<style>
	.box-1{
	}
</style>

<div class="container">

<h1>Member Register</h1>
<br>

	<form action="/member/register" method="post">
	<div class="box-1">
		<div class="row g-3 align-items-center">
			<div class="col-auto">
				<input type="email" class="form-control" id="email" name="email">
			</div>
			<div class="col-auto">
				<label for="exampleFormControlInput1" class="form-label"><h4>Email</h4></label>
				&nbsp<span class="form-text text-danger" id="email_check" hidden="hidden">Email exists..</span>
				&nbsp<span class="form-text text-success" id="email_check_sucess" hidden="hidden">Email available.</span>
			</div>
		</div>
		<div class="row g-3 align-items-center">
			<div class="col-auto">
				<input type="text" class="form-control" id="nickName" name="nickName" id="exampleFormControlInput1">
			</div>
			<div class="col-auto">
				<label for="exampleFormControlInput1" class="form-label"><h4>Nick Name</h4></label>
			</div>
		</div>
		<div class="row g-3 align-items-center">
			<div class="col-auto">
				<input type="password" id="pwd-Check1" name="pwd" class="form-control pwd" aria-describedby="passwordHelpInline">
			</div>
			<div class="col-auto">
				<label for="inputPassword6" class="col-form-label"><h4>Password</h4></label>
			</div>
			<div class="col-auto">
				<span id="passwordHelpInline" class="form-text pwd-check1">  </span>
			</div>
		<div class="row g-3 align-items-center">
			<div class="col-auto">
				<input type="password" id="pwd-Check2" class="form-control pwd" aria-describedby="passwordHelpInline">
			</div>
			<div class="col-auto">
				<label for="inputPassword6" class="col-form-label"><h4>Password Check</h4></label>
			</div>
			<div class="col-auto">
				<span class="form-text text-danger" id="pwd_check" hidden="hidden"> Password mismatch </span>
			</div>
		</div>
		</div>
		<br>
		<div class="row g-3 align-items-center">
			<div class="col-auto">
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button class="btn btn-primary" type="submit" id="regBtn" disabled="disabled">Register</button>
			<a href="/"><button class="btn btn-secondary me-md-2" type="button">cancle</button></a>
		</div>
		</div>
		</div>
	</div>
	
	</form>

</div>

<script src="/resources/js/memberRegister.js"></script>
<script type="text/javascript">

</script>

<jsp:include page="../layout/footer.jsp" />