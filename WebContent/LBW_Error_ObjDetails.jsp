<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Error Object Details </title>
		<link rel="stylesheet" href="Responsive_Style.css">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
		var delcnt={};
		console.log(delcnt);
		function goBack(count) {		
			window.delcnt=count;
			// Save data to sessionStorage
			sessionStorage.setItem('key', count);			
			//alert(count);
		    window.history.back();
		}		
		</script>
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
				width: 3314px;
				margin-bottom:0px;
				border:1px solid #999;
			
			}
			.tablebody {
				height: 400px;
				overflow-y: auto;
				width: 3314px;
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
		<%@page import = "com.mongodb.util.JSON"%>	
		<%@ include file="Config.jsp" %>
		 <%@ include file="home.jsp" %> 	
		
		<h1 style = "text-align:center; color:brown;"> Error Object Report </h1>				
		<br />		
		<%
			response.setContentType("text/html");		
			String object_id = null;
			try
			{			  	
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
				com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();	
				DB database = mongo.getDB(db);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);
				
				String delcount=request.getParameter("count");
				System.out.println("delete count="+delcount);
				
				object_id = request.getParameter("id");
				String jspname = request.getParameter("filename");
				System.out.println("Object id from jsp page="+object_id);				
				
				BasicDBObject query = new BasicDBObject();				
				query.put("_id", new ObjectId(object_id));				
				DBCursor cursor = collection.find(query);    			
				System.out.println("Size of output:"+cursor.size());
				int count =0;				
				%>
				<!-- create table and header for the table -->	
				<div class="container">				
				<div class="row">				
				<div class="table-responsive2">				  
				<table class="table table-bordered table-striped tableheader">
				<thead>			
					<tr>							
						<th style="width:100px;text-align:center;"> Date </th>							
						<th style="width:100px;text-align:center;"> Period </th>
						<th style="width:100px;text-align:center;"> Facility </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> Nurse_Mentor </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> No_of_Deliveries </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> No_of_Babies </th>
						<th style="width:100px;text-align:center;"> gt_24ga</th>
						<th style="width:100px;text-align:center;"> Still_Births </th>
						<th style="width:100px;text-align:center;"> No_of_lbws </th>							
						<th style="width:100px;text-align:center;word-wrap:break-word;"> No_below_2000 </th>							
						<th style="width:100px;text-align:center;word-wrap:break-word;"> No_of_out_borns </th>	
						<th style="width:200px;text-align:center;"> Unique_ID </th>
						<th style="width:100px;text-align:center;"> Baby_DOB </th>
						<th style="width:100px;text-align:center;"> SurveyType </th>
						<th style="width:100px;text-align:center;"> Patient_ID1 </th>
						<th style="width:100px;text-align:center;"> Patient_ID2 </th>
						<th style="width:150px;text-align:center;"> Mother_Name </th>
						<th style="width:150px;text-align:center;"> Husband_Name </th>
						<th style="width:100px;text-align:center;"> Time_of_Birth </th>
						<th style="width:100px;text-align:center;"> Birth_Weight </th>
						<th style="width:100px;text-align:center;"> Baby_Sex </th>
						<th style="width:100px;text-align:center;"> Baby_Status </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> Taluk_From </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> Taluk_To </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> Community_to </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> Community_From </th>
						<th style="width:100px;text-align:center;"> Phone1 </th>
						<th style="width:100px;text-align:center;"> Phone2 </th>
						<th style="width:100px;text-align:center;word-wrap:break-word;"> Thayi_Card_No </th>
						<th style="width:100px;text-align:center;"> UID </th>
						<th style="text-align:center;"> EPIC </th>														
					</tr>
				</thead>
				</table>
				<div class="tablebody">
                <table class="table table-bordered table-striped" >
                <tbody>			
				<%
				while(cursor.hasNext())
				{	
					//cursor move on each object
					DBObject dbobj = cursor.next();
					System.out.println("Object are = "+dbobj);									
					
					//get objectID of each object
					ObjectId objid = (ObjectId) dbobj.get("_id");
					System.out.println("Each objects id are = " + objid);								
					
					//convert ObjectID into date format
					Date enterDate = objid.getDate();
					SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:ss:mm a");
					java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
					sdf1.setTimeZone(tz);
					String formatDate = sdf1.format(enterDate);
					System.out.println("Formatted object entered date = " +formatDate);
					
					//get an array of data stored in mongodb 
					BasicDBList data = (BasicDBList) dbobj.get("data");
					System.out.println("Data array="+data);								
					
					//convert list into BasiccDBObject to retrive each fields
					BasicDBObject data0Obj = (BasicDBObject)data.get(0);
					System.out.println("Data.0th elements ="+data0Obj);							
				
					//retreive each field from data.0 object
					if(data0Obj.containsField("from_date"))							
						bd.from_date = data0Obj.getString("from_date");
					if(data0Obj.containsField("to_date"))								
						bd.to_date = data0Obj.getString("to_date");
					bd.facility = data0Obj.getInt("facility");								
					bd.nm = data0Obj.getInt("nm");
					
					bd.no_of_deliveries = data0Obj.get("no_of_deliveries");
					if(bd.no_of_deliveries instanceof String)
					{
						bd.no_of_deliveries = data0Obj.get("no_of_deliveries");
					}
					else
					{
						bd.no_of_deliveries = data0Obj.getInt("no_of_deliveries");
					}
					
					bd.no_of_babies = data0Obj.get("no_of_babies");
					if(bd.no_of_babies instanceof String)
					{
						bd.no_of_babies = data0Obj.get("no_of_babies");
					}
					else
					{
						bd.no_of_babies = data0Obj.getInt("no_of_babies");
					}
					
					bd.gt_24ga = data0Obj.get("gt_24ga");
					if(bd.gt_24ga instanceof String)
					{
						bd.gt_24ga = data0Obj.get("gt_24ga");
					}
					else
					{
						bd.gt_24ga = data0Obj.getInt("gt_24ga");
					}
					
					bd.still_births = data0Obj.get("still_births");
					if(bd.still_births instanceof String)
					{
						bd.still_births = data0Obj.get("still_births");
					}
					else
					{
						bd.still_births = data0Obj.getInt("still_births");
					}
					
					bd.no_of_lbws = data0Obj.get("no_of_lbws");
					if(bd.no_of_lbws instanceof String)
					{
						bd.no_of_lbws = data0Obj.get("no_of_lbws");
					}
					else
					{
						bd.no_of_lbws = data0Obj.getInt("no_of_lbws");
					}
					
					bd.no_below_2000 = data0Obj.get("no_below_2000");
					if(bd.no_below_2000 instanceof String)
					{
						bd.no_below_2000 = data0Obj.get("no_below_2000");
					}
					else
					{
						bd.no_below_2000 = data0Obj.getInt("no_below_2000");
					}
					
					if(data0Obj.containsField("no_of_ob_lbws"))	
					{
						bd.no_of_ob_lbws = data0Obj.get("no_of_ob_lbws");
						if(bd.no_of_ob_lbws instanceof String)
						{
							bd.no_of_ob_lbws = data0Obj.get("no_of_ob_lbws");
						}
						else
						{
							bd.no_of_ob_lbws = data0Obj.getInt("no_of_ob_lbws");
						}
					}
					
					//list fro an data.1 array of mongodb
					BasicDBList data1list = (BasicDBList)data.get(1);								
					System.out.println("Data.1 objects ="+data1list);						
					
					int size = data1list.size();//data.1 array size
					System.out.println("Data.1 objects size="+size);								
					%>
					<tr>													
						<td rowspan = <%= (size)%> style="width:100px;"> <%= formatDate%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.from_date +" to "+ bd.to_date%> </td>						    	
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.facility%></td> 
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.nm%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.no_of_deliveries%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.no_of_babies%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.gt_24ga%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.still_births%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.no_of_lbws%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.no_below_2000%> </td>
						<td rowspan = <%= (size)%> style="width:100px;"> <%= bd.no_of_ob_lbws%> </td>	
					<%
					if(size>0)
					{
						for(int i=0; i<data1list.size(); i++)
						{
							System.out.println("data.1.["+i+"] elements = "+data1list.get(i));	
							BasicDBObject data1Obj = (BasicDBObject) data1list.get(i);
							//data1Obj.isEmpty()
													
							if(data1Obj.containsField("dob1"))
							{
								bd.dob = data1Obj.getString("dob1");
							}
							else
								bd.dob = "-";
							if(data1Obj.containsField("unique_id"))
							{
								bd.u_id = data1Obj.getString("unique_id");
							}
							else
								bd.u_id = "-";
							if(data1Obj.containsField("pid1"))
							{
								bd.pid1 = data1Obj.get("pid1");
								if(bd.pid1 instanceof String)
								{
									bd.pid1 = data1Obj.get("pid1");
								}
								else
								{
									bd.pid1 = data1Obj.getInt("pid1");
								}	
							}
							//System.out.println("pid1:"+bd.pid1);
							else{
									bd.pid1 = "-";
							}
							if(data1Obj.containsField("pid2"))
							{
								bd.pid2 = data1Obj.get("pid2");
								if(bd.pid2 instanceof String)
								{
									bd.pid2 = data1Obj.get("pid2");
								}
								else
								{
									bd.pid2 = data1Obj.getInt("pid2");
								}
								//System.out.println("pid2:"+bd.pid2);
							}
							else{
									bd.pid2 ="-";
								}
							if(data1Obj.containsField("time_of_birth"))
							{
								bd.time_of_birth = data1Obj.getString("time_of_birth");
							}
							else
								bd.time_of_birth = "-";
							//to ckeck whether the time is in 12hrs format									
							String time12hrs = tc.convert24To12Format((String)bd.time_of_birth);
							System.out.println("time in 24hrs format = "+bd.time_of_birth);
							System.out.println("time in 12hrs format = "+time12hrs);
							System.out.println();
							bd.time_of_birth = time12hrs;
							
							if(data1Obj.containsField("thayi_card_no"))
							{
								bd.thayi_card_no = data1Obj.getLong("thayi_card_no");
								//System.out.println("thayi_card_no:"+bd.thayi_card_no);
							}	
							else{
									bd.thayi_card_no ="-";
								}
										
							if(data1Obj.containsField("baby_status"))
							{
								bd.baby_status = data1Obj.getString("baby_status");
							}
							else
								bd.baby_status = "-";
										
							if(data1Obj.containsField("mother_name"))
							{
								bd.mother_name = data1Obj.getString("mother_name");//getInt("epic");
							}
							else
								bd.mother_name = "-";
										
							if(data1Obj.containsField("sex"))
							{
								bd.sex = data1Obj.getString("sex");//getInt("epic");
							}
							else
								bd.sex = "-";
										
							if(data1Obj.containsField("phone2"))
							{
								bd.phone2 = data1Obj.getLong("phone2");
							}
							else
								bd.phone2 = "-";
										
							if(data1Obj.containsField("epic"))
							{
								bd.epic = data1Obj.get("epic");
								if(bd.epic instanceof String)
								{
									bd.epic = data1Obj.get("epic");
								}
								else
								{	
									bd.epic = data1Obj.getInt("epic");
								}
								//System.out.println("epic:"+bd.epic);
							}	
							else{
									bd.epic ="-";
								}
										
							if(data1Obj.containsField("phone1"))
							{
								bd.phone1 = data1Obj.getLong("phone1");
							}
							else
								bd.phone1 = "-";
										
							if(data1Obj.containsField("uid"))
							{
								bd.uid = data1Obj.get("uid");
								if(bd.uid instanceof String)
								{
									bd.uid = data1Obj.get("uid");
								}
								else
								{
									bd.uid = data1Obj.getInt("uid");
								}
								//System.out.println("uid:"+bd.u_id);
							}
							else{
									bd.uid ="-";
								}
	
							if(data1Obj.containsField("birth_weight"))
							{
								bd.birth_weight = data1Obj.getInt("birth_weight");
								//System.out.println("birth_weight:"+bd.birth_weight);
							}	
							else{
									bd.birth_weight="-";
							}
								
							if(data1Obj.containsField("taluk_from"))
							{
								bd.taluk_from = data1Obj.get("taluk_from");
								if(bd.taluk_from instanceof String)
								{
									if(bd.taluk_from.equals("other"))
									{
										bd.taluk_from = data1Obj.get("taluk_from")+" [" +data1Obj.get("taluk_from-Comment")+"]";
										//System.out.println("taluk_from:"+bd.taluk_from);
									}
									else
									{
										bd.taluk_from = data1Obj.get("taluk_from");
									}
								}
								else
								{
									bd.taluk_from = data1Obj.getInt("taluk_from");
									//System.out.println("taluk_from:"+bd.taluk_from);
								}
							}	
							else{
									bd.taluk_from ="-";
							}
							if(data1Obj.containsField("taluk_to"))
							{
								bd.taluk_to = data1Obj.get("taluk_to");
								if(bd.taluk_to instanceof String)
								{
									if(bd.taluk_to.equals("other"))
									{
										bd.taluk_to = data1Obj.get("taluk_to")+" [" +data1Obj.get("taluk_to-Comment")+"]";
										//System.out.println("taluk_to:"+bd.taluk_to);
									}
									else
									{
										bd.taluk_from = data1Obj.get("taluk_to");
									}
								}
								else
								{
									bd.taluk_to = data1Obj.getInt("taluk_to");
									//System.out.println("uid:"+bd.taluk_to);
								}
							}
							else{
									bd.taluk_to="-";
								}
							if(data1Obj.containsField("community_to"))
							{
								bd.community_to = data1Obj.get("community_to");
								if(bd.community_to instanceof String)
								{
									if(bd.community_to.equals("other"))
									{
										bd.community_to = data1Obj.get("community_to")+" [" +data1Obj.get("community_to-Comment")+"]";
										//System.out.println("community_to:"+bd.community_to);
									}
								}
								else
								{
									bd.community_to = data1Obj.getInt("community_to");
									//System.out.println("community_to:"+bd.community_to);
								}
								}
								else{
										bd.community_to ="-";
									}
								if(data1Obj.containsField("community_from") )
								{
									bd.community_from = data1Obj.get("community_from");
									if(bd.community_from instanceof String)
									{
										if(bd.community_from.equals("other"))
										{
											bd.community_from = data1Obj.get("community_from")+" [" +data1Obj.get("community_from-Comment")+"]";
											//System.out.println("community_from:"+bd.community_from);
										}
									}						
									else
									{
										bd.community_from = data1Obj.getInt("community_from");
										//System.out.println("community_from:"+bd.community_from);
									}
								}
								else{
										bd.community_from = "-";
								}
								if(data1Obj.containsField("husband_name"))
								{
									bd.husband_name = data1Obj.getString("husband_name");
								}
								else
									bd.husband_name = "-";
										
								if(data1Obj.containsField("surveyType"))
								{	
									bd.surveytype = data1Obj.getString("surveyType");	
								}
								else
									bd.surveytype="-";							
							System.out.println();
							System.out.println();
							%>								
								<td style="width:200px;"><%= bd.u_id%></td>
								<td style="width:100px;"><%= bd.dob%></td>
								<td style="width:100px;"><%= bd.surveytype%></td>
								<td style="width:100px;"><%= bd.pid1%></td>
								<td style="width:100px;"><%= bd.pid2%></td>
								<td style="width:150px;word-wrap:break-word;"><%= bd.mother_name%></td>
								<td style="width:150px;word-wrap:break-word;"><%= bd.husband_name%></td>
								<td style="width:100px;"><%= bd.time_of_birth%></td>
								<td style="width:100px;"><%= bd.birth_weight%></td>
								<td style="width:100px;"><%= bd.sex%></td>
								<td style="width:100px;"><%= bd.baby_status%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_from%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_to%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.community_to%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.community_from%></td>
								<td style="width:100px;"><%= bd.phone1%></td>
								<td style="width:100px;"><%= bd.phone2%></td>							    	
								<td style="width:100px;word-wrap:break-word;"><%= bd.thayi_card_no%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.uid%></td>
								<td style="word-wrap:break-word;"><%= bd.epic%></td>															
							</tr>						
							<%						
							}//close for loop of data.1	
						}
						else
						{
							%>								
							<td colspan=20 style="width:2200px"> </td>															
						</tr>						
						<%	
						}
				}//close cursor loop	
				%>
					</tbody>
					</table>
					</div>
					</div>
					</div>
					</div>
					<br />
					<center>
					<form style = text-align:center;color:blue class="form-inline">
						<h3 style = text-align:center; color:brown> Want to delete this Object? </h3>
						<div class="form-group">							
							<input type="button" id="delete_yes" name="delete_yes" onClick = "window.location.href='deleteRecords.jsp?filename=<%= jspname%>&id1=<%=object_id%>'" class="btn btn-warning form-control" value="Yes_Delete"> 
						</div>
						<div class="form-group">							
							<input type="button" id="delete_no" name="delete_no" onClick = "goBack(<%= delcount%>)" class="btn btn-primary form-control" Value="No">				
						</div>						
					</form>	
					</center>	
				<%			
			}//close try block						
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
			}
			%>					
	</body>
</html>