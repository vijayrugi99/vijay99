<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
			table,th,td{ font-family:verdana; font-size:10pt;text-align:center; border-collapse:collapse; border:1px solid black; padding:3px;}");					
</style>
</head>
<body >
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
		<%@ include file="home.jsp" %>
		<script src="ken_kmc_html.js"></script>
        
       <center>
       <div id="ctrls"></div>
       <!-- Method to export the table content to excel -->
      <script>
      ctrls.innerHTML=ExportToexcel("FoundErrors.jsp","foundErrors.xls",<%=request.getParameter("hideCtrls")!=null%>)
       </script>
      </center>
  
				
		
				
<% 
    com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
	//MongoClient mongoclient = (MongoClient) request.getServletContext().getAttribute("MONGO_CLIENT");
	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	DB database = mongo.getDB(db);
	System.out.println("Connected to daabase sucessfully...");
	DBCollection collection = database.getCollection(coll);
	String uid_query = "[{$project:{\"_id\":\"$_id\",data:{$arrayElemAt:[\"$data\", 1]}}},{$unwind:\"$data\"},{$match:{\"data.pid1\":{$exists:true}}},{$group:{_id:{u_id:\"$data.pid1\",mother_name:\"$data.mother_name\",time_of_birth:\"$data.time_of_birth\",dob:\"$data.dob\"} ,count:{$sum:1}}},{$match:{count:{$gt:1}}}]";
    
    java.util.List<DBObject> list_uid = (java.util.List<DBObject>)JSON.parse(uid_query);
    Iterable<DBObject> output1 = collection.aggregate(list_uid).results();
    System.out.println("output1:::"+output1);
    %>				
	<!-- create table and header for the table -->				
	<table>
		<tr style = "color:brown">		
			<th width="75"> Sl. No.</th>
			<th width="400"> Unique_ID </th>						
			<th width="200"> Object ID </th>						
			<!-- <th rowspan="2" width="300"> Entered Date </th> -->						
			<!-- <th rowspan="2" width="300"> Period </th> -->						
			<th width="100"> Facility </th>							
			<th width="100"> Baby_DOB </th>							
			<th width="75"> Patient_ID1 </th>					
			<th width="200"> Patient_ID2 </th> 
			<th width="200"> Mother_Name </th>
			<th width="200"> Husband_Name </th>
			<th width="300"> Time_of_Birth </th>
			<th width="300"> Baby_Birth_Weight </th>
			<th width="300"> Baby_Sex </th>
			<th width="300"> Phone1 </th>
			<th width="300"> Phone2 </th>
			<th width="300"> Thayi_Card_No </th>
			<th width="300"> UID </th>
			<!--
			<th width="300"> EPIC </th>
			<th width="300"> Taluk_From </th>
			<th width="300"> Taluk_To </th>
			<th width="300"> Community_to </th>
			<th width="300"> Community_From </th>
			<th width="300"> Baby_Status </th>
			-->			
			<!-- <th width="300"> Survey Type </th>	-->				
		</tr>
	<%
    for (DBObject dbObj : output1)
    {
        System.out.println(dbObj);
       	       				
				System.out.println("Objects are = "+dbObj);
				
			//get each filtered object
				BasicDBObject dataObj = (BasicDBObject) dbObj.get("data");
			
			if(dataObj.containsField("dob"))
			{
				bd.dob = dataObj.getString("dob");
			}
			else
				bd.dob = "-";
			if(dataObj.containsField("unique_id"))
			{
				bd.u_id = dataObj.getString("unique_id");
			}
			else
				bd.u_id = "-";
			if(dataObj.containsField("pid1"))
			{
				bd.pid1 = dataObj.getString("pid1");
			}
			else
				bd.pid1 = "-";
			if(dataObj.containsField("pid2"))
			{
				bd.pid2 = dataObj.getString("pid2");
			}
			else
				bd.pid2 = "-";
			if(dataObj.containsField("time_of_birth"))
			{
				bd.time_of_birth = dataObj.getString("time_of_birth");
			}
			else
				bd.time_of_birth = "-";
			if(dataObj.containsField("thayi_card_no"))
			{
				bd.thayi_card_no = dataObj.getString("thayi_card_no");
			}
			else
				bd.thayi_card_no = "-";
			if(dataObj.containsField("community_from") )
			{
				bd.community_from = dataObj.getString("community_from");
				if(bd.community_from.equals("other"))
				{
					bd.community_from = dataObj.getString("community_from")+" [" +dataObj.getString("community_from-Comment")+"]";
				}
				else
				{
					bd.community_from = dataObj.getString("community_from");
				}
			}
			else
				bd.community_from = "-";
			if(dataObj.containsField("baby_status"))
			{
				bd.baby_status = dataObj.getString("baby_status");
			}
			else
				bd.baby_status = "-";
			if(dataObj.containsField("mother_name"))
			{
				bd.mother_name = dataObj.getString("mother_name");//getInt("epic");
			}
			else
				bd.mother_name = "-";
			if(dataObj.containsField("sex"))
			{
				bd.sex = dataObj.getString("sex");//getInt("epic");
			}
			else
				bd.sex = "-";
			if(dataObj.containsField("phone2"))
			{
				bd.phone2 = dataObj.getString("phone2");//getInt("epic");
			}
			else
				bd.phone2 = "-";
			if(dataObj.containsField("epic"))
			{
				bd.epic = dataObj.getString("epic");
			}
			else
				bd.epic = "-";
			if(dataObj.containsField("phone1"))
			{
				bd.phone1 = dataObj.getString("phone1");
			}
			else
				bd.phone1 = "-";
			if(dataObj.containsField("uid"))
			{
				bd.uid = dataObj.getString("uid");
			}
			else
				bd.uid = "-";
			
			if(dataObj.containsField("community_to"))
			{
				bd.community_to = dataObj.getString("community_to");
				if(bd.community_to.equals("other"))
				{
					bd.community_to = dataObj.getString("community_to")+" [" +dataObj.getString("community_to-Comment")+"]";
				}
				else
				{
					bd.community_to = dataObj.getString("community_to");
				}
			}
			else
				bd.community_to = "-";
			if(dataObj.containsField("taluk_to"))
			{
				bd.taluk_to = dataObj.getString("taluk_to");
				if(bd.taluk_to.equals("other"))
				{
					bd.taluk_to = dataObj.getString("taluk_to")+" [" +dataObj.getString("taluk_to-Comment")+"]";
				}
				else
				{
					bd.taluk_to = dataObj.getString("taluk_to");
				}
			}
			else
				bd.taluk_to = "-";
			if(dataObj.containsField("birth_weight"))
			{
				bd.birth_weight = dataObj.getString("birth_weight");
			}	
			else
				bd.birth_weight = "-";
			if(dataObj.containsField("taluk_from"))
			{
				bd.taluk_from = dataObj.getString("taluk_from");
				if(bd.taluk_from.equals("other"))
				{
					bd.taluk_from = dataObj.getString("taluk_from")+" [" +dataObj.getString("taluk_from-Comment")+"]";
				}
				else
				{
					bd.taluk_from = dataObj.getString("taluk_from");
				}
			}										
			else
				bd.taluk_from = "-";
			if(dataObj.containsField("husband_name"))
			{
				bd.husband_name = dataObj.getString("husband_name");
			}
			else
				bd.husband_name = "-";
			if(dataObj.containsField("surveyType"))
			{	
				bd.surveytype = dataObj.getString("surveyType");	
			}
			else
				bd.surveytype="-";
				%>	       			
			<%-- <td><%= formatDate%> </td>	 --%>	
			<td><%= bd.u_id%></td>					
			<%-- <td><%= bd.from_date +" to "+ bd.to_date%></td>	 --%>											    	
			<td><%= bd.facility%></td>
			<td><%= bd.dob%></td>
			<td><%= bd.pid1%></td>						
			<td><%= bd.pid2%></td>
			<td><%= bd.mother_name%></td>
			<td><%= bd.husband_name%></td>
			<td><%= bd.time_of_birth%></td>
			<td><%= bd.birth_weight%></td>
			<td><%= bd.sex%></td>
			<td><%= bd.phone1%></td>
			<td><%= bd.phone2%></td>							    	
			<td><%= bd.thayi_card_no%></td>
			<td><%= bd.uid%></td>
			<%-- <td><%= bd.surveytype%></td>
			<td><%= bd.epic%></td>
			<td><%= bd.baby_status%></td>
			<td><%= bd.baby_status%></td>
			<td><%= bd.taluk_from%></td>
			<td><%= bd.taluk_to%></td>
			<td><%= bd.community_to%></td>
			<td><%= bd.community_from%></td>
			 --%>															
		</tr>
		<%					
			}
    

	
%>

</body>
</html>