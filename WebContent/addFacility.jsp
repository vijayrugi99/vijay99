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
<title>Insert title here</title>

</head>	
<body >
<%-- <%@page import="org.json.JSONObject" %>
 --%>	
 		<%@page import="org.json.JSONObject" %>
		<%@page import="org.json.JSONArray" %>
    <%@page import="org.json.simple.*"%>
    <%@page import="org.json.*"%>
	<%@page import="java.io.FileWriter"%>
	<%@page import="java.io.File"%>
	<%@page import="java.io.IOException"%>
	<%@page import="java.nio.file.Path"%>
	
	
	
	<%@page import="java.nio.file.Paths"%>
	<%@page import="java.nio.charset.Charset"%>
	<%@page import="java.nio.file.Files"%>
	<%@page import="java.nio.charset.StandardCharsets"%>
		
<%-- <%@page import="java.io.*"%> --%>
<%
String src=null;
String dist=request.getParameter("dist");
int tq=Integer.parseInt(request.getParameter("tq"));
String faci=request.getParameter("faci");
int value=Integer.parseInt(request.getParameter("value"));
System.out.println("TQ="+tq+"Faci="+faci+"value="+value);
JSONObject obj = new JSONObject();
JSONObject obj1 = new JSONObject();
System.out.println("Outside trye...");
try 
{

%>
<script type="text/javascript">
<%=src%>='${pageContext.request.contextPath}/facilities.js';

</script>

<%
    System.out.println("Source="+src);
	Path filename=Paths.get("D:/Java_Workspace/Testing_Reports/WebContent/facilities.js");
	String file1="D:/Java_Workspace/Testing_Reports/WebContent/facilities.js";
	//String url =session.getServletContext().getRealPath("/");

	  obj.put("value", value);
      obj.put("text", faci);
      obj.put("taluk", tq);
      
   //   String jsonText = obj.toString();
	FileWriter file = new FileWriter(file1,true);
	String comma=",";
	//file.write(obj.toString()); 
	//file.write("Testing data");
	//System.out.println("Successfully Copied JSON Object to File...");
	//System.out.println("\nJSON Object: " + obj);
	Path path = Paths.get("D:/Java_Workspace/Testing_Reports/WebContent/facilities.js");
	Charset charset = StandardCharsets.UTF_8;
	String content = new String(Files.readAllBytes(filename), charset);
	content = content.replaceAll("]", comma.concat(obj.toString()));
	Files.write(path, content.getBytes(charset));
	file.write("\n"+"]");
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