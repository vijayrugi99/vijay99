<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">	
	<title> Community Search</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="koppal_villages.js"></script>
	<script src="communityWorkers.js"></script>		
  	<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
  		
  	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  	<script src="facilities.js">	</script>
	<script src="ken_kmc_html.js"></script>
	
	<style>
		.table>tbody>tr>td{vertical-align:middle;}
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
			.tableheader_modal
			{
				width:800px;
				margin-bottom:0px;
				border:1px solid #999;
			}
			.tablebody_modal
			{
				height: 200px;
				overflow-y: auto;
				width: 800px; 				
				margin-bottom:20px;
			}

			.tableheader {
				width: 100%;				
				margin-bottom:0px;
				border:1px solid #999;			
			}
			.tablebody {
				height: 500px;
				overflow-y: auto;
				width: 100%;				
				margin-bottom:20px;
			}	
		    .modal-content 
		    {
			    background-color: #fefefe;
			    margin: auto;
			    padding: 20px;
			    border: 1px solid #888;
			    width: 100%;
			    height: 100%;
			    overflow :hidden;
			}		
	</style>
  <script> 
	 function display(idx)
	 {
		var village = community[idx];
		var count = 0;
		   for(i = 1;i<village.length;i++)
		   {	
			 // count++;
			   str+="<tr><td style=\"width:20%;\">"+i+"</td>";
		       str+="<td style=\"width:20%;word-wrap:break-word;\">" + village[i].text+"</td>";
		       str+="<td style=\"width:20%;word-wrap:break-word;\">" + village[i].value +"</td>";
		       str+="<td style=\"width:20%;word-wrap:break-word;\"><button class=\"btn btn-info btn-sm\" data-toggle=modal data-target=#myModal onclick=getValue("+village[i].value+","+(i)+");>view</button></td>";
		       str+="<td style=\"width:19.5%;word-wrap:break-word;\">"+ getCWByComm(village[i].value).length+" </td>";
		    }
		   str+="</tr><tbody></table></div></div></div></center>";
		   displayReport.innerHTML=str;	   
	 }
	 
	 function getValue(villagevalue, count)
	 {
		 console.log(villagevalue);
		 console.log(count);
		 var c = document.getElementById("abc");
		 console.log(c);
		 if(c != null)
		{
		 	var str = getworkers(villagevalue);		 	
		 	c.innerHTML=str;
		}
		
	 }
   </script>
   <script>
	   function getworkers(param)
	   {
		   console.log(param);
		   var  res = (param);
		   console.log(res);
		   var myObject = res;
		   var total = myObject.length;
		   
		   var str2=""
			str2+="<h3 style=\"text-align:center\"><b>Total-Workers::"+total+"</b></h3>";
		   	str2+="<div class=\"container\">";		   	
			str2+="<div class=\"row\">";	   
			str2+="<div class=\"table-responsive2\">";	     	 
            str2+="<table class=\"table table-bordered table-striped tableheader_modal\">";
            str2+="<thead><tr>";
		    str2+="<th >Value</th>";
			str2+="<th >Phone</th>";
			str2+="<th >Text</th>";
			str2+="<th >Type</th>";
			str2+="<th style=\" word-wrap:break-word\">Community</th></tr></thead></table>";
			str2+="<div class=\"tablebody_modal\"> <table class=\"table table-bordered table-striped\">";
		  	str2+="<tbody>";
		   //document.writeln("<td>" + total +"<td>");
		   for(i = 0;i<myObject.length;i++)
		   {					
		       str2+="<tr><td style=\"vertical-align:top\">" +myObject[i].value+ "</td>";
		       str2+="<td style=\" word-wrap:break-word ; vertical-align:top\">" + myObject[i].phone +"</td>";
		       str2+="<td style=\" word-wrap:break-word ; vertical-align:top\">" + myObject[i].text +"</td>";
		       str2+="<td style=\" word-wrap:break-word; vertical-align:top\">" + myObject[i].type +"</td>";
		       str2+="<td  style=\" word-wrap:break-word\">" + myObject[i].communities +"</td>";	      
		    }
		   str2+="</tr><tbody></table></div></div></div>";		   		  
		  return str2;
	   }
   </script>
</head>

<body >
	<%@ include file="Config.jsp" %>	
	<%@ include file="home.jsp" %>
	<%@page import= "java.util.*" %>
	<% 
		String value = request.getParameter("workers");
		String taluk = request.getParameter("facility");
		int count=0;
	%>
	<div class="container" align="center"> 		
		<form action="searchCW.jsp" method="POST" class="form-inline">
			<h2 style="color:brown;">Community</h2>
			<div class="form-group">
				<select class="form-control" id="facility" name="facility" style="padding:3px;" onchange="display(this.options.selectedIndex)"> 	
					<option value=0>koppal_villages</option>
					<option value=1>gangawati_villages</option>
					<option value=2>kushtagi_villages</option>
					<option value=3>yelbarga_villages</option>
				</select>
			</div>
			<br /><br />
		</form>
	</div>
	
	<div id="displayReport"></div>
	<!-- <div id="displayWorkers"></div> -->
		
    <!-- Modal -->
    <div class="container">
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-lg">
		      	<div class="modal-content" id="myModal1">
		        	<div class="modal-header">
		          		<button type="button" class="close" data-dismiss="modal">&times;</button>
		          		<h3 class="modal-title" style="color:brown; text-align:center;">Community-workers details</h3>
		        	</div>
		        	<div class="modal-body">      
		          		<p id="abc"> </p>
		          		<div class="modal-footer">
		          			<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
		        		</div>        
		      		</div>
		    	</div>
		  	</div>
		</div>
	</div> 	
	
	<div id="somediv"></div>
	<script>
		 display(0);
	</script>
	<%@include file="tableexport.jsp" %>		  
</body>
</html>