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
	.detailAtag{
        text-decoration: none;
        color : black;
    }
</style>

<div class="container">

<h1>Board List</h1>
<br>

	<!-- Search Line -->
	<div class="mb-3">
		<form action="/board/list" method="get" class="d-flex" role="search">
		<c:set value="${ph.pgvo.type }" var="typed" />
		<div class="col-auto">
			<select name="type" class="form-select form-select-sm" aria-label="Small select example">
				<option ${typed eq null ? 'selected' : '' }>Choose...</option>
				<option value="t" ${typed eq 't' ? 'selected' : '' }>Title</option>
				<option value="w" ${typed eq 'w' ? 'selected' : '' }>Writer</option>
				<option value="c" ${typed eq 'c' ? 'selected' : '' }>Content</option>
				<option value="tc" ${typed eq 'tc' ? 'selected' : '' }>Title&Content</option>
				<option value="tw" ${typed eq 'tw' ? 'selected' : '' }>Title&Writer</option>
				<option value="wc" ${typed eq 'wc' ? 'selected' : '' }>Writer&Content</option>
				<option value="twc" ${typed eq 'twc' ? 'selected' : '' }>Title&Writer&Content</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="qty" value="${ph.pgvo.qty }">
			<input name="keyword" placeholder="Search..." class="form-control me-2 form-control-sm" type="search" placeholder="Search" aria-label="Search" value="${ph.pgvo.keyword }" >
		</div>
			<button class="btn btn-primary position-relative btn-sm" type="submit">Search
			<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${ph.totalCount }
			<span class="visually-hidden"></span>
			</button>
		</form>
	</div>

<c:choose>
	<c:when test="${list eq null }">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label"><h2>No Contents..</h2></label>
		</div>		
	</c:when>
	<c:otherwise>
		<ol class="list-group list-group-numbered">
			<c:forEach items="${list}" var="bvo">
			  <li class="list-group-item d-flex justify-content-between align-items-start">
			    <div class="ms-2 me-auto">
			      <a href="/board/detail?bno=${bvo.bno }" class="detailAtag"><div class="fw-bold">${bvo.title } (${bvo.writer })</div></a>
			      ${bvo.content }
			      <br>
			      <span class="badge bg-warning rounded-pill">Mod: ${bvo.modAt }</span>
			      <span class="badge bg-info rounded-pill">Read ${bvo.readCount }</span>
			      <span class="badge bg-secondary rounded-pill">File ${bvo.hasFile }</span>
			    </div>
			    <span class="badge bg-primary rounded-pill">Comment: ${bvo.cmtQty }</span>
			  </li>
			</c:forEach>
		</ol>
	</c:otherwise>
</c:choose>


	<!-- 페이지네이션 라인 -->
	
	<nav aria-label="Page navigation example">
		<ul class="pagination">
			
			<!-- prev -->
			<c:if test="${ph.prev }">
				<li class="page-item">
				<a href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" class="page-link" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:if>		
			
			<!-- 페이지번호 -->
			<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
				<li class="page-item"><a href="/board/list?pageNo=${i}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" a class="page-link">${i}</a></li>
			</c:forEach>
			
			<!-- next -->
				<li class="page-item ${(ph.next eq false) ? 'disabled' : '' }">
					<a href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" class="page-link" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a></li>
			
			<!-- 전체보기 -->
			<li class="page-item">
				<a href="/board/list" class="page-link" aria-label="Previous">
				<span aria-hidden="true">전체보기</span>
			</a></li>
		</ul>
	</nav>
	

</div>

<jsp:include page="../layout/footer.jsp" />