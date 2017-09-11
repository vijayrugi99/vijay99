<%@page import="java.io.*,java.util.*,com.kentropy.kmc.process.*,com.kentropy.mongodb.*,com.mongodb.util.JSON,java.text.*"%>
<html >
 <head>
	 <meta charset="utf-8" />
	    <meta name="viewport" content="width=device-width" />
	 
	 <!-- link href="https://dxsurvey.com/Content/css?v=j86S_phLMe_0xl-L4OfXYRSSGz6a6bxeCwsSUGvh3K41" rel="stylesheet"/-->
	 <link href="style2.css" rel="stylesheet">
	  <script src="ken-datefun.js"></script>
	 <script src="kmc_init.js"></script>
	<script src="koppal_villages.js"></script>
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
	var kmc="<%= kmccoll%>";
	console.log(kmc);
	//colId.value=new Date().toISOString();
	//colJSON.value=JSON.stringify(data);
	request.colId=new Date().toISOString();
	request.colJSON=JSON.stringify(data);
	request.collection=kmc;
	postForm(request,"saveJSON1.jsp");	
	//saveForm.submit();	
	}
	function doKmc()
	{
		//set the session storage value
		sessionStorage.setItem('filename', "KM_Pending_Details.jsp");
		
		console.log("doKMC");
		document.location.href="kmc-fi.jsp?baby=<%=request.getParameter("baby")%>&start_date="+start_date+"&end_date="+end_date;
	}
	function doDischarge()
	{
		//set the session storage value
		sessionStorage.setItem('filename', "KMC_Pending_Details.jsp");
		
		console.log("doDischarge")
		document.location.href="kmc-discharge-fi.jsp?baby=<%=request.getParameter("baby")%>";
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
	str+="<th>Sex</th><th>Birth Weight</tdh></tr></thead>";
	str+="<tbody><tr><td>"+fac+"</td><td>"+data.pid1+"<td>"+data.mother_name+"</td><td>"+data.husband_name+"</td>";
	str+="<td>"+data.dob+"</td><td>"+(data.sex==1?"M":"F")+"'"+"</td><td>"+data.birth_weight+"</td></tr></tbody>";
	str+="</table></div></div></div>";
	backgroundInfo.innerHTML=str;
	}
	</script>
	<script src="jquery.min.js"></script>
	<script>
	
	function postForm(request,url){
	    
	        $.post(url,
	       request,
	        function(data,status){
	            alert("Data saved successfully: " + data + "\nStatus: " + status);
	         //   localStorage.removeItem("data");
	           // save1.style.display="none";      
	            nxtBtn.style.display="block";
	           });
	    };
	
	</script>
	
	<div id="backgroundInfo">
	</div>
	<div id= "mySurveyJSName"   style1="background-color:#f0f0f0;"></div>
	<script>
	if(baby.comp_docs.length>0)
	{
	alert(" KMC already entered for the baby ");
	}
	else{
	display();
	var start_date="";
	var end_date="<%=sdf.format(new Date())%>";
	var survey = new Survey.Survey(kmcInitForm);
	survey.render("mySurveyJSName");
	survey.onValidateQuestion.add(function(s,options)
	{
	if(options.name=="date_of_kmc_initiation")
	{
	//alert(baby.data.dob+" " +options.value)
	
	if(gt1(baby.data.dob,options.value))
	{
	options.error="KMC Initiation date cannot be before date of birth";
	}
	}
	
	}
	);
	survey.onComplete.add(function (s) {
	
	
	//survey.sendResult('daa498e6-8bca-4141-9fa1-5a0fe9045294');
	var data=s.data;
	data.unique_id='<%=request.getParameter("baby")%>';
	if(data.kmc_initiation=="Initiated")
	{
	start_date=data.date_of_kmc_initiation;
	var tt=start_date.split("/");
	data.init_date1=tt[2]+"-"+tt[1]+"-"+tt[0];
	nxtBtn=kmcBtn;
	}
	else
	{
	nxtBtn=dischargeBtn;
	}
	
	saveToServer(data);
	});
	}	
	nxtBtn=null;
	</script>	
	<button onclick='doKmc()' style="display:none; margin-left:50px;" id="kmcBtn" class="btn btn-primary">Click here to enter KMC details</button><br>
	<button onclick='doDischarge()' style="display:none; margin-left:50px;" id="dischargeBtn" class="btn btn-primary">Click here to enter Discharge details</button><br>
</body>
</html>

