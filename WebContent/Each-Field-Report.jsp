<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	
	<title> Each-Field-Report </title>  	  	
  	<script src="facilities.js">	</script>
	<script src="ken_kmc_html.js"></script>
   	<link rel="stylesheet" type="text/css" href="Responsive_Style.css">  
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
				width: 1500px;
				margin-bottom:0px;
				border:1px solid #999;			
			}
			.tablebody {
				height: 450px;
				overflow-y: auto;
				width: 1500px;
				margin-bottom:20px;				
			}
		</style>
</head>
	<body>
		<%@ page import="java.sql.*" %>
		<%@page import="java.awt.List" %>
		<%@page import="com.mongodb.ServerAddress" %>
		<%@page import="com.mongodb.DBCursor" %>
		<%@page import="com.mongodb.DBObject" %>
		<%@page import="com.mongodb.BasicDBObject" %>
		<%@page import="com.mongodb.DBCollection" %>
		<%@page import="com.mongodb.DB" %>
		<%@page import="org.bson.types.ObjectId" %>
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
		<%@page import = "java.util.Date"%>
		<%@page import = "java.util.*"%>
		<%@page import="com.mongodb.util.JSON"%>
		<%@page import="org.json.*" %>
		<%@page import ="com.mongodb.BasicDBObjectBuilder" %>
		<%@include file="Config.jsp" %>
		<%-- <%@ include file="home.jsp"%> --%>
		
		<% 
			//set the values for the field as same as input give to form on submit (instead of default value on submit)
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			Date dt = new Date();
			String datefrom = request.getParameter("datefrom");
			System.out.println("from1-"+datefrom);
			if(datefrom == null)
			{
				datefrom = "01/10/2016";
			}
			
			String dateto = request.getParameter("dateto"); //get value from form
			System.out.println("fromto-"+dateto);
			if(dateto == null)
			{
				dateto = sdf.format(new Date());
			}
			else
			{
				Date dt2=(Date)sdf.parse(dateto);
				dateto=sdf.format(dt2);
			}			
		%>		
		<div class="container" align="center">		 
			<form action="Each-Field-Report.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> Each-Field-Report </h1>			
			 <div class="form-group">
				<label style="font-size:20px; color:blue"> Date From: </label> 					
				<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom %>" readonly>				
			</div>
			<div class="form-group">
				<label style="font-size:20px; color:blue"> Date To:</label> 
				<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto %>" readonly>				
			</div>			
			 <br /> 
				<button type="submit" class="btn btn-primary">Submit</button>				
				<br /><br /> 																					
			 </form>		 
		 </div>			
		<%			
		   response.setContentType("text/html");	
			try
			{		
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
				SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");				
				Date datef = (Date)sdf.parse(datefrom);
				String newdatefrom = sdf2.format(datef);	
				System.out.println("date from in dd/MM/yyyy format="+datefrom);
				System.out.println("date from after convert to date yyyy-MM-dd format="+newdatefrom);				
				
				Date datet = (Date)sdf.parse(dateto);
				String newdateto = sdf2.format(datet);
				System.out.println("date to in dd/MM/yyyy format="+dateto);
				System.out.println("date to after convert to date yyyy-MM-dd format="+newdateto);

				//Inc dateto to 1day past
			  	Date dt2=sdf.parse(dateto);
			  	Calendar c = Calendar.getInstance(); 
				c.setTime(dt2); 
				c.add(Calendar.DATE, 1);
				dt2 = c.getTime();
				dateto=sdf.format(dt2);
				int i=0;
				String ID = null;
				JSONObject obj = new JSONObject();
				JSONArray JsonArray = new JSONArray(); 
				//MongoClient mongoclient = (MongoClient) request.getServletContext().getAttribute("MONGO_CLIENT");
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				DB database = mongo.getDB(db);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);
				BasicDBObject object= new BasicDBObject();
				object.put("data.0.from1", new BasicDBObject("$gt", newdatefrom).append("$lt", newdateto));
				DBCursor cursor = collection.find(object);
				System.out.println("cursor size--"+cursor.size());
				String query = "[" +
						"  {" +
						"   $project:{" +
						"  facility:{$arrayElemAt:[\"$data\", 0]}," +
						"  data:{$arrayElemAt:[\"$data\", 1]}" +
						"  }}," +
						"  {$unwind:\"$data\"}," +
						"  {$unwind:\"$facility\"}," +
						"  {$match:{" +
						" \"facility.from1\":{$gte:'"+newdatefrom+"', $lte:'"+newdateto+"'}" +
						" }}" +
						"])" ;
			System.out.println("query--"+query);			
				java.util.List<DBObject> sq = (java.util.List<DBObject>)JSON.parse(query);
				 Iterable<DBObject> sr = collection.aggregate(sq).results();	
				 BasicDBObject spc;
				 Object sty=null;
				 int phone1 = 0;
				 int phone2 = 0;
				 int thayi_card_no = 0;
				 int phone1_lbw=0;
				 int phone2_lbw=0;
				 int uid=0;
				 int epic=0;
				 int totalbabies=0;
				 int totlbw=0;
				 int pid1=0;
				 int pid2=0;
				 int pidlbw1=0;
				 int pidlbw2=0;
				 for (DBObject sobj : sr)
				    {
					 totalbabies++;
				        //System.out.println(sobj);
				         spc = (BasicDBObject)sobj.get("data");
				        
				        	 if(spc.containsField("phone1")){
				        	 if(spc.get("phone1") != null){
				        		 phone1++;	 
				        	 } 
				            }
				        	 if(spc.containsField("phone1")){
					        	 if(spc.get("phone1") != null){
					        		 if(!spc.get("surveyType").equals("inborn_normal")){
					        			 phone1_lbw++;	 
					        		 }
					        	 } 
					            }
				        	if(spc.containsField("phone2")){
					        	 if(spc.get("phone2") != null){
					        		 phone2++;	 
					        	 } 
					         }
				        	if(spc.containsField("phone2")){
					        	 if(spc.get("phone2") != null){
					        		 if(!spc.get("surveyType").equals("inborn_normal")){
					        		 phone2_lbw++;	 
					        	 } 
					         }
				        	}
				        	if(spc.containsField("uid")){
					        	 if(spc.get("uid") != null){
					        		 uid++;	 
					        	 } 
					         }
				        	if(spc.containsField("epic")){
					        	 if(spc.get("epic") != null){
					        		 epic++;	 
					        	 } 
					         }
				        	if(spc.containsField("thayi_card_no")){
					        	 if(spc.get("thayi_card_no") != null){
					        		 thayi_card_no++;	 
					        	 } 
					         }
				        	
				        	if(spc.containsField("surveyType")){
					        	 if(!spc.get("surveyType").equals("inborn_normal")){
					        		 totlbw++;	 
					        	 } 
					         }
				        	if(spc.containsField("pid1")){
					        	 if(spc.get("pid1")!=null){
					        		 pid1++;	 
					        	 } 
					         }
				        	if(spc.containsField("pid1")){
					        	 if(spc.get("pid1")!=null){
					        	   if(!spc.get("surveyType").equals("inborn_normal")){
					        		 pidlbw1++;	 
					        	 } 
					         }
				        	}
				        	if(spc.containsField("pid2") || spc.containsField("question1") )
				        	{
					        	 if(spc.get("pid2")!=null || spc.get("question1")!=null)
					        	 {
					        		 pid2++;	 
					        	 } 
					         }
				        	if(spc.containsField("pid2") || spc.containsField("question1"))
				        	{
					        	 if(spc.get("question1")!=null || spc.get("pid2")!=null)
					        	 {
					        	   if(!spc.get("surveyType").equals("inborn_normal")){
					        		 pidlbw2++;	 					        		 
					        	 } 
					         }
				        	}
				        	 
				      }
				   
				 System.out.println("--pid1--"+pid1+"--pid2--"+pid2+"--lbw--"+totlbw+"--totalbabies--"+totalbabies+"--Phone1--"+phone1+"--Phone2--"+phone2+"--tayicard--"+thayi_card_no+"--phone1(lbw)--"+phone1_lbw+"--Epic--"+epic+"--uid--"+uid);
				
				 
				%>
				<div class="container">
				<div id="Each-Field-Report" class="exporttable row">
		     	<div class="table-responsive2">
                <table class="table table-bordered table-striped tableheader">
                <thead>
                <tr>				
					<th	style="text-align:center;width:90px">TotalBabies</th>
					<th style="text-align:center;width:90px"> Total (lbw) </th>
					<th style="text-align:center;width:90px"> Pid1 </th>
					<th style="text-align:center;width:90px"> Pid1 (lbw) </th>
					<th style="text-align:center;width:90px"> Pid2 </th>
					<th style="text-align:center;width:90px"> Pid2 (lbw) </th>
					<th style="text-align:center;width:90px"> Phone1 </th>
					<th style="text-align:center;width:90px"> Phone1 (lbw) </th>
					<th style="text-align:center;width:90px"> Phone2 </th>
					<th style="text-align:center;width:90px"> Phone2 (lbw) </th>
					<th style="text-align:center;width:90px"> Thayi card no (lbw) </th>
					<th style="text-align:center;width:90px"> Uid (lbw)</th>
					<th style="text-align:center;width:90px"> Epic (lbw)</th>
					
				</tr>				                    
                </thead>
                <tbody style="height:50px;">
				<tr>
					<td style="text-align:center;width:90px"><%=totalbabies%></td>
					<td style="text-align:center;width:90px"><%= totlbw %></td>
					<td style="text-align:center;width:90px"><%= pid1 %></td>
					<td style="text-align:center;width:90px"><%= pidlbw1 %></td>
					<td style="text-align:center;width:90px"><%= pid2 %></td>
					<td style="text-align:center;width:90px"><%= pidlbw2 %></td>
				   	<td style="text-align:center;width:90px"><%=phone1%></td>	
				  	<td style="text-align:center;width:90px"><%=phone1_lbw%></td>	
					<td style="text-align:center;width:90px"><%=phone2%></td>
					<td style="text-align:center;width:90px"><%= phone2_lbw %></td>
					<td style="text-align:center;width:90px"><%=thayi_card_no%></td>
					<td style="text-align:center;width:90px"><%= uid%></td>
					<td style="text-align:center;width:90px"><%=epic %></td>	
					
				</tr> </tbody> </table></div>				
		     	<div class="table-responsive2">
                <table class="table table-bordered table-striped tableheader">
                <thead>
                <tr>	
					<th style="text-align:center;width:100px"> SL.NO </th>
					<th style="text-align:center;width:200px"> Thayi_card_no </th>
					<th style="text-align:center;width:200px"> Phone1 </th>
					<th style="text-align:center;width:200px"> Phone2 </th>
					<th style="text-align:center;width:200px"> Pid1 </th>
					<th style="text-align:center;width:200px"> Pid2 </th>
					<th style="text-align:center;width:200px"> Uid </th>
					<th style="text-align:center;width:200px"> Epic </th>
							</tr>                    
                </thead>
                </table>
				<div class="tablebody">
                <table class="table table-bordered table-striped" >
                <tbody>	
				<% 
				int count=0;
				if(cursor.size() != 0)					
				{
					while(cursor.hasNext())
					{
						DBObject dbo = cursor.next();
						BasicDBList List = (BasicDBList)dbo.get("data");
						DBObject data0 =(DBObject)List.get(0);
						BasicDBList data1 = (BasicDBList)List.get(1);
						ID = dbo.get("_id").toString();
						long time = Long.parseLong(ID.substring(0,8),16)*1000;							
						String timestamp = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new Date(time));
						//System.out.println("ddata1::"+data1);
						for(int p = 0;p < data1.size() ;p++)
						{
							BasicDBObject Array = (BasicDBObject) data1.get(p);	
							if(Array.containsField("thayi_card_no"))
						    {
						    	bd.thayi_card_no = Array.getLong("thayi_card_no");
						    	//System.out.println("epic::"+bd.thayi_card_no);
						    }
							else{
								bd.thayi_card_no ="-";
							}
							if(Array.containsField("phone2"))
							{
							 	bd.phone2 = Array.getLong("phone2");
							 	//System.out.println("epic::"+bd.phone2);
							}	
							else{
								bd.phone2 ="-";
							}
							if(Array.containsField("epic"))
							{
							 	bd.epic = Array.get("epic");
							 	if(bd.epic instanceof String)
								{
									bd.epic = Array.get("epic");
								}
								else
								{	
									bd.epic = Array.getInt("epic");
								}
							 	
							}
							else{
								bd.epic ="-";
							}
							if(Array.containsField("phone1"))
							{
								bd.phone1 = Array.getLong("phone1");
								//System.out.println("epic::"+bd.phone1);
							}
							else{
								bd.phone1 = "-";
							}
							if(Array.containsField("uid"))
							{
							   	bd.uid = Array.get("uid");
							   	if(bd.uid instanceof String)
								{
									bd.uid = Array.get("uid");
								}
								else
								{
									bd.uid = Array.getInt("uid");
								}
							   	//System.out.println("epic::"+bd.uid);
							}
							else
							{
								bd.uid ="-";
							}
							if(Array.containsField("pid1"))
							{
							   	bd.pid1 = Array.get("pid1");
							   	if(bd.pid1 instanceof String)
								{
									bd.pid1 = Array.get("pid1");
								}
								else
								{
									bd.pid1 = Array.getInt("pid1");
								}
							   	
							}
							else
							{
								bd.pid1 ="-";
							}
							if(Array.containsField("pid2"))
							{
							   	bd.pid2 = Array.get("pid2");
							   	if(bd.pid2 instanceof String)
								{
									bd.pid2 = Array.get("pid2");
								}
								else
								{
									bd.pid2 = Array.getInt("pid2");
								}
							 
							}
							else
							{
								bd.pid2 ="-";
							}
							%>							
							<tr>
									<td style="width:100px"><%= ++count %> </td>
								   	<td style="width:200px"><%= bd.thayi_card_no %></td>
								   	<td style="width:200px"><%= bd.phone1%></td>							    	
									<td style="width:200px"><%= bd.phone2 %></td>
									<td style="width:200px"><%= bd.pid1 %></td>
									<td style="width:200px"><%= bd.pid2 %></td>
									<td style="width:200px"><%= bd.uid %></td>
									<td style=""><%= bd.epic %></td>
							</tr>
							<% 
						}//data1 for loop						
					}//while loop
					%>
						<tr> <td colspan="6"> <h4 style="color:red;text-align:left;"> ----End of Records---- </h4></td></tr>
					<%
				}//if close
				else
				{
					%>
						<tr> <td colspan="6"> <h4 style="color:red;text-align:left;"> No Records </h4></td></tr>
					<%
				}
				%>
				</tbody>
				</table>
				</div>
				</div></div>
				</div>					
				<%            
			}		
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
			}				
		%>
		<%@include file="tableexport.jsp" %>
		<!-- script for adding alender for date field and disable dates lesser than datefrom-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
		<script type="text/javascript">	
			$(document).ready(function () 
			{				  
			    var pre = new Date("10/01/2016");
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