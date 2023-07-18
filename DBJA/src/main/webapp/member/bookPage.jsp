<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/favicon.ico" />
<meta name="theme-color" content="#000000" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="./lightbox/css/jquery.lightbox.css">
 <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR%3A400%2C700"/>
 <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C700"/>
 <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400"/>
 <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans%3A500%2C700"/>
 <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
 <link rel="stylesheet" href=".././styles/bookpage2.css"/>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="./lightbox/js/jquery.lightbox.js"></script>
 <script type="text/javascript">
 	//카테고리 차트
	google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
          var id = $("#id").val();
          var tno =$("#tno").val();
          var catdata = [['카테고리', '금액']];  // 2차원 배열 생성

          $.ajax({
              url: 'category.jsp',
              data: {id: id, tno: tno},
              success: function(response) {
                var data = JSON.parse(response);

                // JSON 데이터를 2차원 배열로 변환
                for (var i = 0; i < data.length; i++) {
                  var category = data[i].category;
                  var amount = data[i].real;
                  catdata.push([category, amount]);
                }

                var categoryData = google.visualization.arrayToDataTable(catdata);
                var options = {
                  title: '카테고리별 금액'
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));
                chart.draw(categoryData, options);
              }
            });
        }	
      
 	//사이드바 여행일에 여행날짜 리스트 
 	function myAccFunc() {
	 $("#dayList").empty();
	 $.ajax({
			url:"listDay.jsp",
			data:{id : $("#id").val() ,tno : $("#tno").val()},                              
			success:function(data){
				for(i=0;i<data.length;i++){
					var row=data[i];
				    var a = $("<a></a>").html(row).addClass("w3-bar-item w3-button").attr("href", "listExpense.do?id=" + $("#id").val() + "&tno=" + $("#tno").val() + "&adate=" + row);
					$("#dayList").append(a);
				}
			}
		})
	  var x = document.getElementById("dayList");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else { 
	    x.className = x.className.replace(" w3-show", ""); 
	    
	  }
	}
 
 	//지출추가하기
 	$(document).ready(function(){
 		$(".insertExpenseBtn").click(function(){
 			event.preventDefault(); // 폼 전송 방지
 			console.log("지출추가하기")
 			var expense=$("#insert").serializeArray();
 			expense.push({ name: "id", value: $("#id").val() });
 			expense.push({ name: "tno", value: $("#tno").val() });

 			$.ajax({
 				url:"insertExpense.jsp",
 				data:expense,
 				success:function(data){
 					alert("지출 내역이 추가되었습니다");
 					document.getElementById('insertExpense').style.display='none';
 					location.reload();
 				}
 			});
 		});
 	});
 	var ano;
 	var sno;
 	//테이블 행 클릭시 수정하기 창 띄우기
 	$(document).on("click",".row",function(){
 		event.preventDefault(); // 폼 전송 방지	
 		//행의 정보 text칸에 출력
 		var td=$(this).find("td");
 		ano=$(this).attr("value");
 		sno=$(this).attr("sno");
 		console.log(sno);
 		$("#adate").val($(td[0]).html());
 		$("#expect").val($(td[1]).html());
 		$("#memo").val($(td[4]).html());
 		$("#real").val($(td[5]).html());
 		//창띄우기
 		document.getElementById('updateExpense').style.display='block';	
		});
 	
 	$(document).ready(function(){
 		$(".updateBtn").click(function(){
 	 		event.preventDefault(); // 폼 전송 방지
 	 		var update=$("#update").serializeArray();
 	 		update.push({name:"ano" , value:ano});
 	 		update.push({name:"sno" , value:sno});
 	 		update.push({ name: "id", value: $("#id").val() });
 			update.push({ name: "tno", value: $("#tno").val() });
 	 		$.ajax({
 	 			url:"updateExpense.jsp",
 	 			data:update,
 	 			success:function(data){
 	 				console.log(data);
 	 					alert("가계부가 수정되었습니다");
 	 					document.getElementById('updateExpense').style.display='none';
 	 					location.reload();
 	 			}
 	 		})
 	 	});
 	});
 	$(document).ready(function(){
 		$(".deleteBtn").click(function(){
 			event.preventDefault(); // 폼 전송 방지
 			$.ajax({
 				url:"deleteExpense.jsp",
 				data:{id:$("#id").val(),
 					  tno:$("#tno").val(),
 					  ano:ano},
 				success:function(data){
 					alert("지출 내역이 삭제되었습니다");
	 				document.getElementById('updateExpense').style.display='none';
	 				location.reload();
 				}
 			})
 		})
 	})
 	
 </script>
</head>
<body>
<!-- 지출 수정 -->
<div class="w3-modal updateExpense" id="updateExpense" >
	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="width:400px; height:800px;">
		<header class="w3-container "> 
		   <span onclick="document.getElementById('updateExpense').style.display='none'" 
		   class="w3-button  w3-xlarge w3-display-topright">&times;</span>
		   <h2>지출 내역 수정</h2>
		</header>
		<form id="update">
			<div class="divUpdateExpense">
		    <div class="tname"></div>
		    <div class="divrow-npN">
		    <!-- 날짜 -->
		      <div class="divAdate">
		        <div class="label-adate">날짜</div>
		        <div class="input_adate">
		        <input type="text" name="adate" id="adate">
		        </div>
		      </div>
		    <!-- 예상지출 -->
		      <div class="divExpect">
		        <div class="label-expect">예상지출</div>
		        <div class="input_expect">
		        <input type="text" name="expect" id="expect">
		        </div>
		      </div>
		     <!-- 카테고리 -->
		      <div class="divCategory">
		        <div class="label_category" name="categroy">카테고리</div>
		        <select class="select_category" name="categroy">
		        <option value="식비">식비</option>
		        <option value="교통비">교통비</option>
		        <option value="활동비">활동비</option>
		        <option value="쇼핑">쇼핑</option>
		        <option value="기타">기타</option>
		        </select>
		      </div>
		     <!-- 결제수단 -->
		      <div class="divPayment" >
		        <div class="label_payment">결제수단</div>
		        <select class="select_payment" name="payment">
		        <option value="카드">카드</option>
		        <option value="현금">현금</option>
		        </select>
		      </div>
		     <!-- 메모 -->
		      <div class="divMemo">
		        <div class="label_memo">메모</div>
		        <div class="input_memo">
		        <input type="text" name="memo" id="memo">
		        </div>
		      </div>
		     <!-- 실제지출 -->
		      <div class="divReal">
		        <div class="label_real">실제지출</div>
		        <div class="input_real">
		        <input type="text" name="real" id="real">
		        </div>
		      </div>
		    </div>
		    <button class="updateBtn" name="insert">수정하기</button>
		    <button class="deleteBtn" name="delte">삭제하기</button>
		  </div>
		</form>
	</div>
</div>



<!-- 지출추가 -->
<div id="insertExpense" class="w3-modal insertExpense" >
	<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="width:400px; height:730px;">
		<header class="w3-container "> 
		   <span onclick="document.getElementById('insertExpense').style.display='none'" 
		   class="w3-button  w3-xlarge w3-display-topright">&times;</span>
		   <h2>지출 내역 추가</h2>
		</header>
		<form id="insert">
			<div class="divInsertExpense">
		    <div class="divrow">
		      <!-- 날짜 -->
		      <div class="divTdate">
		        <div class="label_tdate">날짜 (형식 : 2023/04/12)</div>
		        <div name="selectTdate" class="selectTdate">
		        <input type="text" name="tdate" required>
		        </div>
		      </div>
		      <!-- 예상지출 -->
		      <div class="divContent">
		        <div class="label_content">예상지출</div>
		        <div class="input_content">
		        <input type="text" name="expect" >
		        </div>
		      </div>
		      <!-- 카테고리 -->
		      <div class="divCategory">
		        <div class="label_category">카테고리</div>
		        <select name="selectCategory" class="selectCategory">
		        <option value="식비">식비</option>
		        <option value="숙박비">숙박비</option>
		        <option value="교통비">교통비</option>
		        <option value="활동비">활동비</option>
		        <option value="쇼핑">쇼핑</option>
		        <option value="기타">기타</option>
		        </select>
		      </div>
		      <!-- 결제수단 -->
		      <div class="divPayment">
		        <div class="label_payment">결제수단</div>
		        <select name="selectPayment" class="selectPayment">
		        <option value="카드">카드</option>
		        <option value="현금">현금</option>
		        </select>
		      </div>
		      <!-- 메모 -->
		      <div class="divMemo">
		        <div class="label_memon">메모</div>
		        <div class="input-memo">
		        <input type="text" name="memo">
		        </div>
		      </div>
		      <!-- 실제지출금액 -->
		      <div class="divReal">
		        <div class="label_real">실제지출</div>
		        <div class="input-real">
		        <input type="text" name="real" >
		        </div>
		      </div>
		    </div>
		    <!-- 저장하기 버튼 -->
		    <button class="insertExpenseBtn">저장하기</button>
    	</div>
		</form>
	</div>
</div>


<div class="bookpage2">
  <div class="mainTitle">
    <div class="booktitle">가계부</div>
  </div>
  <div class="main-a8W">
    <div class="divbook-6ce">
      <div class="auto-group-txft-dMg">
      
      	<!-- 여행이름, 일정div -->
        <div class="div_schedule">
          <div class="travelTitle" >${tnameAndtdate.tname }</div>
          <div class="tdate" >${tnameAndtdate.tstart } ~ ${tnameAndtdate.tend }</div>
        </div>
      
        <!-- 가계부 내용 검색 div -->
        <form action="listExpense.do?id=${id }&tno=${tno}" method="post">
        <div class="findSearch">
        
          <!-- 검색 카테고리 선택div -->
          <select class="selectColum" name="selectColum">
          <option value="category">카테고리</option>
          <option value="real">실제지출</option>
          <option value="payment">결제수단</option>
          <option value="memo">메모</option>
          <option value="real">실제지출금액</option>
          </select>
          
          <!-- 검색창 -->
          <input class="keyword" name="keyword">
          <button type="submit" class="findBtn">검색</button>
        </div>
        </form>
        
      </div>
      
      <div class="auto-group-fdw6-Hj4">
      	
      	<!-- 여행날짜,지출추가 버튼 있는 사이드바 -->
        <div class=" w3-bar-block  w3-border w3-light-grey" style="width:160px">
        
	        <!-- 모든 지출내역 -->
	        <a href="listExpense.do?id=${id }&tno=${tno}" class="w3-bar-item w3-button">All</a>
	        
	        <!-- 여행 일정별 지출내역 -->
	 		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc()">
			여행일정<i class="fa fa-caret-down"></i>
			</button>
			  <div id="dayList" class="w3-hide w3-white w3-card">
			  </div>
			<!-- 지출추가 버튼-->
			<button id="addBtn" class="w3-button w3-block w3-left-align" onclick="document.getElementById('insertExpense').style.display='block'">지출추가</button>		
			
        </div>
        
        <!-- 가계부 테이블 div -->
        <div class="accountList ">
          
          <!-- 테이블 담는 div -->
          <div class="tableContainer">
          
          	  <!-- 가계부 테이블 -->	
			  <table class="w3-table w3-hoverable w3-bordered w3-centered">
			    <tr class="w3-light-grey">
			      <th>날짜</th>
			      <th>예상지출</th>
			      <th>카테고리</th>
			      <th>결제수단</th>
			      <th>메모</th>
			      <th>실제지출</th>
			    </tr>
			    <!-- 테이블 내용 추가 -->
			   <c:forEach var="b" items="${list }">
			   <tr class="row" value="${b.ano }" sno="${b.sno }">
			   	<td>${b.adate }</td>
			   	<td>${b.expect }</td>
			   	<td>${b.category }</td>
			   	<td>${b.payment }</td>
			   	<td>${b.memo }</td>
			   	<td>${b.real }</td>
			   </tr>
			   </c:forEach>
			  </table>
			</div>
          
          <!-- 전체 사용 금액 표시 -->
          <div class="sumExepnse">
           <label style="text-align: right; font-size: 18px; font-weight: bold;">전체 사용 금액 : </label> 
  		   <label style="font-size: 18px; font-weight: bold;">${totalExpense }원</label>
          </div>
          
        </div>
        
      </div>
    </div>
    
    <!-- 총사용금액, 예산 대비 남은금액 div -->
    <div class="budgetPannel">
    
     <!-- 총사용금액 div -->
      <div class="totalUse">
        <div class="totalUseTitle">예산</div>
        <label class="insertTotalUse">${buget }원</label>
      </div>
      
      <!-- 예산 대비 남은금액 div -->
      <div class="balanceExpense">
        <div class="balanceTitle">예산 대비 남은 금액</div>
        <label class="insertBalance">${remain }원</label>
      </div>
      
    </div>
    
    <!-- 가계부 관련 그래프 담고 있는 div -->
    <div class="graphPannel">
      <!-- 카테고리 그래프 div -->
      <div class="categoryGraph">
        <div class="categoryGraphTitle">Category Graph</div>
        <div id="piechart" class="category"></div>	
      </div>
      
      <!-- 중간에 나누는 선 -->
      <img class="line-58-pJz" src="REPLACE_IMAGE:2538:1909"/>
      
      <!-- 예산 그래프 div -->
      <div class="budgetGraph">
        <div class="budgetGraphTitle">Budget Graph</div>
         <div class="w3-light-grey w3-round-large" style="height: 6rem; width: 100%">
   		 <div class="w3-container w3-blue w3-round" style="width:${percent}%; height: 6rem; font-size: 3.3rem; text-align:center">${percent }%</div>
  			<label>전체 사용 금액 / 예산</label>
  		</div>
        
      </div>
    </div>
  </div>
</div>
<input type="hidden" id="id" value=${id }>
<input type="hidden" id="tno" value=${tno }>
</body>
</html>