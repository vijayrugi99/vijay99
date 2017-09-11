<!DOCTYPE html>
<html>
<head>
    <title> NormalCC details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv=”Pragma” content=”no-cache”>
	<meta http-equiv=”Expires” content=”-1?>
	<meta http-equiv=”CACHE-CONTROL” content=”NO-CACHE”>
	
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
			width: 1650px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 500px;
			overflow-y: auto;
			width: 1670px;
			margin-bottom:20px;
		}		

		.modal { overflow: auto !important; 
		/* z-index: 1;
		  position:fixed; */
		 }
		 
		#snackbar{
		  /* width: 200px;
		  height: 200px; */
		  position:absolute; z-index:10000;
		}
   </style>
   
   <script>
   		window.onload = function() 
   		{  			
   			displayFacility(<%= (request.getParameter("taluk")==null)?"0":request.getParameter("taluk")%>);
	   		var ses=sessionStorage.getItem('auto-refresh');
	   		sessionStorage.removeItem('auto-refresh')
	   		if ( ses=== 'YES') {
	         	window.location.reload();
	   		}
	 	};   
   </script>
   
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
	%>
		
	<div class="container" align="center">		 
	<form action="monitoring_normalbabies.jsp" method="POST" class="form-inline">
	<h1 style = "color:brown"> CC Details Of Normal Babies </h1>		
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
			DB database = mongo.getDB(db);
			DBCollection collection = database.getCollection(coll);						
			com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
			/* int facility = value==null?1:Integer.parseInt(value); */
			ArrayList<DBObject> jsonArray = mongodao.monitoringNormalBaby(facValues,newdatefrom,newdateto);
			com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
			System.out.println("json size = "+jsonArray.size());
			int arrCount=jsonArray.size();
			int count=0;
			Object fromDate="-";
			Object toDate="-";
			Object facility="-";
			Object uniqueId="-";
			Object motherName="-";
			Object husbandName="-";
			Object dob="-";
			Object sex="-";
			Object bw1="-";
			Object visitDate="-";
			Object motherAlive="-";
			Object babyAlive="-";
			Object exclBreast="-";
			Object exclBreastComment="-";
			
			String[] comments = {"Baby in ICU/ Facility", "Baby Dead", "Mother dead"};
			String comment="-";
 			%>		
			<br>
			<div class="container">
			<div class="row">				
			<div class="exporttable table-responsive2">
            <table class="table table-bordered table-striped tableheader">
            <thead>
            	<tr>
                	<th style="width:50px;text-align:center;">Sl No.</th>
                	<th style="width:100px; text-align:center;"> Period </th>
                    <th style="width:100px;text-align:center;">Facility</th>
                    <th style="width:200px;text-align:center;word-wrap:break-word;">Unique ID</th>
                    <th style="width:150px;text-align:center;word-wrap:break-word;">Mother Name</th>
                    <th style="width:150px;text-align:center;word-wrap:break-word;">Father Name</th>
                    <th style="width:100px;text-align:center;">DOB</th> 
                    <th style="width:100px;text-align:center;">Sex</th>                      
                    <th style="width:100px;text-align:center;word-wrap:break-word;">Birth weight1</th>
                    <th style="width:100px;text-align:center;word-wrap:break-word;">Date of call/visit date</th>
                    <th style="width:100px;text-align:center;">Mother alive</th>
                    <th style="width:100px;text-align:center;word-wrap:break-word;">Baby alive</th> 
                    <th style="width:100px;text-align:center;word-wrap:break-word;">Excl. Breast feeding</th> 
                    <th style="width:200px;text-align:center;word-wrap:break-word;">comment</th>                    
                 </tr> 
            </thead>
            </table>
                <div class="tablebody">
                <table class="table table-bordered table-striped" >
                <tbody>
                   <tr>
                    <% 	
	   					if(jsonArray.size()>0)
	   					{
							for(int i=0; i<jsonArray.size(); i++)
							{
								BasicDBObject facility_obj = (BasicDBObject)jsonArray.get(i).get("facility");
								BasicDBObject data_obj = (BasicDBObject)jsonArray.get(i).get("data");
								BasicDBList comp_list = (BasicDBList)jsonArray.get(i).get("comp_docs");
								if(facility_obj.containsField("from_date"))
								{
									fromDate=facility_obj.get("from_date");
								}
								else
								{
									fromDate="-";
								}
								
								if(facility_obj.containsField("to_date"))
								{
									toDate=facility_obj.get("to_date");
								}
								else
								{
									toDate="-";
								}
								
								if(facility_obj.containsField("facility"))
								{
									facility=facility_obj.getInt("facility");
								}
								else
								{
									facility="-";
								}
								
								uniqueId=data_obj.get("unique_id");
								motherName = data_obj.get("mother_name");
								husbandName = data_obj.get("husband_name");
								dob = data_obj.get("dob");
								bw1 = data_obj.get("birth_weight");
								if(data_obj.containsField("sex"))
								{
									sex = data_obj.get("sex");
								}
								//System.out.println("comp obj size ="+comp_list.size());
								for(int j=0; j<comp_list.size(); j++)
								{
									BasicDBObject comp_obj = (BasicDBObject)comp_list.get(j);
									if(comp_obj.containsField("visit_date"))
									{
										visitDate = comp_obj.get("visit_date");
									}
									else
									{
										visitDate ="-";
									}
									
									if(comp_obj.containsField("mother_alive"))
									{
										motherAlive = comp_obj.get("mother_alive");
									}
									else
									{
										motherAlive ="-";
									}
									
									if(comp_obj.containsField("baby_alive"))
									{
										babyAlive = comp_obj.get("baby_alive");
									}
									else
									{
										babyAlive ="-";
									}
									
									if(comp_obj.containsField("breastfeed_no"))
									{
										exclBreast = comp_obj.get("breastfeed_no");
									}
									else
									{
										exclBreast ="-";
									}
									
									if(comp_obj.containsField("nobreastfeed_reason"))
									{
										exclBreastComment = comp_obj.get("nobreastfeed_reason");
										String exclcomm = (String)exclBreastComment;
										System.out.println("exclcomm "+exclcomm);
										if(exclcomm.equals("1"))
										{
											comment = comments[Integer.parseInt(exclcomm)-1];
										}
										else if(exclcomm.equals("2"))
										{
											comment = comments[Integer.parseInt(exclcomm)-1];
										}
										else if(exclcomm.equals("3"))
										{
											comment = comments[Integer.parseInt(exclcomm)-1];
										}
										else
										{
											comment = exclcomm;
										}
									}	
									else
									{
										comment ="-";
									}
								}															
								%>
									<td style="width:50px;text-align:center;word-wrap:break-word;"> <%= (++count)%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= fromDate%> to <%= toDate%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= facility%> </td>
									<td style="width:200px;text-align:center;word-wrap:break-word;"> <%= uniqueId%> </td>
									<td style="width:150px;text-align:center;word-wrap:break-word;"> <%= motherName%> </td>
									<td style="width:150px;text-align:center;word-wrap:break-word;"> <%= husbandName%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= dob%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= sex%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= bw1%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= visitDate%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= motherAlive%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= babyAlive%> </td>
									<td style="width:100px;text-align:center;word-wrap:break-word;"> <%= exclBreast %> </td>
									<td style="width:200px;text-align:center;word-wrap:break-word;"> <%= comment%> </td>
								</tr>
								<%
							}//close array loop	
						}//close if of array
						else
						{
							%>
							<tr> <td colspan="14" style="text-align:left; color:red;"> <b> No Details </b></td> </tr>					
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
				catch(Exception  e)
				{
					//out.println("Exception::"+e);							
					//e.printStackTrace(response.getWriter());
					System.out.println(e);
				}			
			%> 
		<%@include file="tableexport.jsp" %> 		
		<!-- Date picker logic-->		
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
			<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
			<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/start/jquery-ui.css" rel="Stylesheet" type="text/css" />			
			<script type="text/javascript">	
			    $(document).ready(function () 
				{
			   		var fromDate=document.getElementById("datefrom").value;
				    var pre = new Date("10/01/2016");
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