<%@page import="java.io.*,java.util.*,com.kentropy.kmc.process.*,com.kentropy.mongo.*"%>
<%@include file="Config.jsp" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text. SimpleDateFormat" %>
<%@page import="java.net.*" %>

<%
//Registry reg= (Registry) session.getServletContext//().getAttribute("registry");

String collection=request.getParameter("collection");
String colJSON=request.getParameter("colJSON");
String text=request.getParameter("details");
System.out.println("Collection "+collection);
Object uname = session.getAttribute("username");
Object role = session.getAttribute("role");
InetAddress IP=InetAddress.getLocalHost();
System.out.println("IP of my system is := "+IP.getHostAddress());
Date date = new Date();
String json="{\"role\":\""+role+"\",\"username\":\""+uname+"\",\"collection\":\""+collection+"\",\"date\":\""+date+"\",\"ip-address\":\""+IP.getHostAddress()+"\",\"activity\":\""+text+"\"}";
new MongoUtils("35.154.204.175",db).insertJSON(collection,colJSON);
new MongoUtils("35.154.204.175",db).insertJSON(userActivity, json);

%>

Saved<br>
<%=colJSON%>