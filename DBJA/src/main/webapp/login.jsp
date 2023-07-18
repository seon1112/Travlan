<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<link rel="icon" href="/favicon.ico" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="theme-color" content="#000000" />
	<title>login</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat%3A600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C600"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
	<link rel="stylesheet" href="./styles/login.css"/>
	
</head>
<body>
	<div class="loginPage">
	  <div class="contentAll">
	    <div class="loginText">LOG IN</div>
	    <div class="travlanText">TRAVLAN</div>
	    <div class="divformContainer">
			<form action="loginOK.do" method="post">
			    <div class="divIDForm">
			      <div class="labelIDText">아이디</div>
			      <div class="inputID">
			        <input type="text" class="inputID" name="id">
			      </div>
			    </div> 
			    <div class="divPwdForm">
			      <div class="labelPwdText">비밀번호</div>
			      <div class="inputPwd">
			        <input type="password" class="inputPwd" name="pwd">
			      </div>
			    </div>
			    <div class="findGroup">
			      <a href="forgotPassword.do" class="linkFindPwd">비밀번호 찾기</a>
			      <a href="findMemberID.do" class="linkFindID">아이디 찾기</a>
			    </div>
			    <font color="red">${msg}</font>
			    <button type="submit" class="btnLogin">로그인</button>
			    <div class="itemSignupGroup">
			      <span class="itemSignupText">회원이 아니세요? </span>
			      <a href="signup.do" class="Signup">회원가입하기</a>
			    </div>
			</form>
		</div>
	    <div class="divDividerContainer">
	      <div class="divDividerLine"></div>
	      <div class="spanOrText">or</div>
	    </div>
	    <div class="snsSimpleLoginText">SNS 간편 로그인</div>
	    <div class="divSnsBtn">
	    	    
	    <!-- 네이버 로그인 -->
	    <%
    String clientId = "mFaZZacB1eEWou4FFBea";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/DBJA_1/callback.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
         + "&client_id=" + clientId
         + "&redirect_uri=" + redirectURI
         + "&state=" + state;
    session.setAttribute("state", state);
 %>
  <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
	    </div>
	  </div>
	</div>
</body>
</html>