<%@page import="java.io.*,java.util.*,com.kentropy.kmc.process.*,com.kentropy.mongodb.*,com.mongodb.util.JSON,com.mongodb.*,java.text.*"%>

<%!
	public Vector<Date> getDateRange(Date start,Date end)
	{
	Vector<Date> v  = new Vector<Date>();
	Calendar cal=Calendar.getInstance();
	cal.setTime(start);
	Date tmp=start;
	v.add(start);
	while(end.after(tmp))
	{
	cal.add(Calendar.DATE,1);
	tmp=cal.getTime();
	if(tmp.before(end) && !tmp.equals(end))
	v.add(tmp);
	}
	return v;
	}
%>
<html >
 <head>
	 <meta charset="utf-8" />
	    <meta name="viewport" content="width=device-width" />	 
	 <!-- link href="https://dxsurvey.com/Content/css?v=j86S_phLMe_0xl-L4OfXYRSSGz6a6bxeCwsSUGvh3K41" rel="stylesheet"/-->
	 <link href="style2.css" rel="stylesheet">
	 <script src="kmc-fi.js"></script>
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
		ArrayList<DBObject> dbos= new MongoDAO(db,coll).getBaby1(request.getParameter("baby"));
		DBObject dbo=dbos.get(0);
		SimpleDateFormat sdf =new SimpleDateFormat("dd/MM/yyyy");
		Date start= sdf.parse(request.getParameter("start_date"));
		Date end= sdf.parse(request.getParameter("end_date"));
		Vector<Date> v= getDateRange(start,end);
		out.println("var kmc_dates=[");
		for(Date dt : v)
		{
		out.println("'"+sdf.format(dt)+"',");
		}
		out.println("];");
	%>
	
	var baby=<%=JSON.serialize(dbo)%>;
	var enteredDates=[];
	function init()
	{
	var dts=[];
	for(var i=0; i< baby.comp_docs.length;i++)
	{
	if(baby.comp_docs.surveyType==null || baby.comp_docs.surveyType!="kmc_details")
	{
	continue;
	}
	else
	dts.push(comp_docs[i].date_of_kmc_initiation);
	}
	var dts2=[];
	for(var i=0; i<kmc_dates.length;i++)
	{
	if(dts.indexOf(kmc_dates[i])!=null)
	{
	dts2.push(kmc_dates[i]);
	}
	}
	kmc_dates=dts2;
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
	var dtidx=0;
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
		str+="<th>Sex</th><th>Birth Weight</th></tr></thead>";
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
	           dtidx++;
	           startSurvey();
	           
	           });
	    };	
	</script>
	
	<div id="backgroundInfo">
	</div>
	<div id= "mySurveyJSName"   style1="background-color:#f0f0f0;"></div>
	<script>
	function gt(one ,two)
	{
	console.log(Date.parse(one)+" "+one);
	console.log(Date.parse(two)+" "+two);
	return Date.parse(one)>Date.parse(two)
	}
	display();
	function startSurvey()
	{
	if(discharge==true)
	{
	document.location.href="kmc-discharge-fi.jsp?baby=<%=request.getParameter("baby")%>";
	
	}
	else{
	survey.clear();
		
		if(dtidx<kmc_dates.length)
		{
		survey.data={date:kmc_dates[dtidx]};
	survey.render("mySurveyJSName");
		}   
		else
		mySurveyJSName.innerHTML="<h2 style=\"margin-left:50px;\">KMC details up to date</h2>";
		}
	}
	var survey = new Survey.Survey(kmcFiForm);
	//survey.render("mySurveyJSName");
	survey.onValidateQuestion.add(function (s, options) {
	//alert(JSON.stringify(options));
	
	      
	        
	    if (options.name == 'kmc_time_slots_today' ) {
	  var arr=  survey.getValue('kmc_time_slots_today')
	    console.log(survey.getValue('kmc_time_slots_today'));
	    for(var i=0; i< arr.length;i++)
	    {
	    var rowStr="Row "+(i+1)+":";
	    var from = arr[i].from;
	     var fromMeridian=arr[i].from_meridian;
	    var to = arr[i].to;
	    var toMeridian=arr[i].to_meridian;
		
	    if(from ==null)
	    {
	    options.error=rowStr+" From time not entered";
	    return;
	    
	    }
	     if(to ==null)
	    {
	    options.error=rowStr+" To time not entered";
	    return;
	    
	    }
	    
	    
	    var tregex=new RegExp("^([0-9]|0[0-9]|1[0-2]):[0-5][0-9]$");
	    if(tregex.test(from)!=true)
	    {
	    options.error=rowStr+" From time should be in the hh:mm format";
	    return;
	    }
	    if(tregex.test(to)!=true)
	    {
	    options.error=rowStr+" To time should be in the hh:mm format";
	    return;
	    }
	    
	    var from_hr=parseInt(from.split(":")[0]);
	    var from_dt=from_hr>=8?"1/1/2016 ":"1/2/2016 ";
	    var to_hr=parseInt(to.split(":")[0]);
	    var to_dt=to_hr>=8?"1/1/2016 ":"1/2/2016 ";
	    
	       if(gt(from_dt+" "+from+" "+fromMeridian,to_dt+ " "+to+" "+toMeridian))
		    {
		    options.error=rowStr+" From time cannot be greater than to time";
		    return;
		    }
	    }
	    
	    }
	    });
	   var  discharge=false;
	   init();
	survey.onComplete.add(function (s) {
	
	
	//survey.sendResult('daa498e6-8bca-4141-9fa1-5a0fe9045294');
	var data=s.data;
	data.unique_id='<%=request.getParameter("baby")%>';
	data.surveyType='kmc_details';
	if(data.discharged!=null && data.discharged[0]=='discharged')
	{
	discharge=true;
	}
	saveToServer(data);
	});
	startSurvey();
	</script>
</body>
</html>




