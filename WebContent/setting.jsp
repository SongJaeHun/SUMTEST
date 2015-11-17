<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.BoardVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Creative - Bootstrap 3 Responsive Admin Template">
<meta name="author" content="GeeksLabs">
<meta name="keyword"
	content="Creative, Dashboard, Admin, Template, Theme, Bootstrap, Responsive, Retina, Minimal">
<link rel="shortcut icon" href="img2/favicon.png">

<title>Creative - Bootstrap Admin Template</title>

<!-- Bootstrap CSS -->
<link href="css2/bootstrap.min.css" rel="stylesheet">
<!-- bootstrap theme -->
<link href="css2/bootstrap-theme.css" rel="stylesheet">
<!--external css-->
<!-- font icon -->
<link href="css2/elegant-icons-style.css" rel="stylesheet" />
<link href="css2/font-awesome.min.css" rel="stylesheet" />
<!-- full calendar css-->
<link
	href="assets2/fullcalendar/fullcalendar/bootstrap-fullcalendar.css"
	rel="stylesheet" />
<link href="assets2/fullcalendar/fullcalendar/fullcalendar.css"
	rel="stylesheet" />
<!-- easy pie chart-->
<link href="assets2/jquery-easy-pie-chart/jquery.easy-pie-chart.css"
	rel="stylesheet" type="text/css" meGdia="screen" />
<!-- owl carousel -->
<link rel="stylesheet" href="css2/owl.carousel.css" type="text/css">
<link href="css2/jquery-jvectormap-1.2.2.css" rel="stylesheet">
<!-- Custom styles -->
<link rel="stylesheet" href="css2/fullcalendar.css">
<link href="css2/widgets.css" rel="stylesheet">
<link href="css2/style.css" rel="stylesheet">
<link href="css2/style-responsive.css" rel="stylesheet" />
<link href="css2/xcharts.min.css" rel=" stylesheet">
<link href="css2/jquery-ui-1.10.4.min.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 -->
<!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
      <script src="js/lte-ie7.js"></script>
    <![endif]-->

</head>
<script>
/* window.onload=function(){
	  alert("${loginInfo}");
} */

function checkChange(){
	var doc = document.settingForm;
	doc.mail_site.value = doc.mail_id.value + "@" + doc.siteAdd.value;
}


function insRow() {
	  oTbl = document.getElementById("addTable");
	  var oRow = oTbl.insertRow();
	  oRow.onmouseover=function(){oTbl.clickedRowIndex=this.rowIndex}; //clickedRowIndex - 클릭한 Row의 위치를 확인;
	  var oCell = oRow.insertCell();
	  var id_count =1;
	  var site_count=1;
	  //삽입될 Form Tag
	  var frmTag = "<input type=text name=mail_id style=width:150px; height:20px; padding-top:10px>";
	  frmTag += " @ <select name=siteAdd onchange='checkChange()'><option value= >메일선택</option><option value=naver.com>naver.com</option><option value=gmail.com>gmail.com</option><option value=nate.com>nate.com</option></select>";
	  frmTag += "&nbsp;&nbsp;&nbsp;<input type=password name=mail_pwd>"
	  frmTag += "&nbsp;&nbsp;&nbsp;<input type=button value='-' onClick='removeRow()' style='cursor:hand'>"
	  frmTag += "&nbsp;&nbsp;&nbsp;<input type=button value='중복 검사 ' onClick='mailCheck()'>";
	  oCell.innerHTML = frmTag;
	  
	}
	
	function mailCheck(){
		var id = document.settingForm.mail_id.value;
		var site =  document.settingForm.siteAdd.value;
		var temp = id+"@"+site;
		location.href="DispatcherServlet?command=accCheck&mail_id=" + temp;
	}


	//Row 삭제
	function removeRow() {
		oTbl.deleteRow(oTbl.clickedRowIndex);
	}

	//텍스트 박스 비엇는지 확인하는거
	function frmCheck() {
		var frm = document.settingForm;

		for (var i = 0; i <= frm.elements.length - 1; i++) {
			if (frm.elements[i].name == "mail_id") {
				if (!frm.elements[i].value) {
					alert("텍스트박스에 값을 입력하세요!");
					frm.elements[i].focus();
					return;
				}
			}
		}
	}
</script>
<body>
	<% int count=0; %>
	<c:forEach items="${loginInfo}" var="loginInfo" >
		<%count++; %>
	</c:forEach>

	<!-- container section start -->
	<section id="container" class=""> <header
		class="header dark-bg">
	<div class="toggle-nav">
		<div class="icon-reorder tooltips"
			data-original-title="Toggle Navigation" data-placement="bottom">
			<i class="icon_menu"></i>
		</div>
	</div>

	<!--logo start--> <a href="DispatcherServlet?command=home" class="logo">Team<span
		class="lite"> SC</span></a> <!--logo end--> <!--  search form start -->
	<div class="nav search-row" id="top_menu">
		<ul class="nav top-menu">
			<li>
				<form class="navbar-form">
					<input class="form-control" placeholder="Search" type="text">
				</form>
			</li>
		</ul>
	</div>
	<!--  search form end -->

	<div class="top-nav notification-row">
		<!-- notificatoin dropdown start-->
		<ul class="nav pull-right top-menu">

			<!-- task notificatoin start 자기가 등록한 메일로가기-->
			<li id="task_notificatoin_bar" class="dropdown">
			
			<a data-toggle="dropdown" class="dropdown-toggle" href="#"> <span
					class="icon-task-l"></i> <span class="badge bg-important">6</span></a>
				<ul class="dropdown-menu extended tasks-bar">
					<div class="notify-arrow notify-arrow-blue"></div>
					<li>
						<p class="blue"><%=count %></p>
					</li>
					<li class="external"><a href="DispatcherServlet?command=home">전체보기</a></li>


					<li class="active"><a href="DispatcherServlet?command=gmailAll">
							<div class="task-info">
								<div class="desc">Gmail - 
									<c:forEach items="${loginInfo}" var="list">
										<c:if test="${list.acc_site_name eq 'GMAIL'}">
											<p>${list.acc_addr}</p>
										</c:if>
									</c:forEach>
								</div>
							</div>
					</a></li>
					
					<li class="active"><a href="DispatcherServlet?command=naverAll">
							<div class="task-info">
								<div class="desc">Naver - 
									<c:forEach items="${loginInfo}" var="list">
										<c:if test="${list.acc_site_name eq 'NAVER'}">
											<p>${list.acc_addr}</p>
										</c:if>
									</c:forEach>
								</div>
							</div>
					</a></li>
					
					<li class="active"><a href="DispatcherServlet?command=hotmailAll">
							<div class="task-info">
								<div class="desc">Hotmail - 
									<c:forEach items="${loginInfo}" var="list">
										<c:if test="${list.acc_site_name eq 'HOTMAIL'}">
											<p>${list.acc_addr}</p>
										</c:if>
									</c:forEach>
								</div>
							</div>
					</a></li>

				</ul></li>
			<!-- task notificatoin end -->


			<!-- inbox notificatoin start-->
			<li id="mail_notificatoin_bar" class="dropdown"><a
				data-toggle="dropdown" class="dropdown-toggle" href="#"> <i
					class="icon-envelope-l"></i> <span class="badge bg-important">최근
						메일 5개</span>
			</a>
				<ul class="dropdown-menu extended inbox">
					<div class="notify-arrow notify-arrow-blue"></div>
					<li>
						<p class="blue">최근 메일 다섯개(적으면 적은데로)</p>
					</li>
					<li><a href="#"> <span class="photo">다음, 지메일, 네이버
								로고 만들어놓고 그 사진 넣어놓기<img alt="avatar" src="./img2/avatar-mini.jpg">
						</span> <span class="subject"> <span class="from">보낸사람 주소</span> <span
								class="time">몇분전에 왔는지</span>
						</span> <span class="message"> 요약본 or 첨부파일G </span>
					</a></li>
					<li><a href="#"> <span class="photo">다음, 지메일, 네이버
								로고 만들어놓고 그 사진 넣어놓기<img alt="avatar" src="./img2/avatar-mini.jpg">
						</span> <span class="subject"> <span class="from">보낸사람 주소</span> <span
								class="time">몇분전에 왔는지</span>
						</span> <span class="message"> 요약본 or 첨부파일 </span>
					</a></li>
					<li><a href="#"> <span class="photo">다음, 지메일, 네이버
								로고 만들어놓고 그 사진 넣어놓기<img alt="avatar" src="./img2/avatar-mini.jpg">
						</span> <span class="subject"> <span class="from">보낸사람 주소</span> <span
								class="time">몇분전에 왔는지</span>
						</span> <span class="message"> 요약본 or 첨부파일 </span>
					</a></li>
					<li><a href="#"> <span class="photo">다음, 지메일, 네이버
								로고 만들어놓고 그 사진 넣어놓기<img alt="avatar" src="./img2/avatar-mini.jpg">
						</span> <span class="subject"> <span class="from">보낸사람 주소</span> <span
								class="time">몇분전에 왔는지</span>
						</span> <span class="message"> 요약본 or 첨부파일 </span>
					</a></li>
					<li><a href="#"> <span class="photo">다음, 지메일, 네이버
								로고 만들어놓고 그 사진 넣어놓기<img alt="avatar" src="./img2/avatar-mini.jpg">
						</span> <span class="subject"> <span class="from">보낸사람 주소</span> <span
								class="time">몇분전에 왔는지</span>
						</span> <span class="message"> 요약본 or 첨부파일 </span>
					</a></li>
				</ul></li>
			<!-- inbox notificatoin end -->
			<!-- alert notification start-->
			<li id="alert_notificatoin_bar" class="dropdown"><a href="setting.jsp"> 설정
					<i class="icon-bell-l"></i> <span class="badge bg-important"><%= count %></span>
			</a></li>
			<!-- alert notification end-->
			<!-- user login dropdown start-->
			<li class="dropdown"><a data-toggle="dropdown"
				class="dropdown-toggle" href="#"> <span class="profile-ava">
						<img alt="" src="img2/avatar1_small.jpg">
				</span> <span class="username"><c:out value="${name}"></c:out></span> <b class="caret"></b>
			</a>
				<ul class="dropdown-menu extended logout">
					<div class="log-arrow-up"></div>
					<li><a href="DispatcherServlet?command=home"><i class="icon_mail_alt"></i>모든메일</a></li>
					<li class="eborder-top"><a href="setting.jsp"><i class="icon_profile"></i>설정하러가기</a></li>
					<li><a href="DispatcherServlet?command=gmailAll"><i class="icon_chat_alt"></i>Gmail</a></li>
					<li><a href="DispatcherServlet?command=naverAll"><i class="icon_chat_alt"></i>Naver</a></li>
					<li><a href="DispatcherServlet?command=hotmailAll"><i class="icon_chat_alt"></i>Daum</a></li>
					<li><a href="index.html"><i class="icon_key_alt"></i> Log Out</a></li>
				</ul></li>
			<!-- user login dropdown end -->
		</ul>
		<!-- notificatoin dropdown end-->
	</div>
	</header> <!--header end--> 
	
	
	<!--sidebar start--> 
	<aside>
	<div id="sidebar" class="nav-collapse ">
		<ul class="sidebar-menu">
			<li class="active">
				<a class="" href="DispatcherServlet?command=home"> 
					<i class="icon_house_alt"></i> 
					<span>Home</span>
				</a>
			</li>

			<li class="sub-menu"><a href="javascript:;" class=""> <!-- <a href="gmail.html" class=""> -->
					<i class="icon_document_alt"></i> <span>Gmail</span> 
					<span class="menu-arrow arrow_carrot-right"></span>
			</a>
			
				<ul class="sub">
					<c:forEach items="${loginInfo}" var="list">
						<c:if test="${list.acc_site_name eq 'GMAIL'}">
						acc_id = ${list.acc_id }
							<li><a class="" href="DispatcherServlet?command=gmail&acc_id=${list.acc_id }">${list.acc_addr }</a></li>
						</c:if>
					</c:forEach>
				</ul></li>
				
			<li class="sub-menu"><a href="javascript:;" class=""> <!-- <a href="gmail.html" class=""> -->
					<i class="icon_document_alt"></i> <span>Naver</span> <span
					class="menu-arrow arrow_carrot-right"></span>
			</a> 
				<ul class="sub">
					<c:forEach items="${loginInfo}" var="list">
					acc_id = ${list.acc_id }
						<c:if test="${list.acc_site_name eq 'NAVER'}">
							<li><a class="" href="DispatcherServlet?command=naver&acc_id=${list.acc_id }">${list.acc_addr }</a></li>
						</c:if>
					</c:forEach>
				</ul></li>
	
	
	
			<li class="sub-menu">
				<a href="javascript:;" class="">
					<i class="icon_document_alt"></i> <span>HotMail</span>
					<span class="menu-arrow arrow_carrot-right"></span>
				</a> 
				
				<ul class="sub">
					<c:forEach items="${loginInfo}" var="list">
						<c:if test="${list.acc_site_name eq 'HOTMAIL'}">
						acc_id = ${list.acc_id }
							<li><a class="" href="DispatcherServlet?command=hotmail&acc_id=${list.acc_id }">${list.acc_addr }</a></li>
						</c:if>
					</c:forEach>
				</ul></li>
	
			<li><a class="" href="setting.jsp"> <i class="icon_piechart"></i>
					<span>설정</span>
	
			</a></li>
		</ul>
		<!-- sidebar menu end-->
	</div>
	</aside> <!--sidebar end--> <!--main content start--> <section
		id="main-content"> <section class="wrapper"> <!--overview start-->
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">
				<i class="fa fa-laptop"></i> Dashboard
			</h3>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="home.html">Home</a></li>
				<li><i class="fa fa-laptop"></i>Dashboard</li>
			</ol>
		</div>
	</div>

	</section> <!-- 테이블 -->
	
	<div style="padding-left:17px">
		<form name="settingForm" method="post" action="DispatcherServlet">
		<input type="hidden" name="command" value="regist">
			<table width="600" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan="2" align="left" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="25">
									<table id="addTable" width="400" cellspacing="0" cellpadding="3"
										bgcolor="#FFFFFF" border="0">
										<tr>
										
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="5" bgcolor="#FFFFFF" height="25" align="center">
									<input name="addButton" type="button" style="cursor: hand"
									onClick="insRow()" value="+">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<input type="submit" value="등록하기">
			
		</form>
	</div>
	
	
	</section> 
	<!--main content end-->
	
	
	</section>
	<!-- container section start -->

	<!-- javascripts -->
	<script src="js2/jquery.js"></script>
	<script src="js2/jquery-ui-1.10.4.min.js"></script>
	<script src="js2/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="js2/jquery-ui-1.9.2.custom.min.js"></script>
	<!-- bootstrap -->
	<script src="js2/bootstrap.min.js"></script>
	<!-- nice scroll -->
	<script src="js2/jquery.scrollTo.min.js"></script>
	<script src="js2/jquery.nicescroll.js" type="text/javascript"></script>
	<!-- charts scripts -->
	<script src="assets2/jquery-knob/js/jquery.knob.js"></script>
	<script src="js2/jquery.sparkline.js" type="text/javascript"></script>
	<script src="assets2/jquery-easy-pie-chart/jquery.easy-pie-chart.js"></script>
	<script src="js2/owl.carousel.js"></script>
	<!-- jQuery full calendar -->
	<
	<script src="js2/fullcalendar.min.js"></script>
	<!-- Full Google Calendar - Calendar -->
	<script src="assets2/fullcalendar/fullcalendar/fullcalendar.js"></script>
	<!--script for this page only-->
	<script src="js2/calendar-custom.js"></script>
	<script src="js2/jquery.rateit.min.js"></script>
	<!-- custom select -->
	<script src="js2/jquery.customSelect.min.js"></script>
	<script src="assets2/chart-master/Chart.js"></script>

	<!--custome script for all page-->
	<script src="js2/scripts.js"></script>
	<!-- custom script for this page-->
	<script src="js2/sparkline-chart.js"></script>
	<script src="js2/easy-pie-chart.js"></script>
	<script src="js2/jquery-jvectormap-1.2.2.min.js"></script>
	<script src="js2/jquery-jvectormap-world-mill-en.js"></script>
	<script src="js2/xcharts.min.js"></script>
	<script src="js2/jquery.autosize.min.js"></script>
	<script src="js2/jquery.placeholder.min.js"></script>
	<script src="js2/gdp-data.js"></script>
	<script src="js2/morris.min.js"></script>
	<script src="js2/sparklines.js"></script>
	<script src="js2/charts.js"></script>
	<script src="js2/jquery.slimscroll.min.js"></script>
	<script>

      //knob
      $(function() {
        $(".knob").knob({
          'draw' : function () { 
            $(this.i).val(this.cv + '%')
          }
        })
      });

      //carousel
      $(document).ready(function() {
          $("#owl-slider").owlCarousel({
              navigation : true,
              slideSpeed : 300,
              paginationSpeed : 400,
              singleItem : true

          });
      });

      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });
	  
	  /* ---------- Map ---------- */
	$(function(){
	  $('#map').vectorMap({
	    map: 'world_mill_en',
	    series: {
	      regions: [{
	        values: gdpData,
	        scale: ['#000', '#000'],
	        normalizeFunction: 'polynomial'
	      }]
	    },
		backgroundColor: '#eef3f7',
	    onLabelShow: function(e, el, code){
	      el.html(el.html()+' (GDP - '+gdpData[code]+')');
	    }
	  });
	});



  </script>

</body>
</html>
