<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">			
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title> KMC Track </title>
		<script src="facilities.js">	</script>
		<script src="koppal_villages.js">	</script>
		<script src="communityWorkers.js">	</script>
		<script src="ken_kmc_html.js"></script>
		<link rel="stylesheet" href="Responsive_Style.css">				
  		
		<style>				
		/* Max width before this PARTICULAR table gets nasty
		This query will take effect for any screen smaller than 760px
		and also iPads specifically.*/
		@media 
		only screen and (max-width: 760px),(min-device-width: 768px) and (max-device-width: 1024px)  {
		
			/* Force table to not be like tables anymore */
			table, thead, tbody, th, td, tr { 
				display: block; 
			}
			
			/* Hide table headers (but not display: none;, for accessibility) */
			.myTable thead tr { 
				position: absolute;
				top: -9999px;
				left: -9999px;
			}			
			.popTable1.popTable2 thead tr { 
				position: absolute;
				top: -9999px;
				left: -9999px;
			}
			
			.myTable tr { border: 1px solid #ccc; }
			.popTable1.popTable2 tr { border: 1px solid #ccc; }
			
			.myTable td { 
				/* Behave  like a "row" */
				border: none;
				border-bottom: 1px solid #eee; 
				position: relative;
				padding-left: 50%; 
			}
			.popTable1.popTable2 td { 
				/* Behave  like a "row" */
				border: none;
				border-bottom: 1px solid #eee; 
				position: relative;
				padding-left: 50%; 
			}
			
			.myTable td:before { 
				/* Now like a table header */
				position: absolute;
				/* Top/left values mimic padding */
				top: 6px;
				left: 6px;
				width: 45%; 
				padding-right: 10px; 
				white-space: nowrap;
			}
			.popTable1.popTable2 td:before { 
				/* Now like a table header */
				position: absolute;
				/* Top/left values mimic padding */
				top: 6px;
				left: 6px;
				width: 45%; 
				padding-right: 10px; 
				white-space: nowrap;
			}			
			
			/*
			Label the data
			*/
			.myTable td:nth-of-type(1):before { content: "SI.No."; }
			.myTable td:nth-of-type(2):before { content: "Facility"; }
			.myTable td:nth-of-type(3):before { content: "DOB"; }
			.myTable td:nth-of-type(4):before { content: "Uniqua_ID"; }
			.myTable td:nth-of-type(5):before { content: "Mother"; }
			.myTable td:nth-of-type(6):before { content: "Father"; }
			.myTable td:nth-of-type(7):before { content: "Community From"; }
			.myTable td:nth-of-type(8):before { content: "Community To"; }
			.myTable td:nth-of-type(9):before { content: "Type"; }	
			
			.popTable1 td:nth-of-type(1):before { content: "Mother Name"; }
			.popTable1 td:nth-of-type(2):before { content: "Phone1"; }
			.popTable1 td:nth-of-type(3):before { content: "Phone2"; }	
			
			.popTable2 td:nth-of-type(1):before { content: "Name"; }
			.popTable2 td:nth-of-type(2):before { content: "Phone"; }
			.popTable2 td:nth-of-type(3):before { content: "Role"; }		
		}
		
		/* Smartphones (portrait and landscape) ----------- */
		@media only screen
		and (min-device-width : 320px)
		and (max-device-width : 480px) {
			body { 
				padding: 0; 
				margin: 0; 
				width: 320px; }
			}
		
		/* iPads (portrait and landscape) ----------- */
		@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {
			body { 
				width: 495px; 
			}
		}		
  		</style>
  		<script>
  		function failStatus()
		{
  			//document.getElementById("#myModa2").style.display="block";
  			$(document).ready(function(){
  			    $("a").click(function(){
  			    	$('#fail').modal('show');
  			    });
  			});	
		}
  		</script>
  		<script>
  		function test(){
  			
  			
  		}
  		</script>
  		
	</head>
	<body >
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
		<script>
		/*script for printing table for community details*/
		function format1(cws1,babyuid,startdate,kPeriod)
		{		
			var count=0;
			if(cws1==null)
				return "";				
				var str="<h5 style=\"color:brown\">Community Details</h5>";
					str+="<h5>Note: Scroll up and down </h5>";
					str+="<center>";
					str+="<div class=\"page-wrap\"><table class=\"popTable2\">";
					str+="<thead><tr style=\"text-align:center

\"><th>Name</th><th>Phone</th><th>Role</th></tr></thead>";
					str+="<tbody>";
				for(var i=0; i < cws1.length;i++)
				{
					//str+="<tr><td>"+cws1[i].text+"</td><td><a href='tel:"+cws1[i].phone

+"'>"+cws1[i].phone+"</td><td>"+cws1[i].type+"</td></tr>";
					var cnt=++count;
					str+="<tr><td>"+cws1[i].text+"</td><td>";					
					str+="<a href='callto:+cws1[i].phone+' class='btn btn-default' data-

toggle='modal' >"+cws1[i].phone+"</a></td>";
					str+="<td>"+cws1[i].type+"</td></tr>";
				}				
				str+="</tbody></table></div>";			
				str+="</center>";								
				return str;
		}
		
		function motherContact(babyuid,startdate,kPeriod,mothername, ph1, ph2)
		{
			var str="<h5 style=\"color:brown\">Mother Details</h5>";
			str+="<center>";
			str+="<div class=\"page-wrap\"><table class=\"popTable1\">";
			/* str+="<table>"; */
			str+="<thead  style=\"height:10%\"><tr style=\"text-align:center\"> <th>Mother Name</th><th>Phone1</th><th>Phone2</th></tr></thead>";
			str+="<tbody>";
			str+="<tr> <td>"+mothername+"</td>";
			str+="<td><a href='callto:+ph1+' class='btn btn-default' data-toggle='modal'> "+ph1+"</a></td>";
			str+="<td><a href='callto:'+ph2+' class='btn btn-default' data-toggle='modal'>"+ph2+"</a></td>";
			str+="</tr>";
			str+="</tbody></table></div>";
			str+="</center>";
			return str;
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
		<form action="TableBS_kmc.jsp" method="POST" style = "text-align:center; margin-top:50px">
			<h1 style = "color:brown"> KMC tracking </h1>				
			<!-- obtain the value from js file into dropdown list-->	
			<div id="filters"></div>
			<script>
				var filterStr= DropdownFilter(facilityFilter,"<%= value%>");
				filterStr+=DropdownFilter(kmcPeriodFilter,"<%=kmcPeriod%>");				
				filters.innerHTML=filterStr;
			</script>
			<input type="submit" value="Submit" name="submit" style="color:blue; width:10%">		

		
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
				
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, 

coll);
				int facility = value==null?1:Integer.parseInt(value);
				//System.out.println("kmcPeriod in kmc_tracking = "+kmcPeriod);
				//System.out.println("facility in kmc_tracking = "+value);
				ArrayList<DBObject> jsonArray = mongodao.getBabiesForPeriod(facility,kmcPeriod);
				//out.println(jsonArray.size()+" "+kmcPeriod+" "+facility);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int count=0;
				%>
				<center>
				<div class="container">				
				<div id="page-wrap">									

				
    				<table class="myTable">									

		
	    				<thead>
	     					<tr>
								<th>SI.No </th>
								<th> Facility </th>	
								<th> DOB </th>
								<th> Unique_ID </th>
								<th> Mother </th>
								<th> Father </th>					

								
								<th>Community From </th>
								<th>Community To </th>					
								<th>Type </th>						

									
							</tr>
	    				</thead>	    				
	   					<tbody>
	   					<% 				
							for(int i=0; i<jsonArray.size(); i++)
							{
								//System.out.println("DBObjects are ="+jsonArray.get(i));
								ObjectId objid = (ObjectId)jsonArray.get(i).get("_id");
								//System.out.println("Objet id are ="+objid);		
								
								//convert ObjectID into date format
								Date enterDate = objid.getDate();
								SimpleDateFormat sdf1 = new 

java.text.SimpleDateFormat("dd/MM/yyyy hh:ss:mm a");
								java.util.TimeZone tz = 

java.util.TimeZone.getTimeZone("IST");
								sdf1.setTimeZone(tz);
								String formatDate = sdf1.format(enterDate);
								//System.out.println("Formatted object entered date = " +formatDate);
								
								//today date calculation
								SimpleDateFormat sdf= new SimpleDateFormat

("dd/MM/yyyy");
								String  start_date = sdf.format(new Date());
								Calendar ca = Calendar.getInstance();
								ca.setTime(sdf.parse(start_date));
								ca.add(Calendar.DATE,0);  
								start_date = sdf.format(ca.getTime());
								//System.out.println("yesterday date = "+start_date);
					
								BasicDBObject facilityData = (BasicDBObject)

jsonArray.get(i).get("facility");
								bd.facility = facilityData.getInt("facility");
								//System.out.println("Faility are ="+bd.facility);
								
								BasicDBObject kmcData = (BasicDBObject)

jsonArray.get(i).get("data");
								bd.dob = kmcData.get("dob1");
								bd.u_id = kmcData.get("unique_id");
								bd.mother_name = kmcData.get("mother_name");
								bd.husband_name = kmcData.get("husband_name");
								ArrayList<DBObject> kmcDocs = 

(ArrayList<DBObject>)kmcData.get("comp_docs");
								//System.out.println("dob are ="+bd.dob);
								System.out.println();
								Object commFrom = kmcData.get

("community_from")+"";						
								Object commTo = kmcData.get("community_to")+"";
								%>					
								<tr>
									<td> <%= (++count)%> </td>
									<td> <%= bd.facility%> </td>
									<td> <%= bd.dob%> </td>
									<td> <%= bd.u_id%> </td>
									<td> <%= bd.mother_name%> </td>
									<td> <%= bd.husband_name%> </td>		

		
									<td>
										<div id="commfrom_<%=count

%>"></div>
										<button data-toggle="modal" data-

target="#myBtn1_<%=count%>">Contacts</button>
										<div class="modal fade" 

id="myBtn1_<%=count%>" role="dialog">
									    <div class="modal-dialog modal-lg">
									      <div class="modal-content">
									        <div class="modal-header">
									          <button type="button" 

class="close" data-dismiss="modal">&times;</button>
									          <h4 class="modal-title"> Contact 

Details </h4>
									        </div>
									        <div class="modal-body">		

							          
									    		<p id="myPop1_<%=count%>"> 

 </p>
									        </div>
									        <div class="modal-footer"></div>
									        <h4>Please select call status</h4>
									         <a  class="btn btn-success btn-

sm" onclick="window.open('kmc-cc.jsp?name=<%= bd.mother_name%>&kmcPeriod=<%=kmcPeriod%>&start_date=<%= start_date

%>&baby=<%=kmcData.get("unique_id")%>')">success</a>
									          <!-- <a   class="btn btn-danger 

btn-sm" data-toggle="modal" data-target="fail1" >failed</a> -->
									           <button type="button" 

class="btn btn-danger" data-toggle="modal" data-target="#fail" onclick="<%test(bd.mother_name,kmcData.get

("unique_id"),request,response);%>">Failed</button>
									      </div>
									    </div>
									  </div>
									  <%
											if(!commFrom.equals

("other"))
											{
												%>
												<script>		

										
													

commfrom_<%=count%>.innerHTML=getCommunity(<%=commFrom%>)+"<br><%=commFrom%>";						

							
													myPop1_<

%=count%>.innerHTML=getCommunity(<%=commFrom%>)+"<br><%=commFrom%>"+"<br>"+motherContact("<%=kmcData.get

("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%= bd.mother_name%>","<%=kmcData.get("phone1")%>","<

%=kmcData.get("phone2")%>")+"<br>"+format1(getCWByComm(<%=commFrom%>),"<%=kmcData.get("unique_id")%>","<%= 

start_date%>","<%=kmcPeriod%>");
												</script>
												<%
											}
										%>					

															
									</td>						

			
									<td>
										<div id="commto_<%=count%>"></div>
										<button data-toggle="modal" data-

target="#myBtn2_<%=count%>">Contacts</button>
										<div class="modal fade" 

id="myBtn2_<%=count%>" role="dialog">
									    <div class="modal-dialog modal-lg">
									      <div class="modal-content">
									        <div class="modal-header">
									          <button type="button" 

class="close" data-dismiss="modal">&times;</button>
									          <h4 class="modal-title"> Contact 

Details </h4>
									        </div>
									        <div class="modal-body">		

							          
									    		<p id="myPop2_<%=count%>"> 

 </p>
									        </div>
									        <div class="modal-footer"></div>
									        <h4>Please select call status</h4>
									         <a  class="btn btn-success btn-

sm" onclick="window.open('kmc-cc.jsp?name=<%= bd.mother_name%>&kmcPeriod=<%=kmcPeriod%>&start_date=<%= start_date

%>&baby=<%=kmcData.get("unique_id")%>')">success</a>
									         <%-- ?id="<%=kmcData.get

("unique_id")%>"&stDate="<%= start_date%>"&period="<%=kmcPeriod%>"&name="<%= bd.mother_name%>"&ph1="<

%=kmcData.get("phone1")%>"&ph2="<%=kmcData.get("phone2")%> --%>
									          <!-- <a   class="btn btn-danger 

btn-sm"  data-toggle="modal" data-target="fail1" >failed</a> -->
									           <button type="button" 

class="btn btn-danger" data-toggle="modal" data-target="#fail" onclick="<%test(bd.mother_name,kmcData.get

("unique_id"),request,response);%>">Failed</button>
									          <%-- "window.open('kmc-

cc88.jsp?name="<%= bd.mother_name%>"&period="<%=kmcPeriod%>"&stDate="<%= start_date%>"&ph1="<%=kmcData.get

("phone1")%>"&ph2="<%=kmcData.get("phone2")%>"' --%>
									      </div>
									    </div>
									  </div>
										<%
											if(!commTo.equals

("other"))
											{
												%>
												<script>		

											
													commto_<

%=count%>.innerHTML=getCommunity(<%=commTo%>)+"<br><%=commTo%>";							

						
													myPop2_<

%=count%>.innerHTML=getCommunity(<%=commTo%>)+"<br><%=commTo%>"+"<br>"+motherContact("<%=kmcData.get

("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%= bd.mother_name%>","<%=kmcData.get("phone1")%>","<

%=kmcData.get("phone2")%>")+"<br>"+format1(getCWByComm(<%=commTo%>),"<%=kmcData.get("unique_id")%>","<%= 

start_date%>","<%=kmcPeriod%>");
												</script>
												<%
											}
										%>
									</td>
									<td><%=kmcData.get("surveyType")%></td>		

														
								</tr>
								
			  				
							<%		
							}				
							%>
							</tbody>
			  				</table>
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
					
					<div class="modal fade" role="dialog" id="fail" >
									    <div class="modal-dialog modal-lg">
									      <div class="modal-content">
									        <div class="modal-header">
									          <button type="button" 

class="close" data-dismiss="modal">&times;</button>
									          <h1 class="modal-title">Enter 

Call Failure Comments</h1>
									        </div>
									        <div class="modal-body">	
									          <div>
									         
									          <center>
												<textarea rows="4" 

cols="50"  name="comment"  id="rem" required=""></textarea><br><br>
								  				<!-- <button 

id="btn" onclick="rem()">submit</button> -->
											
											<button type="submit" 

class="btn btn-info" id="btn2" onclick="remarks1()">submit</button>   <%-- <%=kmcData.get("unique_id")%>','<%= 

bd.mother_name%>','<%=kmcData.get("phone1")%>','<%=kmcData.get("phone2")%> --%>
											</center>
											
											</div>
									        </div>
									    </div>
									  </div>
			  				</div>
		
			
			  				<script>
			  				   function remarks1(name,id)
			  				   {
			  						alert("name="+name+"--id"+id);
			  						
			  						 <%String rem = "abc";%>
			  						
			  						<%int res = new com.kentropy.mongodb.DeleteMongodbObject().insertRemarks( db, CC_CallDetails, session.getAttribute("name").toString(), session.getAttribute("id").toString(), rem); %>
			  						<%
			  					  	  session.removeAttribute("name");
			  					  	  session.removeAttribute("id");
			  						 %>
			  			    	}
			  				 </script>
			  				<!-- method to set session variables to access by the 2nd 

model box -->
			  				<%! public void test(Object name, Object 

id,HttpServletRequest request, HttpServletResponse response)
			  				{
			  					HttpSession session=request.getSession();
			  							
			  					session.setAttribute("name", name); 
			  					session.setAttribute("id", id);
			  					
			  				}
			  				%>
			  				<script>
			  				function test2(){
			  					session.setAttribute("name", name); 
			  					session.setAttribute("id", id);
			  				}
			  				</script>
	</body>
</html>