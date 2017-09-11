<%@page import="java.io.*,java.util.*,com.kentropy.kmc.process.*,com.kentropy.mongodb.*,com.mongodb.util.JSON,java.text.*"%>
<html >
 <head>
	 <meta charset="utf-8" />
	    <meta name="viewport" content="width=device-width" />
	 <!-- link href="https://dxsurvey.com/Content/css?v=j86S_phLMe_0xl-L4OfXYRSSGz6a6bxeCwsSUGvh3K41" rel="stylesheet"/-->
	 <link href="style2.css" rel="stylesheet">
	<script src="ken-datefun.js"></script>
	<script src="koppal_villages.js"></script>
	<script src="communityWorkers.js"></script>
	 <script src="discharge.js"></script>
	<script src="staff.js"></script>
	<script src="facilities.js"></script>
	<!-- script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js" ></script-->
	<script src="knockout.js"></script>
	<script src="survey.bootstrap.min.js"></script>
	<script src="offline.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  			<link rel="stylesheet" href="Responsive_Style.css">
</head>
<body>
	<%@ include file="Config.jsp" %>
	<%@ include file="home.jsp" %>
	<script>
	<%
	SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");	
	%>
	var baby=<%=JSON.serialize(new MongoDAO(db,coll).getBaby1(request.getParameter("baby")).get(0))%>;
	function getKMCInitDate()
	{
	if(baby.comp_docs.length==0)
	{
	return null;
	
	}
	else
	{
	if(baby.comp_docs[0].kmc_initiated='KMC Initiated')
	{
	return baby.comp_docs[0].date_of_kmc_initiation;
	}
	else
	return null;
	
	}
	
	}
	function handleChange()
	{
	alert(Offline.state);
	/*if(offline.state=="up")
	offline=false
	else
	offline=true;*/
	}
	function saveToServer(data)
	{
	
	var request={};
	var disch_coll = "<%= dischargecoll%>";
	//colId.value=new Date().toISOString();
	//colJSON.value=JSON.stringify(data);
	request.colId=new Date().toISOString();
	request.colJSON=JSON.stringify(data);
	request.collection=disch_coll;
	postForm(request,"saveJSON1.jsp");	
	//saveForm.submit();	
	}
	function doKmc()
	{
	document.location.href="kmc-fi.jsp?baby=<%=request.getParameter("baby")%>&start_date="+start_date+"&end_date="+end_date;
	}
	function display()
	{
	var fac="";
	console.log(baby.facility.facility)
	for(var i=0; i< facilities.length;i++)
	{
	if(facilities[i].value==baby.facility.facility)
	{
	fac=facilities[i].text;
	break;
	}
	}
	var data=baby.data;
	var str="<div class=\"container\">";
	str+="<div class=\"row\">";
	str+="<div class=\"table-responsive\">";
	str+="<table class=\"table table-bordered table-striped\">";
	str+="<thead>";
	str+="<tr><th>Facility</th><th>IP number</th><th>Mother</th><th>Father</th><th>DOB</th>";
	str+="<th>Sex</th><th>Birth Weight</td><th>KMC Initiation date</th></tr></thead>";
	str+="<tbody><tr><td>"+fac+"</td><td>"+data.pid1+"<td>"+data.mother_name+"</td><td>"+data.husband_name+"</td>";
	str+="<td>"+data.dob+"</td><td>"+(data.sex==1?"M":"F")+"'"+"</td><td>"+data.birth_weight+"</td><td>"+getKMCInitDate()+"</td></tr></tbody>";
	str+="</table><div></div></div>";
	backgroundInfo.innerHTML=str;
	var cws1=getCWByComm(data.community_from);
	var cws2=getCWByComm(data.community_to);
	for(var i=0; i< cws1.length;i++)
	{
	dischargeCommunities.push(cws1[i]);
	}
	if(data.community_from!=data.community_to)
	{
	for(var i=0; i< cws2.length;i++)
	{
	dischargeCommunities.push(cws2[i]);
	}
	}
	}
	</script>
	
	<script src="jquery.min.js"></script>
	<script>	
	function postForm(request,url)
	{	    
	        $.post(url,
	       request,
	        function(data,status)
	        {	        
	        	//get session storage value
	        	var filename = sessionStorage.getItem('filename');
	        	// Remove saved data from sessionStorage
	        	sessionStorage.removeItem('filename');
	        	// Remove all saved data from sessionStorage
	        	sessionStorage.clear();
	        	
	        	alert("Data saved successfully: " + data + "\nStatus: " + status);
	        	alert("FIle name="+filename)
	         //   localStorage.removeItem("data");
	           // save1.style.display="none";      
	       //     kmcBtn.style.display="block";
	       		window.location.href=filename;
	           });
	    };
	
	</script>
	
	<div id="backgroundInfo">
	</div>
	<div id= "mySurveyJSName"   style1="background-color:#f0f0f0;"></div>
	<script>
	function pad(val,pad1,dig)
	 {
		 console.log(val.length);
		 
		 if(val.length<dig)
		 {
		 for(var i=0; i< dig-val.length;i++)
		 {
		 val=pad1+val;
		 }
		 
		 }
		 return val;
	 }
	if(baby.discharge_docs.length>0)
	{
	alert("Discharge details alread entered");
	}
	else
	{
	display();
	var start_date="";
	var end_date="<%=sdf.format(new Date())%>";
	var survey = new Survey.Survey(dischargeForm);
	survey.render("mySurveyJSName");
	survey.onValidateQuestion.add(function(s,options)
	{
	if(options.name=="date_of_outcome")
	{
	if(gt1(baby.data.dob,options.value))
	{
	options.error="Outcome date  cannot be before date of birth";	
	}	
	var kmc_init_date=getKMCInitDate();
	if(kmc_init_date!=null)
	{
	if(gt1(kmc_init_date,options.value))
	options.error="Date of discharge cannot be before KMC Initiation date";
	}
	}	
	}
	);	
	survey.onComplete.add(function (s) 
	{	
	//survey.sendResult('daa498e6-8bca-4141-9fa1-5a0fe9045294');
	var data=s.data;
	data.unique_id='<%=request.getParameter("baby")%>';
	start_date=data.date_of_outcome;
	var tt=start_date.split("/");
	/* data.outcome_date1=tt[2]+"-"+tt[1]+"-"+tt[0]; */
	var date_of_disch = pad(tt[2],'0',2)+"-"+pad(tt[1],'0',2)+"-"+pad(tt[0],'0',2);
	data.outcome_date1 = date_of_disch;
	saveToServer(data);
	});
	}
	</script>
	<!--  button onclick='doKmc()' style="display:none" id="kmcBtn">Click here to enter KMC details</button><br>-->
</body>
</html>


