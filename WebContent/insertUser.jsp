<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
try{  
		String t="success";
	    String f="fail";
	    String username=(String)session.getAttribute("username");
	    String role=(String)session.getAttribute("role");
	  String un=request.getParameter("ausername");
	  String pass=request.getParameter("apassword");
	  String role1=request.getParameter("arole");
	  System.out.println("Username="+username);
	    System.out.println("AUser name="+un);
	      System.out.println("APass="+pass);
	      System.out.println("ARole="+role);
	  MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	  DB database = mongoClient.getDB(db);
      DBCollection collection= database.getCollection(credentials);
      BasicDBObject document = new BasicDBObject();
   
      document.put("username",un);
      document.put("role",role1);
      DBCursor cr=collection.find(document);
      System.out.println("Size="+cr.size());
      if(cr.size()<=0)
      {
    	  BasicDBObject newDocument = new BasicDBObject();
      	//	newDocument.put("password", pwd);
      	    
      	    newDocument.put("role",role1);  
      	    newDocument.put("username",un);
      	    newDocument.put("password",pass);
      	    newDocument.put("Modified",new Date());
      	    collection.insert(newDocument);
      	    response.sendRedirect("addUser.jsp?error="+t);    
      }
      else
      {
    	  response.sendRedirect("addUser.jsp?error="+f);
      }

}
catch(Exception e)
{
	
	System.out.println("Error="+e);
}

%>


</body>
</html>