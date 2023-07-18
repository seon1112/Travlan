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
	<title>findMemberID</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat%3A600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter%3A500"/>
	<link rel="stylesheet" href="./styles/findmemberid.css"/>
</head>
<body>
	<div class="findMemberIDPage">
	  <div class="contentAll">
	    <div class="findIDText">아이디 찾기</div>
	    <div class="travlanText">TRAVLAN</div>
	    <div class="formAll">
		  <form action="findMemberIDResult.do" method="post">
		    <div class="divNameForm">
		      <div class="labelName">이름</div>
		      <div class="inputName">
		        <input type="text" class="inputName" name="name">
		      </div>
		    </div>
		    <div class="divEmailForm">
		      <div class="labelEmail">이메일</div>
		      <div class="inputEmail">
		        <input type="text" class="inputEmail" name="email">
		      </div>
		    </div>
		    <div class="findPwdGroup">
		      <div class="labelFindPwd">비밀번호가 기억나지 않는다면?</div>
		      <a href="forgotPassword.do" class="linkFindPwd">비밀번호 찾기</a>
		    </div>
		    <font color="red">${msg}</font>
		    <input type="submit" class="btnFindID" value="아이디 찾기">
		    <div class="btnBack">뒤로가기</div>
		  </form>
		</div>
	  </div>
  </div>
</body>
</html>