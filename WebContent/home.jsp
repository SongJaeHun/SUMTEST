<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.BoardVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
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

<title>Team SC - 메일 통합 관리</title>

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
    
    
    
 <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
 
 <script type="text/javascript" src="//code.jquery.com/jquery-2.1.3.js"></script>  
 <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
 <link rel="stylesheet" type="text/css" href="/css/result-light.css">
 <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
 
<style type="text/css">
/* 	.paging-nav { */
/* 	    text-align: center; */
/* 	    padding-top: 2px; */
/* 	} */
/* 	.paging-nav a { */
/* 	    margin: auto 1px; */
/* 	    text-decoration: none; */
/* 	    display: inline-block; */
/* 	    padding: 1px 7px; */
/* 	    background: #91b9e6; */
/* 	    color: white; */
/* 	    border-radius: 3px; */
/* 	} */
/* 	.paging-nav .selected-page { */
/* 	    background: #187ed5; */
/* 	    font-weight: bold; */
/* 	} */


    .paging-nav {
    text-align: center;
    padding-top: 2px;
}
.paging-nav a {
    margin: auto 1px;
    text-decoration: none;
    display: inline-block;
    padding: 1px 7px;
    background: #91b9e6;
    color: white;
    border-radius: 3px;
}
.paging-nav .selected-page {
    background: #187ed5;
    font-weight: bold;
}
  
</style>
<script>

window.onload=function(){
	  alert("${home}");

}   
</script>
<script>
$(window).load(function(){
(function ($) {
    $(function () {
        $.widget("zpd.paging", {
            options: {
                limit: 20,
                limitPaging: 10,
                rowDisplayStyle: 'block',
                activePage: 0,
                rows: []
            },
            _create: function () {
                var rows = $("tbody", this.element).children();
                this.options.rows = rows;
                this.options.rowDisplayStyle = rows.css('display');
                var nav = this._getNavBar();
                this.element.after(nav);
                this.showPage(0);
            },
            _getNavBar: function () {
                var rows = this.options.rows;
                var nav = $('<div>', {
                    class: 'paging-nav'
                });
                var displayVal;
                for (var i = 0; i < Math.ceil(rows.length / this.options.limit); i++) {
                    displayVal = 'display:inline-block';
                    if (i > this.options.limitPaging) displayVal = 'display:none';

                    this._on($('<a>', {
                        href: '#',
                        text: (i + 1),
                            "data-page": (i),
                        style: displayVal
                    }).appendTo(nav), {
                        click: "pageClickHandler"
                    });

                }
                //create previous link
                this._on($('<a>', {
                    href: '#',
                    text: '<<',
                        "data-direction": -1
                }).prependTo(nav), {
                    click: "pageStepHandler"
                });
                //create next link
                this._on($('<a>', {
                    href: '#',
                    text: '>>',
                        "data-direction": +1
                }).appendTo(nav), {
                    click: "pageStepHandler"
                });
                return nav;
            },
            showPage: function (pageNum) {
                var num = pageNum * 1; //it has to be numeric
                this.options.activePage = num;
                var rows = this.options.rows;
                var limit = this.options.limit;
                for (var i = 0; i < rows.length; i++) {
                    if (i >= limit * num && i < limit * (num + 1)) {
                        $(rows[i]).css('display', this.options.rowDisplayStyle);
                    } else {
                        $(rows[i]).css('display', 'none');
                    }
                }
            },
            pageClickHandler: function (event) {
                event.preventDefault();
                $(event.target).siblings().attr('class', "");
                $(event.target).attr('class', "selected-page");
                var pageNum = $(event.target).attr('data-page');
                var itemsOnEachSide = this.options.limitPaging / 2;
                var startPage = Math.floor(parseInt(pageNum) - itemsOnEachSide + 1); // Plus 1 because the array of links starts in "1" index and not "0". "0" index is the next (">>") button 
                var endPage = Math.ceil(parseInt(pageNum) + itemsOnEachSide + 1);
                var pagingLinks = $(event.target).parent().children();
                for (var i = 1; i < pagingLinks.length - 1; i++) {
                    if (i >= startPage && i <= endPage) $(pagingLinks[i]).css('display', 'inline-block');
                    else $(pagingLinks[i]).css('display', 'none');
                }

                this.showPage(pageNum);
            },
            pageStepHandler: function (event) {
                event.preventDefault();
                //get the direction and ensure it's numeric
                var dir = $(event.target).attr('data-direction') * 1;
                var pageNum = this.options.activePage + dir;
                //if we're in limit, trigger the requested pages link
                if (pageNum >= 0 && pageNum < this.options.rows.length) {
                    $("a[data-page=" + pageNum + "]", $(event.target).parent()).click();
                }
            }
        });
    });

    $('#table-demo').paging({
        limit: 20,
        limitPaging: 10
    });
})(jQuery);
});


</script>
</head>

<script>
function logout(){
	 var con = confirm("접속을 종료하시겠습니까");
	 if(con == true){
		session.invalidate(); 
	  	location.href="index.jsp";
	  	}else{}
	}
</script>
<body>




<% int count=0; %>
	<c:forEach items="${loginInfo}" var="loginInfo" >
		<%-- ${loginInfo.acc_addr}
		${loginInfo.acc_site_name} --%>
		<%count++; %>
	</c:forEach>

	<c:set var="name" value="${user_id}" scope="application"></c:set>
	

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
		class="lite"> SC</span></a> 
		
		<!--logo end--> 
		
		
		<!--  search form start -->
			<div class="nav search-row" id="top_menu">
				<ul class="nav top-menu">
					<li>
						<form class="navbar-form" action="DispatcherServlet" method="post">
							<input class="form-control" placeholder="Search" type="text" name="searchText">
							<input type="hidden" name="command" value="search">
							
							<select id="search" name="search" class="form-control">
								<option value="">검색값 선택</option>
								<option value="mailsearch">일반메일검색</option>
								<option value="attachsearch">첨부파일검색</option>
								<option value="mailidsearch">메일주소검색</option>
								<option value="daysearch">수신기간검색</option>
							</select>
							<input type="submit" value="검색" class="form-control">
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
			
			<a data-toggle="dropdown" class="dropdown-toggle" href="#">
			
				<span class="icon-task-l"></i> <span class="badge bg-important">${fn:length(loginInfo)}</span></a>
			
				<ul class="dropdown-menu extended tasks-bar">
					<div class="notify-arrow notify-arrow-blue"></div>
					<li>
						<p class="blue"><%= count %></p>
						
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
										<c:if test="${list.acc_site_name eq 'NATE'}">
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
				data-toggle="dropdown" class="dropdown-toggle"  href="#"> <i
					class="icon-envelope-l"></i> <span class="badge bg-important">${fn:length(recent)}</span>
			</a>
				<ul class="dropdown-menu extended inbox">
					<div class="notify-arrow notify-arrow-blue"></div>
					<li>
						<p class="blue">최근 메일 다섯개</p>
					</li>
					
					<c:forEach items="${recent}" var="recent">
						<li>
							<a href="DispatcherServlet?command=detailView&mail_no=${recent.mail_no}"> 
								
								<div class="photo" style="text-overflow:ellipsis;overflow:hidden;vertical-align:middle;"><nobr style="padding-left:8px">${recent.title}</nobr>
								<c:if test="${recent.acc_site_name eq 'NAVER'}"><img alt="avatar" src="./img2/naver.jpg"></c:if>
								<c:if test="${recent.acc_site_name eq 'GMAIL'}"><img alt="avatar" src="./img2/google.jpg"></c:if>
								<c:if test="${recent.acc_site_name eq 'NATE'}"><img alt="avatar" src="./img2/nate.jpg"></c:if>
								</div>
								
								<div class="from" style="text-overflow:ellipsis;overflow:hidden;text-align:right"><nobr>${recent.recv_addr }</nobr></div> 
								<div class="time" style="text-overflow:ellipsis;overflow:hidden;text-align:right"><nobr>${recent.recv_date}</nobr></div>
								
								<%-- <div class="message" style="text-overflow:ellipsis;overflow:hidden;"><nobr>${recent.title}</nobr></div> --%>
							</a>
						</li>
					</c:forEach>
					
					
					
				</ul></li>
			<!-- inbox notificatoin end -->
			
			
			<!-- alert notification start-->
			<li id="alert_notificatoin_bar" class="dropdown"><a href="setting.jsp">
					<i class="icon-bell-l"></i> <span class="badge bg-important"><%=count %></span>
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
					<li><a href="index.jsp" onClick="return logout();"><i class="icon_key_alt"></i> Log Out</a></li>
				</ul></li>
			<!-- user login dropdown end -->
			
		</ul>
		<!-- notificatoin dropdown end-->
	</div>
	</header> <!--header end--> 
	
	
	<!--sidebar start--> 
	<aside>
	<div id="sidebar" class="nav-collapse ">
		<!-- sidebar menu start-->
		
		<ul class="sidebar-menu">
			<li class="active">
				<a class="" href="DispatcherServlet?command=home"> 
					<i class="icon_house_alt"></i> 
					<span>Home</span>
				</a>
			</li>
			
			<li class="sub-menu"><a href="javascript:;" class="">
					<i class="icon_document_alt"></i> <span>Gmail</span> 
					<span class="menu-arrow arrow_carrot-right"></span>
			</a>
			
				<ul class="sub">
					<c:forEach items="${loginInfo}" var="list">
						<c:if test="${list.acc_site_name eq 'GMAIL'}">
							<li><a class="" href="DispatcherServlet?command=gmail&acc_id=${list.acc_id}">${list.acc_addr }</a></li>
						</c:if>
					</c:forEach>
				</ul></li>
				
	
			<li class="sub-menu"><a href="javascript:;" class="">
					<i class="icon_document_alt"></i> <span>Naver</span> <span
					class="menu-arrow arrow_carrot-right"></span>
			</a> 
				<ul class="sub">
					<c:forEach items="${loginInfo}" var="list">
						<c:if test="${list.acc_site_name eq 'NAVER'}">
							<li><a class="" href="DispatcherServlet?command=naver&acc_id=${list.acc_id }">${list.acc_addr }</a></li>
						</c:if>
					</c:forEach>
				</ul></li>
	
	
	
			<li class="sub-menu">
				<a href="javascript:;" class="">
					<i class="icon_document_alt"></i> 
					<span>HotMail</span>
					<span class="menu-arrow arrow_carrot-right"></span>
				</a> 
				
				<ul class="sub">
					<c:forEach items="${loginInfo}" var="list">
						<c:if test="${list.acc_site_name eq 'HOTMAIL'}">
							<li><a class="" href="DispatcherServlet?command=hotmail&acc_id=${list.acc_id }">${list.acc_addr }</a></li>
						</c:if>
					</c:forEach>
				</ul>
			</li>
	
	
		
			<li class="sub-menu">
				<a class="" href="javascript:;"> <i class="icon_piechart"></i>
					<span>설정</span>
					<span class="menu-arrow arrow_carrot-right"></span>
					</a>		
					<ul class="sub">
						<li><a class="" href="accountAdd.jsp">계정 추가 </a></li>
						<li><a class="" href="accountDel.jsp">계정 삭제 </a></li>
						<li><a class="" href="member_mod.jsp">회원 정보 수정</a></li>
					</ul>
			</li>
		</ul>
		
	</div>
	</aside> <!--sidebar end--> 
	
	<!--main content start--> 
	<section id="main-content"> <section class="wrapper"> <!--overview start-->
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">
				<i class="fa fa-laptop"></i> Team SC
			</h3>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="DispatcherServlet?command=home">Home</a></li>
			</ol>
		</div>
	</div>

	</section> <!-- 테이블 -->
	<table style="align:center; width:1500px; TABLE-layout:fixed" border="2" align="center" id ="table-demo" class="table table-striped">
		<thead style="border:1px solid black;">
			<tr>
				<td align="center" style=" width:100px; height:40px">메일번호</td>
				<td align="center" style="width:900px;">제목</td>
				<td align="center"style="width:300px;">보낸 사람</td>
				<td align="center" style="width:200px;">받은 시간</td>
			</tr>
		</thead>
		<tbody >
			<c:forEach items="${home}" var="home">
				<tr>
					<td align="center">${home.mail_no}</td>
					<td style="text-overflow:ellipsis; overflow:hidden; padding-left:22px"><nobr>
						<a href="DispatcherServlet?command=detailView&mail_no=${home.mail_no}">${home.title}</a></nobr></td>
					<td align="center" style="width:400px;text-overflow:ellipsis; overflow:hidden;"><nobr>${home.recv_addr}</nobr></td>
					<td align="center">${home.recv_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table> 

	<input type="button" border="0" value="홈으로"
		onclick="location.href='\index.jsp'"> </section> <!--main content end-->
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
