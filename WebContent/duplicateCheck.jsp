<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Duplicate Records </title>
		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<style type="text/css">
		.well {
		    background: none;
		    height: 320px;
		}	
		.table>thead>tr>th{text-align:center;}				
		</style>  
	</head>
	
	<body >
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
			//response.setContentType("text/html");	
			try
			{
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
				//MongoClient mongoclient = (MongoClient) request.getSession().getServletContext().getAttribute("MONGO_CLIENT");
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
				DB database = mongo.getDB(db);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);
				int i=0;
				String objectId = request.getParameter("id1");
		   		System.out.println("id1::"+objectId);
		   		String uniqueId = request.getParameter("id2");
		   	 	System.out.println("id2::"+uniqueId);
		   	 	//function to insert deleted record to deletecol
		   	    ArrayList<DBObject> json = mongodao.getRecordByUniqueid(uniqueId);
	    		for(DBObject obj: json){
					//Object data=null;	    
					BasicDBObject data = (BasicDBObject) obj.get("output");
					BasicDBObject facility = (BasicDBObject) obj.get("facility");
	    			if(obj.containsField("output"))
					{
						//data= obj.get("data");
						System.out.println("data--:"+obj.get("output"));
					}
	    			 Object ID=null; 
					if(obj.containsField("_id"))
					{
					
						  ID = obj.get("_id");
						 System.out.println("id--:"+obj.get("_id"));
						
					}
					
	    			BasicDBObject obj2 = new BasicDBObject();
	    			obj2.append("objectId", ID);
	    			obj2.append("output", data);
	    			obj2.append("facility",facility);
	       				    			
	    	      String result= new com.kentropy.mongodb.DeleteMongodbObject().deleteObject(  db, coll, delColl, obj2);
	    	      System.out.println("result::"+result);
	    		}
		   	 	
				BasicDBObject query = new BasicDBObject();
				ObjectId id= new ObjectId(objectId);  
				BasicDBObject searchQuery = new BasicDBObject("_id",id);
		   		BasicDBObject objectQuery = new BasicDBObject("data.1", new BasicDBObject( "unique_id",uniqueId));
		    	BasicDBObject update = new BasicDBObject("$pull",objectQuery);
		   	    WriteResult results = collection.update( searchQuery, update );
		    	//System.out.println("Results::-"+update);
		    	//System.out.println("Results::-"+searchQuery);
		    	//System.out.println("Results::-"+results);
		    	
		    	JSONObject ack = new JSONObject(results); 
		    	System.out.println("ack::-"+ack);
		    	
		    	if(ack.getInt("n") == 1)
		    	{	
		    		//out.println("<br /><br /><br /><center> <h4 style=\"color:brown;\">Object with UniqueId "+id+" Deleted Successfully.......!</h4></center>");
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
		            <p style="color:red"><b>Record Successfully Deleted...</b></p>
		            </div>
		           <button type="button" class="btn btn-primary"onclick="window.location.href='allDocuments.jsp'"><b>OKay</b></button>
		            <div class="modal-footer">
		            </div>
		            </div>
		            </div>
		            </div>
		            </div>
		            <%
		   	    }
		    	else{
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
		            <p style="color:red"><b>Sorry unable deleted the record...</b></p>
		            </div>
		           <button type="button" class="btn btn-primary"onclick="window.location.href='allDocuments.jsp'"><b>OKay</b></button>
		            <div class="modal-footer">
		            </div>
		            </div>
		            </div>
		            </div>
		            </div>
		            <%
		    	}
		    		
		    	// call funtion to insert deleted record to new collection
			}
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
			}				
		%>
		<!-- <center><button class="btn btn-info" style="color:black;" onclick="goBack()"> Go-Back </button></center> -->
	</body>
</html>