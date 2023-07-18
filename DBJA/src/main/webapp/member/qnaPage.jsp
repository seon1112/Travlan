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
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="./lightbox/css/jquery.lightbox.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR%3A400%2C700"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C700"/>
<link rel="stylesheet" href=".././styles/qnapage.css"/>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
var qno;
var answerDiv ;
var update;
var content;
var remove;

//답변 확인하기
function toggleAnswer(id, secret) {
	  answerDiv = document.getElementById(id);
	  qno = answerDiv.dataset.qno; // qno 값 가져오기
	  content=answerDiv.dataset.content; 
	  
	  if (answerDiv.className.indexOf("w3-show") == -1) {
	    answerDiv.className = answerDiv.className.replace("w3-hide", "w3-show");
	    if(secret!=1){
	    	answerDiv.innerHTML="";
	    	 $.ajax({
			      url: "findAnswerByQno.jsp",
			      data: { qno: qno },
			      success: function(data) {
			    	
			        answerDiv.innerHTML = content+"<hr>"+data +"<hr>"; // 서버로부터 가져온 데이터로 내부 HTML 업데이트
			        //수정하기 버튼
			        update = document.createElement("button");
			        update.id = "updateBtn";
			        update.addClass="w3-button";
			        update.innerText = "수정";
			        update.addEventListener("click", handleUpdate);// "updateBtn" 버튼에 이벤트 리스너 추가
			        answerDiv.appendChild(update);
			        //삭제하기 버튼
			        remove = document.createElement("button");
			        remove.id = "removeBtn";
			        remove.innerText = "삭제";		
			        remove.addEventListener("click", handleRemove);// "removeBtn" 버튼에 이벤트 리스너 추가
			        answerDiv.appendChild(remove);
			        
			      }
			    });
	    	
	    }
	  } else {
	    answerDiv.className = answerDiv.className.replace("w3-show", "w3-hide");
	  }
	}
	
//공개글 여부에 따라 비밀번호 확인하기
	function checkPassword(qno) {
	  var passwordInput = document.getElementById("password" + qno);
	  var pwd = passwordInput.value;
	 
	  $.ajax({
	    url: "checkSecret.jsp",
	    data:{ pwd : pwd,
	    	  qno: qno },
	    success: function(data) {
	      if(data.trim()=="false"){
	    	  alert("비밀번호가 잘못되었습니다."); // 비밀번호가 일치하지 않는 경우
	      }else{
	    	  answerDiv.innerHTML="";
		    	 $.ajax({
				      url: "findAnswerByQno.jsp",
				      data: { qno: qno },
				      success: function(data) {
				        answerDiv.innerHTML = content+"<hr>"+data +"<hr>"; // 서버로부터 가져온 데이터로 내부 HTML 업데이트
				        //추가하기 버튼
				        update = document.createElement("button");
				        update.id = "updateBtn";
				        update.innerText = "수정";
				        update.addEventListener("click", handleUpdate);// "updateBtn" 버튼에 이벤트 리스너 추가
				        answerDiv.appendChild(update);
				        //삭제하기 버튼
				        remove = document.createElement("button");
				        remove.id = "removeBtn";
				        remove.innerText = "삭제";		
				        remove.addEventListener("click", handleRemove);// "removeBtn" 버튼에 이벤트 리스너 추가
				        answerDiv.appendChild(remove);
				      }
				    });
	      }
	    }
	  });
	}

//답변하기 버튼 선택시 라이트박스 보여주기
	$(document).ready(function(){
		$("#insertAnswerBtn").click(function(){
			var qno=document.querySelector(".selectQuestion").value;
			var acontent=$("#acontent").val();
			$.ajax({
				url:"insertAnswer.jsp",
				data:{qno:qno, acontent:acontent},
				success:function(data){
					alert("답변이 등록되었습니다.");
					location.reload();
				}
			});
		});
	});

 // 글쓰기 버튼 클릭 시 라이트박스 보여주기
	$(document).ready(function() {
 
	  $('#writeBtn').click(function() {
	    console.log("버튼 눌림");
	    $('#lightbox').fadeIn();
	    evt.currentTarget.classList.add("w3-light-grey");
	   
	  });
	  $('#cancelButton').click(function() {
		  $('#lightbox').fadeOut();
		  });
	
	  $('#questionForm').submit(function(event) {
	    event.preventDefault(); // 폼 전송 방지
	
	    var questionTitle = $('input[name="questionTitle"]').val();
	    var questionContent = $('textarea[name="questionContent"]').val();
	    var password = $('input[name="insertpassword"]').val();
	    var secret = $('.w3-check').prop('checked');
	    var id=$("#id").val();
	    
	    $.ajax({
	      url: 'insertQuestion.jsp',
	      method: 'POST',
	      data: {
	    	id : id,
	        qtitle: questionTitle,
	        qcontent: questionContent,
	        qpassword: password,
	        secret: secret
	      },
	      success: function(response) {
	        // 저장 성공 시 라이트박스 숨기기
	        $('#lightbox').fadeOut();
	        alert("질문이 등록되었습니다");
	        location.reload();
	      },
	      error: function() {
	        // 오류 처리
	      }
	    });
	  });
	});
	
	//수정버튼을 누르면 비밀번호 확인 박스가 뜨고 비밀번호가 맞으면 질문 정보 나옴
	function handleUpdate() {
		  console.log("Update 버튼을 클릭했습니다!");
		  document.getElementById('update').style.display='block';
		  //비밀번호 확인 
		  $("#checkUpdatePassword").click(function(){
			  var updatePassword=$("#updatePassword").val();
			  $.ajax({
				  url: "checkSecret.jsp",
				  data: { pwd: updatePassword, qno: qno },
				  success: function(data) {
					  $("#updatePassword").val("");
					  if (data.trim() == "false") {
					        alert("비밀번호가 잘못되었습니다."); // 비밀번호가 일치하지 않는 경우
					      }else{
					    	  //비밀번호가 일치하는 경우 박스 안에 질문 정보를 옮긴다.
					    	  $.ajax({
					    		  url:"detailQuestion.jsp",
					    		  data:{qno:qno},
					    		  success:function(data){
					    			  $("#questionTitle").val(data.qtitle);
					    			  $("#questionContent").val(data.qcontent);
					    			  $("#qpassword").val(data.qpassword);
					    			  document.getElementById('updateDirow').style.display='block';
					    		  }
					    	  })
					      }
				  }
			  });    
		  })
		   
		}
	//질문 내용을 수정하고 저장하기 버튼	
	$(document).ready(function(){
		$("#updateQuestionBtn").click(function(){
			console.log("수정버튼누름");
			var questionTitle = $('input[name="qtitle"]').val();
		    var questionContent = $('textarea[name="qcontent"]').val();
		    var password = $('input[name="qpassword"]').val();
		    var secret = $('input[name="updateChecked"]').prop('checked');

			$.ajax({
				url:"updateQuestion.jsp",
				method: 'POST',
				data:{
					qno: qno,
			        qtitle: questionTitle,
			        qcontent: questionContent,
			        qpassword: password,
			        secret: secret
			      },
				success:function(data){
					 alert("질문이 수정되었습니다.");
					 $("#questionTitle").val("");
	   			  	 $("#questionContent").val("");
	   			  	 $("#qpassword").val("");
					 document.getElementById('update').style.display='none'
					 location.reload();
				}
			})
		})	
	}); 
	//질문을 삭제하기 위한 액션 비밀번호를 확인
	function handleRemove() {
	  console.log("Remove 버튼을 클릭했습니다!");
	  document.getElementById('delete').style.display='block';
	  //비밀번호 확인 
	  $("#checkDeletePassword").click(function(){
		  var updatePassword=$("#deletePassword").val();
		  $.ajax({
			  url: "checkSecret.jsp",
			  data: { pwd: updatePassword, qno: qno },
			  success: function(data) {
				  $("#deletePassword").val("");
				  if (data.trim() == "false") {
				        alert("비밀번호가 잘못되었습니다."); // 비밀번호가 일치하지 않는 경우
				      }else{
				    	  document.getElementById('deleteBtn').style.display='block';
				      }
			  }
		  });    
	  })
	}
	//비밀번호가 일치하는 경우 삭제하기
	$(document).ready(function(){
		$("#deleteBtn").click(function(){
			console.log("삭제버튼");
			  $.ajax({
				  url:"deleteQuestion.jsp",
				  data:{qno:qno},
				  success:function(data){
					  if(data==1){
						  alert("질문이 삭제되었습니다.");
					  }
					  document.getElementById('delete').style.display='none';
					  location.reload();
				  }
			  })
		  })
	})
	  

</script>
<body>


<!-- 질문게시판 -->
<div class="qnaPage">
  <div class="qnaMain" id="qnaMain">
  	<!-- qnaTitle -->
    <div class="qnaTitle">문의하기</div>
    <!-- qna div -->
    <div class="divqna">
    <!-- qna title -->
      <div class="questionTitle">질문 게시판</div>
      <!-- qna pannel -->
      <div class="qna_pannel">
        <div class="divQnaFind">
          <div class="findQuestionTitle">검색어로 검색</div>
          <form action="listQuestion.do" method="post">
          <div class="divQnaFind2">
            <div class="divQnaFind3">
              <div class="findQuestionTitle2">FAQ 전체에서 검색</div>
              <div class="auto-group-2zvc-AWS">
                <select class="selectColumnQna" name="selectColumnQna">
                <option value="qtitle">글제목</option>
                <option value="qcontent">글내용</option>
                </select>
                <div class="keywordQna">
                <input type="text" name="keyword">
                </div>
              </div>
            </div>
            <button type="submit" class="findQnaBtn">검색</button>
            </div>
            </form>
          </div>
        </div>
     
      
      
      <!-- qna list -->
      <div class="qna_pannel2 ">
        <div class="qnaList">
        <c:forEach var="q" items="${list}">
         <button class="question w3-button w3-left-align w3-border" onclick="toggleAnswer('answer${q.qno}', ${q.secret})" style="width: 100%">
   		 ${q.qtitle}
  		</button>
  		<div data-qno="${q.qno}" data-secret="${q.secret}" data-content="${q.qcontent }" id="answer${q.qno}" class="w3-hide w3-container" style="width: 100%; height: 200px;">
  		  	<input type="password" class="w3-input w3-container" id="password${q.qno}" placeholder="비공개글입니다. 비밀번호를 입력해주세요">
    		<button class="w3-button w3-container " onclick="checkPassword(${q.qno})">확인</button>		
  		</div>
  		
		</c:forEach>  
        
        </div>
        <!-- 페이지 목록 -->
        <div class="bottomBar" style="width:100%">
        <!-- 페이징 바 -->
        <div class="w3-right" >
          <div class="w3-bar w3-right-align" style="width:300px; margin-left: auto;">
			  <a href="#" class="w3-button" >&laquo;</a>
			  <c:forEach var="i" begin="1" end="${totalPage }">
			  	<a href="listQuestion.do?pageNUM=${i}" class="w3-button">${i }</a>
			  </c:forEach>
			  <a href="#" class="w3-button">&raquo;</a>
			</div>
        </div>
        <!-- 글쓰기 답변하기 버튼 -->
        
        <div class="qnaBtn">
        	<button id="writeBtn"  class="w3-button insertBtn">글쓰기</button>
        	<button onclick="document.getElementById('answer').style.display='block'" class="w3-button w3-gray insertBtn">답변하기</button>
        </div>
        </div>
      </div>
     
    </div>
  </div>
	<!-- 답변작성 박스 -->
		<div id="answer" class="w3-modal ">
		 <div class="w3-modal-content w3-card-4 w3-animate-zoom divrow-fkS">
		  <header class="w3-container " style="margin-bottom : 1.5rem"> 
		   <span onclick="document.getElementById('answer').style.display='none'" 
		   class="w3-button  w3-xlarge w3-display-topright">&times;</span>
		   <h2>답변 작성하기</h2>
		  </header>
		    <div class="divrow-fkS">
		    <!-- 질문선택 -->
		      <div class="divqtitle-EHk">
		        <div class="label-qtitle-z22">질문 선택하기</div>
		        <select class="selectQuestion">
		        <c:forEach var="a" items="${noAnswer}">
		        <option value="${a.qno }">${a.qtitle }</option>
		        </c:forEach>
		        </select>
		      </div>
		    <!-- 내용입력 -->
		      <div class="divacontent-EBG">
		        <div class="label-username-P4A">내용</div>
		        <textarea id="acontent" rows="10" cols="10" style="height: 207px; width: 414px;" placeholder="내용을 입력해주세요" required></textarea>
		      </div>
		    </div>
		  <div class="w3-container w3-padding"  style="margin-bottom : 1.5rem">
		   <button class="w3-button w3-center w3-border insertBtn" id="insertAnswerBtn"
		   onclick="document.getElementById('answer').style.display='none'">저장하기</button>
		  </div>
		 </div>
		</div>
  
   <!--질문작성하기 라이트 박스 -->
		<div id="lightbox"  class="w3-modal insertquestion-gWa">
		 <div class="divinsertquestion-QSa w3-modal-content w3-card-4 w3-animate-zoom" style="height: 70rem;">
		 	<header class="w3-container " style="margin-bottom : 1.5rem"> 
			   <span onclick="document.getElementById('lightbox').style.display='none'" 
			   class="w3-button  w3-xlarge w3-display-topright">&times;</span>
			   <h2>질문작성하기</h2>
			  </header>
		   		 <div class="divrow-Dup w3-container" >
			     <form action="insertQusetion.jsp" method="post" id="questionForm">
			 	 <!-- 제목작성 -->
			      <div class="divqtitle-ytz">
			        <div class="label-qtitle-Khx">제목</div>
			        <div class="input-SXg">
			         	<input type="text" name="questionTitle" placeholder="제목을 입력해주세요" required>
			        </div>
			      </div>
			    <!-- 질문 내용 작성 -->
			      <div class="divqcontent-xkv">
			        <div class="label-qcontent-HYJ" >내용</div>
			            <textarea name="questionContent" rows="10" cols="10" style="width: 418px; height: 187px;" placeholder="내용을 입력해주세요" required></textarea>
			      </div>
			    <!-- 비밀번호 작성-->
			      <div class="divsecret-Yz2" >
			        <div class="label-secret-6Vk">
			          <span class="label-secret-6Vk-sub-0">비밀번호 </span>
			          <span class="label-secret-6Vk-sub-1">(필수사항)</span>
			        </div>
			        <!-- 비밀번호 입력 -->
			        <div class="input-paA">
			            <input type="text" name="insertpassword" placeholder="비밀번호를 입력해주세요" required>
			        </div>
			      </div>
			    <!-- 비밀글 여부 설정 -->
			     <div class="secret">
			      <p>
				  <input class="w3-check" type="checkbox" checked="checked" style="width: 29.3px; height: 29.3px;">
				  <label class="secretTitle" style="font-size: 1.6rem;">비밀글 여부</label></p>
				  <p>
				 </div>
				<!-- 질문 저장하기 버튼 -->
			     <button type="submit" class="button" >저장하기</button>
			     <button  id="cancelButton" >취소하기</button>
		</form>
		</div>
		</div>
		</div>
		
	<!-- 질문삭제를 위한 라이트 박스 -->
	<div id="delete" class="w3-modal insertquestion-gWa ">
		<div class="divinsertquestion-QSa w3-modal-content w3-card-4 w3-animate-zoom" style="height: 40rem;">
			<header class="w3-container " style="margin-bottom : 1.5rem"> 
			 <span onclick="document.getElementById('delete').style.display='none'" 
			  class="w3-button  w3-xlarge w3-display-topright" >&times;</span>
			 <h2>질문 삭제</h2>
			</header>
			<!-- 비밀번호 체크 박스 -->
			<div id="checkPasswordBox">
			<div style="margin-left:0.5rem; margin-bottom:0.95rem;">비밀번호를 입력해주세요</div>
			<input class="checkDiv w3-border" type="password" id="deletePassword" placeholder="비밀번호를 입력해주세요">
			<span class="w3-button  w3-gray w3-border" id="checkDeletePassword" style="border-radius : 0.4rem;">확인</span>
			</div>
			<button id="deleteBtn" class="deleteBtn w3-button" style="display:none">삭제하기</button>
		</div>
	</div>
	
 <!--질문수정하기 라이트 박스 -->
	<div id="update"  class="w3-modal insertquestion-gWa " >
		<div class="divinsertquestion-QSa w3-modal-content w3-card-4 w3-animate-zoom" style="height: 76rem;">
		 <header class="w3-container" style="margin-bottom : 1.5rem"> 
			 <span onclick="document.getElementById('update').style.display='none'" 
			  class="w3-button w3-xlarge w3-display-topright" >&times;</span>
			  <h2>질문 수정</h2>
		</header>
		<!-- 비밀번호 체크 박스 -->
		<div id="checkPasswordBox">
		<div style="margin-left:0.5rem; margin-bottom:0.95rem;">비밀번호를 입력해주세요</div>
		<input class="checkDiv w3-border" type="password" id="updatePassword" placeholder="비밀번호를 입력해주세요">
		<span class="w3-button  w3-gray w3-border" id="checkUpdatePassword" style="border-radius : 0.4rem;">확인</span>
		</div>
			<!-- 정보수정박스 -->
		   <div class="divrow-Dup w3-container " id="updateDirow" style="display:none" >
			  <!-- 제목작성 -->
			     <div class="divqtitle-ytz">
			       <div class="label-qtitle-Khx">제목</div>
			       <div class="input-SXg">
			         <input type="text" id="questionTitle"  name="qtitle" required>
			        </div>
			      </div>
			   <!-- 질문 내용 작성 -->
			     <div class="divqcontent-xkv">
			       <div class="label-qcontent-HYJ" >내용</div>
			           <textarea name="qcontent" id="questionContent" rows="10" cols="10" style="width: 418px; height: 187px;" required></textarea>
			     </div>
			   <!-- 비밀번호 작성-->
			     <div class="divsecret-Yz2" >
			       <div class="label-secret-6Vk">
			         <span class="label-secret-6Vk-sub-0">비밀번호 </span>
			         <span class="label-secret-6Vk-sub-1">(필수사항)</span>
			       </div>
			       <!-- 비밀번호 입력 -->
			       <div class="input-paA">
			           <input type="text" name="qpassword" id="qpassword" required>
			       </div>
			     </div>
			    <!-- 비밀글 여부 설정 -->
			     <div class="secret">
			      <p>
				  <input  name="updateChecked" class="w3-check" type="checkbox" checked="checked" style="width: 29.3px; height: 29.3px;">
				  <label class="secretTitle" style="font-size: 1.6rem;">비밀글 여부</label></p>
				  <p>
				 </div>
				<!-- 질문 저장하기 버튼 -->
			     <button id="updateQuestionBtn" class="button" style="margin-top:1rem;">수정</button>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="id" value="${id }">
</body>
</html>