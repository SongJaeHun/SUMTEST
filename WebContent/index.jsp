<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    	<!-- 
    	Boxer Template
    	http://www.templatemo.com/tm-446-boxer
    	-->
		<meta charset="utf-8">
		<title>teamSC - Test2</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="keywords" content="">
		<meta name="description" content="">

		<!-- animate css -->
		<link rel="stylesheet" href="css/animate.min.css">
		<!-- bootstrap css -->
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<!-- font-awesome -->
		<link rel="stylesheet" href="css/font-awesome.min.css">
		<!-- google font -->
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,700,800' rel='stylesheet' type='text/css'>

		<!-- custom css -->
		<link rel="stylesheet" href="css/templatemo-style.css">
		
	<script type="text/javascript">
	
		function checkRegister(){
			var r=document.registerForm;
			if(r.user_id.value==""){
				alert("아이디를 입력하세요");
				r.user_id.focus();
				return false;
			}else if(r.user_pwd.value==""){
				alert("패스워드를 입력하세요");
				r.user_pwd.focus();
				return false;
			}else if(r.user_name.value==""){
				alert("이름을 입력하세요");
				r.user_name.focus();
				return false;
			}else if(r.cf_email.value==""){
				alert("메일을 입력하세요");
				r.cf_email.focus();
				return false;
			}
		}
		
		
		function checkLogin(){
			var r=document.LoginForm;

			if(r.user_id.value==""){
				alert("아이디를 입력하세요");
				r.user_id.focus();
				return false;
			}else if(r.user_pwd.value==""){
				alert("패스워드를 입력하세요");
				r.user_pwd.focus();
				return false;
			}
		}
		
		//*********************************************************************************************
		function checkId() {
			  if (checkFirst == false) {
			   //0.5초 후에 sendKeyword()함수 실행
			   setTimeout("sendId();", 500);
			   loopSendKeyword = true;
			  }
			  checkFirst = true;
			 }
			 
			 
			 
		function sendId() {
			  if (loopSendKeyword == false) return;
			  
			  var keyword = document.registerForm.user_id.value;
			  if (keyword == '') {
				   lastKeyword = '';
				   document.getElementById('checkMsg').style.color = "black";
				   document.getElementById('checkMsg').innerHTML = "아이디를 입력하세요.";
				   }
			  else if (keyword != lastKeyword) {
					lastKeyword = keyword;
					   
					if (keyword != '') {
						    var params = "user_id="+encodeURIComponent(keyword);
						    sendRequest("id_check.jsp", params, displayResult, 'POST');
						}
					else {
					}
			  }
			  setTimeout("sendId();", 500);
			 }
			 
			 
		function displayResult() {
			  if (httpRequest.readyState == 4) {
			   if (httpRequest.status == 200) {
			    var resultText = httpRequest.responseText;
			    var listView = document.getElementById('checkMsg');
			    if(resultText==0){
			     listView.innerHTML = "사용 할 수 있는 ID 입니다";
			     listView.style.color = "blue";
			    }else{
			     listView.innerHTML = "이미 등록된 ID 입니다";
			     listView.style.color = "red";
			    }
			   } else {
			    alert("에러 발생: "+httpRequest.status);
			   }
			  }
			 }


		
		function checkPwd(){
			  var f1 = document.registerForm;
			  var pw1 = f1.user_pwd.value;
			  var pw2 = f1.pwd_check.value;
			  if(pw1!=pw2){
				   document.getElementById('checkPwd').style.color = "red";
				   document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요."; 
			  }else{
				   document.getElementById('checkPwd').style.color = "black";
				   document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다."; 
			   
			  }
			  }
	
		
	</script>
	
	<style type="text/css">
	
		#checkMsg{
		  font-size: 12px;
		}
		#checkPwd{
		  color : red;
		  font-size: 12px;
		}
	</style>
	
	</head>
	<body>
		<!-- start preloader -->
		<div class="preloader">
			<div class="sk-spinner sk-spinner-rotating-plane"></div>
    	 </div>
		<!-- end preloader -->
		
        <!-- start navigation -->
		<nav class="navbar navbar-default navbar-fixed-top templatemo-nav" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="icon icon-bar"></span>
						<span class="icon icon-bar"></span>
						<span class="icon icon-bar"></span>
					</button>
					<a href="index.jsp" class="navbar-brand">Mail</a>
				</div>
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav navbar-right text-uppercase">
						<li><a href="#home">HOME</a></li>
						<li><a href="#video">VIDEO</a></li>
						<li><a href="#login">LOGIN</a></li>
						<li><a href="#join">JOIN</a></li>
						<li><a href="#about">ABOUT</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- end navigation -->
		
        
        <!-- start home -->
		<section id="home">
			<div class="overlay">
				<div class="container">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-10 wow fadeIn" data-wow-delay="0.3s">
							<h1 class="text-upper">Elastic search</h1>
							<p class="tm-white">
							메일 통합 관리 시스템. [ MTMS ]<br/>
							엘라스틱 서치를 이용한 메일 검색 시스템. [Elastic Search]</br>
							<a href="https://twitter.com/">트위터</a> <a href="http://www.facebook.com">페이스북</a> <a href="index.jsp">홈페이지</a></p>
                            <br/><br/><br/><br/><br/>지금시작하세요<br/><br/><br/>
                            
                            
							
						</div>
						<div class="col-md-1"></div>
					</div>
				</div>
			</div>
		</section>
        <!-- end home -->
         
         
         <!-- start video -->
         <section id="video">
				<!-- <div class="container"> 
					<div class="row"> -->
						<div class="col-md-6 wow fadeInUp col-lg-12" data-wow-delay="0.6s">
							<h2 class="text-uppercase"></h2>
							<iframe width="1900" height="500" src="https://www.youtube.com/embed/j42QYC7La5U" frameborder="0" ></iframe>
							
						</div>
<!-- 					</div>						
                    </div> -->
		</section>
		
        <!-- end video-->
        
        <!-- start login -->
        
        <section id="login">
			<div class="overlay">
				<div class="container">
					<div class="row">
                
				<div class="col-md-6 wow fadeInUp" data-wow-delay="0.6s">
							<h2 class="text-uppercase"></h2>
							<h1>&emsp;&emsp;Log In</h1>
                            <p>로그인해서 메일관리를 편하게 이용해보세요</p>
                            <p>&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;<a href="#login">지금 로그인 하기</a></p>
						</div>
						<div class="col-md-6 wow fadeInUp" data-wow-delay="0.6s">
							<div class="contact-form">
							<form action="DispatcherServlet" method="post" name="LoginForm" onsubmit="return checkLogin()">
								
								<input type="hidden" name="command" value="login">
	                                <div class="col-md-12">
										<input type="text" class="form-control" placeholder="ID" name="user_id" id="user_id">
									</div>
                                    <div class="col-md-12">
										<input type="password" class="form-control" placeholder="Password" id="user_pwd" name="user_pwd">
									</div>
									
									<div class="col-md-6">
										<input type="submit" class="form-control text-uppercase" value="Login">
									</div>
                                    <div class="col-md-6">
										<input type="submit" class="form-control text-uppercase" value="ID/PWD 찾기">
									</div>
                                    <div class="col-md-6">
										<input type="reset" class="form-control text-uppercase" value="취소">
									</div>
								</form>
							</div>
						</div>
						</div>
						</div>
					</div>
		</section>
        
        <!-- end login-->
        
        
        <!-- start join -->
    <section id="join">
		<div class="overlay">
				<div class="container">
					<div class="row">
						<div class="col-md-6 wow fadeInUp" data-wow-delay="0.6s">
							<h2 class="text-uppercase"></h2>
							<h1>&emsp;&emsp;JOIN US</h1>
                            <p>회원가입해서 메일관리를 편하게 이용해보세요</p>
                            <p>&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;<a href="#join">지금 회원가입 하기</a></p>
						</div>
						<div class="col-md-6 wow fadeInUp" data-wow-delay="0.6s">
							<div class="contact-form">
								<form action="DispatcherServlet" method="post" name="registerForm" onsubmit="return checkRegister()">
	                            <input type="hidden" name="command" value="register">
                                    <div class="col-md-12">
										<input type="text" class="form-control" placeholder="ID" name="user_id" id="user_id" onkeydown="checkId()">
										<div id="checkMsg">아이디를 입력하세요</div>
									</div>
									
									<div class="col-md-12">
										<input type="password" class="form-control" placeholder="Password" name="user_pwd">
									</div>
									
									<div class="col-md-12">
										<input type="password" class="form-control" placeholder="Password" name="pwd_check" onkeyup="checkPwd()">
       									<div id="checkPwd">동일한 암호를 입력하세요.</div>
									</div>

									<div class="col-md-12">
										<input type="text" class="form-control" placeholder="NAME" name="user_name">
									</div>
									
                                    <div class="col-md-12">
										<input type="email" class="form-control" placeholder="EMAIL" name="cf_email">
									</div>
									
									<div class="col-md-6">
										<input type="submit" class="form-control text-uppercase" value="회원가입">
									</div>
									
                                    <div class="col-md-6">
										<input type="reset" class="form-control text-uppercase" value="취소">
									</div>
									
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section id="about">
			<div class="overlay">
				<div class="container">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-10 wow fadeIn" data-wow-delay="0.3s">
							<h1 class="text-upper">About US</h1>
							<p class="tm-white">Team SC</p>
						</div>
						<div class="col-md-1"></div>
					</div>
				</div>
			</div>
		</section>
		<footer>
			<div class="container">
				<div class="row">
					<p>Copyright © 2015 Team SC</p>
				</div>
			</div>
		</footer>
		<!-- end footer -->
        
		<script src="js/jquery.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/wow.min.js"></script>
		<script src="js/jquery.singlePageNav.min.js"></script>
		<script src="js/custom.js"></script>
	</body>
</html>