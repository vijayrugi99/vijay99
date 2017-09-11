<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mongodb.ServerAddress" %>
<%@page import="com.mongodb.DBCursor" %>
<%@page import="com.mongodb.DBObject" %>
<%@page import="com.mongodb.BasicDBObject" %>
<%@page import="com.mongodb.DBCollection" %>
<%@page import="com.mongodb.DB" %>
<%@page import="com.mongodb.BasicDBObjectBuilder" %>
<%@page import="com.mongodb.BasicDBList" %>
<%@ include file="Config.jsp" %>
<%@page import="org.json.JSONObject" %>
	<%@page import="org.json.JSONArray" %>
	<%@page import="java.io.PrintWriter" %>
<% 
try{
	  
	  String password=request.getParameter("password");

	  String un=request.getParameter("un");
	  String role=null; 
	  
	  role=request.getParameter("role");

	 // System.out.println("exist role"+role);
	//  System.out.println("exist Username"+un);
	  MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	  DB datab = mongoClient.getDB(db);
	  DBCollection collection= datab.getCollection(credentials);
	  BasicDBObject doc = new BasicDBObject();
	  if(password==null)
	  {
		  
		  doc.put("username",un);
		  doc.put("role",role);
		  DBCursor cr=collection.find(doc);
		  System.out.println("Cursor Size="+cr.size());
		  if(cr.size()>0)
		  {
			   //String json="{'status':'User name already registered'}";
			    String json="{'status':'-1'}";
			    JSONObject jsons = new JSONObject(json);
			    JSONObject member =  new JSONObject();
			    member.put("jsonArray", jsons);
			    PrintWriter pw = response.getWriter(); 
			    pw.print(jsons.toString());
			    pw.close();
			  // response.getWriter().print("User name already registered");
		  }
		  else
		  {
			    String json="{'status':'1'}";
			    JSONObject jsons = new JSONObject(json);
			    JSONObject member =  new JSONObject();
			    member.put("jsonArray", jsons);
			    PrintWriter pw = response.getWriter(); 
			    pw.print(jsons.toString());
			    pw.close();
			   //response.getWriter().print("available");
		  }
		  
	  }
	
	  else
	  {
		  String username=(String)session.getAttribute("username");
		  doc.put("username",username);
		  doc.put("password",password);
		  DBCursor cr=collection.find(doc);
		  if(cr.size()<=0)
		  {
			//String json="{'status':'User name already registered'}";
			    String json="{'status':'-1'}";
			    JSONObject jsons = new JSONObject(json);
			    JSONObject member =  new JSONObject();
			    member.put("jsonArray", jsons);
			    PrintWriter pw = response.getWriter(); 
			    pw.print(jsons.toString());
			    pw.close();
			  // response.getWriter().print("wrong password");
		  }
		  else
		  {
			    String json="{'status':'1'}";
			    JSONObject jsons = new JSONObject(json);
			    JSONObject member =  new JSONObject();
			    member.put("jsonArray", jsons);
			    PrintWriter pw = response.getWriter(); 
			    pw.print(jsons.toString());
			    pw.close();
			   //response.getWriter().print("correct password");
		  }
		  
	  }
}
catch(Exception e)
{
System.out.print(e);
}
	
%>


</body>
</html>