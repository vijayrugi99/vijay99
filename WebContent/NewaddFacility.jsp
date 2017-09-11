<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>	
<body>
<%-- <%@page import="org.json.JSONObject" %>
 --%>	
 		<%@page import="org.json.JSONObject" %>
		<%@page import="org.json.JSONArray" %>
    <%@page import="org.json.simple.*"%>
    <%@page import="org.json.*"%>
	<%@page import="java.io.FileWriter"%>
		<%@page import="java.io.IOException"%>
		
<%-- <%@page import="java.io.*"%> --%>
<%
String dist=request.getParameter("dist");
String tq=request.getParameter("tq");
String faci=request.getParameter("faci");
String value=request.getParameter("value");
System.out.println("TQ="+tq+"Faci="+faci+"value="+value);

JSONObject obj = new JSONObject();
JSONObject obj1 = new JSONObject();
System.out.println("Outside trye...");
try 
{
	String filename="D:/Java_Workspace/Testing_Reports/WebContent/test_facilities.js";
	//String url =session.getServletContext().getRealPath("/");
	  
	  obj.put("value", value);
      obj.put("text", faci);
      obj.put("taluk", tq);
   //   String jsonText = obj.toString();
	FileWriter file = new FileWriter(filename,true);
	file.write(",");
	file.write(obj.toString());
	//file.write("Testing data");
	System.out.println("Successfully Copied JSON Object to File...");
	//System.out.println("\nJSON Object: " + obj);
	file.flush();
	file.close();
}
catch(Exception e)
{
	System.out.println("Error="+e);
}

%>

</body>
</html>