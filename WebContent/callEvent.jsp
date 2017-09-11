
<%@include file="Config.jsp" %>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONArray" %>
<%@page import="com.mongodb.util.JSON" %>
<%@page import="java.util.*"%>
<%@page import="com.kentropy.mongo.*"%>
<% 

 Object uname = session.getAttribute("username");
 Object col= session.getAttribute("collection");
 Object id = session.getAttribute("id");
 System.out.println("col in callevent.jsp:"+col);
 Date date = new Date();
 date =new Date(session.getLastAccessedTime());
 JSONObject data1= new JSONObject();
 JSONObject obj=new JSONObject();
 Object role=session.getAttribute("role");
  System.out.println("uname::"+uname);
 System.out.println("role::"+role);
 System.out.println("collection::"+col);
 System.out.println("time of activity::"+date);
 System.out.println("id::"+id); 
 obj.put("username", uname);
 obj.put("time_of_Activity",date);
 obj.put("role", role);
 obj.put("id", id);
 obj.put("Collection", col);
 //obj.put("Survey_Type",surveyType);
 data1.put("RecDetails", obj);
 new MongoUtils("54.162.202.102",db).insertJSON(userActivity, ""+data1+""); 

 session.removeAttribute("id");
 session.removeAttribute("collection");
 
%>  
