<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta http-equiv=Pragma content=no-cache>
		<meta http-equiv=Expires content=-1?>
		<meta http-equiv=CACHE-CONTROL content=NO-CACHE>

		<title> Babies Details </title>	  				
  		<script src="facilities.js">	</script>
  		<script src="taluks.js">	</script>
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
			border:1px solid #ddd;
			/* position:relative; */			
			}
			
			.table-responsive2 table {
			    table-layout: fixed;
			}
			.tableheader {
				width: 3660px;
				margin-bottom:0px;
				border:1px solid #999;			
			}
			.tablebody {
				height: 450px;
				overflow-y: auto;
				width: 3678px;
				margin-bottom:20px;				
			}
		</style>
		
		<!-- Get facilities based on taluk selected-->
		<script>
	   	function displayFacility(index)
	   	{
	   		var fac=facilities;
	   		var facArray = [];
	   		var selected = "";
	   		var len1=0;
	   		var facvalue = '<%= request.getParameter("facility")%>';
	   		//console.log(facvalue);
	   		var facint = parseInt(facvalue);
	   		console.log(facint);
	   		var st="<label style=\"font-size:20px; color:blue\"> Facility:</label>";
	   		st+="<select name=\"facility\" id=\"facility\" class=\"form-control\" style=\"padding:3px;\">";
	   		st+="<option value=\"1\">All</option>";
	   		selected = "";
	   		if(index=="0")
	   		{   			
	   			//alert("Inside index 0")
	   			for(i=0;i<fac.length;i++)
	   			{   		
	   				var value=fac[i].value;
	         		var text=fac[i].text;  
	         		if(facvalue !=null && facint==fac[i].value)
	      		 	{
	      		 		selected="selected";
	      		 	}
	      		 	else
	      		 		selected="";
	         		st+="<option "+selected+" value="+fac[i].value+">"+fac[i].text+"</option>";
	         		facArray.push(fac[i].value);
	         		//alert(index)
	   			}   			
	   			st+="</select>";   			
	  		 	sf.innerHTML=st;  		
	   		}
	   		else
	   		{   		
		   	 	for(i=0;i<fac.length;i++)
			   	{
		   		 	if(fac[i].taluk==index)
		   			 {
		   			  	var taluk=fac[i].taluk;
		   		      	var value=fac[i].value;
		      		 	var text=fac[i].text;
		      		 	if(facvalue !=null && facint==fac[i].value)
		      		 	{
		      		 		selected="selected";
		      		 	}
		      		 	else
		      		 		selected="";
		      		 	st+="<option "+selected+" value="+fac[i].value+">"+fac[i].text+"</option>";
		      		 	len1++;	
		      		 	facArray.push(fac[i].value);
		   			 } 	   		 	
			   	}
	   	 		//alert(len1)
	   	      	st+="</select>";
			  	sf.innerHTML=st;
			}
	   		//console.log(facArray);   		
	   		document.getElementById("hiddenField").value=facArray;
	   		var hiddenvalue=document.getElementById("hiddenField").value;
	   		console.log(hiddenvalue);
	   	} 
   	</script>			
	</head>	
	
	<body >
		<%@ page import="java.sql.*" %>
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
		<%-- <%@ include file="home.jsp" %> --%>
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>					
      	
		<% 
			//jsp logic to set the values for the field as same as input give to form on submit (instead of default value on submit)
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");			
			String value = request.getParameter("facility"); //get value from form
			System.out.println("facility = "+value);
			
			String survey = request.getParameter("survey");	//get value from form			
			System.out.println("Survet type:"+survey);
  			
			String tq = request.getParameter("taluk");
			if(tq==null)
			{
				tq="0";
			}						
			System.out.println("taluk="+tq);
			
			//logic to increment one day from today's date
			Date dt = new Date();
			//current date - one month 
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			Date result = cal.getTime();
			System.out.println("Before one month date ="+result);
						
			String datefrom = request.getParameter("datefrom"); //get value from form
			if(datefrom == null)
			{
				datefrom = sdf.format(result);
			}
			System.out.println("date from before submit="+datefrom);			
			
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
			System.out.println("date to before submit="+dateto);
		%>	      	
      		<div class="container" align="center">		 
			<form action="BabyDetails_by_facility_date.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> Baby Details </h1>
			
			 <div class="form-group">
				<div id="filters2"></div>
					<script>
						var filterStr= DropdownFilterWithOnchange(talukFilter,"<%= tq%>");				
						filters2.innerHTML=filterStr;
					</script>
		 	</div>
			
			<div class="form-group">
			      <div id="sf"><label style="font-size:20px; color:blue"> Facility:</label>
			      	<!-- <select class="form-control" multiple id="facility1" name="facility1" style="padding:3px;">
					<option value="">Choose</option> 	
					</select> -->
			      </div>
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
			
			<!-- for store facility value -->			
			<input type="hidden" id="hiddenField" name="hiddenField"/>
			
			<br> 
				<button type="submit" class="btn btn-primary">Submit</button>				
				<br /> 																					
			 </form>		 
		 </div>
		<% 
			int compv=0;
			//response.setContentType("text/html");	
			try
			{
				String jspname = "BabyDetails_by_facility_date.jsp";
				DBCursor cursor=null;
				
				String facValues=null;
				int facilityint=0;
				int[] intArray=null;
				int facilityvalue =Integer.parseInt(value);
				if(facilityvalue == 1)
				{
					facValues=request.getParameter("hiddenField");					
					String[] stringFacArray = facValues.split(",");						
					intArray = new int[stringFacArray.length];//create a new int array to store the int values
				    for (int i = 0; i < stringFacArray.length; i++) 
				    {
				        intArray[i] = Integer.parseInt(stringFacArray[i]);//parse the integer value and store it in the int array
				    }										
				}
				else
				{
					facValues=value;
					facilityint=Integer.parseInt(facValues);
				}
				System.out.println("hidden values in string = "+facValues);
				
			   	//date covert to yyyy-mm-dd format
			  	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");				
				Date datef = (Date)sdf.parse(datefrom);
				String newdatefrom = sdf2.format(datef);	
				System.out.println("date from in dd/MM/yyyy format="+datefrom);
				System.out.println("date from after convert to date yyyy-MM-dd format="+newdatefrom);				
				
				Date datet = (Date)sdf.parse(dateto);
				String newdateto = sdf2.format(datet);
				System.out.println("date to in dd/MM/yyyy format="+dateto);
				System.out.println("date to after convert to date yyyy-MM-dd format="+newdateto);
			  	
			  	//print surveytype;
			  	System.out.println("survey  =="+survey);
			  	
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();		
				DB database = mongo.getDB(db);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				BasicDBObject query = new BasicDBObject();				
				
				//retrieve the data of baby details based on date and facility	    			
	    		//create a array list for more than 1 queries
	    		ArrayList<BasicDBObject> list= new ArrayList<BasicDBObject>();    			
	    		//list.add(new BasicDBObject("_id", new BasicDBObject("$gte",obFrom).append("$lte",obTo)));
	    		list.add(new BasicDBObject("data.0.from1", new BasicDBObject("$gte",newdatefrom).append("$lt",newdateto)));
	    		if(!value.equals("All") && !value.equals("1"))	//check for facility is All    					
	    			list.add(new BasicDBObject("data.0.facility", new BasicDBObject("$in", new int[]{facilityint})));
	    		else	//if facility is not All   						
	    			//list.add(new BasicDBObject("data.0.facility", new BasicDBObject("$gt",1)));	
	    			list.add(new BasicDBObject("data.0.facility", new BasicDBObject("$in", intArray)));
	    		query.put("$and",list);
				System.out.println("query ="+query);			
	    		//take cursor to move inside each object of _id and save that in one array
		    	cursor = collection.find(query).sort(new BasicDBObject("data.0.from1",1)); 
	    		//cursor.sort(new BasicDBObject("data.0.from1",1)); //ascending order by fromdate
		    	System.out.println("Size of output:"+cursor.size());
		    	
		    	DBCursor cursor2 = collection.find(query);				
				int cursor_size=cursor.size();
				int cursor2_size=cursor2.size();
				int count = 0;
				int k=0;
				int survey_otherAll=0;
				int survey_all=0;
				int survey_normal_count=0;
				int survey_inlbw_count=0;
				int survey_outlbw_count=0;
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();	
				String surveytype = "-";
				//BabyDetails bd= new BabyDetails();
				
				
				%>
				<div class="container">
				<div class="row">
				<% 
				if(survey.equals("All"))
				{
					%>
					<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= cursor_size%> </b> </h4>
					<%
				}
				%>
							
		     	<div id="All_BabyDetails" class="exporttable table-responsive2">		     	 
                <table class="table table-bordered table-striped tableheader">
                <thead>
					<tr>	
						<th style="width:150px; text-align:center;"> Sl. No.</th>
						<th style="width:210px; text-align:center;"> ObjectID </th>
						<!-- <th style="width:100px; text-align:center;"> Date </th> -->
						<th style="width:150px; text-align:center;"> Period </th>
						<th style="width:100px; text-align:center;"> Facility </th>
						<th style="width:100px; text-align:center;"> Nurse Mentor </th>
						<th style="width:100px; text-align:center;"> No of Deliveries </th>
						<th style="width:100px; text-align:center;"> No of Babies </th>
						<th style="width:100px; text-align:center;"> gt 24ga</th>
						<th style="width:100px; text-align:center;"> Still Births </th>
						<th style="width:100px; text-align:center;"> No of lbws </th>							
						<th style="width:100px; text-align:center;"> No below 2000 </th>							
						<th style="width:100px; text-align:center;"> No of out borns </th>
						<th style="width:200px; text-align:center;"> Babies Unique_ID </th>
						<th style="width:100px; text-align:center;"> Baby DOB </th>
						<th style="width:100px; text-align:center;"> Survey Type </th>
						<th style="width:100px; text-align:center;"> Patient ID1 </th>
						<th style="width:100px; text-align:center;"> Patient ID2 </th>
						<th style="width:100px; text-align:center;"> Mother Name </th>
						<th style="width:100px; text-align:center;"> Husband Name </th>
						<th style="width:100px; text-align:center;"> Time of Birth </th>
						<th style="width:100px; text-align:center;"> Baby Birth Weight </th>
						<th style="width:100px; text-align:center;"> Baby Sex </th>
						<th style="width:100px; text-align:center;"> Baby Status </th>
						<th style="width:100px; text-align:center;"> Taluk_From </th>
						<th style="width:100px; text-align:center;"> Taluk_To </th>
						<th style="width:150px; text-align:center;"> Community_to </th>
						<th style="width:150px; text-align:center;"> Community_From </th>
						<th style="width:100px; text-align:center;"> Phone1 </th>
						<th style="width:100px; text-align:center;"> Phone2 </th>
						<th style="width:150px; text-align:center;"> Thayi_Card_No </th>
						<th style="width:100px; text-align:center;"> UID </th>
						<th style="width:100px; text-align:center;"> EPIC </th>												
					</tr>						
                </thead>
                </table>
                <div class="tablebody">
                <table id="mytable" class="table table-bordered table-striped" >
                <tbody>
				<%
				System.out.println("cursor_size="+cursor_size);
				if(cursor_size>0)
				{					
					int r=0;
					while(cursor.hasNext())
					{	
						//count=0;
						//cursor move on each object
						DBObject dbobj = cursor.next();
						//System.out.println("Object are = "+dbobj);									
						
						//get objectID of each object
						ObjectId objid = (ObjectId) dbobj.get("_id");
						//System.out.println("Each objects id are = " + objid);								
						
						//convert ObjectID into date format
						Date enterDate = objid.getDate();
						//System.out.println("enter date = "+enterDate);
						SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
						java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
						sdf1.setTimeZone(tz);
						String formatDate = sdf1.format(enterDate);
						//System.out.println("Formatted object entered date = " +formatDate);
						
						//get an array of data stored in mongodb 
						BasicDBList data = (BasicDBList) dbobj.get("data");
						//System.out.println("Data array="+data);								
						
						//convert list into BasiccDBObject to retrive each fields
						BasicDBObject data0Obj = (BasicDBObject)data.get(0);
						//System.out.println("data.0 size ="+data0Obj.size());
						//System.out.println("Data.0th elements ="+data0Obj);							
					
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
						//System.out.println("Data.1 objects ="+data1list);						
						
						int size = data1list.size();//data.1 array size
						//System.out.println("Data.1 objects size="+size);					
						
						if(data1list.size()==0)
						{
							//System.out.println("inside when data1list=0");
							surveytype="Notpresent";
							//System.out.println("surveytype is present = "+surveytype);
							
							if(surveytype.equals("Notpresent") && !survey.equals("All"))
							{
								continue;
							}
							%>
							<tr>
								<td id="<%= count%>" rowspan=<%= data1list.size()%> style="width:150px"><b> Record No. <%= (++count)%></b> 
									<br /> 
									<a class="btn btn-info btn-sm" onclick= "window.location.href='LBW_Error_ObjDetails.jsp?filename=<%= jspname%>&id=<%= objid%>&count=<%= count%>'"> <span class="glyphicon glyphicon-trash"></span>Delete </a>
								</td>								
								<td style="width:210px;word-wrap:break-word;"> <%= objid%> 
								<br /><%= formatDate%></td>
								<td style="width:150px;word-wrap:break-word;"><%= bd.from_date +" to "+ bd.to_date%></td>						    	
								<td style="width:100px;word-wrap:break-word;"><%= bd.facility%></td> 
								<td style="width:100px;word-wrap:break-word;"><%= bd.nm%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_deliveries%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_babies%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.gt_24ga%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.still_births%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_lbws%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.no_below_2000%></td>
								<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_ob_lbws%></td>								
								<td colspan="20"></td>	
							</tr>					
						<%
						}
						else
						{	
							//System.out.println("inside when data1list != 0");		
							if(survey.equals("All"))
							{
								//System.out.println("inside when data1list != 0 & survey = all");
								%>
								<tr>
								<td id="<%= count%>" rowspan=<%= data1list.size()%> style="width:150px"><b> Record No. <%= (++count)%></b> 
									<br /> 
									<a class="btn btn-info btn-sm" onclick= "window.location.href='LBW_Error_ObjDetails.jsp?filename=<%= jspname%>&id=<%= objid%>&count=<%= count%>'"><span class="glyphicon glyphicon-trash"></span> Delete </a>
								</td>
								<%
							}
							for(int i=0; i<data1list.size(); i++)
							{								
								//System.out.println("data.1.["+i+"] elements = "+data1list.get(i));	
								BasicDBObject data1Obj = (BasicDBObject) data1list.get(i);
								//data1Obj.isEmpty()
								Object st = null;
								if(data1Obj.containsField("surveyType"))
									st = data1Obj.getString("surveyType");
								//System.out.println("surevy type from data ="+st);
								//System.out.println("surevy type from dropdown ="+survey);
								//System.out.println();
								
								if(survey.equals("All") ||(st!=null && st.equals(survey)))
								{								
									if(data1Obj.containsField("dob"))
									{
										bd.dob = data1Obj.getString("dob");
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
										//System.out.println("pid1:"+bd.pid1);
									}
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
									//System.out.println("time in 24hrs format = "+bd.time_of_birth);
									//System.out.println("time in 12hrs format = "+time12hrs);
									//System.out.println();
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
										String b_status=(String)bd.baby_status;
										if(b_status.equals("1"))
											bd.baby_status="Well";
										else if(b_status.equals("2"))
											bd.baby_status="Sick";
										else
											bd.baby_status="Dead";
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
										String sex1=(String)bd.sex;
										if (sex1.equals("1"))
											bd.sex="Male";
										else if(sex1.equals("2"))
											bd.sex="Female";
										else
											bd.sex="other";
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
												bd.taluk_to = data1Obj.get("taluk_to");
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
									
									if(!survey.equals("All"))
									{										
										++survey_otherAll;
										//count=0;
										//System.out.println("inside when data1list != 0 & survey != all loop");
										//System.out.println("surveytype other than all count ="+survey_otherAll);
										%>
										<tr>
											<td id="<%= count%>" style="width:150px"><b> Record No. <%= (++count)%></b> 
												<br /> 
												<button class="btn btn-warning" onclick= "window.location.href='LBW_Error_ObjDetails.jsp?filename=<%= jspname%>&id=<%= objid%>&count=<%= count%>'"> Delete </button>
											</td>
											<td style="width:210px;word-wrap:break-word;"> <%= objid%>
											<br /><%= formatDate%></td>
											<td style="width:150px;word-wrap:break-word;"><%= bd.from_date +" to "+ bd.to_date%></td>						    	
											<td style="width:100px;word-wrap:break-word;"><%= bd.facility%></td> 
											<td style="width:100px;word-wrap:break-word;"><%= bd.nm%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_deliveries%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_babies%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.gt_24ga%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.still_births%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_lbws%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_below_2000%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_ob_lbws%></td>															
											<td style="width:200px;word-wrap:break-word;"><%= bd.u_id%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.dob%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.surveytype%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.pid1%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.pid2%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.mother_name%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.husband_name%></td>										
											<td style="width:100px;word-wrap:break-word;"><%= bd.time_of_birth%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.birth_weight%></td>
											<td style="width:100px;word-wrap:break-word;"> <%= bd.sex%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.baby_status%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_from%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_to%></td>
											<td style="width:150px;word-wrap:break-word;"><%= bd.community_to%></td>
											<td style="width:150px;word-wrap:break-word;"><%= bd.community_from%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.phone1%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.phone2%></td>							    	
											<td style="width:150px;word-wrap:break-word;"><%= bd.thayi_card_no%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.uid%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.epic%></td>																																	
										</tr>																	
										<%										
									}
									else
									{										
										++survey_all;	
										//System.out.println("inside when data1list != 0 & survey = all loop");
										//System.out.println("surveytype all count ="+survey_all);
										%>
										<!-- <tr> -->																				
											<td style="width:210px;word-wrap:break-word;"> <%= objid%>
											<br /><%= formatDate%></td>
											<td style="width:150px;word-wrap:break-word;"><%= bd.from_date +" to "+ bd.to_date%></td>						    	
											<td style="width:100px;word-wrap:break-word;"><%= bd.facility%></td> 
											<td style="width:100px;word-wrap:break-word;"><%= bd.nm%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_deliveries%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_babies%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.gt_24ga%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.still_births%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_lbws%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_below_2000%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.no_of_ob_lbws%></td>															
											<td style="width:200px;word-wrap:break-word;"><%= bd.u_id%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.dob%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.surveytype%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.pid1%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.pid2%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.mother_name%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.husband_name%></td>										
											<td style="width:100px;word-wrap:break-word;"><%= bd.time_of_birth%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.birth_weight%></td>
											<td style="width:100px;word-wrap:break-word;"> <%= bd.sex%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.baby_status%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_from%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.taluk_to%></td>
											<td style="width:150px;word-wrap:break-word;"><%= bd.community_to%></td>
											<td style="width:150px;word-wrap:break-word;"><%= bd.community_from%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.phone1%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.phone2%></td>							    	
											<td style="width:150px;word-wrap:break-word;"><%= bd.thayi_card_no%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.uid%></td>
											<td style="width:100px;word-wrap:break-word;"><%= bd.epic%></td>																																	
										</tr>
										<%
									}//close for survey=All for delete button
								}//close if of survey type								
							}//close for loop of data.1								
							//System.out.println();
						}//if of data1size>0						
					}//close cursor while loop
					//System.out.println("surveytype other than all count ="+survey_otherAll);
					//System.out.println("surveytype all count ="+survey_all);
					//System.out.println("cursor size ="+cursor.size());
					if(survey_all==0 && survey_otherAll==0)
					{
						%>
						<tr> <td colspan="33" style="text-align:left; color:red;"> <b> No Details </b></td></tr>
						<%
					}
				} //close if cursor size			
				else
				{
					%>
					<tr> <td colspan="33" style="text-align:left; color:red;"> <b> No Details </b></td></tr>
					<%
				}
				
				if(cursor_size>0  && (survey_all != 0 || survey_otherAll != 0))
				{
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
				<%  compv=cursor.size();
			}//close try block						
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
			}				
		%>
		<script>
			var value1 = "<%=compv%>";
			// Get saved data from sessionStorage	
		window.onload = function()
		{				
			displayFacility(<%= (request.getParameter("taluk")==null)?"0":request.getParameter("taluk")%>);	
			var data = sessionStorage.getItem('key');	
			if(data==value1)
			data=data-1;
			var row = document.getElementById(data);
			
			row.scrollIntoView(false);			
			// Remove saved data from sessionStorage
			sessionStorage.removeItem('key');
			// Remove all saved data from sessionStorage
			sessionStorage.clear();
		}
		</script>
		<%@include file="tableexport.jsp" %>
		<!-- script for adding alender for date field and disable dates lesser than datefrom-->
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