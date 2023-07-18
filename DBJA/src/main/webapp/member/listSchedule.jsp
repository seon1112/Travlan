<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="theme-color" content="#000000" />
<title>listSchedule</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C600%2C700" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Inter%3A400%2C600%2C700" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR%3A700" />
<link rel="stylesheet" href=".././styles/listschedule.css" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	//여행 편집
	$(document).ready(function() {
		$(".edit_anchor").click(function() {
			event.preventDefault(); // 폼 전송 방지
			console.log("편집하기")
			$("#tname").val($("#ttname").val());
			$("#tstart").val($("#ttstart").val());
			$("#tend").val($("#ttend").val());
			$("#budget").val($("#tbudget").val());
		});

	});
	//편집을 눌러 라이트박스가 열리면 수정 
	$(document).ready(function() {
		$(".updateBtn").click(function() {
			event.preventDefault(); // 폼 전송 방지
			var travel = $("#update").serializeArray();
			console.log("ttno"+ $("#ttno").val());
			travel.push({name : "tno",value : $("#ttno").val()});
			$.ajax({
				url : "updateTravelList.jsp",
				data : travel,
				success : function(data) {
					if (data == 1) {
					alert("여행목록이 수정되었습니다");
					document.getElementById('updateTravelList').style.display = 'block'
					location.reload();
					}
				}
			})
		});
	});
	//친구추가하기
	$(document).ready(function(){
		$(".inviteBtn").click(function(){
			var id=$("#id").val();
			var tno=$("#ttno").val();
			$.ajax({
				url:"inviteFriend.jsp",
				data:{id:id,tno:tno},
				success:function(data){
					if(data==1){
						alert("친구가 초대되었습니다.");
						document.getElementById('inviteFriend').style.display = 'block'
						location.reload();
					}
				}
			});
		});
	});
	var sno;
	
	//테이블 행 클릭시 일정수정 창 띄우기
	$(document).on("click",".row",function(){
		event.preventDefault(); // 폼 전송 방지	
		//행의 정보 text칸에 출력
		var td=$(this).find("td");
 		sno=$(this).attr("sno");
 		$("#sdate").val($(td[0]).html());
 		$("#stime").val($(td[1]).html());
 		$("#saddr").val($(td[2]).html());
 		$("#sname").val($(td[3]).html());
 		$("#expect").val($(td[5]).html());
 		//창띄우기
 		document.getElementById('updateSchedule').style.display='block';	
	})
	$(document).ready(function(){
		$(".updateBtnSd").click(function(){
			event.preventDefault(); // 폼 전송 방지
			var update=$("#updateSd").serializeArray();
			update.push({name : "tno",value : $("#ttno").val()});
 	 		update.push({name:"sno" , value:sno});
 	 		$.ajax({
 	 			url:"updateSchedule.jsp",
 	 			data:update,
 	 			success:function(data){
 	 				if(data!=0){
 	 					alert("일정이 수정되었습니다");
 	 					document.getElementById('updateSchedule').style.display='none';
 	 					location.reload();
 	 				}
 	 				
 	 			}
 	 		});
		});
	});
	//일정삭제하기
	$(document).ready(function(){
		$(".deleteBtnSd").click(function(){
			event.preventDefault(); // 폼 전송 방지
			$.ajax({
 	 			url:"deleteSchedule.jsp",
 	 			data:{tno:$("#ttno").val(), sno:sno},
 	 			success:function(data){
 	 				if(data!=0){
 	 					alert("일정이 삭제되었습니다");
 	 					document.getElementById('updateSchedule').style.display='none';
 	 					location.reload();
 	 				}
 	 				
 	 			}
 	 		});
		})
	})
	
	//일정삽입하기
	$(document).ready(function(){
		$(".insertBtnSd").click(function(){
			event.preventDefault(); // 폼 전송 방지
			var s=$("#insertSd").serializeArray();
			s.push({name : "tno",value : $("#ttno").val()});
			$.ajax({
 	 			url:"insertSchedule.jsp",
 	 			data:s,
 	 			success:function(data){
 	 				if(data!=0){
 	 					alert("일정이 삽입되었습니다");
 	 					document.getElementById('insertSchedule').style.display='none';
 	 					location.reload();
 	 				}
 	 				
 	 			}
 	 		});
		})
	})
</script>
<body>

	
<!-- 일정삽입하기 -->
<div class="w3-modal insertSchedule" id="insertSchedule" >
	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="width:400px; height:730px;">
		<header class="w3-container "> 
		   <span onclick="document.getElementById('insertSchedule').style.display='none'" 
		   class="w3-button  w3-xlarge w3-display-topright">&times;</span>
		   <h2>일정 수정</h2>
		</header>
		<form id="insertSd">
			<div class="divinsertSchedule">
		    <div class="divrow_insert">
		    <!-- 날짜 -->
		      <div class="divSdate">
		        <div class="label-sdate">날짜</div>
		        <div class="input_sdate">
		        <input type="text" name="sdate" id="insertsdate">
		        </div>
		      </div>
		    <!-- 시간 -->
		      <div class="divStime">
		        <div class="label-stime">시간</div>
		        <div class="input_stime">
		        <input type="text" name="stime" id="insertstime">
		        </div>
		      </div>
		     <!-- 장소 -->
		      <div class="divSaddr">
		        <div class="label_saddr">장소</div>
		        <div class="input_saddr" >
		        <input type="text" name="saddr" id="insertsaddr">
		        </div>
		      </div>
		     <!-- 내용 -->
		      <div class="divSname" >
		        <div class="label_sname">내용</div>
		        <div class="input_sname" >
		     	<input type="text" name="sname" id="insertsname">
		        </div>
		      </div>
		     <!-- 카테고리 -->
		      <div class="divCategory">
		        <div class="label_category">카테고리</div>
		        <select class="select_category">
		        <option value="식비">식비</option>
		        <option value="교통비">교통비</option>
		        <option value="활동비">활동비</option>
		        <option value="쇼핑">쇼핑</option>
		        <option value="기타">기타</option>
		        </select>
		      </div>
		     <!-- 예상지출 -->
		      <div class="divExpect">
		        <div class="label_expect">예상 지출 금액</div>
		        <div class="input_expect">
		        <input type="text" name="expect" id="insertexpect">
		        </div>
		      </div>
		    </div>
		    <button class="insertBtnSd" name="insertSd">등록하기</button>
		  </div>
		</form>
	</div>
</div>
	



	


	<!--전체 div 시작-->
	<div class="div_schedule">
		<div class="title">일정</div>
		<!--main div 시작-->
		<div class="div_main">
			<!--div_main 윗 부분 시작-->
			<div class="div_main_top">
				<!--여행이름 등 수정 / 친구추가 감싸는 div 시작-->
				<div class="div_edit_addfriend">
					<!--수정 부분 감싸는 div 시작-->
					<div class="div_edit">
						<!--여행이름 수정 감싸는 div 시작-->
						<div class="editname">
							<div class="inputname">
								<input value=${travel.tname }>
							</div>
							<!--input으로 편집해야 함-->
							<div class="edit_anchor"
								onclick="document.getElementById('updateTravelList').style.display='block'">편집</div>
							<!--a로 편집해야 함-->
						</div>
						<!--여행이름 수정 감싸는 div 끝-->
						<div class="travel_date">${travel.tstart }-${travel.tend }</div>
						<div class="budget">예산 : ${travel.budget }원</div>
					</div>
					<!--수정 부분 감싸는 div 끝-->

					<!--친구추가 감싸는 div 시작-->
					<div class="div_addfriend">
						<div class="friendList">
							<c:forEach var="f" items="${friend }">
								<div>${f	 }</div>
							</c:forEach>
						</div>
						<button class="addfriend_btn"
							onclick="document.getElementById('inviteFriend').style.display='block'">친구초대</button>

					</div>
					<!--친구추가 감싸는 div 끝-->
				</div>
				<!--여행이름 등 수정 / 친구추가 감싸는 div 끝-->

				<!--일정 table 감싸는 div 시작-->
				<div class="table-eT8">
					<!--테이블 추가-->
					<table class="w3-table w3-hoverable w3-bordered w3-centered">
						<tr class="w3-light-grey">
							<th>날짜</th>
							<th>시간</th>
							<th>장소</th>
							<th>내용</th>
							<th>카테고리</th>
							<th>예상 지출 금액</th>
						</tr>
						<!-- 테이블 내용 추가 -->
						<c:forEach var="s" items="${schedule }">
							<tr class="row" sno="${s.sno }" tno="${s.tno }">
								<td>${s.sdate }</td>
								<td>${s.stime }</td>
								<td>${s.saddr}</td>
								<td>${s.sname }</td>
								<td>${s.category }</td>
								<td>${s.expect }</td>
							</tr>
						</c:forEach>
					</table>
				</div>

			</div>
			<!--일정 table 감싸는 div 끝-->
		</div>
		<!-- div_main 윗 부분 끝-->

		<!-- div_main 아래 부분(button 모음) 시작 -->
		<div class="div_btns">
			<button class="register_btn" onclick="document.getElementById('insertSchedule').style.display='block'" >등록</button>
			<!--   <button class="edit_btn">수정</button>-->
			<!-- <button class="delete_btn">삭제</button>-->
			<a href="listExpense.do?id=${id }&tno=${tno}" class="moveBook">가계부로
				이동하기</a>
		</div>
		<!-- div_main 아래 부분(button 모음) 끝 -->
	</div>
	<!--main div 끝-->
	</div>
	<!--전체 div 끝-->

	<input type="hidden" id="ttname" value=${travel.tname }>
	<input type="hidden" id="ttno" value=${travel.tno }>
	<input type="hidden" id="ttstart" value=${travel.tstart }>
	<input type="hidden" id="ttend" value=${travel.tend }>
	<input type="hidden" id="tbudget" value=${travel.budget }>
	
	
	<!-- 일정 수정 -->
<div class="w3-modal updateSchedule" id="updateSchedule" >
	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="width:400px; height:770px;">
		<header class="w3-container "> 
		   <span onclick="document.getElementById('updateSchedule').style.display='none'" 
		   class="w3-button  w3-xlarge w3-display-topright">&times;</span>
		   <h2>일정 수정</h2>
		</header>
		<form id="updateSd">
			<div class="divUpdateSchedule">
		    <div class="divrow-npN">
		    <!-- 날짜 -->
		      <div class="divSdate">
		        <div class="label-sdate">날짜</div>
		        <div class="input_sdate">
		        <input type="text" name="sdate" id="sdate">
		        </div>
		      </div>
		    <!-- 시간 -->
		      <div class="divStime">
		        <div class="label-stime">시간</div>
		        <div class="input_stime">
		        <input type="text" name="stime" id="stime">
		        </div>
		      </div>
		     <!-- 장소 -->
		      <div class="divSaddr">
		        <div class="label_saddr">장소</div>
		        <div class="input_saddr" >
		        <input type="text" name="saddr" id="saddr">
		        </div>
		      </div>
		     <!-- 내용 -->
		      <div class="divSname" >
		        <div class="label_sname">내용</div>
		        <div class="input_sname" >
		     	<input type="text" name="sname" id="sname">
		        </div>
		      </div>
		     <!-- 카테고리 -->
		      <div class="divCategory">
		        <div class="label_category">카테고리</div>
		        <select class="select_category">
		        <option value="식비">식비</option>
		        <option value="교통비">교통비</option>
		        <option value="활동비">활동비</option>
		        <option value="쇼핑">쇼핑</option>
		        <option value="기타">기타</option>
		        </select>
		      </div>
		     <!-- 예상지출 -->
		      <div class="divExpect">
		        <div class="label_expect">예상 지출 금액</div>
		        <div class="input_expect">
		        <input type="text" name="expect" id="expect">
		        </div>
		      </div>
		    </div>
		    <button class="updateBtnSd" name="insertSd">수정하기</button>
		    <button class="deleteBtnSd" name="deleteSd">삭제하기</button>
		  </div>
		</form>
	</div>
</div>

<!-- 친구초대하기 창 -->
	<div id="inviteFriend" class="w3-modal">
		<div class="w3-modal-content w3-card-4 w3-animate-zoom"
			style="width: 400px; height: 300px;">
			<header class="w3-container"> <span
				onclick="document.getElementById('inviteFriend').style.display='none'"
				class="w3-button w3-xlarge w3-display-topright">&times;</span>
			<h2>친구 초대하기</h2>
			</header>
			<div class="divInviteFriend">
				<div class="divrow-npN">
					<!-- 친구 아이디 입력-->
					<div class="inviteFriend">
						<div class="label_inviteFriend">친구 아이디</div>
						<div class="input_inviteFriend">
							<input type="text" name="id" id="id">
						</div>
					</div>
				</div>
				<button class="inviteBtn" name="invite">초대하기</button>
			</div>
		</div>
	</div>
	<!-- 여행 수정 -->
	<div class="w3-modal updateTravelList" id="updateTravelList">
		<div class="w3-modal-content w3-card-4 w3-animate-zoom"
			style="width: 400px; height: 600px;">
			<header class="w3-container "> <span
				onclick="document.getElementById('updateTravelList').style.display='none'"
				class="w3-button  w3-xlarge w3-display-topright">&times;</span>
			<h2>여행 수정</h2>
			</header>
			<form id="update">
				<div class="divUpdateTravel">
					<div class="divrow-npN">
						<!-- 여행 이름 -->
						<div class="divTname">
							<div class="label-tname">여행이름</div>
							<div class="input_tname">
								<input type="text" name="tname" id="tname">
							</div>
						</div>
						<!-- 시작일 -->
						<div class="divTstart">
							<div class="label-tstart">여행 시작일</div>
							<div class="input_tstart">
								<input type="text" name="tstart" id="tstart">
							</div>
						</div>
						<!-- 종료일 -->
						<div class="divTend">
							<div class="label_tend">여행 종료일</div>
							<div class="input_tend">
								<input type="text" name="tend" id="tend">
							</div>
						</div>
						<!-- 예산-->
						<div class="divBudget">
							<div class="label_budget">예산</div>
							<div class="input_budget">
								<input type="text" name="budget" id="budget">
							</div>
						</div>
					</div>
					<button class="updateBtn" name="insert">수정하기</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>