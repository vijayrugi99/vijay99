<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>Add Taluk</title>
<head>

<link rel="stylesheet" type="text/css" href="Responsive_Style.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script>var Myapp={};</script>
</head>

<script type="text/javascript">
function loadXMLDocU()
{
var xmlhttp;
var xmlhttp;
var response="";
var u = $("#ausername").val();
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
	var newusr = $("#ausername").val();
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
</script>
<body>

 	<div class="container">
	 <h1 style="text-align:center;color:brown;"> Add New Facility</h1>

   <div class="form-group" style="text-align:center">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> District:</label>
		<div class="col-sm-3">
		  <select required="required" name="dist" id="dist" class="form-control" onchange="district()">
			  <option> Choose...</option>
			 <option value="Koppal">Koppal</option>
			 <option value="Gadag">Gadag</option>
		 </select><br><span id="err4" style="color:red"></span>
		</div>
	  </div>
   <div class="form-group" style="text-align:center">
		<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> Taluk:</label>
		<div class="col-sm-3">
		  <select required="required" name="dist" id="dist" class="form-control" onchange="district()">
			  <option> Choose...</option>
			 <option value="Koppal">Koppal</option>
			 <option value="Gadag">Gadag</option>
		 </select><br><span id="err4" style="color:red"></span>
		</div>
	  </div>

  
<!-- Text input-->
   <div class="form-group" style="text-align:center">
  <label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> Taluk Name</label> 
		<div class="col-sm-3">
  <input id="talukname" name="talukname" placeholder="Enter Taluk Name" class="form-control input-md" onchange="newtaluk()" required="" type="text"><span id="err" style="color:red"></span>
  <br><span id="err1" style="color:red"></span>
  </div></div>

<!-- Button -->
<div class="form-group" style="text-align:center">
<label class="control-label col-sm-offset-3 col-sm-2" style="color:blue"> </label>
<div class="col-sm-3">
    <button class="btn btn-primary" id="submit1" onclick="onSubmit1()" type="submit">Submit</button>
  </div>
	</div>
	
 <span id="err1" style="color:red"></span><br>
 <blink><span id="err" style="color:red;align:center"></span></blink>


</div>
</body></html>