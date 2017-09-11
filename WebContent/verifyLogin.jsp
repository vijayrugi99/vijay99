<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%@page import="java.util.ArrayList"%>
	<%@page import="com.mongodb.ServerAddress"%>
	<%@page import="com.mongodb.DBCursor"%>
	<%@page import="com.mongodb.DBObject"%>
	<%@page import="com.mongodb.BasicDBObject"%>
	<%@page import="com.mongodb.DBCollection"%>
	<%@page import="com.mongodb.DB"%>
	<%@page import="com.mongodb.BasicDBObjectBuilder"%>
	<%@page import="com.mongodb.BasicDBList"%>
	<%@ include file="Config.jsp"%>
	<%
		
		com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(
				db, coll);
		String role = request.getParameter("role");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String dummy = "s";
		int val = mongodao.getUser(role, username, password, credentials);
		System.out.println(val);
		if (val == 2) {

			session.setAttribute("username", username);
			session.setAttribute("role", role);
			response.sendRedirect("home1.jsp?code=true");
		} else {
			response.sendRedirect("login.jsp?error=" + val + "&un="
					+ username + "&role=" + role);
		}

		/* 	/* 	  else
		 if(val==-1) {
		 response.sendRedirect("login.jsp?error="+val+"&role="+role);
		 }
		 if(val==-3) {
		 response.sendRedirect("login.jsp?error="+val+"&un="+username+"&role="+role);
		 }
		 /*   //session.setAttribute("username",username); 
		
		 session.setAttribute("dummy",dummy); 
		 response.sendRedirect("login.jsp?username="+username);  */
	%>

</body>
</html>