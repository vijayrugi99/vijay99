<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Staff</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="snackbar.css">
    <script src="facilities.js">	</script>
	<script src="taluks.js">	</script>
	<script src="koppal_villages.js"></script>
	<script src="ken_kmc_html.js"></script>
	<script src="staff.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/index.js"></script>
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
<form action="AddNewStaff.jsp" method="get" class="form-inline">
	<h1 style = "color:brown"> Add New NurseMentor </h1>
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
			<label style="font-size:20px; color:blue"> Enter New NurseMentor Name:</label><input type="text" name="staff">
		 <div class="form-group">
		 <button type="submit" class="btn btn-primary">Submit</button>
		 </div>
		 </form>	
		 </div>
<%
String dist = request.getParameter("selDist");
System.out.println("dist-"+dist);
String taluk = request.getParameter("taluk");
System.out.println("taluk-"+taluk);
String staff = request.getParameter("staff");
System.out.println("fac-"+staff);
JSONObject obj=new JSONObject();
//String query=fac.trim();
//System.out.println("after trim-"+query);
if(staff!=null){
%>
<script>
alert("chumma");
var str = '<%=staff%>';
alert(str);
alert("str");
 var nm = nms;
var len=nm.length;
alert("len-"+nm.length);
var last = nm[len-1].value;
alert("last--"+last);
var JSONObj = nms;
for(var i=0;i<nm.length;i++){
	if(str != nm[i].text){
		//alert("this is really new facility... ");
		// create new nurse mentor object here...
		var obj={};
		var ln=len++;
		JSONObj[ln].value=last++;
		JSONObj[ln].text=str;
		
        document.write("value = "+JSONObj[ln].value);  
        document.write("text = "+JSONObj[ln].text);
		alert("successfull");
		document.write("<script type='text/javascript' src='${pageContext.request.contextPath}/js/index.js'><\/script>");
	}
	else{
		//alert("facility u entereed is already exist... ");
		
	}
}

</script>
<%
} 
%>
		 
</body>
</html>