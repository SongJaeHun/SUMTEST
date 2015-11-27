<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.BoardVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ page import="org.json.simple.*" %>
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
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
 
 <script type="text/javascript" src="//code.jquery.com/jquery-2.1.3.js"></script>  
 <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
 <link rel="stylesheet" type="text/css" href="/css/result-light.css">
 <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
 <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
 
 
 <!-- 페이징   페이징    페이징    페이징    페이징    페이징    페이징    페이징    페이징     -->
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
<!-- 페이징 끝   페이징 끝   페이징 끝   페이징 끝   페이징 끝   페이징 끝   페이징 끝    -->

</head>

<!-- 로그아웃 스크립트 -->
<script>
function logout(){
	 var con = confirm("접속을 종료하시겠습니까");
	 if(con == true){
		session.invalidate(); 
	  	location.href="index.jsp";
	  	return false;
	  	}else{
	  		return false;
	  	}
	}
</script>
<!-- 로그아웃 스크립트 끝 -->

<!-- 서치 스크립트 시작      서치 스크립트 시작      서치 스크립트 시작      서치 스크립트 시작      서치 스크립트 시작      서치 스크립트 시작       -->
<style>
.result table, .result table td, .result ul, .result li { margin:0; padding:0 }  
.result table {border-collapse: collapse; margin-bottom:20px; }
.result table td { padding:10px }
.result table td.highlight { padding:5px; word-break:break-all; }
.result table td.highlight li { margin:10px; margin-left:20px;}
</style>

<script>
var FETCH_LIST_SIZE = 10;
var fetchIndex = 0;

function insertHit( fields ) {

	var html = 
		"<table style='width:1500px; TABLE-layout:fixed' border='1' align='center' id='table-demo' class='table table-striped'>"  +
			"<tr>" +
				"<td width='100px' height='40px' align='center'>" + fields._id + "</td>" +
				"<td width='200px' align='center'>" + fields.fields.account_addr + "</td>" +
				"<td width='400px' padding-left='100px'><a href='DispatcherServlet?command=detailView&mail_no=" + fields.fields.mail_id + " ' target='_blank'>" + (fields.fields.title == null ? fields.fields.mail_title : fields.fields.title) + "</a></td>" +
				"<td width='200px' align='center'>" + fields.fields.rec_addr + "</td>" +
				"<td width='200px' align='center'>"+ fields.fields.date_detail+"</td>" +
			"</tr>" +
				
			"<tr>" +
				"<td colspan='5'; class='highlight'; word-break:break-all >" +
				"<ul>" +
				
				( fields.highlight.title == null ? "" : "<li><span>제목 :</span><span>" + fields.highlight.title + "</span></li>") + 
				( fields.highlight.file == null ? "" : "<li><span>내용 :</span><span>" + fields.highlight.file + "</span></li>") + 
				( fields.highlight.attachment_title == null ? "" : "<li><span>첨부파일 제목 :</span><span>" + fields.highlight.attachment_title + "</span></li>") + 
				( fields.highlight.attachment_file == null ? "" : "<li><span>첨부파일 내용 :</span><span>" + fields.highlight.attachment_file + "</span></li>") + 
			
				"</ul>" +
				"</td>" +
			"</tr>" /* +
				
				( fields.fields.attachment_file == null ? "" : "<tr><td colspan='5' style='padding-left:50px'>첨부파일 미리보기&nbsp;&nbsp;:&nbsp;&nbsp; <button type='button' data-toggle='modal' data-target='#myModal' id='modaltestBtn'>"+fields.fields.attachment_title+"</button> </td></tr>")+ */
			
		"</table>"; /* + 
		
		( fields.fields.attachment_file == null ? $("div.modal-body").text("미리보기가 불가능한 첨부파일입니다.") : $("div.modal-body").text(fieds.fields.attachment_file)) */;
		
		
	
	$("#table-demo").append( html );
	
	$("#modaltestBtn").click(function(){
		$('#myModal').modal();
	});

}

function search1( isFirst ){
	 var id = $('#searchText').val();
	 var id2 = $('#searchCon').val();
	 var hidden_mb_id = $('#hidden_mb_id').val();
	 var hidden_acc_id = $('#searchID').val();

	 if(id==""){
		 if(id2=="nothing"){
			 alert("조건을 입력하세요");
			 return false;
		 }else{
		 	alert("검색값을 입력하세요");
		 	return false;
		 }
	 }else{
		 if(id2=="nothing"){
			 alert("조건을 입력하세요");
			 return false;
	 	}else{
	 	$("#table-demo").append( "" );
	 	}
	 }

	 
	 if( isFirst == true ) {
	 	$("#table-demo").html( "" );
	 	fetchIndex = 0;
	 }
	 
	 if(hidden_acc_id=="all"){
	 
		 if(id2=="allSearch"){
			 var data=  {
						"fields": ["mail_id","account_addr","rec_addr","title","mail_title","attachment_title","attachment_file","date_detail"],
						"query": {
						    "bool": {
						         "must": [{
						             "multi_match": {
						               "query": id,
						               "fields": [
											"title",
											"file",
											"attachment_title",
											"attachment_file"
						               ],
						              "type": "cross_fields",
						              "operator":"OR",
						              "minimum_should_match": "50%"
						             }
						           }]
						    }
						  },
						  "size": FETCH_LIST_SIZE,
						  "from" :fetchIndex,
						  "sort": [
						           {
						             "date": {
						               "order": "desc"
						             }
						           }
						         ],
						  "highlight": {
							  "fields": {
							      "*":  {"fragment_size" : 150, "number_of_fragments" : 3}
							  }
						  
						  }
		}
		
		$.ajax({
			url:"http://192.168.1.55:9200/" + hidden_mb_id + "/_search",
			type:"post",
			data:JSON.stringify(data),
			dataType:"json",	 
			success:function( response ){
	      	console.log(response);
	       
	       var count = response.hits.hits.length;
	       console.log( count );
	       
	       for( var i = 0; i < count; i++ ) {
	     	  var fields = response.hits.hits[ i ];
	     	  insertHit( fields )
	       }
	       
	       fetchIndex += count;
	       
	       if( count > 0 ){
	    	   $("#down-arrow").show();
	    	   $("div.paging-nav").hide();
	    	   $("#lr-arrow").hide();
	       } else {
	    	   $("#down-arrow").hide();
	    	   
	    	}
		}
	    });

		}
		 
		 else if(id2=="mailSearch"){
				 var data=  {
							"fields": ["mail_id","account_addr","rec_addr","title","date_detail"],
							"query": {
							    "bool": {
							         "must": [{
							             "multi_match": {
							               "query": id,
							               "fields": [
												"title",
												"file"
							               ],
							              "type": "cross_fields",
							              "operator":"OR",
							              "minimum_should_match": "50%"
							             }
							           }]
							    }
							  },
							  "size": FETCH_LIST_SIZE,
							  "from" :fetchIndex,
							  "sort": [
							           {
							             "date": {
							               "order": "desc"
							             }
							           }
							         ],
							  "highlight": {
								  "fields": {
								      "*":  {"fragment_size" : 150, "number_of_fragments" : 3}
								  }
							  
							  }
				 }
				 
			
			$.ajax({
				url:"http://192.168.1.55:9200/" + hidden_mb_id + "/mail_type/_search",
				type:"post",
				data:JSON.stringify(data),
				dataType:"json",	 
				success:function( response ){
		          console.log(response);
		          var count = response.hits.hits.length;
			       console.log( count );
			       
			       for( var i = 0; i < count; i++ ) {
			     	  var fields = response.hits.hits[ i ];
			     	  insertHit( fields )
			       }
			       
			       fetchIndex += count;       
			       
			       if( count > 0 ){
			    	   $("#down-arrow").show();
			    	   $("div.paging-nav").hide();
			    	   $("#lr-arrow").hide();
			       } else {
			    	   $("#down-arrow").hide();
			    	   
			    	}
				}
			    });
			 
		 }
		 
		 else if(id2=="attachSearch"){
				 var data=  {
							"fields": ["mail_id","account_addr","rec_addr","mail_title","attachment_title","attachment_file","date_detail"],
							"query": {
							    "bool": {
							         "must": [{
							             "multi_match": {
							               "query": id,
							               "fields": [
												"attachment_title",
												"attachment_file"
							               ],
							              "type": "cross_fields",
							              "operator":"OR",
							              "minimum_should_match": "50%"
							             }
							           }]
							    }
							  },
							  "size": FETCH_LIST_SIZE,
							  "from" :fetchIndex,
							  "sort": [
							           {
							             "date": {
							               "order": "desc"
							             }
							           }
							         ],
							  "highlight": {
								  "fields": {
								      "*":  {"fragment_size" : 150, "number_of_fragments" : 3}
								  }
							  
							  }
				 }
				 
			
			$.ajax({
				url:"http://192.168.1.55:9200/" + hidden_mb_id + "/attachment_type/_search",
				type:"post",
				data:JSON.stringify(data),
				dataType:"json",	 	
				success:function( response ){
		          console.log(response);
		          var count = response.hits.hits.length;
			       console.log( count );
			       
			       for( var i = 0; i < count; i++ ) {
			     	  var fields = response.hits.hits[ i ];
			     	  insertHit( fields )
			       }
			       
			       fetchIndex += count;
			       
			       if( count > 0 ){
			    	   $("#down-arrow").show();
			    	   $("div.paging-nav").hide();
			    	   $("#lr-arrow").hide();
			       } else {
			    	   $("#down-arrow").hide();
			    	   
			    	}
			       
				}
			    });
		 }
	 }
	 
	 // 아이디서치 조건이 all 이 아닐때
	 else{
		 if(id2=="allSearch"){
			 var data=  {
						"fields": ["mail_id","account_addr","rec_addr","title","mail_title","attachment_title","attachment_file","date_detail"],
						"query": {
						    "bool": {
						         "must": [{
						             "multi_match": {
						               "query": id,
						               "fields": [
											"title",
											"file",
											"attachment_title",
											"attachment_file"
						               ],
						              "type": "cross_fields",
						              "operator":"OR",
						              "minimum_should_match": "50%"
						             }
						           }]
						    }
						  },
						  "post_filter" : {
							  "term" : {
								  "account_id" : hidden_acc_id
							  }
						  }, 
						  "size": FETCH_LIST_SIZE,
						  "from" :fetchIndex,
						  "sort": [
						           {
						             "date": {
						               "order": "desc"
						             }
						           }
						         ],
						  "highlight": {
							  "fields": {
							      "*":  {"fragment_size" : 150, "number_of_fragments" : 3}
							  }
						  
						  }
		}
		
		$.ajax({
			url:"http://192.168.1.55:9200/" + hidden_mb_id + "/_search",
			type:"post",
			data:JSON.stringify(data),
			dataType:"json",	 
			success:function( response ){
	      	console.log(response);
	       
	       var count = response.hits.hits.length;
	       console.log( count );
	       
	       for( var i = 0; i < count; i++ ) {
	     	  var fields = response.hits.hits[ i ];
	     	  insertHit( fields );
	       }
	       
	       fetchIndex += count;
	       
	       if( count > 0 ){
	    	   $("#down-arrow").show();
	    	   $("div.paging-nav").hide();
	    	   $("#lr-arrow").hide();
	       } else {
	    	   $("#down-arrow").hide();
	    	   
	    	}
		}
	    });

		}
		 
		 else if(id2=="mailSearch"){
				 var data=  {
							"fields": ["mail_id","account_addr","rec_addr","title","date_detail"],
							"query": {
							    "bool": {
							         "must": [{
							             "multi_match": {
							               "query": id,
							               "fields": [
												"title",
												"file"
							               ],
							              "type": "cross_fields",
							              "operator":"OR",
							              "minimum_should_match": "50%"
							             }
							           }]
							    }
							  },
							  "post_filter" : {
								  "term" : {
									  "account_id" : hidden_acc_id
								  }
							  }, 
							  "size": FETCH_LIST_SIZE,
							  "from" :fetchIndex,
							  "sort": [
							           {
							             "date": {
							               "order": "desc"
							             }
							           }
							         ],
							  "highlight": {
								  "fields": {
								      "*":  {"fragment_size" : 150, "number_of_fragments" : 3}
								  }
							  
							  }
				 }
				 
			
			$.ajax({
				url:"http://192.168.1.55:9200/" + hidden_mb_id + "/mail_type/_search",
				type:"post",
				data:JSON.stringify(data),
				dataType:"json",	 
				success:function( response ){
		          console.log(response);
		          var count = response.hits.hits.length;
			       console.log( count );
			       
			       for( var i = 0; i < count; i++ ) {
			     	  var fields = response.hits.hits[ i ];
			     	  insertHit( fields )
			       }
			       
			       fetchIndex += count;
			       if( count > 0 ){
			    	   $("#down-arrow").show();
			    	   $("div.paging-nav").hide();
			    	   $("#lr-arrow").hide();
			       } else {
			    	   $("#down-arrow").hide();
			    	   
			    	}
			       
				}
			    });
			 
		 }
		 
		 else if(id2=="attachSearch"){
				 var data=  {
							"fields": ["mail_id","account","rec_addr","mail_title","attachment_file","date"],
							"query": {
							    "bool": {
							         "must": [{
							             "multi_match": {
							               "query": id,
							               "fields": [
												"attachment_title",
												"attachment_file"
							               ],
							              "type": "cross_fields",
							              "operator":"OR",
							              "minimum_should_match": "75%"
							             }
							           }]
							    }
							  },
							  "post_filter" : {
								  "term" : {
									  "account_id" : hidden_acc_id
								  }
							  }, 
							  "size": FETCH_LIST_SIZE,
							  "from" :fetchIndex,
							  "sort": [
							           {
							             "date": {
							               "order": "desc"
							             }
							           }
							         ],
							  "highlight": {
								  "fields": {
								      "*":  {"fragment_size" : 150, "number_of_fragments" : 3}
								  }
							  
							  }
				 }
				 
			
			$.ajax({
				url:"http://192.168.1.55:9200/" + hidden_mb_id + "/attachment_type/_search",
				type:"post",
				data:JSON.stringify(data),
				dataType:"json",	 
				success:function( response ){
		          console.log(response);
		          
		          var count = response.hits.hits.length;
			       console.log( count );
			       
			       for( var i = 0; i < count; i++ ) {
			     	  var fields = response.hits.hits[ i ];
			     	  insertHit( fields )
			       }
			       
			       fetchIndex += count;
			       if( count > 0 ){
			    	   $("#down-arrow").show();
			    	   $("div.paging-nav").hide();
			    	   $("#lr-arrow").hide();
			       } else {
			    	   $("#down-arrow").hide();
			    	   
			    	}
				}
			    });
		 }
	 }
	 
 }
</script>
<!-- 서치스크립트 끝      서치스크립트 끝      서치스크립트 끝      서치스크립트 끝      서치스크립트 끝      서치스크립트 끝      서치스크립트 끝      서치스크립트 끝       -->


<body>
	
	<!-- 모달    모달    모달    모달    모달    모달    모달    모달    모달     -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="false" style="background-color: rgba(0, 0, 0, 0.5);">
     <div class="modal-dialog">
       <div class="modal-content">
		<!-- -----------------------모달 타이틀---------------------- -->
		   <div class="modal-header">
		       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">첨부파일</h4>
		    </div>
		<!-- ---------------------모달내용--------------------- -->
		    <div class="modal-body">
		
		
		   </div>
		<!-- ---------------------모달 하단--------------------- -->
		   <div class="modal-footer">
		      <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		   </div>
       </div>
     </div>
   </div>
   
 <!-- 모달 끝       모달 끝       모달 끝       모달 끝       모달 끝       모달 끝       모달 끝       모달 끝        -->
	

	<% int count=0; %>
	<c:forEach items="${loginInfo}" var="loginInfo" >
		<%count++; %>
	</c:forEach>
	
	<input type="hidden" id="hidden_mb_id" value="${mb_id}">
	
	<% String[] filePaths = (String[])request.getAttribute("filePaths") ; %>
	<% String[] fileNames = (String[])request.getAttribute("fileNames") ;%>
	
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
		class="lite"> SC</span></a> <!--logo end--> 
		
		<!--  search form start -->
	
	<style>
		.navbar-form select {-webkit-appearance:none; -moz-appearance: none; position: relative; appearance: none; border-radius:7px; background:url(./img2/sdown.png) no-repeat 95% 50%; background-color:white; }
	</style>
	
		<div class="nav search-row" id="top_menu">
			<ul class="nav top-menu">
				<li>
					<div class="navbar-form">
						<input type="hidden" name="command" value="search">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<select id="searchID" name="searchID" style="width:160px; height:26px; font-family:고딕체">
								<option value="all" height="100px">&nbsp;모든 메일 검색</option>
							<c:forEach items="${loginInfo}" var="list">
								<option value="${list.acc_id}">&nbsp;${list.acc_addr}</option>
							</c:forEach>
						</select>
						&nbsp;&nbsp;
						<select id="searchCon" name="searchCon" style="width:140px; height:26px; font-family:고딕체">
							<option value="nothing">&nbsp;조건</option>
							<option value="allSearch">&nbsp;전체 검색</option>
							<option value="mailSearch">&nbsp;일반메일검색</option>
							<option value="attachSearch">&nbsp;첨부파일검색</option>
						</select>
						&nbsp;&nbsp;
						<input placeholder="&nbsp;&nbsp;Search" type="text" name="searchText" id="searchText" style="width:200px; height:26px; border-radius:5px; position:relative; font-family:고딕체;">
						
						<button type="button" style="background-Color:#1a2732; border:0px #f1f2f7;" value="검색" onclick="search1( true );"><img alt="avatar" src="./img2/searchB2.png"></button>
					</div>
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
					class="icon-task-l"></i> <span class="badge bg-important">${fn:length(loginInfo)}</span></a>
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
					<i class="icon-bell-l"></i> <span class="badge bg-important"><%= count %></span>
			</a></li>
			<!-- alert notification end-->
			
			<!-- user login dropdown start-->
			<li class="dropdown"><a data-toggle="dropdown"
				class="dropdown-toggle" href="#"> <span class="profile-ava">
						<img alt="" src="img2/avatar1_small.jpg">
				</span> <span class="username">${user_id}</span> <b class="caret"></b>
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
		
		<!-- <form action="DispatcherServlet" method="post" name="llll">
			<input type="hidden" name="command" value="allview"> -->
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
							<li><a class="" href="DispatcherServlet?command=gmail&acc_id=${list.acc_id }">${list.acc_addr }</a></li>
						</c:if>
					</c:forEach>
				</ul></li>
				
				</li>
	
			<li class="sub-menu"><a href="javascript:;" class=""> <!-- <a href="gmail.html" class=""> -->
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
	
	
	
			
			<li class="sub-menu">
				<a class="" href="javascript:;"> <i class="icon_piechart"></i>
					<span>설정</span>
					<span class="menu-arrow arrow_carrot-right"></span>
					</a>		
					<ul class="sub">
						<li><a class="" href="accountAdd.jsp">계정 추가 </a></li>
						<li><a class="" href="accountDel.jsp">계정 삭제 </a></li>
						<!-- <li><a class="" href="member_mod.jsp">회원 정보 수정</a></li> -->
						<li><a class="" href="DispatcherServlet?command=memInfo">회원정보 수정</a></li>
					</ul>
			</li>
			
		</ul>
		<!-- sidebar menu end-->
	</div>
	</aside> <!--sidebar end--> <!--main content start--> <section
		id="main-content"> <section class="wrapper"> <!--overview start-->
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">
				<i class="fa fa-laptop"></i> Team SC
			</h3>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="DispatcherServlet?command=home">Home</a></li>
				<li><i class="fa fa-laptop"></i>Detail View</li>
			</ol>
		</div>
	</div>

	</section> <!-- 테이블 -->
	
	<table style="align:center; width:1500px; TABLE-layout:fixed" border="2" align="center" id ="table-demo" class="table table-striped">

		<tbody style="border:1px solid black;">
		
				<tr>
					<td align="center" style="width:1300px;"><h4>${detail.title }</h4></td>
					<td align="center" width=200px height=20px style="table-layout:fixed; padding-top:18px">${detail.recv_date }</td>
				</tr>
				<tr>
					<td align="right" colspan="2" style="height:20px; padding-right:33px"><a href="DispatcherServlet?command=gmail&acc_id=${allview.mail_no}">${detail.recv_addr }</a></td>
				</tr>
				<tr>
					<td align="center" colspan="2" style="border:2px">
						<iframe src="${detail.html_path }" width="1450px" height="800px"></iframe>
					</td>
				</tr>
				
				<%if(filePaths != null ){ %>
				
					<% for(int i = 0 ; i < filePaths.length ; i++) { %>
				<tr>
					<td align="right" style="width:1500px; padding-right:35px" colspan="2">
						<img src="http://publicdomainvectors.org/photos/Icon_Documents.png" width=40 height=30> 
						<a href="DispatcherServlet?command=down&file_path=<%= fileNames[i]%>">&nbsp;&nbsp;&nbsp;<%= filePaths[i] %></a></td>
					<%} %>		
				</tr>						
				<%} %>
		</tbody>
	</table>
	
	<div style="padding-top:10px" id="lr-arrow">
		<table align="center" style="table-layout:fixed;" >
				<tr>
					<td align="center" width=50px height=30px style="table-layout:fixed">
						<c:set var="mail_no_minus" value="${detail.mail_no-1}"></c:set>
						<a href="DispatcherServlet?command=detailView&mail_no=${mail_no_minus}"><img alt="avatar" src="./images/left.png"></a>
					</td>
					<td align="center" width=700px height=5px style="table-layout:fixed; padding-bottom:17px; vertical-align:center"><nobr><h4>&ensp;${detail.title}</h4></nobr>&ensp;&ensp;&ensp;</td>
					<td align="center" width=50px height=5px style="table-layout:fixed">
						<c:set var="mail_no_plus" value="${detail.mail_no+1}"></c:set>
						<a href="DispatcherServlet?command=detailView&mail_no=${mail_no_plus}"><img alt="avatar" src="./images/right.png"></a>
					</td>
				</tr>	
		
		</table>	
	</div>
	
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
