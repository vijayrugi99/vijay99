<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="Config.jsp" %>	
<%@page import="org.json.JSONObject" %>
	<%@page import="org.json.JSONArray" %>
	<%@page import="java.io.PrintWriter" %>
	
<%
response.setContentType("application/json");
int res=0;
String objid=null;
String rem=null;
objid=request.getParameter("objid");
rem = request.getParameter("rem");
System.out.println("outside objid null check");
if(objid!=null)
{
	System.out.println("Inside objid null check");
	res = new com.kentropy.mongodb.DeleteMongodbObject().insertComment(db,kmccoll,objid,rem);
	if(res==1)
	{
		System.out.println("Result="+res);
		response.setContentType("application/json;charset=utf-8");
		String json="{'status':'Remark Saved Successfully'}";
	    JSONObject jsons = new JSONObject(json);
	    JSONObject member =  new JSONObject();
	    //member.put("arrayData", sampleData);
	    member.put("jsonArray", jsons);
	    PrintWriter pw = response.getWriter(); 
	    pw.print(jsons.toString());
	    pw.close();
	}
	else
	{
		
		response.setContentType("application/json;charset=utf-8");
		String json="{'status':'Failed-Please Try Again Later'}";
	    JSONObject jsons = new JSONObject(json);
	    JSONObject member =  new JSONObject();
	    //member.put("arrayData", sampleData);
	    member.put("jsonArray", jsons);
	    PrintWriter pw = response.getWriter(); 
	    pw.print(jsons.toString());
	    pw.close();
	}
}
else
{
	System.out.println("Inside else objid null check");
String name = request.getParameter("name");
String id=request.getParameter("id");

String period = request.getParameter("period");
String type = request.getParameter("type");
String phone = request.getParameter("cph");
String cn = (String)session.getAttribute("username");
String role=(String)session.getAttribute("role");
String survey=request.getParameter("surveytype");
System.out.println("survey  in fail jsp= "+survey);

/* if(cn != null && role != null){ */

	
	
res = new com.kentropy.mongodb.DeleteMongodbObject().insertRemarks(db,kmccoll,name,id,role,cn,rem,period,type,phone,survey);
/* } */
System.out.println("res::"+res);
if(res==1){
	response.setContentType("application/json;charset=utf-8");
	String json="{'status':'Remark Saved Successfully'}";
    JSONObject jsons = new JSONObject(json);
    JSONObject member =  new JSONObject();
    //member.put("arrayData", sampleData);
    member.put("jsonArray", jsons);
    PrintWriter pw = response.getWriter(); 
    pw.print(jsons.toString());
    pw.close();
    
}
else
{
	response.setContentType("application/json;charset=utf-8");
	String json="{'status':'Failed-Please Try Again Later'}";
    JSONObject jsons = new JSONObject(json);
    JSONObject member =  new JSONObject();
    //member.put("arrayData", sampleData);
    member.put("jsonArray", jsons);
    PrintWriter pw = response.getWriter(); 
    pw.print(jsons.toString());
    pw.close();
}}
%>
</body>
</html>


