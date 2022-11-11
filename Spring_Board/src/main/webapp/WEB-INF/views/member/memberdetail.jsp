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
          <form id="operFormAuth" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type='hidden' name='originauth' value='<c:out value="${memberAuth}"/>'>
            <input type='hidden' name='pageNum' value='<c:out value="${searchInfo.pageNum}"/>'>
            <input type='hidden' name='amount' value='<c:out value="${searchInfo.amount}"/>'>
            <input type='hidden' name='keyword' value='<c:out value="${searchInfo.keyword}"/>'>
            <input type='hidden' name='type' value='<c:out value="${searchInfo.type}"/>'>

            <sec:authorize access="hasRole('ROLE_ADMIN')" var="isadmin"/>
            <div class="form-group">

              <label>ID</label> <input class="form-control" name="userid"
                                       value='<c:out value="${memberVO.userid}"/>' readonly="readonly">
            </div>
            <div class="form-group">
              <label>사용자 이름</label> <input class="form-control" name="userName"
                                        value='<c:out value="${memberVO.userName}"/>' readonly="readonly">
            </div>
            <div class="form-group">
              <label>권한</label><br>
              <input type="checkbox" name="auth" value="ROLE_ADMIN" > 관리자 권한
              <input type="checkbox" name="auth" value="ROLE_USER" > 일반사용자 권한
            </div>
          </form>
            <sec:authorize access="isAuthenticated()">
              <sec:authentication property="principal" var="pinfo"/>
              <c:if test="${isadmin}">
                <button data-oper="modify" type="button"
                        class="btn btn-default">
                  수정
                </button>
              </c:if>

            </sec:authorize>
            <button data-oper="memberlist"
                    class="btn btn-info">
              목록
            </button>



          <form id="operForm" method="get">
            <input type='hidden' id='userid' name='userid' value='<c:out value="${memberVO.userid}"/>'>
            <input type='hidden' name='pageNum' value='<c:out value="${searchInfo.pageNum}"/>'>
            <input type='hidden' name='amount' value='<c:out value="${searchInfo.amount}"/>'>
            <input type='hidden' name='keyword' value='<c:out value="${searchInfo.keyword}"/>'>
            <input type='hidden' name='type' value='<c:out value="${searchInfo.type}"/>'>
          </form>

          <form id="operFormPost" method="post">
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

  var memberAuth = '${memberAuth}';
  $('input:checkbox[name="auth"]').each(function() {
    if(memberAuth.includes(this.value)) {
      this.checked=true;
    }
  });
</script>

<script type="text/javascript">

  $(document).ready(function() {

    var operForm = $("#operForm");
    var operFormAuth = $("#operFormAuth");
    var operFormPost = $("#operFormPost");
    $("button[data-oper='modify']").on("click", function(e) {
      if($("input:checkbox[name='auth']").is(":checked")==false) {
        alert("적어도 하나의 권한은 있어야 합니다.");
      } else {
        operFormAuth.attr("action", "/member/memberupdate").submit();
      }
    });

    $("button[data-oper='memberlist']").on("click", function(e) {
      operForm.find("#userid").remove();
      operForm.attr("action", "/member/memberlist")
      operForm.submit();
    });

  });
</script>
