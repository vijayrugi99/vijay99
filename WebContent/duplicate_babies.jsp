<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title> Duplicate Babies </title>
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
			width: 2300px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 300px;
			overflow-y: auto;
			width: 2315px;
			margin-bottom:20px;
		}		
   </style>	
   <script type="text/javascript">
   function validate(clickedid)
   {	  
	   var len=document.querySelectorAll('input[type="checkbox"]:checked').length;
	   var count=document.querySelectorAll('input[type="checkbox"]').length;
	  // alert(len);
	//   alert(count);
 	//  alert("button="+clickedid);
		if(clickedid=="delbtn")
		{
		//	alert("inside if");
			 if(len<1)
			 {
			    alert("Please select atlease 1 check box!")
			  	return false;   
			 }	
		 	else if(len==count)
			 {
			    alert("Please Un-mark Original data!")
			    return false;   
			 }
		}
	else
		{
		    if(len<2)
			{
   				alert("Please select more than 1 check box!")
   				return false;   
			}	
		 }
	}
   </script>
   <script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});
</script>
   
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
	<%-- <%@ include file="home.jsp" %> --%>
	<%@page import = "com.mongodb.util.JSON"%> 
	
	
	<% 
		String mothername = request.getParameter("mothername");
		String fathername = request.getParameter("fathername");
		String dob = request.getParameter("dob");
		//System.out.println(" dob in jsp 2="+dob);
	%>
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
			ArrayList<DBObject> jsonArray = mongodao.duplicateBabies(mothername, fathername, dob);
			System.out.println("Total duplicate babies="+jsonArray.size());
			com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
			com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
			int count=0;
			String delete_id=null;
			%>
			<div class="container">
			<div class="row">
			<form action="Group_Merge.jsp" method="get">
			<h1 style="color:brown; text-align:center"> Duplicates Babies </h1>
			<div class="table-responsive2">
			<table class="table table-bordered table-striped table-header">
			<thead>
				<tr>
					<th style="text-align:center;width:100px;"> SI. No. </th>					
					<th style="text-align:center;width:200px;word-wrap:break-word;"> Entered_Date </th>
					<th style="text-align:center;width:200px;word-wrap:break-word;"> Unique ID </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Period </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Facility </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> DOB </th>						
					<th style="text-align:center;width:150px;word_wrap:break-word;"> Mother Name </th>
					<th style="text-align:center;width:150px;word_wrap:break-word;"> Father Name </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Sex </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Phone1 </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Pid1 </th>					
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Time_of Birth </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Birth weight </th>
					<th style="text-align:center;width:200px;word_wrap:break-word;"> Thayicard No. </th>	
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Taluk From </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Taluk To </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Community From </th>
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Community To </th>					
					<th style="text-align:center;width:100px;word_wrap:break-word;"> Survey Type </th>	
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
						BasicDBObject facility = (BasicDBObject)jsonArray.get(i).get("facility");
						BasicDBObject data = (BasicDBObject)jsonArray.get(i).get("data");
						//System.out.println("facility data are = "+facility);
						//System.out.println("data are = "+data);
						
						ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
						//System.out.println("_id object are="+objid);
							
						//convert ObjectID into date format
						Date enterDate = objid.getDate();
						SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:ss:mm a");
						java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
						sdf1.setTimeZone(tz);
						String formatDate = sdf1.format(enterDate);
						
						//get facility fields						
						if(facility.containsField("from_date"))
						{
							bd.from_date = facility.getString("from_date");	
						}
						else
						{
							bd.from_date = "-";
						}
						if(facility.containsField("to_date"))
						{
							bd.to_date = facility.getString("to_date");	
						}
						else
						{
							bd.to_date = "-";
						}							
						bd.facility = facility.getInt("facility");
						
						//get data array fields
						if(data.containsField("dob1"))
						{
							bd.dob = data.getString("dob1");
						}
						else
							bd.dob = "-";
						if(data.containsField("unique_id"))
						{
							bd.u_id = data.getString("unique_id");
						}
						else
							bd.u_id = "-";															
								
						if(data.containsField("pid1"))
						{
							bd.pid1 = data.get("pid1");
							if(bd.pid1 instanceof String)
							{
								bd.pid1 = data.get("pid1");
							}
							else
							{
								bd.pid1 = data.getInt("pid1");
							}						
							//System.out.println("pid1:"+bd.pid1);
						}
						else{
							bd.pid1 = "-";
						}
								
						if(data.containsField("time_of_birth"))
						{
							bd.time_of_birth = data.getString("time_of_birth");
						}
						else
							bd.time_of_birth = "-";
						//to ckeck whether the time is in 12hrs format									
						String time12hrs = tc.convert24To12Format((String)bd.time_of_birth);
						//System.out.println("time in 24hrs format = "+bd.time_of_birth);
						//System.out.println("time in 12hrs format = "+time12hrs);
						//System.out.println();
						bd.time_of_birth = time12hrs;
								
						if(data.containsField("thayi_card_no"))
						{
							bd.thayi_card_no = data.getLong("thayi_card_no");
							//System.out.println("thayi_card_no:"+bd.thayi_card_no);
						}	
						else{
							bd.thayi_card_no ="-";
						}
								
						if(data.containsField("mother_name"))
						{
							bd.mother_name = data.getString("mother_name");
						}
						else
							bd.mother_name = "-";
								
						if(data.containsField("sex"))
						{
							bd.sex = data.getString("sex");//getInt("epic");
							if(bd.sex.equals("1"))
								bd.sex="Male";
							else bd.sex="Female";
						}
						else
							bd.sex = "-";
								
						if(data.containsField("phone1"))
						{
							bd.phone1 = data.getLong("phone1");
						}
						else
							bd.phone1 = "-";								
								
						if(data.containsField("birth_weight"))
						{
							bd.birth_weight = data.getInt("birth_weight");
							//System.out.println("birth_weight:"+bd.birth_weight);
						}	
						else{
							bd.birth_weight="-";
						}
								
						if(data.containsField("taluk_from"))
						{
							bd.taluk_from = data.get("taluk_from");
							if(bd.taluk_from instanceof String)
							{
								if(bd.taluk_from.equals("other"))
								{
									bd.taluk_from = data.get("taluk_from")+" [" +data.get("taluk_from-Comment")+"]";
									//System.out.println("taluk_from:"+bd.taluk_from);
								}
								else
								{
									bd.taluk_from = data.get("taluk_from");
								}
							}
							else
							{
								bd.taluk_from = data.getInt("taluk_from");
								//System.out.println("taluk_from:"+bd.taluk_from);
							}
						}	
						else{
								bd.taluk_from ="-";
						}
						
						if(data.containsField("taluk_to"))
						{
							bd.taluk_to = data.get("taluk_to");
							if(bd.taluk_to instanceof String)
							{
								if(bd.taluk_to.equals("other"))
								{
									bd.taluk_to = data.get("taluk_to")+" [" +data.get("taluk_to-Comment")+"]";
									//System.out.println("taluk_to:"+bd.taluk_to);
								}
								else
								{
									bd.taluk_from = data.get("taluk_to");
								}
							}
							else
							{
								bd.taluk_to = data.getInt("taluk_to");
								//System.out.println("uid:"+bd.taluk_to);
							}
						}
						else{
							bd.taluk_to="-";
						}
						
						if(data.containsField("community_to"))
						{
							bd.community_to = data.get("community_to");
							if(bd.community_to instanceof String)
							{
								if(bd.community_to.equals("other"))
								{
									bd.community_to = data.get("community_to")+" [" +data.get("community_to-Comment")+"]";
									//System.out.println("community_to:"+bd.community_to);
								}
							}
							else
							{
								bd.community_to = data.getInt("community_to");
								//System.out.println("community_to:"+bd.community_to);
							}
						}
						else{
							bd.community_to ="-";
						}
						
						if(data.containsField("community_from") )
						{
							bd.community_from = data.get("community_from");
							if(bd.community_from instanceof String)
							{
								if(bd.community_from.equals("other"))
								{
									bd.community_from = data.get("community_from")+" [" +data.get("community_from-Comment")+"]";
									//System.out.println("community_from:"+bd.community_from);
								}
							}						
							else
							{
								bd.community_from = data.getInt("community_from");
								//System.out.println("community_from:"+bd.community_from);
							}
						}
						else{
							bd.community_from = "-";
						}
								
						if(data.containsField("husband_name"))
						{
							bd.husband_name = data.getString("husband_name");
						}
						else
							bd.husband_name = "-";
								
						if(data.containsField("surveyType"))
						{	
							bd.surveytype = data.getString("surveyType");	
						}
						else
							bd.surveytype="-";
						
						if(data.containsField("unique_id")){
							bd.uid=data.get("unique_id");
						}
						else{
							bd.uid="-";
						}
						
						//check for delete_id exists or not	
						if(data.containsField("d_id"))
						{
							delete_id="exists yes";
							System.out.println("delete_id = "+delete_id);
						}
						else
						{
							delete_id="exists no";
							System.out.println("delete_id = "+delete_id);
						}
						
						if(delete_id.equals("exists no"))
						{
							%>
								<td style="width:100px;word_wrap:break-word;"><input type="checkbox" id="check" name="uid" value="<%= bd.uid%>"><%-- <%= (++count)%> --%></td>
								<td style="width:200px;word_wrap:break-word;"><%= objid%> <br><%= formatDate%></td>		
								<td style="width:200px;word_wrap:break-word;"><%= bd.uid%></td>				
								<td style="width:100px;word_wrap:break-word;"><%= bd.from_date +" to "+ bd.to_date%></td>						    	
								<td style="width:100px;word_wrap:break-word;"><%= bd.facility%></td> 
								<td style="width:100px;word_wrap:break-word;"><%= bd.dob%></td>										
								<td style="width:150px;word_wrap:break-word;"><%= bd.mother_name%></td>
								<td style="width:150px;word_wrap:break-word;"><%= bd.husband_name%></td>									
								<td style="width:100px;word_wrap:break-word;"><%= bd.sex%></td>
								<td style="width:100px;word_wrap:break-word;"><%= bd.phone1%></td>
								<td style="width:100px;word_wrap:break-word;"><%= bd.pid1%></td>
								<td style="width:100px;word_wrap:break-word;"><%= bd.time_of_birth%></td>
								<td style="width:100px;word_wrap:break-word;"><%= bd.birth_weight%></td>
								<td style="width:200px;word_wrap:break-word;"><%= bd.thayi_card_no%></td>	
								<td style="width:100px;word_wrap:break-word;"><%= bd.taluk_from%></td>
								<td style="width:100px;word_wrap:break-word;"><%= bd.taluk_to%></td>
								<td style="width:100px;word_wrap:break-word;"><%= bd.community_to%></td>
								<td style="width:100px;word_wrap:break-word;"><%= bd.community_from%></td>								
								<td style="word_wrap:break-word;"><%= bd.surveytype%></td>																	
							</tr> 
							<%
						}
						else
						{
							continue;
						}
						System.out.println();
					}	
				%>				
			</tbody>
			</table>
			</div>
			</div>
			<button type="submit" name="btn" id="delbtn" value="merge" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="Selected babies will be deleted" onclick="return validate(this.id)">Duplicate</button> &nbsp;	&nbsp;	
			<button type="submit" name="btn" id="grpbtn" value="group" class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="Selected babies are twince" onclick="return validate(this.id)">Group</button>	&nbsp;	&nbsp;	
			<button type="submit" name="btn" id="radbtn" value="readmit" class="btn btn-primary" data-toggle="tooltip" data-placement="right" title="Selected babies are re-admitted" onclick="return validate(this.id)">Re-Admission</button>
			</form>
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
	<%-- <%@include file="tableexport.jsp" %>	 --%>	
</body>
</html>