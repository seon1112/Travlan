<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>listPost</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR%3A400%2C500%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C700"/>
  <link rel="stylesheet" href=".././styles/listPost.css"/>
</head>
<body>
<div class="listPost">
  <div class="title">게시판</div>
<!--   <div class="searchAndWriting">
    <div class="inputSearch">
    </div>
    <div class="buttonSearch">검색</div>
    <div class="buttonWriting">글쓰기</div>
  </div> -->
    <form action="listPost.do" class="div_search" method="post" >
      <input type="text" class="search" name="keyword">
	  <input type="submit" class="btn" value="검색">
   	</form>
  <div class=write><a href="insertPost.do">글쓰기</a></div>
  <div class="main">
     <c:forEach var="p" items="${list }">
	     <div class="place1">
	        <div class="picture">
	        	<img class="picture" src="../assets/travel.jpg">
	        </div>
	        <div class="content">
	        	${p.pcontent }
	        </div>
	        <div class="hashtagAndDetailsbutton">
	          <div class="hashtag">
		          ${p.hashtag1 }
		          ${p.hashtag2 }
		          ${p.hashtag3 }
	          </div>
	          <div class="detailsbutton" ><a href="detailPost.do?postno=${p.postno }">더보기 &gt;&gt;</a></div>
	        </div>
	      </div>
     </c:forEach>
  	
      
     
    
      </div>
    </div>
 

</body>
</html>