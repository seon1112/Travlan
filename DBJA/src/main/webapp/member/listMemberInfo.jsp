<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <link rel="icon" href="/favicon.ico" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>listMemberInfo</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter%3A700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A700"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href=".././styles/listmemberinfo.css"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
<div class="listmemberinfo">
  <div class="title">마이페이지</div>
  <div class="mypagemain">
  <!-- 회원정보 -->
    <div class="memberinfoouter">
      <div class="auto-group-info">
        <div class="auto-group-id">
          <div class="id">ID</div>
          <div class="userid">
            <i class="fa fa-id-badge"  style="font-size:23px; margin-right:1rem;"   aria-hidden="true"></i>
            <input type="text" name="id" value=${info.id } >
          </div>
        </div>
        <div class="auto-group-name">
          <div class="name">이름</div>
          <div class="username">
          	<i class="fa fa-user" aria-hidden="true"  style="font-size:23px; margin-right:1rem;" ></i>
            <input type="text" name="name" value=${info.name } >
          </div>
        </div>
        <div class="auto-group-birth">
          <div class="birth">생년월일</div>
          <div class="userbirth">
         	 <i class="fa fa-birthday-cake" aria-hidden="true" style="font-size:23px; margin-right:1rem;"></i>
            <input type="text" name="birth" value=${info.birth }>
          </div>
        </div>
        <div class="auto-group-email">
          <div class="email">이메일</div>
          <div class="useremail">
          <i class="fa fa-envelope" aria-hidden="true"  style="font-size:23px; margin-right:1rem;"></i>
            <input type="text" name="email" value=${info.email }>
          </div>
        </div>
      </div>
      <div class="memberinfobtn">
        <div class="btnUpdate">회원정보 수정</div>
        <div class="btnDelete">회원 탈퇴</div>
      </div>
    </div>
    
    
    <div class="middleline">
    </div>
    <div class="auto-group-right">
      <div class="travellistouter">
        <div class="auto-group-travelListTop">다가올 여행</div>
		<c:forEach items="${travelList}" var="t" varStatus="status">
		<c:choose>
		<c:when test="${status.index  == 0}">
        <div class="div_mytrip1">
          <div class="auto-group-iconAndTname">
            <div class="tname1">${t.tname }</div>
          </div>
          <div class="tstart1"> ${t.tstart }~${t.tend }</div>
        </div>
        </c:when>
        <c:when test="${status.index  == 1}">
        <div class="div_mytrip2">
          <div class="tname2">
          ${t.tname }
          </div>
          <div class="tstart2">
          ${t.tstart }~${t.tend }
          </div>
        </div>
        </c:when>
        <c:when test="${status.index  == 2}">
        <div class="div_mytrip3">
          <div class="tname3">
          ${t.tname }
          </div>
          <div class="tstart3">
          ${t.tstart }~${t.tend }
          </div>
        </div>
        </c:when>
        </c:choose>
        </c:forEach>
      </div>
      <div class="heartlistouter">
        <div class="auto-group-listTop">
          <div class="div_heart">
            <div class="heart">
            </div>
          </div>
          <div class="div_heartlist">좋아요 리스트</div>
        </div>
        <c:forEach var="h" items="${heart }" begin="0" end="4">
        <div class="auto-group-list1">
        
          <div class="div_heart">
            <div class="heart">
            <i class="fa fa-heart" style="font-size:25px; color:red;"></i>
            </div>
          </div>
          <div class="div_place">
            <div class="place">
            ${h }
            </div>
          </div>
        
        </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>
</body>
</html>