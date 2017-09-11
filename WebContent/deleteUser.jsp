<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">  
</head>
<body>
<%@page import="com.mongodb.MongoClient"%>

<%@page import="com.mongodb.MongoException"%>
<%@page import="com.mongodb.WriteConcern"%>

<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>

<%@page import="com.mongodb.ServerAddress"%>
<%@page import="java.util.*"%>
<%@page import="java.util.List"%>
<%@page import="java.net.UnknownHostException"%>
<%@page import="java.util.Date"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.mongodb.MongoException"%>
	<%@include file="Config.jsp" %>

<%
try
{
		String role=request.getParameter("role");
		String username=request.getParameter("username");
		 MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		 DB database = mongoClient.getDB(db);
			//System.out.println("Connected to daabase sucessfully...");
			DBCollection collection = database.getCollection(credentials);
	    System.out.println("role="+role);
	    System.out.println("un="+username);
	
	    BasicDBObject document = new BasicDBObject();
	    document.put("username",username);
	    document.put("role",role);
	    DBCursor cr=collection.find(document);
	    
	    if(cr.size()>0)
	    {
	    	
	    	
	    	//BasicDBObject searchQuery = new BasicDBObject().remove(document);
	    	 collection.remove(document);
	    	 response.sendRedirect("viewUser.jsp?err=3");
	    }
	    else
	    {
	    	

	    	response.sendRedirect("Fail.jsp");
	    }
	    }
	    catch(Exception e)
	    {
	    System.out.print(e);
	    }
	    

	%>
</body>
</html>