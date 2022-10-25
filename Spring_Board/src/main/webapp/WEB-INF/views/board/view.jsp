<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Read Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="panel-body">
					<div class="form-group">
						<label>Pno</label> <input class="form-control" name="pno"
												  value='<c:out value="${postVO.postNo}"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>Title</label> <input class="form-control" name="postSubject"
													value='<c:out value="${postVO.postSubject}"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="postText"
								  readonly="readonly"><c:out value="${postVO.postText}"/></textarea>
					</div>

					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="posterName"
													 value='<c:out value="${postVO.posterName}"/>' readonly="readonly">
					</div>

					<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq postVO.posterName}">
							<button data-oper="modify"
									class="btn btn-default">
								Modify
							</button>
						</c:if>
					</sec:authorize>
					<button data-oper="list"
							class="btn btn-info">
						<%--                  onclick="location.href='/board/list'">--%>
						List
					</button>

					<form id="operForm" action="/board/modify" method="get">
						<input type='hidden' id='postNo' name='postNo' value='<c:out value="${postVO.postNo}"/>'>
						<input type='hidden' name='pageNum' value='<c:out value="${searchInfo.pageNum}"/>'>
						<input type='hidden' name='amount' value='<c:out value="${searchInfo.amount}"/>'>
						<input type='hidden' name='keyword' value='<c:out value="${searchInfo.keyword}"/>'>
						<input type='hidden' name='type' value='<c:out value="${searchInfo.type}"/>'>
					</form>
				</div>
			</div>
			<!-- end panel-body -->

		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<div class='row'>

	<div class="col-lg-12">

		<!-- /.panel -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<sec:authorize access="isAuthenticated()">
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
				</sec:authorize>
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">

				<ul class="chat">

					<!-- Replace to JavaScript -->

				</ul>
				<!-- ./end ul -->
			</div>
			<!-- /.panel .chat-panel -->
			<div class="panel-footer"></div>
		</div>
	</div>
	<!-- ./end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	 aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name="reply" value="New Reply!!!">
				</div>

				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name="replyer" value="replyer">
				</div>

				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name="replyDate" value="2022-10-01 12:34">
				</div>


			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Add</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

	$(document).ready(function() {
		var pnoValue = '<c:out value="${postVO.postNo}"/>';
		var replyUL = $(".chat");

		showList(1);

		function showList(page) {
			console.log("show list " + page);

			replyService.getList({pno:pnoValue, page: page || 1}, function(replyCnt, list) {
				console.log("replyCnt: " + replyCnt);
				console.log("list: " + list);
				console.log(list);

				if(page == -1) {
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}

				var str="";

				if(list == null || list.length == 0) {
					// replyUL.html("");

					return;
				}

				for (var i=0, len=list.length || 0; i<len; i++) {
					str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str +="  <div><div class='header'><strong class='primary-font'>[" // 댓글 순서 번호 rno
							+list[i].rno+"] "+list[i].replyer+"</strong>";
					str +="    <small class='pull-right text-muted'>"
							+replyService.displayTime(list[i].replyDate)+"</small></div>";
					str +="    <p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);

				showReplyPage(replyCnt);

			}); // end function
		} // end showList
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");

		function showReplyPage(replyCnt) {

			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;

			var prev = startNum != 1;
			var next = false;

			if(endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);
			}

			if(endNum * 10 < replyCnt) {
				next = true;
			}

			var str = "<ul class='pagination pull-right'>";

			if(prev) {
				str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
			}

			for(var i = startNum; i <= endNum; i++) {
				var active = pageNum == i? "active":"";

				str+= "<li class='page-item "+ active + " '><a class='page-link' href='" + i + "'>Next</a></li>";
			}

			if(next) {
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
			}

			str += "</ul></div>";

			console.log(str);
			replyPageFooter.html(str);

		}

		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			console.log("page click");

			var targetPageNum = $(this).attr("href");

			console.log("targetPageNum: " + targetPageNum);

			pageNum = targetPageNum;

			showList(pageNum);
		});

		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");

		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");

		var replyer = null;

		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";

		$("#modalCloseBtn").on("click", function(e) {

			modal.modal("hide");
		});

		$("#addReplyBtn").on("click", function(e){

			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();

			modalRegisterBtn.show();

			$(".modal").modal("show");
		});

		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});

		modalRegisterBtn.on("click", function(e) {
			var reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				pno: pnoValue
			};

			replyService.add(reply, function(result) {
				alert(result);

				modal.find("input").val("");
				modal.modal("hide");

				showList(-1);
			});
		});


		$(".chat").on("click", "li", function(e) {

			var rno = $(this).data("rno");

			replyService.get(rno, function(reply) {
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);

				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();

				$(".modal").modal("show");

			});

			// 댓글 수정
			modalModBtn.on("click", function(e) {
				var reply = {
					reply: modalInputReply.val(),
					rno: modal.data("rno")
				};

				replyService.update(reply, function(result) {
					alert(result);
					modal.modal("hide");
					showList(pageNum);

				});

			});

			// 댓글 삭제
			modalRemoveBtn.on("click", function(e) {
				var rno = modal.data("rno");

				replyService.remove(rno, function(result) {
					alert(result);
					modal.modal("hide");
					showList(pageNum);
				});
			});

		});

	});

</script>




<script>
	console.log("============");
	console.log("JS TEST");

	var pnoValue = '<c:out value="${postVO.postNo}"/>';

	replyService.getList({pno:pnoValue, page:1}, function(list) {
		for(var i = 0, len = list.length||0; i < len; i++ ){
			console.log(list[i]);
		}
	});

	replyService.get(10, function(data){
		console.log(data);
	});

</script>

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/update").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#pno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});

		console.log(replyService);
	});
</script>
