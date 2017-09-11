<%@page import="java.io.*,java.util.*,com.kentropy.kmc.process.*,com.kentropy.mongo.*"%>
<%@include file="Config.jsp" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text. SimpleDateFormat" %>
<%@page import="java.net.*" %>
<%
//Registry reg= (Registry) session.getServletContext//().getAttribute("registry");
String colId=request.getParameter("colId");
String collection=request.getParameter("collection");
String colJSON=request.getParameter("colJSON");
String text=request.getParameter("details");
FileOutputStream fout= new FileOutputStream(session.getServletContext().getRealPath("/data")+"/"+collection+"_"+colId+".json");
fout.write(colJSON.getBytes());
fout.close();
new MongoUtils("35.154.204.175",db).insertJSON(collection, "{data:"+colJSON+"}");
Object uname = session.getAttribute("username");
Object role = session.getAttribute("role");
InetAddress IP=InetAddress.getLocalHost();
System.out.println("role:"+role);
Date date = new Date();
String json="{\"role\":\""+role+"\",\"username\":\""+uname+"\",\"collection\":\""+collection+"\",\"date\":\""+date+"\",\"ip-address\":\""+IP.getHostAddress()+"\",\"activity\":\""+text+"\"}";
new MongoUtils("35.154.204.175",db).insertJSON(userActivity, json);

%>
<%=colJSON%>