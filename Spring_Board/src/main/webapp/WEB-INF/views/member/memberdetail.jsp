<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">회원 권한 부여</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">회원 권한 부여</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

        <div class="panel-body">
          <sec:authorize access="hasRole('ROLE_ADMIN')" var="isadmin"/>
          <div class="form-group">
            <label>ID</label> <input class="form-control" name="userid"
                                     value='<c:out value="${memberVO.userid}"/>' readonly="readonly">
          </div>
          <div class="form-group">
            <label>이름</label> <input class="form-control" name="userName"
                                      value='<c:out value="${memberVO.userName}"/>' readonly="readonly">
          </div>
          <div class="form-group">
            <label>권한</label>
            <input type="checkbox" name="auth" value="ROLE_ADMIN">관리자
            <input type="checkbox" name="auth" value="ROLE_MEMBER">일반사용자
          </div>

          <sec:authorize access="isAuthenticated()">
            <sec:authentication property="principal" var="pinfo"/>
            <c:if test="${isadmin}">
              <button data-oper="modify"
                      class="btn btn-default">
                수정/삭제
              </button>
            </c:if>

          </sec:authorize>
          <sec:authorize access="${isadmin}">
            <c:if test="${!memberVO.enabled}">
              <button data-oper="restorepost"
                      class="btn btn-default">
                복구하기
              </button>
            </c:if>
          </sec:authorize>
          <button data-oper="memberlist"
                  class="btn btn-info">
            목록
          </button>

          <form id="operFormPost" action="/board/restore" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type='hidden' id='userid' name='userid' value='<c:out value="${memberVO.userid}"/>'>

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


<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/reply.js"></script>


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

    $("button[data-oper='memberlist']").on("click", function(e) {
      operForm.find("#userid").remove();
      operForm.attr("action", "/member/memberlist")
      operForm.submit();
    });

    $("button[data-oper='restorepost']").on("click", function(e) {
      operFormPost.attr("action", "/board/restore").submit();
    });

  });
</script>
