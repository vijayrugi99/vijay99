<!DOCTYPE html>
<html>
<head>
    <title> Call attempt details </title>
	<script src="facilities.js">	</script>
	<script src="koppal_villages.js"></script>
	<script src="communityWorkers.js"></script>
	<script src="ken_kmc_html.js"></script>
	<link rel="stylesheet" href="Responsive_Style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv=”Pragma” content=”no-cache”>
	<meta http-equiv=”Expires” content=”-1?>
	<meta http-equiv=”CACHE-CONTROL” content=”NO-CACHE”>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="snackbar.css">
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
		    
	<% String value = request.getParameter("facility");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
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
		
		int kmcPeriod=0;
		if(request.getParameter("kmcPeriod")!=null)
		{				
			kmcPeriod=Integer.parseInt(request.getParameter("kmcPeriod"));
		}
		else
		{
			kmcPeriod=2;
		}
					
		int bw=0;
		if(request.getParameter("birthweight")!=null)
		{				
			bw=Integer.parseInt(request.getParameter("birthweight"));
		}
		else
		{
			bw=1;
		}
		System.out.println("birth weight ="+bw);
	%>		
		<div class="container" align="center">		 
			<form action="call_attempt_report.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> LBW Call Attempt Details </h1>
			<div class="form-group">							
			<!-- obtain the value from js file into dropdown list-->	
				<div id="filters"></div>
				<script>
					var filterStr= DropdownFilter(facilityFilter,"<%= value%>");							
					filters.innerHTML=filterStr;
				</script>
			 </div>	
			 <div class="form-group">
				<label style="font-size:20px; color:blue"> Date From: </label> 					
				<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
			</div>
			<div class="form-group">
				<label style="font-size:20px; color:blue"> Date To:</label> 
				<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto%>" readonly>				
			</div>	
			
			<div class="form-group">
			<div id="filters2"></div>
			<script>
				var filterStr= DropdownFilter(kmcPeriodFilter,"<%= kmcPeriod%>");				
				filters2.innerHTML=filterStr;
			</script>
		 </div>
		 
		 <div class="form-group">
			<div id="filters3"></div>
			<script>
				var filterStr= DropdownFilter(birthweightFilter,"<%= bw%>");				
				filters3.innerHTML=filterStr;
			</script>
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
			  	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");				
				Date datef = (Date)sdf.parse(datefrom);
				String newdatefrom = sdf2.format(datef);	
				System.out.println("date from in dd/MM/yyyy format="+datefrom);
				System.out.println("date from after convert to date yyyy-MM-dd format="+newdatefrom);				
				
				Date datet = (Date)sdf.parse(dateto);
				String newdateto = sdf2.format(datet);
				System.out.println("date to in dd/MM/yyyy format="+dateto);
				System.out.println("date to after convert to date yyyy-MM-dd format="+newdateto);
			  	
				ArrayList<DBObject> jsonArray = mongodao.callAttemptDetails(facility,newdatefrom, newdateto,kmcPeriod, bw);
				System.out.println("Total babies ="+jsonArray.size());
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int json_size = jsonArray.size();
				int no_of_babyalive=0;
				int no_of_ph1=0;
				int no_of_ph2=0;
				int no_of_attempts1=0;
				int no_of_successfullattempt1=0;
				int no_of_attempts2=0;
				int no_of_successfullattempt2=0;
				int no_of_attempts3=0;
				int no_of_successfullattempt3=0;
				int total_attempts1=0;
				int total_successfullattempt1=0;
				int total_attempts2=0;
				int total_successfullattempt2=0;
				int total_attempts3=0;
				int total_successfullattempt3=0;
				int total_attempts_asha=0;
				int total_successfullattempt_asha=0;
				int kmccc_cnt=0;
				int failed_cnt=0;
				ArrayList<BasicDBObject> kmccc_array = new ArrayList<BasicDBObject>();
				%>
				<div class="container">
				<div class="row">
				<div id="call_attempt_details" class="exporttable table-responsive">
				<table class="table table-bordered table-striped">
				<thead>
					<tr>
						<th style="width:50px;text-align:center; word-wrap:break-word;"> Total Babies </th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Number of live-births </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> No of LBs with ph #1 </th>						
						<th style="width:200px;text-align:center; word-wrap:break-word;"> No of LBs with ph #2 </th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Nos of fail attempt #1 </th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Nos successful on attempt #1 </th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Nos of fail attempt #2 </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Nos successful on attempt #2 </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Nos of fail attempt #3 </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Nos successful on attempt #3 </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Nos of fail attempts to ASHA/AF/CC </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Nos successful with ASHA/AF/CC </th>						
					</tr>
				</thead>
				<tbody>					
					<%
						if(jsonArray.size() > 0)
						{
							for(int i=0; i<jsonArray.size(); i++)
							{
								kmccc_cnt=0;								
								failed_cnt=0;								
								DBObject obj = jsonArray.get(i);
								//System.out.println("Obj = "+obj);
								
								BasicDBObject facilityData = (BasicDBObject)obj.get("facility");
								//System.out.println("facility data = "+facilityData);
								bd.facility=facilityData.getInt("facility");
								if(facilityData.containsField("from_date"))	
								{
									bd.from_date = facilityData.getString("from_date");
								}
								else
								{
									bd.from_date = "-";
								}
								if(facilityData.containsField("to_date"))	
								{
									bd.to_date = facilityData.getString("to_date");
								}
								else
								{
									bd.to_date = "-";
								}
								
								BasicDBObject data = (BasicDBObject)obj.get("data");	
								if(data.containsField("unique_id"))
								{
									bd.u_id = data.get("unique_id");
								}
								else
									bd.u_id ="-";
								System.out.println("unique_id = "+bd.u_id);
								/* if(data.containsField("phone1"))
								{
									 ++no_of_ph1;
								}
								if(data.containsField("phone2"))
								{
									 ++no_of_ph2;
								} */				
								
								BasicDBList compobj_data = (BasicDBList)obj.get("comp_docs");
								int comp_kmcperiod=0;
								for(int j=0; j<compobj_data.size(); j++)
								{
									BasicDBObject comp_obj_success = (BasicDBObject)compobj_data.get(j);
									//count no of kmc cc details including all kmc period
									
									if(comp_obj_success.containsField("kmc_period"))
									{
										String docs_kmcperiod = (String)comp_obj_success.get("kmc_period");
										comp_kmcperiod = Integer.parseInt(docs_kmcperiod);
										//System.out.println("kmc from comp docs ="+comp_kmcperiod);
										//System.out.println("kmc from dropdown ="+kmcPeriod);
									}									
									
									if(comp_obj_success.containsField("surveyType"))
									{
										if(comp_obj_success.get("surveyType").equals("kmc_details_cc"))
										{
											++kmccc_cnt;
											if(comp_obj_success.containsField("kmc_period"))
											{
												if(comp_kmcperiod==kmcPeriod)
												{
													kmccc_array.add(comp_obj_success);
												}
											}
											//kmccc_array.add(comp_obj_success); //collect all kmc_cc objects into one array
										}
										
										//count no of failure of perticular kmc period
										if(comp_kmcperiod == kmcPeriod)
										{
											//System.out.println("yes equal");
											if(comp_obj_success.containsField("status"))
											{
												//System.out.println("baby alive = "+comp_obj_success.get("baby_alive"));
												if(comp_obj_success.get("status").equals("failed"))
												{
													++failed_cnt;
													if(comp_obj_success.containsField("type"))
													{
														if((comp_obj_success.get("type").equals("ASHA")) || 
																(comp_obj_success.get("type").equals("ANM")) ||
																(comp_obj_success.get("type").equals("ASHA_Facilitator")))
														{
															++total_attempts_asha;//asha count
														}
													}
												}
											}
											else if(comp_obj_success.containsField("visit_date"))
											{
												if(comp_obj_success.containsField("type"))
												{
													if((comp_obj_success.get("type").equals("ASHA")) || 
																(comp_obj_success.get("type").equals("ANM")) ||
																(comp_obj_success.get("type").equals("ASHA_Facilitator")))
													{
															++total_successfullattempt_asha;//asha success count
													}	
												}
											}
										}
									}
									
									if(comp_obj_success.containsField("visit_date"))
									{										
										//count nos of baby alive
										if(comp_kmcperiod == kmcPeriod)
										{
											//System.out.println("yes equal");
											if(comp_obj_success.containsField("baby_alive"))
											{
												//System.out.println("baby alive = "+comp_obj_success.get("baby_alive"));
												if(comp_obj_success.get("baby_alive").equals("Yes"))
												{
													++no_of_babyalive;
													if(data.containsField("phone1"))
													{
														 ++no_of_ph1;
													}
													if(data.containsField("phone2"))
													{
														 ++no_of_ph2;
													}
												}
											}
										}
									}									
								}//for loop of comp_docs
								System.out.println("no of fail/success kmc cc count of each baby = "+kmccc_cnt);									
								System.out.println("total no. failed at selected period on each baby= "+failed_cnt);
								
								//count no. of. attempt#1, #2, #3, no. of. success attempt#1,#2,#3.
								System.out.println("Total kmccc array of baby of selected kmc period = "+kmccc_array.size());	
								for(int k=0; k<kmccc_array.size(); k++)
								{
									BasicDBObject kmccc_obj=(BasicDBObject)kmccc_array.get(k);	
									//System.out.println("kmccc_obj of selected "+kmcPeriod+" = "+kmccc_obj);
									String docs_kmcperiod = (String)kmccc_obj.get("kmc_period");
									comp_kmcperiod = Integer.parseInt(docs_kmcperiod);
									//count failure/success at attempt at #1
									if(k==0)
									{
										if(kmccc_obj.containsField("status") && comp_kmcperiod==kmcPeriod)
											{
												if(kmccc_obj.get("status").equals("failed"))
												{
													++no_of_attempts1;
												}
											}
											else if(kmccc_obj.containsField("visit_date") && comp_kmcperiod==kmcPeriod)
											{
												++no_of_successfullattempt1;
											}										
									}
									//count falure/success at attempt at #1
									else if(k==1)
									{
										if(kmccc_obj.containsField("status") && comp_kmcperiod==kmcPeriod)
										{
											if(kmccc_obj.get("status").equals("failed"))
											{
												++no_of_attempts2;
											}
										}
										else if(kmccc_obj.containsField("visit_date") && comp_kmcperiod==kmcPeriod)
										{
											++no_of_successfullattempt2;
										}
									}
									//count falure/success at attempt at #1
									else if(k>=2)
									{
										if(kmccc_obj.containsField("status") && comp_kmcperiod==kmcPeriod)
										{
											if(kmccc_obj.get("status").equals("failed"))
											{
												++no_of_attempts3;
											}
										}
										else if(kmccc_obj.containsField("visit_date") && comp_kmcperiod==kmcPeriod)
										{
											++no_of_successfullattempt3;
										}
									}
								}
								kmccc_array.clear();
								System.out.println("no_of_attempts#1 = "+no_of_attempts1+", No_of_succcessattempt#1= "+no_of_successfullattempt1);
								System.out.println("no_of_attempts#2 = "+no_of_attempts2+", No_of_succcessattempt#2= "+no_of_successfullattempt2);
								System.out.println("no_of_attempts#3 = "+no_of_attempts3+", No_of_succcessattempt#3= "+no_of_successfullattempt3);
								total_attempts1=total_attempts1+no_of_attempts1;
								total_attempts2=total_attempts2+no_of_attempts2;
								total_attempts3=total_attempts3+no_of_attempts3;
								total_successfullattempt1=total_successfullattempt1+no_of_successfullattempt1;
								total_successfullattempt2=total_successfullattempt2+no_of_successfullattempt2;
								total_successfullattempt3=total_successfullattempt3+no_of_successfullattempt3;
								
								no_of_attempts1=0;
								no_of_successfullattempt1=0;
								no_of_attempts2=0;
								no_of_successfullattempt2=0;
								no_of_attempts3=0;
								no_of_successfullattempt3=0;
								System.out.println();
							}//for loop of jsonarray
							System.out.println("total baby = "+jsonArray.size());
							System.out.println("total baby alive = "+no_of_babyalive);
							System.out.println("total baby has phone1 = "+no_of_ph1);									
							System.out.println("total baby has phone2 = "+no_of_ph2);
							System.out.println("total failed by asha = "+total_attempts_asha);									
							System.out.println("total success by asha = "+total_successfullattempt_asha);
							System.out.println("total attempt#1 = "+total_attempts1+", total succcessattempt#1="+total_successfullattempt1);
							System.out.println("total attempt#2 = "+total_attempts2+", total succcessattempt#2="+total_successfullattempt2);
							System.out.println("total attempt#3 = "+total_attempts3+", total succcessattempt#3="+total_successfullattempt3);
							
							%>
							<tr>
								<td> <%= jsonArray.size()%></td>
								<td> <%= no_of_babyalive%></td>
								<td> <%= no_of_ph1%></td>
								<td> <%= no_of_ph2%></td>
								<td> <%= total_attempts1%></td>
								<td> <%= total_successfullattempt1%></td>
								<td> <%= total_attempts2%></td>
								<td> <%= total_successfullattempt2%></td>								
								<td> <%= total_attempts3%></td>
								<td> <%= total_successfullattempt3%></td>
								<td> <%= total_attempts_asha%></td>
								<td> <%= total_successfullattempt_asha%></td>
							</tr>
							<%
						}//close if of jsonarray size compare>0
						else
						{
							%>
								<tr> <td colspan=23> <h4 style="text-align:left;color:red;">No details</h4> </td></tr>
							<% 
						}
						%>					
				</tbody>
				</table>				
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
		$(document).ready(function () 
				{				  
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