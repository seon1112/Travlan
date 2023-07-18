<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<link rel="icon" href="/favicon.ico" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="theme-color" content="#000000" />
	<title>findMemberIDResult</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat%3A600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter%3A500%2C600"/>
	<link rel="stylesheet" href="./styles/findmemberidresult.css"/>
</head>
<body>
	<div class="findMemberIDResultPage">
	  <div class="contentAll">
	    <div class="findMemberIDResultText">아이디 찾기  결과</div>
	    <div class="travlanText">TRAVLAN</div>
	    <div class="infoText">고객님의 정보와 일치하는 아이디입니다.</div>
	    <div class="formResultID">
	      <div class="ResultID">${id }</div>
	      <div class="findPwdGroup">
	        <div class="labelFindPwd">비밀번호가 기억나지 않는다면?</div>
	        <!-- <div class="linkFindPwd">비밀번호 찾기</div> -->
	        <a href="forgotPassword.do" class="linkFindPwd">비밀번호 찾기</a>
	      </div>
	      <!-- <div class="btnLogin">로그인하기</div> -->
	      <form action="login.do" method="post">
	      <!-- <button class="btnLogin" onclick="window.location.href = 'login.do'">로그인</button> -->
	      <input type="submit" class="btnLogin" value="로그인">
	      </form>
	    </div>
	  </div>
	</div>
</body>
</html>