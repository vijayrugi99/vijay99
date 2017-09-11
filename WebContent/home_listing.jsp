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
		<script src="ken-datefun.js"></script>
		<script src="koppal_villages.js"></script>
		<script src="staff.js"></script>
		<script src="facilities.js"></script>
		 <script src="homeborn_listing.js"></script>
		<!-- script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js" ></script-->
		<script src="knockout.js"></script>
		<script src="survey.bootstrap.min.js"></script>
		<script src="offline.min.js"></script>
	</head>
	<body>
		<%@ include file="Config.jsp" %>
		
		<script>
		var bw_rates=[.01,0.015];
		function parseDate(str) {
    var mdy = str.split('/');
    return new Date(mdy[2], mdy[1]-1, mdy[0]);
}

function daydiff(first, second) {
    return Math.round((second-first)/(1000*60*60*24));
}
		
		
		var enteredDates=[];
		function init()
		{
			var dts=[];
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
			var kmc="homeborn";
			//colId.value=new Date().toISOString();
			//colJSON.value=JSON.stringify(data);
			request.colId=new Date().toISOString();
			request.colJSON=JSON.stringify(data);
			request.collection=kmc;
                        request.details="Inserted Home Born Baby";
			postForm(request,"saveJSON1.jsp");
			//saveForm.submit();
		}
		var dtidx=0;
		function display()
		{
		
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
			//display();
			function startSurvey()
			{
		
			survey.clear();			
				survey.data={start_date:dtstr};
			survey.render("mySurveyJSName");			
			}
			var survey = new Survey.Survey(homeborn_listing);
		//	survey.render("mySurveyJSName");
			survey.onValueChanged.add(function (s, options) {

 if (options.name == 'taluk_from')  {
 setCommunityPlaces(options.value-1,0);
 survey.getQuestionByName("community_from").choicesValues=community_places_from;
 survey.render();
  }
  if (options.name == 'taluk_to')  {
 setCommunityPlaces(options.value-1,1);
 survey.getQuestionByName("community_to").choicesValues=community_places_to;
 survey.render();
 
 }

}
);
			survey.onValidateQuestion.add(function (s, options) {
	   var today= dtstr;		
			 if (options.name == 'dob' )
       {
   
      var dob=options.value;
console.log(dob+" "+today);
      if(gt1(dob,today))
      {
      options.error="Date of birth cannot  greater than today";
      }
       } 
       		 if (options.name == 'babyweight_date' )
       {
      var dob= survey.getValue("dob");
      var bwdate=options.value;
console.log(bwdate+" "+dob+" "+today);
      if(gt1(bwdate,today))
      {
      options.error="Birth weight date cannot  greater than today";
      }
         if(gt1(dob,bwdate))
      {
      options.error="Birth weight date cannot  lesser than Date of birth";
      }
       }
        
	    	
		    
		    
		    });
		

function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x3|0x8)).toString(16);
    });
    return uuid;
};
		    var dt = new Date();
var dtstr= dt.getDate()+"/"+(dt.getMonth()+1)+"/"+(1900+dt.getYear());
		   // var  discharge=false;
		    //init();
			survey.onComplete.add(function (s) 
			{
				//survey.sendResult('daa498e6-8bca-4141-9fa1-5a0fe9045294');
				var data=s.data;
				data.unique_id=generateUUID();
				data.surveyType='homeborn_listing';
				
				var diff=daydiff(parseDate(data.dob),parseDate(data.birthweight_date) );
				console.log(diff);
				console.log("before baby_weight"+data.baby_weight);
				console.log("before birth_weight"+data.birth_weight);
				
				var diff2= 0;
				if(diff<10)
				{
				if(data.baby_weight>=2000)
				{
				diff2=diff*.01;
				if(diff>5)
				diff2=5*.01-(diff-5)*.01;
				}
				else
				{
				diff2=diff*.015;
				if(diff>7)
				diff2=7*.015-(diff-7)*.015;;
				}
				
				data.birth_weight=data.baby_weight*(1+diff2);
				}
				else
				data.birth_weight=-1;
				console.log("data"+data);
				console.log("birth_weight"+data.birth_weight);
				saveToServer(data);
			});
			startSurvey();
		</script>
	</body>	
</html>




