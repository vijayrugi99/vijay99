<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv=”Pragma” content=”no-cache”>
	<meta http-equiv=”Expires” content=”-1?>
	<meta http-equiv=”CACHE-CONTROL” content=”NO-CACHE”>
<title>New Facility</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="snackbar.css">
    <script src="facilities.js">	</script>
	<script src="taluks.js">	</script>
	<script src="koppal_villages.js"></script>
	<script src="ken_kmc_html.js"></script>
	<script>
function fun()
{
var src='${pageContext.request.contextPath}/facilities.js';
//alert(src);
}

</script>
	<script>
	   	function onChange(index)
	   	{	
	   		var taluk=taluks;
	   		var talArr = [];
	   		var selected = "";
	   		var len1=0;
	   		var dist = '<%= request.getParameter("selDist")%>';
	   		var facint = parseInt(dist);
	   		var st="<label style=\"font-size:20px; color:blue\"> Taluk:</label>";
	   		st+="<select name=\"taluk\" id=\"taluk\" class=\"form-control\" style=\"padding:3px;\">";
	   		selected = "";
		   	 	for(i=0;i<taluk.length;i++)
			   	{	
		   		 	if(taluk[i].district==index)
		   			 {
		   			  st+="<option "+selected+" value="+taluk[i].value+">"+taluk[i].text+"</option>";
		   			 } 	   		 	
			   	}
	   	      	st+="</select>";
			  	sf.innerHTML=st;
	   		document.getElementById("hiddenField").value=talArr;
	   		var hiddenvalue=document.getElementById("hiddenField").value;
	   		//console.log(hiddenvalue);
	   	} 
   	</script>
</head>
<body>
<%
String  selDist=request.getParameter("selDist");
System.out.println("taluk-"+selDist);

%>
<div class="container" align="center">
<form action="AddNewFacility.jsp" method="get" class="form-inline">
	<h1 style = "color:brown"> Add New Facility </h1>
<div class="form-group">
			<div id="filters1"></div>
			<script>
				var filterStr= DropdownOnchange(sel_dist,"<%=selDist%>");				
				filters1.innerHTML=filterStr;
			</script>
			</div>
			<div class="form-group">
			<div id="sf"><label style="font-size:20px; color:blue"> Taluk:</label>
			<select>
			<option value=""></option>
			</select>
			</div>
		</div>&nbsp;
			<label style="font-size:20px; color:blue"> Enter New Facility Name:</label><input type="text" name="facility">
		 
		 <button type="submit" class="btn btn-primary">Submit</button>
		 </form>	
		 </div>
<%
String dist = request.getParameter("selDist");
System.out.println("dist-"+dist);
String taluk = request.getParameter("taluk");
System.out.println("taluk-"+taluk);
String fac = request.getParameter("facility");
System.out.println("fac-"+fac);
//String query=fac.trim();
//System.out.println("after trim-"+query);
if(fac!=null){
%>
<script>
var str = '<%=fac%>';
var exist=0;
//alert("str="+str);
alert("Hi")
var faci=facilities;
var len = faci.length;
alert(len)

//alert("len+"+len);
var last=(faci[len-1].value)+1;
alert("last--"+last);

for(var i=0;i<faci.length;i++){
	
	var var1=faci[i].text.toUpperCase();
	var var2=str.toUpperCase();
	var areEqual=var1.includes(var2);
	
     if(areEqual==true)
    	 {
    	 alert("areEqual="+areEqual)
			exist=1;    	   	 
	     }
	}
if(exist==0)
	{
       window.location.href="addFacility.jsp?dist=<%=dist%>&tq=<%=taluk%>&value="+last+"&faci="+str;
	}
else
	{
			alert("Facility already exists")	
	}

	/* if(str != faci[i].text){
		alert("this is really new facility... ");
		alert(last++);
		
	}
	else{
		alert("facility u entereed is already exist... ");
	} */


</script>
<%
} 
%>
		 
</body>
</html>