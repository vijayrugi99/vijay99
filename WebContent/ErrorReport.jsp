
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
	<title>Error Records </title>
	<script src="facilities.js"></script>
	<script src="ken_kmc_html.js"></script>
	<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
	<style type="text/css">
		.well {
		    background: none;
		    height: 320px;
		}	
		.table>thead>tr>th{text-align:center;}				
	</style>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
	<body >
		<%@ page import="java.sql.*" %>
				<%@ page import="java.util.*" %>
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
		<%@page import = "java.util.Date"%>
		<%@include file="Config.jsp" %>
		<%@ include file="home.jsp" %>		
		<%
		 /*String user1 = session.getAttribute("username").toString();
        	if(user1 == null) 
        	{
        		response.sendRedirect(request.getContextPath() + "/login.jsp");
        	} */
		String value = request.getParameter("facility");
		%>
		<h1 style="text-align:center;color:brown">Error Report</h1>		
		<%		  		    
		   
		   
			String ID = null;
			com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
			//MongoClient mongoclient = (MongoClient) request.getServletContext().getAttribute("MONGO_CLIENT");
			MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
			DB database = mongo.getDB(db);
			System.out.println("Connected to daabase sucessfully...");
			DBCollection collection = database.getCollection(coll);
			DBCursor cursor = collection.find();
			//System.out.println("cursor size="+cursor.size());
			int count=1;
			int listcount=0;
			BasicDBList List=null;
			%>
			<div class="container">				
			<div class="panel-body">				
			<div class="table-responsive">				  
			<table id="ErrorReport" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th> SL.NO </th>
					<th>OBJECT-ID </th>
					<th>CREATED-DATE</th>
					<th>RECORD-DETAILS</th>
				</tr>
			</thead>
			<tbody>
			<%
			if(cursor.size() > 0)
			{
				while(cursor.hasNext())
				{
					DBObject dbo = cursor.next();
					List = (BasicDBList)dbo.get("data");
					DBObject data0 =(DBObject)List.get(0);
					BasicDBList data1 = (BasicDBList)List.get(1);
					int size = data1.size();
					//System.out.println("data1 size::"+size);
					ID = dbo.get("_id").toString();
					//String ID1 = (String)ID;
					//System.out.println("ID:"+ID);	
					//System.out.println("list size ="+List.size());
						if(List.size() > 2)
						{
							++listcount;
							int length = List.size();
							System.out.println("length of Object ob::"+length);
					  	    System.out.println("oid"+ID);
							long time = Long.parseLong(ID.substring(0,8),16)*1000;							
							SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
							java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
							sdf1.setTimeZone(tz);		
							String timestamp = sdf1.format(new Date(time));
							//System.out.println("Timestamp::"+timestamp);
							%>
							<tr>
								<td><%= count++ %></td>
								<td><%=  ID %></td>
								<td><%= timestamp %></td>
								<td><%= data1 %></td>
							</tr>
							<% 
						}						
				}				
			}
			if(listcount==0)
			{
				%>
					<tr> <td colspan="4"> <h4 style="color:red;text-align:left;">No records</h4> </td></tr>
				<%
			}
			%>
			</tbody>
			</table>
			</div>
			</div>
			</div>			
</body>
</html>

