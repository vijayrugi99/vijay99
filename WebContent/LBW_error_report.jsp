<%@page import="com.mongodb.util.JSON"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Comparison Details </title>  		
  		<script src="facilities.js">	</script>
		<script src="ken_kmc_html.js"></script>	
		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
		 <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
			width: 1160px;
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
		<%@page import = "com.mongodb.util.JSON"%>
		<%@page import = "java.util.Date"%>
		<%@page import = "java.util.Calendar"%>	
		<%@ include file="Config.jsp" %>
		<%-- <%@ include file="home.jsp"%> --%>
		
		 <% 
			//jsp logic to set the values for the field as same as input give to form on submit (instead of default value on submit)
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); //date format		
			
			//logic to increment one day from today's date
			Date dt = new Date();
			/* Calendar c = Calendar.getInstance(); 
			c.setTime(dt); 
			c.add(Calendar.DATE, 1);
			dt = c.getTime(); */
			
			String datefrom = request.getParameter("datefrom"); //get value from form
			if(datefrom == null)
			{
				datefrom = "01/10/2016";
			}
			System.out.println("date from before submit="+datefrom);
			
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
			System.out.println("date to before submit="+dateto);
		%>		
			
		<!-- HTML form -->
		<div class="container" align="center">		 
		<form action="LBW_error_report.jsp" method="POST" class="form-inline">
		<h1 style = "color:brown"> Comparison Details  </h1>
		<div class="form-group">							
			<label style="font-size:20px;color:blue;"> Date From: </label> 					
			<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom %>" readonly>
		</div>	&nbsp;	
		<div class="form-group">
			<label style="font-size:20px;color:blue;"> Date To:</label> 
			<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto %>" readonly>
		</div>
		<br />		 
		<button type="submit" class="btn btn-primary">Submit</button>				
		<br /><br />		 																					
		</form>		 
		</div>				
		<%
			response.setContentType("text/html");
		int compare = 0;
			try
			{	
				String jspname = "LBW_error_report.jsp";											
				
				//Inc dateto to 1day past
			  	Date dt2=sdf.parse(dateto);
			  	Calendar c = Calendar.getInstance(); 
				c.setTime(dt2); 
				c.add(Calendar.DATE, 1);
				dt2 = c.getTime();
				dateto=sdf.format(dt2);
			  	System.out.println("dateto after inc by 1 ="+dateto);
			  	
			  	//convert date to id
			  	ObjectId obFrom = new ObjectId(sdf.parse(datefrom));     
				ObjectId obTo = new ObjectId(sdf.parse(dateto));
				System.out.println("datefrom in id=="+obFrom);			 	
				System.out.println("dateto in id=="+obTo);				
				
				//get connection to mongodb	
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();					
				
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection);				
				
				//query for aggregate
				String str = "[{$project:{outbornlbws:{$size:{$filter:{input: {$arrayElemAt: [\"$data\",1]},as: \"outbornlbw\",cond:{$eq:[\"$$outbornlbw.surveyType\",\"outborn_lbw\"]}}}},inbornlbws:{$size:{$filter:{input:{$arrayElemAt:[\"$data\",1]},as:\"inbornlbw\",cond:{$eq:[\"$$inbornlbw.surveyType\",\"inborn_lbw\"]}}}},inbornormal:{$size:{$filter:{input:{$arrayElemAt:[\"$data\",1]},as:\"inbornnormal\",cond:{$eq:[\"$$inbornnormal.surveyType\",\"inborn_normal\"]}}}},TotalExpected:{$arrayElemAt: [\"$data\",0]}}},{$project:{outbornlbws:1,no_below_2000:\"$TotalExpected.no_below_2000\", no_of_ob_lbws:\"$TotalExpected.no_of_ob_lbws\",inbornlbws:1,cpin_lbw:{$cmp:[\"$TotalExpected.no_below_2000\",\"$inbornlbws\"]},cpin_outlbw:{$cmp:[\"$TotalExpected.no_of_ob_lbws\",\"$outbornlbws\"]}}},{$match: {$or:[{cpin_lbw:{\"$ne\":0}},{$and:[{\"no_of_ob_lbws\":{$exists:true}},{cpin_outlbw:{\"$ne\":0}}]}]}}]);]";
	    			java.util.List<DBObject> list = (java.util.List<DBObject>)JSON.parse(str);	    		
				Iterable<DBObject> output = collection.aggregate(list).results();
				//System.out.println("No of comparison objects ="+list.size());
				//query for date filter
				BasicDBObject dateQuery = new BasicDBObject("_id", new BasicDBObject("$gt",obFrom).append("$lt",obTo));
				DBCursor cursor = collection.find(dateQuery); 
				System.out.println("Size of output:"+cursor.size());				
				%>
													
				<!-- create table and header for the table -->
			 	<div class="container">
				<div class="row">
		     	        <div id="LBW_error_report" class="exporttable table-responsive2">
                                <table class="table table-bordered table-striped tableheader">
                                <thead>
                                <tr>
					<th style="width:100px; text-align:center;"> Sl. No.</th>
					<th style="width:200px; text-align:center;"> Date </th>
					<th style="width:210px; text-align:center;"> Object id </th>					
					<th style="width:100px; text-align:center;"> No below 2000 </th>				
					<th style="width:100px; text-align:center;"> Inborn Lbws </th>
					<th style="width:100px; text-align:center;"> Compare Invalue </th>
					<th style="width:100px; text-align:center;"> No of ob lbws </th>					
					<th style="width:100px; text-align:center;"> Outborn Lbws </th>
					<th style="text-align:center;"> Compare Outvalue </th>
				</tr>
			        </thead>
                                </table>
                                <div class="tablebody">
                                <table class="table table-bordered table-striped">
                                <tbody>
				<%
						
						int count = 0;
						//iterate to date filter objects
						while(cursor.hasNext())
						{							
							//get date objects
							DBObject dbobj = cursor.next();								
							//get objectID of date object
							ObjectId date_objid = (ObjectId) dbobj.get("_id");
							//System.out.println("Each date objects id are = " + date_objid);
							//iterate to compare objects
							for (DBObject dbObject : output)
							{																
								ObjectId compare_objid = (ObjectId) dbObject.get("_id");
								BasicDBObject bDB = (BasicDBObject)dbObject;
								//System.out.println("Each compare objects id are = " + compare_objid);								
								if(compare_objid.equals(date_objid))
								{									
									++compare;										
									//System.out.println("Each date objects id are = " + date_objid);
									//System.out.println("Each compare objects id are = " + compare_objid);
									bd.no_below_2000 = dbObject.get("no_below_2000");
									if(bd.no_below_2000 instanceof String)
									{
										bd.no_below_2000 = bDB.get("no_below_2000");
									}
									else
									{
										bd.no_below_2000 = bDB.getInt("no_below_2000");
									}
									Object inbornlbws = dbObject.get("inbornlbws");
									Object cpin_lbw = dbObject.get("cpin_lbw");
									//Object no_ob_lbws = "-";	//null if object not exits				
									//check whether no_of_ob_lbws is there in data.0 object or not (because it is added later)
									if(dbObject.containsField("no_of_ob_lbws"))
									{
										bd.no_of_ob_lbws = bDB.get("no_of_ob_lbws");
										if(bd.no_of_ob_lbws instanceof String)
										{
											bd.no_of_ob_lbws = bDB.get("no_of_ob_lbws");
										}
										else
										{
											bd.no_of_ob_lbws = bDB.getInt("no_of_ob_lbws");
										}
									}
									else
									{
										bd.no_of_ob_lbws = "-";
									}
									Object outbornlbws = dbObject.get("outbornlbws");
									Object cpin_outlbw = dbObject.get("cpin_outlbw");
									//convert ObjectID into date format
									Date enterDate = compare_objid.getDate();
									SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:ss:mm a");
									java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
									sdf1.setTimeZone(tz);
									String formatDate = sdf1.format(enterDate);
									//System.out.println("Formatted object entered date = " +formatDate);									
									if(bd.no_below_2000 != inbornlbws)
									{
									%>									
									<tr>
										<td id="<%= count%>" style="width:100px"><%= (++count)%></td>
										<td style="width:200px"><%= formatDate%></td>
										<td style="width:210px"><%= compare_objid%>
										<button class="btn btn-warning" onclick= "window.location.href='LBW_Error_ObjDetails.jsp?filename=<%= jspname%>&id=<%= compare_objid%>&count=<%= count%>'"> Delete </button> 
										</td>							   			    	
										<td style="width:100px"><%= bd.no_below_2000%></td>
										<td style="width:100px"><%= inbornlbws%></td>
										<td style="width:100px"><%= cpin_lbw%></td>	
									<%		
									}									
									//if both compare value is zero print --
									else
									{
									%>
									<tr>
										<td id="<%= count%>" style="width:100px"><%= (++count)%></td>
										<td style="width:200px"><%= formatDate%></td>
										<td style="width:210px"><%= compare_objid%>
										<button class="btn btn-warning" onclick= "window.location.href='LBW_Error_ObjDetails.jsp?filename=<%= jspname%>&id=<%= compare_objid%>&count=<%= count%>'"> Delete </button> 
										</td>
										<td style="width:100px">--</td>
										<td style="width:100px">--</td>
										<td style="width:100px">--</td>
									<%
									}
									%>
										<td style="width:100px"><%= bd.no_of_ob_lbws%></td>
										<td style="width:100px"><%= outbornlbws%></td>
										<td style=""><%= cpin_outlbw%></td>
						    		</tr> 
						    		<%
								}//close if of comaprison of objects								
							}//close for loop
						}//close while loop						
						System.out.println("Comaprison count = "+compare);
						if(compare == 0)
						{
							%>
							<tr> <td colspan="9"><b> No Records </b></td></tr>
							<%
						}	
						if(compare>0)
						{
							%>
							<tr> <td colspan="9" style="color:red;text-align:left"><b> -----End of Records----- </b></td></tr>
							<%
						}
						%>
						</tbody>
						</table>
						</div></div></div></div>											
						<%						
			}//close try block			
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
				e.printStackTrace();
			}	
			System.out.println("Compare value out side try="+compare);
			
		%>
			<script>var value = "<%=compare%>";
			// Get saved data from sessionStorage	
		window.onload = function()
		{
			var data = sessionStorage.getItem('key');
			if(value==data)
			data=data-1;     
			var row = document.getElementById(data);
			row.scrollIntoView(false);			
			// Remove saved data from sessionStorage
			sessionStorage.removeItem('key');
			// Remove all saved data from sessionStorage
			sessionStorage.clear();
		}
		</script>
		
		
		
		<%@include file="tableexport.jsp" %>
		<!-- script for adding alender for date field and disable dates lesser than datefrom-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
		<script type="text/javascript">	
		$(document).ready(function () 
				{				  
				    var pre = new Date("01/10/2016");
					var date=new Date();				
					date.setDate(date.getDate());
					var fromDate=document.getElementById("datefrom").value;
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
								date.setDate( date.getDate() + 1 );        
								var newDate = date.toDateString(); 
								newDate = new Date( Date.parse( newDate ) );                      
								$('#dateto').datepicker("option","minDate",newDate);            
				        }
				    });	
				});
		</script>	
	</body>
</html>