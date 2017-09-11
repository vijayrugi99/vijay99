<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title> 28thday Babies </title>
	<script src="facilities.js">	</script>
	<script src="koppal_villages.js"></script>
	<script src="communityWorkers.js"></script>
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
			width: 1150px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 500px;
			overflow-y: auto;
			width: 1168px;
			margin-bottom:20px;
		}		
   </style>
	<script>
		function goBack() 
		{
			//var x = document.referrer;
			//console.log(x);
		    window.history.back();		    
		}
		</script>
</head>
<body onload="backToLogin()">
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
	<%@ include file="home.jsp" %>
	<%@page import = "com.mongodb.util.JSON"%> 
	<% String value = request.getParameter("facility");
		String kmcprd = request.getParameter("kmcPeriod");
		System.out.println("kmcPeriod in 7thday life from kmc_tracking= "+kmcprd);
		System.out.println("facility in 7thday life from kmc_tracking= "+value);%>
		<h3 style="color:brown; text-align:center;"> 28th day life Babies </h3>
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
				int facility = value==null?1:Integer.parseInt(value);
				int kmcPeriod = Integer.parseInt(kmcprd);
				System.out.println("kmcPeriod in 28thday life = "+kmcPeriod);
				System.out.println("facility in 28thday life = "+value);
				ArrayList<DBObject> jsonArray = mongodao.getBabiesForPeriod(facility,kmcPeriod);
				//out.println(jsonArray.size()+" "+kmcPeriod+" "+facility);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int count=0;
				%>		
				<div class="container">				
				<div class="row">				
				  <div id="28th day life babies" class="exporttable table-responsive2">				  
				    <table class="table table-bordered table-striped tableheader">
				        <thead>
				            <tr>
				            	<th style="width:100px;text-align:center;">Sl No.</th>
		                          <th style="width:100px;text-align:center;">Facility</th>
		                          <th style="width:150px;text-align:center;">DOB</th>
		                          <th style="width:250px;text-align:center;">Unique_ID</th>
		                          <th style="width:200px;text-align:center;">Mother</th>
		                          <th style="width:200px;text-align:center;">Father</th>
		                          <th style="text-align:center;">Type</th>
				            </tr>
				        </thead>
     					</table>
				      <div class="tablebody">
                      <table class="table table-bordered table-striped" >
                        <tbody>
	   					<% 	
	   						//String containsKmc_cc="no";
	   						int count2=0;
							for(int i=0; i<jsonArray.size(); i++)
							{								
								int babyCount=++count2;
								System.out.println("baby count="+babyCount);
								BasicDBList comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");
								//System.out.println("comp_docs = "+comp_obj);
								String containsKmc_cc="no";
								System.out.println("comp_obj size is = "+comp_obj.size());	
								
								//check for whether the baby has kmc_details_cc surveytype
								for(int k=0; k < comp_obj.size(); k++)
								{
									System.out.println("kmc_period ="+kmcPeriod);
									BasicDBObject comp_obj_array =(BasicDBObject)comp_obj.get(k);
									//System.out.println("comp_obj_array["+k+"]"+comp_obj_array);
									
									if(comp_obj_array.containsField("mother_alive"))
									{
										bd.mother_alive=comp_obj_array.get("mother_alive");
										//System.out.println("Is mother alive ="+bd.mother_alive);
									}
									if(comp_obj_array.containsField("baby_alive"))
									{
										bd.baby_alive=comp_obj_array.get("baby_alive");
										//System.out.println("Is baby alive ="+bd.baby_alive);
									}
									if(comp_obj_array.containsField("surveyType"))
									{
										if(comp_obj_array.get("surveyType").equals("kmc_details_cc"))
										{	
											String kmcperiod = Integer.toString(kmcPeriod);
											System.out.println("db kmc_period ="+comp_obj_array.get("kmc_period"));
											System.out.println("dropdown kmc_period ="+kmcperiod);
											if((bd.baby_alive.equals("No"))
													&& (comp_obj_array.get("kmc_period").equals("2") || 
													comp_obj_array.get("kmc_period").equals("3") || 
													comp_obj_array.get("kmc_period").equals("4")))
											{
												containsKmc_cc="yes";
												System.out.println("contains baby alive(no)+kmc period ="+containsKmc_cc);
											}
											if(comp_obj_array.get("kmc_period").equals(kmcperiod))
											{	
												//when failed
												if(comp_obj_array.containsField("status"))
												{
													//if(comp_obj_array.get("status").equals("failed"))
													containsKmc_cc="no";
													System.out.println("contains status(failed)="+containsKmc_cc);			
												}												
												
												//when success
												else
												{
													containsKmc_cc="yes";
													System.out.println("contains success="+containsKmc_cc);
												}
											}
										}										
									}																		
								}
								System.out.println("contains after loop="+containsKmc_cc);
								System.out.println();
								//if baby has kmc_details_cc surveytype move to next baby
								if(containsKmc_cc.equals("yes"))
								{									
									continue;
								}
								//if baby doesn't have kmc_details_cc surveytype print baby
								else
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
									//today date calculation
									SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
									String  start_date = sdf.format(new Date());
									Calendar ca = Calendar.getInstance();
									ca.setTime(sdf.parse(start_date));
									ca.add(Calendar.DATE,0);  
									start_date = sdf.format(ca.getTime());
									//System.out.println("yesterday date = "+start_date);
									BasicDBObject facilityData = (BasicDBObject)jsonArray.get(i).get("facility");
									bd.facility = facilityData.getInt("facility");
									//System.out.println("Faility are ="+bd.facility);
									BasicDBObject kmcData = (BasicDBObject)jsonArray.get(i).get("data");
									bd.dob = kmcData.get("dob1");
									bd.u_id = kmcData.get("unique_id");
									bd.mother_name = kmcData.get("mother_name");
									bd.husband_name = kmcData.get("husband_name");								
									System.out.println();
									Object commFrom = kmcData.get("community_from")+"";						
									Object commTo = kmcData.get("community_to")+"";
									%>					
									<tr>
										<td style="width:100px;text-align:center;"> <%= (++count)%> </td>
										<td style="width:100px;text-align:center;"> <%= bd.facility%> </td>
										<td style="width:150px;text-align:center;"> <%= bd.dob%> </td>
										<td style="width:250px;text-align:center;"> <%= bd.u_id%> </td>
										<td style="width:200px;text-align:center;"> <%= bd.mother_name%> </td>
										<td style="width:200px;text-align:center;"> <%= bd.husband_name%> </td>			
										<td style="text-align:center;"><%=kmcData.get("surveyType")%></td>			
									</tr>
								<%	
								}//else close for kmc_cc contains
							}//close array loop		
							%>
							</tbody>
			  				</table>
			  				</div>
							</div>
							</div>	
							</div>
							<br />							
							<form style = text-align:center;color:blue class="form-inline">																
								<div class="form-group">							
									<input type="button" id="back" name="back" onClick = "goBack()" class="btn btn-primary form-control" Value="Go-Back">				
								</div>						
							</form>							
							<%
						}//close try block			
						catch(Exception  e)
						{
							out.println("Exception::"+e);
							
							e.printStackTrace(response.getWriter());
						}			
					%>										
	<%@include file="tableexport.jsp" %>		
</body>
</html>