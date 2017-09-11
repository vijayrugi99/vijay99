<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		
		<title> classified babies </title>  				
  		<script src="facilities.js">	</script>
  		<script src="taluks.js">	</script>
		<script src="ken_kmc_html.js"></script>		
		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

   		<!-- style for table fixed -->
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
			.tableheader 
			{
				width: 1750px;
				margin-bottom:0px;
				border:1px solid #999;
			}
			.tablebody 
			{
				height: 500px;
				overflow-y: auto;
				width: 1753px;
				margin-bottom:20px;
			}
		</style>
		
		<!-- Display facility based on selected taluk -->
		<script>
		   	function displayFacility(index)
		   	{
		   		//alert(index);
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
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>				
      	
      	<%        
	      	String value = request.getParameter("facility");
			System.out.println("facility ="+value);	
			
			String tq = request.getParameter("taluk"); 
			if(tq==null)
			{
				tq="0";
			}			
			System.out.println("taluk="+tq);
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); //date format
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
			System.out.println("datefrom from form="+datefrom);
						
			String dateto = request.getParameter("dateto"); //get value from form
			if(dateto == null)
			{
				dateto = sdf.format(dt);
			}
			else
			{
				Date dt2=(Date)sdf.parse(dateto);
				dateto=sdf.format(dt2);
			}
			System.out.println("date to from form="+dateto);	
			
			String classify_res = request.getParameter("res");
			System.out.println("classified = "+classify_res);
		%>			  			
		<div class="container">
		 <center>
		 <form action="classified_babies.jsp" method="POST" class="form-inline">
		 <h1 style = "color:brown"> Classified Babies </h1>
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
		
		<div class="form-group">
				<label style="font-size:20px; color:blue"> Results:</label> 
				<select id="res" name="res" class="form-control" style="padding:3px"> 	
				<!-- jsp(java) logic to keep the selected data as data field on submit without .js file -->
				<%	
					String[] str = {"Duplicates", "Readmits", "Groups"};							
					String selected = "";
					for(int v=0; v<str.length; v++)
					{	
						if(classify_res != null && classify_res.equals(str[v]))
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
			  	
			 	//convert date to yyyy-MM-dd format
				SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");				
				Date datef = (Date)sdf.parse(datefrom);
				String newdatefrom = sdf2.format(datef);				
				System.out.println("date from after convert to date yyyy-MM-dd format="+newdatefrom);				
				
				Date datet = (Date)sdf.parse(dateto);
				String newdateto = sdf2.format(datet);
				System.out.println("date to after convert to date yyyy-MM-dd format="+newdateto);
				
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
				
				ArrayList<DBObject> jsonArray=null;
				jsonArray = mongodao.classified_babies(facValues,newdatefrom,newdateto,classify_res);				
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();					
				System.out.println("No. of "+classify_res+" = "+jsonArray.size());
				int count=0;
				Object u_id= "-";
				Object dob = "-";				
				Object mother = "-";
				Object husband = "-";
				Object thayi_card_no = "-";
				Object pid1 = "-";
				Object phone1 = "-";
				Object phone2 = "-";
				Object bw = "-";
				Object sex = "-";
				Object tob = "-";
				Object facility = "-";
				Object entered_date = "-";
				Object t_half = "-";
				Object duplicateOf= "-";
				Object readmitOf= "-";
				Object group_id= "-";
			%>
			<div class="container">
			<div class="row">
		    <div id="classified_babies" class="exporttable table-responsive2">
                <table class="table table-bordered table-striped tableheader">
                    <thead>
                     	<tr>					
							<th style="width:50px;text-align:center;"> SI. No. </th>
							<th style="width:200px;text-align:center;"> Unique ID</th>
							<th style="width:100px;text-align:center;"> DOB </th>
							<th style="width:150px;text-align:center;"> Mother Name </th>
							<th style="width:150px;text-align:center;"> Husband Name</th>
							<th style="width:100px;text-align:center;"> Thayi card No. </th>
							<th style="width:100px;text-align:center;"> Pid1 </th>
							<th style="width:100px;text-align:center;"> Phone1 </th>
							<th style="width:100px;text-align:center;"> phone2 </th>
							<th style="width:100px;text-align:center;"> Bith Weight </th>
							<th style="width:100px;text-align:center;"> Sex </th>
							<th style="width:100px;text-align:center;"> Time of Birth </th>						
							<th style="width:100px;text-align:center;"> Facility </th>						
							<th style="width:100px;text-align:center;"> Entered Date </th>		
							
							<% 
								if(classify_res.equals("Duplicates"))
								{
									%>						
									<th style="width:200px;text-align:center;"> Duplicate of </th>
									<%
								}
								else if(classify_res.equals("Readmits"))
								{
									%>						
									<th style="width:200px;text-align:center;"> Readmit of </th>
									<%
								}	
								else if(classify_res.equals("Groups"))
								{
									%>															
									<th style="width:200px;text-align:center;"> Grouped With </th>	
									<%
								}					
							%>				
						</tr>				
					</thead>
                </table>
                <div class="tablebody">
                <table class="table table-bordered table-striped" >
                <tbody>		
				<%				
				if(jsonArray.size()>0)
				{					
					for(int i=0; i<jsonArray.size(); i++)
					{
						BasicDBObject obj = (BasicDBObject)jsonArray.get(i);
						BasicDBObject facility_obj = (BasicDBObject)obj.get("facility");
						BasicDBObject data_obj = (BasicDBObject)obj.get("data");
						
						if(data_obj.containsField("unique_id"))
						{
							u_id= data_obj.get("unique_id");
						}
						else
						{
							u_id= "-";
						}
						
						if(data_obj.containsField("dob"))
						{
							dob= data_obj.get("dob");
						}
						else
						{
							dob= "-";
						}
						
						if(data_obj.containsField("mother_name"))
						{
							mother= data_obj.get("mother_name");
						}
						else
						{
							mother= "-";
						}
						
						if(data_obj.containsField("husband_name"))
						{
							husband= data_obj.get("husband_name");
						}
						else
						{
							husband= "-";
						}
						
						if(data_obj.containsField("thayi_card_no"))
						{
							thayi_card_no= data_obj.getInt("thayi_card_no");
						}
						else
						{
							thayi_card_no= "-";
						}
						
						if(data_obj.containsField("pid1"))
						{
							pid1= data_obj.getInt("pid1");
						}
						else
						{
							pid1= "-";
						}
						
						if(data_obj.containsField("phone1"))
						{
							phone1= data_obj.get("phone1");
						}
						else
						{
							phone1= "-";
						}
						
						if(data_obj.containsField("phone2"))
						{
							phone2= data_obj.get("phone2");
						}
						else
						{
							phone2= "-";
						}
						
						if(data_obj.containsField("birth_weight"))
						{
							bw= data_obj.getInt("birth_weight");
						}
						else
						{
							bw= "-";
						}
						
						if(data_obj.containsField("sex"))
						{
							sex= data_obj.get("sex");
						}
						else
						{
							sex= "-";
						}
						
						if(data_obj.containsField("time_of_birth"))
						{
							tob= data_obj.get("time_of_birth");
						}
						else
						{
							tob= "-";
						}
						
						if(data_obj.containsField("half"))
						{
							t_half= data_obj.get("half");
						}
						else
						{
							t_half = "-";
						}
						
						if(facility_obj.containsField("facility"))
						{
							facility= facility_obj.getInt("facility");
						}
						else
						{
							facility= "-";
						}
						
						if(facility_obj.containsField("to_date"))
						{
							entered_date= facility_obj.get("to_date");
						}
						else
						{
							entered_date= "-";
						}
						
						if(classify_res.equals("Duplicates"))
						{
							if(data_obj.containsField("duplicateof"))
							{
								duplicateOf= data_obj.get("duplicateof");
							}
							else
							{
								duplicateOf= "-";
							}
						}
						else if(classify_res.equals("Readmits"))
						{
							if(data_obj.containsField("readmitof"))
							{
								readmitOf= data_obj.get("readmitof");
							}
							else
							{
								readmitOf= "-";
							}
						}
						else if(classify_res.equals("Groups"))
						{
							if(data_obj.containsField("groupid"))
							{
								group_id= data_obj.get("groupid");
							}
							else
							{
								group_id= "-";
							}
						}
						%>
						<tr>
							<td style="width:50px;text-align:center;"> <%= (++count)%></td>
							<td style="width:200px;text-align:center;"> <%= u_id%></td>
							<td style="width:100px;text-align:center;"> <%= dob%></td>
							<td style="width:150px;text-align:center;"> <%= mother%></td>
							<td style="width:150px;text-align:center;"> <%= husband%></td>
							<td style="width:100px;text-align:center;"> <%= thayi_card_no%></td>
							<td style="width:100px;text-align:center;"> <%= pid1%></td>
							<td style="width:100px;text-align:center;"> <%= phone1%></td>
							<td style="width:100px;text-align:center;"> <%= phone2%></td>
							<td style="width:100px;text-align:center;"> <%= bw%></td>
							<td style="width:100px;text-align:center;"> <%= sex%></td>
							<td style="width:100px;text-align:center;"> <%= tob%> <%= t_half%></td>
							<td style="width:100px;text-align:center;"> <%= facility%></td>
							<td style="width:100px;text-align:center;"> <%= entered_date%></td>							
							<% 
								if(classify_res.equals("Duplicates"))
								{
									%>
									<td style="text-align:center;"> <%= duplicateOf%></td>	
									<%
								}
								else if(classify_res.equals("Readmits"))
								{
									%>
									<td style="text-align:center;"> <%= readmitOf%></td>	
									<%
								}
								else if(classify_res.equals("Groups"))
								{
									%>
									<td style="text-align:center;"> <%= group_id%></td>	
									<%
								}
							%>
						</tr>
						<%						
					}//close for loop for json array					
				}//close if when size>0
				else
				{
					%>
					<tr> <td colspan=14> <h4>No records</h4> </td></tr>
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
		<!-- Date picker logic-->		
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
			<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
			<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
			<script type="text/javascript">	
			    $(document).ready(function () 
				{
			   		var fromDate=document.getElementById("datefrom").value;
				    var pre = new Date("09/01/2016");
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