<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv=”Pragma” content=”no-cache”>
	<meta http-equiv=”Expires” content=”-1?>
	<meta http-equiv=”CACHE-CONTROL” content=”NO-CACHE”>
	
	<title> KMC Pending Details </title>
	<script src="facilities.js">	</script>
	<script src="taluks.js">	</script>	
	<script src="ken_kmc_html.js"></script>	
	<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- must include -->
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
			width: 1165px;
			margin-bottom:0px;
			border:1px solid #999;
			}
			.tablebody {
				height: 500px;
				overflow-y: auto;
				width: 1165px;
				margin-bottom:20px;
				}
	</style>
	
	<!-- Display facility based on selected taluk -->
	<script>
	   	function displayFacility(index)
	   	{
	   		var fac=facilities;
	   		var facArray = [];
	   		var selected = "";
	   		var len1=0;
	   		var facvalue = '<%= request.getParameter("facility")%>';
	   		//console.log(facvalue);
	   		var facint = parseInt(facvalue);
	   		console.log(facint);
	   		var st="<label style=\"font-size:20px; color:blue\"> Facility:</label>";
	   		st+="<select name=\"facility\" id=\"facility\" class=\"form-control\" style=\"padding:3px;\">";
	   		st+="<option value=\"1\">All</option>";
	   		selected = "";
	   		if(index=="0")
	   		{   			
	   			//alert("Inside index 0")
	   			for(i=0;i<fac.length;i++)
	   			{   		
	   				var value=fac[i].value;
	         		var text=fac[i].text;  
	         		if(facvalue !=null && facint==fac[i].value)
	      		 	{
	      		 		selected="selected";
	      		 	}
	      		 	else
	      		 		selected="";
	         		st+="<option "+selected+" value="+fac[i].value+">"+fac[i].text+"</option>";
	         		facArray.push(fac[i].value);
	         		//alert(index)
	   			}   			
	   			st+="</select>";   			
	  		 	sf.innerHTML=st;  		
	   		}
	   		else
	   		{   		
		   	 	for(i=0;i<fac.length;i++)
			   	{
		   		 	if(fac[i].taluk==index)
		   			 {
		   			  	var taluk=fac[i].taluk;
		   		      	var value=fac[i].value;
		      		 	var text=fac[i].text;
		      		 	if(facvalue !=null && facint==fac[i].value)
		      		 	{
		      		 		selected="selected";
		      		 	}
		      		 	else
		      		 		selected="";
		      		 	st+="<option "+selected+" value="+fac[i].value+">"+fac[i].text+"</option>";
		      		 	len1++;	
		      		 	facArray.push(fac[i].value);
		   			 } 	   		 	
			   	}
	   	 		//alert(len1)
	   	      	st+="</select>";
			  	sf.innerHTML=st;
			}
	   		//console.log(facArray);   		
	   		document.getElementById("hiddenField").value=facArray;
	   		var hiddenvalue=document.getElementById("hiddenField").value;
	   		//console.log(hiddenvalue);
	   	} 
   	</script>   		
	</head>
	<body onload="displayFacility(<%= (request.getParameter("taluk")==null)?"0":request.getParameter("taluk")%>)">	
		<%@page import="java.sql.*" %>
		<%@page import="java.awt.List" %>
		<%@page import="com.mongodb.ServerAddress" %>
		<%@page import="com.mongodb.DBCursor" %>
		<%@page import="com.mongodb.DBObject" %>
		<%@page import="com.mongodb.BasicDBObject" %>
		<%@page import="com.mongodb.DBCollection" %>
		<%@page import="com.mongodb.DB" %>
		<%@page import="com.mongodb.BasicDBObjectBuilder" %>
		<%@page import="com.mongodb.BasicDBList" %>
		<%@page import="com.mongodb.AggregationOutput" %>
		<%@page import="com.mongodb.MongoException" %>
		<%@page import="com.mongodb.MongoClient" %>
		<%@page import="org.bson.types.ObjectId" %>
		<%@page import="com.mongodb.ServerAddress" %>
		<%@page import="java.awt.List" %>
		<%@page import="java.util.ArrayList"%>
		<%@page import="java.awt.List" %>
		<%@page import="org.json.JSONObject" %>
		<%@page import="org.json.JSONArray" %>
		<%@page import="java.text.*" %>
		<%@page import = "java.util.*"%>
		<%@page import = "java.util.Date"%>
		<%@page import = "java.util.Calendar"%>	
		<%@ include file="Config.jsp" %>
		<%-- <%@ include file="home.jsp" %> --%>
		<%@page import = "com.mongodb.util.JSON"%>
		
		<% 
			String value = request.getParameter("facility");
			System.out.println("facility ="+value);	
			
			String tq = request.getParameter("taluk"); 
			if(tq==null)
			{
				tq="0";
			}			
			System.out.println("taluk="+tq);
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); //date format
			//logic to increment one day from today's date
			Date dt = new Date();
			//current date - one month 
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			Date result = cal.getTime();
			System.out.println("Before one month date ="+result);
						
			String datefrom = request.getParameter("datefrom"); //get value from form
			if(datefrom == null)
			{
				datefrom = sdf.format(result);
			}
			System.out.println("datefrom from form="+datefrom);
						
			String dateto = request.getParameter("dateto"); //get value from form
			if(dateto == null)
			{
				dateto = sdf.format(dt);
			}
			else
			{
				Date dt2=(Date)sdf.parse(dateto);
				dateto=sdf.format(dt2);
			}
			System.out.println("date to from form="+dateto);
		%>
		
		
		<div class="container" align="center">		 
		 <form action="KMC_Pending_Details.jsp" method="POST" class="form-inline">
		 <h1 style = "color:brown"> KMC Pending Details </h1>
		 <div class="form-group">
			<div id="filters2"></div>
			<script>
				var filterStr= DropdownFilterWithOnchange(talukFilter,"<%= tq%>");				
				filters2.innerHTML=filterStr;
			</script>
		 </div>
		
			
		<div class="form-group">
			<div id="sf"><label style="font-size:20px; color:blue"> Facility:</label></div>
		</div>
		
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Date From: </label> 					
			<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
		</div>
		
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Date To:</label> 
			<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto%>" readonly>				
		</div>			
		
		<!-- for store facility value -->			
			<input type="hidden" id="hiddenField" name="hiddenField"/>
			
		<br /> 
		<button type="submit" class="btn btn-primary">Submit</button>				
		<br />									
		</form>			
		</div>		
		<%
			response.setContentType("text/html");	
			try
			{
				int kmcPeriod = 4;
				String facValues=null;
				int facilityvalue =Integer.parseInt(value);
				if(facilityvalue == 1)
				{
					facValues=request.getParameter("hiddenField");					
				}
				else
				{
					facValues=value;
				}
				//System.out.println("hidden values = "+facValues);				
			  	int taluks = Integer.parseInt(tq);
			  	
			 	//convert date to yyyy-MM-dd format
				SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");				
				Date datef = (Date)sdf.parse(datefrom);
				String newdatefrom = sdf2.format(datef);				
				System.out.println("date from after convert to date yyyy-MM-dd format="+newdatefrom);				
				
				Date datet = (Date)sdf.parse(dateto);
				String newdateto = sdf2.format(datet);
				System.out.println("date to after convert to date yyyy-MM-dd format="+newdateto);
				
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();				
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection);	
				
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
				int facility = value==null?1:Integer.parseInt(value);
				ArrayList<DBObject> jsonArray = mongodao.getPendingKMCInitiation(facValues,newdatefrom,newdateto);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				System.out.println("total baby count ="+jsonArray.size());
				int count=0;
				%>				
			 	<div class="container">
				<div class="row">
				<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= jsonArray.size()%> </b> </h4>
		     	<div id="KMC_Pending_Babies" class="exporttable table-responsive2">
                <table class="table table-bordered table-striped tableheader">
                <thead>
                <tr>
						<th style="text-align:center;width:50px;"> SI. No. </th>
						<th style="width:100px; text-align:center;word-wrap:break-word;"> Period </th>
						<th style="text-align:center;width:100px;"> Facility </th>
						<th style="text-align:center;width:300px;word-wrap:break-word;"> Unique_ID </th>
						<th style="text-align:center;width:150px;"> DOB </th>
						<th style="text-align:center;width:150px;word-wrap:break-word;"> Mother Name </th>
						<th style="text-align:center;width:150px;word-wrap:break-word;"> Father Name </th>
						<th style="text-align:center;"> Enter </th>
				</tr>                    
                </thead>
                </table>
				<div class="tablebody">
                <table class="table table-bordered table-striped" >
                <tbody>
				<% 
				if(jsonArray.size() >0)
				{
					for(int i=0; i<jsonArray.size(); i++)
					{
						//System.out.println("DBObjects are ="+jsonArray.get(i));
						ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
						//System.out.println("Objet id are ="+objid);		
						
						//convert ObjectID into date format
						Date enterDate = objid.getDate();
						SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:ss:mm a");
						java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
						sdf1.setTimeZone(tz);
						String formatDate = sdf1.format(enterDate);
						//System.out.println("Formatted object entered date = " +formatDate);
						
						BasicDBObject facilityData = (BasicDBObject)jsonArray.get(i).get("facility");
						bd.facility = facilityData.getInt("facility");
						
						if(facilityData.containsField("from_date"))							
							bd.from_date = facilityData.getString("from_date");
						if(facilityData.containsField("to_date"))								
							bd.to_date = facilityData.getString("to_date");	
						//System.out.println("Faility are ="+bd.facility);
						
						BasicDBObject kmcData = (BasicDBObject)jsonArray.get(i).get("data");
						bd.dob = kmcData.get("dob");
						bd.mother_name = kmcData.get("mother_name");
						bd.husband_name = kmcData.get("husband_name");
						bd.u_id = kmcData.get("unique_id");
						//System.out.println("dob are ="+bd.dob);
						System.out.println();
						%>					
						<tr>
							<td style="width:50px;vertical-align:middle"> <%= (++count)%> </td>
							<td style="width:100px;word-wrap:break-word;"><%= bd.from_date +" to "+ bd.to_date%></td>
							<td style="width:100px;vertical-align:middle"> <%= bd.facility%> </td>
							<td style="width:300px;vertical-align:middle"> <%=  bd.u_id%> </td>
							<td style="width:150px;vertical-align:middle"> <%= bd.dob%> </td>
							<td style="width:150px;vertical-align:middle;word-wrap:break-word;"> <%= bd.mother_name%> </td>
							<td style="width:150px;vertical-align:middle;word-wrap:break-word;"> <%= bd.husband_name%> </td>
							<td style="vertical-align:middle">
							<button type="button" class="btn btn-info btn-sm" style="color:black" onClick="window.location.href='kmcinit-fi.jsp?baby=<%=kmcData.get("unique_id")%>'"> Enter KMC </button>
							</td>						
						</tr>
					<%		
					}	//close for loop of jsonArray
					if(jsonArray.size() >0)
					{
						%>
							<tr> <td colspan="8"> <h4 style="text-align:left; color:red;">-----End of Records----</h4> </td></tr>						
						<%
					}
				}//close if jsoArray
				else
				{
					%>
					<tr> <td colspan="8"> <h4 style="text-align:left; color:red;">No Records</h4> </td></tr>
					<%
				}			
				%>
				</tbody>
				</table>
				</div></div>
				</div></div>
				
				<%
			}//close try block	
			catch(Exception e)
			{
				System.out.println("e");
			}
			%>	
		<%@ include file="tableexport.jsp" %>
		<!-- Date picker logic-->		
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
			<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
			<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
			<script type="text/javascript">	
			    $(document).ready(function () 
				{
			   		var fromDate=document.getElementById("datefrom").value;
				    var pre = new Date("10/01/2016");
					var date=new Date();
					date.setDate(date.getDate());
					$('#dateto').datepicker(
							{
								dateFormat: "dd/mm/yy" ,
								numberOfMonths: 1,			
								minDate:  fromDate,
								maxDate:date,								
							}
					);
	
				    $("#datefrom").datepicker(
						{
							dateFormat: "dd/mm/yy",
							numberOfMonths: 1,			
							minDate:  pre,
							maxDate:date,
							onSelect: function(date){            
								var date1 = $('#datefrom').datepicker('getDate');           
								var date = new Date( Date.parse( date1 ) ); 
								date.setDate( date.getDate());        
								var newDate = date.toDateString(); 
								newDate = new Date( Date.parse( newDate ) );                      
								$('#dateto').datepicker("option","minDate",newDate);            
				        }
				    });
				})
			</script>
	</body>
</html>