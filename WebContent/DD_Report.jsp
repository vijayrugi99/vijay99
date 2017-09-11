<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="facilities.js">	</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>data-dictionary</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="Responsive_Style.css"> 
       <script src="ken_kmc_html.js"></script>
</head>
<body>
<%@page import="org.json.JSONTokener" %>
<%@page import="org.json.JSONTokener" %>
<%@page import="java.io.File" %>
<%@page import=" java.io.FileNotFoundException" %>
<%@page import=" java.io.FileOutputStream" %>
<%@page import="java.io.FileReader" %>
<%@page import="java.io.FileWriter" %>
<%@page import="org.json.JSONArray" %>
<%@page import="org.json.JSONObject" %>
<%@ include file="Config.jsp" %>
<%-- <%@ include file="home.jsp" %>  --%>
<%
try{
String value=request.getParameter("forms");
%>
	 <div class="container" style="text-align:center">
	 <h2 style="text-align:center;color:brown;"> Data-Dictionary </h2>
	 <center>
	 <form action="DD_Report.jsp" method="post" class="form-inline">
		 <div class="form-group" class="form -control">							
			<!-- obtain the value from js file into dropdown list-->	
			<div id="filters"></div>
			<script>
				var filterStr = DropdownFilter(dataForms,"<%= value%>");							
				filters.innerHTML=filterStr;
			</script><br>
                        <button  type="submit" class="btn btn-primary">Submit</button>
			</div>
					
			</form>
	 </center>
		<div class="row">
		<div id="Data-Dictionary" class="exporttable table-responsive2">
		 <table  border="border: 1px solid black" font-family="verdana" font-size="10pt" text-align="center" border-collapse="collapse" border="1px solid black" padding="3px" class="table table-bordered table-condensed table-striped">
               <thead>
                 <tr> 	
                   <th>Name</th>
                   <th>Type</th>
                   <th>Title</th>
                   <th>Is Required</th>
                   <th>Validator-Type</th>
                   <th>Validation-Minvalue</th>
                   <th>Validation-Maxvalue</th>
                   <th>Min length</th>
                   <th>Validation-regex</th>
                   <th>Validation-text</th>
                   <th>Visible</th>
                   <th>Min count</th>
                   <th>Max count</th>
                   <th>drop-down-list-with-value</th>
                   </tr>
                   </thead>
                  <tbody>
                   <%
                String filename[]={"","inborn_lbw.json","inborn_listing.json","inborn_normal.json","discharge_form.json","kmc_cc_form.json","kmc_fi_form.json","kmc_init_form.json","outborn_lbw.json"};
               
                	int val=Integer.parseInt(value);
                	String Name="";
                	String Type="";
                	String Title="";
                	String IsRequired="";
                	String Validator_Type="";
                	String Validation_Minvalue="";
                	String Validation_Maxvalue="";
                	String Minlength="";
                	String Validation_regex="";
                	String Validation_text="";
                	String drop_down_list_with_value="";
                	String Min_count="";
                	String Max_count="";
                	String Visible="";
            		String url =session.getServletContext().getRealPath("/");
					String str = url+filename[val];
                	JSONTokener jt = new JSONTokener(new FileReader(str));
                	JSONArray arr = new JSONArray(jt);
                	for(int i=0;i<arr.length();i++){
                   	 JSONObject obj1 = (JSONObject)arr.get(i);
                   	 if(obj1.has("Name")){
                   		 Name=(String)obj1.get("Name");
                   	 }
                   	 if(obj1.has("Type")){
                   		 Type=(String)obj1.get("Type");
                   	 }
                   	 if(obj1.has("Title")){
                   		 Title=(String)obj1.get("Title");
                   	 }
                   	 if(obj1.has("IsRequired")){
                   		IsRequired=(String)obj1.get("IsRequired");																																														
                   	 }
                   	 if(obj1.has("Validator-Type")){
                   		Validator_Type=(String)obj1.get("Validator-Type");
                   	 }
                   	 if(obj1.has("Validation-Minvalue")){
                   		Validation_Minvalue=(String)obj1.get("Validation-Minvalue");
                   	 }
                   	 if(obj1.has("Validation-Maxvalue")){
                   		Validation_Maxvalue=(String)obj1.getString("Validation-Maxvalue");
                   	 }
                   	 if(obj1.has("Minlength")){
                   		Minlength=(String)obj1.getString("Minlength");
                   	 }
                   	 if(obj1.has("Validation-regex")){
                   		Validation_regex=(String)obj1.getString("Validation-regex");
                   	 }
                   	 if(obj1.has("Validation-text")){
                   		Validation_text=(String)obj1.getString("Validation-text");
                   	 }
                   	 if(obj1.has("drop_down_list_with_value")){
                   		drop_down_list_with_value=(String)obj1.getString("drop_down_list_with_value");
                   	 }
                   	 if(obj1.has("Min-count")){
                   		Min_count=(String)obj1.getString("Min-count");
                   	 }
                   	 if(obj1.has("Max-count")){
                    		Max_count=(String)obj1.getString("Max-count");
                    	 }
                   	if(obj1.has("Visible")){
                		Visible=(String)obj1.getString("Visible");
                	 } 
                   	 %>
                   	 
                   	          
                                       <tr class="warning">
                                       <td><%=Name%></td>
                                       <td><%=Type%></td>
                                       <td><%=Title%></td>
                                       <td><%=IsRequired%></td>
                                       <td><%=Validator_Type%></td>
                                       <td><%=Validation_Minvalue%></td>
                                       <td><%=Validation_Maxvalue%></td>
                                       <td><%=Minlength%></td>
                                       <td><%=Validation_regex%></td>
                                       <td><%=Validation_text%></td>
                                       <td><%=Visible %></td>
                                       <td><%=Min_count %></td>
                                       <td><%=Max_count %></td>
                                       <td><%=drop_down_list_with_value%></td>
                                       </tr>
                                      
                                         
                   <%
                	
                    }
               }catch(Exception e){
               	System.out.println(e);
               }
                %>
</tbody> 
</table>
</div>
</div>
</div>
 <%@include file="tableexport.jsp" %> 
</body>
</html>