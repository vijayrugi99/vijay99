<!DOCTYPE html>
<html>
<head>
    <title> Call Status </title>
	<script src="facilities.js">	</script>
	<script src="koppal_villages.js"></script>
	<script src="communityWorkers.js"></script>
	<script src="ken_kmc_html.js"></script>
	<link rel="stylesheet" href="Responsive_Style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="snackbar.css">
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
		.table-responsive table{
			table-layout: auto;
		}
		.tableheader {
			width: 1150px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 500px;
			overflow-y: auto;
			width: 1165px;
			margin-bottom:20px;
		}		
   </style>         
</head>
<body>
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
	
	<% String value = request.getParameter("facility");
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		//logic to decrement one month from current month
		Date dt = new Date();
		//current date - one month 
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1);
		Date result = cal.getTime();
		//System.out.println("Before one month date ="+result);
		int kmcPeriod=0;
		if(request.getParameter("kmcPeriod")!=null)
		{				
			kmcPeriod=Integer.parseInt(request.getParameter("kmcPeriod"));
		}
		else
		{
			kmcPeriod=2;
		}
		
		String datefrom = request.getParameter("datefrom"); //get value from form
		if(datefrom == null)
		{
			datefrom = sdf.format(result);
		}
		//System.out.println("date from in mm/dd/yyyy="+datefrom);			
		
		String dateto = request.getParameter("dateto"); //get value from form
		if(dateto == null)
		{
			dateto = sdf.format(new Date());
		}
		else
		{
			Date dt2=(Date)sdf.parse(dateto);
			dateto=sdf.format(dt2);
		}
		//System.out.println("date to in mm/dd/yyyy="+dateto);
	%>		
		<div class="container" align="center">		 
			<form action="callstatus_allbabies.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> LBW Babies Call Status </h1>
			<div class="form-group">							
			<!-- obtain the value from js file into dropdown list-->	
				<div id="filters"></div>
				<script>
					var filterStr= DropdownFilter(facilityFilter,"<%= value%>");							
					filters.innerHTML=filterStr;
				</script>
			 </div>	
			 <div class="form-group">
				<label style="font-size:20px; color:blue"> DOB From: </label> 					
				<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
			</div>
			<div class="form-group">
				<label style="font-size:20px; color:blue"> DOB To:</label> 
				<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto%>" readonly>				
			</div>
			<div class="form-group">
			<div id="filters2"></div>
			<script>
				var filterStr= DropdownFilter(kmcPeriodFilter,"<%=kmcPeriod%>");
				filters2.innerHTML=filterStr;
			</script>
		 	</div>			
				<button type="submit" class="btn btn-primary">Submit</button>				
				<br /> 																					
			 </form>		 
		 </div>			
		<%
			response.setContentType("text/html");	
			try
			{				
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();				
				DB database = mongo.getDB(db);
				DBCollection collection = database.getCollection(coll);						
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
				int facility = value==null?1:Integer.parseInt(value);
				System.out.println("facility ="+value);
				
				//date in yyyy-MM-dd format for comparing with period
			  	SimpleDateFormat sdf_ddmm = new SimpleDateFormat("yyyy-MM-dd");
			  	Date df = new Date(datefrom);
			  	Date dto = new Date(dateto);
			  	String date_from = sdf_ddmm.format(df);
			  	String date_to = sdf_ddmm.format(dto);
			  	System.out.println("datefrom after convert into yyyy-mm-dd="+date_from);
			  	System.out.println("dateto after convert into yyyy-mm-dd="+date_to);
			  	
				ArrayList<DBObject> jsonArray = mongodao.callstatus_allbabies(facility, kmcPeriod, date_from, date_to);
				System.out.println("Total call success babies ="+jsonArray.size());
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();			
			  	
				int count=0;
				int json_size = jsonArray.size();
				String success_status=null;
				%>
				<div class="container">
				<div class="row">
				<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= json_size%> </b> </h4>
				<div id="call Success babies" class="table-responsive2">
				<table class="table table-bordered table-striped tableheader">
				<thead>
					<tr>
						<th style="width:50px;text-align:center; word-wrap:break-word;"> SI. No. </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Facility </th>
						<th style="width:200px;text-align:center; word-wrap:break-word;"> Period </th>
						<th style="width:200px;text-align:center; word-wrap:break-word;"> Unique ID</th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Mother Name</th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Father Name</th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> DOB </th>
						<th style="width:200px;text-align:center; word-wrap:break-word;"> Call Status </th>
					</tr>
				</thead>
				</table>
                    <div class="tablebody">
                      <table class="table table-bordered table-striped" >
                        <tbody>
					<tr>
						<%
						if(jsonArray.size() > 0)
						{
							for(int i=0; i<jsonArray.size(); i++)
							{
								DBObject obj = jsonArray.get(i);
								//System.out.println("Obj = "+obj);
								
								BasicDBObject facilityData = (BasicDBObject)obj.get("facility");
								//System.out.println("facility data = "+facilityData);
								bd.facility=facilityData.getInt("facility");
								if(facilityData.containsField("from_date"))
								{
									bd.from_date = facilityData.get("from_date");
								}
								else
								{
									bd.from_date = "-";
								}
								if(facilityData.containsField("to_date"))
								{
									bd.to_date = facilityData.get("to_date");
								}
								else
								{
									bd.to_date = "-";
								}
						
								BasicDBObject data = (BasicDBObject)obj.get("data");
								//System.out.println("facility data = "+facility_data);								
								bd.dob = data.get("dob1");
								bd.mother_name = data.get("mother_name");
								bd.husband_name = data.get("husband_name");
								bd.u_id = data.get("unique_id");
								//System.out.println("unique_id ="+bd.u_id);
								//System.out.println();
								
								BasicDBList compobj_data = (BasicDBList)obj.get("comp_docs");
								for(int k=0; k<compobj_data.size(); k++)
								{
									BasicDBObject comp_obj = (BasicDBObject)compobj_data.get(k);
																	
									if(comp_obj.containsField("visit_date"))
									{										
										bd.kmc_period = comp_obj.get("kmc_period");	
										int success_period = Integer.parseInt((String)bd.kmc_period);
										/* System.out.println("kmc period from dropdown ="+kmcPeriod);
										System.out.println("success on kmc period ="+bd.kmc_period);
										System.out.println(); */
										if(success_period==kmcPeriod)
										{
											success_status="successful";
										}										
									}
									else
									{
										success_status="unsuccessful";
									}
								}
								%>
									<td style="width:50px;"> <%= (++count)%> </td>
									<td style="width:100px;"> <%= bd.facility%> </td>
									<td style="width:200px;word-wrap:break-word;"> <%= bd.from_date%> to <%= bd.to_date %> </td>
									<td style="width:200px;word-wrap:break-word;"> <%= bd.u_id%> </td>									
									<td style="width:150px;word-wrap:break-word;"> <%= bd.mother_name%> </td>
									<td style="width:150px;word-wrap:break-word;"> <%= bd.husband_name%> </td>
									<td style="width:100px;word-wrap:break-word;"> <%= bd.dob%> </td>										
									<td style="color:red;word-wrap:break-word;"> <%= success_status%> <br />
									<button class="btn btn-info btn-sm" style="color:black" onclick="window.location.href='success_details.jsp?baby=<%=data.get("unique_id")%>'"> Success Details </button>
									<br /><br /><button class="btn btn-info btn-sm" style="color:black" onclick="window.location.href='CallDetails.jsp?baby=<%=data.get("unique_id")%>'"> Failure Details </button>	
									</td>																		
								</tr>
								<%
							}							
						}
						else
						{
							%>
								<tr> <td colspan=8> <h4 style="text-align:left;color:red;">No details</h4> </td></tr>
							<% 
						}
						%>					
				</tbody>
				</table>				
				</div>
				</div>
				</div>
				</div>
				<%				
			}
			catch(Exception e)
			{
				System.out.println(e);				
			}
		%>		
		<%@include file="tableexport.jsp" %>		
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
		<script type="text/javascript">	
			var fromDate=document.getElementById("datefrom").value;
        	//console.log(fromDate);
			var date=new Date();
			date.setDate(date.getDate());			
			var pre = new Date("10/01/2016");			
			//console.log(pre);		
	        $("#datefrom").datepicker({
	                numberOfMonths: 1,
					maxDate:date,
					minDate:pre,
	                onSelect: function (selected) 
	                {	                	
	                    var dt = new Date(selected);
	                    dt.setDate(dt.getDate() + 0);
	                    $("#dateto").datepicker("option", 'minDate', dt);
	                }
	            });
				
	            $("#dateto").datepicker({
	                numberOfMonths: 1,				
					maxDate:date,
					minDate:fromDate,				
	                onSelect: function (selected) 
					{		                	
	                    var dt = new Date(selected);
	                    //var fromDate=document.getElementById("datefrom");
	                    //console.log(dt);//selected date from calender
	                    dt.setDate(dt.getDate() - 1);	                    
	                    $("#datefrom").datepicker("option", 'maxDate','minDate', dt);	                    
	                }	            	
	            });  
		</script>	
</body>  
</html>  