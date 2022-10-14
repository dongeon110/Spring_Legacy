<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-10-13
  Time: 오후 6:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Title</title>
    </head>
    <body>
        <form action = "/sample/exUploadPost" method="post"
              enctype = "multipart/form-data">
            <div>
                <input type="file" name="files">
            </div>
            <div>
                <input type="file" name="files">
            </div>
            <div>
                <input type="file" name="files">
            </div>
            <div>
                <input type="file" name="files">
            </div>
            <div>
                <input type="file" name="files">
            </div>
            <div>
                <input type="submit">
            </div>
        </form>
    </body>
</html>
