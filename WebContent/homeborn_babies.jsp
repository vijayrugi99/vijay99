<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		
		<title> Home Born Babies </title>  				
  		<script src="facilities.js">	</script>  		 
  		<script src="koppal_villages.js">	</script> 		
  		<script src="taluks.js">	</script>
		<script src="ken_kmc_html.js"></script>		
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
			-webkit-overflow-scrolling:touch;
			-ms-overflow-style:-ms-autohiding-scrollbar;
			border:1px solid #ddd;
			/* position:relative; */			
			}
			
			.table-responsive2 table {
			    table-layout: fixed;
			}
			.tableheader {
				width: 1950px;
				margin-bottom:0px;
				border:1px solid #999;			
			}
			.tablebody {
				height: 500px;
				overflow-y: auto;
				width: 1968px;
				margin-bottom:20px;				
			}
		</style>
		
		<!-- Display facility based on selected taluk -->
		<script>
		   	function displayTown(index)
		   	{			   		
		   		//alert(index);		   		
		   		var town=null;
		   		if(index=="1")
		   		{
		   			town = koppal_villages;
		   		}
		   		else if(index=="2")
		   		{
		   			town = gangawati_villages;
		   		}
		   		else if(index=="3")
		   		{
		   			town = kushtagi_villages;
		   		}		   		
		   		else if(index=="4")
		   		{
		   			town = yelbarga_villages;
		   		}		   		
		   		if(index=="5")
		   		{
		   			var st="<label style=\"font-size:20px; color:blue\"> Town/Village:</label>";
			   		st+="<select name=\"town\" id=\"town\" class=\"form-control\" style=\"padding:3px;\">";			   		
		   		}
		   		else
		   		{		   			
		   			var townArray = [];
			   		var selected = "";			   		
			   		var len1=0;
			   		var townvalue = '<%= request.getParameter("town")%>';
		   			if(townvalue!="other")			   		
			   		{		   			
			   			var townint = parseInt(townvalue);
			   			//alert(townint);
			   		}		   		
			   		//console.log(townint);		   		
			   		var st="<label style=\"font-size:20px; color:blue\"> Town/Village:</label>";
			   		st+="<select name=\"town\" id=\"town\" class=\"form-control\" style=\"padding:3px;\">";
			   		st+="<option value=\"1\">All</option>";
			   		selected = "";		   		
			   		for(i=0;i<town.length;i++)
					{
				   		var value=town[i].value;
				      	var text=town[i].text;
				      	if(townvalue !=null && townint==town[i].value)
				      	{
				      		 selected="selected";
				      	}
				      	else
				      		 selected="";
				      	st+="<option "+selected+" value="+town[i].value+">"+town[i].text+"</option>";
				      	len1++;	
				      	townArray.push(town[i].value);
				   	}
			   		if(townvalue=="other")
			   		{
			   			selected="selected";
			   		}
			   		else
			   		{
			   			selected="";
			   		}
		   		}		   		
		   		st+="<option "+selected+" value=other>Other</option>";
		   	    st+="</select>";
				sf.innerHTML=st;				
		   	}
	   	</script>		
	</head>	
	<body onload="displayTown(<%= (request.getParameter("taluk")==null)?"1":request.getParameter("taluk")%>)">
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
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>				
      	
      	<%
			String tq = request.getParameter("taluk");
	      	if(tq==null)
	      	{
	      		tq="1";
	      	}
			System.out.println("taluk="+tq);
			
			String town = request.getParameter("town");
			System.out.println("town = "+town);
			
			String bw = request.getParameter("bw");
			System.out.println("birth weight = "+bw);
		%>			  			
		<div class="container">
		<center>
		<form action="homeborn_babies.jsp" method="POST" class="form-inline">
		<h1 style = "color:brown"> Home-Born Babies </h1>		 		
		
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Taluk: </label> 
			<select id="taluk" name="taluk" class="form-control" style="padding:3px" onchange="displayTown((this.options.selectedIndex)+1);"> 	
			<%				
				String[] str2 = {"Koppal", "Gangawati", "Kushtagi", "Yelburga", "Other"};
				String[] vt = {"1", "2", "3", "4", "5"};
				String selected2 = "";
				//int s=0;
				for(int v=0; v<str2.length; v++)
				{						
					if(tq != null && tq.equals(vt[v]))
					{						
						selected2 = "selected";	
						%>
							<script>displayTown(<%=tq%>)</script>
						<%
					}
					else 
						selected2 = "";
					
					out.println("<option value="+vt[v]+" "+selected2+">"+str2[v]+"</option>");						
				}						
			%> 				
			</select >
		</div>&nbsp;
		
		<div class="form-group">
			<div id="sf"><label style="font-size:20px; color:blue"> Town/Village:</label></div>
		</div>&nbsp;
		
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Birth-weight: </label> 
			<select id="bw" name="bw" class="form-control" style="padding:3px"> 	
			<%				
				String[] str1 = {"All", "<=2000 (lbw)", ">2000 (normal)", "-1 (error)"};
				String[] bwv = {"0", "1", "2", "3"};
				String selected1 = "";
				//int s=0;
				for(int v=0; v<str1.length; v++)
				{						
					if(bw != null && bw.equals(bwv[v]))
					{						
						selected1 = "selected";						
					}
					else 
						selected1 = "";
					
					out.println("<option value="+bwv[v]+" "+selected1+">"+str1[v]+"</option>");						
				}						
			%> 				
			</select >
		</div>
		<br /> 
		<button type="submit" class="btn btn-primary">Submit</button>				
		<br />																				
		</form>	
		</center>
		</div>		
		<%
			//response.setContentType("text/html");					
			try
			{	
				String townValues=null;
				int facilityint=0;
				int[] intArray=null;
				//int talukvalue = Integer.parseInt(tq);				
				int bwvalue = Integer.parseInt(bw);				
				townValues=town;				
				System.out.println("hidden town values in string = "+townValues);
				
				//get connection to mongodb				
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				System.out.println("mongo = "+mongo);
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(homeborn);						
				System.out.println("Collection used ="+collection); 
				
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,homeborn);
				ArrayList<DBObject> jsonArray=null;
				jsonArray = mongodao.homeBornBabies(tq,townValues,bwvalue);				
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
				int count=0;
			%>
			<div class="container">
			<div class="row">
		    <div id="Homeborn_Babies" class="exporttable table-responsive2">
                <table class="table table-bordered table-striped tableheader">
                    <thead>
                     	<tr>					
							<th style="width:50px;text-align:center;"> SI. No. </th>
							<th style="width:100px;text-align:center;"> NM </th>
							<th style="width:50px;text-align:center;"> Taluk From </th>
							<th style="width:100px;text-align:center;"> Community From </th>
							<th style="width:200px;text-align:center;"> Unique ID </th>
							<th style="width:150px;text-align:center;"> Mother Name </th>
							<th style="width:150px;text-align:center;"> Father Name </th>							
							<th style="width:100px;text-align:center;"> DOB </th>
							<th style="width:100px;text-align:center;"> Time of Birth </th>
							<th style="width:100px;text-align:center;"> Sex </th>							
							<th style="width:100px;text-align:center;"> Baby condition </th>													
							<th style="width:150px;text-align:center;"> Survey Type </th>
							<th style="width:100px;text-align:center;"> Date of listing </th>						
							<th style="width:100px;text-align:center;"> Baby Weight Measured Date </th>
							<th style="width:100px;text-align:center;"> Measured Baby weight </th>
							<th style="width:100px;text-align:center;"> Calculated Birth weight </th>
							<th style="width:100px;text-align:center;"> Baby Admitted</th>
							<th style="width:100px;text-align:center;"> Facility </th>											
						</tr>				
					</thead>
                </table>
                <div class="tablebody">
                <table class="table table-bordered table-striped">
                <tbody>	 
                <tr>               	
				<%				
				if(jsonArray.size() >0)
				{
					for(int i=0; i<jsonArray.size(); i++)
					{
						BasicDBObject data = (BasicDBObject)jsonArray.get(i);
						//System.out.println("listing data = "+data);
						
						bd.nm = data.getInt("nm");
						bd.mother_name = data.get("mother_name");
						bd.husband_name = data.get("husband_name");
						bd.start_date = data.get("start_date");
						bd.taluk_from = data.get("taluk_from");
						
						if(data.get("community_from").equals("other"))
						{
							bd.community_from = data.get("community_from-Comment");
						}
						else
						{
							bd.community_from = data.get("community_from");
						}
						
						if(data.containsField("baby_admitted"))
						{
							bd.baby_admitted=data.get("baby_admitted");
						}
						else
						{
							bd.baby_admitted="-";
						}
						
						if(data.containsField("facility"))
						{
							bd.facility=data.get("facility");
						}
						else
						{
							bd.facility="-";
						}
						if(data.containsField("sex"))
						{
							bd.sex = data.getString("sex");//getInt("epic");
							String sex1=(String)bd.sex;
						//	System.out.println("Sex1="+sex1);
							if (sex1.equals("1"))
								bd.sex="Male";
							else if(sex1.equals("2"))
								bd.sex="Female";
							else
								bd.sex="other";
						}
						else
							bd.sex = "-";
						if(data.containsField("baby_status"))
						{
							bd.baby_status = data.getString("baby_status");
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
						//System.out.println("Sex="+bd.sex);
						bd.dob = data.get("dob");
						bd.babymeasured_weight = data.get("baby_weight");
						bd.babyweight_date = data.get("babyweight_date");
						bd.time_of_birth = data.get("time_of_birth");
					//	bd.baby_status = data.get("baby_status");
					//	bd.sex = data.get("sex");
						bd.u_id = data.get("unique_id");
						bd.surveytype = data.get("surveyType");
						bd.birth_weight = data.get("birth_weight");	
						
						%>						
							<td style="width:50px; word-wrap:break-word"> <%= (++count)%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.nm%> </td>
							<td style="width:50px; word-wrap:break-word"> <%= bd.taluk_from%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.community_from%> </td>
							<td style="width:200px; word-wrap:break-word"> <%= bd.u_id%> </td>
							<td style="width:150px; word-wrap:break-word"> <%= bd.mother_name%> </td>
							<td style="width:150px; word-wrap:break-word"> <%= bd.husband_name%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.dob%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.time_of_birth%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.sex%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.baby_status%> </td>
							<td style="width:150px; word-wrap:break-word"> <%= bd.surveytype%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.start_date%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.babyweight_date%> </td>
							<td style="width:100px; word-wrap:break-word"> <%= bd.babymeasured_weight%> </td>
							<td style="width:100px;word-wrap:break-word"> <%= bd.birth_weight%> </td>
							<td style="width:100px;word-wrap:break-word"> <%= bd.baby_admitted%> </td>
							<td style="word-wrap:break-word"> <%= bd.facility%> </td>
						</tr>
						<%
					}//close for loop for json array
				}//close if when size>0
				else
				{
					%>
					<tr> <td colspan=18> <h4 style="text-align:left; color:red">No records</h4> </td></tr>
					<%
				}
				%>	
				</tbody>							
				</table>
				</div>
				</div>
				</div></div>
				<%
			}//close try block
			catch(Exception e)
			{
				System.out.println(e);
			}
		%>	
		<%@ include file="tableexport.jsp" %>		
	</body>
</html>