<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="icon" href="/favicon.ico" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="theme-color" content="#000000" />
<title>MyTrip</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Inter%3A400" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Noto+Sans%3A400" />
<link rel="stylesheet" href=".././styles/mytrip.css" />

<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$(function() {
			var today = new Date();
			var startDate = today.toLocaleDateString('en-GB');
			var endDate = today.toLocaleDateString('en-GB');

			$('input[name="daterange"]').daterangepicker({
				"startDate" : startDate,
				"endDate" : endDate,
				opens : 'center',
				locale : {
					format : 'DD/MM/YYYY'
				}
			});
		});
	});
</script>
</head>
<body>
<a href="listSchedule.do?id=<%="cocomo3" %>&tno=<%=3 %>">나의여행</a>
	<div class="mytrip-5jk">
		<div class="title-D5G">나의 여행</div>
		<div class="main-V2n">
			<div class="travellist-F1x">
				<c:forEach var="t" items="${list }">
					<div class="icon-ZoL"></div>
					<div class="tname-GSr">${t.tname }</div>
					</c:forEach>
			</div>
			<div class="line-81-Mz6"></div>
			<div class="addscheduleouter-KAE">
				<div class="auto-group-7sra-arr">
					<div class="addschedule-KZY">일정 추가</div>
					<div class="auto-group-4zft-FrW">
						<div class="btnaddicon-vhk">
							<img class="plus--66S" src=".././assets/plus-.png" />
						</div>
						<div class="choiceicon-d6N">아이콘 선택</div>
					</div>
				</div>
				<div class="auto-group-mka2-KUz">
					<div class="tnameouter-D4a">
						<div class="tname-LQ6">새 여행 이름</div>
						<div class="auto-group-q4rc-RAe">새 여행 이름을 작성해주세요.</div>
					</div>
					<div class="sdateouter-VgJ">
						<div class="sdate-T7L">여행 기간</div>
						<div class="auto-group-hzdg-x46">
							<img class="icon-main-quickcalendarsvg-uk2"
								src=".././assets/icon-main-quickcalendarsvg.png" />
						</div>
					</div>
				</div>
				<div class="budgetouter-1HG">
					<div class="budget-uNe">예산</div>
					<div class="auto-group-pg5c-NGE">금액을 입력하세요.</div>
				</div>
				<div class="btnaddschedule-fWE">새 일정 생성</div>
			</div>
		</div>
	</div>
</body>
</html>