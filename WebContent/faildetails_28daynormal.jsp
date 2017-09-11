<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Call Details </title>
		<script src="facilities.js">	</script>		
		<script src="ken_kmc_html.js"></script>	
		
  		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  		<script src="jquery-3.1.1.min.js"></script>
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  		
  		<style type="text/css">
		.well {
		    background: none;
		    height: 320px;
		}	
		.table>thead>tr>th{text-align:center;border:1px solid #333;}
		.table>tbody>tr>td{text-align:center;border:1px solid #333;}
	</style>	
	<script>
	function goBack() {
	    window.history.back();
	}
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
		<%@include file="handleEvent.jsp" %>
		<%@include file="tableexport.jsp" %>		
      	
      	<% //String value = request.getParameter("facility"); 
			String data_uid_value = request.getParameter("baby");
			System.out.println("unique_id inside call_details file = "+data_uid_value);
		%> 		
		
		<h1 style = "color:brown; text-align:center; margin-top:10px" > Call Details </h1>						
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
				int count=0;				
				%>				
				<!-- <div class="container">
				<div class="panel-body">
				<div class="table-responsive"> --> 						
				<% 				
				BasicDBList comp_obj = null;
				BasicDBObject comp_failed = null;
				BasicDBList disch_obj = null;
				BasicDBObject comp_obj_0 = null;				
				BasicDBObject comp_obj_1 = null;
				BasicDBList kmc_details = null;
				BasicDBObject kmc_timeslot = null;	
				BasicDBObject failedArray=null;											
				String call_date="--";
				String call_time="--";				
				//System.out.println("json array ="+jsonArray.size());
				
				BasicDBObject data = (BasicDBObject)jsonArray.get(0).get("data");
				bd.dob = data.get("dob1");
				//System.out.println("dob= "+bd.dob);
				bd.kmc_unique_id = data.get("unique_id");				
				
				Object attempt_date_7="--";
				Object attempt_time_7="--";
				Object callername_7="--";
				Object callerrole_7="--";
				Object calledto_7="--";
				Object type_7="--";
				Object phnum_7="--";
				Object remarks_7="--";
				Object status_7="--";
				Object date_disch_7="--";
				Object disch_time_7="--";
				Object disch_callername_7="--";
				Object disch_callerrole_7="--";
				Object disch_calledto_7="--";
				Object disch_type_7="--";
				Object disch_phnum_7="--";
				Object disch_remarks_7="--";
				Object disch_status_7="--";
				Object attempt_date_28="--";
				Object attempt_time_28="--";
				Object callername_28="--";
				Object callerrole_28="--";
				Object calledto_28="--";
				Object type_28="--";
				Object phnum_28="--";
				Object remarks_28="--";
				Object status_28="--";
				int k_7=0;
				int k_28=0;
				int k_disch=0;
				SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
				if(data_uid_value.equals(bd.kmc_unique_id))
				{
					comp_obj = (BasicDBList)jsonArray.get(0).get("comp_docs");
					//System.out.println("comp_docs = "+comp_obj);
					System.out.println("comp_obj size = "+comp_obj.size());	
					if(comp_obj.size()>0)
					{
						for(int i=0; i<comp_obj.size(); i++)
						{
							if(i==0)//table head for each different kmc_period and print table head at oly one time
							{
								%>
								<div class="container">
								<div class="panel-body">
								<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped">
								<thead>
								  	<tr style="background-color:grey;color:white;">
								       <th colspan="10" style="border:1px solid white"> Date of Call_7 </th>												       
								    </tr>
								    <tr style="background-color:grey;color:white">			
										<th colspan="3"> Attempt_Status </th>
										<th colspan="2"> Caller_Details </th>
										<th colspan="3"> Called_To </th>
										<th colspan="2"> Status </th>														
									</tr>
									<tr style="background-color:#FAEBD7;color:black">					
										<th> No. of attempt </th>
										<th> Attempt_Dates </th>
										<th> Attempt_Time </th>
										<th> Name </th>
										<th> Role </th>
										<th> Name </th>
										<th> Role </th>
										<th> Phone </th>
										<th> Status </th>
										<th> Remarks </th>				
									</tr>
								</thead>
								<tbody id="call_7">
								</tbody>
								</table>
								</div>
								</div>
								</div>
								
								<div class="container">
								<div class="panel-body">
								<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped">
								<thead>
								  	<tr style="background-color:grey;color:white;">
								       <th colspan="10" style="border:1px solid white"> Date of Call after discharge_7 </th>												       
								    </tr>
								    <tr style="background-color:grey;color:white">			
										<th colspan="3"> Attempt_Status </th>
										<th colspan="2"> Caller_Details </th>
										<th colspan="3"> Called_To </th>
										<th colspan="2"> Status </th>														
									</tr>
									<tr style="background-color:#FAEBD7;color:black">					
										<th> No. of attempt </th>
										<th> Attempt_Dates </th>
										<th> Attempt_Time </th>
										<th> Name </th>
										<th> Role </th>
										<th> Name </th>
										<th> Role </th>
										<th> Phone </th>
										<th> Status </th>
										<th> Remarks </th>				
									</tr>
								</thead>
								<tbody id="disch_7">
								</tbody>
								</table>								
								</div>
								</div>
								</div>
								
								<div class="container">
								<div class="panel-body">
								<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped">
								<thead>
								  	<tr style="background-color:grey;color:white;">
								       <th colspan="10" style="border:1px solid white"> Date of Call_28 </th>												       
								    </tr>
								    <tr style="background-color:grey;color:white">			
										<th colspan="3"> Attempt_Status </th>
										<th colspan="2"> Caller_Details </th>
										<th colspan="3"> Called_To </th>
										<th colspan="2"> Status </th>														
									</tr>
									<tr style="background-color:#FAEBD7;color:black">					
										<th> No. of attempt </th>
										<th> Attempt_Dates </th>
										<th> Attempt_Time </th>
										<th> Name </th>
										<th> Role </th>
										<th> Name </th>
										<th> Role </th>
										<th> Phone </th>
										<th> Status </th>
										<th> Remarks </th>				
									</tr>
								</thead>
								<tbody id="call_28">
								</tbody>
								</table>
								</div>
								</div>
								</div>
								<%
							}
							comp_obj_0= (BasicDBObject)comp_obj.get(i);
							//System.out.println("comp_obj_"+i+" are = "+comp_obj_0);
							//searh only failed details by keeping kmc_period and surveytype as base input
							if(comp_obj_0.containsField("surveyType"))
							{							
								if(comp_obj_0.containsField("status"))
								{
									if(comp_obj_0.get("surveyType").equals("kmc_details_cc") && comp_obj_0.get("status").equals("failed"))
									{										
										comp_failed = (BasicDBObject)comp_obj.get(i);
										System.out.println("failed array ="+comp_failed);
										if(comp_failed.containsField("callDate"))
										{
											bd.calldate=comp_failed.get("callDate");
											if(bd.calldate instanceof String)
											{
												System.out.println("yes date is in string");
												call_date = (String)bd.calldate;											
												System.out.println("date in string ="+call_date);
											}
											else if(bd.calldate instanceof Date)
											{
												System.out.println("yes date is in Date object");
												java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
												sdf2.setTimeZone(tz);
												Date date=(Date)comp_failed.get("callDate");
												String datenew = sdf2.format(date);
												System.out.println("date convert="+datenew);
												String[] splitStr = ((String)datenew).split(" ");
												call_time= splitStr[1]+" "+splitStr[2];
												call_date = splitStr[0];
												System.out.println("date="+call_date);
												System.out.println("time="+call_time);
											}
										}
										if(comp_failed.containsField("status"))
										{
											bd.fstatus=comp_failed.get("status");
											System.out.println("sttaus ="+bd.fstatus);
										}
										//System.out.println();
										if(comp_failed.containsField("remarks"))
										{
											bd.remarks=comp_failed.get("remarks");
										}
										if(comp_failed.containsField("Name"))
										{
											bd.calledto=comp_failed.get("Name");
											System.out.println("name ="+bd.calledto);
										}
										if(comp_failed.containsField("type"))
										{	
											bd.type=comp_failed.get("type");
										}
										if(comp_failed.containsField("phone"))
										{
											bd.phno=comp_failed.get("phone");
										}
										if(comp_failed.containsField("callerName"))
										{
											bd.callername=comp_failed.get("callerName");
										}
										if(comp_failed.containsField("role"))
										{
											bd.callerrole=comp_failed.get("role");
										}					
										
										if(comp_failed.containsField("kmc_period"))
										{										
											if(comp_failed.get("kmc_period").equals("2"))
											{	
												++k_7;												
												//System.out.println("kmc period inside compare ="+comp_failed.get("kmc_period"));
												attempt_date_7=call_date;
												attempt_time_7=call_time;
												callername_7 = bd.callername;
												callerrole_7 = bd.callerrole;
												calledto_7 = bd.calledto;
												type_7 = bd.type;
												phnum_7 = bd.phno;
												remarks_7 = bd.remarks;	
												status_7=bd.fstatus;											
												%>
													<script>			
														var table_7=document.getElementById("call_7"); 
														var row_7 = table_7.insertRow();
														var cell1 = row_7.insertCell(0);
														var cell2 = row_7.insertCell(1);
														var cell3 = row_7.insertCell(2);
														var cell4 = row_7.insertCell(3);
														var cell5 = row_7.insertCell(4);
														var cell6 = row_7.insertCell(5);
														var cell7 = row_7.insertCell(6);
														var cell8 = row_7.insertCell(7);
														var cell9 = row_7.insertCell(8);
														var cell10 = row_7.insertCell(9);
														cell1.innerHTML="<b>Attempt_"+<%= k_7%>+"</b>";
														cell2.innerHTML="<%= attempt_date_7%>";
														cell3.innerHTML="<%= attempt_time_7%>";
														cell4.innerHTML="<%= callername_7%>";
														cell5.innerHTML="<%= callerrole_7%>";
														cell6.innerHTML="<%= calledto_7%>";
														cell7.innerHTML="<%= type_7%>";
														cell8.innerHTML="<%= phnum_7%>";
														cell9.innerHTML="<%= status_7%>";
														cell10.innerHTML="<%=  remarks_7%>";													
													</script>
												<%
											}									
											else if(comp_failed.get("kmc_period").equals("4"))
											{
												++k_28;
												//System.out.println("kmc period inside compare ="+comp_failed.get("kmc_period"));
												attempt_date_28=call_date;
												attempt_time_28=call_time;
												callername_28 = bd.callername;
												callerrole_28 = bd.callerrole;
												calledto_28 = bd.calledto;
												type_28 = bd.type;
												phnum_28 = bd.phno;
												remarks_28 = bd.remarks;	
												status_28=bd.fstatus;
												%>
													<script>			
														var table_28=document.getElementById("call_28"); 
														var row_28 = table_28.insertRow();
														var cell1 = row_28.insertCell(0);
														var cell2 = row_28.insertCell(1);
														var cell3 = row_28.insertCell(2);
														var cell4 = row_28.insertCell(3);
														var cell5 = row_28.insertCell(4);
														var cell6 = row_28.insertCell(5);
														var cell7 = row_28.insertCell(6);
														var cell8 = row_28.insertCell(7);
														var cell9 = row_28.insertCell(8);
														var cell10 = row_28.insertCell(9);
														cell1.innerHTML="<b>Attempt_"+<%= k_28%>+"</b>";
														cell2.innerHTML="<%= attempt_date_28%>";
														cell3.innerHTML="<%= attempt_time_28%>";
														cell4.innerHTML="<%= callername_28%>";
														cell5.innerHTML="<%= callerrole_28%>";
														cell6.innerHTML="<%= calledto_28%>";
														cell7.innerHTML="<%= type_28%>";
														cell8.innerHTML="<%= phnum_28%>";
														cell9.innerHTML="<%= status_28%>";
														cell10.innerHTML="<%=  remarks_28%>";													
													</script>
												<%											
											}
											else if(comp_failed.get("kmc_period").equals("3"))
											{
												++k_disch;
												date_disch_7 = call_date;
												disch_time_7 = call_time;
												disch_callername_7 =  bd.callername;
												disch_callerrole_7 = bd.callerrole;
												disch_calledto_7 = bd.calledto;
												disch_type_7 = bd.type;
												disch_phnum_7 = bd.phno;
												disch_remarks_7 = bd.remarks;
												disch_status_7 = bd.fstatus;
												%>
												<script>													
													var table_disch=document.getElementById("disch_7"); 
													var row_disch = table_disch.insertRow();
													var cell1 = row_disch.insertCell(0);
													var cell2 = row_disch.insertCell(1);
													var cell3 = row_disch.insertCell(2);
													var cell4 = row_disch.insertCell(3);
													var cell5 = row_disch.insertCell(4);
													var cell6 = row_disch.insertCell(5);
													var cell7 = row_disch.insertCell(6);
													var cell8 = row_disch.insertCell(7);
													var cell9 = row_disch.insertCell(8);
													var cell10 = row_disch.insertCell(9);
													cell1.innerHTML="<b>Attempt_"+<%= k_disch%>+"</b>";
													cell2.innerHTML="<%= date_disch_7%>";
													cell3.innerHTML="<%= disch_time_7%>";
													cell4.innerHTML="<%= disch_callername_7%>";
													cell5.innerHTML="<%= disch_callerrole_7%>";
													cell6.innerHTML="<%= disch_calledto_7%>";
													cell7.innerHTML="<%= disch_type_7%>";
													cell8.innerHTML="<%= disch_phnum_7%>";
													cell9.innerHTML="<%= disch_status_7%>";
													cell10.innerHTML="<%=  disch_remarks_7%>";												
												</script>
											<%										
											}										
										}//close of kmc_period	
									}//close if of surveytype and status compare
									else
									{
										continue;
									}								
								}//close if of status compare
								else
								{
									continue;
								}
							}//close if of surveytype compare 
							System.out.println("no of kmc_period 2="+k_7);
							System.out.println("no of kmc_period 3="+k_disch);
							System.out.println("no of kmc_period 4="+k_28);						
						}//close for loop
						if(k_7==0)
						{
							%>
							<script>
							var table_7=document.getElementById("call_7");
							var row_7 = table_7.insertRow();
							var cell1_7 = row_7.insertCell(0);														
							cell1_7.colSpan="10";
							cell1_7.innerHTML="<h4 style=\"text-align:left;color:red;\">No details</h4>";
							</script>
							<%
						}
						if(k_28==0)
						{
							%>
							<script>
							var table_28=document.getElementById("call_28");
							var row_28 = table_28.insertRow();
							var cell1_28 = row_28.insertCell(0);							
							cell1_28.colSpan="10";
							cell1_28.innerHTML="<h4 style=\"text-align:left;color:red;\">No details</h4>";
							</script>
							<%
						}
						if(k_disch==0)
						{
							%>
							<script>
							var table_disch=document.getElementById("disch_7");
							var row_disch = table_disch.insertRow();
							var cell1_disch = row_disch.insertCell(0);							
							cell1_disch.colSpan="10";
							cell1_disch.innerHTML="<h4 style=\"text-align:left;color:red;\">No details</h4>";
							</script>
							<%							
						}						
					}//close if of comp_docs array size>0
					else//when no kmc details kmc_array=0
					{
						%>						
						<div class="container">
						<div class="table-responsive">
						<table class="table table-bordered table-hover table-striped">
						<thead>
						  	<tr style="background-color:grey;color:white;">
						       <th colspan="10" style="border:1px solid white"> Date of Call_28 </th>												       
						    </tr>
						    <tr style="background-color:grey;color:white">			
								<th colspan="3"> Attempt_Status </th>
								<th colspan="2"> Caller_Details </th>
								<th colspan="3"> Called_To </th>
								<th colspan="2"> Status </th>														
							</tr>
							<tr style="background-color:#FAEBD7;color:black">					
								<th> No. of attempt </th>
								<th> Attempt_Dates </th>
								<th> Attempt_Time </th>
								<th> Name </th>
								<th> Role </th>
								<th> Name </th>
								<th> Role </th>
								<th> Phone </th>
								<th> Status </th>
								<th> Remarks </th>				
							</tr>
						</thead>
						<tbody>
							<tr><td colspan="10"> <h4 style="text-align:left;color:red;">No details</h4></td></tr>
						</tbody>
						</tbody>
						</table>
						</div>
						</div>
						<%
					}
				}//if close for unique id compare								
				%>
				<div class="container" align="center">
					<form class="form-inline">	
					<div class="form-group">
						<input type="button" class="btn btn-info" style="color:black;" onclick="goBack()" value="Go-Back">
					</div>
					</form>
				</div>				
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