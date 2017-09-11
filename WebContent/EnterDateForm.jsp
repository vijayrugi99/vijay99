<%@page import="com.kentropy.mongodb.UpdateByObjectID"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Update by ObjectID </title>
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
		
		<% String fromdate = request.getParameter("fromdate");		
			String todate = request.getParameter("todate");
			String objid = request.getParameter("id");
			System.out.println("Obejct ="+objid);
		%>
		<form action="Update_ObjectID.jsp?id=<%= objid%>" method="post" style = "text-align:center; margin-top:50px">
			<h3 style = "text-align:center;color:brown"> Enter the from and to date to be modify </h3>
			Current FromDate = <input type=text id="fromdate" name="fromdate" value=<%= fromdate%> disabled> &nbsp;	
			Current toDate = <input type=text id="todate" name="todate" value=<%= todate%> disabled>	
			<br />
			<br />
			New FromDate = <input type=text id="from1" name="from1">	&nbsp;
			New toDate = <input type=text id="to1" name="to1">	
			<br />
			<br />
			<input type="submit" value="Update">					
		</form>		
	</body>
</html>