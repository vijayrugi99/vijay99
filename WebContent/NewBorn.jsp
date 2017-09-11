<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
 <link href="style2.css" rel="stylesheet">
 <script src="ken-datefun.js"></script>
<script src="koppal_villages.js"></script>
<script src="staff.js"></script>
<script src="facilities.js"></script>
<script src="inborn_listing.js"></script>
<script src="lbw_inborn.js"></script>
<script src="normal_inborn.js"></script>
<!-- script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js" ></script-->
<script src="knockout.js"></script>
<script src="survey.bootstrap.min.js"></script>
<script src="offline.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> <!-- link href="https://dxsurvey.com/Content/css?v=j86S_phLMe_0xl-L4OfXYRSSGz6a6bxeCwsSUGvh3K41" rel="stylesheet"/-->

<script>
var curSurveyType="";
function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x3|0x8)).toString(16);
    });
    return uuid;
};

function getCount(surveyType)
{
var count2=0;
for(var i=0;i< currentdata.length;i++)
{
if(currentdata[i].surveyType==surveyType)
{
count2++;
}
}
return count2;
}

function getName(arr,val)
{
for(var i=0; i< arr.length;i++)
{
if(arr[i].value==val)
return arr[i].text
}
return "";
}
function displayStatus()
{
facDiv.innerHTML=getName(facilities,facilitydata.facility);
fromDiv.innerHTML=dtstr;
 toDiv.innerHTML=dtstr1;
 BabyDiv.innerHTML=getCount("inborn_lbw")+"/"+facilitydata.no_below_2000;
BabyDiv1.innerHTML=""+getCount("inborn_normal")+"/"+remain;
BabyDiv2.innerHTML=""+getCount("outborn_lbw")+"/"+facilitydata.no_of_ob_lbws;

}
function handleSurveyEvent(evt)
{
console.log("Survey evt:"+evt);

curevent=evt;
saveState();
displayStatus()
if(evt==("start_inborn_list"))
{
//state="INBORN_LIST";

curSurveyType="inborn_list";
if(facilitydata.length==0 || facilitydata==null)
curdata={from_date:dtstr,to_date:dtstr1};
else
curdata=facilitydata;
console.log( "Curdata : "+curdata);
//startSurvey(survey1,curdata);
// start the inborn listing survey 
handleSurveyEvent("new_inborn_list");
return;
}
if(evt==("new_inborn_list"))
{
state="NEW_INBORN_LIST";

curSurveyType="inborn_list";
startSurvey(survey1,curdata);
// start the inborn listing survey 


return;
}
if(evt==("inborn_list_complete"))
{
saveState();
//state="INBORN_LIST_COMPLETE";
dtstr=facilitydata.from_date;
dtstr1=facilitydata.to_date;
handleSurveyEvent("start_inborn_lbw");
return;
}
else
if(evt==("start_inborn_lbw"))
{
state="BABY_LIST";
//BabyDiv.innerHTML=count+"/"+facilitydata.no_below_2000;
//currentdata=inborndata;
if( count < facilitydata.no_below_2000) 
{
handleSurveyEvent("new_inborn_lbw");;
}
else handleSurveyEvent("start_inborn_normal");

}
else
if(evt==("new_inborn_lbw"))
{
state="NEW_INBORN_LBW";
curSurveyType="inborn_lbw";
curdata={dob:dtstr,unique_id:generateUUID()};
startSurvey(survey2,curdata);
// start the inborn lbw survey
}
else
if(evt==("inborn_lbw_complete"))
{
state="NEW_INBOEN_LBW_COMPLETE";
//BabyDiv.innerHTML=count+"/"+facilitydata.no_below_2000;
if(count<facilitydata.no_below_2000)
{
 handleSurveyEvent("new_inborn_lbw");;
}
else handleSurveyEvent("start_inborn_normal");
}
else
if(evt==("start_inborn_normal"))
{
state="INBORNORMAL";

remain = prompt("How many babies in the range of >=2000  do you have data for?", ""+(facilitydata.no_of_babies-facilitydata.still_births-facilitydata.no_below_2000));
 if(remain !=null && remain>0)
 {
 curdata={dob:dtstr,unique_id:generateUUID()};
 fromDiv.innerHTML=dtstr;
 toDiv.innerHTML=dtstr1;
//BabyDiv1.innerHTML=""+(count-facilitydata.no_below_2000)+"/"+remain;
  handleSurveyEvent("new_inborn_normal");
  
  
  }
  else handleSurveyEvent("start_outborn_lbw");

// get normal count;;
//if(>0)handleSurveyEvent("new_inborn_normal")elsehandleSurveyEvent("start_outborn_lbw");
}
else
if(evt==("new_inborn_normal"))
{
// start the normal survey
curSurveyType="inborn_normal";
 survey3.getQuestionByName("birth_weight").validators[0].maxValue=5000;
  survey3.getQuestionByName("birth_weight").validators[0].minValue=2000;
  survey3.title="Details of babies >=2000 gm";
 startSurvey(survey3,curdata);// survey3
}
else
if(evt==("inborn_normal_complete"))
{

//fromDiv.innerHTML=dtstr;
 //toDiv.innerHTML=dtstr1;
//BabyDiv1.innerHTML=""+(count-facilitydata.no_below_2000)+"/"+remain;

if (count < (facilitydata.no_below_2000+parseInt(remain))) 
{
 curdata={dob:dtstr,unique_id:generateUUID()};
handleSurveyEvent("new_inborn_normal");;
}
else handleSurveyEvent("start_outborn_lbw");
}
else
if(evt==("start_outborn_lbw"))
{
// get outborn lbw count;;set the count
var ob=prompt("How many Outborn lbw babies (in the range of <2000)?", ""+0);
 //= prompt("How many Outborn lbw babies (in the range of <2000)?", ""+0);
 if(ob!=null && ob>0)
 {
 facilitydata.no_of_ob_lbws=parseInt(ob);

 curdata={dob:dtstr,unique_id:generateUUID()};
  handleSurveyEvent("new_outborn_lbw");
  
  }
  else
  {
  facilitydata.no_of_ob_lbws=0;
   handleSurveyEvent("survey_complete");
   }
}

else
if(evt==("new_outborn_lbw"))
{
//fromDiv.innerHTML=dtstr;
 //toDiv.innerHTML=dtstr1;
//BabyDiv2.innerHTML=""+(count-facilitydata.no_below_2000-remain)+"/"+facilitydata.no_of_ob_lbws;
curSurveyType="outborn_lbw";
// start the outborn lbw survey
survey2.getQuestionByName("birth_weight").validators[0].maxValue=1999;
 //survey2.getQuestionByName("no_of_deliveries").title="No of admissions";
  survey2.getQuestionByName("birth_weight").validators[0].minValue=1;
  survey2.title="Details of outborn lbws <2000 gm";
startSurvey(survey2,curdata)
}

else
if(evt==("outborn_lbw_complete"))
{
//fromDiv.innerHTML=dtstr;
 //toDiv.innerHTML=dtstr1;
//BabyDiv2.innerHTML=""+(count-facilitydata.no_below_2000-remain)+"/"+facilitydata.no_of_ob_lbws;
 if (count < (facilitydata.no_of_ob_lbws+facilitydata.no_below_2000+parseInt(remain))) 
 {
  curdata={dob:dtstr,unique_id:generateUUID()};
 handleSurveyEvent("new_outborn_lbw");;
 }
else
handleSurveyEvent("survey_complete");

}
else
if(evt==("survey_complete"))
{
fromDiv.innerHTML=dtstr;
 toDiv.innerHTML=dtstr1;
//display save button
save1.style.display="block";
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
</script>
<script src="jquery.min.js"></script>
<script>
function postForm(request,url){
    
        $.post(url,
       request,
        function(data,status){
            alert("Data saved successfully: \nStatus: " + status);
            localStorage.removeItem("data");
            data=[];
            reset();
            save1.style.display="none";
            window.location.href="NewBorn.jsp";
            });
    };

</script>
<script>
function check(){
Offline.check();//console.log(Offline.state),setTimeout(check,1000)
}


window.addEventListener("offline", function(e) {
  alert("offline");
}, false);

window.addEventListener("online", function(e) {
  alert("online");
}, false);
var offline=false;
window.addEventListener('load', function(e) {
//setTimeout( check,1000);
Offline.on("up",handleChange);
Offline.on("down",handleChange);
init();
  window.applicationCache.addEventListener('updateready', function(e) {
    if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
      // Browser downloaded a new app cache.
      if (confirm('A new version of this site is available. Load it?')) {
        window.location.reload();
      }
    } else {
      // Manifest didn't changed. Nothing new to server.
    }
  }, false);
  window.applicationCache.addEventListener("error", function(e) {
  alert("Error fetching manifest: a good chance we are offline");
  offline=true;
});
//setTimeout(checkLocal,2000);
}, false);

function checkLocal() 
{
if(localStorage.getItem("data") !=null)
{
data=localStorage.getItem("data");

if(!offline)
{


if(data!=null )
{
alert(" Locally stored data found . Trying to upload"+(data));
data=eval(data);
//localStorage.removeItem("data");
saveToServer(data);

}
}
else{
alert(" Saved local data found. Please go online to upload it");
document.write("Refresh to continue");

}

}
}
//var offline=false;

</script>

</head>
<body  style="padding-top:20px;padding-left:10px">
<%@include file="home.jsp" %>
<%@include file="Config.jsp" %>
<div class= "container">		 
<form method="POST" class="form-inline">
<h4 style="color:brown">Facility lbws Listing for <span id="facDiv"></span>from <span id="fromDiv"> </span> to <span id="toDiv"></span></h4>
<div class="form-group">							
	<label style="display:none;">No of LBWS  For facility:</label>	
	<span style="display:none;" id="FacilityListDiv"></span>			
</div>
<div class="form-group col-sm-4">							
	<label style="color:#6495ED;">No of Inborn <2000 Completed:</label>	
	<span id="BabyDiv">0</span>	
</div>	
<div class="form-group col-sm-3">
	<label style="color:#6495ED;">No of Inborn >=2000 Completed:</label>	
	<span id="BabyDiv1">0</span>	
</div>
<div class="form-group col-sm-4">
	<label style="color:#6495ED;">No of Outborn <2000 Completed:</label>	
	<span id="BabyDiv2">0</span>			
</div>
<br />																					
</form>		 
</div>

<div id= "mySurveyJSName"   style1="background-color:#f0f0f0;"></div>

<script>

/*******************************************************************************************************************************************/

/*************/
 var survey1= new Survey.Survey(listsurvey);
var survey2=new Survey.Survey(babysurvey);
var survey3=new Survey.Survey(babysurvey1);
survey2.onValueChanged.add(function (s, options) {

 if (options.name == 'taluk_from')  {
 setCommunityPlaces(options.value-1,0);
 survey2.getQuestionByName("community_from").choicesValues=community_places_from;
 survey2.render();
 //console.log();
 //console.log(community_places_from);
 }
  if (options.name == 'taluk_to')  {
 setCommunityPlaces(options.value-1,1);
 survey2.getQuestionByName("community_to").choicesValues=community_places_to;
 survey2.render();
 
 }

}
);
var dt = new Date();
var dtstr1= dt.getDate()+"/"+(dt.getMonth()+1)+"/"+(1900+dt.getYear());
dt.setDate(dt.getDate()-1);
var dtstr= dt.getDate()+"/"+(dt.getMonth()+1)+"/"+(1900+dt.getYear());


console.log(dtstr);


survey1.onValidateQuestion.add(function (s, options) {
//alert(JSON.stringify(options));

       if (options.name == 'to_date' )
       {
      var frm_date= survey1.getValue("from_date");
      var to_date=options.value;
console.log(frm_date+" "+to_date);
      if(!gt1(to_date,frm_date))
      {
      options.error="To Date has to be greater than from date";
      }
       } 
        
    if (options.name == 'no_of_lbws' ) {
        var births = survey1.getValue('no_of_babies');
        
         var sb = survey1.getValue('still_births');
         if(isNaN(sb))
         sb=0;
    //  alert(births);
      
                if(options.value > births-sb) {
                    options.error = "The 'Lbws ' should be less than or equal to 'No of babies'-'Still births'.";
                }
            }   
            
                
    if (options.name == 'gt_24ga' ||  options.name == 'still_births') {
        var births = survey1.getValue('no_of_babies');
    //  alert(births);
      
                if(options.value > births) {
                    options.error = " Should be less than or equal to 'No of babies'.";
                }
            }   
        
      var still_births=survey1.getValue('still_births');
 if (options.name == 'no_below_2000') {
        var lbws = survey1.getValue('no_of_lbws');
      var still_births=survey1.getValue('still_births');
      
                if(options.value > lbws) {
                    options.error = "The 'Lbws < 2000 ' should be less than or equal to  'No of LBWs'.";
                }
            }   
        
    
    
});

survey2.onValidateQuestion.add(function (s, options) {

if (options.name == 'dob') {
//alert(date_3m_back);
var flg=checkDateRange(options.value,date_3m_back,today);

if(flg==false)
options.error="Date should be lesser than or equal to today and within the past 3 months";
}

});

var facilitydata=[];
//var inborndata=[];
//var outborndata=[];
var currentdata=[];

var state="NotStarted";
var curevent="start_inborn_list";
var curdata=null;

var count=0;
var count1=0;
var remain=0;
function saveState()
{
var statedata={curSurveyType:curSurveyType,state:state,curevent:curevent,curdata:curdata,facilitydata:facilitydata,currentdata:currentdata,count:count,remain:remain,count1:count};
localStorage.setItem("statedata",JSON.stringify(statedata));
}
function readState(statedata)
{
state=statedata.state;
curSurveyType=statedata.curSurveyType;
curevent=statedata.curevent;
curdata=statedata.curdata;
facilitydata=statedata.facilitydata;
currentdata=statedata.currentdata;
count=statedata.count;
count1=statedata.count1;
remain=statedata.remain;

}
function reset()
{
localStorage.removeItem("statedata");
this.location.href=this.location.href;
}
function resetByUser()
{
if(confirm("Do you want to reset the data?"))
{
reset();
}
}


function init()
{
var statedataStr=localStorage.getItem("statedata");
if(statedataStr!=null)
{
var statedata=JSON.parse(statedataStr);
readState(statedata);
}
handleSurveyEvent(curevent);
}


survey1.onComplete.add(function (s) {

//alert("The results are:" + JSON.stringify(s.data));

facilitydata=s.data;
//dispdata();
facilitydata.no_of_lbws=parseInt(facilitydata.no_of_lbws);
facilitydata.no_below_2000=parseInt(facilitydata.no_below_2000);
facilitydata.from1=toDate(facilitydata.from_date);
facilitydata.to1=toDate(facilitydata.to_date);



survey1.sendResult('9199261f-037b-46d4-ab4a-6e5535da52de');
//BabyDiv.innerHTML=count+"/"+facilitydata.no_below_2000;
handleSurveyEvent(curSurveyType+"_complete");

 });
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

function toDate(str)
{
var dt=str.split("/");
var dt1=pad(dt[2],'0',2)+"-"+pad(dt[1],'0',2)+"-"+pad(dt[0],'0',2);
return dt1;
}
survey2.onComplete.add(function (s) {


//survey.sendResult('daa498e6-8bca-4141-9fa1-5a0fe9045294');
var data=s.data;
data.surveyType=curSurveyType;
var dob=data.dob.split("/");
var dob1=pad(dob[2],'0',2)+"-"+pad(dob[1],'0',2)+"-"+pad(dob[0],'0',2);
data.dob1=dob1;
//alert("The results are:" + JSON.stringify(data))+" "+count;
currentdata.push(data);
//dispdata();
count++;
	//BabyDiv.innerHTML=""+count+"/"+facilitydata.no_below_2000;

survey2.sendResult('319d06e2-4288-4528-b8c1-31c83b741749');
handleSurveyEvent(curSurveyType+"_complete");


 });
 survey3.onComplete.add(function (s) {


//survey.sendResult('daa498e6-8bca-4141-9fa1-5a0fe9045294');
var data=s.data;
data.surveyType=curSurveyType;
//alert("The results are:" + JSON.stringify(data))+" "+count;
var dob=data.dob.split("/");
var dob1=pad(dob[2],'0',2)+"-"+pad(dob[1],'0',2)+"-"+pad(dob[0],'0',2);
data.dob1=dob1;
currentdata.push(data);
//dispdata();
count++;
	//BabyDiv.innerHTML=""+count+"/"+facilitydata.no_below_2000;

survey3.sendResult('7b73927c-64f4-4a1e-b955-ced67af558cb');
handleSurveyEvent(curSurveyType+"_complete");


 });
 

function startSurvey(survey,data1)
{
console.log(data1);
survey.clear();
survey.data=data1;

survey.render("mySurveyJSName");


}
var today=new Date();
var date_3m_back= new Date();
date_3m_back.setMonth(today.getMonth()-3);

function checkDateRange(val,dt1,dt2)
{
var tt=val.split("/");
var val1=new Date(tt[2],tt[1]-1,tt[0]);
//alert(val1);

return val1>=dt1 && val1 <=dt2
}
function dispdata()
{
var str="<UL>";
for(var i=0; i< data.length;i++)
{
str+="<LI>"+data[i].mother_name+" LBWS:"+data[i].no_of_lbws;
}
str+="</UL>";
Mothers.innerHTML=str;
}
var data=[];
//init();

//handleSurveyEvent(curevent);
//startSurvey(survey1,{});
//var data=[];
function save()
{
data=[];
data.push(facilitydata);
//data.push(inborndata);
//data.push(outborndata);
data.push(currentdata);
if(offline)
{
alert("The systen is oofline Try again later .status"+offline);

}

//saveLocally(data);
if(!offline)
{
save1.disabled=true;
saveToServer(data);

}

}
function saveLocally(data)
{
alert("Saving locally");
localStorage.setItem("data", JSON.stringify(data));
save1.style.display="none";
// Retrieve
//document.getElementById("result").innerHTML = JSON.stringify(localStorage.getItem("data"));
}
function saveToServer(data)
{

var request={};
var coll="<%= coll%>";
console.log(coll);
//colId.value=new Date().toISOString();
//colJSON.value=JSON.stringify(data);
request.colId=new Date().toISOString();
request.colJSON=JSON.stringify(data);
/*request.collection="test";*/
request.collection=coll;
request.details="Inserted new baby";
postForm(request,"saveJSON.jsp");

//saveForm.submit();


}
</script>
<form id="saveForm" action="saveJSON.jsp" style="display:none">
<input type=text id="colId" name="colId">
<input type=text id="collection" name="collection" value="test">
<input type=text id=colJSON name="colJSON">
</form>
<input type=button id="save1" value="Save to Server" onclick="save()" style="display:none">
<input type=button id="upload" value="upload" onclick="save()" style="display:none">
<br />
<button type=button id="resetBtn" class="btn btn-primary" onclick="resetByUser()" style="margin-left:13px">Reset Data</button>
</body >
</html>
