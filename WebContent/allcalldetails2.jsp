<!DOCTYPE html>
<html>
<head>
    <title> Call Status </title>
	<script src="facilities.js">	</script>
	<script src="koppal_villages.js"></script>
	<script src="communityWorkers.js"></script>
	<script src="ken_kmc_html.js"></script>
	<link rel="stylesheet" href="Responsive_Style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="snackbar.css">
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
			width: 2950px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 500px;
			overflow-y: auto;
			width: 2965px;
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
	<%@page import = "java.util.*"%>
	<%@page import = "java.util.Date"%>
	<%@page import = "java.util.Calendar"%>	
	<%@ include file="Config.jsp" %>
 	<%-- <%@ include file="home.jsp" %> --%>
 	<%@page import="javax.servlet.jsp.JspWriter"%>
	<%@page import = "com.mongodb.util.JSON"%>
	
	<%!
		int count=0;
	javax.servlet.jsp.JspWriter myOut;
		com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
		void ifExists(Object babydetails[], String period, BasicDBObject success_obj, JspWriter myOut)
		{
			try
			{		
						bd.visit_date = success_obj.get("visit_date");
						System.out.println("visit date in exists jsp method= "+bd.visit_date);
						if(success_obj.containsField("baby_death_date"))
						{
							bd.baby_death_date = success_obj.get("baby_death_date");
						}
						else
						{
							bd.baby_death_date = "-";
						}
						if(success_obj.containsField("mother_death_date"))
						{
							bd.mother_death_date = success_obj.get("mother_death_date");
						}
						else
						{
							bd.mother_death_date = "-";
						}
						
						if(success_obj.containsField("baby_alive"))
						{
							bd.baby_alive = success_obj.get("baby_alive");
						}
						else
						{
							bd.baby_alive = "-";
						}
						if(success_obj.containsField("mother_alive"))
						{
							bd.mother_alive = success_obj.get("mother_alive");
						}
						else
						{
							bd.mother_alive = "-";
						}
						if(success_obj.containsField("baby_weight"))
						{
							bd.baby_weight = success_obj.get("baby_weight");
						}
						else
						{
							bd.baby_weight = "-";
						}
						if(success_obj.containsField("breastfeed_no"))
						{
							bd.breastfeed_no = success_obj.get("breastfeed_no");
						}
						else
						{
							bd.breastfeed_no = "-";
						}
						if(success_obj.containsField("kmc_hours"))
						{
							bd.kmc_hours = success_obj.get("kmc_hours");
						}
						else
						{
							bd.kmc_hours = "-";
						}
						myOut.println("<td style=\"width:50px;word-wrap:break-word;\"> "+(++count)+" </td>");	
						myOut.println("<td style=\"width:200px;word-wrap:break-word;\"> "+period+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[0]+" </td>");						
						myOut.println("<td style=\"width:200px;word-wrap:break-word;\"> "+babydetails[1]+" </td>");
						myOut.println("<td style=\"width:150px;word-wrap:break-word;\"> "+babydetails[2]+" </td>");
						myOut.println("<td style=\"width:150px;word-wrap:break-word;\"> "+babydetails[3]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[4]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[5]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[6]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\">"+babydetails[7]+"  </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[8]+" </td>");						
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.visit_date+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.baby_alive+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.baby_death_date+"</td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.mother_alive+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.mother_death_date+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.baby_weight+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.kmc_hours+"</td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+bd.breastfeed_no+"</td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");						
						myOut.println("<td style=\"width:100px; word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");	
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"word-wrap:break-word;\"> - </td>");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}		
		}
			
		void ifNotExists(Object babydetails[], String period, JspWriter myOut)
		{
			try
			{
						myOut.println("<td style=\"width:50px;word-wrap:break-word;\"> "+(++count)+" </td>");	
						myOut.println("<td style=\"width:200px;word-wrap:break-word;\"> "+period+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[0]+" </td>");						
						myOut.println("<td style=\"width:200px;word-wrap:break-word;\"> "+babydetails[1]+" </td>");
						myOut.println("<td style=\"width:150px;word-wrap:break-word;\"> "+babydetails[2]+" </td>");
						myOut.println("<td style=\"width:150px;word-wrap:break-word;\"> "+babydetails[3]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[4]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[5]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[6]+" </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\">"+babydetails[7]+"  </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> "+babydetails[8]+" </td>");						
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\">-  </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> -</td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> -</td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");						
						myOut.println("<td style=\"width:100px; word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");	
						myOut.println("<td style=\"width:100px;word-wrap:break-word;\"> - </td>");
						myOut.println("<td style=\"word-wrap:break-word;\"> - </td>");
			}
			catch(Exception e)
			{
				System.out.println(e);
			}					
		}				
	%>
		    
	<% String value = request.getParameter("facility");
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		//logic to decrement one month from current month
		Date dt = new Date();
		//current date - one month 
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1);
		Date result = cal.getTime();
		//System.out.println("Before one month date ="+result);
		
		String datefrom = request.getParameter("datefrom"); //get value from form
		if(datefrom == null)
		{
			datefrom = sdf.format(result);
		}
		//System.out.println("date from in mm/dd/yyyy="+datefrom);			
		
		String dateto = request.getParameter("dateto"); //get value from form
		if(dateto == null)
		{
			dateto = sdf.format(new Date());
		}
		else
		{
			Date dt2=(Date)sdf.parse(dateto);
			dateto=sdf.format(dt2);
		}
		//System.out.println("date to in mm/dd/yyyy="+dateto);
	%>		
		<div class="container" align="center">		 
			<form action="allcalldetails2.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> LBW Babies Call Details </h1>
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
			<br />					
				<button type="submit" class="btn btn-primary">Submit</button>				
				<br /> 																					
			 </form>		 
		 </div>	
	    <%
			response.setContentType("text/html");	
			try
			{	
				
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();				
				DB database = mongo.getDB(db);
				DBCollection collection = database.getCollection(coll);						
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
				int facility = value==null?1:Integer.parseInt(value);
				System.out.println("facility ="+value);
				
				//date in yyyy-MM-dd format for comparing with period
			  	SimpleDateFormat sdf_ddmm = new SimpleDateFormat("yyyy-MM-dd");
			  	Date df = new Date(datefrom);
			  	Date dto = new Date(dateto);
			  	String date_from = sdf_ddmm.format(df);
			  	String date_to = sdf_ddmm.format(dto);
			  	System.out.println("datefrom after convert into yyyy-mm-dd="+date_from);
			  	System.out.println("dateto after convert into yyyy-mm-dd="+date_to);
			  	
				ArrayList<DBObject> jsonArray = mongodao.callstatus_allbabies(facility,date_from, date_to);
				System.out.println("Total babies ="+jsonArray.size());
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();			
			  	
				int count=0;
				int json_size = jsonArray.size();
				int failedAt2_cnt = 0;
				int failedAt3_cnt = 0;
				int failedAt4_cnt = 0;
				String period=null;
				int failure_cnt = 0;
				int success2_cnt=0;
				int success3_cnt=0;	
				int success4_cnt=0;	
				int kmc2_ntexts =0;
				int kmc3_ntexts=0;
				int kmc4_ntexts=0;
				int kmc2_exts =0;
				int kmc3_exts=0;
				int kmc4_exts=0;
				
				%>
				<div class="container">
				<div class="row">
				<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= json_size%> </b> </h4>
				<div id="call Success babies" class="table-responsive2">
				<table class="table table-bordered table-striped tableheader">
				<thead>
					<tr>
						<th style="width:50px;text-align:center; word-wrap:break-word;"> SI. No. </th>
						<th style="width:200px;text-align:center; word-wrap:break-word;"> KMC Period </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Facility </th>						
						<th style="width:200px;text-align:center; word-wrap:break-word;"> Unique ID</th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Mother Name</th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Father Name</th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> DOB </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Sex </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Birth Weight </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Phone 1 </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Phone 2 </th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Visit Date </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Alive </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Death Date </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Mother Alive </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Mother Death Date </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Weight </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> KMC Hours </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Exclusive Breastfed </th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> No. of. Attempts </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Attempt Date </th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Attempt Time </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Called To Name </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Called To Role </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Called To Ph. no. </th>
						<th style="width:200px;text-align:center; word-wrap:break-word;"> Remarks </th>
					</tr>
				</thead>
				</table>
                    <div class="tablebody">
                      <table class="table table-bordered table-striped" >
                        <tbody>
					
						<%
						if(jsonArray.size() > 0)
						{
							for(int i=0; i<jsonArray.size(); i++)
							{
								DBObject obj = jsonArray.get(i);
								//System.out.println("Obj = "+obj);
								
								BasicDBObject facilityData = (BasicDBObject)obj.get("facility");
								//System.out.println("facility data = "+facilityData);
								bd.facility=facilityData.getInt("facility");
								
								BasicDBObject data = (BasicDBObject)obj.get("data");																
								bd.dob = data.get("dob");								
								bd.mother_name = data.get("mother_name");								
								bd.husband_name = data.get("husband_name");								
								bd.u_id = data.get("unique_id");								
								Object sex = data.get("sex");
								if(sex.equals("1"))
								{
									bd.sex="Male";
								}
								else if(sex.equals("2"))
								{
									bd.sex="Female";
								}
								else
								{
									bd.sex="Other";
								}
								
								bd.birth_weight = data.get("birth_weight");
								
								if(data.containsField("phone1"))
								{
									bd.phone1 = data.get("phone1");
								}
								else
								{
									bd.phone1 = "-";
								}
								
								if(data.containsField("phone2"))
								{
									bd.phone2 = data.get("phone2");
								}
								else
								{
									bd.phone2 = "-";
								}
								Object babydetails[] = {bd.facility,bd.u_id,bd.mother_name,bd.husband_name,bd.dob,bd.sex,bd.birth_weight,bd.phone1,bd.phone2};
								//System.out.println("unique_id ="+bd.u_id);
								//System.out.println();
								failedAt2_cnt=0;
								failedAt3_cnt=0;
								failedAt4_cnt=0;
								success2_cnt=0;
								success3_cnt=0;
								success4_cnt=0;
								kmc2_exts=0;
								kmc3_exts=0;
								kmc4_exts=0;
								kmc2_ntexts=0;
								kmc3_ntexts=0;
								kmc4_ntexts=0;
								
								BasicDBList compobj_data = (BasicDBList)obj.get("comp_docs");
								//loop to count no. of. attempts called for each kmc period
								for(int k=0; k<compobj_data.size(); k++)
								{									
									BasicDBObject comp_obj = (BasicDBObject)compobj_data.get(k);																	
									if(comp_obj.containsField("status"))
									{										
										if(comp_obj.get("status").equals("failed"))	
										{
											if(comp_obj.get("kmc_period").equals("2"))
											{
												//System.out.println("contains failure of 2");
												++failedAt2_cnt;
											}											
											else if(comp_obj.get("kmc_period").equals("3"))
											{
												//System.out.println("contains failure of 3");
												++failedAt3_cnt;
											}											
											else if(comp_obj.get("kmc_period").equals("4"))
											{
												//System.out.println("contains failure of 4");
												++failedAt4_cnt;
											}											
										}										
									}	
									
									if(comp_obj.containsField("visit_date"))
									{
										if(comp_obj.get("kmc_period").equals("2"))
										{
											++success2_cnt;
										}
										else if(comp_obj.get("kmc_period").equals("3"))
										{
											++success3_cnt;
										}
										else if(comp_obj.get("kmc_period").equals("4"))
										{
											++success4_cnt;
										}
									}
								}//close loop for count failure data
								/* System.out.println("success at 2 ="+success2_cnt);
								System.out.println("success at 3 ="+success3_cnt);
								System.out.println("success at 4 ="+success4_cnt); */
								if(success2_cnt==0)
								{
									System.out.println("kmc period 2 not exists");
									period="7th day of life";
								}
								if(success3_cnt==0)
								{
									System.out.println("kmc period 3 not exists");
									period="7th day after discharge";
								}
								if(success4_cnt==0)
								{
									System.out.println("kmc period 4 not exists");
									period="28th day of life";
								}	
								if(success2_cnt>0 && success3_cnt>0 && success4_cnt>0)
								{
									System.out.println("all call success");									
								}
								
								/* System.out.println("failure at 2 ="+failedAt2_cnt);
								System.out.println("failure at 3 ="+failedAt3_cnt);
								System.out.println("failure at 4 ="+failedAt4_cnt);*/
								//System.out.println(); 
								//loop to dispaly success details
								int comp_obj_size = compobj_data.size();
								int j=0;
								for(j=0; j<compobj_data.size(); j++)
								{
									BasicDBObject comp_obj_success = (BasicDBObject)compobj_data.get(j);
									if(comp_obj_success.containsField("visit_date"))
									{										
										bd.visit_date = comp_obj_success.get("visit_date");
										if(comp_obj_success.containsField("baby_death_date"))
										{
											bd.baby_death_date = comp_obj_success.get("baby_death_date");
										}
										else
										{
											bd.baby_death_date = "-";
										}
										if(comp_obj_success.containsField("mother_death_date"))
										{
											bd.mother_death_date = comp_obj_success.get("mother_death_date");
										}
										else
										{
											bd.mother_death_date = "-";
										}
										
										if(comp_obj_success.containsField("baby_alive"))
										{
											bd.baby_alive = comp_obj_success.get("baby_alive");
										}
										else
										{
											bd.baby_alive = "-";
										}
										if(comp_obj_success.containsField("mother_alive"))
										{
											bd.mother_alive = comp_obj_success.get("mother_alive");
										}
										else
										{
											bd.mother_alive = "-";
										}
										if(comp_obj_success.containsField("baby_weight"))
										{
											bd.baby_weight = comp_obj_success.get("baby_weight");
										}
										else
										{
											bd.baby_weight = "-";
										}
										if(comp_obj_success.containsField("breastfeed_no"))
										{
											bd.breastfeed_no = comp_obj_success.get("breastfeed_no");
										}
										else
										{
											bd.breastfeed_no = "-";
										}
										if(comp_obj_success.containsField("kmc_hours"))
										{
											bd.kmc_hours = comp_obj_success.get("kmc_hours");
										}
										else
										{
											bd.kmc_hours = "-";
										}
										
										
										if(comp_obj_success.get("kmc_period").equals("2"))
										{
											kmc2_exts=1;
											%>
											<tr> <% ifExists(babydetails,"7th day of life",comp_obj_success,out);%> </tr>
											<%
										}
										else
										{
											if(kmc2_ntexts==0 && kmc2_exts!=1)
											{
												kmc2_ntexts=1;
												%>
												<tr> <% ifNotExists(babydetails,"7th day of life",out);%> </tr>
												<%
											}
											if(comp_obj_success.get("kmc_period").equals("3"))
											{
												kmc3_exts=1;
												%>
												<tr> <% ifExists(babydetails,"7th day after disccharge",comp_obj_success,out);%> </tr>
												<%
											}
											else
											{
												if(kmc3_ntexts==0 && kmc3_exts!=1)
												{
													kmc3_ntexts=1;
													%>
													<tr> <% ifNotExists(babydetails,"7th day after disccharge",out);%> </tr>
													<%
												}												
												if(comp_obj_success.get("kmc_period").equals("4"))
												{
													kmc4_exts=1;
													%>
													<tr> <% ifExists(babydetails,"28th day of life",comp_obj_success,out);%> </tr>
													<%
												}
												else
												{
													if(kmc4_ntexts==0 && kmc4_exts!=1)
													{
														kmc4_ntexts=1;
														%>
														<tr> <% ifNotExists(babydetails,"28th day of life",out);%> </tr>
														<%
													}
												}
											}
										}
																				
									}//close if of compare visit_date
								}//for loop of success data									
								if(j==compobj_data.size())
								{
									//System.out.println("j == comp_docs size");
									System.out.println("kmc2_exts =="+kmc2_exts);
									System.out.println("kmc2_ntexts =="+kmc2_ntexts);
									System.out.println("kmc3_exts =="+kmc3_exts);
									System.out.println("kmc3_ntexts =="+kmc3_ntexts);
									System.out.println("kmc4_exts =="+kmc4_exts);
									System.out.println("kmc4_ntexts =="+kmc4_ntexts);
									
									if((kmc2_ntexts!=1 && kmc2_exts==0)) 
									{
										System.out.println("kmc2 is not exists after loop");
										%>
										<tr> <% ifNotExists(babydetails,"7th day of life",out);%> </tr>
										<%
									}
									if((kmc3_ntexts!=1 && kmc3_exts==0)) 
									{
										System.out.println("kmc3 is not exists after loop");
										%>
										<tr> <% ifNotExists(babydetails,"7th day after discharge",out);%> </tr>
										<%
									}
									if((kmc4_ntexts!=1 && kmc4_exts==0)) 
									{
										System.out.println("kmc4 is not exists after loop");
										%>
										<tr> <% ifNotExists(babydetails,"28th day of life",out);%> </tr>
										<%
									}
									System.out.println();
								}
							}//for loop of jsonarray
						}//close if of jsonarray size compare>0
						else
						{
							%>
								<tr> <td colspan=26> <h4 style="text-align:left;color:red;">No details</h4> </td></tr>
							<% 
						}
						%>					
				</tbody>
				</table>				
				</div>
				</div>
				</div>
				</div>
				<%				
			}
			catch(Exception e)
			{
				System.out.println(e);				
			}
			
		%>		
		<%@include file="tableexport.jsp" %>		
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
		<script type="text/javascript">	
			var fromDate=document.getElementById("datefrom").value;
        	//console.log(fromDate);
			var date=new Date();
			date.setDate(date.getDate());			
			var pre = new Date("10/01/2016");			
			//console.log(pre);		
	        $("#datefrom").datepicker({
	                numberOfMonths: 1,
					maxDate:date,
					minDate:pre,
	                onSelect: function (selected) 
	                {	                	
	                    var dt = new Date(selected);
	                    dt.setDate(dt.getDate() + 0);
	                    $("#dateto").datepicker("option", 'minDate', dt);
	                }
	            });
				
	            $("#dateto").datepicker({
	                numberOfMonths: 1,				
					maxDate:date,
					minDate:fromDate,				
	                onSelect: function (selected) 
					{		                	
	                    var dt = new Date(selected);
	                    //var fromDate=document.getElementById("datefrom");
	                    //console.log(dt);//selected date from calender
	                    dt.setDate(dt.getDate() - 1);	                    
	                    $("#datefrom").datepicker("option", 'maxDate','minDate', dt);	                    
	                }	            	
	            });  
		</script>	
</body>  
</html>  