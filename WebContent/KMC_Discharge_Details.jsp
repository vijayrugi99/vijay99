<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> KMC  Details </title>
		<script src="facilities.js">	</script>		
		<script src="ken_kmc_html.js"></script>	
		<!-- style for excel sheet  -->
		<style>
			table, th, tr{ 	
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
      	
      	<% String value = request.getParameter("facility"); 
			String data_uid_value = request.getParameter("unique_id");
			System.out.println("unique_id inside kmc_details file = "+data_uid_value);
		%> 
		
      	<center>
       	<div id="ctrls"></div>
      		<script>
      			ctrls.innerHTML=ExportToexcelWithParameter("KMC_Discharge_Details.jsp?facility=<%= value%>&unique_id=<%= data_uid_value%>","KmcDischargeDetails.xls",<%=request.getParameter("hideCtrls")!=null%>)
       		</script>
      	</center> 
     
		<h1 style = "color:brown; text-align:center; margin-top:50px" > KMC Details </h1>				
		<%		
			ArrayList<DBObject> obj = new com.kentropy.mongodb.MongoDAO("test","test").getBaby(request.getParameter("unique_id"));
			BasicDBObject babyFacility = (BasicDBObject)obj.get(0).get("facility");	
			BasicDBObject babyData = (BasicDBObject)obj.get(0).get("baby_NoKMC");
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
					<td> <%= babyData.get("sex")%> </td>
					<td> <%= babyData.get("birth_weight")%> </td>
				</tr>
			</table>
			</center>			
			<br />
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
				ca.add(Calendar.DATE, -1);  
				enddate = sdf.format(ca.getTime());
				System.out.println("yesterday date = "+enddate);				
				
				%>				
				<center>
				<table width=1200>
				<tr style = color:black>
					<th colspan=4> KMC-Initiated Details </th>					
					<th colspan=6> KMC Details </th>
					<th colspan =2> Status </th>
				</tr>
				<tr style = color:brown>
					<th width=50> SI. No. </th>									
					<th width=40> KMC_Reg_No </th>
					<th width=30> Date_Of_KMC_Initiation </th>
					<th width=30> Time_Of_KMC_Initiation </th>
					<th width=30> KMC_Date </th>
					<th width=30> KMC_Done </th>
					<th width=200> From to To time </th>
					<th width=75> Hours_of_KMC_service </th>
					<th width=50> Feed Type </th>
					<th width=50> Survey_Type </th>						
					<th width=50> Discharge Status </th>				
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
				int hr =0;
				double min = 0;
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
					
					BasicDBObject data = (BasicDBObject)jsonArray.get(i).get("data");
					bd.dob = data.get("dob1");
					bd.mother_name = data.get("mother_name");
					bd.husband_name = data.get("husband_name");
					bd.kmc_unique_id = data.get("unique_id");
					
					if(data_uid_value.equals(bd.kmc_unique_id))
					{
						comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");
						//System.out.println("comp_docs = "+comp_obj);
						System.out.println("comp_obj size is = "+comp_obj.size());
						
						//comp_docs 0th array elements 
						comp_obj_0 = (BasicDBObject)comp_obj.get(0);
						
						//no_of_days of kmc initiated						
						for(int j=1; j<comp_obj.size(); j++)
						{
							++dateCount;
							comp_obj_1 = (BasicDBObject)comp_obj.get(j);
							//System.out.println("comp_obj_"+j+" is "+comp_obj_1);						
							bd.kmc_date = comp_obj_1.get("date");
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
						}						
						else
						{
							dt = comp_obj_0.getString("date_of_kmc_initiation");
						}						
						
						bd.kmc_reg_no = comp_obj_0.get("kmc_reg_no");
						System.out.println("kmc_reg_no = "+bd.kmc_reg_no);
						if(comp_obj_0.containsField("init_date1"))
							bd.date_of_kmc_initiation = comp_obj_0.get("init_date1");
						else
							bd.date_of_kmc_initiation = "-";							
							
						if(comp_obj_0.containsField("date_of_kmc_initiation"))
							date_of_initiation = comp_obj_0.get("date_of_kmc_initiation");
						else
							date_of_initiation = "-";								
							
						if(comp_obj_0.containsField("time_of_kmc_initiation"))
							bd.time_of_kmc_initiation = comp_obj_0.get("time_of_kmc_initiation");
						else
							bd.time_of_kmc_initiation = "-";	
							
						if(comp_obj_0.containsField("am_pm"))
							bd.am_pm = comp_obj_0.get("am_pm");	
						else
							bd.am_pm = "-";	
																	
						//comp_docs more than 0th array list							
						if(comp_obj.size() > 1 )
						{
							for(int j=1; j<comp_obj.size(); j++)
							{
								comp_obj_1 = (BasicDBObject)comp_obj.get(j);
								System.out.println("comp_obj_"+j+" is "+comp_obj_1);
								bd.kmc_done = comp_obj_1.get("kmc_done");
								
								bd.kmc_date = comp_obj_1.get("date");
								bd.kmc_survey_type = comp_obj_1.get("surveyType");								
								
								//kmc_time_slots details
								if(comp_obj_1.containsKey("kmc_time_slots_today"))
								{
									System.out.println("contains key no");
									//BasicDBList kmc_timeslot = (BasicDBList)jsonArray.get(0).get("kmc_time_slots_today");	
									kmc_details = (BasicDBList)comp_obj_1.get("kmc_time_slots_today");
									int kmc_slot_size = kmc_details.size();
									System.out.println("kmc_timeslot is "+kmc_details.size());
									//System.out.println("kmc_timeslot is "+kmc_details);
									System.out.println();									
									int k=0;
									for(k=0; k<kmc_details.size(); k++)
									{											
										kmc_timeslot = (BasicDBObject)kmc_details.get(k);
										bd.kmc_from_time = kmc_timeslot.get("from");
										bd.kmc_to_time = kmc_timeslot.get("to");					
										bd.kmc_from_meridian = kmc_timeslot.get("from_meridian");
										bd.kmc_to_meridian = kmc_timeslot.get("to_meridian");
										bd.kmc_feed_type = kmc_timeslot.get("feed_type");										
										
										//Time diffrence calculation
										String fromTime = bd.kmc_from_time+" "+bd.kmc_from_meridian;
										//System.out.println("from time = "+fromTime);
										String toTime = bd.kmc_to_time+" "+bd.kmc_to_meridian;
										String date = (String)bd.kmc_date;							
										double diffInTime = timeDiff.timeDifference(date, date, fromTime, toTime);
										hr = (int)diffInTime;
									    min = (diffInTime - (int)diffInTime)*60;		    
									   //System.out.println("Difference b/w = "+hr+"hr "+(int)min+"mins");									   	
									    
										if(!comp_obj_1.containsField("discharged"))
										{											
											%>															
											<tr>
												<td> <%= (++count)%> </td>	
												<td> <%= bd.kmc_reg_no%> </td>
												<td> <%= bd.date_of_kmc_initiation%> </td>
												<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>
												<td> <%= bd.kmc_date%> </td>
												<td> <%= bd.kmc_done%> </td>																		
												<td> <%= bd.kmc_from_time%> <%= bd.kmc_from_meridian%> - <%= bd.kmc_to_time%> <%= bd.kmc_to_meridian%></td>
												<td> <%= hr%>hr <%= (int)min%>mins</td>
												<td> <%= bd.kmc_feed_type%> </td>	
												<td> <%= bd.kmc_survey_type%> </td>
												<td> -- </td> 							
											</tr>			
											<%
										}									   
									    else
									    {
										   BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
										   disStatus = disList.get(0);											
										   //System.out.println("discahrge status ="+disStatus);
										   %>															
											 <tr>
												<td> <%= (++count)%> </td>	
												<td> <%= bd.kmc_reg_no%> </td>
												<td> <%= bd.date_of_kmc_initiation%> </td>
												<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>
												<td> <%= bd.kmc_date%> </td>
												<td> <%= bd.kmc_done%> </td>																		
												<td> <%= bd.kmc_from_time%> <%= bd.kmc_from_meridian%> - <%= bd.kmc_to_time%> <%= bd.kmc_to_meridian%></td>
												<td> <%= hr%>hr <%= (int)min%>mins</td>
												<td> <%= bd.kmc_feed_type%> </td>	
												<td> <%= bd.kmc_survey_type%> </td>
												<td style="color:red"> Discharged without Entering Details </td>											 							
											</tr>				
											<%
									  	}																		   										   
									}//close for loop of kmc slot									
									//System.out.println("startDate = "+startDate+"last date ="+lastDate);
								}//close if of kmc_time_slots
								else if(comp_obj_1.containsField("discharged"))
								{
									BasicDBList dlist = (BasicDBList)comp_obj_1.get("discharged");
									disStatus = dlist.get(0);
									//System.out.println("discahrge status ="+disStatus);
									if(disStatus.equals("discharged"))
									{
										%>					
										<tr>											
											<td> <%= (++count)%> </td>
											<td> <%= bd.kmc_reg_no%> </td>
											<td> <%= bd.date_of_kmc_initiation%> </td>
											<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>
											<td> <%= bd.kmc_date%> </td>
											<td> <%= bd.kmc_done%> </td>																		
											<td> -- </td>
											<td> -- </td>
											<td> -- </td>	
											<td> -- </td> 
											<td style="color:red"> Discharged without Entering Details </td>							
										</tr>				
										<%
									}
								}
								else 
								{
									%>					
									<tr>											
										<td> <%= (++count)%> </td>
										<td> <%= bd.kmc_reg_no%> </td>
										<td> <%= bd.date_of_kmc_initiation%> </td>
										<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>
										<td> <%= bd.kmc_date%> </td>
										<td> <%= bd.kmc_done%> </td>																		
										<td> -- </td>
										<td> -- </td>
										<td> -- </td>	
										<td> -- </td> 
										<td style="color:red"> Not Discharged </td>							
									</tr>				
									<%
								}
							}//close for loop itertae through each array of comp_obj							
						}//close if comp_docs size
						else
						{							
							if(comp_obj_0.containsField("kmc_initiation"))
							{
								if(comp_obj_0.get("kmc_initiation").equals("Discharged without initiation"))
								{
									%>					
									<tr>
										<td> <%= (++count)%> </td>								
										<td> <%= bd.kmc_reg_no%> </td>
										<td> <%= bd.date_of_kmc_initiation%> </td>
										<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>								
										<td colspan = 6> Not Initiated </td>										
										<td style="color:red"> Discharged without Entering Details	</td>
									<%
								}
								else if(comp_obj_0.get("kmc_initiation").equals("Initiated"))
								{
									%>					
									<tr>
										<td> <%= (++count)%> </td>								
										<td> <%= bd.kmc_reg_no%> </td>
										<td> <%= bd.date_of_kmc_initiation%> </td>
										<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>								
										<td colspan = 6> </td>										
										<td style="color:red"> Not Discharged </td>
									<%
								}									
							}
							else if(!comp_obj_0.containsField("kmc_initiation"))
							{
								%>					
								<tr>
									<td> <%= (++count)%> </td>								
									<td> <%= bd.kmc_reg_no%> </td>
									<td> <%= bd.date_of_kmc_initiation%> </td>
									<td> <%= bd.time_of_kmc_initiation%> <%= bd.am_pm%> </td>								
									<td colspan = 6> </td>										
									<td style="color:red"> Not Discharged </td>
								<%
							}							
						}					
					}//if close for unique id compare						
				}				
				%>								
				</table>
				</center>
				<br />
				<br />	
				
				<% 
					if(comp_obj_0.containsField("kmc_initiation"))
					{
						//System.out.println("discharge status ="+disStatus);
						if(disStatus.equals("discharged"))
						{							
							%>			
							<center>
							<form>
								<h4 style="color:brown">No_Days_KMC = <input type="text" id="days" name="days" value=<%= dateCount%> size="10" style="text-align:center" disabled>						 
								<span>
									<input type="button" id="dis" name = "dis" value = "Enter Discharge Details" style="color:blue" onClick="window.open('kmc-discharge-fi.jsp?baby=<%= bd.kmc_unique_id%>')">	
							 	</span>
							</form>
							</center>
							<%	
						}
						else if(comp_obj_0.get("kmc_initiation").equals("Initiated"))
						{							
							%>			
							<center>
							<form>
								<h4 style="color:brown">No_Days_KMC = <input type="text" id="days" name="days" value=<%= dateCount%> size="10" style="text-align:center" disabled>						 
								<span>
									<input type="button" id="kmc" name = "kmc" value = "Enter More KMC details" style="color:blue" onClick="window.open('kmc-fi.jsp?baby=<%= data_uid_value%>&start_date=<%= dt%>&end_date=<%= enddate%>')">				
								</span>
							</form>
							</center>
							<%
						}
						else if(comp_obj_0.get("kmc_initiation").equals("Discharged without initiation"))
						{							
							%>			
							<center>
							<form>
								<h4 style="color:brown">No_Days_KMC = <input type="text" id="days" name="days" value=<%= dateCount%> size="10" style="text-align:center" disabled>						 
								<span>
									<input type="button" id="dis" name = "dis" value = "Enter Discharge Details" style="color:blue" onClick="window.open('kmc-discharge-fi.jsp?baby=<%= bd.kmc_unique_id%>')">	
							 	</span>
							</form>
							</center>
							<%					
						}
					}
					else if(!comp_obj_0.containsField("kmc_initiation"))
					{
						%>			
						<center>
						<form>
							<h4 style="color:brown">No_Days_KMC = <input type="text" id="days" name="days" value=<%= dateCount%> size="10" style="text-align:center" disabled>						 
							<span>
								<input type="button" id="kmc" name = "kmc" value = "Enter More KMC details" style="color:blue" onClick="window.open('kmc-fi.jsp?baby=<%= data_uid_value%>&start_date=<%= dt%>&end_date=<%= enddate%>')">				
							</span>
						</form>
						</center>
						<%
					}
			}//close try block			
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
				e.printStackTrace();
			}				
		%>	
	</body>
</html>