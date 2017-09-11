<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		
		<title> Track Babies </title>		
  		<link rel="stylesheet" type="text/css" href="Responsive_Style.css"> 		
  		<script src="facilities.js">	</script>  		
  		<script src="taluks.js">	</script>
		<script src="ken_kmc_html.js"></script>	
		<script src="ken_kmc_html.js"></script>	
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>		
		
		<!-- must include -->
	   	<style>
	   		.table>tbody>tr>td{vertical-align:middle;}		   
			.table-responsive2 {
			width:100%;
			margin-bottom:15px;
			overflow-x:auto;
			overflow-y:hidden;
			-webkit-overflow-scrolling:touch;
			-ms-overflow-style:-ms-autohiding-scrollbar;
			border:1px solid #ddd;
			/* position:relative; */			
			}
			
			.table-responsive2 table {
			    table-layout: fixed;
			}
			.tableheader {
				width: 1450px;
				margin-bottom:0px;
				border:1px solid #999;			
			}
			.tablebody {
				height: 500px;
				overflow-y: auto;
				width: 1465px;
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
		   	
		   	function csv()
		   	{
		   		var dateFrom=document.getElementById("datefrom").value;
		   		var dateTo=document.getElementById("dateto").value;
		   		window.location.href="CSV1.jsp?datefrom="+dateFrom+"&dateto="+dateTo;
		   		
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
		<%@include file="handleEvent.jsp" %>		
      	
      	<%        
	      	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");			
	      	/* String value = request.getParameter("facility");
			System.out.println("facility ="+value);	
			
			String tq = request.getParameter("taluk"); 
			if(tq==null)
			{
				tq="0";
			}			
			System.out.println("taluk="+tq); */				
			
			String datefrom = request.getParameter("datefrom"); //get value from form
			if(datefrom == null)
			{
				datefrom = "01/10/2016";
			}
			System.out.println("date from before submit="+datefrom);			
			
			Date dateto2=sdf.parse(datefrom);
			Calendar c2 = Calendar.getInstance(); 
			c2.setTime(dateto2); 
			c2.add(Calendar.DATE, 6);
			dateto2 = c2.getTime();
			String dateto1=sdf.format(dateto2);
			System.out.println("date to + 7th day of date from ="+dateto1);
			
			String dateto = request.getParameter("dateto"); //get value from form			
			if(dateto == null)
			{
				dateto = dateto1;
			}
			else
			{
				Date dt2=(Date)sdf.parse(dateto);
				dateto=sdf.format(dt2);
			}
			System.out.println("date to from dropdown="+dateto);		
		%>         	  			
				
		<div class="container" align="center">		 
			<form action="normalization_redcap.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> Normalized Data </h1>
			<%-- <div class="form-group">
			<div id="filters2"></div>
			<script>
				var filterStr= DropdownFilterWithOnchange(talukFilter,"<%= tq%>");				
				filters2.innerHTML=filterStr;
			</script>
			 </div>		
				
			<div class="form-group">
				<div id="sf"><label style="font-size:20px; color:blue"> Facility:</label></div>
			</div> --%>
			
			 <div class="form-group">
				<label style="font-size:20px; color:blue"> DOB From: </label> 					
				<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
			</div>&nbsp;
			
			<div class="form-group">
				<label style="font-size:20px; color:blue"> DOB To:</label> 
				<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto1%>" disabled>				
			</div>	
			
			<!-- <!-- for store facility value -->			
			<!-- <input type="hidden" id="hiddenField" name="hiddenField"/>	 -->
			<br /> 
				<button type="submit" class="btn btn-primary">Submit</button>				
				<br /> 																				
			 </form>		 
		 </div>
		<%
			//response.setContentType("text/html");					
			try
			{	
				/* int kmcPeriod = 4;
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
			  	int taluks = Integer.parseInt(tq); */
			  	
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				System.out.println("mongo = "+mongo);
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection); 
				
				System.out.println("datefrom after convert="+datefrom);
				Date df = sdf.parse(datefrom);
			  	Date dt = sdf.parse(dateto1);
				System.out.println("Dtfrom="+datefrom+"Dtto="+dateto);
				SimpleDateFormat sdf_ddmm = new SimpleDateFormat("yyyy-MM-dd");
				String date_from = sdf_ddmm.format(df);
				String date_to = sdf_ddmm.format(dt);
				
				System.out.println("datefrom after convert into yyyy-MM-dd="+date_from);
			  	System.out.println("dateto after convert into yyyy-MM-dd="+date_to);
			  	
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
				//int facility = value==null?1:Integer.parseInt(value);
				//System.out.println("Facility in  jsp page ="+facility);
				ArrayList<DBObject> jsonArray = mongodao.dataNormalization(date_from, date_to);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
				System.out.println("Json array size ="+jsonArray.size());
				int count=0;				
				%>
				<div class="container">
				<div class="row">
				<button onclick="csv()">Download CSV</button>
				<div id="normalizedata from <%= datefrom%> to <%= dateto%>" class="exporttable table-responsive2">
				<table class="table table-bordered table-striped tableheader">	
					<thead>			
					<tr>	
						<th style="width:50px;text-align:center; word-wrap:break-word;"> SI. No. </th>				
						<th style="width:200px;text-align:center; word-wrap:break-word;"> Record_ID </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Pid1 </th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Mother Name </th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Husband Name </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> DOB</th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Time of Birth</th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Birth Weight</th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Sex</th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Status</th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Phone1 </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Phone2 </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Thayi_card No.</th>												
					</tr>
					</thead>
                </table>
                <div class="tablebody">
                <table id="mytable" class="table table-bordered table-striped">
                <tbody>
                <tr>		
				<% 				
				for(int i=0; i<jsonArray.size(); i++)
				{
					BasicDBObject data_obj = (BasicDBObject)jsonArray.get(i).get("data");
					
					if(data_obj.containsField("dob"))
					{
						bd.dob =data_obj.getString("dob");
					}
					else
						bd.dob = "-";
					if(data_obj.containsField("unique_id"))
					{
						bd.u_id = data_obj.getString("unique_id");
					}
					else
						bd.u_id = "-";
					if(data_obj.containsField("pid1"))
					{
						bd.pid1 = data_obj.get("pid1");
						if(bd.pid1 instanceof String)
						{
							bd.pid1 = data_obj.get("pid1");
						}
						else
						{
							bd.pid1 = data_obj.getInt("pid1");
						}						
						//System.out.println("pid1:"+bd.pid1);
					}
					else{
						bd.pid1 = "-";
					}
					
					if(data_obj.containsField("time_of_birth"))
					{
						bd.time_of_birth = data_obj.getString("time_of_birth");
					}
					else
						bd.time_of_birth = "-";
					//to ckeck whether the time is in 12hrs format									
					String time12hrs = tc.convert24To12Format((String)bd.time_of_birth);
					//System.out.println("time in 24hrs format = "+bd.time_of_birth);
					//System.out.println("time in 12hrs format = "+time12hrs);
					//System.out.println();
					bd.time_of_birth = time12hrs;									
					
					if(data_obj.containsField("thayi_card_no"))
					{
						bd.thayi_card_no = data_obj.getLong("thayi_card_no");
						//System.out.println("thayi_card_no:"+bd.thayi_card_no);
					}	
					else{
						bd.thayi_card_no ="-";
					}
					
					if(data_obj.containsField("baby_status"))
					{
						bd.baby_status = data_obj.getString("baby_status");
						String b_status=(String)bd.baby_status;
						if(b_status.equals("1"))
							bd.baby_status="Well";
						else if(b_status.equals("2"))
							bd.baby_status="Sick";
						else
							bd.baby_status="Dead";
					}
					else
						bd.baby_status = "-";
					
					if(data_obj.containsField("mother_name"))
					{
						bd.mother_name = data_obj.getString("mother_name");//getInt("epic");
					}
					else
						bd.mother_name = "-";
					
					if(data_obj.containsField("sex"))
					{
						bd.sex = data_obj.getString("sex");//getInt("epic");
						String sex1=(String)bd.sex;
						if (sex1.equals("1"))
							bd.sex="Male";
						else if(sex1.equals("2"))
							bd.sex="Female";
						else
							bd.sex="other";
					}
					else
						bd.sex = "-";
					
					if(data_obj.containsField("phone2"))
					{
						bd.phone2 = data_obj.getLong("phone2");
					}
					else
						bd.phone2 = "-";							
					
					if(data_obj.containsField("phone1"))
					{
						bd.phone1 = data_obj.getLong("phone1");
					}
					else
						bd.phone1 = "-";
					
					if(data_obj.containsField("uid"))
					{
						bd.uid = data_obj.get("uid");
						if(bd.uid instanceof String)
						{
							bd.uid = data_obj.get("uid");
						}
						else
						{
							bd.uid = data_obj.getInt("uid");
						}
						//System.out.println("uid:"+bd.u_id);
					}
					else{
						bd.uid ="-";
					}

					if(data_obj.containsField("birth_weight"))
					{
						bd.birth_weight = data_obj.getInt("birth_weight");
						//System.out.println("birth_weight:"+bd.birth_weight);
					}	
					else{
						bd.birth_weight="-";
					}
					
					if(data_obj.containsField("husband_name"))
					{
						bd.husband_name = data_obj.getString("husband_name");
					}
					else
						bd.husband_name = "-";
					
					%>
						<td style="width:50px;word-wrap:break-word;"><%= (++count)%></td>
						<td style="width:200px;word-wrap:break-word;"><%= bd.u_id%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.pid1%></td>
						<td style="width:150px;word-wrap:break-word;"><%= bd.mother_name%></td>
						<td style="width:150px;word-wrap:break-word;"><%= bd.husband_name%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.dob%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.time_of_birth%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.birth_weight%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.sex%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.baby_status%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.phone1%></td>
						<td style="width:100px;word-wrap:break-word;"><%= bd.phone2%></td>
						<td style="word-wrap:break-word;"><%= bd.thayi_card_no%></td>	
					</tr>				
					<%
				}
				%>
				
				</tbody>				
				</table>
				</div>
				</div>
				</div>
				</div>				
				<br />					
				<% 				
				
			}//close try block			
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
				e.printStackTrace();
			}				
		%>
		<%@include file="tableexport.jsp" %>
		<!-- script for adding alender for date field and disable dates lesser than datefrom-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
		
		<script>		
		var fromDate=document.getElementById("datefrom").value;
		//var toDate=document.getElementById("dateto").value;	
		//var seventhday = fromDate.setDate(fromDate.getDate()+6);
		//console.log(seventhday);
    	//console.log(fromDate);
		var date=new Date();
		date.setDate(date.getDate());			
		var pre = new Date("10/01/2016");
		$(document).ready(function()
						{
						    $( "#datefrom" ).datepicker({
						    	dateFormat: "dd/mm/yy" ,
						    	 numberOfMonths: 1,
									maxDate:date,
									minDate:pre,
					                onSelect: function (selected) 
					                {	                	
					                    var dt = new Date(selected);
					                    dt.setDate(dt.getDate() + 0);
					                    $("#dateto").datepicker("option", 'minDate', dt);
					                },
						        onClose: function() {
						            var date2 = $('#datefrom').datepicker('getDate');
						            date2.setDate(date2.getDate()+6)
						            $( "#dateto" ).datepicker("setDate", date2);
						        }
						    });						    
						    $( "#dateto" ).datepicker(
						    
						     {
						    	 dateFormat: "dd/mm/yy",
						    } 
						    		);
							}
		);
		</script>
	</body>
</html>