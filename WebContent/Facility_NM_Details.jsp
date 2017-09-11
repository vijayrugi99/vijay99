<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta http-equiv=”Pragma” content=”no-cache”>
		<meta http-equiv=”Expires” content=”-1?>
		<meta http-equiv=”CACHE-CONTROL” content=”NO-CACHE”>

		<title> Facility,NM Details </title>
		<script src="facilities.js?version=1.0.0">	</script>
		<script src="staff.js">	</script>
		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
		<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
		<style type="text/css">
		.well {
		    background: none;
		    height: 320px;
		}	
		.table>thead>tr>th{text-align:center;}	
		table,th,td { text-align:center; border-collapse:collapse; border:1px solid black; padding:5px; width:50%};			
		</style>  
		
		<!-- style for table fixed -->
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
			width: 1100px;
			margin-bottom:0px;
			border:1px solid #999;
			}
			.tablebody {
			height: 250px;
			overflow-y: auto;
			width: 1100px;
			margin-bottom:20px;
			}
		</style>    
		<script>
		function eraseCache(){
		//	alert("hi")
			  window.location = window.location.href+'?eraseCache=true';
			}
		</script> 		
	</head>
	
	<body>
	<%-- <%@ include file="home.jsp" %> --%>					
		<h4 style = "color:brown; text-align:center"> Facility Details </h4>
		<div id="facilitydisplay"></div>			
			<script>			
				var str="<div class=\"container\">"+
				"<div class=\"row\">"+
				"<div id=\"Facilities\" class=\"exporttable table-responsive2\"><center>";				  
				str+="<table class=\"table table-bordered table-striped tableheader\"><thead><tr>";		
					str+="<th style=\"width:550px\"> Value </th>";
					str+="<th style=\"width:550px\"> Text </th>"
					str+="</tr>";
					str+="</thead></table>";					
					str+="<div class=\"tablebody\">"+
	                "<table class=\"table table-bordered table-striped\">"+
	                "<tbody>";
					for(var i=0; i<facilities.length; i++)				
					{				
						str+="<tr>";
						str+="<td style=\"width:550px\">"+facilities[i].value+"</td>";					
						str+="<td style=\"width:550px\">"+facilities[i].text+"</td>";
						str+="</tr>";
					}
					str+="</div></div></div>";
					str+="</center>";
					//console.log(str);					
					facilitydisplay.innerHTML=str;
			</script>	
								
			<h4 style = "color:brown; text-align:center"> Nurse_Mentor Details </h4>
			<div id="nmdisplay"></div>				
			<script>			
				var str2="<div class=\"container\">"+
				"<div class=\"row\">"+
				"<div id=\"NMs\" class=\"exporttable table-responsive2\"><center>";				  
				str2+="<table class=\"table table-bordered table-striped tableheader\"><thead><tr>";		
					str2+="<th style=\"width:550px\"> Value </th>";
					str2+="<th style=\"width:550px\"> Text </th>"
					str2+="</tr>";
					str2+="</thead></table>";					
					str2+="<div class=\"tablebody\">"+
	                "<table class=\"table table-bordered table-striped\">"+
	                "<tbody>";					
						for(var j=0; j<nms.length; j++)					
						{				
							str2+="<tr>";
							str2+="<td style=\"width:550px\">"+nms[j].value+"</td>";					
							str2+="<td style=\"width:550px\">"+nms[j].text+"</td>";
							str2+="</tr>";
						}
						str2+="</div></div></div>";
						str2+="</center>";
						//console.log(str2);					
						nmdisplay.innerHTML=str2;
			</script>
			<%@ include file="tableexport.jsp" %>
	</body>	
</html>