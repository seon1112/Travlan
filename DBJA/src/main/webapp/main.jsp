<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>main</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C500%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans%3A400%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR%3A400%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto%3A400%2C500"/>
  <link rel="stylesheet" href="./styles/main.css"/>
  <!-- 
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
	
			$('.input-daterange').datepicker({
			    format: 'dd-mm-yyyy',
			    autoclose: true
			});
			});
	</script> -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e5c21ed588d8552d6ec7e0d2cd7cfdef"></script>
</head>
<body>
<div class="main-B9p">
  <div class="content-7JN">
    <div class="divtitle">
      <div class="divjspc6e-ZAN">Travel</div>
		<form action="listInformation.do" method="GET">
		 <div class="divsbslld-b74">
		  <div class="diveu5u4b-7r6">
		    <a href="listInformation.do">
		      <img class="svg-FxJ" src="./assets/svg.png" onclick="location.href='listInformation.do'"/>
		    </a>
		    <div class="combobox-search-for-destinations-sights-and-more-AZU">
		      <input type="text" placeholder="검색어를 입력하세요." class="divplaceholder-xte">
		    </div>
		  </div>
		</div>
		</form>
    </div>
    <div class="tabpanel-7QA">
  <div class="ke-main-quick-booking-ow-rt-dtJ">
    <form action="listSchedule.do" method="POST"> <!-- form 태그 추가 -->
      <div class="auto-group-bdjc-mzW">
        <div class="presentationbooking-widgetitem-Hhx">간편 일정 추가</div>
        <div class="divquickbookingsseparate-vW2">
          <div class="item--egv">새 여행 이름</div>
          <div class="button-Xki">
            <input type="text" placeholder="새 여행 이름을 작성해주세요." class="spanquickbookingsselect-data-f6E">
          </div>
        </div>
        <div class="divquickbookingsseparate-hBL">
          <div class="item--SPp">여행 기간</div>
          <div class="button-A4v">
              <div class="flex-row d-flex justify-content-center">
                <div class="col-lg-6 col-11">
                  <div class="input-group input-daterange">
                  	<div class=input1>
                  	    <input type="text" value="YYYY/MM/DD" >
                  	</div>
                  	<div class=input2>
                  	    <input type="text" value="YYYY/MM/DD">
                  	</div>
                    
                  </div>
              </div>
            </div>
            <!-- 
              <div class="spanquickbookingsdate-hKk">
                <div class="item--eVt">가는 날</div>
                <div class="item--Mv6">~</div>
                <div class="item--GGN">오는 날</div>
              </div>
            -->
          </div>
        </div>
        <div class="divquickbookingsseparate-rnJ">
            <div class="item--Zgi">예산</div>
            <div class="button-5QA">
              <input type="text" class="spanquickbookingsselect-data-btJ" placeholder="금액을 입력하세요."/>
            </div>
          </div>
      </div>
      
      <div class="divquickbookingsaligner-7U2">
      아이콘 사진 등록
	        <input type="file" class="item--EoY">
		<!-- 사진 -->
	      <div class="divquickbookingsaligner123">
	        <img class="iconimg" id="img" src=""/>
	
	      </div>
      </div>
      
      <div class="btnOuter">
	       <div class="button-TQi">
	            <input type="submit" value="새 일정 생성" class="inputbtn"> <!-- submit 버튼으로 변경 -->
	       </div>
       </div>
    </form>
  </div>
</div>

    <div class="divhsd1lb-uzE">
      <div class="top5-fyQ">인기 여행지 TOP5</div>
      <div class="divcaskkc-yUJ">
        <div class="divnp08ab-Wz2">
          <div class="link-Rr6">
            <div class="divnmi75c-wrapper-MUr">
              <img class="destinationbg240fixsvg-gGE" src="./assets/destinationbg240fixsvg-mXt.png"/>
              <div class="divnmi75c-CVU">
              </div>
            </div>
            <div class="div-hBL">
              <div class="divvqkstc-qYS">${top1.iname }</div>
              <div class="copacabana-beach-sugarloaf-carnaval-vpn">${top1.icontent }</div>
            </div>
          </div>
          <div class="link-bg2">
            <div class="divnmi75c-wrapper-ike">
              <img class="destinationbg240fixsvg-euC" src="./assets/destinationbg240fixsvg.png"/>
              <div class="divnmi75c-Bu8">
              </div>
            </div>
            <div class="div-HxA">
              <div class="divvqkstc-qin">${top2.iname }</div>
              <div class="eiffel-tower-louvre-cafes-fashion-j3U">${top2.icontent }</div>
            </div>
          </div>
          <div class="link-1Ft">
            <div class="divnmi75c-wrapper-Xk2">
              <img class="destinationbg240fixsvg-Fg2" src="./assets/destinationbg240fixsvg-Z42.png"/>
              <div class="divnmi75c-BZg">
              </div>
            </div>
            <div class="div-tU6">
              <div class="divvqkstc-qeE">${top3.iname }</div>
              <div class="eiffel-tower-louvre-cafes-fashion-wSN">${top3.icontent }</div>
            </div>
          </div>
          <div class="link-cYW">
            <div class="divnmi75c-wrapper-wKt">
              <img class="destinationbg240fixsvg-U4v" src="./assets/destinationbg240fixsvg-UjG.png"/>
              <div class="divnmi75c-bfL">
              </div>
            </div>
            <div class="div-6rz">
              <div class="divvqkstc-rLN">${top4.iname }</div>
              <div class="eiffel-tower-louvre-cafes-fashion-wci">${top4.icontent }</div>
            </div>
          </div>
          <div class="link-dkS">
            <div class="divnmi75c-wrapper-kq4">
              <img class="destinationbg240fixsvg-68E" src="./assets/destinationbg240fixsvg-Qm4.png"/>
              <div class="divnmi75c-DyY">
              </div>
            </div>
            <div class="div-96W">
              <div class="divvqkstc-VRG">${top5.iname }</div>
              <div class="grand-palace-wat-phra-kaew-nightlife-Bot">${top5.icontent }</div>
            </div>
          </div>
        </div>
          <div class="link-Sjp" id="map">
           <input type="hidden" id="latitude" value="${top1.latitude }"> 
           <input type="hidden" id="longitude" value="${top1.longitude }"> 
          </div>
           <script>
            var container = document.getElementById('map');
            var options = {
               center: new kakao.maps.LatLng($("#latitude").val(), $("#longitude").val()),
               level: 3
            };
      
            var map = new kakao.maps.Map(container, options);
            var markerPosition  = new kakao.maps.LatLng($("#latitude").val(), $("#longitude").val()); 

            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });

            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);
         </script>
      </div>
    </div>
  </div>
</div>
</body>
</html>