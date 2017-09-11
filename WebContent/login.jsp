


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="snackbar.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
        <script type="text/javascript">
        function getQueryVariable(variable)
        {
               var query = window.location.search.substring(1);
               var vars = query.split("&");
               for (var i=0;i<vars.length;i++) {
                       var pair = vars[i].split("=");
                       if(pair[0] == variable){
                    	   
                    	   return pair[1];}
                       
               }
               return(false);
        }
function test()
{
	snackbar();
	var role=getQueryVariable("role")
	var err=getQueryVariable("error")
	var un=getQueryVariable("un")
	if(err==-1)
		{
		document.getElementById("roles").value=role;
		document.getElementById('err').innerHTML = "User name is incorrect";
		
		}
	if(err==-2)
	{
		document.getElementById("roles").value=role;
		document.getElementById("username").value=un;
	document.getElementById('err').innerHTML = "Please select correct role";
	
	}
	if(err==-3)
	{
	document.getElementById("roles").value=role;
	document.getElementById("username").value=un;
	document.getElementById("password").focus();
	document.getElementById('err').innerHTML = "please enter correct password";
	
	}
	}
	
</script>
   <script>
          function snackbar(){
   if(document.URL.indexOf("val") != -1) {
	   var x = document.getElementById("snackbar")
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
	}}
 </script>
<style>
.navbar {
      margin-bottom: 0;
      background-color: #5F5F5F;
      z-index: 9999;
      border: 0;
      font-size: 14px !important;
      line-height: 1.42857143 !important;
      letter-spacing: 1px;
      border-radius: 0;
  }
</style>
</head>
<body onload="javascript:test()">


<nav class="navbar navbar-inverse navbar-fixed-top">

  <div class="container-fluid">
    <div class="navbar-header">

    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#"><span class="label label-danger">KMC Project </span></a>
    </div>
</div>
</nav>
<br>
<br>
<br>

<div class="container">
<center>
	<h1 style="color:brown"> Login </h1>
	<br />
	<form class="form-horizontal" action="verifyLogin.jsp" method="post">
	  <div class="form-group" style="text-align:center">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> Role:</label>
		<div class="col-sm-3">
		  <select name="role" id="roles" class="form-control">
			 <option> Choose...</option>
			 <option value="admin">Admin</option>
			 <option value="monitoring">Monitoring</option>
			 <option value="fi">Field-Investigator</option>
			 <option value="CallCenter">CallCenter</option>
			 <option value="analyst">Analyst</option>
			</select>
		</div>
	  </div>
	  <div class="form-group">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue">Username:</label>
		<div class="col-sm-3"> 
		  <input type="text" class="form-control" id="username" name="username" required>
		</div>
	  </div>  
	  <div class="form-group">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue">Password:</label>
		<div class="col-sm-3"> 
		  <input type="password" class="form-control" id="password" name="password" required>
		</div>
	  </div>
	  <br />	  
	  <button class="btn btn-primary"> Login </button>
	</form>
<br>
<br>
<span id="err" style="color:red"></span>
<div id="snackbar">You've logged out successfully</div>
</center>
</div>
</body>
</html>