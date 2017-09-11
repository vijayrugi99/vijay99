<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		
		<title> csv data </title>  				
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
			.tableheader {
			width: 1150px;
			margin-bottom:0px;
			border:1px solid #999;
			}
			.tablebody {
			height: 500px;
			overflow-y: auto;
			width: 1165px;
			margin-bottom:20px;
			}
		</style>
		
		<script>
			function generate_filename(file,objid,db,col)
			{
				//alert("Obj="+objid)
				//response.setContentType("application/csv");
				 var url = "<%= session.getServletContext().getContextPath()+"/csv/"%>";
						//getRealPath("/")+"csv/"%>";
				url+=file;
				var user = "<%= session.getAttribute("username")%>";
				var role = "<%= session.getAttribute("role")%>";
				var date= "<%= new Date()%>";
				var urls="exist.jsp?objid="+objid+"&un="+user+"&role="+role+"&db="+db+"&col="+col;
				if (window.XMLHttpRequest)
				  {
				  	xmlhttp=new XMLHttpRequest();
				  }
				else 
				  {
				  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				  }
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
			    {
				    alert(xmlhttp)
			    }
				xmlhttp.open("GET",urls,true);
				xmlhttp.send();
				//alert(url);
				window.location.href=url; 
			}
		</script>
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
		<%@page import = "com.mongodb.util.JSON"%>
		<%@include file="handleEvent.jsp" %>				
      	
      	<% 
      		String url =session.getServletContext().getRealPath("/")+"/csv/";
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); //date format
			//logic to increment one day from today's date
			Date dt = new Date();
			//current date - one month 
			/* Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			Date result = cal.getTime();
			System.out.println("Before one month date ="+result); */
						
			String datefrom = request.getParameter("datefrom"); //get value from form
			if(datefrom == null)
			{
				datefrom = "01/10/2016";
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
		%>			  			
		<div class="container">
		 <center>
		 <form action="csvfile_report.jsp" method="POST" class="form-inline">
		 <h1 style = "color:brown"> CSV Data </h1>
		 
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Date From: </label> 					
			<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
		</div>
		
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Date To:</label> 
			<input style="background-color:white" id="dateto" name="dateto" type="text" class="form-control" value="<%= dateto%>" readonly>				
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
				DBCollection collection = database.getCollection(csv);						
				System.out.println("Collection used ="+collection); 
				
				//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
				com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,csv);
				ArrayList<DBObject> jsonArray=null;
				jsonArray = mongodao.csvdata(newdatefrom,newdateto);				
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
				int count=0;
			%>
			<div class="container">
			<div class="row">
		    <div id="csv data" class="exporttable table-responsive2">
                <table id="Discharged_Babies" class="table table-bordered table-striped tableheader">
                    <thead>
                     	<tr>					
							<th style="width:60px;text-align:center;"> SI. No. </th>
							<th style="width:100px;text-align:center;"> File Type </th>							
							<th style="width:400px;text-align:center;"> File Name </th>	
							<th style="width:100px;text-align:center;"> From Date </th>
							<th style="width:100px;text-align:center;"> To Date </th>
							<th style="width:200px;text-align:center;"> Created Date </th>
							<th style="width:90px;text-align:center;"> File Size </th>
							<th style="width:100px;text-align:center;"> Download </th>																		
						</tr>				
					</thead>
                </table>
                <div class="tablebody">
                <table class="table table-bordered table-striped">
                <tbody>		
				<%				
				if(jsonArray.size() > 0)
				{
					for(int i=0; i<jsonArray.size(); i++)
					{
						BasicDBObject csvdata = (BasicDBObject)jsonArray.get(i);
						//System.out.println("csv data ="+csvdata);
						
						Date created_date=csvdata.getDate("created");						
						SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
						java.util.TimeZone tz = java.util.TimeZone.getTimeZone("IST");
						sdf1.setTimeZone(tz);
						String formatDate = sdf1.format(created_date);
						String filesize=null;
						String objid=null;
						objid=csvdata.get("_id").toString();				
						
						//Date cretaed_date = new Date(csvdata.get("created"));
						if(csvdata.containsField("size"))
						{
							filesize=csvdata.get("size").toString()+"KB";				
						}
						else
							filesize="-";
						
						bd.filename=csvdata.get("filename");
						if(csvdata.containsField("type"))
						{
							bd.filetype=csvdata.get("type");
							if(bd.filetype==null)								
							{
								bd.filetype="-";
							}							
						}	
						
						//convert date format into dd/mm/yyyy
						String dtfrom=(String)csvdata.get("datefrom");
						Date df = (Date)sdf2.parse(dtfrom);
						bd.csv_datefrom = sdf.format(df);
						
						String dto=(String)csvdata.get("dateto");
						Date dt1 = (Date)sdf2.parse(dto);
						bd.csv_dateto = sdf.format(dt1);
						 
						%>
						<tr>
							<td style="width:60px;word-wrap:break-word;"> <%= (++count)%> </td>
							<td style="width:100px;word-wrap:break-word;"> <%= bd.filetype%> </td>
							<td style="width:400px;word-wrap:break-word;"> <%= bd.filename%> </td>
							<td style="width:100px;word-wrap:break-word;"> <%= bd.csv_datefrom%> </td>
							<td style="width:100px;word-wrap:break-word;"> <%= bd.csv_dateto%> </td>
							<td style="width:200px;word-wrap:break-word;"> <%= formatDate%> </td>	
							<td style="width:90px;word-wrap:break-word;"> <%= filesize%></td>					
							<td> 
								<button class="btn btn-info" onclick="generate_filename('<%=bd.filename%>','<%=objid%>','<%=db%>','<%=csv%>');"> Download </button>
							</td>
						</tr>
						<%
					}//close for loop for json array
					//System.out.println("count loop = "+cnt);
					System.out.println();
				}//close if when size>0
				else
				{
					%>
					<tr> <td colspan=6> <h4>No records</h4> </td></tr>
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