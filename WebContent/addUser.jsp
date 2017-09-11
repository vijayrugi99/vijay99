<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>Add User</title>
<head>

<link rel="stylesheet" type="text/css" href="Responsive_Style.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="snackbar.css">
  <script>var Myapp={};</script>
  <style>
#snackbar1 {
    visibility: hidden;
    min-width: 250px;
    margin-left: -125px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border-radius: 2px;
    padding: 16px;
    position: fixed;
    z-index: 1;
    left: 50%;
    margin-top:250px;
    bottom: 30px;
    font-size: 17px;
}
#snackbar1.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
    from {bottom: 0; opacity: 0;} 
    to {bottom: 30px; opacity: 1;}
}

@keyframes fadein {
    from {bottom: 0; opacity: 0;}
    to {bottom: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {bottom: 30px; opacity: 1;} 
    to {bottom: 0; opacity: 0;}
}

@keyframes fadeout {
    from {bottom: 30px; opacity: 1;}
    to {bottom: 0; opacity: 0;}
}
  </style>
</head>

<script type="text/javascript">
function loadXMLDocU()
{
var xmlhttp;
var xmlhttp;
var response="";
var u = $.trim($("#ausername").val());
var role=$("#arole").val();
var urls="exist.jsp?un="+u+"&role="+role;

if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {   // 	alert("ajax")


	if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
    {

      //  alert(response)
     response = xmlhttp.responseText.trim()
     response = response.replace(/^\s+|\s+$/g, "");
     //response1 = JSON.parse(response);
	//  alert(response.length)
  		if (response.length<=735)
        {
  		  document.getElementById("err").innerHTML=""; 
  		 Myapp.t=1;
            //window.location.href = "dashboard.html";
        }
        else
        {
     		 Myapp.t=0;
  	       document.getElementById("ausername").focus();
            document.getElementById("err").innerHTML = response;
        } 
    }
  }
xmlhttp.open("GET",urls,true);
xmlhttp.send();
}
function role1()
{		var role= $("#arole").val();
		if(role!="choose")
		{
		 	 document.getElementById("err4").innerHTML="";
		} 
		else
		{
	 		//alert("Select role")
	 		document.getElementById("err4").innerHTML="Please select the role!";

			//$("#errr").html("Please select the role!").css('color', 'red');
	 		document.getElementById("arole").focus();
	 		Myapp.t=0;
		}
}

function newuser()	
	{
	role1();
	var newusr = $.trim($("#ausername").val());
 	var apwd = $("#apassword").val();
	var role= $("#arole").val();

	var confirmPassword = $("#conpassword").val();
	var t=null;
	$("#errr").html("").css('color', 'red');


	   if (newusr.length < 5)
	   {
	       $("#err").html("Username should min 5 char!").css('color', 'red');
           /* document.getElementById("submit1").disabled=true; */
	 	    Myapp.t=0;
            document.getElementById("ausername").focus();
	   }
	   else
		   {  	
		   
	  		  document.getElementById("err").innerHTML=""; 
		  		  document.getElementById("err1").innerHTML=""; 
		       loadXMLDocU();
		       if(Myapp.t==1)
		       {
	          		  if (apwd.length < 6 || apwd.length > 12)
	          		  {
	    	          	 Myapp.t=0;
	      				 $("#err2").html("Password length between 6 to 12 char!").css('color', 'red');
 	           			 document.getElementById("apassword").focus();
	           		   }  
	   				 else
	   					{
	   					
							$("#err2").html("").css('color', 'red');
							
							if(confirmPassword!="")
							checkPasswordMatch()
							 if(Myapp.t==2)
							{
					     		 Myapp.t=3;

								 //window.location.href="insertUser.jsp?arole="+role+"&ausername="+newusr+"&apassword="+apwd;
							}
							 else
		 	           			 document.getElementById("conpassword").focus();

	   					}
            	}	   
	  		 	else
	  		 	{
		    		document.getElementById("submit1").disabled=false;
	   			}
	       	}   
	}
function goBack() {
    window.history.back();
}
function checkPasswordMatch() {
var password = $("#apassword").val();
var confirmPassword = $("#conpassword").val();
if (password != confirmPassword)
    $("#err3").html("Passwords do not match!").css('color', 'red');
else
	{
		 Myapp.t=2;
    $("#err3").html("Passwords match.").css('color', 'green');
    return;
	}
}
function onSubmit1() {
	newuser();
	var newusr = $("#ausername").val();
 	var apwd = $("#apassword").val();
	var role= $("#arole").val();
	/* alert(newusr)
	alert(apwd)
	alert(role)
	alert("M="+Myapp.t) */
	 if(Myapp.t==3)
		{
	//	 alert("inside 3333")
	window.location.href="insertUser.jsp?arole="+role+"&ausername="+newusr+"&apassword="+apwd;
	//	 window.location="vijay.jsp";
		 // ?arole="+role+"&ausername="+newusr;

		}
	
}
function RestrictSpace() {
    if (event.keyCode == 32) {
        return false;
    }
}
</script>
<body onload="javascript:snackbar()">
<div id="snackbar">User Added Successfully</div>
<div id="snackbar1">Sorry unable to add new user</div>
<%
String err="";
err=request.getParameter("error");
if(err!=null){
	%>
	<script>
	 function snackbar(){
  	   if(window.location.href.indexOf("success") > -1) {
  		   var x = document.getElementById("snackbar");
  		    x.className = "show";
  		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
  		}
  	   
  	    if(window.location.href.indexOf("fail") > -1) {
  	    	var x = document.getElementById("snackbar1");
  		    x.className = "show";
  		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
  			}
  	   }
      </script>
	
	    
<%}
%>




<%-- <%@ include file="home.jsp" %> --%>

 	<div class="container">
	 <h1 style="text-align:center;color:brown;"> Add New User </h1>
<!-- Select Basic -->
<div>
   <div class="form-group" style="text-align:center">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> Role:</label>
		<div class="col-sm-3">
		  <select required="required" name="role" id="arole" class="form-control" onchange="role1()">
			  <option value="choose" > Choose...</option>
			 <option value="admin">Admin</option>
			 <option value="monitoring">Monitoring</option>
			 <option value="fi">Field-Investigator</option>
			 <option value="CallCenter">CallCenter</option>
			 <option value="analyst">Analyst</option>
			</select><br><span id="err4" style="color:red"></span>
		</div>
	  </div>
<!-- Text input-->
   <div class="form-group" style="text-align:center">
  <label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> User Name:</label> 
		<div class="col-sm-3">
  <input id="ausername" name="ausername" placeholder="Enter User Name" class="form-control input-md" onkeypress="return RestrictSpace()" onchange="newuser()" required="" type="text"><span id="err" style="color:red"></span>
  <br><span id="err1" style="color:red"></span>
  </div></div>

<!-- Text input-->
<div class="form-group" style="text-align:center">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue">Password:</label>  
 <div class="col-sm-3">
  <input id="apassword" name="apassword" placeholder="Enter User Password" class="form-control input-md" onkeypress="return RestrictSpace()" required="" type="password" onchange="newuser()">
<span id="err2" style="color:red"></span><br>
  </div>
  </div>
<!-- Text input-->
<div class="form-group" style="text-align:center">
<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue">Confirm Password:</label>  
<div class="col-sm-3">
  <input id="conpassword" name="conpassword" placeholder="Confirm your Password" class="form-control input-md" required="" type="password" onkeypress="return RestrictSpace()" onchange="newuser()">
 <br> <span id="err3" style="color:red"></span>  
</div>
</div>
<!-- Button -->
<div class="form-group" style="text-align:center">
<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> </label>
<div class="col-sm-3">
    <button class="btn btn-primary" id="submit1" onclick="onSubmit1()" type="submit">Submit</button>
  </div>
	</div>
	
 <span id="err1" style="color:red"></span><br>
 <blink><span id="err" style="color:red;align:center"></span></blink>
 <div class="form-group">
 <label class="control-label col-sm-offset-3 col-sm-6" style="color:red">Password must contain: 
 <br><h5 style="color:red">*Between 6-12 characters</h5></label>
 <div class="col-md-1 control-label"><br>
 </div>
 </div></div>

</div>
<!-- </div> -->
<br><br>


</body></html>