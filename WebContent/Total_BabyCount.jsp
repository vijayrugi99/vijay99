<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		
		<title> Track Babies </title>		
  		<link rel="stylesheet" type="text/css" href="Responsive_Style.css"> 		
  		<script src="facilities.js">	</script>  		
  		<script src="taluks.js">	</script>
		<script src="ken_kmc_html.js"></script>	
		<script src="ken_kmc_html.js"></script>	
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>		
		
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
		<%@include file="handleEvent.jsp" %>		
      	
      	<%        
	      	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");			
	      	String value = request.getParameter("facility");
			System.out.println("facility ="+value);	
			
			String tq = request.getParameter("taluk"); 
			if(tq==null)
			{
				tq="0";
			}			
			System.out.println("taluk="+tq);				
			
			String datefrom = request.getParameter("datefrom"); //get value from form
			Date today = new Date();
			Calendar c1 = Calendar.getInstance(); 
			c1.setTime(today); 
			c1.add(Calendar.DATE, -6);
			today = c1.getTime();
			String today_7 = sdf.format(today);
			System.out.println("today-7 date ="+today_7);
			if(datefrom == null)
			{
				datefrom = today_7;
			}
			System.out.println("date from before submit="+datefrom);			
			
			Date dateto2=sdf.parse(datefrom);
			Calendar c2 = Calendar.getInstance(); 
			c2.setTime(dateto2); 
			c2.add(Calendar.DATE, 6);
			dateto2 = c2.getTime();
			String dateto1=sdf.format(dateto2);
			System.out.println("date to + 7th day of date from ="+dateto1);
			
			String dateto = request.getParameter("dateto"); //get value from form			
			if(dateto == null)
			{
				dateto = dateto1;
			}
			else
			{
				dateto=request.getParameter("dateto");
			}
			System.out.println("date to from dropdown="+dateto);		
		%>         	  			
				
		<div class="container" align="center">		 
			<form action="Total_BabyCount.jsp" method="POST" class="form-inline">
			<h1 style = "color:brown"> Total Babies count </h1>
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
				<label style="font-size:20px; color:blue"> DOB From: </label> 					
				<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
			</div>
			<div class="form-group">
				<label style="font-size:20px; color:blue"> DOB To:</label> 
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
			//response.setContentType("text/html");					
			try
			{	
				int kmcPeriod = 4;
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
				System.out.println("mongo = "+mongo);
				DB database = mongo.getDB(db);
				System.out.println("Used db ="+database);
				System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				System.out.println("Collection used ="+collection); 
				
				System.out.println("datefrom after convert="+datefrom);
				Date df = sdf.parse(datefrom);
			  	Date dt = sdf.parse(dateto);
				System.out.println("Dtfrom="+datefrom+"Dtto="+dateto);
				SimpleDateFormat sdf_ddmm = new SimpleDateFormat("yyyy-MM-dd");
				String date_from = sdf_ddmm.format(df);
				String date_to = sdf_ddmm.format(dt);
				
				System.out.println("datefrom after convert into yyyy-MM-dd="+date_from);
			  	System.out.println("dateto after convert into yyyy-MM-dd="+date_to);
			  	
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
				//int facility = value==null?1:Integer.parseInt(value);
				//System.out.println("Facility in  jsp page ="+facility);
				ArrayList<DBObject> jsonArray = mongodao.totalBabyCount(facValues, date_from, date_to);
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				System.out.println("Json array size ="+jsonArray.size());
				int count=0;
				int kmcCount=0;
				int dischCount=0;
				int pendingKmc=0;
				int pendingDischwithkmc=0;
				int pendingDischwithoutkmc=0;
				Object surveytype = null;
				int inborn_cnt=0;
				int inlbw_cnt=0;				
				int outlbw_cnt=0;
				%>
				<div class="container">
				<div class="row">
				<div id="Total_Babies_Count" class="exporttable table-responsive">
					<table class="table table-bordered table-striped">	
					<thead>			
					<tr>					
						<th style="text-align:center; word-wrap:break-word;"> Total Normal Babies </th>
						<th style="text-align:center; word-wrap:break-word;"> Total Inborn_LBW Babies </th>
						<th style="text-align:center; word-wrap:break-word;"> Total Outborn_LBW Babies </th>
						<th style="text-align:center; word-wrap:break-word;"> KMC Initiated Babies </th>
						<th style="text-align:center; word-wrap:break-word;"> Babies Discharged after KMC Initiated</th>
						<th style="text-align:center; word-wrap:break-word;"> Babies Pending for KMC</th>
						<th style="text-align:center; word-wrap:break-word;"> Babies KMC Initiated but not Discharged</th>
						<th style="text-align:center; word-wrap:break-word;"> Babies pending for Discharged without KMC Initiated</th>												
					</tr>
					</thead>
					<tbody>	
					<tr>			
				<% 				
				for(int i=0; i<jsonArray.size(); i++)
				{
					BasicDBObject data_obj = (BasicDBObject)jsonArray.get(i).get("data");
					BasicDBList comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");
					BasicDBList disch_obj = (BasicDBList)jsonArray.get(i).get("discharge_docs");
					//System.out.println("comp_obj size is = "+comp_obj.size());
					//System.out.println("disch_obj size is = "+disch_obj.size());
					
					//total lbw and normal count
					if(data_obj.containsField("surveyType"))
					{
						surveytype = data_obj.get("surveyType");
						if(surveytype.equals("inborn_normal"))
						{
							++inborn_cnt;
						}
						else if(surveytype.equals("inborn_lbw"))
						{
							++inlbw_cnt;
							
							//kmc initiated count
							if(comp_obj.size()>0)
							{
								++kmcCount;
							}					
							
							//discharged count					
							if(disch_obj.size()>0)
							{
								++dischCount;
							}
							
							//pending for kmc initiation
							if(comp_obj.size()== 0 && disch_obj.size() == 0)
							{
								++pendingKmc;
							}
							
							//kmc initiated but not discharged
							if(comp_obj.size()>0 && disch_obj.size() == 0)
							{
								++pendingDischwithkmc;
							}
							
							//no of babies pending for discharged without kmc init
							if(comp_obj.size()==0 && disch_obj.size() == 0)
							{
								++pendingDischwithoutkmc;
							}
						}
						else if(surveytype.equals("outborn_lbw"))
						{
							++outlbw_cnt;
							//kmc initiated count
							if(comp_obj.size()>0)
							{
								++kmcCount;
							}					
							
							//discharged count					
							if(disch_obj.size()>0)
							{
								++dischCount;
							}
							
							//pending for kmc initiation
							if(comp_obj.size()== 0 && disch_obj.size() == 0)
							{
								++pendingKmc;
							}
							
							//kmc initiated but not discharged
							if(comp_obj.size()>0 && disch_obj.size() == 0)
							{
								++pendingDischwithkmc;
							}
							
							//no of babies pending for discharged without kmc init
							if(comp_obj.size()==0 && disch_obj.size() == 0)
							{
								++pendingDischwithoutkmc;
							}
						}
					}					
				}
				System.out.println("Total Babies = "+jsonArray.size());				
				System.out.println("Total normal Babies = "+inborn_cnt);
				System.out.println("Total inborn lbw Babies = "+inlbw_cnt);
				System.out.println("Total outborn lbw Babies = "+outlbw_cnt);
				System.out.println("Total Babies initiated for kmc = "+kmcCount);
				System.out.println("Total Babies initiated for kmc and not Discharged = "+pendingDischwithkmc);
				System.out.println("Total Babies initiated for without kmc and not Discharged = "+pendingDischwithoutkmc);
				System.out.println("Total Babies discharged= "+dischCount);
				System.out.println("Total Babies pending for kmc= "+pendingKmc);				
				%>				
					<td> <%= inborn_cnt%> </td>
					<td> <%= inlbw_cnt%> </td>
					<td> <%= outlbw_cnt%> </td>
					<td> <%= kmcCount%> </td>
					<td> <%= dischCount%> </td>
					<td> <%= pendingKmc%> </td>
					<td> <%= pendingDischwithkmc%> </td>
					<td> <%= pendingDischwithoutkmc%> </td>
				</tr>
				</tbody>				
				</table>
				</div>
				</div>
				</div>
				<br />
				<br />					
				<% 
			}//close try block			
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
				e.printStackTrace();
			}				
		%>
		<%@include file="tableexport.jsp" %>
		<!-- script for adding alender for date field and disable dates lesser than datefrom-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
		
		<script type="text/javascript">	
			    $(document).ready(function () 
				{
			   		var fromDate=document.getElementById("datefrom").value;
				    var pre = new Date("09/16/2016");
					var date=new Date();
					date.setDate(date.getDate());
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
								date.setDate( date.getDate());        
								var newDate = date.toDateString(); 
								newDate = new Date( Date.parse( newDate ) );                      
								$('#dateto').datepicker("option","minDate",newDate);            
				        }
				    });
				})
			</script>
	</body>
</html>