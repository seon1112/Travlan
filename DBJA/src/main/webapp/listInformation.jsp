<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>information_search</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR%3A400%2C500%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C700"/>
  <link rel="stylesheet" href="styles/listInformation.css?after"/>
  <style type="text/css">
  	a{
  		text-decoration:none;
  		color: black;
  	}
  	#nonepage{
  		text-decoration:none;
  		color: #ced4da; 
  	}

  </style>
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
<!-- 전체 div 시작 -->
<div class="div_all">
  <div class="div_title">여행지 정보</div>
  <!-- 검색창, 버튼 form 시작 -->
   <form action="listInformation.do" class="div_search" method="post" >
      <input type="text" class="search" name="keyword">
	  <input type="submit" class="btn" value="검색">
   </form>
  <!-- 검색창, 버튼 form 끝 -->
  
  <!-- 내용(정보) div 시작 -->
  <div class="div_content">
  	<!-- 정렬 방법 담은 div 시작 -->
    <div class="div_sort">
      <div class="sortname" name="sortname">
      	<a id="sort" href="listInformation.do?sort=iname">이름순</a></div>
      <div class="sortpopular" name="sortpopular">
      	<a id="sort" href="listInformation.do?sort=click">인기순</a></div>
      <div class="sortcorrect" name="sortcorrect">
      	<a id="sort" href="listInformation.do?sort=correct">정확도순</a></div>
    </div>
    <!-- 정렬 방법 담은 div 끝 -->
    
    <!-- 정보(9개)담는 큰 div 시작 -->
    <div class="div_information">
    	<!-- 정보 하나 담는 div 시작 -->
    	<c:forEach var="i" items="${list }">
	    	<div class="info">
	    		  <!-- 정보 윗 부분 div 시작 -->
		          <div class="info_top">
		          	<!-- 여행지 사진 div 시작 -->
		            <div class="divimg">
		              <img class="infoimg" src="assets/gamcheonri.png"/>
		            </div>
		            <!-- 여행지 사진 div 끝 -->
		            
		            <!-- 여행지 title 담긴 div 시작 -->
		            <div class="infotitle">
		              <div class="name">${i.iname }</div>
		              <!-- 주소와 평점 담긴 div 시작 -->
		              <div class="addrrate">
		                <div class="addr">${i.addr }</div>
		                <div class="rate">평점 ${i.grade }</div>
		              </div>
		              <!-- 주소와 평점 담긴 div 끝 -->
		            </div>
		             <!-- 여행지 title 담긴 div 끝 -->
		          </div>
		          <!-- 정보 윗 부분 div 끝 -->
		          
		          <!-- 정보 아래 부분 div 시작 -->
		          <div class="info_bottom">
		            <div class="infocontent">
		            	${i.icontent }
		            </div>
		            <div class="more"><a href="member/detailInformation.do?ino=${i.ino }">더보기 &gt;&gt;</a></div>
		          </div>
		          <!-- 정보 아래 부분 div 끝 -->
	        </div>
	        <!-- 정보 하나 담는 div 끝 -->
        </c:forEach>
       
       
	</div>
	<!-- 정보(9개)담는 큰 div 끝 -->
  </div>
  <!-- 내용(정보) div 끝 -->

	<!-- 페이징 처리 div 시작 -->
	<div class="divinf_paging">
	  <!-- 맨 앞으로 -->
	  <div class="firstpage"><a href="listInformation.do?pageNUM=1">처음</a></div>
	  <!-- 앞으로 -->
	  <div class="prevpage"><a href="listInformation.do?goPage=이전">이전</a></div>
	  <!-- 페이징 순서 -->
	  <div class="pages">
	  	<c:forEach var="p" begin="${firstPage }" end="${lastPage }">
	  	  <c:set var="totalPage" value="${totalPage }"></c:set>
	  	  <c:if test="${p le totalPage}"> <!-- 작거나 같다 -->
 	      	<span class="page"><a id="page" href="listInformation.do?pageNUM=${p }">${p }</a></span>
 	      </c:if>
 	      <c:if test="${p gt totalPage}">
 	      	 <span class="nonepage">${p }</span>	      	 
 	      </c:if>
 	      							
	  	</c:forEach>
	  </div> 
	  <!-- 뒤로  -->
	  <div ><a class="nextpage" href="listInformation.do?goPage=다음&pageNUM=${lastPage}">다음</a></div>
	  <!-- 맨 뒤로 -->
	  <div class="lastpage"><a href="listInformation.do?goPage=마지막">마지막</a></div>
	</div>
	<!-- 페이징 처리 div 끝 -->
</div>
<!-- 전체 div 끝 -->
</body>
</html>