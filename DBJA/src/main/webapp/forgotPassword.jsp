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
	<title>forgotPassword</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat%3A600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter%3A500"/>
	<link rel="stylesheet" href="./styles/forgotpassword.css"/>
</head>
<body>
	<div class="forgotPwdAll">
	  <div class="contentAll">
	    <div class="findPwdText">비밀번호 찾기</div>
	    <div class="travlanText">TRAVLAN</div>
	    <div class="formAll">
		  <form action="forgotPasswordOK.do" method="post">
		    <div class="divIDForm">
		      <div class="labelID">아이디</div>
		      <div class="inputIDForm">
		        <input type="text" class="inputID" name="id">
		        <div class="btnID">확인</div>
		      </div>
		    </div>
		    <div class="divNameForm">
		      <div class="labelName">이름</div>
		      <input type="text" class="inputName" name="name">
		    </div>
		    <div class="divEmail">
		      <div class="labelEmail">이메일</div>
		      <input type="text" class="inputEmail" name="email">
		    </div>
		    <div class="findIDGroup">
		      <div class="labelFindIDText">아이디가 기억나지 않는다면?</div>
		      <a href="findMemberID.do" class="linkFindID">아이디 찾기</a>
		    </div>
		    <font color="red">${msg}</font>
		    <input type="submit" class="btnFindPwd" value="비밀번호 찾기">
		    <div class="btnBack">뒤로가기</div>
		  </form>
		</div>
	  </div>
	</div>
</body>
</html>