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
  <link rel="stylesheet" href="../styles/detailPost.css?after"/>
</head>
<body>
<div class="detailPost">
  <div class="titleOuter">
  	<div class="tname"> ${p.tname }</div>
  </div>
  
  <div class="main">
  	<div class="main_top">
	  <%-- 	<div class="travelInfo">
			    	<div class="writer">작성자</div>
			    	<div class="name"> ${p.name }</div>
		</div> --%>
	    	<img class="picture" src="../assets/travel.jpg">
		    <div class="hashtagOuter">
		    	<div class="hashtag">${p.hashtag1 }&nbsp;${p.hashtag2 }&nbsp;${p.hashtag3 }</div>
		    </div>
	</div>
    <div class="itineraryOuter">
    	<div class="scheduleInfo">
		    <div class="	schedule"> ${p.tstart }&nbsp;~&nbsp;${p.tend }</div>
		</div>
		<div class="budgetInfo">
	    	<div class="budget">💲</div>
	    	<div class="money">&nbsp;&nbsp;${p.budget }원</div>
		</div>
    </div>
    	<div class="content">${p.pcontent }</div>

  </div>
  <div class="commentOuter">
    <div class="commentTitle">comment</div>
     <!-- 별점 등록, 검색 div 시작 -->
    <form action="insertComments.do" class="commentForm" name="commentForm" method="post">
       
      <!-- 검색, 버튼 div 시작 -->
       	 <input type="hidden" name="postno" value=${p.postno }>
     <div class="div_star_search">
         <input type="text" class="commentContents" name="c_comment">
         <input type="submit" class="btn" value="등록">
       </div>
       <!-- 검색, 버튼 div 끝 -->
    </form>
    <!-- 별점 등록, 검색 div 끝 -->
        
        <!--  리뷰 리스트 시작 -->
     <div class="divinf_commentlist">
       <!-- 리뷰 1 --> 
       <c:forEach var="comment" items="${list }">
       	 <div class="divinf_comment1">
         	 <div class="divinf_comment1id">${comment.id }</div>
        	 <div class="divinf_comment1txt">“${comment.c_content }”</div>
       </div>
       </c:forEach>
     </div>
     <!--  리뷰 리스트 끝 -->
   </div>
   <!-- 리뷰 끝 -->
    
    
    
  <div class="button">
      <a href="deletePost.do?postno=${p.postno }"><div class="buttonDelete">삭제</div></a>
  </div>

</div>
</body>
</html>