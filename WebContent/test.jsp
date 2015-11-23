<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>


		  
 function search1(){
	 var id = $('#exam').val();
	 var id2 = $('#search').val();
	 alert(id2);
	 var data=  {
				"fields": ["id","title","file"],
				"query": {
				    "bool": {
				         "must": [{
				             "multi_match": {
				               "query": id,
				               "fields": [
				                 "title^10",
				                 "file^100"
				               ],
				              "type": "cross_fields",
				              "operator":"AND",
				              "minimum_should_match": "75%"
				             }
				           }]
				    }
				  },
				  "highlight": {
				    "fields": {"file": {"fragment_size" : 150, "number_of_fragments" : 3}}
				  }};
 
	$.ajax({
		url:"http://192.168.1.55:9200/test2/board/_search",
		type:"post",
		data:JSON.stringify(data),
		dataType:"json",	 
		success:function( response ){
          console.log(response);
          
          var count = response.hits.hits.length;
          console.log( count );
          
          for( var i = 0; i < count; i++ ) {
        	  var fields = response.hits.hits[ i ];

        	  document.write("파일id = " + fields._id);
        	  document.write('<br/>');
        	  document.write('<br/>');
        	  document.write("제목 = " + fields.fields.title);
        	  document.write('<br/>');
        	  document.write('<br/>');
        	  document.write("파일 내용 = " + fields.fields.file);
        	  document.write('<br/>');
        	  document.write('<br/>');
        	  document.write("하이라이트=" + fields.highlight.file);
        	  
          }
          
		}
	    });
	
 }
 
 
</script>
<body>
	<input type="text" id=exam name=exam><input type="button" onClick="return search1()" value="버튼">
	
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
							<input type="button" value="검색" onClick="return search1()">
						</form>
					</li>
				</ul>
			</div>
</body>
</html>