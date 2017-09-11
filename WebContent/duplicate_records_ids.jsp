<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title> Duplicate Records </title>
	<script src="facilities.js">	</script>
	<script src="koppal_villages.js"></script>	
	<script src="ken_kmc_html.js"></script>
	<link rel="stylesheet" href="Responsive_Style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
	   <!-- must include -->
	   <style>
		.table-responsive2 {
		width:100%;
		margin-bottom:15px;
		overflow-x:auto;
		overflow-y:hidden;
		-webkit-overflow-scrolling:touch;
		-ms-overflow-style:-ms-autohiding-scrollbar;
		border:1px solid #ddd
		}		
		.table-responsive2 table {
		    table-layout: fixed;
		}
		.table-responsive table{
			table-layout: auto;
		}
		.tableheader {
			width: 1165px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 600px;
			overflow-y: auto;
			width: 1165px;
			margin-bottom:20px;
		}		
   </style>	
</head>
<body onload="backToLogin()">
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
	<%-- <%@ include file="home.jsp" %> --%>
	<%@page import = "com.mongodb.util.JSON"%> 
	
	<%
		response.setContentType("text/html");	
		try
		{				
			//get connection to mongodb				
			MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();				
			DB database = mongo.getDB(db);
			System.out.println("Used db ="+database);
			System.out.println("Connected to database sucessfully...");
			DBCollection collection = database.getCollection(coll);						
			System.out.println("Collection used ="+collection);	
			com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
			ArrayList<DBObject> jsonArray = mongodao.duplicateRecords();
			System.out.println("Total duplicate babies="+jsonArray.size());
			com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
			int count=0;
			int delete_id_cnt=0;			
			%>
			<div class="container">
			<div class="row">
			<h1 style="color:brown; text-align:center"> Duplicates Babies </h1>
			
			<div class="table-responsive2">
			<table class="table table-bordered table-striped table-header">
			<thead>
				<tr>
					<th style="text-align:center;width:165px;"> SI. No. </th>					
					<th style="text-align:center;width:250px;"> Mother_Name </th>
					<th style="text-align:center;width:250px;"> Father_Name </th>
					<th style="text-align:center;width:250px;"> DOB </th>						
					<th style="text-align:center;width:250px;"> View Details </th>					
				</tr>
			</thead>
			</table>
			<div class="tablebody">
            <table class="table table-bordered table-striped" >
            <tbody>						
				<tr>
				<%
					for(int i=0; i<jsonArray.size(); i++)						
					{
						//System.out.println("Records are = "+jsonArray.get(i));
						BasicDBObject obj = (BasicDBObject)jsonArray.get(i);
						//int dup_cnt = Integer.parseInt(obj.getString("count"));
						String dup_cnt = obj.getString("count");
						BasicDBObject fieldsData = (BasicDBObject)jsonArray.get(i).get("_id");
						//System.out.println("Fields data ="+fieldsData);
						bd.mother_name = fieldsData.get("mother");
						bd.husband_name = fieldsData.get("father");
						bd.sex = fieldsData.get("sex");
						bd.dob = fieldsData.get("dob");
						
						BasicDBList data = (BasicDBList)jsonArray.get(i).get("data");
						System.out.println("data array ="+data);
						for(int k=0; k<data.size(); k++)
						{
							BasicDBObject data_arr = (BasicDBObject)data.get(k);
							//System.out.println("data at "+k+" = "+data_arr);
							if(data_arr.containsField("d_id"))								
							{
								++delete_id_cnt;
							}
						}
						//int dupCount =  Integer.parseInt(dup_str_cnt);
						//System.out.println("duplicate cnt in object type = "+dup_cnt);
						System.out.println("duplicate cnt in int type = "+dup_cnt);
						System.out.println("delete_id_cnt = "+delete_id_cnt);						
						System.out.println();
						
						if(dup_cnt.equals("2") && delete_id_cnt == 1)
						{
							System.out.println("inside if2");
							continue;
						}
						else
						{
						%>
							<td style="width:165px;"> <%= (++count)%> </td>
							<td style="width:250px;"> <%= bd.mother_name%> </td>
							<td style="width:250px;"> <%= bd.husband_name%> </td>
							<td style="width:250px;"> <%= bd.dob%> </td>							
							<td> 
								<input type="button" class="btn btn-info btn-sm" onclick="window.open('duplicate_babies.jsp?mothername=<%= bd.mother_name%>&fathername=<%= bd.husband_name%>&dob=<%= bd.dob%>')" value="View">
							</td>
						</tr>
						<%						
						}
						delete_id_cnt=0;
					}					
				%>				
			</tbody>
			</table>
			</div>
			</div>
			</div>			
			</div>
			<%	
		}//close try block			
		catch(Exception  e)
		{
			//out.println("Exception::"+e);
			//e.printStackTrace(response.getWriter());
			System.out.println(e);
		}			
	%>										
	<%@include file="tableexport.jsp" %>		
</body>
</html>