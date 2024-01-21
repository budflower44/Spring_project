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
	.box-2{
	    display: flex;
        align-items: center;
	}
	.box-1{
		padding-top: 5%;
	}
	.box-3{
		padding-left: 20%;
		padding-top: 0;
		padding-bottom: 0;
	}
	.g-3, .gy-3 {
    	--bs-gutter-y: 0;
	}
</style>

<div class="container">
	<div class="d-flex justify-content-center box-2">
		<h1>Login</h1>
	</div>
	<div class="d-flex justify-content-center box-1">
		<form action="/member/login" method="post">
			<div class="box-1">
				<div class="row g-3 align-items-center box-3">
					<div class="col-auto">
						<label for="exampleFormControlInput1" class="form-label"><h4>Email</h4></label>
						&nbsp<span class="form-text text-danger" id="email_check" hidden="hidden">Email exists..</span>
						&nbsp<span class="form-text text-success" id="email_check_sucess" hidden="hidden">Email available.</span>
					</div>
					<div class="col-auto">
						<input type="email" class="form-control" id="email" name="email">
					</div>
				</div>
				<div class="row g-3 align-items-center box-3">
					<div class="col-auto">
						<label for="inputPassword6" class="col-form-label"><h4>Password</h4></label>
					</div>
					<div class="col-auto">
						<span id="passwordHelpInline" class="form-text pwd-check1"
							hidden="hidden"> Must be 8-20 characters long. </span>
					</div>
					<div class="col-auto">
						<input type="password" id="pwd-Check1" name="pwd"
							class="form-control pwd" aria-describedby="passwordHelpInline">
					</div>
				</div>
			</div>
			<br>
			<div class="d-flex justify-content-center box-1">
				<div class="row g-3 align-items-end">
					<div class="col-auto">
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<button class="btn btn-primary" type="submit" id="regBtn">Login</button>
							<a href="/"><button class="btn btn-secondary me-md-2" type="button">cancle</button></a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<br>

		<div class="d-flex justify-content-center">
			<c:if test="${not empty param.errMsg}">
				<c:choose>
					<c:when test="${param.errMsg eq 'Bad credentials'}">
						<c:set value="이메일 & 비밀번호가 일치하지 않습니다." var="errText"></c:set>
					</c:when>
					<c:otherwise>
						<c:set value="관리자에게 문의해주세요." var="errText"></c:set>
					</c:otherwise>
				</c:choose>
				<div>
					<span class="form-text text-danger">${errText}</span>
				</div>
			</c:if>
		</div>
</div>



<jsp:include page="../layout/footer.jsp"></jsp:include>