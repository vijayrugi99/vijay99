<!DOCTYPE html>
<html>
<head>
    <title> KMC Track </title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv=”Pragma” content=”no-cache”>
	<meta http-equiv=”Expires” content=”-1?>
	<meta http-equiv=”CACHE-CONTROL” content=”NO-CACHE”>
	
	<script src="facilities.js">	</script>
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
			width: 1300px;
			margin-bottom:0px;
			border:1px solid #999;
			text-align:center;
		}
		.tablebody {
			height: 500px;
			overflow-y: auto;
			width: 1318px;
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
   
   <script>var gvar={};</script> 
      
  <!--  get faccility based on selected taluk  -->
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
	<script>
		/*script for printing table for community details*/
		function format1(cmtext, cmvalue, cws1,babyuid,startdate,kPeriod)
		{		
			var count=0;
			if(cws1==null)
				return "";				
				var str="<h5 style=\"color:blue\">Community From Details</h5>";
					str+= cmtext+"["+cmvalue+"]";
					str+="<div class=\container\">";
					str+="<div class=\"panel-body\">";
					str+="<div class=\"table-responsive\">";
					str+="<table class=\"table table-bordered table-hover table-striped\">";
					str+="<thead><tr><th style=\"text-align:center\">Role</th><th style=\"text-align:center\">Name</th><th style=\"text-align:center\">Phone</th></tr></thead>";
					str+="<tbody>";
				for(var i=0; i < cws1.length;i++)
				{
					//str+="<tr><td>"+cws1[i].text+"</td><td><a href='tel:"+cws1[i].phone+"'>"+cws1[i].phone+"</td><td>"+cws1[i].type+"</td></tr>";
					var cnt=++count;
					str+="<tr><td>"+cws1[i].type+"</td>";
					str+="<td>"+cws1[i].text+"</td>";
					if(cws1[i].phone == "" || cws1[i].phone == "-" || cws1[i].phone == "N/A!" || cws1[i].phone == "#REF!")
					{
						str+="<td> - </td>";
					}
					else
					{
						str+="<td><a href=tel:'"+cws1[i].phone+"' class='btn btn-default' onclick='cdf(\""+cws1[i].type+"\",\""+cws1[i].text+"\",\""+cws1[i].phone+"\")'><span class='glyphicon glyphicon-earphone'></span>&nbsp"+cws1[i].phone+"</a></td></tr>";						
					}
				}				
				str+="</tbody></table></div></div></div>";			
				str+="</center>";								
				return str;
		}
		function format2(cmtext, cmvalue, cws1,babyuid,startdate,kPeriod)
		{		
			var count=0;
			if(cws1==null)
				return "";				
				var str="<h5 style=\"color:blue\">Community To Details</h5>";
					str+= cmtext+"["+cmvalue+"]";
					str+="<div class=\container\">";
					str+="<div class=\"panel-body\">";
					str+="<div class=\"table-responsive\">";
					str+="<table class=\"table table-bordered table-hover table-striped\">";
					str+="<thead><tr><th style=\"text-align:center\">Role</th><th style=\"text-align:center\">Name</th><th style=\"text-align:center\">Phone</th></tr></thead>";
					str+="<tbody>";
				for(var i=0; i < cws1.length;i++)
				{
					//str+="<tr><td>"+cws1[i].text+"</td><td><a href='tel:"+cws1[i].phone+"'>"+cws1[i].phone+"</td><td>"+cws1[i].type+"</td></tr>";
					var cnt=++count;
					str+="<tr><td>"+cws1[i].type+"</td>";
					str+="<td>"+cws1[i].text+"</td>";
					if(cws1[i].phone == "" || cws1[i].phone == "-" || cws1[i].phone == "N/A!" || cws1[i].phone == "#REF!")
					{
						str+="<td> - </td>";
					}
					else
					{
						str+="<td><a href=tel:'"+cws1[i].phone+"' class='btn btn-default' onclick='cdf(\""+cws1[i].type+"\",\""+cws1[i].text+"\",\""+cws1[i].phone+"\")'><span class='glyphicon glyphicon-earphone'></span>&nbsp"+cws1[i].phone+"</a></td></tr>";
					}
				}				
				str+="</tbody></table></div></div></div>";			
				str+="</center>";								
				return str;
		}
		function motherContact(babyuid,startdate,kPeriod,mothername, ph1, ph2)
		{
			var role="mother";			
			var str="<h5 style=\"color:blue\">Mother Details</h5>";
			str+="<div class=\container\">";
			str+="<div class=\"panel-body\">";
			str+="<div class=\"table-responsive\">";
			str+="<table class=\"table table-bordered table-hover table-striped\">";
			str+="<thead><tr><th style=\"text-align:center\">Mother Name</th><th style=\"text-align:center\">Phone1</th><th style=\"text-align:center\">Phone2</th></tr></thead>";
			str+="<tbody  style=\"height:10%\">";
			str+="<tr> <td>"+mothername+"</td>";
			if(ph1=="-")
			{
				str+="<td>"+ph1+"</td>";
			}
			else
			{
				str+="<td><a href=tel:'"+ph1+"' class='btn btn-default' onclick='mdf(\""+mothername+"\","+ph1+")'><span class='glyphicon glyphicon-earphone'></span>&nbsp "+ph1+"</a></td>";
			}
			if(ph2=="-")
			{
				str+="<td>"+ph2+"</td>";
			}
			else
			{
				str+="<td><a href=tel:'"+ph2+"' class='btn btn-default' onclick='mdf(\""+mothername+"\","+ph2+")'><span class='glyphicon glyphicon-earphone'></span>&nbsp"+ph2+"</a></td>";
			}
			str+="</tr>";
			str+="</tbody></table></div></div></div>";
			str+="</center>";
			return str;
		}		
	</script>
	<script>
		function cdf(type,text,ph){
		 window.location.href="tel://"+ph;
		 setTimeout(function(){
		      $('#status').modal('show');
		  }, 3000);
		 gvar.type=type;
		 gvar.text=text;
		 gvar.cph=ph;
		}
	</script>
	<script>
		function mdf(m,ph){
			window.location.href="tel://"+ph;
			
			setTimeout(function(){
			      $('#status').modal('show');
			  }, 3000);
			gvar.mm=m;
			gvar.mph=ph;	
		}
	</script>
	<script>
		function display(ph){
			alert(ph)
		}
		</script>		
	<script>
		function saveRemarks()
	 	 {
		  	 var rem = document.getElementById("rem").value;
		  	 var name =gvar.name; 
		  	 var id = gvar.id;
		  	 var period = gvar.period;
		  	 var mm = gvar.mm;
		     var mph = gvar.mph;
			 var type = gvar.type;
			 var text = gvar.text;
			 var cph = gvar.cph;
		  	 if(type==null){
		  		 type="mother";
		  	 	 cph=mph;
		  	 	 text=name;	 
		  	 }	
		     //window.location.href="failDetail.jsp?name="+text+"&id="+id+"&rem="+rem+"&period="+period+"&type="+type+"&cph="+cph;
		  	 var urls="failDetails.jsp?name="+text+"&id="+id+"&rem="+rem+"&period="+period+"&type="+type+"&cph="+cph;
		     //$('#fail').modal('toggle');
		  		if (window.XMLHttpRequest)
		  		  {
		  			  request=new XMLHttpRequest();
		  		  }
		  		else
		  		  {
		  			  request=new ActiveXObject("Microsoft.XMLHTTP");
		  		  }
		  		request.onreadystatechange=display;
		  		request.open("GET",urls,true);  
		  		request.send();  
		  }
		
		function display(){
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
				 var x = document.getElementById("snackbar");
				   x.className = "show";
				    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	  	    }
		}
	</script>
	
	<script>
		function disSuccess()
		{
			var sd=gvar.sd;
			var m=gvar.name;
			var id=gvar.id;
			var p=gvar.period;
			
		    var mph = gvar.mph;
		    var type = gvar.type;
			var text = gvar.text;
			var cph = gvar.cph;
			if(type==null)
			{
			   type="mother";
			   cph=mph;
			   text=m;	 
			}	
		  	window.location.href="normal-cc.jsp?name="+m+"&kmcPeriod="+p+"&start_date="+sd+"&baby="+id+"&calledTo="+text+"&type="+type+"&cph="+cph;
		  }
	</script>
	<script>
		function saveDetails(m,p,d,id){
			gvar.sd=d;
			gvar.name=m;
			gvar.id=id;
			gvar.period=p;
		}
	</script>			
	<script>
		function call(ph)
		{
			var name = ph;
			document.getElementById("p2").innerHTML = name;
		}
	</script>
	
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
	<form action="28day_normal_babies.jsp" method="GET" class="form-inline">
	<h1 style = "color:brown"> 28Day Normal Babies </h1>
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Taluk:</label> 
			<select id="taluk" name="taluk" class="form-control" style="padding:3px" onchange="displayFacility(this.options.selectedIndex);"> 	
			<%
				if(tq==null || tq.equals("0"))
				{
					%>
					<script>
					displayFacility(0);
					</script>
					<% 
				}
				String[] str2 = {"All","Koppal", "Gangawati", "kushtagi", "yelburga"};
				String[] vt = {"0","1", "2", "3", "4"};
				String selected2 = "";
				for(int v=0; v<str2.length; v++)
				{						
					if(tq != null && tq.equals(vt[v]))
					{
						selected2 = "selected";	
						%>
							<script>displayFacility(<%=tq%>)</script>
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
			<div id="sf"><label style="font-size:20px; color:blue"> Facility:</label></div>
		</div>&nbsp;		
		
		<div class="form-group">
			<label style="font-size:20px; color:blue"> Date From: </label> 					
			<input style="background-color:white" id="datefrom" name="datefrom" type="text" class="form-control" value="<%= datefrom%>" readonly>				
		</div>&nbsp;
		
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
			ArrayList<DBObject> jsonArray = mongodao.normal28dayBaby(facValues,newdatefrom,newdateto);
			com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
			int arrCount=jsonArray.size();
			int count=0;
			int count2=0;
			Object phnum1="-";
			Object phnum2="-";
			int displayBaby_cnt=0;
 			%>		
			<br>
			<div class="container">
			<div class="row">			
			<div class="table-responsive2">
            <table class="table table-bordered table-striped tableheader">
            <thead>
            	<tr>
                	<th style="width:50px;text-align:center;">Sl No.</th>
                	<th style="width:100px;text-align:center;"> Period </th>
                    <th style="width:100px;text-align:center;">Facility</th>
                    <th style="width:200px;text-align:center;word-wrap:break-word;">Unique ID</th>
                    <th style="width:100px;text-align:center;">DOB</th>
                    <th style="width:150px;text-align:center;">Mother</th>
                    <th style="width:150px;text-align:center;">Father</th>
                    <th style="width:100px;text-align:center;word-wrap:break-word;">Discharge Date</th>
                    <th style="width:100px;text-align:center;word-wrap:break-word;">Community Details</th>
                    <th style="width:150px;text-align:center;">Type</th>
                    <th style="width:100px;text-align:center;word-wrap:break-word;">Call Details</th>                      
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
								int babyCount=++count2;
								//System.out.println("baby count="+babyCount);
								BasicDBList comp_obj = (BasicDBList)jsonArray.get(i).get("comp_docs");
								BasicDBList dis_doc = (BasicDBList)jsonArray.get(i).get("discharge_docs");
								String containsKmc_cc="no";
								//String date_of_outcome="";	
								for(int d=0;d<dis_doc.size();d++){
									BasicDBObject dis_obj=(BasicDBObject)dis_doc.get(d);
									bd.date_of_outcome = dis_obj.get("date_of_outcome");
								}
								//check for whether the baby has kmc_details_cc surveytype
								for(int k=0; k < comp_obj.size(); k++)
								{
									BasicDBObject comp_obj_array =(BasicDBObject)comp_obj.get(k);
									if(comp_obj_array.containsField("mother_alive"))
									{
										bd.mother_alive=comp_obj_array.get("mother_alive");
									
									}
									if(comp_obj_array.containsField("baby_alive"))
									{
										bd.baby_alive=comp_obj_array.get("baby_alive");
									
									}
									
									if(comp_obj_array.containsField("surveyType"))
									{
										if(comp_obj_array.get("surveyType").equals("kmc_details_cc"))
										{	
											String kmcperiod = Integer.toString(kmcPeriod);
											if((bd.baby_alive.equals("No"))
													&& (comp_obj_array.get("kmc_period").equals("2") || 
													comp_obj_array.get("kmc_period").equals("3") || 
													comp_obj_array.get("kmc_period").equals("4")))
											{
												containsKmc_cc="yes";
											}											
											
											if(comp_obj_array.get("kmc_period").equals(kmcperiod))
											{	
												if(comp_obj_array.containsField("status"))
												{
													//if(comp_obj_array.get("status").equals("failed"))
													containsKmc_cc="no";
												}
												else
												{
													containsKmc_cc="yes";
												}
											}
										}										
									}																		
								}
								if(containsKmc_cc.equals("yes"))
								{									
									continue;
								}
								
								//if baby doesn't have kmc_details_cc surveytype print baby
								else
								{
									++displayBaby_cnt;
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
									SimpleDateFormat sdf3= new SimpleDateFormat("dd/MM/yyyy");
									String  start_date = sdf3.format(new Date());
									Calendar ca = Calendar.getInstance();
									ca.setTime(sdf3.parse(start_date));
									ca.add(Calendar.DATE,0);  
									start_date = sdf3.format(ca.getTime());
									//System.out.println("yesterday date = "+start_date);									
									
									BasicDBObject facilityData = (BasicDBObject)jsonArray.get(i).get("facility");
									bd.facility = facilityData.getInt("facility");
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
									//System.out.println("Faility are ="+bd.facility);
									BasicDBObject kmcData = (BasicDBObject)jsonArray.get(i).get("data");
									bd.dob = kmcData.get("dob");
									
									//convert dob from yyyy-mm-dd format to dd/mm/yyyy
									SimpleDateFormat dobFormat= new SimpleDateFormat("yyyy-MM-dd");
									String dob = (String)kmcData.get("dob1");									
									Date dt2=(Date)dobFormat.parse(dob);
									dob = sdf.format(dt2);									
									bd.u_id = kmcData.get("unique_id");
									bd.mother_name = kmcData.get("mother_name");
									bd.husband_name = kmcData.get("husband_name");
									if(kmcData.get("phone1")==null)
									{
										phnum1="-";
									}
									else
										phnum1=kmcData.get("phone1");
									if(kmcData.get("phone2")==null)
									{
										phnum2="-";
									}
									else
										phnum2=kmcData.get("phone2");
									Object commFrom = kmcData.get("community_from")+"";						
									Object commTo = kmcData.get("community_to")+"";
									%>
		                            <td style="width:50px;word-wrap:break-word;"><%= (++count)%></td>
		                            <td style="width:100px;word-wrap:break-word;"><%= bd.from_date +" to "+ bd.to_date%></td>
		                            <td style="width:100px;word-wrap:break-word;"><%= bd.facility%></td>
		                            <td style="width:200px;word-wrap:break-word;"><%= bd.u_id%> </td>
		                            <td style="width:100px;word-wrap:break-word;"><%= bd.dob%></td>		                            
		                            <td style="width:150px;word-wrap:break-word;"><%= bd.mother_name%></td>
		                            <td style="width:150px;word-wrap:break-word;"><%= bd.husband_name%></td>
		                            <td style="width:100px;word-wrap:break-word;"><%= bd.date_of_outcome%></td>
		                            <td style="width:100px;word-wrap:break-word;"><div id="commfrom_<%=count%>"></div>									
		                            <button data-toggle="modal" data-target="#myBtn1_<%=count%>" onclick= "saveDetails('<%= bd.mother_name%>','<%=kmcPeriod%>','<%= start_date%>','<%=kmcData.get("unique_id")%>')"  class="btn btn-info" style="color:black">Contacts</button>		
									<div class="modal fade" name="myBtn1" id="myBtn1_<%=count%>" role="dialog">
									<div class="modal-dialog modal-lg">
									<div class="modal-content">
									<div class="modal-header">
									<h3 class="modal-title" style="color:brown"> Contact Details </h3>
									<button type="button" class="close" data-dismiss="modal">&times;</button>											
									</div>
									<div class="modal-body">																	          
										<p id="myPop1_<%=count%>">  </p>
									</div>
									
									<div class="modal-footer"></div>
									</div>
									</div>
									</div>
									<%
										if(commFrom.equals("other") && commTo.equals("other"))
										{
										%>
											<script>							
												myPop1_<%=count%>.innerHTML = motherContact("<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%= bd.mother_name%>","<%=phnum1%>","<%=phnum2%>");
											</script>
										<%
										}
										else if(commFrom.equals("other") && !commTo.equals("other"))
										{
										%>
											<script>
												myPop1_<%=count%>.innerHTML = motherContact("<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%= bd.mother_name%>","<%=phnum1%>","<%=phnum2%>")+"<br>"+format2(getCommunity(<%=commTo%>),<%=commTo%>,getCWByComm(<%=commTo%>),"<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>");
											</script>
										<%
										}
										else if(!commFrom.equals("other") && commTo.equals("other"))
										{
										%>
											<script>
												myPop1_<%=count%>.innerHTML = motherContact("<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%= bd.mother_name%>","<%=phnum1%>","<%=phnum2%>")+"<br>"+format1(getCommunity(<%=commFrom%>),<%=commFrom%>,getCWByComm(<%=commFrom%>),"<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>");
											</script>
										<%
										}												
										else if(!commFrom.equals("other") && !commTo.equals("other"))
										{
										%>
											<script>
												myPop1_<%=count%>.innerHTML = motherContact("<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>","<%= bd.mother_name%>","<%=phnum1%>","<%=phnum2%>")+"<br>"+format1(getCommunity(<%=commFrom%>),<%=commFrom%>,getCWByComm(<%=commFrom%>),"<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>")+"<br>"+format2(getCommunity(<%=commTo%>),<%=commTo%>,getCWByComm(<%=commTo%>),"<%=kmcData.get("unique_id")%>","<%= start_date%>","<%=kmcPeriod%>");
											</script>
										<%
										}
										%>	
										</td>
			                           <td style="width:150px;"><%=kmcData.get("surveyType")%></td>
			                            <td style="width:100px;">
			                            	<button class="btn btn-info btn-sm" style="color:black" onclick="window.location.href='CallDetails.jsp?baby=<%=kmcData.get("unique_id")%>'"> View </button>
			                            </td>
			                         </tr>
	                         		<%	
									}//else close for kmc_cc contains
								}//close array loop	
							}//close if of array
							
			   				if(displayBaby_cnt == 0 || jsonArray.size() == 0)
			   				{
			   					%>
								<tr> <td colspan="12" style="text-align:left; color:red;"> <b> No Details </b></td></tr>					
								<%
			   				}
							if(jsonArray.size()>0 && displayBaby_cnt != 0)
							{
								%>
								<tr> <td colspan="12" style="text-align:left; color:red;"> <b> -----End of Records----- </b></td></tr>					
								<%
							}
						%>
					</tbody>
				</table>
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
		</div></div>
		<div id="snackbar"></div>
		<div class="modal" id="status" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
			<div class="modal-body">	
				<div align="center">
				<h4>Please select call status</h4>
				<a  class="btn btn-success btn-sm" onclick="disSuccess()">success</a>
				<button type="button" id="fBtn" class="btn btn-danger"  data-toggle="modal" data-target="#fail" data-dismiss="modal" >Failed</button>
				</div>
			</div>
		</div>
		</div>            
		</div>
		
		<div class="modal fade" id="fail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-sm">
		<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">Enter Call Failure Comments</h4>
		</div>
		<div class="modal-body">	
			<div align="center">
			<textarea rows="4" cols="25"  name="comment"  id="rem" required></textarea><br><br>
			<button type="button" class="btn btn-info" id="btn2" onclick="saveRemarks()" data-dismiss="modal">submit</button>  
		</div>
		</div>
		</div>
		</div>
		</div>		
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