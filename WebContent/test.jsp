<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
.result table, .result table td, .result ul, .result li { margin:0; padding:0 }  
.result table { width:1500px; height:40px; border-collapse: collapse; margin-bottom:20px; }
.result table, .result table td { border:1px solid #111 }
.result table td { padding:10px }
.result ul { list-style-type: none }
.result table td.highlight { padding:5px; word-break:break-all; }
.result table td.highlight li { margin:10px; margin-left:20px;}
</style>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
var FETCH_LIST_SIZE = 5;
var fetchIndex = 0;

function insertHit( fields ) {

	var html = 
		"<table>"  +
			"<tr>" +
				"<td width='100px' align='center'>" + fields._id + "</td>" +
				"<td width='200px'>" + fields.fields.account_addr + "</td>" +
				"<td width='200px'>" + fields.fields.rec_addr + "</td>" +
				
				
				"<td width='400px'><a href='/SUMTEST/viewMail?mail_no=1' targte='_blank'>" + (fields.fields.title == null ? fields.fields.mail_title : fields.fields.title) + "</a></td>" +
				
				"<td width='200px'>"+ fields.fields.date_detail+"</td>" +
				"</tr>" +
				"<tr>" +
				"<td colspan='5' class='highlight'>" +
				"<ul>" +
				
				( fields.highlight.title == null ? "" : "<li><span>제목 :</span><span>" + fields.highlight.title + "</span></li>") + 
				( fields.highlight.file == null ? "" : "<li><span>내용 :</span><span>" + fields.highlight.file + "</span></li>") + 
				( fields.highlight.attachment_title == null ? "" : "<li><span>첨부파일 제목 :</span><span>" + fields.highlight.attachment_title + "</span></li>") + 
				( fields.highlight.attachment_file == null ? "" : "<li><span>첨부파일 내용 :</span><span>" + fields.highlight.attachment_file + "</span></li>") + 
				
				"</ul>" +
				"</td>" +
				"</tr>" +
				
				( fields.fields.attachment_title == null ? "" : "<tr><td colspan='5'>첨부파일 미리보기 : <button>"+fields.fields.attachment_title+"</button> </td></tr>")+
			
		"</table>";
	
	$("#result-list").append( html );

}

function search1( isFirst ){
	 var id = $('#searchText').val();
	 var id2 = $('#searchCon').val();

	 if( isFirst == true ) {
	 	$("#result-list").html( "" );
	 	fetchIndex = 0;
	 }
	 
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
					              "minimum_should_match": "75%"
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
		url:"http://192.168.1.55:9200/48/_search",
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
	}
    });

	}
	 
	 else if(id2=="mailSearch"){
			 var data=  {
						"fields": ["mail_id","account_dd","title","date_detail"],
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
						              "minimum_should_match": "75%"
						             }
						           }]
						    }
						  },
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
			url:"http://192.168.1.55:9200/15/mail_type/_search",
			type:"post",
			data:JSON.stringify(data),
			dataType:"json",	 
			success:function( response ){
	          console.log(response);
	          
	          /* var count = response.hits.hits.length;
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
	        	  
	          } */
	          
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
						              "minimum_should_match": "75%"
						             }
						           }]
						    }
						  },
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
			url:"http://192.168.1.55:9200/15/attachment_type/_search",
			type:"post",
			data:JSON.stringify(data),
			dataType:"json",	 
			success:function( response ){
	          console.log(response);
	          
	          /* var count = response.hits.hits.length;
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
	        	  
	          } */
	          
			}
		    });
		 
	 }
	 
	 
 }
</script>

</head>
<body>
	<div class="nav search-row" id="top_menu">
			<ul class="nav top-menu">
				<li>
					<div class="navbar-form">
						<select id="searchID" name="searchID" class="form-control">
							<option value="">전체</option>
							<option value="">1@nav</option>
							<option value="">2@goo</option>
						</select>
						
						<input class="form-control" placeholder="Search" type="text" name="searchText" id="searchText">
						<input type="hidden" name="command" value="search">
							
						<select id="searchCon" name="searchCon" class="form-control">
							<option value="">조건</option>
							<option value="allSearch">전체 검색</option>
							<option value="mailSearch">일반메일검색</option>
							<option value="attachSearch">첨부파일검색</option>
						</select>
						<input type="button" value="검색" onclick="search1( true );">
					</div>
				</li>
			</ul>
	</div>
	<div class="result" id="result-list"></div>
	<button onclick="search1( false );">다음</button>
</body>
</html>