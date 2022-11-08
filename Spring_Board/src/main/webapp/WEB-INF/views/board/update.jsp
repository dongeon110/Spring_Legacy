<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시물 수정/삭제</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">게시물 수정/삭제</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<!-- /.panel-heading -->
				<div class="panel-body">
					<form role="form" action="/board/update" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type='hidden' name="pageNum" value='<c:out value="${searchInfo.pageNum}"/>'>
						<input type='hidden' name='amount' value='<c:out value="${searchInfo.amount}"/>'>
						<input type='hidden' name='type' value='<c:out value="${searchInfo.type}"/>'>
						<input type='hidden' name='keyword' value='<c:out value="${searchInfo.keyword}"/>'>

						<div class="form-group">
							<input class="form-control" name="postNo" type="hidden"
								   value='<c:out value="${postVO.postNo }"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>제목</label>
							<input class="form-control" name="postSubject"
								   value='<c:out value="${postVO.postSubject }"/>' >
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name="postText" ><c:out value="${postVO.postText }"/></textarea>
						</div>

						<div class="form-group">
							<label>작성자 ID</label>
							<input class="form-control" name="posterName"
								   value='<c:out value="${postVO.posterName}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>최초 작성일</label>
							<input class="form-control" name='regDate'
								   value='<fmt:formatDate pattern="yyyy/MM/dd" value="${postVO.postCreatedDate}" />' readonly="readonly">
						</div>

						<div class="form-group">
							<label>최근 수정일</label>
							<input class="form-control" name='updateDate'
								   value='<fmt:formatDate pattern="yyyy/MM/dd" value="${postVO.postUpdateDate}" />' readonly="readonly">
						</div>

						<sec:authentication property="principal" var="pinfo" />
						<sec:authorize access="hasRole('ROLE_ADMIN')" var="isadmin"/>
						<sec:authorize access="isAuthenticated()">
							<c:if test="${(pinfo.username eq postVO.posterName)}">
								<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
							</c:if>
							<c:if test="${(pinfo.username eq postVO.posterName) || isadmin}">
								<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
							</c:if>
						</sec:authorize>
						<button type="submit" data-oper='list' class="btn btn-info">목록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");

		$('button').on("click", function(e){

			if($('input[name="postSubject"]').val().trim() == '') {
				alert("제목을 입력하세요.");
				return false;
			}
			if($('textarea[name="postText"]').val().trim() == '') {
				alert("내용을 입력하세요.");
				return false;
			}

			e.preventDefault();

			var operation = $(this).data("oper");

			console.log(operation);

			if(operation === 'remove') {
				formObj.attr("action", "/board/remove");
			} else if(operation === 'list') {
				// move to list
				formObj.attr("action", "/board/list").attr("method", "get");

				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();

				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}
			formObj.submit();
		});
	});
</script>

