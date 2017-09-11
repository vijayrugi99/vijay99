<%@page import="java.io.*,java.util.*,com.kentropy.kmc.process.*,com.kentropy.mongo.*"%>
<html >
 <head>
 <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
 
 <!-- link href="https://dxsurvey.com/Content/css?v=j86S_phLMe_0xl-L4OfXYRSSGz6a6bxeCwsSUGvh3K41" rel="stylesheet"/-->
 <link href="style2.css" rel="stylesheet">
 <script src="kmc.js"></script>
<script src="koppal_villages.js"></script>
<script src="staff.js"></script>
<script src="facilities.js"></script>
<!-- script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js" ></script-->
<script src="knockout.js"></script>
<script src="survey.bootstrap.min.js"></script>
<script src="offline.min.js"></script>
<script>
var task=<%=TaskList.getTaskById(request.getParameter("task")).toString()%>;

function handleChange()
{
alert(Offline.state);
/*if(offline.state=="up")
offline=false
else
offline=true;*/
}

function display()
{
var fac="";
console.log(facilities)
for(var i=0; i< facilities.length;i++)
{
if(facilities[i].value==task.facility)
{
fac=facilities[i].text;
break;
}
}
var str="<table width=80% border=1>"
str+="<tr><td>Facility</td><td>Mother</td><td>Father</td><td>DOB</td></tr>";
str+="<tr><td>"+fac+"</td><td>"+task.data.mother_name+"</td><td>"+task.data.husband_name+"</td><td>"+task.data.dob+"</td></tr>";
str+="</table>";
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
            localStorage.removeItem("data");
            save1.style.display="none";       });
    };

</script>

<div id="backgroundInfo">
</div>
<div id= "mySurveyJSName"   style1="background-color:#f0f0f0;"></div>
<script>
display();
var survey = new Survey.Survey(kmc1Form);
survey.render("mySurveyJSName");
</script>




