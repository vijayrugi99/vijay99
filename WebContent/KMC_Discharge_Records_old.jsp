<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> KMC Initiated Records </title>
		<script src="facilities.js">	</script>
		<script src="ken_kmc_html.js"></script>
		 <!-- style for excel sheet  -->
		<style>
			table,th,td{ 	
					font-family:verdana; 
					font-size:10pt;
					text-align:center; 
					border-collapse:collapse; 
					border:1px solid black; 
					padding:3px;
				}
		</style>
		<link rel="stylesheet" type="text/css" href="Reports_Stylesheet.css">
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
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>		
        
       <center>
       	<div id="ctrls"></div>
      		<script>
      			ctrls.innerHTML=ExportToexcel("KMC_Discharge_Records.jsp","KMC_Discharge_Records.xls",<%=request.getParameter("hideCtrls")!=null%>)
       		</script>
      </center>	
      			
		<% String value = request.getParameter("facility"); %>
		<script src="ken_kmc_html.js"></script>
		
		<form action="KMC_Discharge_Records.jsp" method="POST" style = "text-align:center; margin-top:30px">
			<h1 style = "color:brown"> KMC Initiated Details for Babies </h1>				
			
			<div id="filters"></div>
			<script>
				var filterStr= DropdownFilter(facilityFilter,"<%= value%>");
				filters.innerHTML=filterStr;
			</script>
			<br /> 			
			<input type="submit" value="Submit" name="submit" style="color:blue; width:5%">				
			<br />
			<br />																								
		</form>
		
		<%
			//response.setContentType("text/html");					
			//try
			{				
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				System.out.println("mongo = "+mongo);
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection); 
				
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
				int facility = value==null?1:Integer.parseInt(value);
				System.out.println("Facility in  jsp page ="+facility);
				ArrayList<DBObject> jsonArray = mongodao.kmcDischargeRecords(facility);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int count=0;
				%>
				<center>
				<table>				
					<tr style = "color:brown;">
						<th width=30> SI. No. </th>
						<th width=100> Date </th>
						<th width=50> Facility </th>
						<th width=100> Unique_ID </th>
						<th width=100> DOB </th>
						<th width=75> Mother_Name </th>
						<th width=75> Husband_Name </th>
						<th width=30> Date_Of_KMC_Initiation </th>
						<th width=30> No_of_Days_of_kmc_entered </th>
						<th width=30> Status </th>
						<th width=100> Details </th>	
					</tr>				
				<% 	
				Object disStatus = "-";
				for(int i=0; i<jsonArray.size(); i++)
				{
					//System.out.println("DBObjects are ="+jsonArray.get(i));
					ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
					//System.out.println("Objet id are ="+objid);		
					
					//convert ObjectID into date format
					Date enterDate = objid.getDate();
					SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:ss:mm a");
					java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
					sdf1.setTimeZone(tz);
					String formatDate = sdf1.format(enterDate);
					//System.out.println("Formatted object entered date = " +formatDate);
					
					BasicDBObject facilityData = (BasicDBObject)jsonArray.get(i).get("facility");
					bd.facility = facilityData.getInt("facility");
					//System.out.println("Faility are ="+bd.facility);
					
					BasicDBObject kmcData = (BasicDBObject)jsonArray.get(i).get("data");
					bd.dob = kmcData.get("dob1");
					bd.mother_name = kmcData.get("mother_name");
					bd.husband_name = kmcData.get("husband_name");
					bd.u_id = kmcData.get("unique_id");

					//comp_docs list
					BasicDBList comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");					
					//System.out.println("comp_obj are:"+comp_obj);
					System.out.println("comp_obj size is ="+comp_obj.size());
					
					if(comp_obj.size() == 0)
					{
						%>					
						<tr>
							<td> <%= (++count)%> </td>
							<td> <%= formatDate%> </td>
							<td> <%= bd.facility%> </td>
							<td> <%= bd.u_id%> </td>
							<td> <%= bd.dob%> </td>
							<td> <%= bd.mother_name%> </td>
							<td> <%= bd.husband_name%> </td>
							<td> -- </td>					
							<td> -- </td>
							<td> KMC Not Being Initiated</td>
							<td> 
								<input type="button" id="kmc" name = "kmc" value = "Enter KMC" style="color:blue" onClick="window.open('kmcinit-fi.jsp?baby=<%= bd.u_id%>')">	
							</td>															
						</tr>					
					<%	
					}
					else
					{
						//comp_docs 0th array list
						BasicDBObject comp_obj_0 = (BasicDBObject)comp_obj.get(0);					
						//System.out.println("comp_obj_0 :"+comp_obj_0);
						if(comp_obj_0.containsField("init_date1"))
						{
							bd.init_date1 = comp_obj_0.get("init_date1");
						}
						else
						{
							bd.init_date1 = "-";					
						}
	
						if(comp_obj_0.containsField("kmc_initiation"))
						{
							if(comp_obj_0.get("kmc_initiation").equals("Discharged without initiation"))
							{
								bd.kmc_initiation = comp_obj_0.get("kmc_initiation");
							}
							else
								bd.kmc_initiation = "-";
						}
						else
							bd.kmc_initiation = "-";					
						
						System.out.println();					
						int dateCount = 0;
						for(int j=1; j<comp_obj.size(); j++)
						{
							++dateCount;
							BasicDBObject comp_obj_1 = (BasicDBObject)comp_obj.get(j);
							//System.out.println("comp_obj_"+j+" is "+comp_obj_1);						
							bd.kmc_date = comp_obj_1.get("date");
							//System.out.println("comp_obj_"+j+" date is "+bd.kmc_date);
							
							if(comp_obj_1.containsField("discharged"))
							{
								BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
								disStatus = disList.get(0);
								System.out.println("dis status ="+disStatus);
							}
							else
							{
								disStatus = "-";
							}
						}
						System.out.println("kmc_initiation = "+bd.kmc_initiation);
						if(bd.kmc_initiation.equals("Discharged without initiation") || disStatus.equals("discharged"))
						{
							%>					
							<tr>
								<td> <%= (++count)%> </td>
								<td> <%= formatDate%> </td>
								<td> <%= bd.facility%> </td>
								<td> <%= bd.u_id%> </td>
								<td> <%= bd.dob%> </td>
								<td> <%= bd.mother_name%> </td>
								<td> <%= bd.husband_name%> </td>
								<td> <%= bd.init_date1%> </td>					
								<td> <%= dateCount%> </td>
								<td> Discharged without Entering Details</td>
								<td> 
									<input type="button" id="kmc" name = "kmc" value = "View" style="color:blue" onClick="window.open('KMC_Discharge_Details.jsp?facility=<%= bd.facility%>&unique_id=<%= bd.u_id%>')">	
								</td>															
							</tr>					
						<%		
						}
						else
						{
							%>					
							<tr>
								<td> <%= (++count)%> </td>
								<td> <%= formatDate%> </td>
								<td> <%= bd.facility%> </td>
								<td> <%= bd.u_id%> </td>
								<td> <%= bd.dob%> </td>
								<td> <%= bd.mother_name%> </td>
								<td> <%= bd.husband_name%> </td>
								<td> <%= bd.init_date1%> </td>					
								<td> <%= dateCount%> </td>
								<td> Not Discharged </td>
								<td> 
									<input type="button" id="kmc" name = "kmc" value = "View" style="color:blue" onClick="window.open('KMC_Discharge_Details.jsp?facility=<%= bd.facility%>&unique_id=<%= bd.u_id%>')">	
								</td>															
							</tr>					
							<%	
						}
					}	
				}
				%>				
				</table>				
				</center>
				<%
				
			}//close try block			
			/* catch(Exception  e)
			{
				//out.println("Exception::"+e);				
				e.printStackTrace();
			} */			
		%>	
	</body>
</html>