<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Baby Details by DOB </title> 
  		<script src="facilities.js">	</script>
		<script src="ken_kmc_html.js"></script>	
		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	  	
	   	<!-- must include -->
	   	<style>		   		
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
				width: 2860px;
				margin-bottom:0px;
				border:1px solid #999;
			
			}
			.tablebody {
				height: 450px;
				overflow-y: auto;
				width: 2878px;
				margin-bottom:20px;
			}   
   	</style>
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
		<%@page import = "java.util.Date"%>
		<%@page import = "java.util.Calendar"%>				
		<%@ include file="Config.jsp" %>
		<%-- <%@ include file="home.jsp"%> --%>
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>		 
		
		<% 
			//jsp logic to set the values for the field as same as input give to form on submit (instead of default value on submit)
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); //date format
			String value = request.getParameter("facility"); //get value from form
			
			String survey = request.getParameter("survey");	//get value from form			
			//System.out.println("Survet type:"+survey);
  			
			//logic to increment one day from today's date
			Date dt = new Date();
			//current month - one month 
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			Date result = cal.getTime();
			System.out.println("Before one month date ="+result);
						
			String datefrom = request.getParameter("datefrom"); //get value from form
			if(datefrom == null)
			{
				datefrom = sdf.format(result);
			}
			System.out.println("date from before format dd/mm/yy="+datefrom);
						
			String dateto = request.getParameter("dateto"); //get value from form
			if(dateto == null)
			{
				dateto = sdf.format(dt);
			}
			else
			{
				Date dt2=(Date)sdf.parse(dateto);
				dateto=sdf.format(dt2);
			}
			System.out.println("date to before format dd/mm/yy="+dateto);			
			SimpleDateFormat sdf_mmdd = new SimpleDateFormat("MM/dd/yyyy");
			/* SimpleDateFormat sdf_ddmm = new SimpleDateFormat("dd/MM/yyyy");
			Date date_from = new Date(datefrom);
			Date date_to = new Date(dateto);
			String datefrom_ddmm = sdf_ddmm.format(date_from);
			String dateto_ddmm = sdf_ddmm.format(date_to); */
		%>		
		<div class="container" align="center">		 
			<form action="BabyDetails_by_dob_new.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> Baby Details By DOB </h1>
			<div class="form-group">							
				<!-- obtain the value from js file into dropdown list-->	
				<div id="filters"></div>
				<script>
					var filterStr= DropdownFilter(facilityFilter,"<%= value%>");							
					filters.innerHTML=filterStr;
				</script>
			 </div>	
			 <div class="form-group">
				<label style="font-size:20px; color:blue"> DOB From: </label> 					
				<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
			</div>
			<div class="form-group">
				<label style="font-size:20px; color:blue"> DOB To:</label> 
				<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto%>" readonly>				
			</div>
			<div class="form-group">
				<label style="font-size:20px; color:blue"> SurveyType:</label> 
				<select id="survey" name="survey" class="form-control" style="padding:3px"> 	
				<!-- jsp(java) logic to keep the selected data as data field on submit without .js file -->
				<%	
					String[] str = {"All", "inborn_normal", "inborn_lbw", "outborn_lbw"};							
					String selected = "";
					for(int v=0; v<str.length; v++)
					{	
						if(survey != null && survey.equals(str[v]))
						{
							selected = "selected";									
						}
						else 
							selected = "";
							out.println("<option "+selected+">"+str[v]+"</option>");								
					}							
				%> 
				</select>			
			</div>
			 <br><br> <spanid="msg"></span>
				<button id="subbtn" name="subbtn" type="submit" class="btn btn-primary">Submit</button>				
				<br /> 																					
			 </form>
		 </div>	
		<%
			//response.setContentType("text/html");	
			try
			{
				String jspname = "BabyDetails_by_dob.jsp";
				//convert string to int;
				int fno = Integer.parseInt(value);
				System.out.println("facility in int from dropdown=="+fno);			  	
				System.out.println("datefrom before convert from dropdown ="+datefrom);
				System.out.println("dateto before convert from dropdown="+dateto);
				System.out.println("survey type from dropdown="+survey);
				
				//convert date to yyyy-MM-dd format
				SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");				
				Date datef = (Date)sdf.parse(datefrom);
				String newdatefrom = sdf2.format(datef);				
				System.out.println("date from after convert to date yyyy-MM-dd format="+newdatefrom);				
				
				Date datet = (Date)sdf.parse(dateto);
				String newdateto = sdf2.format(datet);
				System.out.println("date to after convert to date yyyy-MM-dd format="+newdateto);
						
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();					
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection);						
						
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				BasicDBObject query = new BasicDBObject();				
						
				//retrieve the data of baby details based on dob and facility 
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
				ArrayList<DBObject> jsonArray = mongodao.babiesByDOB(fno,newdatefrom, newdateto);				
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
				com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();				
				int json_size=jsonArray.size();
				System.out.println("no. of total records ="+json_size);
				int count =0;
				int survey_otherAll=0;
				int survey_all=0;
				int survey_normal_count=0;
				int survey_inlbw_count=0;
				int survey_outlbw_count=0;
				
				if(json_size>0)
				{	
					for(int k=0; k<json_size; k++)
					{						
						BasicDBObject data = (BasicDBObject)jsonArray.get(k).get("data");
						if(data.containsField("surveyType"))
						{	
							bd.surveytype = data.getString("surveyType");	
						}
						else
							bd.surveytype="-";								
								
						if((fno==1 || fno !=1) && survey.equals("inborn_normal") && bd.surveytype.equals("inborn_normal"))
						{
							++survey_normal_count;
						}
						if((fno==1 || fno !=1) && survey.equals("inborn_lbw") && bd.surveytype.equals("inborn_lbw"))
						{
							++survey_inlbw_count;
						}
						if((fno==1 || fno !=1) && survey.equals("outborn_lbw") && bd.surveytype.equals("outborn_lbw"))
						{
							++survey_outlbw_count;
						}
					}					
				}
				System.out.println("survey_normal_count="+survey_normal_count);
				System.out.println("survey_inlbw_count="+survey_inlbw_count);
				System.out.println("survey_outlbw_count="+survey_outlbw_count);
				%>				
		 		<div class="container">
				<div class="row">
				<% 
					if((fno==1 || fno !=1) && survey.equals("inborn_normal"))
					{
						%>
						<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= survey_normal_count%> </b> </h4>
						<%
					}
					else if((fno==1 || fno !=1) && survey.equals("inborn_lbw"))
					{
						%>
						<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= survey_inlbw_count%> </b> </h4>
						<%
					}
					else if((fno==1 || fno !=1) && survey.equals("outborn_lbw"))
					{
						%>
						<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= survey_outlbw_count%> </b> </h4>
						<%
					}
					else
					{
						%>
						<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= json_size%> </b> </h4>
						<%
					}
				%>
		     	<div id="BabyDetails_by_DOB" class="exporttable table-responsive2">
                <table class="table table-bordered table-striped tableheader">
                <thead>
                    <tr>		
						<th style="width:50px; text-align:center;"> Sl. No.</th>
						<th style="width:210px; text-align:center;"> ObjectID </th>						
						<th style="width:100px; text-align:center;"> Period </th>
						<th style="width:100px; text-align:center;"> Facility </th>
						<th style="width:100px; text-align:center;"> Nurse Mentor </th>	
						<th style="width:200px; text-align:center;"> Babies Unique ID </th>
						<th style="width:100px; text-align:center;"> Baby DOB </th>
						<th style="width:110px; text-align:center;"> Survey Type </th>
						<th style="width:100px; text-align:center;"> Patient ID1 </th>
						<th style="width:100px; text-align:center;"> Patient ID2 </th>
						<th style="width:100px; text-align:center;"> Mother Name </th>
						<th style="width:100px; text-align:center;"> Husband Name </th>
						<th style="width:100px; text-align:center;"> Time of Birth </th>
						<th style="width:100px; text-align:center;"> Birth Weight </th>
						<th style="width:100px; text-align:center;"> Baby Sex </th>
						<th style="width:100px; text-align:center;"> Baby Status </th>
						<th style="width:100px; text-align:center;"> Taluk_From </th>
						<th style="width:100px; text-align:center;"> Taluk_To </th>
						<th style="width:150px; text-align:center;"> Community_to </th>
						<th style="width:150px; text-align:center;"> Community_From </th>
						<th style="width:100px; text-align:center;"> Phone1 </th>
						<th style="width:100px; text-align:center;"> Phone2 </th>
						<th style="width:150px; text-align:center;">Thayi_Card_No </th>
						<th style="width:120px; text-align:center;"> UID </th>
						<th style="width:120px; text-align:center;"> EPIC </th>						
					</tr>				
				 </thead>
                 </table>
                 	<div class="tablebody">
                 	<table class="table table-bordered table-striped" >
                 	<tbody>
					<%		
					if(json_size > 0)
					{
						for(int i=0; i<jsonArray.size(); i++)
						{	
							//System.out.println("array = "+jsonArray);	
							ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
							//System.out.println("_id object are="+objid);
							
							//convert ObjectID into date format
							Date enterDate = objid.getDate();
							SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:ss:mm a");
							java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
							sdf1.setTimeZone(tz);
							String formatDate = sdf1.format(enterDate);
							//System.out.println("Formatted object entered date = " +formatDate);
							
							BasicDBObject facility = (BasicDBObject)jsonArray.get(i).get("facility");
							//retreive each field from data.0 object
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
							bd.nm = facility.getInt("nm");	
							
							BasicDBObject data = (BasicDBObject)jsonArray.get(i).get("data");
							Object st = null;
							if(data.containsField("surveyType"))
								st = data.getString("surveyType");
							//System.out.println("survey type of data array = "+st);
							if(survey.equals("All") ||(st!=null && st.equals(survey)))
							{
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
								if(data.containsField("pid2"))
								{
									bd.pid2 = data.get("pid2");
									if(bd.pid2 instanceof String)
									{
										bd.pid2 = data.get("pid2");
									}
									else
									{
										bd.pid2 = data.getInt("pid2");
									}
									//System.out.println("pid2:"+bd.pid2);
								}
								else{
									bd.pid2 ="-";
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
								
								if(data.containsField("baby_status"))
								{
									bd.baby_status = data.getString("baby_status");
								}
								else
									bd.baby_status = "-";
								
								if(data.containsField("mother_name"))
								{
									bd.mother_name = data.getString("mother_name");//getInt("epic");
								}
								else
									bd.mother_name = "-";
								
								if(data.containsField("sex"))
								{
									bd.sex = data.getString("sex");//getInt("epic");
								}
								else
									bd.sex = "-";
								
								if(data.containsField("phone2"))
								{
									bd.phone2 = data.getLong("phone2");//getInt("epic");
								}
								else
									bd.phone2 = "-";
								
								if(data.containsField("epic"))
								{
									bd.epic = data.get("epic");
									if(bd.epic instanceof String)
									{
										bd.epic = data.get("epic");
									}
									else
									{	
										bd.epic = data.getInt("epic");
									}
									//System.out.println("epic:"+bd.epic);
								}	
								else{
									bd.epic ="-";
								}
								
								if(data.containsField("phone1"))
								{
									bd.phone1 = data.getLong("phone1");
								}
								else
									bd.phone1 = "-";
								
								if(data.containsField("uid"))
								{
									bd.uid = data.get("uid");
									if(bd.uid instanceof String)
									{
										bd.uid = data.get("uid");
									}
									else
									{
										bd.uid = data.getInt("uid");
									}
									//System.out.println("uid:"+bd.u_id);
								}
								else{
									bd.uid ="-";
								}

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
								
								if(!survey.equals("All"))
								{
									++survey_otherAll;
								}
								else
								{
									++survey_all;
								}
								%>
								<tr>
									<td style="width:50px;vertical-align:middle"> <b><%= (++count)%></b></td>
									<td style="width:210px;word-wrap:break-word;"> <%= objid%> <br> <%= formatDate%></td>													
									<td style="width:100px;word-wrap:break-word;"><%= bd.from_date +" to "+ bd.to_date%></td>						    	
									<td style="width:100px;word-wrap:break-word;"><%= bd.facility%></td> 
									<td style="width:100px;word-wrap:break-word;"><%= bd.nm%></td>	
									<td style="width:200px;word-wrap:break-word;"><%= bd.u_id%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.dob%></td>
									<td style="width:110px;word-wrap:break-word;"><%= bd.surveytype%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.pid1%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.pid2%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.mother_name%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.husband_name%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.time_of_birth%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.birth_weight%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.sex%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.baby_status%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_from%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_to%></td>
									<td style="width:150px;word-wrap:break-word;"><%= bd.community_to%></td>
									<td style="width:150px;word-wrap:break-word;"><%= bd.community_from%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.phone1%></td>
									<td style="width:100px;word-wrap:break-word;"><%= bd.phone2%></td>							    	
									<td style="width:150px;word-wrap:break-word;"><%= bd.thayi_card_no%></td>
									<td style="width:120px;word-wrap:break-word;"><%= bd.uid%></td>
									<td style="width:120px;word-wrap:break-word;"><%= bd.epic%></td>
								</tr>
								<%
								System.out.println();
							}//close of if of surveytype compare
						}//close of jsonArray loop
						//System.out.println("survey size when other than all ="+survey_otherAll);
						//System.out.println("survey size when all ="+survey_all);
						if(survey_all==0 && survey_otherAll==0)
						{
							//System.out.println("survey if");
							%>
							<tr> <td colspan="26" style="text-align:left;color:red;"> <b> No Details </b></td></tr>
							<%
						}
					}//if of json size compare										
					else
					{
						//System.out.println("else");
						%>
						<tr> <td colspan="26" style="text-align:left; color:red;"> <b> No Details </b></td></tr>
						<%
					}					
					if(json_size == jsonArray.size() && (survey_all != 0 || survey_otherAll != 0))
					{
						//System.out.println("jsonarray size if");
						%>
						<tr> <td colspan="33" style="text-align:left; color:red;"> <b> ----End of Records---- </b></td></tr>
						<%
					}
					%>
					</tbody>
				</table>
				</div>
				</div>
				</div></div>
				<%
				}//close try block
				catch (Exception e) 
				{
					e.printStackTrace();
					System.out.println("Exception::" + e);
				}
				%>
				<%@include file="tableexport.jsp" %>
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
			    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
			    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
			    <script type="text/javascript">	
			   $(document).ready(function () 
				{
				   /*var fromDate=document.getElementById("datefrom").value;	
			    	console.log(fromDate);
			    	var  df = fromDate.split("/");			    	
			    	var date_from = df[1]+"/"+df[0]+"/"+df[2];
					console.log(date_from);
					
					var date=new Date();
					date.setDate(date.getDate());	
					
					var pre = new Date("10/01/2016");
					console.log(pre);					
			        $("#datefrom").datepicker(
			        		{
			                numberOfMonths: 1,
							maxDate:date,
							minDate:pre,
							dateFormat: 'dd/mm/yy', //Note that 'yy' is for four digits.
			                onSelect: function (selected) {
			                    var dt = new Date(selected);
			                    dt.setDate(dt.getDate() + 0);
			                    $("#dateto").datepicker("option",'minDate', dt);
			                }
			            });
						
			            $("#dateto").datepicker(			            	
							{								
			                numberOfMonths: 1,				
							maxDate:date,
							minDate:date_from,
							dateFormat: 'dd/mm/yy', //Note that 'yy' is for four digits.
			                onSelect: function (selected) 
							{					
			                    var dt = new Date(selected);
			                    dt.setDate(dt.getDate() - 1);
			                    $("#datefrom").datepicker("option", 'maxDate', 'minDate', dt);
			                }
			            });
			    }); */
			    var pre = new Date("10/01/2016");
				var date=new Date();				
				date.setDate(date.getDate());
				var fromDate=document.getElementById("datefrom").value;
				$('#dateto').datepicker(
						{
							dateFormat: "dd/mm/yy" ,
							numberOfMonths: 1,			
							minDate:  fromDate,
							maxDate:date,
						}
				);

			    $("#datefrom").datepicker(
					{
						dateFormat: "dd/mm/yy",
						numberOfMonths: 1,			
						minDate:  pre,
						maxDate:date,
						onSelect: function(date){            
							var date1 = $('#datefrom').datepicker('getDate');           
							var date = new Date( Date.parse( date1 ) ); 
							date.setDate( date.getDate() + 1 );        
							var newDate = date.toDateString(); 
							newDate = new Date( Date.parse( newDate ) );                      
							$('#dateto').datepicker("option","minDate",newDate);            
			        }
			    });	
			});
			</script>
	</body>
</html>