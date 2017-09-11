<%@page import="java.io.*,java.util.*,com.kentropy.kmc.process.*,com.kentropy.mongo.*"%>

<%
/*************config****************/
String taskpath="/task";
/*************************/
%>
<%
TaskList.init(session.getServletContext().getRealPath(taskpath)+"/");
String str="var tasks=";
		str+=TaskList.ja.toString();
		str+="";
		


%>

<div id="disp">
</div>
<script>
<%=str%>
function displayTasks()
{
var str="";
str="<table border=1>";
for(var i=0 ; i< tasks.length;i++)
{
var form=tasks[i].taskType+".jsp?task="+tasks[i].id+"";
str+="<tr><td>"+tasks[i].taskType+"</td><td>Mother:"+tasks[i].data.mother_name+"</td><td> Husband:"+tasks[i].data.husband_name+"</td><td> Dob:"+tasks[i].data.dob+"</td><td><a href='"+form+"'>Open</a></td></tr>"
}
str+="</table>";
disp.innerHTML=str;


}
displayTasks();
</script>