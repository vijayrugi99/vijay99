<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
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
		<%@page import = "com.mongodb.util.JSON"%>
		<%@page import = "java.util.Date"%>
		<%@page import = "java.util.Calendar"%>	
		<%@ include file="Config.jsp" %>
		
		<%
        String exportToExcel = request.getParameter("exportToExcel");
        if (exportToExcel != null
                && exportToExcel.toString().equalsIgnoreCase("YES")) {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "inline; filename="
                    + "kmcInitiated.xls");
        }
        %>
        <%
         if (exportToExcel == null) {
        %>
    
    <%
        }
    %>
<%
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
		DB database = mongo.getDB(db);
		System.out.println("Used db ="+database);
		System.out.println("Connected to database sucessfully...");
		DBCollection collection = database.getCollection(kmcColl);						
		System.out.println("Collection used ="+collection);
		DBCursor cursor = collection.find();
%>
            <font color=blue><center><h1>KMC Initiated Babies</h1></center></font>
			 <center>
             <a href="kmcInitiated.jsp?exportToExcel=YES">ExportToExcel</a>
            </center>
            <br>
			<table align="center" border="2" font-family="verdana" font-size="10pt" text-align="center" border-collapse="collapse" border="1px solid black" padding=3px;>
			<tr style = color:brown>	
				<th rowspan=2> Sl. No.</th>
				<th rowspan=2> ObjectID </th>
				<th colspan=20> Babies Details </th>
				<tr style = color:brown>
				   
					<th> Babies Unique_ID </th>
					<th> am/pm </th>
					<th> kmc_reg_no </th>
					<th> date_of_kmc_initiation </th>
					<th> time_of_kmc_initiation </th>	
					</tr>
<% 
		int i=1;
		while(cursor.hasNext())
		{
			DBObject dbo = cursor.next();
			if(dbo.containsField("_id"))
			{
			
				bd.kmc_objectID = dbo.get("_id");
				
			}
			if(dbo.containsField("am_pm"))
			{
				bd.am_pm = dbo.get("am_pm");
			}
			if(dbo.containsField("kmc_reg_no"))
			{
				bd.kmc_reg_no = dbo.get("kmc_reg_no");
			}
			if(dbo.containsField("date_of_kmc_initiation"))
			{
				bd.date_of_kmc_initiation = dbo.get("date_of_kmc_initiation");
			}
			if(dbo.containsField("time_of_kmc_initiation"))
			{
				bd.time_of_kmc_initiation = dbo.get("time_of_kmc_initiation");
			}
			if(dbo.containsField("unique_id"))
			{
				bd.kmc_unique_id = dbo.get("unique_id");
			}
			
%>
			<tr>
			<td> <%= i++ %> </td>
			<td> <%= bd.kmc_objectID %> </td>
			<td> <%= bd.kmc_unique_id %> </td>
			<td> <%= bd.am_pm %> </td>
			<td> <%= bd.kmc_reg_no %> </td>
			<td> <%= bd.date_of_kmc_initiation %> </td>
			<td> <%= bd.time_of_kmc_initiation %> </td>
			 </tr>
<% 
		}
%>
</table>
</body>
</html>