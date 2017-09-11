<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
		<%@page import="com.mongodb.WriteResult" %>
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
 	<%@ include file="home.jsp" %>
	<%@page import = "com.mongodb.util.JSON"%>
	
<%
String name = request.getParameter("name");
String id=request.getParameter("id");
String rem = request.getParameter("rem");
String period = request.getParameter("period");
String type = request.getParameter("type");
String phone = request.getParameter("cph");
String cn = (String)session.getAttribute("username");
String role=(String)session.getAttribute("role");

Date date = new Date();
MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
DB db1 = mongo.getDB(db);
DBCollection collection = db1.getCollection(kmccoll);
BasicDBObject doc = new BasicDBObject();
System.out.println("sop inside insert remarks");
doc.append("unique_id",id);
doc.append("Name", name);
doc.append("callerName", cn);
doc.append("role", role);
doc.append("remarks", rem);
doc.append("callDate",date);
doc.append("status","failed");
doc.append("surveyType","kmc_details_cc");
doc.append("kmc_period",period);
doc.append("type", type);
doc.append("phone", phone);
WriteResult out1=collection.insert(doc);
if(out1.getN()==0){
	response.sendRedirect("kmc_tracking.jsp?err=1");
}
else
{
	%>
	<script>
	alert("faul");
	</script>
	<%
}
 %>
</body>
</html>