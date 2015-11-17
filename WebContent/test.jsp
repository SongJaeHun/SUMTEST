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
	var data=  {
		"fields": ["id","title","file"],
		"query": {
		    "bool": {
		         "must": [{
		             "multi_match": {
		               "query": "한국",
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
        	  var fields = response.hits.hits[ i ].fields;
        	  

        	  
        	  console.log( fields.file + ":" + fields.file );
          }
          
		}
	    });
	
	
	
</script>
<body>
</body>
</html>