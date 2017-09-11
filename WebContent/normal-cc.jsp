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
		 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  			<link rel="stylesheet" href="Responsive_Style.css">
		 <script src="normal-cc.js"></script>
		<script src="koppal_villages.js"></script>
		<script src="staff.js"></script>
		<script src="facilities.js"></script>
		<!-- script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js" ></script-->
		<script src="knockout.js"></script>
		<script src="survey.bootstrap.min.js"></script>
		<script src="offline.min.js"></script>
	</head>
	<body>
		<%@ include file="Config.jsp" %>
		
		<script>
		<%
			ArrayList<DBObject> dbos= new MongoDAO(db,coll).getBaby1(request.getParameter("baby"));
			DBObject dbo=dbos.get(0);
			Date callDate = new Date();
			SimpleDateFormat sdf =new SimpleDateFormat("dd/MM/yyyy");
			Date start= sdf.parse(request.getParameter("start_date"));
			String Name = request.getParameter("calledTo");// change to called to name
			String type = request.getParameter("type");
			String phone = request.getParameter("cph");
			 String callerName = null;
			String role = null; 
			if((String)session.getAttribute("username") == null || (String)session.getAttribute("role") == null){
				 callerName = null;
				role = null; 
			 
			 }
			else
			{
				 callerName = (String)session.getAttribute("username");
				 role=(String)session.getAttribute("role");
				
			}
			String kmcPeriod=request.getParameter("kmcPeriod");
			out.println("var start='"+sdf.format(start)+"';");	
		%>
		var baby=<%=JSON.serialize(dbo)%>;
		var enteredDates=[];
		function init()
		{
			var dts=[];
			for(var i=0; i< baby.comp_docs.length;i++)
			{
				if(baby.comp_docs.surveyType==null || baby.comp_docs.surveyType!="kmc_details_cc")
				{		
					dts.push(baby.comp_docs[i].date_of_kmc_initiation);
					break;
				}
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
			var kmc="<%= kmccoll%>";
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
				str+="<thead><tr><th>Facility</th><th>IP number</th><th>Mother</th><th>Father</th><th>DOB</th>";
				str+="<th>Sex</th><th>Birth Weight</th><th>Event</th></tr></thead>";
				str+="<tbody><tr><td>"+fac+"</td><td>"+data.pid1+"<td>"+data.mother_name+"</td><td>"+data.husband_name+"</td>";
				str+="<td>"+data.dob+"</td><td>"+(data.sex==1?"M":"F")+"'"+"</td><td>"+data.birth_weight+"</td><td>"+<%=kmcPeriod%>+"</td></tr>";
				str+="</tbody></table>";
				str+="</div></div></div>";
				backgroundInfo.innerHTML=str;
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
		        	/* //get session storage value
		        	var filename = sessionStorage.getItem('filename');
		        	// Remove saved data from sessionStorage
		        	sessionStorage.removeItem('filename');
		        	// Remove all saved data from sessionStorage
		        	sessionStorage.clear(); */
		        	
		            alert("Data saved successfully: \nStatus: " + status);
		         //   localStorage.removeItem("data");
		           // save1.style.display="none";    
		           dtidx++;		          
		           sessionStorage.setItem('auto-refresh', 'YES');
		           window.history.go(-1);
		     
		        //   startSurvey();	           
		           });
		    };	
		</script>
	
		<div id="backgroundInfo"></div>
		<div id= "mySurveyJSName" style1="background-color:#f0f0f0;"></div>
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
			/*if(discharge==true)
			{
				document.location.href="kmc-discharge-fi.jsp?baby=<%=request.getParameter("baby")%>";
			
			}
			else
			{
			*/
			survey.clear();			
				survey.data={visit_date:start,kmc_period:"<%=kmcPeriod%>"};
			survey.render("mySurveyJSName");			
			}
			var survey = new Survey.Survey(normalCCForm);
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
			survey.onComplete.add(function (s) 
			{
				//survey.sendResult('daa498e6-8bca-4141-9fa1-5a0fe9045294');
				var data=s.data;
				data.unique_id='<%=request.getParameter("baby")%>';
				data.surveyType='kmc_details_cc';
				data.visitDate='<%=start%>';	
				data.callDate='<%=callDate%>';
				data.callerName='<%=callerName%>';
				data.Name='<%=Name%>';
				data.phone='<%=phone%>';
				data.role='<%=role%>';
				data.type='<%=type%>';
				saveToServer(data);
			});
			startSurvey();
		</script>
	</body>	
</html>




