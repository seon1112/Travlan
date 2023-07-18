<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>header</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400"/>
  <link rel="stylesheet" href="styles/header.css?after"/>
    <style type="text/css">
  	a{
  		text-decoration:none;
  		color: black;
  	}

  </style>
</head>
<body>
<div class="header-5Zx">
  <div class="nav-JxW">
    <img class="logo-7Ya" src="assets/logo.png" onclick="location.href='main.do'"></img>
    <div class="divcontainer-Amk">
      <div class="list-gzz">
        <a class="item-link-home-Emc" href="member/myTrip.do">나의여행</a>
        <a class="information" href="listInformation.do">여행정보</a>
        <a class="board" href="member/listPost.do">게시판</a>
        <a class="board" href="member/listQuestion.do?id=<%="cocomo3" %>">문의하기</a>
      </div>
      <div class="list-iTp">
        <a class="item-link-login-USz" href="login.do">로그인</a>
        <a class="item-link-sign-up-bnW" href="signup.do">회원가입</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>