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
	<%@page import = "java.util.Date"%>
	<%@page import = "java.util.Calendar"%>	
	<%@ include file="Config.jsp" %>
 	<%@ include file="home.jsp" %>
	<%@page import = "com.mongodb.util.JSON"%>
<%
try
{
String[] uid = request.getParameterValues("uid");
String btnName= request.getParameter("btn");
BasicDBObject newDoc;
BasicDBObject searchDoc;
BasicDBObject newDocument = new BasicDBObject();
BasicDBObject searchQuery;    
MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();				
DB database = mongo.getDB(db);
DBCollection collection = database.getCollection(credentials);		
DBCollection collection1 = database.getCollection(coll);						
System.out.println("UID Length="+uid.length);
System.out.println("Button Name="+btnName);
String id1;
/** 
* This condition is used to check user clicked which button
*/
if(btnName.equals("group")) /* For grouping the babies*/
{
	id1="592feed142d8cd0df011d024";
	DBObject ObjID = new BasicDBObject("_id", new ObjectId(id1));
	DBObject res=collection.findOne(ObjID);
	int g_id= (Integer)res.get("group_id");
	System.out.println("G_id="+g_id);
	for(int i=0;i<uid.length;i++)
	{
		searchQuery = new BasicDBObject("data.1.unique_id", uid[i]);
		newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$.group_id",g_id));
		collection1.update(searchQuery,newDocument); 
		System.out.println("Executed");
	}
	searchDoc = new BasicDBObject("group_id", g_id);
	newDoc=new BasicDBObject().append("$set", new BasicDBObject("group_id", g_id+1));
	collection.update(searchDoc,newDoc);
}
/* This condition is used to check user clicked which button */
else if(btnName.equals("readmit")) /* For merge the babies*/
{
	id1="592feedf42d8cd0df011d025";
	DBObject ObjID = new BasicDBObject("_id", new ObjectId(id1));
	DBObject res=collection.findOne(ObjID);
	int r_id= (Integer)res.get("readmit");
	System.out.println("G_id="+r_id);
	for(int i=0;i<uid.length;i++)
	{
		searchQuery = new BasicDBObject("data.1.unique_id", uid[i]);
		newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$.readmit",r_id));
		collection1.update(searchQuery,newDocument); 
		System.out.println("Executed");
	}
	searchDoc = new BasicDBObject("readmit", r_id);
	newDoc=new BasicDBObject().append("$set", new BasicDBObject("readmit", r_id+1));
	collection.update(searchDoc,newDoc);
	
}
/* This condition is used to check user clicked which button */
else if(btnName.equals("merge")) /* For merge the babies*/
{
	id1="592feee942d8cd0df011d026";
	DBObject ObjID = new BasicDBObject("_id", new ObjectId(id1));
	DBObject res=collection.findOne(ObjID);
	int d_id= (Integer)res.get("d_id");
	System.out.println("D_id="+d_id);
	for(int i=0;i<uid.length;i++)
	{
		searchQuery = new BasicDBObject("data.1.unique_id", uid[i]);
		newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$.d_id",d_id));
		collection1.update(searchQuery,newDocument); 
		System.out.println("Executed");
	}
	searchDoc = new BasicDBObject("d_id", d_id);
	newDoc=new BasicDBObject().append("$set", new BasicDBObject("d_id", d_id+1));
	collection.update(searchDoc,newDoc);
}
}
catch(Exception e)
{
	out.println("Error= "+e);
	
}
	



%>
</body>
</html>