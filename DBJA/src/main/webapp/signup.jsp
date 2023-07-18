<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <meta charset="utf-8" />
  <link rel="icon" href="/favicon.ico" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>회원 가입</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C600"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter%3A500"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat%3A400%2C600"/>
  <link rel="stylesheet" href="./styles/signup.css"/>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script>
	$(document).ready(function() {
		  $('.btnIDOK').click(function() {
		    var id = $('#inputID').val(); // 입력된 아이디를 가져옵니다
		    console.log("ID: " + id); // 콘솔에 아이디 출력
		    var isValid = /^[a-zA-Z0-9._]{6,20}$/.test(id); // 아이디 유효성 검사

		    if (!isValid) {
		      alert('아이디는 알파벳 (대소문자), 숫자, 밑줄(_), 마침표(.)로 구성되어야 하며 6자 이상 20자 이하여야 합니다.');
		      return; // 아이디 유효성 검사 실패 시 함수 종료
		    }
		    
	    $.ajax({
	      type: 'POST',
	      url: 'checkDuplicateId.jsp',
	      data: { id: id },
	      success: function(response) {
	    	  console.log("response : "+response)
	        if (response==1) {
	          alert('중복된 아이디입니다. 다른 아이디를 입력해주세요.');
	        } else {
	          alert('사용할 수 있는 아이디입니다.');
	        }
	      },
	      error: function(xhr, status, error) {
	        alert('서버와의 통신 중 오류가 발생했습니다.');
	      }
	    });
	  });
	});
	</script>

</head>
<body>
  <div class="signupPage">
    <div class="contentAll">
      <div class="signupText">회원 가입</div>
      <div class="travlanText">TRAVLAN</div>
      <div class="divFormContainer">
        <form action="signupSuccess.do" method="post">
          <div class="divIDForm">
            <div class="labelID">아이디</div>
            <div class="divIDInputForm">
              <div class="inputID">
                <input type="text" class="inputID" id="inputID" name="id" required="required" autofocus="autofocus" pattern="^[a-zA-Z0-9._]{6,20}$" title="아이디는 알파벳 (대소문자), 숫자, 밑줄(_), 마침표(.)로 구성되어야 하며 6자 이상 20자 이하여야 합니다.">
              </div>
              <div class="btnIDOK">확인</div>
            </div>
          </div>
          <div class="divNameForm">
            <div class="labelName">이름</div>
            <div class="inputName">
              <input type="text" class="inputName" name="name" required="required">
            </div>
          </div>
          <div class="divBirthForm">
            <div class="labelBirth">생년월일</div>
            <div class="inputBirth">
              <input type="text" placeholder="생년월일 8자리" class="inputBirth" name="birth" required="required" pattern="[0-9]{8}" maxlength="8" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
            </div>
          </div>
          <div class="divEmail">
            <div class="labelEmail">이메일</div>
            <div class="inputEmail">
              <input type="email" class="inputEmail" name="email" required="required">
            </div>
          </div>
          <div class="divPwd">
            <div class="labelPwd">비밀번호</div>
            <div class="divPwdText">
              <input type="password" placeholder="비밀번호(문자, 숫자, 특수문자 포함 10~20자)" class="inputPwd" name="pwd" required="required">
            </div>
          </div>
          <div class="divPwdCheck">
            <div class="labelPwdCheck">비밀번호 확인</div>
            <div class="divPwdCheckText">
              <input type="password" placeholder="비밀번호 재입력" class="inputPwdCheck" name="pwdCheck" required="required">
            </div>
          </div>
          <font color="red">${msg}</font>
          <input type="submit" class="btnSignup" value="회원가입">
          <div class="btnBack">뒤로가기</div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
