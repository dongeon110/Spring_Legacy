<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시판</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시물
				<sec:authorize access="isAuthenticated()">
					<button id="regBtn" type="button" class="btn btn-xs pull-right">새 글 작성</button>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<button id="loginBtn" type="button" class="btn btn-xs pull-right">로그인</button>
				</sec:authorize>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>조회수</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
				
					<c:forEach var="postVO" items="${postVOs}">
						<c:choose>
							<c:when test="${postVO.enabled}">
								<tr>
									<td>${postVO.rowNum + (searchInfo.pageNum -1) * 10}</td>
									<td>
										<c:forEach var="i" begin="0" end="${postVO.redepth}">
											&nbsp&nbsp&nbsp
										</c:forEach>
										<c:if test="${postVO.redepth != 0}" var="re">
											<span class="badge badge-primary">[Re]</span>
										</c:if>
										<a class="move" href='<c:out value="${postVO.postNo}"/>'>
											${postVO.postSubject}
										</a>
										<c:if test="${postVO.cntReply > 0}">
											<span style="color:red;">&nbsp[${postVO.cntReply}]</span>
										</c:if>
									</td>
									<td>${postVO.postViews}</td>
									<td>
										${postVO.posterName}
									</td>

									<td><fmt:formatDate pattern="yyyy-MM-dd aa hh:mm" value="${postVO.postCreatedDate}"/></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td>${postVO.rowNum + (searchInfo.pageNum -1) * 10}</td>
									<td colspan="4">
										<c:forEach var="i" begin="0" end="${postVO.redepth}">
											&nbsp&nbsp&nbsp
										</c:forEach>
										<c:if test="${postVO.redepth != 0}" var="re">
											<span class="badge badge-primary">[Re]</span>
										</c:if>
										삭제된 게시물 입니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</table>
				<div class="row">
					<div class="col-lg-12">
						<%--          <li class="sidebar-search">--%>
						<%--            <div class="input-group custom-search-form">--%>
						<%--              <input type="text" class="form-control" placeholder="Search...">--%>
						<%--              <span class="input-group-btn">--%>
						<%--                                <button class="btn btn-default" type="button">--%>
						<%--                                    <i class="fa fa-search"></i>--%>
						<%--                                </button>--%>
						<%--                            </span>--%>
						<%--            </div>--%>
						<%--            <!-- /input-group -->--%>
						<%--          </li>--%>
						<form id='searchForm' action="/board/list" method="get">
							<input type='hidden' name="pageNum" value='<c:out value="${pageMaker.searchInfo.pageNum}"/>'/>
							<input type='hidden' name="amount" value='<c:out value="${pageMaker.searchInfo.amount}"/>'/>
							<select name="type">
								<option value="S"
										<c:out value="${pageMaker.searchInfo.type == 'S'? 'selected' : ''}"/>>제목</option>
								<option value="T"
										<c:out value="${pageMaker.searchInfo.type == 'T'? 'selected' : ''}"/>>내용</option>
								<option value="P"
										<c:out value="${pageMaker.searchInfo.type == 'P'? 'selected' : ''}"/>>작성자</option>
							</select>
							<div class="input-group custom-search-form">
								<input type='text' name='keyword' class="form-control" placeholder="검색"
									   value='<c:out value="${pageMaker.searchInfo.keyword}"/>' size="50">

								<span class="input-group-btn">
									<button class='btn btn-default' type="button">
										<i class="fa fa-search"></i>
									</button>
								</span>
							</div>
						</form>
					</div>
				</div>

<%--				<li class="sidebar-search">--%>
<%--					<div class="input-group custom-search-form">--%>
<%--						<input type="text" class="form-control" placeholder="Search...">--%>
<%--						<span class="input-group-btn">--%>
<%--                                <button class="btn btn-default" type="button">--%>
<%--                                    <i class="fa fa-search"></i>--%>
<%--                                </button>--%>
<%--                            </span>--%>
<%--					</div>--%>
<%--					<!-- /input-group -->--%>
<%--				</li>--%>


				<!-- Pagination -->
				<div class='pull-right'>
					<ul class='pagination'>
						<c:if test='${pageMaker.prev}'>
							<li class="paginate_button previous"><a href='${pageMaker.startPage-1}'>이전</a></li>
						</c:if>
						<c:forEach var='num' begin='${pageMaker.startPage}' end='${pageMaker.endPage}'>
							<li class="paginate_button  ${pageMaker.searchInfo.pageNum == num? "active":""} ">
								<a href='${num}'>${num}</a></li>
						</c:forEach>
						<c:if test='${pageMaker.next}'>
							<li class="paginate_button next"><a href='${pageMaker.endPage+1}'>다음</a></li>
						</c:if>
					</ul>
				</div>
				<!-- end Pagination -->

				<form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.searchInfo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.searchInfo.amount}">
					<input type="hidden" name="type" value="${pageMaker.searchInfo.type}">
					<input type="hidden" name="keyword" value="${pageMaker.searchInfo.keyword}">
				</form>

				<!-- Modal 추가 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					 aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</div>

						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
</div>
<!-- /.row -->

<%@ include file="../includes/footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		var result = '<c:out value="${result}"/>';

		checkModal(result);

		history.replaceState({}, null, null);

		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}

			$("#myModal").modal("show");
		}

		$("#regBtn").on("click", function(){
			self.location = "/board/add";
		});

		$("#loginBtn").on("click", function(){
			self.location = "/customLogin";
		});

		<!-- Paging -->
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='pno' value='" +
					$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/view");
			actionForm.submit();
		});

		<!-- list.jsp의 검색 버튼의 이벤트 처리 -->
		<!-- 검색 버튼 클릭시 검색은 1페이지로, 화면에 검색 조건 키워드 보이게 -->
		var searchForm = $("#searchForm");

		$("#searchForm button").on("click", function(e) {
			if(!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}

			if(!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
	});
</script>