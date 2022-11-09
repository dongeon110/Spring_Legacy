<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 보기</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">게시글 보기</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="panel-body">
					<div class="form-group">
						<input class="form-control" name="pno" type="hidden"
												  value='<c:out value="${postVO.postNo}"/>' readonly="readonly">
					</div>

					<sec:authorize access="hasRole('ROLE_ADMIN')" var="isadmin"/>
					<c:choose>
						<c:when test="${postVO.enabled || isadmin}">
						<div class="form-group">
							<label>제목</label> <input class="form-control" name="postSubject"
														value='<c:out value="${postVO.postSubject}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>조회수</label> <input class="form-control" name="postViews"
													  	value='<c:out value="${postVO.postViews}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name="postText"
									  readonly="readonly"><c:out value="${postVO.postText}"/></textarea>
						</div>

						<div class="form-group">
							<label>작성자</label> <input class="form-control" name="posterName"
														value='<c:out value="${postVO.posterName}"/>' readonly="readonly">
						</div>



						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal" var="pinfo"/>
								<c:if test="${(pinfo.username eq postVO.posterName) || isadmin}">
									<button data-oper="modify"
											class="btn btn-default">
										수정/삭제
									</button>
								</c:if>

							<c:if test="${postVO.redepth <= 2 and postVO.redepth >=0}">
								<button data-oper="addrepost"
										class="btn btn-default">
									답글달기
								</button>
							</c:if>
							<c:if test="${postVO.redepth == 3}">
								<button data-oper="addrepostblock"
										class="btn btn-default">
									답글달기
								</button>
							</c:if>
						</sec:authorize>
						<sec:authorize access="${isadmin}">
							<c:if test="${!postVO.enabled}">
								<button data-oper="restorepost"
										class="btn btn-default">
									복구하기
								</button>
							</c:if>
						</sec:authorize>
						<button data-oper="list"
								class="btn btn-info">
							<%--                  onclick="location.href='/board/list'">--%>
							목록
						</button>

						<form id="operForm" action="/board/modify" method="get">
							<input type='hidden' id='pno' name='pno' value='<c:out value="${postVO.postNo}"/>'>
							<input type='hidden' name='pageNum' value='<c:out value="${searchInfo.pageNum}"/>'>
							<input type='hidden' name='amount' value='<c:out value="${searchInfo.amount}"/>'>
							<input type='hidden' name='keyword' value='<c:out value="${searchInfo.keyword}"/>'>
							<input type='hidden' name='type' value='<c:out value="${searchInfo.type}"/>'>
						</form>

						<form id="operForm" action="/board/addrepost" method="get">
							<input type='hidden' id='pno' name='pno' value='<c:out value="${postVO.postNo}"/>'>
							<input type='hidden' name='pageNum' value='<c:out value="${searchInfo.pageNum}"/>'>
							<input type='hidden' name='amount' value='<c:out value="${searchInfo.amount}"/>'>
							<input type='hidden' name='keyword' value='<c:out value="${searchInfo.keyword}"/>'>
							<input type='hidden' name='type' value='<c:out value="${searchInfo.type}"/>'>
						</form>

						<form id="operFormPost" action="/board/restore" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<input type='hidden' id='pno' name='postNo' value='<c:out value="${postVO.postNo}"/>'>
							<input type='hidden' name='pageNum' value='<c:out value="${searchInfo.pageNum}"/>'>
							<input type='hidden' name='amount' value='<c:out value="${searchInfo.amount}"/>'>
							<input type='hidden' name='keyword' value='<c:out value="${searchInfo.keyword}"/>'>
							<input type='hidden' name='type' value='<c:out value="${searchInfo.type}"/>'>
						</form>
						</c:when>
						<c:otherwise>
							<h3>삭제된 게시물 입니다.</h3>
						</c:otherwise>
					</c:choose>
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
				<i class="fa fa-comments fa-fw"></i> 댓글
				<sec:authorize access="isAuthenticated()">
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">댓글 쓰기</button>
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
				<h4 class="modal-title" id="myModalLabel">댓글 MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>댓글</label>
					<input class="form-control" name="reply" value="New Reply!!!">
				</div>

				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="replyer" value="replyer" readonly="readonly">
				</div>

				<div class="form-group">
					<label>답글 날짜</label>
					<input class="form-control" name="replyDate" value="2022-10-01 12:34">
				</div>


			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">수정</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">추가</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">닫기</button>
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

				if(replyCnt == 0 && pageNum > 1) {
					showList(pageNum-1);
					return;
				} else if (replyCnt == 0) {
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
							+((page-1)*10 + i+1)+"] "+list[i].replyer+"</strong>";
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

				str+= "<li class='page-item "+ active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}

			if(next) {
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>다음</a></li>";
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


		// 댓글 클릭 이벤트 처리
		$(".chat").on("click", "li", function(e) {

			var rno = $(this).data("rno");

			replyService.get(rno, function (reply) {
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);

				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();

				$(".modal").modal("show");

			});
		});

			// 댓글 수정
		modalModBtn.on("click", function(e) {

			var originalReplyer = modalInputReplyer.val();

			var reply = {
				reply: modalInputReply.val(),
				rno: modal.data("rno"),
				replyer: originalReplyer
			};

			if(!replyer) {
				alert("로그인 후 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}

			console.log("Original Replyer: " + originalReplyer);

			if(replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 수정가능합니다");
				modal.modal("hide");
				return;
			}

			replyService.update(reply, function(result) {
				alert(result);
				modal.modal("hide");
				showList(pageNum);

			});

		});

		// 댓글 삭제
		modalRemoveBtn.on("click", function(e) {
			var rno = modal.data("rno");

			console.log("RNO: " + rno);
			console.log("REPLYER: " + replyer);

			if(!replyer) {
				alert("로그인 후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}

			var originalReplyer = modalInputReplyer.val();

			console.log("Original Replyer: " + originalReplyer); // 기존 댓글 작성자

			if (replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}

			replyService.remove(rno, originalReplyer, function(result) {
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});

		var replyer = null;

		<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";

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
		var operFormPost = $("#operFormPost");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/update").submit();
		});

		$("button[data-oper='addrepost']").on("click", function(e) {

			operForm.attr("action", "/board/addrepost").submit();
		});
		$("button[data-oper='addrepostblock']").on("click", function(e) {

			alert("답글의 최대 depth는 3");
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#pno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});

		$("button[data-oper='restorepost']").on("click", function(e) {
			operFormPost.attr("action", "/board/restore").submit();
		});

		console.log(replyService);
	});
</script>
