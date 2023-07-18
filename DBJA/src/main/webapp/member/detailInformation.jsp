<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>detail Information</title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>information_detail</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR%3A400%2C500%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter%3A400"/>
  <link rel="stylesheet" href=".././styles/detailInformation.css?after"/>
  <link rel="stylesheet" href=".././styles/star.css?after"/>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1f2916fe9be7d4973e1955c2e2aeff14"></script>
<script>
$(document).ready(function() {
	
    $('#heart').click(function() {
        alert("좋아요 리스트에서 삭제되었습니다.");
    })
    
    $('#noheart').click(function() {
        alert("좋아요 리스트에 추가되었습니다.");
    })
});
</script>
<body>
<!-- 전체 div 시작 -->
<div class="divinf">

  <div class="divinf_title">여행지 상세 정보</div>
  <!-- 조회수 및 찜하기 버튼 div 시작 -->
  <div class="divinf_popular" id="popular">
  	  <c:if test="${re eq true}">
		  <div class="divinf_click">조회수 ${i.click }</div>
		  <a id="heart" href="detailInformation.do?ino=${i.ino }&heart=${heart}">
			<img class="divinf_heart" src="../assets/heart.png"/>
		  </a><!--  -->
	  </c:if>
	  <c:if test="${re eq false}">
	  	  <div class="divinf_click">조회수 ${i.click }</div>
		  <a id="noheart" href="detailInformation.do?ino=${i.ino }&heart=${heart}">
			<img class="divinf_heart" src="../assets/noheart.png"/>
		  </a>
	  </c:if>
	  	
  </div>
  <!-- 조회수 및 찜하기 버튼 div 끝 -->
  
  <!-- 본문 ~ 페이징처리 div 시작 -->
  <div class="divinf_content">
  	<!-- 본문 ~ 리뷰 div 시작 -->
    <div class="divinf_cont_ext_paging">
      <!-- 여행지이름, 주소, 사진 div 시작 -->
      <div class="divinf_place_main">
      	<!-- 여행지이름, 주소, 한 줄 소개 div 시작 -->
        <div class="divinf_place_txt">
          <div class="placename">${i.iname }</div>
          <!-- 여행지 주소, 한 줄 소개 div 시작 -->
          <div class="placetxt">
            <c:if test="${i.review ne ''}">
           		<div class="shortinfo">“${i.review }”</div>
            </c:if>
            <c:if test="${i.review eq ''}">
           		<div class="shortinfo"></div>
            </c:if>
            <div class="placeaddr">${i.addr }</div>
          </div>
          <!-- 여행지 주소, 한 줄 소개 div 끝 -->
        </div>
        <!-- 여행지이름, 주소, 한 줄 소개 div 끝 -->
        
        <!-- 여행지 사진 div  -->
        <img class="placeimg" src="../assets/gamcheonri.png"/>
        <!-- 여행지 위치 div -->
        
        <div class="map" id="map">
        	<input type="hidden" id="latitude" value="${i.latitude }"> 
        	<input type="hidden" id="longitude" value="${i.longitude }"> 
        </div>
	        <script>
				var container = document.getElementById('map');
				var options = {
					center: new kakao.maps.LatLng($("#latitude").val(), $("#longitude").val()),
					level: 3
				};
		
				var map = new kakao.maps.Map(container, options);
				var markerPosition  = new kakao.maps.LatLng($("#latitude").val(), $("#longitude").val()); 

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
			</script>
      </div>
      <!-- 여행이름, 주소, 사진 div 끝 -->
      
      <!-- 여행소개 div 시작 -->
      <div class="divinf_place_info"> <!-- 스크롤 가진 아이 -->
        <div class="placeinfo">
        ${i.icontent } 
        </div>
      </div>
      <!-- 여행소개 div 끝 -->
      
      <!-- 리뷰 시작  -->
      <div class="divinf_review">
      	<!-- 리뷰 소개, 평균평점 div 시작 -->
        <div class="divinf_reviewinfo">
          <div class="review">review</div>
          <!-- 평균평점 div 시작 -->
          <div class="div_avgrate">
            <span class="avgrate_txt">평균평점 </span>
            <span class="avgrate_num">${i.grade }</span>
          </div>
          <!-- 평균평점 div 끝 -->
        </div>
        <!-- 리뷰 소개, 평균평점 div 끝 -->
        
        <!-- 별점 등록, 검색 div 시작 -->
        <form action="insertReview.do" class="mb-3" name="reviewForm" id="reviewForm" method="post">
        	<input type="hidden" name="ino" value=${i.ino }>
	        <div class="div_star_search">
	          <!-- 별점 div 시작 -->
	          <div class="divinf_stars">
				<fieldset>
					<input type="radio" name="grade" value="5" id="rate1"><label
						for="rate1">★</label>
					<input type="radio" name="grade" value="4" id="rate2"><label
						for="rate2">★</label>
					<input type="radio" name="grade" value="3" id="rate3"><label
						for="rate3">★</label>
					<input type="radio" name="grade" value="2" id="rate4"><label
						for="rate4">★</label>
					<input type="radio" name="grade" value="1" id="rate5"><label
						for="rate5">★</label>
				</fieldset>
			 	
			  </div>	
	          <!-- 별점 div 끝 -->
	          
	         <!-- 검색, 버튼 div 시작 -->
	          <div class="divinf_search">
	            <input type="text" id="reviewContents" name="rcontent" value="">
	            <input type="submit" class="btn" value="등록">
	          </div>
	          <!-- 검색, 버튼 div 끝 -->
	        </div>
        </form>
        <!-- 별점 등록, 검색 div 끝 -->
        
        <!--  리뷰 리스트 시작 -->
        <div class="divinf_reviewlist">
          <!-- 리뷰 1 --> 
          <c:forEach var="r" items="${list2 }">
          	 <div class="divinf_review1">
	           	 <div class="divinf_review1id">${r.id }</div>
	         	 <div class="divinf_review1rate">${r.grade }.0</div>
	          	 <div class="divinf_review1txt">“${r.rcontent }”</div>
	         </div>
          </c:forEach>
        </div>
        <!--  리뷰 리스트 끝 -->
      </div>
      <!-- 리뷰 끝 -->
    </div>
    <!-- 본문 ~ 리뷰 끝 -->
    
<!--     페이징 처리 div 시작
    <div class="divinf_paging">
      맨 앞으로
      <img class="firstpage" src="images/leftleft.png"/>
      앞으로
      <img class="prevpage" src="images/left.png"/>
      페이징 순서
      <div class="pages">
	      <span class="selectedpage">1</span>
	      <span class="page2">2</span>
	      <span class="page3">3</span>
	      <span class="page4">4</span>
	 	  <span class="page5">5</span>
	      <span class="page6">6</span>
	      <span class="page7">7</span>
	  </div> 
      뒤로 
      <img class="nextpage" src="images/right.png"/>
      맨 뒤로
      <img class="lastpage" src="images/rightright.png"/>
    </div>
    페이징 처리 div 끝
  </div>
  본문 ~ 페이징처리 div 끝 -->
</div>
<!-- 전체 div 끝 -->
</body>
</html>