<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta charset="utf-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  		<script src="facilities.js">	</script>
		<script src="ken_kmc_html.js"></script>
		<title> Date Error Report </title>		
		 <!-- style for excel sheet  -->
		<style>
			table,th,td{ 	
					font-family:verdana; 
					font-size:10pt;
					text-align:center; 
					border-collapse:collapse; 
					border:1px solid black; 
					padding:3px;
				}
		</style>		
		<link rel="stylesheet" type="text/css" href="Reports_Stylesheet.css">
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
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>
      
		<center>
       		<div id="ctrls"></div>
      		<script>
      			ctrls.innerHTML=ExportToexcel("DateError_Records.jsp","DateError_Records.xls",<%=request.getParameter("hideCtrls")!=null%>)
       		</script>
        </center>
		
		<form action="DateError.jsp" method="POST" style = "text-align:center; margin-top:20px">
			<h1 style = "color:brown"> Date Error Records </h1>				
			<br />																														
		</form>
		
		<%
			//response.setContentType("text/html");					
			try
			{				
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				System.out.println("mongo = "+mongo);
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection); 				
				
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
				String query = "[{$project:{"+
						"\"_id\":\"$_id\","+
						"facility:{$arrayElemAt:[\"$data\", 0]},"+ 
						"data:{$arrayElemAt:[\"$data\",1]}"+
						"}},"+            						
						"{$project:{facility:\"$facility\", data:\"$data\","+
						"from_date:\"$facility.from1\", "+
						"to_date:\"$facility.to1\", "+
						"cpin_lbw:{$cmp:[\"$facility.from1\", \"$facility.to1\"]}"+
						"}"+
						"},"+
						"{$match:{from_date:{$exists:true},to_date:{$exists:true},cpin_lbw:{$ne:-1}"+						
						"}}]";
				
				ArrayList<DBObject> jsonArray = mongodao.executeQuery(query);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int count=0;
				%>
				<center>
				<table width=1000>				
					<tr style = "color:brown;">
						<th width=30> SI. No. </th>
						<th width=30> Object_ID </th>
						<th width=100> Period </th>
						<th width=50> Facility </th>
						<th width=100> Unique_ID </th>
						<th width=100> DOB </th>
						<th width=75> Mother_Name </th>
						<th width=75> Husband_Name </th>
						<th width=100> Operation </th>									
					</tr>				
				<% 					
				System.out.println("jsonArray size = "+jsonArray.size());				
				for(int i=0; i<jsonArray.size(); i++)
				{
					System.out.println("DBObjects are ="+jsonArray.get(i));
					ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
					System.out.println("Objet id are ="+objid);
					
					BasicDBObject facilityData = (BasicDBObject)jsonArray.get(i).get("facility");
					bd.facility = facilityData.getInt("facility");
					System.out.println("facility ="+bd.facility);
					
					bd.from_date = facilityData.get("from_date");					
					bd.to_date = facilityData.get("to_date");
					
					BasicDBList data = (BasicDBList)jsonArray.get(i).get("data");
					System.out.println("data size = "+data.size());
					%>
						<tr>
							<td rowspan = <%= data.size()%>> <%= (++count)%> </td>
							<td rowspan = <%= data.size()%>> <%= objid%></td>
							<td rowspan = <%= data.size()%> style="color:red"> <%= bd.from_date%> to <%= bd.to_date%> </td>
							<td rowspan = <%= data.size()%>> <%= bd.facility%> </td>					
					<%	
					int k = 0;
					for(k=0; k<data.size(); k++)
					{
						//System.out.println("data at "+k+" ="+data.get(k));
						BasicDBObject dataObj = (BasicDBObject)data.get(k);
						bd.u_id = dataObj.get("unique_id");
						bd.dob = dataObj.get("dob1");
						bd.mother_name = dataObj.get("mother_name");
						bd.husband_name = dataObj.get("husband_name");
						%>
						<td> <%= bd.u_id%> </td>
						<td> <%= bd.dob%> </td>
						<td> <%= bd.mother_name%> </td>
						<td> <%= bd.husband_name%> </td> 																	
						<%
						if(k == (data.size()-1))
						{	
							%>													
							<td> 
								<input type="button" id="update" name = "update" value = "Update" style="color:blue" onClick="window.location.href='EnterDateForm.jsp?id=<%= objid%>&fromdate=<%= bd.from_date%>&todate=<%= bd.to_date%>'">	
							</td> 
							</tr>						
							<%
						}
						else
						{
							%> 
							<td> </td>
							</tr>
							<%
						}
					}					
					System.out.println();					
				}
				%>				
				</table>				
				</center>
				<%							
				}//close try block
				catch(Exception  e)
				{
					System.out.println("Exception::"+e);
					e.printStackTrace();
				}				
			%>	
	</body>
</html>