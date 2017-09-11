<!DOCTYPE html>
<html>
<head>
    <title>KMC-CC Details </title>    
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Expires" CONTENT="-1">
		
	<script src="facilities.js">	</script>
	<script src="taluks.js">	</script>
	<script src="koppal_villages.js"></script>
	<script src="communityWorkers.js"></script>
	<script src="ken_kmc_html.js"></script>
	<link rel="stylesheet" href="Responsive_Style.css">
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
			width: 3250px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 450px;
			overflow-y: auto;
			width: 3370px;
			margin-bottom:20px;
		}		
   </style>    
   
   <!-- Display facility based on selected taluk -->
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
		   		//console.log(hiddenvalue);
		   	} 
		   	function test()
		   	{
		   		
		   		alert("TD test")
		   	}
	   	</script>
	   	
	   <script>  
		   $('#btn1').click(function() {
			   $("#span1").html("").css('color', 'red');
			});
		   var cvar={};
		  /*  */
		   function addComment(objid)
		   {			  
			  	console.log(objid);
			   cvar.objid=objid;     /* Storing Object ID in Javascript global variable to access in saveRemarks() method */
		   }
		   
		   function saveRemarks()
		   {
				 var rem = document.getElementById("rem").value;
				 var objid=cvar.objid;
				 var request;
				 var urls="failDetails.jsp?objid="+objid+"&rem="+rem;
				 //alert("ObjID="+objid)
				 //alert("Rem="+rem)
			 		if (window.XMLHttpRequest)
					  {
						  request=new XMLHttpRequest();
					  }
					else
					  {
						  request=new ActiveXObject("Microsoft.XMLHTTP");
					  }
				   request.onreadystatechange=function()
				   {
					   if (request.readyState == 4 && request.status == 200)
				 	    {	
							var a = JSON.parse(request.responseText);
							var val=request.responseText;  
							//alert(this.responseText);
							//document.getElementById('snackbar').innerHTML=val;
							//var m=document.getElementById('snackbar').value=val;
							var d = a.jsonArray;
							var s=JSON.stringify(a);
							var n= s.split(":");
							var one=n[0];
							var two=n[1];
							var three=two.split("\"");
							var four=three[1];
							document.getElementById('snackbar').innerHTML=four;
							//alert("Msg="+four)
							 var x = document.getElementById("snackbar");
							   x.className = "show";
							    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
							    if(four=="Remark Saved Successfully")
							    	{
							    	location.reload(true);
		
							    	}
				 	    }
				   }
				   if(rem.length>1)
					   {
					   $("#commentId .close").click()
						request.open("GET",urls,true);  
						request.send();  
					   }
				   else
					   $("#span1").html("Please enter comments").css('color', 'red');
				  
		   }
		   function display(){
				if (request.readyState == 4 && request.status == 200)
		 	    {	
					var a = JSON.parse(request.responseText);
					var val=request.responseText;  
					////alert(this.responseText);
					//document.getElementById('snackbar').innerHTML=val;
					//var m=document.getElementById('snackbar').value=val;
					var d = a.jsonArray;
					var s=JSON.stringify(a);
					var n= s.split(":");
					var one=n[0];
					var two=n[1];
					var three=two.split("\"");
					var four=three[1];
					document.getElementById('snackbar').innerHTML=four;
					//alert("Msg="+four)
					 var x = document.getElementById("snackbar");
					   x.className = "show";
					    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
		 	    }
			}
	   </script>
</head>
<body onload="displayFacility(<%= (request.getParameter("taluk")==null)?"0":request.getParameter("taluk")%>)">
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
		    
	<% 	
		String value = request.getParameter("facility");
		System.out.println("facility ="+value);	
		
		String tq = request.getParameter("taluk"); 
		if(tq==null)
		{
			tq="0";
		}			
		System.out.println("taluk="+tq);
	
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
		System.out.println("date to in dd/MM/yyyy="+dateto);
		System.out.println("date from in dd/MM/yyyy="+datefrom);
	%>		
		<div class="container" align="center">		 
			<form action="calldetails_allbabies.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> LBW KMC CC Details </h1>
			<div class="form-group">
			<div id="filters2"></div>
				<script>
					var filterStr= DropdownFilterWithOnchange(talukFilter,"<%= tq%>");				
					filters2.innerHTML=filterStr;
				</script>
		 	</div>		
			
			<div class="form-group">
				<div id="sf"><label style="font-size:20px; color:blue"> Facility:</label></div>
			</div>
			
			 <div class="form-group">
				<label style="font-size:20px; color:blue"> Date From: </label> 					
				<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
			</div>
			<div class="form-group">
				<label style="font-size:20px; color:blue"> Date To:</label> 
				<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto%>" readonly>				
			</div>
			
			<!-- for store facility value -->			
			<input type="hidden" id="hiddenField" name="hiddenField"/>
				
			<br />					
				<button type="submit" class="btn btn-primary">Submit</button>				
				<br /> 																					
			 </form>	
			 	 
		 </div>	
	    <%
			response.setContentType("text/html");	
			try
			{	
				String facValues=null;
				int facilityvalue =Integer.parseInt(value);
				if(facilityvalue == 1)
				{
					facValues=request.getParameter("hiddenField");					
				}
				else
				{
					facValues=value;
				}
				//System.out.println("hidden values = "+facValues);				
			  	int taluks = Integer.parseInt(tq);
			  	
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();				
				DB database = mongo.getDB(db);
				DBCollection collection = database.getCollection(coll);						
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
				/* int facility = value==null?1:Integer.parseInt(value);
				System.out.println("facility ="+value); */
				
				//convert date to yyyy-MM-dd format
				SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");				
				Date datef = (Date)sdf.parse(datefrom);
				String newdatefrom = sdf2.format(datef);				
				System.out.println("date from after convert to date yyyy-MM-dd format="+newdatefrom);				
				
				Date datet = (Date)sdf.parse(dateto);
				String newdateto = sdf2.format(datet);
				System.out.println("date to after convert to date yyyy-MM-dd format="+newdatefrom);
			  	
				ArrayList<DBObject> jsonArray = mongodao.kmcCCDetails(facValues,newdatefrom, newdateto);
				System.out.println("Total babies ="+jsonArray.size());
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();			
			  	
				int count=0;
				int json_size = jsonArray.size();				
				Object visitdate_7 = "-";
				Object babyalive_7 = "-";
				Object babydeathdate_7 = "-";
				Object kmchrs_7 = "-";					
				Object nokmc_reason_7="-";
				Object nobreastfeed_reason_7="-";
				Object breastfed_7 = "-";
				Object comments_7="-";
				ObjectId objid_7=null;
				
				Object visitdate_7disch ="-";
				Object babyalive_7disch = "-";
				Object babydeathdate_7disch = "-";
				Object kmchrs_7disch = "-";				
				Object breastfed_7disch = "-";
				Object nokmc_reason_7disch="-";
				Object nobreastfeed_reason_7disch="-";
				Object comments_disch="-";
				ObjectId objid_disch=null;
				
				Object visitdate_28 = "-";
				Object babyalive_28 = "-";
				Object babydeathdate_28 = "-";
				Object kmchrs_28 = "-";				
				Object breastfed_28 = "-";
				Object nokmc_reason_28="-";
				Object nobreastfeed_reason_28="-";
				Object comments_28="-";
				ObjectId objid_28=null;
				%>
				<div class="container">
				<div class="row">
				<h4 style="text-align:right; margin-right:5px; color:black"> <b> Total Records:<%= json_size%> </b> </h4>
				<div id="call_details_allbabies" class="exporttable table-responsive2">
				<table class="table table-bordered table-striped tableheader">
				<thead>
					<tr>
						<th style="width:50px;text-align:center; word-wrap:break-word;"> SI. No. </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Facility </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Period </th>											
						<th style="width:200px;text-align:center; word-wrap:break-word;"> Unique ID</th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Mother Name</th>												
						<th style="width:100px;text-align:center; word-wrap:break-word;"> DOB </th>						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Phone1 </th>												
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Visit Date (7th Day of life) </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Alive </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Death Date </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> KMC Hours </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> KMC Comments </th>					
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Exclusive Breastfed </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Breastfed Comments </th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Comments </th>
						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Visit Date (7th Day After Discharge) </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Alive </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Death Date </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> KMC Hours </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> KMC Comments </th>					
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Exclusive Breastfed </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Breastfed Comments </th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Comments </th>
						
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Visit Date (28th Day of life) </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Alive </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Baby Death Date </th>
						<th style="width:100px;text-align:center; word-wrap:break-word;"> KMC Hours </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> KMC Comments </th>					
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Exclusive Breastfed </th>	
						<th style="width:100px;text-align:center; word-wrap:break-word;"> Breastfed Comments </th>
						<th style="width:150px;text-align:center; word-wrap:break-word;"> Comments </th>
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
								visitdate_7 = "-";
								babyalive_7 = "-";
								babydeathdate_7 = "-";
								kmchrs_7 = "-";					
								nokmc_reason_7="-";
								nobreastfeed_reason_7="-";
								breastfed_7 = "-";	
								comments_7="-";
								visitdate_7disch ="-";
								babyalive_7disch = "-";
								babydeathdate_7disch = "-";
								kmchrs_7disch = "-";				
								breastfed_7disch = "-";
								nokmc_reason_7disch="-";
								nobreastfeed_reason_7disch="-";
								comments_disch="-";
								visitdate_28 = "-";
								babyalive_28 = "-";
								babydeathdate_28 = "-";
								kmchrs_28 = "-";				
								breastfed_28 = "-";
								nokmc_reason_28="-";
								nobreastfeed_reason_28="-";
								comments_28="-";
								DBObject obj = jsonArray.get(i);								
								objid_7=null;								
								objid_disch=null;
								objid_28=null;
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
								if(data.containsField("dob"))
								{
									bd.dob = data.get("dob");
								}
								else
								{
									bd.dob = "-";
								}
								
								if(data.containsField("mother_name"))
								{
									bd.mother_name = data.get("mother_name");
								}
								else
								{
									bd.mother_name = "-";
								}								
								
								if(data.containsField("unique_id"))
								{
									bd.u_id = data.get("unique_id");
								}
								else
								{
									bd.u_id = "-";
								}								
								
								if(data.containsField("phone1"))
								{
									bd.phone1 = data.get("phone1");
								}
								else
								{
									bd.phone1 = "-";
								}								
																	
								%>
								<tr>
									<td style=width:50px;word-wrap:break-word;> <%= (++count)%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= bd.facility%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= bd.from_date%> to <%= bd.to_date%> </td>
									<td style=width:200px;word-wrap:break-word;> <%= bd.u_id%> </td>
									<td style=width:150px;word-wrap:break-word;> <%= bd.mother_name%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= bd.dob%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= bd.phone1%> </td>									
								<% 
								BasicDBList compobj_data = (BasicDBList)obj.get("comp_docs");
								for(int j=0; j<compobj_data.size(); j++)
								{									
									BasicDBObject comp_obj_success = (BasicDBObject)compobj_data.get(j);
									if(comp_obj_success.containsField("visit_date"))
									{
										if(comp_obj_success.get("kmc_period").equals("2"))
										{											
											objid_7 = (ObjectId) comp_obj_success.get("_id");
											//System.out.println("object id="+objid_7);
											visitdate_7 = comp_obj_success.get("visit_date");
											if(comp_obj_success.containsField("baby_death_date"))
											{
												babydeathdate_7 = comp_obj_success.get("baby_death_date");
											}
											
											if(comp_obj_success.containsField("baby_alive"))
											{
												babyalive_7 = comp_obj_success.get("baby_alive");
											}
											
											if(comp_obj_success.containsField("breastfeed_no"))
											{
												breastfed_7 = comp_obj_success.get("breastfeed_no");
											}
											
											if(comp_obj_success.containsField("kmc_hours"))
											{
												kmchrs_7 = comp_obj_success.get("kmc_hours");
											}
											
											if(comp_obj_success.containsField("nokmc_reason"))
											{
												nokmc_reason_7 = comp_obj_success.get("nokmc_reason");
											}
											
											if(comp_obj_success.containsField("nobreastfeed_reason"))
											{
												nobreastfeed_reason_7 = comp_obj_success.get("nobreastfeed_reason");
											}
											
											if(comp_obj_success.containsField("comments"))
											{
												comments_7 = comp_obj_success.get("comments");
											}
										}
										if(comp_obj_success.get("kmc_period").equals("3"))
										{
											objid_disch = (ObjectId) comp_obj_success.get("_id");
											//System.out.println("object id="+objid_disch);
											visitdate_7disch = comp_obj_success.get("visit_date");
											if(comp_obj_success.containsField("baby_death_date"))
											{
												babydeathdate_7disch = comp_obj_success.get("baby_death_date");
											}											
											
											if(comp_obj_success.containsField("baby_alive"))
											{
												babyalive_7disch = comp_obj_success.get("baby_alive");
											}
											
											if(comp_obj_success.containsField("breastfeed_no"))
											{
												breastfed_7disch = comp_obj_success.get("breastfeed_no");
											}
											
											if(comp_obj_success.containsField("kmc_hours"))
											{
												kmchrs_7disch = comp_obj_success.get("kmc_hours");
											}
											
											if(comp_obj_success.containsField("nokmc_reason"))
											{
												nokmc_reason_7disch = comp_obj_success.get("nokmc_reason");
											}
											if(comp_obj_success.containsField("nobreastfeed_reason"))
											{
												nobreastfeed_reason_7disch = comp_obj_success.get("nobreastfeed_reason");
											}
											if(comp_obj_success.containsField("comments"))
											{
												comments_disch = comp_obj_success.get("comments");
											}
										}
										if(comp_obj_success.get("kmc_period").equals("4"))
										{
											objid_28 = (ObjectId) comp_obj_success.get("_id");
											//System.out.println("object id="+objid_28);
											visitdate_28 = comp_obj_success.get("visit_date");
											if(comp_obj_success.containsField("baby_death_date"))
											{
												babydeathdate_28 = comp_obj_success.get("baby_death_date");
											}											
											
											if(comp_obj_success.containsField("baby_alive"))
											{
												babyalive_28 = comp_obj_success.get("baby_alive");
											}
											
											if(comp_obj_success.containsField("breastfeed_no"))
											{
												breastfed_28 = comp_obj_success.get("breastfeed_no");
											}
											
											if(comp_obj_success.containsField("kmc_hours"))
											{
												kmchrs_28 = comp_obj_success.get("kmc_hours");
											}	
											
											if(comp_obj_success.containsField("nokmc_reason"))
											{
												nokmc_reason_28 = comp_obj_success.get("nokmc_reason");
											}
											if(comp_obj_success.containsField("nobreastfeed_reason"))
											{
												nobreastfeed_reason_28 = comp_obj_success.get("nobreastfeed_reason");
											}
											if(comp_obj_success.containsField("comments"))
											{
												comments_28 = comp_obj_success.get("comments");
											}
										}
									}//if of success details compare
								}//loop of comp_docs
								%>
									<td style=width:100px;word-wrap:break-word;> <%= visitdate_7%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= babyalive_7%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= babydeathdate_7%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= kmchrs_7%> </td>	
									<td style=width:100px;word-wrap:break-word;> <%= nokmc_reason_7%> </td>								
									<td style=width:100px;word-wrap:break-word;> <%= breastfed_7%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= nobreastfeed_reason_7%> </td>									
									<% if(comments_7.equals("-") && !visitdate_7.equals("-"))									
										{
											%>
											<td style=width:150px;word-wrap:break-word; data-toggle="modal" data-target="#commentId" onclick="addComment('<%= objid_7%>');"><a href="#" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-pencil"></span>No Comment</a></td>
											<%
										}
										else
										{
											%>
											<td style=width:150px;word-wrap:break-word;> <%= comments_7%> </td>
											<%
											
										}
									%>
									
									<td style=width:100px;word-wrap:break-word;> <%= visitdate_7disch%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= babyalive_7disch%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= babydeathdate_7disch%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= kmchrs_7disch%> </td>	
									<td style=width:100px;word-wrap:break-word;> <%= nokmc_reason_7disch%> </td>								
									<td style=width:100px;word-wrap:break-word;> <%= breastfed_7disch%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= nobreastfeed_reason_7disch%> </td>
									<% if(comments_disch.equals("-") && !visitdate_7disch.equals("-"))									
										{
											%>
											<td style=width:150px;word-wrap:break-word; data-toggle="modal" data-target="#commentId" onclick="addComment('<%= objid_disch%>');"><a href="#" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-pencil"></span>No Comment</a></td>
											<%
										}
										else
										{
											%>
											<td style=width:150px;word-wrap:break-word;> <%= comments_disch%> </td>
											<%
										}
									%>
									
									<td style=width:100px;word-wrap:break-word;> <%= visitdate_28%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= babyalive_28%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= babydeathdate_28%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= kmchrs_28%> </td>	
									<td style=width:100px;word-wrap:break-word;> <%= nokmc_reason_28%> </td>								
									<td style=width:100px;word-wrap:break-word;> <%= breastfed_28%> </td>
									<td style=width:100px;word-wrap:break-word;> <%= nobreastfeed_reason_28%> </td>
									<% if(comments_28.equals("-") && !visitdate_28.equals("-"))									
										{
											%>
											<td style=width:150px;word-wrap:break-word; data-toggle="modal" data-target="#commentId" onclick="addComment('<%= objid_28%>');"><a href="#" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-pencil"></span>No Comment</a></td>
											<%
										}
										else
										{
											%>
											<td style=width:150px;word-wrap:break-word;> <%= comments_28%> </td>
											<%
										}
									%>
								</tr>
								<%
								comments_7=null;
								comments_disch=null;
								comments_28=null;
							}//for loop of jsonarray							
						}//close if of jsonarray size compare>0
						else
						{
							%>
								<tr> <td colspan=21> <h4 style="text-align:left;color:red;">No details</h4> </td></tr>
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
		
<div class="modal fade" id="commentId" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-sm">
		<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">Enter Comments</h4>
		</div>
		<div class="modal-body">	
			<div align="center">
			<textarea rows="4" cols="25"  name="comment" onchange="validate()" id="rem" required></textarea><br>
			<span id="span1"></span>  <br>
			<button type="button" class="btn btn-info" id="btn2" onclick="saveRemarks()">submit</button>
			
		</div>
		</div>
		</div>
		</div>
		</div> 
<div id="snackbar"></div>
		
		
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