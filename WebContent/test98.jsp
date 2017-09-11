<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%@page import="org.json.JSONObject" %>
	<%@page import="org.json.JSONArray" %>
	<%@page import="java.util.*"%>
	<%@page import="java.io.*"%>
=
<%
try
{
	
	System.out.println("Name="+request.getParameter("name"));
	//response.setContentType("text/json");
	/* System.out.println("Query="+request.getQueryString()+" "+request.getMethod() +" ");
	byte[] b= new byte[2048];
	int count=request.getInputStream().read(b);
String str=	new String(b,0,count);
System.out.println(str); */
PrintWriter out1=null;
Enumeration<String> tt= request.getParameterNames();
int cnt=0;


 while(tt.hasMoreElements())
{
	String vl=tt.nextElement();
	System.out.println((cnt++)+" "+vl+" "+request.getParameter(vl));
	out.println(vl+""+request.getParameter(vl));
	out1.write(request.getParameter(vl));
}
	/* String newObj = request.getParameter("name");
	System.out.println("new="+newObj);
	JSONObject jsonObj = new JSONObject(newObj );
	String name = jsonObj.getString("name");
	int age = jsonObj.getInt("age");
	System.out.println("Name="+name+"Age="+age);
 */	 
}
catch(Exception e)
{
	System.out.println(e);
}
%>

</body>
</html>