<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">		
		<meta charset="utf-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">  		
  		<link rel="stylesheet" type="text/css" href="Reports_Stylesheet.css">		
  		<script src="facilities.js">	</script>
		<script src="ken_kmc_html.js"></script>
		<title> KMC Initiated Babies</title>
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
		<%@include file="Config.jsp" %>
		<%-- <%@include file="home.jsp" %> --%>
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>
		
		<% 
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //date format
       		String value = request.getParameter("facility");
       		if(value == null)
       		{
       			value="1";
       		}
			System.out.println("facility value = "+value);
		
			//logic to increment one day from today's date
			Date dt = new Date();
			Calendar c = Calendar.getInstance(); 
			c.setTime(dt); 
			c.add(Calendar.DATE, 1);
			dt = c.getTime();
			
			String datefrom = request.getParameter("datefrom"); //get value from form			
			if(datefrom == null)
			{
				datefrom = "2016-09-03";
			}
			
			String dateto = request.getParameter("dateto"); //get value from form			
			if(dateto == null)
			{
				dateto = sdf.format(dt);
			}
		%>
		
		<form action="KMCInit_Babies.jsp" method="POST" style = "text-align:center; margin-top:20px">
			<h1 style = "color:brown"> KMC Initiated Babies </h1>				
			
			<div id="filters"> </div>
			<script>
				var str="<label style=\"font-size:20px; color:blue\"> DOB From: </label>";
				str+="<input style=\"width:10%; padding:3px\" id=\"datefrom\" name=\"datefrom\" type=\"date\" value=\"<%= datefrom%>\"> &nbsp";
				str+="<label style=\"font-size:20px; color:blue\"> DOB To: </label>";
				str+="<input style=\"width:10%;padding:3px\" id=\"dateto\" name=\"dateto\" type=\"date\" value=\"<%= dateto%>\">";
				var filterStr= DropdownFilter(facilityFilter,"<%= value%>");				
				<%-- filterStr+= DropdownFilter(recordsFilter,"<%= records%>"); --%>
				filters.innerHTML=filterStr+"&nbsp"+str;				
			</script>
			<br /> 			
			<input type="submit" value="Submit" id="submit" name="submit" style="color:blue; width:5%">	
			<br /> 	
			<br />																												
		</form>
		
		<!-- logic for compare two date -->
		<script>		
			var dfrom = "<%= datefrom%>";
			//console.log(dfrom);
			var dto = "<%= dateto%>";
			//console.log(dto);
			var d1 = new Date(dfrom);
			var d2 = new Date(dto);
			//console.log(d1);
			//console.log(d2);			
			
			if(d1 >= d2)
			{
				alert("From date should be less than To date");
			}	
		</script>
		<%
			//response.setContentType("text/html");					
			try
			{				
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				System.out.println("mongo = "+mongo);
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection); 				
				
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
				int facility = value==null?1:Integer.parseInt(value);
				//System.out.println("Facility in  jsp page ="+facility);
				//System.out.println("datefrom in  jsp page ="+datefrom);
				//System.out.println("dateto in  jsp page ="+dateto);
				ArrayList<DBObject> jsonArray = mongodao.kmcInitBabies(facility,datefrom,dateto);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int count=0;
				%>
				<center>
				<table id="KMCInitiated_Babies" width=1200>				
					<tr style = "color:brown;">
						<th width=30> SI. No. </th>
						<th width=100> Period </th>
						<th width=50> Facility </th>
						<th width=100> Unique_ID </th>
						<th width=100> DOB </th>
						<th width=75> Mother_Name </th>
						<th width=75> Husband_Name </th>
						<th width=30> Date_Of_KMC_Initiation </th>
						<th width=30> No_of_Days_of_kmc_entered </th>
						<th width=30> Status </th>
						<th width=100> View Details </th>
					</tr>				
				<% 	
				Object disStatus = "-";
				Object status = "-";
				if(jsonArray.size() > 0)
				{				
					for(int i=0; i<jsonArray.size(); i++)
					{
						//System.out.println("DBObjects are ="+jsonArray.get(i));
						ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
						//System.out.println("Objet id are ="+objid);
						
						BasicDBObject facilityData = (BasicDBObject)jsonArray.get(i).get("facility");
						bd.facility = facilityData.getInt("facility");
	
						if(facilityData.containsField("from_date"))
						{
							bd.from_date = facilityData.get("from_date");
						}
						else
						{
							bd.from_date = "-";
						}
						if(facilityData.containsField("to_date"))
						{
							bd.to_date = facilityData.get("to_date");
						}
						else
						{
							bd.to_date = "-";
						}
						
						BasicDBObject kmcData = (BasicDBObject)jsonArray.get(i).get("data");
						bd.dob = kmcData.get("dob1");
						bd.mother_name = kmcData.get("mother_name");
						bd.husband_name = kmcData.get("husband_name");
						bd.u_id = kmcData.get("unique_id");
	
						//comp_docs list
						BasicDBList comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");					
						//System.out.println("comp_obj are:"+comp_obj);
						//System.out.println("comp_obj size is ="+comp_obj.size());
						
						//comp_docs 0th array list
						BasicDBObject comp_obj_0 = (BasicDBObject)comp_obj.get(0);					
						//System.out.println("comp_obj_0 :"+comp_obj_0);
						if(comp_obj_0.containsField("init_date1"))
						{
							bd.init_date1 = comp_obj_0.get("init_date1");
						}
						else if(comp_obj_0.containsField("date_of_kmc_initiation"))
						{
							Object d = comp_obj_0.get("date_of_kmc_initiation");
							Date initDate = new SimpleDateFormat("dd/MM/yyyy").parse((String)d);
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
							String parsedDate = formatter.format(initDate);
							bd.init_date1 = parsedDate;
						}
						else
						{
							bd.init_date1 = "--";
						}						
							
						if(comp_obj_0.containsField("kmc_initiation"))
						{
							if(comp_obj_0.get("kmc_initiation").equals("Discharged without initiation"))
							{
								bd.kmc_initiation = comp_obj_0.get("kmc_initiation");
							}
							else if(comp_obj_0.get("kmc_initiation").equals("Initiated"))
							{
								bd.kmc_initiation = comp_obj_0.get("kmc_initiation");
							}
						}
						else
							bd.kmc_initiation = "-";						
							
						int dateCount = 0;
						status="-";
						for(int j=1; j<comp_obj.size(); j++) //comp_obj array more than 1
						{							
							++dateCount;
							BasicDBObject comp_obj_1 = (BasicDBObject)comp_obj.get(j);
							//System.out.println("comp_obj_"+j+" is "+comp_obj_1);						
							bd.kmc_date = comp_obj_1.get("date");
							//System.out.println("comp_obj_"+j+" date is "+bd.kmc_date);
								
							if(comp_obj_1.containsField("discharged"))
							{
								BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
								disStatus = disList.get(0);
								if(disStatus.equals("discharged"))
								{
									status = disStatus;
								}
								else
								{
									status="-";
								}
								//System.out.println("discch status ="+status);
							}
							else
							{
								disStatus = "-";
							}
						}
						/* System.out.println("kmc_initiation = "+bd.kmc_initiation);
						System.out.println("dis status ="+disStatus);
						System.out.println("disch status ="+status); */
						//System.out.println();
						if(bd.kmc_initiation.equals("Discharged without initiation"))
						{
							/* System.out.println("when discharge without initiation");
							System.out.println(); */
							%>					
								<tr>
									<td> <%= (++count)%> </td>
									<td> <%= bd.from_date%> to <%= bd.to_date %> </td>
									<td> <%= bd.facility%> </td>
									<td> <%= bd.u_id%> </td>
									<td> <%= bd.dob%> </td>
									<td> <%= bd.mother_name%> </td>
									<td> <%= bd.husband_name%> </td>
									<td> <%= bd.init_date1%> </td>					
									<td> <%= dateCount%> </td>
									<td style="color:red"> Discharged without KMC</td>
									<td>										
										<input type="button" id="kmc" name = "kmc" value = "Discharge Details" style="color:blue" onClick="window.open('DischargeDetails_UID.jsp?unique_id=<%= bd.u_id%>')">
									</td>															
								</tr>					
							<%		
						}						
						else if(status.equals("discharged"))
						{
							//System.out.println("when discharge with  initiation");
							System.out.println();
							%>					
								<tr>
									<td> <%= (++count)%> </td>
									<td> <%= bd.from_date%> to <%= bd.to_date %> </td>
									<td> <%= bd.facility%> </td>
									<td> <%= bd.u_id%> </td>
									<td> <%= bd.dob%> </td>
									<td> <%= bd.mother_name%> </td>
									<td> <%= bd.husband_name%> </td>
									<td> <%= bd.init_date1%> </td>					
									<td> <%= dateCount%> </td>
									<td style="color:red"> KMC initiated, Discharged </td>
									<td>
										<input type="button" id="kmc" name = "kmc" value = "KMC Details" style="color:blue" onClick="window.open('KMCDetails_UID.jsp?unique_id=<%= bd.u_id%>')">
										<br />
										<br />
										<input type="button" id="kmc" name = "kmc" value = "Discharge Details" style="color:blue" onClick="window.open('DischargeDetails_UID.jsp?unique_id=<%= bd.u_id%>')">
									</td>															
								</tr>					
							<%		
						}
						else 
						{
							/* System.out.println("when baby not discharge");
							System.out.println(); */
							%>					
							<tr>
								<td> <%= (++count)%> </td>
								<td> <%= bd.from_date%> to <%= bd.to_date %> </td>
								<td> <%= bd.facility%> </td>
								<td> <%= bd.u_id%> </td>
								<td> <%= bd.dob%> </td>
								<td> <%= bd.mother_name%> </td>
								<td> <%= bd.husband_name%> </td>
								<td> <%= bd.init_date1%> </td>					
								<td> <%= dateCount%> </td>
								<td style="color:red"> KMC initiated, but Not Discharged </td>
								<td>
									<input type="button" id="kmc" name = "kmc" value = "KMC Details" style="color:blue" onClick="window.open('KMCDetails_UID.jsp?unique_id=<%= bd.u_id%>')">
								</td>															
							</tr>					
							<%	
						}
					}//close for loop of comp_docs array
				}//close if of baby records b/w given dob's			
				else
				{
					%>
					<tr> 
						<td colspan="11">
							<h4 style="color:blue; text-align:center"> No babies between given facility and DOB date</h4> 
						</td>
					</tr>
					<%
				}
				%>				
				</table>				
				</center>
				<%				
					}//close try block
					catch(Exception e)
					{
						System.out.println(e);
					}
				%>	
		<%@include file="tableexport.jsp"%>
	</body>
</html>