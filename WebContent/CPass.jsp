<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<title>Password Change</title>	
   <link rel="stylesheet" type="text/css" href="Reports_Stylesheet.css"> 	
  	<script src="facilities.js">	</script>
	<script src="ken_kmc_html.js"></script>
<title>Insert title here</title>
  <script>var Myapp={};</script>
  <script type="text/javascript">
function loadXMLDocP()
{
var xmlhttp;
var xmlhttp;
var response="";
var p = $("#CurPass").val();
//alert("Inside loadxml"+p)
var urls="exist.jsp?password="+p;
if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else 
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {   	//alert("ajax")


	if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
    {
	
		 var a = JSON.parse(xmlhttp.responseText);
		 var val=xmlhttp.responseText;
		// alert("length-"+val.length);
		 var d = a.jsonArray;
		 var s=JSON.stringify(a);
		 var n= s.split(":");
		 var one=n[0];
		 var two=n[1];
		 var three=two.split("\"");
		 var four=three[1];
  		 if (four=="1")
         {
  			document.getElementById("err1").innerHTML = "";
            Myapp.t=1;
      
        }
        else
        {
            Myapp.t=0;
  	       document.getElementById("CurPass").focus();
            document.getElementById("err1").innerHTML = "wrong password";
        } 
    }
  }
xmlhttp.open("GET",urls,true);
xmlhttp.send();
}


function newuser()	
	{
	var p = $("#CurPass").val();
	var np = $("#NewPassword").val();
	var cp = $("#ConPassword").val();
	
	var confirmPassword = $("#ConPassword").val();
	var t=null;
      if(Myapp.t==1)
		       {
	          		  if (np.length < 6 || np.length > 12)
	          		  {
	    	          	 Myapp.t=0;
	      				 $("#err2").html("Password min 6 & max 12 char!").css('color', 'red');
 	           			 document.getElementById("NewPassword").focus();
	           		   }  
	   				 else
	   					{
	   					
							$("#err2").html("").css('color', 'red');
							if(confirmPassword!="")
							checkPasswordMatch()
							    //alert("Myapp value="+Myapp.t)

							 if(Myapp.t==2) // passwords are matched
							{
								  //  alert("Myapp inside value="+Myapp.t)

					     		 Myapp.t=3;
								 //window.location.href="insertUser.jsp?arole="+role+"&ausername="+newusr+"&apassword="+apwd;
							}
							 else
		 	           			 document.getElementById("ConPassword").focus();
							loadXMLDocP();

	   					}
            	}	   
	  		 	else
	  		 	{
		    		document.getElementById("submit1").disabled=false;
	   			}
      loadXMLDocP();

	       	}   
	
function goBack() {
    window.history.back();
}
function checkPasswordMatch() {
var password = $("#NewPassword").val();
var confirmPassword = $("#ConPassword").val();
if (password != confirmPassword)
    $("#err3").html("Passwords do not match!").css('color', 'red');
else
	{
		 Myapp.t=2;
    $("#err3").html("").css('color', 'green');
    return;
	}
}
function onSubmit1() {
	
	var p = $("#CurPass").val();
	var np = $("#NewPassword").val();
	loadXMLDocP();
    newuser(); //  myapp.t is 3 if passwords are matched else myapp.t is 1 
	//checkPasswordMatch();
    //alert("Myapp sub,mit value="+Myapp.t)

    if(Myapp.t==3)
		{
	    window.location.href="PassCheck.jsp?CurPass="+p+"&pwd1="+np;

		}
	
}
</script>
<style >
td{
width="500px";
}
</style>
</head>
<body>
<%@include file="home.jsp" %>
<br>
<br>

<center> <h2 style="color:brown">Change Password</h2> </center>
 
<br>
<div class="container">
 
    
<table class="table table-bordered table-striped tableheader table-responsive" border="1" style="align:center" cellpadding="0">
  <thead class="thead-inverse">
    
  </thead>
  <tbody>
 
  <tr>
      <td>Current Password: </td>
      <td><input type="password" id="CurPass" name="CurPass" onchange="loadXMLDocP()"> <br><span id="err1" style="color:red"></span></td>
    </tr>
    
   
     <tr>
      <td>New Password: </td>
      <td><input type="password" id="NewPassword" name="NewPassword" onchange="newuser()"> <br><span id="err2" style="color:red"></span></td>
    </tr>
   
   
    <tr>
      <td>Confirm Password: </td>
     <td><input type="password" id="ConPassword" onchange="newuser()" name="ConPassword"><br><span id="err3" style="color:red"></span> </td>
    </tr>
   
      <tr>
        	<td> </td> 
     <td><input type="submit" id="submit1" value="Submit" onclick="onSubmit1()">  &nbsp; &nbsp; &nbsp;
     <input type="button" value="Cancel" onclick="goBack()"></td>
     </tr>
    
  </tbody>
</table>
</div>


<blink><span id="err" style="color:red;align:center"></span></blink>
<h5 style="color:red;margin-left:5%;"> <b>Password must contain: </b></h5>
<ul style="list-style-type:disc; color:red; margin-left:5%;">
  <li>At least 6 characters</li>
<!--   <li>At least 1 lowercase letter</li>
  <li>At least 1 uppercase letter</li>
  <li>At least 1 number</li>
 -->
 </ul>



</div>
</body>
</html>