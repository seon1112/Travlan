<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{
	overflow: scroll;
}
	#header, #footer{
		width: 100%;
		height: 20%;
		}
	
	#content{
		width:100%;
		height: 60%;
	}
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="header.jsp"/>
	</div>

	<div id="content">
		<jsp:include page="${viewPage }"/>
	</div>


	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>