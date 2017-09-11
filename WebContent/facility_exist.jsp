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
try{
	response.setContentType("text/xml");
	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();					
	
	DB database = mongo.getDB(db);
	//System.out.println("Used db ="+database);
	//System.out.println("Connected to database sucessfully...");
	DBCollection collection = database.getCollection(taluk);						
	//System.out.println("Collection used ="+collection);
	String query=null;
	  String tq=request.getParameter("tq");
	  
	  System.out.println("Taluk"+tq);
	//  System.out.println("exist Username"+un);
	String qry ="[ {" +
			"       \"$unwind\":\"$taluk\"" +
			"  },   " +
			"  {" +
			"     \"$match\":" +
			"       {" +
			"        \"taluk.value\":"+tq+"" +
			"       }" +
			"  }" +
			" ]";
	System.out.println("Qry="+qry);
	java.util.List<DBObject> list = (java.util.List<DBObject>)JSON.parse(qry);	    		
		Iterable<DBObject> output = collection.aggregate(list).results();//object contains all records       			
		System.out.println("No. reports ="+list.size());  
		Double value=0.0;
		String text=null;
		String strObjects = null;		
		System.out.println("output="+output);
	
          
                   
                

		for(DBObject obj: output)//this contains all records, if used str string
		{			
			ObjectId id = (ObjectId) obj.get("_id");
			BasicDBObject data = (BasicDBObject) obj.get("taluk");
			BasicDBList data1 = (BasicDBList) data.get("facility");
		//	System.out.println("<FACILITY>");
		//	
			for(int i=0;i<data1.size();i++)
			{
				DBObject obj1=(DBObject)data1.get(i);
			if(obj1.containsField("value"))
			{
				value = (Double)obj1.get("value");
				list.add(value);
			}
			if(obj1.containsField("text"))
			{
				text = (String)obj1.get("text");
				list.add(text);
			}
			response.setHeader("Cache-Control", "no-cache");
			// response.getWriter().write("<valid>true</valid>");
			 
			/*  response.getWriter().write("<FACILITY>");
			 response.getWriter().write("<TEXT>"+text+"</TEXT>");
			 response.getWriter().write("</FACILITY>");
			 */ 
/* 			 out.println("<FACILITY>");
			 out.println("<TEXT>"+text+"</TEXT>");
			 out.println("<FACILITY>");
			  */
			 System.out.println("<FACILITY>");
			 System.out.println("<TEXT>"+text+"</TEXT>");
			 System.out.println("</FACILITY>");
			}
			// out.println("<value>"+value+"</value>");
			
			//System.out.println("</FACILITY>");
			
		}
		
		
}
catch(Exception e)
{
System.out.print(e);
}
%>


</body>
</html>