<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Add Post / Register Post</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Add Post / Register Post</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="/board/add" method="post">
					<div class="form-group">
						<label>Title</label> <input class="form-control"
													name="postSubject">
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="postText"></textarea>
					</div>

					<div class="form-group">
						<label>Writer</label> <input class="form-control"
													 name="posterName">
					</div>

					<button type="submit" class="btn btn-default">Submit Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
				</form>

			</div>
			<!-- end panel-body -->

		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->
<%@include file="../includes/footer.jsp" %>


