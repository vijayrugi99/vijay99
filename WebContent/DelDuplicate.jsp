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
</head>
<body>
<%@ page import="java.sql.*" %>
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
<%@page import = "java.util.Date"%>
<%@page import = "java.util.Calendar"%>
<%@page import="com.mongodb.util.JSON"%>
<%@page import="com.mongodb.WriteResult" %>	
<%@include file="Config.jsp" %>
<% 


	
	String id=request.getParameter("id");
	String uid=request.getParameter("uid");
	BasicDBObject data;
	System.out.println("id="+id);
	System.out.println("uid="+uid);
	com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
	//MongoClient mongoclient = (MongoClient) request.getSession().getServletContext().getAttribute("MONGO_CLIENT");
	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
	DB database = mongo.getDB(db);
	DBCollection collection = database.getCollection(coll);
    BasicDBObject query = new BasicDBObject();
    ObjectId objid= new ObjectId(id);  
    BasicDBObject searchQuery = new BasicDBObject("_id",objid);
    BasicDBObject objectQuery = new BasicDBObject("data.1", new BasicDBObject( "unique_id",uid));
    BasicDBObject update = new BasicDBObject("$pull",objectQuery);
    WriteResult results = collection.update( searchQuery, update );
    String res=null;
    if(results.getN()==1){
    	%>
    	<script>
          $(document).ready(function(){
        	  $('#myModal').modal('show');
         });
        </script>
    	<div class="modal fade" id="myModal" role="dialog"  data-backdrop="static" width="20%">
        <div class="modal-dialog">
        <div class="modal-content">
        <div align="center">
        <div class="modal-body">
        <p style="color:red"><b>Record Successfully Inserted Back...</b></p>
        </div>
       <button type="button" class="btn btn-primary"onclick="window.location.href='Duplicate_Records.jsp'"><b>OKay</b></button>
        <div class="modal-footer">
        </div>
        </div>
        </div>
        </div>
        </div>
        <%
    }
    else
    {
    	%>
    	<script>
          $(document).ready(function(){
        	  $('#myModal1').modal('show');
         });
        </script>
    	<div class="modal fade" id="myModal1" role="dialog"  data-backdrop="static" width="20%">
        <div class="modal-dialog">
        <div class="modal-content">
        <div align="center">
        <div class="modal-body">
        <p style="color:red"><b>Sorry unable to delete the record...</b></p>
        </div>
       <button type="button" class="btn btn-primary"onclick="window.location.href='Duplicate_Records.jsp'"><b>OKay</b></button>
        <div class="modal-footer">
        </div>
        </div>
        </div>
        </div>
        </div>
    	 <%
    }
    System.out.println("results::"+results);
    %>
      
</body>
</html>