<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">회원 목록</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">회원 목록
      </div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <table class="table table-striped table-bordered table-hover">
          <thead>
          <tr>
            <th>#번호</th>
            <th>ID</th>
            <th>이름</th>
            <th>가입일</th>
          </tr>
          </thead>

          <c:forEach var="memberVO" items="${memberVOList}">
            <tr>
              <td>${memberVO.rowNum + (searchInfo.pageNum -1) * (searchInfo.amount)}</td>
              <td>
                <a class="move" href='<c:out value="${memberVO.userid}"/>'>
                    ${memberVO.userid}
                </a>
              </td>
              <td>
                  ${memberVO.userName}
              </td>

              <td><fmt:formatDate pattern="yyyy-MM-dd" value="${memberVO.regDate}"/></td>
            </tr>
          </c:forEach>
        </table>
        <div class="row">
          <div class="col-lg-12">

            <form id='searchForm' action="/member/memberlist" method="get">
              <select name="type">
                <option value="I"
                        <c:out value="${pageMaker.searchInfo.type == 'I'? 'selected' : ''}"/>>ID</option>
                <option value="N"
                        <c:out value="${pageMaker.searchInfo.type == 'N'? 'selected' : ''}"/>>이름</option>
              </select>
              <input type='text' name='keyword'
                     value='<c:out value="${pageMaker.searchInfo.keyword}"/>' size='50'>
              <input type='hidden' name="pageNum" value='<c:out value="${pageMaker.searchInfo.pageNum}"/>'/>
              <input type='hidden' name="amount" value='<c:out value="${pageMaker.searchInfo.amount}"/>'/>
              <button type='btn btn-default'><i class="fa fa-search"></i></button>
            </form>
          </div>
        </div>

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

        <form id="actionForm" action="/member/memberlist" method="get">
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
        $(".modal-body").html("result: " + parseInt(result));
      }

      $("#myModal").modal("show");
    }

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
      actionForm.append("<input type='hidden' name='userid' value='" +
              $(this).attr("href")+"'>");
      actionForm.attr("action", "/member/memberdetail");
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
        window.location.replace("/member/memberlist");
        return false;
      }

      searchForm.find("input[name='pageNum']").val("1");
      e.preventDefault();
      searchForm.submit();
    });
  });
</script>