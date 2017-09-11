<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		
		<title> Redcap </title>  				
  		<script src="facilities.js">	</script>
  		<script src="taluks.js">	</script>
		<script src="ken_kmc_html.js"></script>		
		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
		
		<%
			String datefrom = request.getParameter("datefrom");	
			String dateto=null;
			dateto=request.getParameter("dateto");
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
			if(datefrom == null)
			{
				Date today = new Date();
				String dtfrm = sdf.format(today); 
				System.out.println("date after convert ="+dtfrm);
				datefrom = dtfrm;				
			}
			else
			{				
				String[] datestr = datefrom.split("/");
			
				String newdate = datestr[1]+"/"+datestr[0]+"/"+datestr[2];
				datefrom = newdate;
			}
			if(dateto==null)
			{
				/* Calendar cal= Calendar.getInstance();
				cal.setTime(new Date(datefrom));
				cal.add(Calendar.DATE, 1);
				Date endDate= cal.getTime();
				dateto = sdf.format(endDate); */
				dateto=datefrom;
			}			
			else
			{				
				String[] dateend = dateto.split("/");
				String newdate1 = dateend[1]+"/"+dateend[0]+"/"+dateend[2];
				dateto=newdate1;
			}
				
			out.println("start date in jsp="+datefrom);
			out.println("end date in jsp="+dateto);
			String facility = request.getParameter("facility");
			if(facility==null)
			{
				facility ="all";
			}	
			else
			{
				facility =request.getParameter("facility");
			}
			//out.println("facility ="+facility);
		%>		
		
		<form name="myform" id="myform" method="GET">
			<!-- for store facility value -->			
			<input type="hidden" id="facility" name="facility"/>	
		</form>
				
		<%
			//response.setContentType("text/html");					
			try
			{
				String facValues=null;
				int facilityvalue =0;
				if(!facility.equals("all"))
				{
					facilityvalue =Integer.parseInt(facility);
				}								
				facValues=facility;
				out.println("facility values = "+facValues);		
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
				com.kentropy.mongodb.MongoDAO mongodao1 = new com.kentropy.mongodb.MongoDAO(db,redcap);				
				com.kentropy.mongodb.Classification classify = new com.kentropy.mongodb.Classification();
				int size = classify.classifyLbwOneDay(new Date(datefrom),new Date(dateto),facValues,mongodao);
				if(size>0)
				{
					int result=classify.generate20Percent(new Date(datefrom),new Date(dateto),facValues,mongodao, mongodao1,counter);
				}
				else
				{
					out.println("<span style=color:red> No records found in DB between given date "+datefrom+" and facility "+facility+"</span>");
				}
				//out.println("jsonarray size ="+jsonArray.size());
								
				//System.out.println("json array size ="+jsonArray.size());
			}//close try block
			catch(Exception e)
			{
				System.out.println(e);
			}
		%>	
	</body>
</html>