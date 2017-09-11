<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> KMC  Details </title>
		<script src="facilities.js">	</script>		
		<script src="ken_kmc_html.js"></script>	
  		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">  		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<!-- must include -->
	   	<style>
	   		.table>thead>tr{background-color:#F0E68c}
	   		.table>thead>tr>th{vertical-align:middle}
		   .table>tbody>tr>td{vertical-align:middle;}
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
			.tableheader {
				width: 1300px;
				margin-bottom:0px;
				border:1px solid #999;			
			}
			.tablebody {
				height: 300px;
				overflow-y: auto;
				width: 1300px;
				margin-bottom:20px;
			}
		</style>		
	</head>
	<script>
	function goBack() {
	    window.history.back();
	}
	</script>
	
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
		<%-- <%@ include file="home.jsp"%> --%>
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>
		<%@include file="tableexport.jsp" %>		
      	
      	<% String value = request.getParameter("facility"); 
			String data_uid_value = request.getParameter("unique_id");
			System.out.println("unique_id inside kmc_details file = "+data_uid_value);
		%> 		
		
		<h1 style = "color:brown; text-align:center; margin-top:10px" > KMC Details </h1>				
		<%		
			ArrayList<DBObject> obj = new com.kentropy.mongodb.MongoDAO(db,coll).getBaby(request.getParameter("unique_id"));
			BasicDBObject babyFacility = (BasicDBObject)obj.get(0).get("facility");	
			BasicDBObject babyData = (BasicDBObject)obj.get(0).get("baby_NoKMC");
			char s = '-';
			if(babyData.containsField("sex"))
			{
				Object sex =  babyData.get("sex");							
				System.out.println("sex = "+sex);		
				if(sex.equals("1"))
				{
					s = 'M';
				}
				else if(sex.equals("2"))
				{
					s = 'F';
				}
			}
			else
			{
				s= '-';
			}
						
		%>					
			<center>
			<div class="container">
			<div class="row">			
			<div class="table-responsive">
			<table class="table table-bordered table-striped">			
			<thead>		
				<tr>
					<td> <b>Facility</b> </td>
					<td> <b>Mother Name </b></td>
					<td> <b>Husband Name</b> </td>
					<td><b> DOB</b> </td>
					<td><b> Sex</b> </td>
					<td><b> Birth_Weight</b> </td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td> <%= babyFacility.getInt("facility")%> </td>
					<td> <%= babyData.get("mother_name")%> </td>
					<td> <%= babyData.get("husband_name")%> </td>
					<td> <%= babyData.get("dob1")%> </td>
					<td> <%= s%> </td>
					<td> <%= babyData.get("birth_weight")%> </td>
				</tr>
			</tbody>
			</table>
			</div>
			</div>
			</div>
			</center>			
			<br />			
		<%	
			//response.setContentType("text/html");				
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
				int facility = Integer.parseInt(value);
				System.out.println("facility in kmc_details page = "+facility);				
				System.out.println("unique_id = "+data_uid_value);
				ArrayList<DBObject> jsonArray = mongodao.kmcDischargeRecords(facility);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				com.kentropy.kmc.bean.TimeCalculation timeDiff = new com.kentropy.kmc.bean.TimeCalculation();	
				int count=0;	
				
				//today date calculation
				SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
				String  enddate = sdf.format(new Date());
				Calendar ca = Calendar.getInstance();
				ca.setTime(sdf.parse(enddate));
				ca.add(Calendar.DATE, -1);  //today-1 day
				enddate = sdf.format(ca.getTime());
				System.out.println("yesterday date = "+enddate);				
				
				%>				
				<div class="container">
				<div class="row">
				<div class="table-responsive2">								
				<table class="table table-bordered table-striped tableheader">
				<thead>
				<tr>
					<th colspan="6" style="text-align:center;"> KMC-Initiated Details </th>					
					<th colspan="6" style="text-align:center;"> KMC Details </th>
					<th colspan="1" style="word-wrap:break-word;text-align:center;"> Total Time (Min) </th>					
				</tr>				
				<tr>
					<th style="text-align:center;"> SI. No. </th>									
					<th style="text-align:center;"> KMC Reg_No </th>
					<th style="text-align:center;word-wrap:break-word;"> Date</th>
					<th style="text-align:center;word-wrap:break-word;"> Time</th>
					<th style="text-align:center;"> KMC Provider </th>
					<th style="text-align:center;"> Feed Type </th>
					<th style="text-align:center;"> KMC Date </th>
					<th style="text-align:center;"> KMC Done </th>					
					<th style="text-align:center;"> Feed Type </th>
					<th style="text-align:center;"> SurveyType </th>					
					<th style="text-align:center;"> From to To time </th>
					<th style="text-align:center;"> Total Hrs </th>	
					<th style="text-align:center;word-wrap:break-word;"> Time(Minutes) </th>									
				</tr>				
				</thead>
				</table>
				<div class="tablebody">
                <table class="table table-striped">
                <tbody>
				<% 
				int dateCount = 0;
				String dt = null;
				Object date_of_initiation = "-";
				BasicDBList comp_obj = null;
				BasicDBObject comp_obj_0 = null;				
				BasicDBObject comp_obj_1 = null;
				BasicDBList kmc_details = null;
				BasicDBObject kmc_timeslot = null;
				Object disStatus = "-";
				Object kmc_provider="-";
				Object kmc_feed_type="-";
				Object date_kmc="-";
				int hr =0;
				double min = 0;
				int totalHr = 0;
				double totalMin = 0;
				double kmcMinute=0;
				for(int i=0; i<jsonArray.size(); i++)
				{
					//System.out.println("DBObjects are ="+jsonArray.get(i));
					ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
					//System.out.println("Objet id are ="+objid);		
					
					BasicDBObject facilityData = (BasicDBObject)jsonArray.get(i).get("facility");
					bd.facility = facilityData.getInt("facility");
					//System.out.println("Faility are ="+bd.facility);
					
					BasicDBObject data = (BasicDBObject)jsonArray.get(i).get("data");
					bd.dob = data.get("dob1");
					bd.mother_name = data.get("mother_name");
					bd.husband_name = data.get("husband_name");
					bd.kmc_unique_id = data.get("unique_id");
					
					if(data_uid_value.equals(bd.kmc_unique_id))
					{
						//System.out.println(data_uid_value);
						comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");
						//System.out.println("comp_docs = "+comp_obj);
						//System.out.println("comp_obj size is = "+comp_obj.size());
						
						//comp_docs 0th array elements 
						comp_obj_0 = (BasicDBObject)comp_obj.get(0);
						//System.out.println("comp_obj at 0 = "+comp_obj_0);					
						
						//no_of_days of kmc initiated						
						for(int j=1; j<comp_obj.size(); j++)
						{
							//++dateCount;
							comp_obj_1 = (BasicDBObject)comp_obj.get(j);
							//System.out.println("comp_obj_"+j+" is "+comp_obj_1);	
							
							if(comp_obj_1.containsField("date"))
							{
								bd.kmc_date = comp_obj_1.get("date");	
								if(comp_obj_1.containsField("kmc_done"))
								{
									bd.kmc_done = comp_obj_1.get("kmc_done");								
									if(comp_obj_1.get("kmc_done").equals("Yes"))
									{
										++dateCount;
									}
								}
							}
							else
							{
								bd.kmc_date = "-";
							}								
							//System.out.println("comp_obj_"+j+" date is "+bd.kmc_date);							
						}
						//System.out.println("last entered date = "+bd.kmc_date);
						
						//convert last entered date to next day						
						if(!bd.kmc_date.equals("-"))
						{
							dt = (String)bd.kmc_date;
							Calendar c = Calendar.getInstance();
							c.setTime(sdf.parse(dt));
							c.add(Calendar.DATE, 1);  
							dt = sdf.format(c.getTime());
							//System.out.println("last date after convert to next Date= "+dt);
							//System.out.println("no_of_days = "+dateCount);							
							//System.out.println("start date in if="+dt);
						}						
						else
						{
							dt = comp_obj_0.getString("date_of_kmc_initiation");
							System.out.println("start date in else="+dt);
						}						
						
						bd.kmc_reg_no = comp_obj_0.get("kmc_reg_no");
						//System.out.println("kmc_reg_no = "+bd.kmc_reg_no);
						if(comp_obj_0.containsField("init_date1"))
							bd.date_of_kmc_initiation = comp_obj_0.get("init_date1");
						else
							bd.date_of_kmc_initiation = "-";							
						System.out.println("init_date = "+bd.date_of_kmc_initiation);
						
						if(comp_obj_0.containsField("date_of_kmc_initiation"))
							date_of_initiation = comp_obj_0.get("date_of_kmc_initiation");
						else
							date_of_initiation = "-";								
							
						if(comp_obj_0.containsField("date"))
							date_kmc = comp_obj_0.get("date");
						else
							date_kmc = "-";
						
						if(comp_obj_0.containsField("time_of_kmc_initiation"))
							bd.time_of_kmc_initiation = comp_obj_0.get("time_of_kmc_initiation");
						else
							bd.time_of_kmc_initiation = "-";	
							
						if(comp_obj_0.containsField("am_pm"))
							bd.am_pm = comp_obj_0.get("am_pm");	
						else
							bd.am_pm = "-";							
						
						if(comp_obj_0.containsField("kmc_provider"))
						{														
							kmc_provider = comp_obj_0.get("kmc_provider");
							//System.out.println("kmc_provider = "+kmc_provider);
						}
						else
						{
							kmc_provider = "-";
						}						
						
						if(comp_obj_0.containsField("feed_type"))
						{
							kmc_feed_type = comp_obj_0.get("feed_type");
						}
						else
						{
							kmc_feed_type = "-";
						}
						//System.out.println("feedtype = "+bd.kmc_feed_type);						
						
						//comp_docs more than 0th array list							
						if(comp_obj.size() > 1 )
						{
							if(!comp_obj_0.containsField("kmc_initiation"))
							{
								if(comp_obj_1.containsField("discharged"))
								{
									BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
								    disStatus = disList.get(0);
								    //System.out.println("dis status ="+disStatus);
								}
							}
							else if(comp_obj_0.containsField("kmc_initiation"))
							{
								if(comp_obj_0.get("kmc_initiation").equals("Initiated"))
								{
									if(comp_obj_1.containsField("discharged"))
									{
										BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
									    disStatus = disList.get(0);
									    //System.out.println("dis status ="+disStatus);
									}
								}
							}
						
							//double kmcMinute=0;
							for(int j=1; j<comp_obj.size(); j++)
							{
								comp_obj_1 = (BasicDBObject)comp_obj.get(j);
								//System.out.println("comp_obj_"+j+" is "+comp_obj_1);
								if(comp_obj_1.containsField("kmc_done"))
								{
									bd.kmc_done = comp_obj_1.get("kmc_done");
								}
								else
								{
									bd.kmc_done = "-";
								}								
								
								if(comp_obj_1.containsField("date"))
								{
									bd.kmc_date = comp_obj_1.get("date");
								}
								else
								{
									bd.kmc_date = "-";
								}
								
								if(comp_obj_1.containsField("surveyType"))
								{
									bd.kmc_survey_type = comp_obj_1.get("surveyType");
								}
								else
								{
									bd.kmc_survey_type = "-";
								}								
								
								//System.out.println("kmc date = "+bd.kmc_date);
								//bd.kmc_survey_type = comp_obj_1.get("surveyType");
								
								double totmin = 0;
								//kmc_time_slots details
								if(comp_obj_1.containsField("kmc_time_slots_today")) //check for if kmc_slot array is present
								{									
									//BasicDBList kmc_timeslot = (BasicDBList)jsonArray.get(0).get("kmc_time_slots_today");	
									kmc_details = (BasicDBList)comp_obj_1.get("kmc_time_slots_today");
									int kmc_slot_size = kmc_details.size();
									//System.out.println("kmc_timeslot size = "+kmc_slot_size);
									//System.out.println("kmc_timeslot is "+kmc_details);	
									if(comp_obj_1.containsField("feed_type"))
									{
										bd.kmc_feed_type = comp_obj_1.get("feed_type");
									}
									else
									{
										bd.kmc_feed_type = "-";
									}
									
									int k=0;
									totalHr = 0;
									totalMin = 0;									
									%>															
									<tr>
										<td rowspan=<%= kmc_slot_size%>> <%= (++count)%> </td>	
										<td rowspan=<%= kmc_slot_size%>> <%= bd.kmc_reg_no%> </td>
										<td rowspan=<%= kmc_slot_size%>> <%= bd.date_of_kmc_initiation%> </td>
										<td rowspan=<%= kmc_slot_size%>> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>
										<td rowspan=<%= kmc_slot_size%>> <%= kmc_provider%> </td>										
										<td rowspan=<%= kmc_slot_size%>> <%= kmc_feed_type%> </td>
										<td rowspan=<%= kmc_slot_size%>> <%= bd.kmc_date%> </td>
										<td rowspan=<%= kmc_slot_size%>> <%= bd.kmc_done%> </td>
									<%
									
									for(k=0; k<kmc_details.size(); k++)
									{	
										hr=0;
										min=0;
										//get kmc_timeslot array elements
										kmc_timeslot = (BasicDBObject)kmc_details.get(k);
										bd.kmc_from_time = kmc_timeslot.get("from");
										bd.kmc_to_time = kmc_timeslot.get("to");					
										bd.kmc_from_meridian = kmc_timeslot.get("from_meridian");
										bd.kmc_to_meridian = kmc_timeslot.get("to_meridian");
										
										if(kmc_timeslot.containsField("feed_type"))
										{
											bd.kmc_feed_type = kmc_timeslot.get("feed_type");
										}
										else
										{
											bd.kmc_feed_type = "-";
										}
										
										//Time diffrence calculation
										String fromTime = bd.kmc_from_time+" "+bd.kmc_from_meridian;										
										String toTime = bd.kmc_to_time+" "+bd.kmc_to_meridian;
										String date = (String)bd.kmc_date;	
										//System.out.println("kmc date = "+bd.kmc_date);
										//System.out.println("from time = "+fromTime);
										//System.out.println("to time = "+toTime);
										
										double diffInTime = timeDiff.timeCalculation(date,fromTime, toTime);
										hr = (int)diffInTime;
									    min = (diffInTime - (int)diffInTime)*60;
									    //System.out.println("Difference b/w = "+hr+"hr "+Math.round(min)+"mins");
									    totalHr = totalHr+hr;
									   	totalMin = totalMin+min;							   										    							   	
									   	
										if(!comp_obj_1.containsField("discharged")) //check discharged or not after kmc initiated
										{	
											//System.out.println("kmc_timeslot size  = "+kmc_slot_size);
											//System.out.println("inisde kmcslot if");
											%>												
												<td> <%= bd.kmc_feed_type%> </td>	
												<td> <%= bd.kmc_survey_type%> </td>																		
												<td> <%= bd.kmc_from_time%> <%= bd.kmc_from_meridian%> - <%= bd.kmc_to_time%> <%= bd.kmc_to_meridian%></td>
												<td> <%= hr%>hr <%= Math.round(min)%>mins</td>										 
											<%
										}										
									    else
									    {
									    	//System.out.println("Inside kmcslot else");
										    BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
										    disStatus = disList.get(0);
										   //System.out.println("discharge status with kmcslot present="+disStatus);
										   %>												
												<td> <%= bd.kmc_feed_type%> </td>	
												<td> <%= bd.kmc_survey_type%> </td>																		
												<td> <%= bd.kmc_from_time%> <%= bd.kmc_from_meridian%> - <%= bd.kmc_to_time%> <%= bd.kmc_to_meridian%></td>
												<td> <%= hr%>hr <%= Math.round(min)%>mins</td>											
											<%
									  	}										
										//System.out.println("Total hrs = "+totalHr+"hr "+(int)totalMin+"mins");										
										int hrInMin = (int) Math.round(totalHr*60);
										totmin=hrInMin+totalMin;
										//System.out.println("total mins ="+totmin);
																				
										if(k == (kmc_slot_size-1))
										{
											//System.out.println("inisde if2");
										 %>											 
											<td > <center> <table> <td> <%= totmin%> </td> </table> </center> </td>											
										</tr> 									
										<% 
										}
										else
										{
											//System.out.println("inisde else-if2");											
											%>
												 <td> - </td>
											</tr> 
											<%
										}
										
									}//close for loop of kmc slot
									%>
									<td colspan = 13> </td>
									<%																											
									//System.out.println("startDate = "+startDate+"last date ="+lastDate);
								}//close if of kmc_time_slots
								
								else //check for no kmc_slot array
								{	
									if(comp_obj_1.containsField("discharged"))
									{
										BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
									    disStatus = disList.get(0);
									    //System.out.println("discharged when no kmc slot ="+disStatus);
									}
									//System.out.println("inisde else3");
									%>
									<tr>
									<td> <%= (++count)%> </td>	
									<td> <%= bd.kmc_reg_no%> </td>
									<td> <%= bd.date_of_kmc_initiation%> </td>
									<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>										
									<td> <%= kmc_provider%> </td>										
									<td> <%= bd.kmc_feed_type%> </td>
									<td> <%= bd.kmc_date%> </td>									
									<td> <%= bd.kmc_done%> </td>
									<td> -- </td>
									<td> <%= bd.kmc_survey_type%> </td>																		
									<td> -- </td>
									<td> -- </td>
									<td> -- </td>
									<%									
								}
								kmcMinute = kmcMinute+totmin;
								//System.out.println("total kmc time in min="+kmcMinute);
								System.out.println(); 
							}//close for loop itertae through each array of comp_obj							
						}//close if comp_docs size>0
						else //comp_docs size is one
						{							
							if(comp_obj_0.containsField("kmc_initiation"))
							{
								if(comp_obj_0.get("kmc_initiation").equals("Discharged without initiation"))
								{	
									//System.out.println("inside else-if-if");
									%>	
										<tr>
											<td> <%= (++count)%> </td>	
											<td> <%= bd.kmc_reg_no%> </td>						
											<td colspan = 10> KMC Not Initiated </td>
											<td> -- </td>
										</tr>
									<%
								}								
								else if(comp_obj_0.get("kmc_initiation").equals("Initiated"))
								{
									//System.out.println("inside else2 if");
									%>							
										<tr>
											<td> <%= (++count)%> </td>	
											<td> <%= bd.kmc_reg_no%> </td>
											<td> <%= bd.date_of_kmc_initiation%> </td>
											<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>
											<td> <%= kmc_provider%> </td>
											<td> <%= kmc_feed_type%> </td>
											<td> <%= bd.kmc_date%> </td>
											<td> - </td>
											<td> <%= bd.kmc_survey_type%> </td>
											<td> - </td>
											<td> - </td>
											<td> - </td>											
											<td> - </td>
										</tr>
									<%
								}									
							}
							else if(comp_obj_0.containsField("discharged"))//discharged but loop does'nt have date_kmc_initiation
							{
								if(comp_obj_0.containsField("date"))
								{
									//System.out.println("inside else if if");									
									%>	
									<tr>			
										<td> <%= (++count)%> </td>	
										<td>  </td>
										<td> <%= date_kmc%> </td>
										<td>  </td>
										<td>  </td>
										<td>  </td>
										<td>  </td>
										<td> <%= bd.kmc_done%> </td>
										<td>  </td>
										<td>  </td>
										<td>  </td>
										<td>  </td>																			
										<td> -- </td>
									</tr>
									<%
								}
								else
								{
									//System.out.println("inside else if else");
									%>	
									<tr>						
										<td colspan = 12> </td>
										<td> -- </td>
									</tr>
									<%
								}
							}
							else if(!comp_obj_0.containsField("kmc_initiation"))
							{								
								//System.out.println("inside else3 if");
								%>															
									<td colspan = 12> </td>
									<td> -- </td>
								</tr>
								<%								
							}							
						}					
					}//if close for unique id compare						
				}				
				%>	
				</tbody>							
				</table>
				</div>
				</div>											
				<br />								
				<% 
					//System.out.println("start date after loop= "+dt);
					if(comp_obj_0.containsField("kmc_initiation"))
					{
						//System.out.println("discharge status ="+disStatus);
						if(disStatus.equals("discharged"))
						{
							//System.out.println("inside if");
							%>			
							<center>
							<form class="form-inline">
							<div class="form-group">							
								<label style="font-size:15px; color:green">No_Days_KMC=</label>
								<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
							</div>
							<div class="form-group">					 
								<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
								<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
							</div>
							<div class="form-group">
								<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Enter Discharge Details" onClick="window.location.href='kmc-discharge-fi.jsp?baby=<%= data_uid_value%>'">								 	
							</div>
							<div class="form-group">
								<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
							</div>
							</form>
							</center>
							<%	
						}
						else if(comp_obj_0.get("kmc_initiation").equals("Initiated"))
						{	
							//System.out.println("start date inside else if1="+dt);
							if(dt == null)
							{
								//System.out.println("dis status at elseif1 ="+disStatus);
								//System.out.println("inside else if1");
								%>			
								<center>
								<form class="form-inline">
									<div class="form-group">							
										<label style="font-size:15px; color:green">No_Days_KMC=</label>
										<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
									</div>
									<div class="form-group">					 
										<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
										<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="kmc" name = "kmc" value = "Enter KMC_Init_Date" onClick="window.location.href='kmcinit-fi.jsp?baby=<%= data_uid_value%>'">								 	
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
									</div>
								</form>
								</center>
								<%
							}
							else
							{
								//System.out.println("dis status at elseif1 ="+disStatus);
								//System.out.println("inside else if1");
								%>			
								<center>
								<form class="form-inline">
									<div class="form-group">							
										<label style="font-size:15px; color:green">No_Days_KMC=</label>
										<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
									</div>
									<div class="form-group">					 
										<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
										<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="kmc" name = "kmc" value = "Enter KMC" onClick="window.location.href='kmc-fi.jsp?baby=<%= data_uid_value%>&start_date=<%= dt%>&end_date=<%= enddate%>'">								 	
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
									</div>
								</form>
								</center>
								<%
							}
						}
						else if(comp_obj_0.get("kmc_initiation").equals("Discharged without initiation"))
						{
							//System.out.println("inside else if2");
							%>			
							<center>
							<form class="form-inline">
								<div class="form-group">							
									<label style="font-size:15px; color:green">No_Days_KMC=</label>
									<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
								</div>
								<div class="form-group">					 
									<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
									<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
								</div>
								<div class="form-group">
									<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Enter Discharge Details" onClick="window.location.href='kmc-discharge-fi.jsp?baby=<%= data_uid_value%>'">								 	
								</div>
								<div class="form-group">
									<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
								</div>
							</form>
							</center>
							<%					
						}
					}
					else if(comp_obj_0.containsField("discharged"))
					{
						//System.out.println("inside else if3");
						%>			
						<center>
						<form class="form-inline">
							<div class="form-group">							
								<label style="font-size:15px; color:green">No_Days_KMC=</label>
								<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
							</div>
							<div class="form-group">					 
								<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
								<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
							</div>
							<div class="form-group">
								<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Enter Discharge Details" onClick="window.location.href='kmc-discharge-fi.jsp?baby=<%= data_uid_value%>'">								 	
							</div>
							<div class="form-group">
								<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
							</div>
						</form>
						</center>
						<%
					}
					else if(!comp_obj_0.containsField("kmc_initiation"))
					{
						//System.out.println("dis status at else4 ="+disStatus);
						//System.out.println("inside else if4");
						if(disStatus.equals("discharged"))
						{							
							%>			
							<center>
							<form class="form-inline">
								<div class="form-group">							
									<label style="font-size:15px; color:green">No_Days_KMC=</label>
									<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
								</div>
								<div class="form-group">					 
									<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
									<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
								</div>
								<div class="form-group">
									<input type="button" style="color:black;" class="btn btn-info" id="kmc" name = "kmc" value = "Enter Discharge Details" onClick="window.location.href='kmc-discharge-fi.jsp?baby=<%= data_uid_value%>'">								 	
								</div>
								<div class="form-group">
									<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
								</div>
							</form>
							</center>
							<%
						}
						else
						{
							//System.out.println("start date inside else if4="+dt);
							if(dt == null)
							{
								%>			
								<center>
								<form class="form-inline">
									<div class="form-group">							
										<label style="font-size:15px; color:green">No_Days_KMC=</label>
										<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
									</div>
									<div class="form-group">					 
										<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
										<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="kmc" name = "kmc" value = "Enter KMC_Init_Date" onClick="window.location.href='kmcinit-fi.jsp?baby=<%= data_uid_value%>'">								 	
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
									</div>
								</form>
								</center>
								<%
							}
							else
							{
								%>			
								<center>
								<form class="form-inline">
									<div class="form-group">							
										<label style="font-size:15px; color:green">No_Days_KMC=</label>
										<input type="text" id="days" name="days" value=<%= dateCount%> disabled>
									</div>
									<div class="form-group">					 
										<label style="font-size:15px; color:green">Total Time(Minutes)=</label>
										<input type="text" id="days" name="days" value=<%= kmcMinute%> disabled>
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="kmc" name = "kmc" value = "Enter KMC" onClick="window.location.href='kmc-fi.jsp?baby=<%= data_uid_value%>&start_date=<%= dt%>&end_date=<%= enddate%>'">								 	
									</div>
									<div class="form-group">
										<input type="button" style="color:black;" class="btn btn-info" id="dis" name = "dis" value = "Go-Back" onClick="goBack()">								 	
									</div>
								</form>								
								</center>
								<%
							}						
						}
					}					
				}//close try block			
				catch(Exception  e)
				{
					System.out.println("Exception::"+e);
					e.printStackTrace();
				}				
				%>	
				</div>
				</div>	
	</body>
</html>