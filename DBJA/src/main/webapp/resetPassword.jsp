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
	<title>resetPassword</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter%3A500"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat%3A400%2C600"/>
	<link rel="stylesheet" href="./styles/resetpassword.css"/>
</head>
<body>
	<div class="resetPwdPage">
	  <div class="contentAll">
	    <div class="resetPwdText">비밀번호 재설정</div>
	    <div class="travlanText">TRAVLAN</div>
	    <div class="formAll">
  <form action="resetPassword.do" method="post">
    <div class="divIDForm">
      <div class="labelID">아이디</div>
      <div class="divInputIDForm">
        <input type="text" class="inputID" name="id">
        <div class="btnIDOK">확인</div>
      </div>
    </div>
    <div class="divPwdForm">
      <div class="labelPwd">새 비밀번호</div>
      <div class="divPwdText">
        <input type="password" placeholder="비밀번호(문자,숫자,특수문자 포함 10~20자)" class="inputPwd" name="newPwd">
      </div>
    </div>
    <div class="divPwdCheckForm">
      <div class="labelPwdCheck">새 비밀번호 확인</div>
      <div class="divPwdCheckText">
        <input type="password" placeholder="비밀번호 재입력" class="inputPwdCheck" name="newPwdCheck">
      </div>
    </div>
    <div class="findIDGroup">
      <div class="labelFindIDText">아이디가 기억나지 않는다면?</div>
      <a href="findMemberID.do" class="linkFindID">아이디 찾기</a>
    </div>
    <font color="red">${msg}</font>
    <input class="btnFindPwd" type="submit" value="비밀번호 재설정">
    <div class="btnBack">뒤로가기</div>
  </form>
</div>
	  </div>
	</div>
</body>
</html>