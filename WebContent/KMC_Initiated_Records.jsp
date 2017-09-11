<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>   			
  	<script src="facilities.js">	</script>
	<script src="ken_kmc_html.js"></script>			
	<title> KMC Initiated Records </title>
  	<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	border:1px solid #ddd
	}

	.table-responsive2 table {
    	table-layout: fixed;
	}
	.tableheader {
	width: 1360px;
	margin-bottom:0px;
	border:1px solid #999;

	}
	.tablebody {
	height: 400px;
	overflow-y: auto;
	width: 1375px;
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
		<%@include file="Config.jsp" %>
	    <%-- <%@include file="home.jsp" %> --%> 
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>				
		
		<script>
		//set the session storage value
		sessionStorage.setItem('filename', "KMC_Initiated_Records.jsp");
		</script>
		<% 
       		String value = request.getParameter("facility");
       		int cnt=0;
       		if(value == null)
       		{
       			value="1";
       		}
			System.out.println("facility value = "+value);
		
			//logic to set page number to 1 default			
			String pageNo = request.getParameter("page");
			if(pageNo == null)
			{
				pageNo = "1";
			}
			
			//logic to set records per page to 5 default
			int records=5;
			if(request.getParameter("recordsPerPage")!=null)
			{
				records=Integer.parseInt(request.getParameter("recordsPerPage"));
			}
			System.out.println("Record  per page from dropdown list = "+records);
		%>		
		<div class="container" align="center">		 
		 <form action="KMC_Initiated_Records.jsp" method="POST" class="form-inline">
		 <h1 style = "color:brown"> KMC Initiated Records </h1>
		 <div class="form-group">							
			<!-- obtain the value from js file into dropdown list-->	
			<div id="filters"></div>
			<script>
				var filterStr= DropdownFilter(facilityFilter,"<%= value%>");							
				filters.innerHTML=filterStr;
			</script>
		 </div> &nbsp;		
		 <div class="form-group">
			<div id="filters2"></div>
			<script>
				var filterStr= DropdownFilter(recordsFilter,"<%= records%>");				
				filters2.innerHTML=filterStr;
			</script>
		 </div>
		 <br />
			<button type="submit" class="btn btn-primary">Submit</button>				
			<br /> 																					
		 </form>	
		 
		 </div>		
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
				
				//calculate no of records per page and page number
				System.out.println("pagenumber from request = "+pageNo);
				//out.print("<h3>Page No: "+pageNo+"</h3>");				
				int pageNum = Integer.parseInt(pageNo);
				int currentPageNum = Integer.parseInt(pageNo);
				int recordPerPage = records;				
				System.out.println("Record  per page = "+recordPerPage);			
				if(pageNum==1)
				{}  
				else if(request.getParameter("btnPressed").equals("next"))
				{  
					pageNum=pageNum-1;  
				    System.out.println("pagenumber when next pressed= "+pageNum);
				    pageNum=pageNum*recordPerPage+1; 
				    System.out.println("pageid no after calculation in next = "+pageNum);
				}	
				else if(request.getParameter("btnPressed").equals("back"))
				{  
					pageNum=pageNum-1;  
				    System.out.println("pageNumber when back pressed = "+pageNum);
				   	pageNum=pageNum*recordPerPage+1; 
				   	System.out.println("page no after calculation in back = "+pageNum);
				}
				System.out.println("no of Skip records ="+(pageNum-1));
				System.out.println("no of records per page ="+recordPerPage);
				int skipValue = pageNum-1;
				
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
				int facility = value==null?1:Integer.parseInt(value);
				System.out.println("Facility in  jsp page ="+facility);
				ArrayList<DBObject> jsonArray=null;
				if(recordPerPage != 1)
				{
					jsonArray = mongodao.kmcDischargeRecordsByLimit(facility,recordPerPage,skipValue);
				}
				else if(recordPerPage==1)
				{
					jsonArray = mongodao.kmcDischargeRecords(facility);
				}				
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				com.kentropy.kmc.bean.TimeCalculation timeDiff = new com.kentropy.kmc.bean.TimeCalculation();
				String countv=request.getParameter("count");
				String countp=request.getParameter("countp");
				int count;
				if(countv == null)
				{
				  count=0;
				}
				else
				{
					count=Integer.parseInt(countv);
				}
				if(pageNum==1)
				{
					count=0;
				}
				if(pageNum>1)
				{
					count=(Integer.parseInt(pageNo)*Integer.parseInt(request.getParameter("recordsPerPage"))-Integer.parseInt(request.getParameter("recordsPerPage")));
				}
				%>				
				<br>
		 		<div class="container">
				<h4> Page No. = <%= pageNo%> </h4>
				<div class="row">
		     	<div id="KMC_Initiated_Babies" class="exporttable table-responsive2">
                <table class="table table-bordered table-striped tableheader">
                <thead>
                <tr>
						<th style="text-align:center;width:50px"> SI. No. </th>
						<th style="text-align:center;width:100px"> Period </th>
						<th style="text-align:center;width:100px"> Facility </th>
						<th style="text-align:center;width:200px"> Unique_ID </th>
						<th style="text-align:center;width:100px"> DOB </th>
						<th style="text-align:center;width:150px"> Mother_Name </th>
						<th style="text-align:center;width:150px"> Husband_Name </th>
						<th style="text-align:center;width:100px; word-wrap:break-word;">Date Of KMC Initiation </th>
						<th style="text-align:center;width:100px; word-wrap:break-word;"> No of Days of kmc entered </th> 
						<th style="text-align:center;width:100px"> Total Time (mins) </th>
						<th style="text-align:center;width:100px"> Status </th>
						<th style="text-align:center;"> Details </th>	
					</tr>				
					</thead>
                    </table>
                    <div class="tablebody">
                    <table class="table table-bordered table-striped" >
                    <tbody>                     
				<% 	
				Object disStatus = "-";
				Object disStatus2 = "-";
				int hr =0;
				double min = 0;
				int totalHr = 0;
				double totalMin = 0;
				double kmcMinute=0;
				String kmc_init="-";
				BasicDBList kmc_details = null;
				BasicDBObject kmc_timeslot = null;			
				int size=jsonArray.size();
				System.out.println("total babies ="+size);
				int resize=0;			
				if(size==recordPerPage || size<recordPerPage)
				{					
					resize=size;
				}				
				else
				{
					resize=size-1;
				}
				//out.println("json array size="+size);
				//out.println("json array resize="+resize);			
				
				if(size > 0)
				{
					for(int i=0; i<size; i++)
					{
						++cnt;
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
						bd.dob = kmcData.get("dob");
						bd.mother_name = kmcData.get("mother_name");
						bd.husband_name = kmcData.get("husband_name");
						bd.u_id = kmcData.get("unique_id");	
						//comp_docs list
						BasicDBList comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");					
						//System.out.println("comp_obj are:"+comp_obj);
						//System.out.println("comp_obj size is ="+comp_obj.size());						
						
						System.out.println("baby count ="+count);
						//System.out.println("inside else");
						//comp_docs 0th array list
						BasicDBObject comp_obj_0 = (BasicDBObject)comp_obj.get(0);					
						//System.out.println("comp_obj_0 :"+comp_obj_0);
						SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
						SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
     					String init_dt;
						
							if(comp_obj_0.containsField("init_date1"))
							{
								bd.init_date1 = comp_obj_0.get("init_date1");
								init_dt=(String)bd.init_date1;
								Date date = sdfSource.parse(init_dt);
								bd.init_date1 = sdfDestination.format(date);
							}
							else
							{
								bd.init_date1 = "-";					
							}
		
							if(comp_obj_0.containsField("kmc_initiation"))
							{
								if(comp_obj_0.get("kmc_initiation").equals("Discharged without initiation"))
								{
									bd.kmc_initiation = comp_obj_0.get("kmc_initiation");
									//System.out.println("bd.kmc_initiation at 0th array = "+bd.kmc_initiation);
								}
								else
									bd.kmc_initiation = "-";
							}
							else if(comp_obj_0.containsField("discharged"))
							{
								BasicDBList disList = (BasicDBList)comp_obj_0.get("discharged");
								disStatus = disList.get(0);
								//System.out.println("dis status at if of comp_obj_0="+disStatus); 
							}
							else
								bd.kmc_initiation = "-";						
							
							//logic to count no of dates
							int dateCount = 0;
							for(int j=1; j<comp_obj.size(); j++)
							{
								//++dateCount;
								//System.out.println("u_id = "+bd.u_id);
								BasicDBObject comp_obj_1 = (BasicDBObject)comp_obj.get(j);
								//System.out.println("comp_obj_"+j+" is "+comp_obj_1);						
								bd.kmc_date = comp_obj_1.get("date");	
								if(comp_obj_1.containsField("kmc_done"))
								{
									bd.kmc_done = comp_obj_1.get("kmc_done");								
									if(comp_obj_1.get("kmc_done").equals("Yes"))
									{
										++dateCount;
									}
								}							
								//System.out.println("comp_obj_"+j+" date is "+bd.kmc_date);
								//System.out.println("comp_obj_"+j+" kmc_done = "+bd.kmc_done);
								
								if(comp_obj_1.containsField("discharged"))
								{
									BasicDBList disList = (BasicDBList)comp_obj_1.get("discharged");
									disStatus = disList.get(0);
									//System.out.println("disstatus at if of comp_obj_1="+disStatus);
									if(disStatus.equals("discharged"))
									{										
										disStatus2 = disStatus;
										//System.out.println("dis status2 at if of comp_obj_1="+disStatus2);
									}									
								}							
								else
								{
									disStatus = "-";
									//System.out.println("disStatus at else of  comp_obj_1= "+disStatus);
								}						
							
								//logic to count total minutes
								double totmin = 0;							
								if(comp_obj_1.containsField("kmc_time_slots_today")) //check for if kmc_slot array is present
								{	
									kmc_details = (BasicDBList)comp_obj_1.get("kmc_time_slots_today");
									int k=0;
									totalHr = 0;
									totalMin = 0;
									totmin = 0;
									for(k=0; k<kmc_details.size(); k++)
									{	
											hr=0;
											min=0;
											//get kmc_timeslot array elements
											kmc_timeslot = (BasicDBObject)kmc_details.get(k);												
											bd.kmc_from_time = kmc_timeslot.get("from");
											bd.kmc_to_time = kmc_timeslot.get("to");					
											bd.kmc_from_meridian = kmc_timeslot.get("from_meridian");
											bd.kmc_to_meridian = kmc_timeslot.get("to_meridian");
											
											//Time diffrence calculation
											String fromTime = bd.kmc_from_time+" "+bd.kmc_from_meridian;										
											String toTime = bd.kmc_to_time+" "+bd.kmc_to_meridian;
											//String date = (String)bd.kmc_date;	
											//System.out.println("kmc date = "+bd.kmc_date);
											//System.out.println("from time = "+fromTime);
											//System.out.println("to time = "+toTime);
											
											String date = (String)bd.kmc_date;	
											//System.out.println("kmc date = "+bd.kmc_date);
											double diffInTime = timeDiff.timeCalculation(date,fromTime, toTime);
											hr = (int)diffInTime;
										    min = (diffInTime - (int)diffInTime)*60;
										    //System.out.println("Difference b/w = "+hr+"hr "+Math.round(min)+"mins");
										    totalHr = totalHr+hr;
										   	totalMin = totalMin+min;					
											//System.out.println("Total hrs = "+totalHr+"hr "+(int)totalMin+"mins");										
											int hrInMin = (int) Math.round(totalHr*60);
											totmin=hrInMin+totalMin;
											//System.out.println("total mins ="+totmin);
									}//close for loop of kmc slot									
								}//close if of kmc_time_slots								
								kmcMinute = kmcMinute+totmin;
								//System.out.println("total kmc time in min="+kmcMinute);
								//System.out.println("total initiated date ="+dateCount);								
							}//close loop when comp_obj size>0	
							
							if(disStatus.equals("discharged") || disStatus2.equals("discharged"))
							{
								/* System.out.println("Inside if");
								System.out.println("disStatus Inside if="+disStatus);
								System.out.println("disStatus2 Inside if="+disStatus2);
								System.out.println(); */
								%>					
								<tr style="background:#EAEAEA;">
									<td style="width:50px;vertical-align:middle;"> <%= (++count)%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.from_date%> to <%= bd.to_date %> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.facility%> </td>
									<td style="width:200px;vertical-align:middle;"> <%= bd.u_id%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.dob%> </td>
									<td style="width:150px;vertical-align:middle;"> <%= bd.mother_name%> </td>
									<td style="width:150px;vertical-align:middle;"> <%= bd.husband_name%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.init_date1%> </td>					
									<td style="width:100px;vertical-align:middle;"> <%= dateCount%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= kmcMinute%> </td>
									<td style="color:red;width:100px;vertical-align:middle;"> Discharged without Entering Details</td>
									<td style="vertical-align:middle;">
									<button type="button" class="btn btn-info" style="color:black" onClick="window.location.href='KMC_Details.jsp?facility=<%= bd.facility%>&unique_id=<%= bd.u_id%>'">View </button></td>															
								</tr>					
							<%		
							}							
							else if(bd.kmc_initiation.equals("Discharged without initiation"))
							{
								/* System.out.println("Inside else if2");
								System.out.println("disStatus Inside else if2 ="+disStatus); */								
								%>					
								<tr style="background:#C0C0C0;">
									<td style="width:50px;vertical-align:middle;"> <%= (++count)%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.from_date%> to <%= bd.to_date %> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.facility%> </td>
									<td style="width:200px;vertical-align:middle;"> <%= bd.u_id%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.dob%> </td>
									<td style="width:150px;vertical-align:middle;"> <%= bd.mother_name%> </td>
									<td style="width:150px;vertical-align:middle;"> <%= bd.husband_name%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.init_date1%> </td>					
									<td style="width:100px;vertical-align:middle;"> <%= dateCount%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= kmcMinute%> </td>
									<td style="color:red;width:100px;vertical-align:middle;"> Discharged without Entering Details</td>
									<td style="vertical-align:middle;">
									<button type="button" class="btn btn-info" style="color:black" onClick="window.location.href='KMC_Details.jsp?facility=<%= bd.facility%>&unique_id=<%= bd.u_id%>'">View </button></td>															
								</tr>					
							<%		
							}						
							else
							{
								/* System.out.println("Inside else");
								System.out.println("disStatus Inside else="+disStatus); */								
								%>					
								<tr style="background:#D3D3D3;">
									<td style="width:50px;vertical-align:middle;"> <%= (++count)%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.from_date%> to <%= bd.to_date %> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.facility%> </td>
									<td style="width:200px;vertical-align:middle;"> <%= bd.u_id%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.dob%> </td>
									<td style="width:150px;vertical-align:middle;"> <%= bd.mother_name%> </td>
									<td style="width:150px;vertical-align:middle;"> <%= bd.husband_name%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= bd.init_date1%> </td>					
									<td style="width:100px;vertical-align:middle;"> <%= dateCount%> </td>
									<td style="width:100px;vertical-align:middle;"> <%= kmcMinute%> </td>
									<td style="color:red;width:100px;vertical-align:middle;" > Not Discharged </td>
									<td style="vertical-align:middle;">
									<button type="button" class="btn btn-info" style="color:black" onClick="window.location.href='KMC_Details.jsp?facility=<%= bd.facility%>&unique_id=<%= bd.u_id%>'"> View </button></td>															
								</tr>					
								<%	
							}
							kmcMinute=0;
							disStatus="-";
							disStatus2="-";							
							//System.out.println("disStatus2 before other baby loop = "+disStatus2);								
							//System.out.println();
						}//close for loop of array
				}
				else
				{
					%>
					<tr> <td colspan=12> <h4 style="color:red; text-align:left;">No records</h4> </td></tr>
					<%
				}
				if(size>0)					
				{
					%>
					<tr> <td colspan=12> <h4 style="color:red; text-align:left;">---End of Records---</h4> </td></tr>
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
				//out.println("currentPageNum="+currentPageNum+"size="+size+"cnt="+cnt+"recordPerPage="+recordPerPage);
				//System.out.println("records per page after table= "+recordPerPage);
				if(recordPerPage != 1 || size<recordPerPage)
				{
					if(currentPageNum > 1 && size==recordPerPage)
					{					
						%>
						<center>
						<div class="container">	
							<ul class="pager">			
								<li ><a href="KMC_Initiated_Records.jsp?facility=<%= value%>&btnPressed=back&page=<%=currentPageNum-1%>&recordsPerPage=<%= recordPerPage%>&countp=<%= count%>" style="background-color:skyblue; color:black"> Previous </a> </li>			
								
								<li><a href="KMC_Initiated_Records.jsp?facility=<%= value%>&btnPressed=next&page=<%=currentPageNum+1%>&recordsPerPage=<%= recordPerPage%>&count=<%= count%>" style="background-color:skyblue; color:black"> NEXT </a> </li>
							</ul>
						</div>
						</center>
						<%
					}	
					else if(currentPageNum >= 1 && (size>cnt || size==cnt) && size>=recordPerPage)
					{					
						%>
						<center>
						<div class="container">	
							<ul class="pager">						
								<li><a href="KMC_Initiated_Records.jsp?facility=<%= value%>&btnPressed=next&page=<%=currentPageNum+1%>&recordsPerPage=<%= recordPerPage%>&count=<%= count%>" style="background-color:skyblue; color:black"> NEXT </a> </li>
							</ul>
						</div>
						</center>
						<%
					}	
					else if(currentPageNum > 1 && size==cnt)
					{
						%>
						<center>
						<div class="container" >	
							<ul class="pager">						
								<li ><a href="KMC_Initiated_Records.jsp?facility=<%= value%>&btnPressed=back&page=<%=currentPageNum-1%>&recordsPerPage=<%= recordPerPage%>&countp=<%= count%>" style="background-color:skyblue; color:black"> Previous </a> </li>
							</ul>
						</div>
						</center>
						<%
					}
				}
			}//close try block
			catch(Exception e)
			{
				System.out.println(e);
			}
		%>	
		<%@include file="tableexport.jsp" %>
</body>
</html>