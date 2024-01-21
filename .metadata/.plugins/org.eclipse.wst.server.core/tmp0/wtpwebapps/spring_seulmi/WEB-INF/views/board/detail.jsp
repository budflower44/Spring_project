<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/Nav.jsp" />
<style>

</style>

<div class="container">

	<h1>Board Detail</h1>
	<br>

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label"><h4>Title</h4></label>
		<input type="text" class="form-control" name="title" id="exampleFormControlInput1" value="${bdto.bvo.title }">
	</div>
	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label"><h4>Writer</h4></label>
		<input type="text" class="form-control" name="writer" id="exampleFormControlInput1" value="${bdto.bvo.writer }" readonly="readonly">
	</div>
	<div class="mb-3">
		<label for="exampleFormControlTextarea1" class="form-label"><h4>Content</h4></label>
		<textarea class="form-control" name="content" id="exampleFormControlTextarea1" rows="3">${bdto.bvo.content }</textarea>
	</div>
	
	<!-- file line -->
	<c:set value="${bdto.flist }" var="flist" />
	<div class="mb-3">
		<label for="file" class="form-label"></label>
			<ul class="list-group list-group-flush">
				<c:forEach items="${flist }" var="fvo">
	  				<li class="list-group-item">
	  					<c:choose>
	  						<c:when test="${fvo.fileType == 1 }">
	  							<div "mb-3">
	  								<img alt="image" src="/upload/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}">
	  							</div>
	  						</c:when>
	  						<c:otherwise>
	  							<div>
	  								<!-- 일반 파일 표시할 아이콘 -->
	  								<a href="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}" download=${fvo.fileName }>
	  								<i class="bi bi-file-earmark-check"></i></a>
	  							</div>
	  						</c:otherwise>
	  					</c:choose>
	  					<div class="mb-3">
	  						<div class="fw-bold">${fvo.fileName }</div>
	  						<span class="badge rounded-pill text-bg-secondary">${fvo.fileSize }Byte</span>
	  					</div>
	  				</li>				
				</c:forEach>
  			</ul>
  			<br>
 	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.mvo.authList" var="auths" />
			<c:if test="${auths.stream().anyMatch(authVO -> authVO.email.equals(bdto.bvo.writer)).get() }">
				<a href="/board/modify?bno=${bdto.bvo.bno }"><button class="btn btn-primary" type="button">modify</button></a>
			</c:if>
		</sec:authorize>
		<a href="/board/list"><button class="btn btn-secondary me-md-2" type="button">Close</button></a>
	</div> 
	
	<hr>

<sec:authorize access="isAuthenticated()">
   <!-- 댓글 등록 라인 -->
   <div class="input-group mb-3">
	  <sec:authentication property="principal.mvo.email" var="email" />
	  <span class="input-group-text" id="cmtWriter">${email}</span>
	  <input type="text" class="form-control" id="cmtText" aria-label="Amount (to the nearest dollar)">
	  <button type="button" class="btn btn-success" id="cmtPostBtn">Post</button>
	</div>
</sec:authorize>

   <!-- 댓글 표시 라인 -->
   <ul class="list-group list-group-flush" id="cmtListArea">
	  <li class="list-group-item">
	  	<div class="mb-3">
	  		<div class="fw-bold">Writer</div>
	  		content
	  	</div>
	  	<span class="badge rounded-pill text-bg-warning">modAt</span>
	  </li>
	</ul>
	
	<!-- 댓글 더보기 버튼 -->
	<div>
		<button type="button" id="moreBtn" data-page="1" class="btn btn-outline-dark" style="visibility:hidden">MORE+</button>
	</div>
	
	<!-- 모달창 라인 -->
	<div class="modal" id="myModal" tabindex="-1">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title">Writer</h5>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			<div class="modal-body">
        			<div class="input-group mb-3">
        				<input type="text" class="form-control" id="cmtTextMod">
        				<button type="button" class="btn btn-primary" id="cmtModBtn">Post</button>
        			</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      			</div>
    		</div>
  		</div>
	</div>
</div>


<script type="text/javascript">
	let bnoVal = `<c:out value="${bdto.bvo.bno}" />`;
	console.log(bnoVal);
</script>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.mvo.email" var="authEmail" />
<script type="text/javascript">
let emailVal = `<c:out value="${authEmail}" />`;
console.log(emailVal);
</script>
</sec:authorize>
<script src="/resources/js/boardComment.js"></script>
<script type="text/javascript">
	spreadCommentList(bnoVal);
</script>
<jsp:include page="../layout/footer.jsp" />