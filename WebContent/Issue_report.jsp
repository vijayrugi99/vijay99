<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Responsive_Style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="snackbar.css">
<title>Insert title here</title>
</head>
<body>
<% String value = request.getParameter("issue");
		 %>
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
	<%@page import="com.mongodb.QueryBuilder"%>
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
		<div class="container" align="center">		 
		 <form action="Issue_report.jsp" method="POST" class="form-inline">
		 <h1 style = "color:brown"> Issue's Babies Report</h1>
		 <div class="form-group">							
			<!-- obtain the value from js file into dropdown list-->	
			<div id="filters"></div>
			  <select required="required" name="issue" id="issue" class="form-control">
			 <option> choose</option>
			 <option value="d_id">Duplicate Report</option>
			 <option value="group_id">Grouped Report</option>
			 <option value="readmit">Re-admitted Report</option>
			 <option value="ur">Un-related</option>
			</select>
		 </div>&nbsp;		
		 <br><br> 
			<button type="submit" class="btn btn-primary">Submit</button>				
			<br /> 																					
		 </form>			 
		 </div>
	<%
	MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
    DB db1 = mongoClient.getDB(db); 
    DBCollection collection= db1.getCollection(coll);
    System.out.println("Value ="+value);
	String query = "[{$project:{data:{$arrayElemAt:[\"$data\", 1]}}}," +
"				{$unwind:\"$data\"}," +
"				{ \"$match\": {\"data."+value+"\": {\"$exists\": true } }" +
"				}]";
	 java.util.List<DBObject> list_uid = (java.util.List<DBObject>)JSON.parse(query);	
     Iterable<DBObject> output1 = collection.aggregate(list_uid).results();
    //System.out.println("Query ="+query);
    Object pid =null;
    DBObject dbObject1; 
    
	 for (DBObject dbObject : output1)
	    {
		 out.println(dbObject);
		 
		 dbObject1 = (DBObject)dbObject.get("data");
	        System.out.println("dbObject1="+dbObject1.get("mother_name"));
	    }
	   %>

</body>
</html>