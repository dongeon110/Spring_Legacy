<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">새 글 작성</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">새 글 작성</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="/board/add" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

					<div class="form-group">
						<label>제목</label> <input class="form-control"
													name="postSubject">
					</div>

					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" name="postText"></textarea>
					</div>

					<div class="form-group">
						<label>작성자</label> <input class="form-control"
													 name="posterName"
													 value='<sec:authentication property="principal.username"/>'
													 readonly="readonly">
					</div>

					<button type="submit" class="btn btn-default" >추가하기</button>
					<button type="reset" class="btn btn-default">다시 작성</button>
				</form>

			</div>
			<!-- end panel-body -->

		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->


<script>

	$(document).ready(function(e){
		var formObj = $("form[role='form']");

		$("button[type='submit']").on("click", function(e){

			if($('input[name="postSubject"]').val().trim() == '') {
				alert("제목을 입력하세요.");
				return false;
			}
			if($('textarea[name="postText"]').val().trim() == '') {
				alert("내용을 입력하세요.");
				return false;
			}


			e.preventDefault();

			console.log("submit clicked");

			formObj.submit();

		});



	});

</script>


<%@include file="../includes/footer.jsp" %>


