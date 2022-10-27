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


		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB

		function checkExtension(fileName, fileSize){

			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}

			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}

		var csrfHeaderName ="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";


		$("input[type='file']").change(function(e){

			var formData = new FormData();

			var inputFile = $("input[name='uploadFile']");

			var files = inputFile[0].files;

			for(var i = 0; i < files.length; i++){

				if(!checkExtension(files[i].name, files[i].size) ){
					return false;
				}
				formData.append("uploadFile", files[i]);

			}

			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data:formData,
				type: 'POST',
				dataType:'json',
				success: function(result){
					console.log(result);
					showUploadResult(result); //업로드 결과 처리 함수

				}
			}); //$.ajax

		});

		function showUploadResult(uploadResultArr){

			if(!uploadResultArr || uploadResultArr.length == 0){ return; }

			var uploadUL = $(".uploadResult ul");

			var str ="";

			$(uploadResultArr).each(function(i, obj){

				if(obj.image){
					var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					str += "<li data-path='"+obj.uploadPath+"'";
					str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
					str +" ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str +"</li>";
				}else{
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

					str += "<li "
					str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
				}

			});

			uploadUL.append(str);
		}

		$(".uploadResult").on("click", "button", function(e){

			console.log("delete file");

			var targetFile = $(this).data("file");
			var type = $(this).data("type");

			var targetLi = $(this).closest("li");

			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type:type},
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},

				dataType:'text',
				type: 'POST',
				success: function(result){
					alert(result);

					targetLi.remove();
				}
			}); //$.ajax
		});

	});

</script>


<%@include file="../includes/footer.jsp" %>


