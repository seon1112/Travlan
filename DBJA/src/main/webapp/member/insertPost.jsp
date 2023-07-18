<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>detailPost</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400"/>
  <link rel="stylesheet" href="../styles/insertPost.css?after"/>
  
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
$(document).ready(function() {
	$("#p_pic").on("change", handleImgFileSelect);
});

function handleImgFileSelect(e) {
	var files=e.target.files;
	var reader = new FileReader();
	reader.onload = function(e) {
		$("#img").attr("src", e.target.result);
	}
	reader.readAsDataURL(files[0]);
}

</script>  
</head>
<body>
<div class="detailPost">
  <form action="insertPostOK.do" method="post" enctype="multipart/form-data">
	  <div class="titleOuter">
	  	<div class="tname">게시물 등록</div>
	  </div>
	  
	  <div class="main">
	  	<div class="main_top">
		  <%-- 	<div class="travelInfo">
				    	<div class="writer">작성자</div>
				    	<div class="name"> ${p.name }</div>
			</div> --%>
				<div class="pictxt">사진을 등록해주세요.</div>
		    	<img class="picture" id="img"/>
		    	<input type="file" id="p_pic" name="p_pic" class="pic"><br>
			    <div class="hashtagOuter">
			    해시태그 3개를 작성해주세요.
			    	<input type="text" name="hashtags" class="hashtag">
			    </div>
		</div>
	    <div class="itineraryOuter">
	      <div class="tname">
	    	<select name="tname" class="select">
	    		<c:forEach var="t" items="${list }">
	    			<option value="${t.tname }">${t.tname }</option>
	    		</c:forEach>
	    	</select>
	      </div>

	    </div>
	    	<div class="content">
	    		<textarea class="textarea" rows="10" cols="10" name="pcontent"></textarea>
	    	</div>
	  </div>
	
	    
	  <div class="btn"><input type="submit" value="등록" class="submit"></div>
  </form>
</div>
</body>
</html>