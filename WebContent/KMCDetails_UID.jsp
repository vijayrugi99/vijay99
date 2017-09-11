<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> KMC Details </title>
		<script src="facilities.js">	</script>		
		<script src="ken_kmc_html.js"></script>	
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
		<%-- <%@ include file="home.jsp" %> --%>
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>
		<%@include file="tableexport.jsp" %>		
      	
      	<% //String value = request.getParameter("facility"); 
			String data_uid_value = request.getParameter("unique_id");
			System.out.println("unique_id inside kmc_details file = "+data_uid_value);
		%> 		
		
		<h1 style = "color:brown; text-align:center; margin-top:10px" > KMC Details </h1>				
		<%		
			ArrayList<DBObject> obj = new com.kentropy.mongodb.MongoDAO("test","test").getBaby(request.getParameter("unique_id"));
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
			<table>			
				<tr>
					<td> <b>Facility</b> </td><td> <b>Mother Name </b></td><td> <b>Husband Name</b> </td><td><b> DOB</b> </td><td><b> Sex</b> </td><td><b> Birth_Weight</b> </td>
				</tr>
				<tr>
					<td> <%= babyFacility.getInt("facility")%> </td>
					<td> <%= babyData.get("mother_name")%> </td>
					<td> <%= babyData.get("husband_name")%> </td>
					<td> <%= babyData.get("dob1")%> </td>
					<td> <%= s%> </td>
					<td> <%= babyData.get("birth_weight")%> </td>
				</tr>
			</table>
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
				//int facility = Integer.parseInt(value);
				//System.out.println("facility in kmc_details page = "+facility);				
				System.out.println("unique_id = "+data_uid_value);
				ArrayList<DBObject> jsonArray = mongodao.getBaby1(data_uid_value);
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
				<center>
				<table width=1000 id="kmc_details">
				<tr style = color:black>
					<th colspan=6> KMC-Initiated Details </th>					
					<th colspan=6> KMC Details </th>
					<th colspan=1> Total Time(Minutes) </th>
					<th colspan=5> CC Details </th>					
				</tr>
				<tr style = color:brown>
					<th width=50> SI. No. </th>									
					<th width=40> KMC_Reg_No </th>
					<th width=30> Date_Of_KMC_Initiation </th>
					<th width=30> Time_Of_KMC_Initiation </th>
					<th width=30> KMC_Provider </th>
					<th width=30> Feed_Type </th>
					<th width=30> KMC_Date </th>
					<th width=30> KMC_Done </th>					
					<th width=50> Feed Type </th>
					<th width=50> Survey_Type </th>					
					<th width=200> From to To time </th>
					<th width=75> Total Hrs </th>	
					<th width=100> Time(Minutes) </th>
					
					<th width=100> Visit_Date </th>
					<th width=100> KMC_Period </th>
					<th width=100> Baby_alive </th>
					<th width=100> Mother_Alive </th>
					<th width=100> Age </th>														
				</tr>
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
						comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");
						//System.out.println("comp_docs = "+comp_obj);
						//System.out.println("comp_obj size is when more than 1 = "+comp_obj.size());
						
						//comp_docs 0th array elements 
						comp_obj_0 = (BasicDBObject)comp_obj.get(0);
						//System.out.println("comp_obj at 0 = "+comp_obj_0);					
						
						//no_of_days of kmc initiated						
						for(int j=1; j<comp_obj.size(); j++)
						{
							++dateCount;
							comp_obj_1 = (BasicDBObject)comp_obj.get(j);
							System.out.println("comp_obj_"+j+" is "+comp_obj_1);	
							
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
							System.out.println("no_of_days = "+dateCount);
						}						
						else
						{
							dt = comp_obj_0.getString("date_of_kmc_initiation");
						}						
						
						if(comp_obj_0.containsField("kmc_reg_no"))
						{
							bd.kmc_reg_no = comp_obj_0.get("kmc_reg_no");
						}
						else
							bd.kmc_reg_no = "-";
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
						
						//cc details
						if(comp_obj_0.containsField("visit_date"))
						{
							bd.visit_date=comp_obj_0.get("visit_date");									
						}
						else
						{
							bd.visit_date="-";
						}
						//System.out.println("visit date = "+bd.visit_date);
						if(comp_obj_0.containsField("kmc_period"))
						{
							bd.kmc_period=comp_obj_0.get("kmc_period");									
						}
						else
						{
							bd.kmc_period="-";
						}
						//System.out.println("kmc_period = "+bd.kmc_period);
						if(comp_obj_0.containsField("baby_alive"))
						{
							bd.baby_alive=comp_obj_0.get("baby_alive");
						}
						else
						{
							bd.baby_alive="-";
						}
						//System.out.println("baby_alive = "+bd.baby_alive);
						if(comp_obj_0.containsField("mother_alive"))
						{
							bd.mother_alive=comp_obj_0.get("mother_alive");
						}
						else
						{
							bd.mother_alive="-";
						}
						//System.out.println("mother_alive = "+bd.mother_alive);
						if(comp_obj_0.containsField("age"))
						{
							bd.age=comp_obj_0.get("age");
						}
						else
						{
							bd.age="-";
						}			
						//System.out.println("age = "+bd.age);
						if(comp_obj_0.containsField("surveyType"))
						{
							bd.kmc_survey_type = comp_obj_0.get("surveyType");
						}
						else
						{
							bd.kmc_survey_type = "-";
						}
						//comp_docs size more than 1							
						if(comp_obj.size() > 1 )
						{
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
								
								//cc details
								if(comp_obj_1.containsField("visit_date"))
								{
									bd.visit_date=comp_obj_1.get("visit_date");									
								}
								else
								{
									bd.visit_date="-";
								}
								//System.out.println("visit date = "+bd.visit_date);
								if(comp_obj_1.containsField("kmc_period"))
								{
									bd.kmc_period=comp_obj_1.get("kmc_period");									
								}
								else
								{
									bd.kmc_period="-";
								}
								//System.out.println("kmc_period = "+bd.kmc_period);
								if(comp_obj_1.containsField("baby_alive"))
								{
									bd.baby_alive=comp_obj_1.get("baby_alive");
								}
								else
								{
									bd.baby_alive="-";
								}
								//System.out.println("baby_alive = "+bd.baby_alive);
								if(comp_obj_1.containsField("mother_alive"))
								{
									bd.mother_alive=comp_obj_1.get("mother_alive");
								}
								else
								{
									bd.mother_alive="-";
								}
								//System.out.println("mother_alive = "+bd.mother_alive);
								if(comp_obj_1.containsField("age"))
								{
									bd.age=comp_obj_1.get("age");
								}
								else
								{
									bd.age="-";
								}			
								//System.out.println("age = "+bd.age);								
								//System.out.println("kmc date = "+bd.kmc_date);
								//bd.kmc_survey_type = comp_obj_1.get("surveyType");								
													
								double totmin = 0;
								//kmc_time_slots details
								if(comp_obj_1.containsKey("kmc_time_slots_today")) //check for if kmc_slot array is present
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
										/* System.out.println("kmc date = "+bd.kmc_date);
										System.out.println("from time = "+fromTime);
										System.out.println("to time = "+toTime); */
										
										double diffInTime = timeDiff.timeCalculation(date,fromTime, toTime);
										hr = (int)diffInTime;
									    min = (diffInTime - (int)diffInTime)*60;
									    //System.out.println("Difference b/w = "+hr+"hr "+Math.round(min)+"mins");
									    totalHr = totalHr+hr;
									   	totalMin = totalMin+min;							   										    							   	
									   	
										if(!comp_obj_1.containsField("discharged")) //check discharged or not after kmc initiated
										{	
											//System.out.println("kmc_timeslot size  = "+kmc_slot_size);
											//System.out.println("inisde if");
											%>												
												<td> <%= bd.kmc_feed_type%> </td>	
												<td> <%= bd.kmc_survey_type%> </td>																		
												<td> <%= bd.kmc_from_time%> <%= bd.kmc_from_meridian%> - <%= bd.kmc_to_time%> <%= bd.kmc_to_meridian%></td>
												<td> <%= hr%>hr <%= Math.round(min)%>mins</td>										 
											<%
										}										
									    else
									    {
									    	//System.out.println("Inside else");
										    BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
										    disStatus = disList.get(0);
										   //System.out.println("discahrge status ="+disStatus);
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
											System.out.println("inisde if2");
										 %>											 
											<td > <center> <table> <td> <%= totmin%> </td> </table> </center> </td>
											<td> <%= bd.visit_date%> </td>
											<td> <%= bd.kmc_period%> </td>
											<td> <%= bd.baby_alive%> </td>
											<td> <%= bd.mother_alive%> </td>
											<td> <%= bd.age%> </td>										
										</tr> 							
										<% 
										}
										else
										{
											//System.out.println("inisde else-if2");											
											%>
												<td> - </td>
												<td> <%= bd.visit_date%> </td>
												<td> <%= bd.kmc_period%> </td>
												<td> <%= bd.baby_alive%> </td>
												<td> <%= bd.mother_alive%> </td>
												<td> <%= bd.age%> </td>	
											</tr> 
											<%
										}										
									}//close for loop of kmc slot
									%>
									<td colspan = 13> </td>
									<%
									System.out.println(); 																		
									//System.out.println("startDate = "+startDate+"last date ="+lastDate);
								}//close if of kmc_time_slots
								
								else //check for no kmc_slot array
								{	
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
										<td> <%= bd.visit_date%> </td>
										<td> <%= bd.kmc_period%> </td>
										<td> <%= bd.baby_alive%> </td>
										<td> <%= bd.mother_alive%> </td>
										<td> <%= bd.age%> </td>	
									</tr>
									<%									
								}
								kmcMinute = kmcMinute+totmin;								
								//System.out.println("total kmc time in min="+kmcMinute);
							}//close for loop itertae through each array of comp_obj							
						}//close if comp_docs size
						else //comp_docs size is one
						{	
							//System.out.println("comp_obj size when 1 = "+comp_obj.size());
							if(comp_obj_0.containsField("kmc_initiation"))
							{
								if(comp_obj_0.get("kmc_initiation").equals("Initiated"))
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
											<td> <%= bd.kmc_done%> </td>
											<td> - </td>
											<td> <%= bd.kmc_survey_type%> </td>
											<td> - </td>
											<td> - </td>
											<td> - </td>											
											<td> <%= bd.visit_date%> </td>
											<td> <%= bd.kmc_period%> </td>
											<td> <%= bd.baby_alive%> </td>
											<td> <%= bd.mother_alive%> </td>
											<td> <%= bd.age%> </td>								
										</tr>
										<%
								}
							}
							else
							{
								//System.out.println("inside else4");
								%>							
									<tr>
										<td> <%= (++count)%> </td>	
										<td> <%= bd.kmc_reg_no%> </td>
										<td> <%= bd.date_of_kmc_initiation%> </td>
										<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>
										<td> <%= kmc_provider%> </td>
										<td> <%= kmc_feed_type%> </td>
										<td> <%= bd.kmc_date%> </td>
										<td> <%= bd.kmc_done%> </td>
										<td> - </td>
										<td> <%= bd.kmc_survey_type%> </td>
										<td> - </td>
										<td> - </td>
										<td> - </td>										
										<td> <%= bd.visit_date%> </td>
										<td> <%= bd.kmc_period%> </td>
										<td> <%= bd.baby_alive%> </td>
										<td> <%= bd.mother_alive%> </td>
										<td> <%= bd.age%> </td>								
									</tr>
									<%
							}							
						}//close comp_size=1 					
					}//if close for unique id compare						
				}//close jsonArray loop				
				%>								
				</table>
				</center>
				<br />
				<br />	
				<center>
					<form>
						<h4 style="color:brown">No_Days_KMC = <input type="text" id="days" name="days" value=<%= dateCount%> size="10" style="text-align:center" disabled></h4>					 
						<h4 style="color:brown">Total Time(Minutes) = <input type="text" id="days" name="days" value=<%= kmcMinute%> size="10" style="text-align:center" disabled></h4>
					</form>
				</center>
				<%			
			}//close try block			
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
				e.printStackTrace();
			}				
		%>			
	</body>
</html>