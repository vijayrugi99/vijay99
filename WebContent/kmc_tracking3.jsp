<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> KMC Track </title>
		<script src="facilities.js">	</script>
		<script src="koppal_villages.js">	</script>
		<script src="communityWorkers.js">	</script>
		<script src="ken_kmc_html.js"></script>
		<!--<link rel="stylesheet" type="text/css" href="Reports_Stylesheet.css"> -->
		<link rel="stylesheet" type="text/css" href="Popup_Scroll.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
  		
		<style>
		/* style for table scoll  */
			.scroll {
		    width: 1556px; <!-- /* 140px * 11 column + 16px scrollbar width */ -->
		    border-spacing: 0;
		    border: 2px solid black;
			}
		
			.scroll tbody,
			.scroll thead tr { display: block; }
		
			.scroll tbody {
				height: 100px;
				overflow-y: auto;
				overflow-x: hidden;
			}
			
			.scroll tbody td,
			.scroll thead th {
				width: 140px; 
				border-right: 1px solid black;
			}
		
			.scroll thead th:last-child {
				width: 156px; <!-- /* 140px + 16px scrollbar width */ -->
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
		<%@page import = "com.mongodb.util.JSON"%>
		<script>
		//var count=0;
		function format1(cws1,babyuid,startdate,kPeriod,p2cnt)
		{		
			var count=0;
			if(cws1==null)
				return "";				
				var str="<center><table><tr style=\"text-align:center\"><th>Name</th><th>Phone</th><th>Role</th>";
				for(var i=0; i < cws1.length;i++)
				{
					//str+="<tr><td>"+cws1[i].text+"</td><td><a href='tel:"+cws1[i].phone+"'>"+cws1[i].phone+"</td><td>"+cws1[i].type+"</td></tr>";
					var cnt=++count;
					str+="<tr><td>"+cws1[i].text+"</td><td>";					
					/* str+="<a href='#' id=\"ph_"+cnt+"\" >"+cws1[i].phone+"</td>"; */
					/* str+="<a href='tel:"+cws1[i].phone+"' onclick=\"makeCall(\'"+p2cnt+"\',\'"+babyuid+"\',\'"+startdate+"\',\'"+kPeriod+"\'); call(\'"+p2cnt+"\',\'"+cws1[i].phone+"\');\">"+cws1[i].phone+"</td>"; */
					/* str+="<a href='#' onclick=\"window.open('kmc-cc.jsp?baby="+babyuid+"&start_date="+startdate+"&kmcPeriod="+kPeriod+"')\">"+cws1[i].phone+"</td>"; */
					/* str+="<a href='#' onclick=\"makeCall(\'"+cws1[i].phone+"\'), enterForm(\'"+babyuid+"\',\'"+startdate+"\',\'"+kPeriod+"\')\">"+cws1[i].phone+"</td>"; */
					/* str+="<a href='#' id=\"click\" onclick=\"clkFunc(\'"+cws1[i].phone+"\',\'"+babyuid+"\',\'"+startdate+"\',\'"+kPeriod+"\')\">"+cws1[i].phone+"</td>";  */
					/* str+="<a href='#' id=\"clk\"\">"+cws1[i].phone+"</td>"; */
					/* str+="<a href='#' id=\"click\" onclick=\"window.open('tel:"+cws1[i].phone+"','_blank','width=700,height=700'); window.open('kmc-cc.jsp?baby="+babyuid+"&start_date="+startdate+"&kmcPeriod="+kPeriod+"','_blank','width=700,height=700');\">"+cws1[i].phone+"</td>"; */ 
					/* str+="<a href='#' class='clk'\">"+cws1[i].phone+"</a></td>"; */
					/* str+="<a href='#' onclick='window.open('www.yahoo.com','','width=700,height=500');'return true;\">"+cws1[i].phone+"</a></td>"; */
					str+="<a href='tel:"+cws1[i].phone+"' onClick=\"func(\'"+cws1[i].phone+"\',\'"+babyuid+"\',\'"+startdate+"\',\'"+kPeriod+"\')\">"+cws1[i].phone+"</a></td>";
					str+="<td>"+cws1[i].type+"</td></tr>";
				}				
				str+="</table>";
				str+="</center>";
				str+="<br /><br />";
				//str+="<button onclick=\"window.open('kmc-cc.jsp?baby="+baby_uid+"&start_date="+start_date+"&kmcPeriod="+kmcPeriod+"')\"> Make A Call </button>";
				return str;
		}
		</script>	
		<script>
			function func(ph,babyuid,startdate,kPeriod)
			{
				/* window.open("tel:"+ph+"",'','width=700,height=700');  */
				window.open("kmc-cc.jsp?baby="+babyuid+"&start_date="+startdate+"&kmcPeriod="+kPeriod+"",'','width=700,height=700');
			}
		</script>
		
		<% String value = request.getParameter("facility");
			int kmcPeriod=0;
			if(request.getParameter("kmcPeriod")!=null)
			{				
				kmcPeriod=Integer.parseInt(request.getParameter("kmcPeriod"));
			}
			else
			{
				kmcPeriod=2;
			}
		 %>
		<form action="kmc_tracking3.jsp" method="POST" style = "text-align:center; margin-top:50px">
			<h1 style = "color:brown"> KMC tracking </h1>				
			<!-- obtain the value from js file into dropdown list-->	
			<div id="filters"></div>
			<script>
				var filterStr= DropdownFilter(facilityFilter,"<%= value%>");
				filterStr+=DropdownFilter(kmcPeriodFilter,"<%=kmcPeriod%>");				
				filters.innerHTML=filterStr;
			</script>
			<input type="submit" value="Submit" name="submit" style="color:blue; width:5%">				
			<br /> 
			<h3>Note: Scroll up and down </h3>																				
		</form>			
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
				//System.out.println("kmcPeriod in kmc_tracking = "+kmcPeriod);
				//System.out.println("facility in kmc_tracking = "+value);
				ArrayList<DBObject> jsonArray = mongodao.getBabiesForPeriod(facility,kmcPeriod);
				out.println(jsonArray.size()+" "+kmcPeriod+" "+facility);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int count=0;
				%>
				<center>
				<div class="container">
				<div class="row">
					<div class="table-responsive">
						<table class="table scroll">						
	    				<thead>
	     					<tr>
								<th>SI.No </th>
								<th> DOB </th>
								<th> Mother </th>
								<th> Father </th>
								<th>Phones </th>					
								<th>Community From </th>
								<th>Community To </th>
								<th> Date </th>
								<th> Facility </th>			
								<th>Type </th>
								<th>Details </th>							
							</tr>
	    				</thead>
	   					<tbody style="height:500px">
	   					<% 				
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
								bd.mother_name = kmcData.get("mother_name");
								bd.husband_name = kmcData.get("husband_name");
								ArrayList<DBObject> kmcDocs = (ArrayList<DBObject>)kmcData.get("comp_docs");
								//System.out.println("dob are ="+bd.dob);
								System.out.println();
								Object commFrom = kmcData.get("community_from")+"";						
								Object commTo = kmcData.get("community_to")+"";
								%>					
								<tr>
									<td> <%= (++count)%> </td>
									<td> <%= bd.dob%> </td>
									<td> <%= bd.mother_name%> </td>
									<td> <%= bd.husband_name%> </td>									
									<td><%=kmcData.get("phone1")%> <br>									
									<%= kmcData.get("phone2")%></td>
									<td>
										<div id="commfrom_<%=count%>"></div>
										<button id="myBtn1_<%=count%>">Contacts</button>
										<div id="contactsfrom_<%=count%>" class="modal">
											<!-- Modal content -->											
										  <div class="modal-content">	
										  	<h3 style="color:brown"> Community details </h3>								  	
										    <span id="close1_<%=count%>" class="close">&times;</span>										
										    <p id="myPop1_<%=count%>"></p>	
										    <!-- <p id="phbtn1"></p> -->
										    <p id="phbtn1_<%=count%>"></p>
										    <p id="phbtn2_<%=count%>"></p>								    
										  </div>										
										</div>
										<%
											if(!commFrom.equals("other"))
											{
												%>
												<script>													
													// Get the button that opens the modal
													var btn = document.getElementById("myBtn1_<%=count%>");													
													// Get the <span> element that closes the modal
													var span = document.getElementById("close1_<%=count%>");
	
													// When the user clicks the button, open the modal 
													btn.onclick = function() 
													{
														// Get the modal
														var modal = document.getElementById("contactsfrom_<%=count%>");
													    modal.style.display = "block";													    
													}
	
													// When the user clicks on <span> (x), close the modal
													span.onclick = function() {
														var modal = document.getElementById("contactsfrom_<%=count%>");
													    modal.style.display = "none";
													}
	
													// When the user clicks anywhere outside of the modal, close it
													window.onclick = function(event) 
													{
														var modal = document.getElementById("contactsfrom_<%=count%>");
													    if (event.target == modal) 
													    {
													    	<%-- var modal = document.getElementById("contactsfrom_<%=count%>"); --%>
													        modal.style.display = "none";
													    }
													}
													commfrom_<%=count%>.innerHTML=getCommunity(<%=commFrom%>)+"<br><%=commFrom%>";													
													myPop1_<%=count%>.innerHTML=getCommunity(<%=commFrom%>)+"<br><%=commFrom%>"+"<br><h5>Note: Scroll up and down </h5>"+format1(getCWByComm(<%=commFrom%>),"<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%=count%>");
												</script>
												<%
											}
										%>										
									</td>									
									<td>
										<div id="commto_<%=count%>"></div>
										<button id="myBtn2_<%=count%>">Contacts</button>
										<div id="contactsto_<%=count%>" class="modal">
											<!-- Modal content -->											
										  <div class="modal-content">	
										  	<h3 style="color:brown"> Community details </h3>								  	
										    <span id="close2_<%=count%>" class="close">&times;</span>										
										    <p id="myPop2_<%=count%>"></p>
										    <p id="phbtn3_<%=count%>"></p>										   
										  </div>										
										</div>
										<%
											if(!commTo.equals("other"))
											{
												%>
												<script>
													// Get the button that opens the modal
													var btn = document.getElementById("myBtn2_<%=count%>");
	
													// Get the <span> element that closes the modal
													var span = document.getElementById("close2_<%=count%>");
	
													// When the user clicks the button, open the modal 
													btn.onclick = function() 
													{
														// Get the modal
														var modal = document.getElementById("contactsto_<%=count%>");
													    modal.style.display = "block";													    
													}
	
													// When the user clicks on <span> (x), close the modal
													span.onclick = function() {
														var modal = document.getElementById("contactsto_<%=count%>");
													    modal.style.display = "none";
													}
	
													// When the user clicks anywhere outside of the modal, close it
													window.onclick = function(event) 
													{
														var modal = document.getElementById("contactsto_<%=count%>");
													    if (event.target == modal) 
													    {
													    	<%-- var modal = document.getElementById("contactsto_<%=count%>"); --%>
													        modal.style.display = "none";
													    }
													}
													commto_<%=count%>.innerHTML=getCommunity(<%=commTo%>)+"<br><%=commTo%>";													
													myPop2_<%=count%>.innerHTML=getCommunity(<%=commTo%>)+"<br><%=commTo%>"+"<br>"+format1(getCWByComm(<%=commTo%>),"<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%=count%>");
												</script>
												<%
											}
										%>
									</td>						
									<td> <%= formatDate%> </td>
									<td> <%= bd.facility%> </td>
									<td><%=kmcData.get("surveyType")%></td>					
									<td>
										<input type="button" id="kmc" name = "kmc" value = "Enter KMC" style="color:blue" onClick="window.open('kmc-cc.jsp?baby=<%=kmcData.get("unique_id")%>&start_date=<%= start_date%>&kmcPeriod=<%=kmcPeriod%>')">
									</td>						
								</tr>
							<%		
							}				
							%>
							</tbody>
			  				</table>
			  				</div>
							</div>
							</div>
							</center>
							<%
						}//close try block			
						catch(Exception  e)
						{
							out.println("Exception::"+e);
							
							e.printStackTrace(response.getWriter());
						}			
					%> 
	</body>
</html>