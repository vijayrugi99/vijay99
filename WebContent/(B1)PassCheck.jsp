<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="home.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.MongoException"%>
<%@page import="com.mongodb.WriteConcern"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.ServerAddress"%>
<%@page import="java.util.*"%>
<%@page import="java.util.List"%>
<%@page import="java.net.UnknownHostException"%>
<%@page import="java.util.Date"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.mongodb.MongoException"%>
<%@ include file="Config.jsp" %>
<%
try{
        String uname=(String)session.getAttribute("username");
		String role=(String)session.getAttribute("role");
        String cpwd=request.getParameter("CurPass");
        String pwd=request.getParameter("pwd1");
	    MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
        DB db1 = mongoClient.getDB(db);
        DBCollection collection= db1.getCollection(credentials);
        BasicDBObject document = new BasicDBObject();
        document.put("username",uname);
        document.put("password",cpwd);
        document.put("role",role);
        DBCursor cr=collection.find(document);
        String cses="ss";
        if(cr.size()>0)
        {
        	BasicDBObject newDocument = new BasicDBObject();
	        newDocument.append("$set",  new BasicDBObject().append("username", uname).append("role", role).append("password", pwd));
    		BasicDBObject searchQuery = new BasicDBObject().append("username",uname).append("role", role).append("password", cpwd);
    		collection.update(searchQuery, newDocument);
            response.sendRedirect("home1.jsp?err=s");    
        }
        else
        {
        	
        	session.setAttribute("cses",cses);
        	return ; 
        } 
        }
        catch(Exception e)
        {
        System.out.print(e);
        }
        

%>
</body>
</html>