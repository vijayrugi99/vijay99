<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Users list</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="Responsive_Style.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="snackbar.css">
  <script>var Myapp={};</script>
  <!--  Export table code-->
  <script src="jquery.min.js"></script>
	<script src="FileSaver.js"></script>
	<script src="tableexport.js"></script>

	<script>
	function export1()
	{
	$(".exporttable").tableExport();
	}
	/* Defaults */
	$(".exporttable").tableExport({
	    headings: true,                    // (Boolean), display table headings (th/td elements) in the <thead>
	    footers: true,  				// (Boolean), display table footers (th/td elements) in the <tfoot>
	    //type:"xls",
	    formats: ["xls"],// "csv", "txt"],    // (String[]), filetypes for the export
	    fileName: "id",                    // (id, String), filename for the downloaded file
	    bootstrap:true,                   // (Boolean), style buttons using bootstrap
	    position: "bottom"    ,             // (top, bottom), position of the caption element relative to table
	    ignoreRows: null,                  // (Number, Number[]), row indices to exclude from the exported file
	    ignoreCols: [4]  ,                 // (Number, Number[]), column indices to exclude from the exported file
	    ignoreCSS: ".tableexport-ignore"   // (selector, selector[]), selector(s) to exclude from the exported file
	});
	</script>
  
  <style>
  .table-responsive2 {
 	width:100%;
 	margin-bottom:15px; 
	overflow-x:auto; 
	overflow-y:hidden;
	-webkit-overflow-scrolling:touch;
	-ms-overflow-style:-ms-autohiding-scrollbar; 
	border:1px solid #ddd
	}
	
	.table-responsive2 table {
	    table-layout: fixed;
	}
	.tableheader {
		width:100%; 
		margin-bottom:0px;
		border:1px solid #999;
		align:center;
	
	}
	.tablebody {
		height: 640px;
		overflow-y: auto; 
		width: 100%; 
		margin-bottom:20px;
		align:center;
	}
  </style>
  <style>
#snackbar1,#snackbar2,#snackbar3 {
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

#snackbar1.show,#snackbar2.show,#snackbar3.show  {
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
   var x={};
   </script>
<script type="text/javascript">


function myFunction(urole,un) {
    
    x.urole=urole;
    x.un=un;
    $(document).ready(function(){
  	  $('#myModal1').modal('show');
  	  
   });
   }
     function okay(){
    	 $(document).ready(function(){
    	  	  $('#myModal1').modal('hide');
    	   }); 
            	window.location="deleteUser.jsp?role="+x.urole+"&username="+x.un;
            }         
</script>
<body onload="javascript:snackbar()">
	<%
	String err=request.getParameter("err");
	//System.out.println("Err="+err);
	%>
	 <%@page import="com.mongodb.MongoClient"%>
	<%@page import="org.bson.Document"%>
	<%@page import="com.mongodb.MongoException"%>
	<%@page import="com.mongodb.WriteConcern"%>
	<%@page import="com.mongodb.DB"%>
	<%@page import="com.mongodb.DBCollection"%>
	<%@page import="com.mongodb.BasicDBObject"%>
	<%@page import="com.mongodb.DBObject"%>
	<%@page import="com.mongodb.DBCursor"%>
	<%@page import="com.mongodb.ServerAddress"%>
	<%@page import="java.util.*"%>
	<%@page import="java.util.List"%>
	<%@page import="java.net.UnknownHostException"%>
	<%@page import="java.util.Date"%>
	<%@page import="com.mongodb.BasicDBObject"%>
	<%@page import="com.mongodb.DB"%>
	<%@page import="com.mongodb.DBCollection"%>
	<%@page import="com.mongodb.Mongo"%>
	<%@page import="com.mongodb.MongoException"%>
	<%@include file="Config.jsp" %>
	<%-- <%@include file="home.jsp" %> --%>
	<%
	try{  
		
	    MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	    DB db1 = mongoClient.getDB(db); 
	    DBCollection collection= db1.getCollection(credentials);
	    DBCursor cursor;
	    cursor=collection.find();
	    %>
	    <div class="container">
			<h2 style="text-align:center;color:brown;">List of Users</h2>
			<div class="row">
			<div id="user logn details" class="exporttable table-responsive2">
	        <table class="table table-bordered table-striped tableheader">
	        <thead>
	           <tr>
						<th style="width:10%;text-align:center;word-wrap:break-word">Sl. No.</th>
						<th style="width:15%;text-align:center;word-wrap:break-word">Role</th>
						<th style="width:25%;text-align:center;word-wrap:break-word">UserName</th>						
						<th style="width:15%;text-align:center;word-wrap:break-word">Password</th>
						<th style="text-align:center;word-wrap:break-word">Modify</th>
				</tr> 
			</thead>
	        </table>
	        <div class="tablebody">
	        <table class="table table-bordered table-striped" >
	        <tbody>
	<% 
	   DBObject dbo;
	   int count=0;
	   while(cursor.hasNext())
	   {
	    	dbo=cursor.next();
	    	//System.out.print(dbo);
	     	%>   
	        <tr>
	            <td style="width:10%;vertical-align:middle;word-wrap:break-word"><%= ++count %></td>
	            <td style="width:15%;vertical-align:middle;word-wrap:break-word" id="role_<%= count%>"><%=dbo.get("role") %></td>
	            <td style="width:25%;vertical-align:middle;word-wrap:break-word" id="user_<%= count%>"><%=dbo.get("username") %></td>
	          	<%--  <td><%=dbo.get("password") %></td> --%>
	         	<td style="width:15%;vertical-align:middle;word-wrap:break-word"><%=dbo.get("password") %></td>
	          	<td style="vertical-align:middle;word-wrap:break-word"><button type="button" class="btn btn-success btn-md" data-toggle="modal" onclick="fun('<%=dbo.get("role")%>','<%=dbo.get("username")%>','<%=dbo.get("password")%>')" data-target="#myModal">
	          	<span class="glyphicon glyphicon-pencil"></span>&nbsp Edit</button>
	        	&nbsp &nbsp<button type="button" class="btn btn-danger btn-md" data-toggle="modal" data-target="#myModal1" onclick="myFunction('<%=dbo.get("role")%>','<%=dbo.get("username")%>')"><span class="glyphicon glyphicon-remove"></span>&nbsp Delete</button>
	        </tr>
	        <%
	   }
	}
	catch(Exception e)
	{
		//out.println("Exception"+e);
		System.out.println(e);
	}%>
	
	 
	    </tbody>
	</table>
	</div>
	</div>
	</div>
	</div>
	<script>
	
	function fun(a,b,c)
	{			
		$("#err").html("").css('color', 'red');
		Myapp.role=a;
		Myapp.username=b;
		Myapp.password=c;
		document.getElementById("arole").value=a;
		document.getElementById("username").value=b;
		document.getElementById("password").value=c;
		var newusr=document.getElementById("username").value;
		var newpwd=document.getElementById("password").value;
	}
	</script>
	<div id="snackbar">User Modified Successfully</div>
	<div id="snackbar1">User Deleted Successfully</div>
	<div id="snackbar2">Sorry, Unable To Modify User,TRY AGAIN</div>
	<div id="snackbar3">Sorry, Unable To Delete User,TRY AGAIN</div>
	<div class="container">
			<div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	    
	      Modal content
	      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title">User details</h4>
		        </div>
	        <div class="modal-body">
	        <div align="center">
			<label class="col-md-3 control-label" for="selectbasic">Role of the User</label>
			<select id="arole" name="role" class="form-control input-md" required>
			 <option value="admin">Admin</option>
			 <option value="monitoring">Monitoring</option>
			 <option value="fi">Field-Investigator</option>
			 <option value="CallCenter">CallCenter</option>
			 <option value="analyst">Analyst</option>
			</select><br> 
			<label class="col-md-1 control-label" for="selectbasic">UserName:</label><input type="text" name="username" id="username" onchange="onSubmit()" class="form-control input-md"><br>
			<label class="col-md-1 control-label" for="selectbasic">Password:</label><input type="password" name="password" id="password" onchange="onSubmit()" class="form-control input-md"><br>		<span id="err" style="color:red"></span>
			 <p id="p1"></p>
			
			  </div>
			        <div class="modal-footer">
			          <button type="button" class="btn btn-primary" id="submit1" onclick="onSubmit()" class="form-control input-md">submit</button>
			          <button type="button" class="btn btn-primary" data-dismiss="modal" class="form-control input-md" >cancel</button>
			          
			        </div>
			      </div>		      
			    </div>
			  </div>		  
			</div>  
			  </div>
			
			
	       <script>
	       function newuser()	
	      	{
	    	   var newrole = $("#arole").val();
	    	 	var newusr = $.trim($("#username").val());
	    		var newpwd= $("#password").val();
	    		document.getElementById("err").innerHTML="";

	    		var t=null;
	
	    		   if (newusr.length < 5)
	    		   {
	    		       $("#err").html("User name should be >5char!").css('color', 'red');
	    	           /* document.getElementById("submit1").disabled=true; */
	    		 	    	           Myapp.t=0;
	
	    		       document.getElementById("username").focus();
	    		   }
	    		   else
	    			   {  		 
		    		       $("#err").html("").css('color', 'red');
	 	    	           Myapp.t=0;
	
	    		           if (newpwd.length <= 7){
		 	    	           Myapp.t=0;
	
	    		      		$("#err").html("Password should > 8 char!").css('color', 'red');
	 	    	           document.getElementById("password").focus();
	 	    	           /* document.getElementById("submit1").disabled=true; */
	    		           }  
	    		   			else
	    		   				{
	    		   						$("#err").html("").css('color', 'red');
	    		 	    	           document.getElementById("submit1").disabled=false;
	    		 	    	           Myapp.t=1;
	    		   				}
	    	            }
	    		   
	      	}   
	    	   function onSubmit()
	    	   {
	    		   Myapp.t=0;
	    		   newuser();
	    		 
	    		   $("#err").html("").css('color', 'red');
	    		   var mrole = Myapp.role;
				   var musername = Myapp.username;
				   var mpassword = Myapp.password;
				    var newrole = $("#arole").val();
		    	 	var newusr = $("#username").val();
		    	// 	//alert(newusr);
		    		var newpwd= $("#password").val();
		    		var msg=null;
		    		if(Myapp.t==1)
		    			{
		    			  //alert("Inside submit")
		    			  if(mrole!=newrole || musername!=newusr)
		    				  {
				    			var xmlhttp;
				    			var response="";
				    			var urls="exist.jsp?role="+newrole+"&un="+newusr;
				    			if (window.XMLHttpRequest)
				    			  {
				    			   xmlhttp=new XMLHttpRequest();
				    			  }
				    			else
				    			  {
				    			   xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				    			  }
				    			   xmlhttp.onreadystatechange=function()
				    			  {    				
				    				if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
				    		        {
				    		            var response;// =xmlhttp.responseText;
				    		          //  //alert(response)
				    		          /* response = xmlhttp.responseText.trim()
	    		                      response = response.replace(/^\s+|\s+$/g, ""); */
				    		          //response1 = JSON.parse(response);
				    		          //   //alert(Myapp.t);
				    		 	      // //alert(response.length)
				    		 	       var a = JSON.parse(xmlhttp.responseText);
				                       var val=xmlhttp.responseText; 
				                       var d = a.jsonArray;
				       				   var s=JSON.stringify(a);
				       				   var n= s.split(":");
				       				   var one=n[0];
				       				   //alert("one"+one);
				       				   var two=n[1];
				       				   //alert("one2"+two);
				       				   var three=two.split("\"");
				       				   //alert("one3"+three);
				       				   var four=three[1];
				       				   //alert("one4"+four);
				    		      		if (four=="1")
				    		            {
				    		      			 window.location.href="updateUser.jsp?mrole="+mrole+"&muname="+musername+"&mpassword="+mpassword+"&role="+newrole+"&username="+newusr+"&password="+newpwd;
				    		 		   		 $('#myModal').modal('hide');
				    		                //window.location.href = "dashboard.html";
				    		            }
				    		            else
				    		            {
				    		            	 
				    		               // //alert("Not available");
				    		                Myapp.t=1;
				    		               // document.getElementById("err").innerHTML = "User already registered!";
				    		                $("#err").html("User already registered!").css('color', 'red');
				    		            } 
				    		      		
				    		        }
		    						}
				    				xmlhttp.open("GET",urls,true);
				    				xmlhttp.send();  	
		    					  }
		    					else
		    					{
		      			 			window.location.href="updateUser.jsp?mrole="+mrole+"&muname="+musername+"&mpassword="+mpassword+"&role="+newrole+"&username="+newusr+"&password="+newpwd;
		      						$('#myModal').modal('hide');	
		    					}
		    			 
		    			  }
		    //		//alert(t1);
			   	   /* if(t1==2)
			   		{
			   		   //alert("hi")
		   	   	   window.location.href="updateUser.jsp?mrole="+mrole+"&muname="+musername+"&mpassword="+mpassword+"&role="+newrole+"&username="+newusr+"&password="+newpwd;
			   		$('#myModal').modal('hide');
			   		} */
		    			
		    		}   
	       
	       
	       </script>
	       <div class="modal fade" id="myModal1" role="dialog"  data-backdrop="static" width="20%">
	                                <div class="modal-dialog">
	                                <!-- Modal content-->
	                                <div class="modal-content">
	                                <div align="center">
	                                <div class="modal-body">
	                                <p style="color:red"><b>Are You Sure , Want To Delete This User....? <br> Please Confirm..!</b></p>
	                                </div>
	                                <a  class="btn btn-warning"  onclick="okay()" >Yes</a>&nbsp;&nbsp;
	                                <button type="button"  class="btn btn-info"  data-toggle="modal"  data-dismiss="modal" >No</button>
	                                <div class="modal-footer">
	                                </div>
	                                </div>
	                                </div>
	                                </div>
	                               </div>
	                      <%
	/* String err="";
	err=request.getParameter("err"); */
	if(err!=null){
		System.out.println("Error code="+err);
		if(err.equals("2"))
		{%>
		<script>
		 	var x = document.getElementById("snackbar");
		    x.className = "show";
		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		</script>
		
		<%}
		else if(err.equals("3"))
		{%>
		<script>
			var x = document.getElementById("snackbar1");
		    x.className = "show";
		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		</script>
		
		<%}
		else if(err.equals("4"))
		{
		%>
		<script>
			var x = document.getElementById("snackbar2");
		  	x.className = "show";
		  	setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		  	</script>
		<%}
		
		else if(err.equals("5"))
		{
		%><script>
			var x = document.getElementById("snackbar3");
		  	x.className = "show";
		  	setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		  	</script>
		<%}
		else
		%>
		<!-- <script>
		function snackbar(){
		  	   if(window.location.href.indexOf("2") > -1) {
		  		 //alert("in 2");
		  		   var x = document.getElementById("snackbar");
		  		    x.className = "show";
		  		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		  		}
		  	 if(window.location.href.indexOf("3") > -1) {
		  		 //alert("in 3");
		  		   var x = document.getElementById("snackbar1");
		  		    x.className = "show";
		  		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		  		}
		  	if(window.location.href.indexOf("4") > -1) {
		  		//alert("in 4");
		  			var x = document.getElementById("snackbar2");
		  		    x.className = "show";
		  		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		  		}
		  	if(window.location.href.indexOf("5") > -1) {
		  	//	alert("in 5");
		  		   var x = document.getElementById("snackbar3");
		  		    x.className = "show";
		  		    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
		  		}
		}
	      </script>
		 -->    
	<% 
	 }
	%>
			
</body>
</html>
