<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">답글 작성</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">답글 작성</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="/board/addrepost" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

					<div class="form-group">
						<input class="form-control" type="hidden"
													name="originpost"
													value="${originpostVO.postNo}"
													readonly="readonly">
					</div>

					<div class="form-group">
						<label>답글 제목</label> <input class="form-control"
													name="postSubject">
					</div>

					<div class="form-group">
						<label>답글 내용</label>
						<textarea class="form-control" rows="3" name="postText"></textarea>
					</div>

					<div class="form-group">
						<label>작성자 ID</label> <input class="form-control"
													 name="posterName"
													 value='<sec:authentication property="principal.username"/>'
													 readonly="readonly">
					</div>

					<div class="form-group">
						<input class="form-control"
							   name="redepth"
							   type="hidden"
							   value="${originpostVO.redepth +1}"
							   readonly="readonly">
					</div>
					<div class="form-group">
						<input class="form-control"
							   type="hidden"
							   name="reorder"
							   value="${originpostVO.reorder +1}"
							   readonly="readonly">
					</div>
					<div class="form-group">
						<input class="form-control"
							   type="hidden"
							   name="regroup"
							   value="${originpostVO.regroup}"
							   readonly="readonly">
					</div>


					<button type="submit" class="btn btn-default">완료</button>
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

			var str = "";

			$(".uploadResult ul li").each(function(i, obj){

				var jobj = $(obj);

				console.dir(jobj);
				console.log("-------------------------");
				console.log(jobj.data("filename"));


				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";

			});

			console.log(str);

			formObj.append(str).submit();

		});




		var csrfHeaderName ="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";


	});

</script>


<%@include file="../includes/footer.jsp" %>


