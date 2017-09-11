<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="mystyle.css">
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
	<%@include file="Config.jsp"%>

	<%
		try {
			String muname = request.getParameter("muname");
			String mrole = request.getParameter("mrole");
			String mpassword = request.getParameter("mpassword");

			String role = request.getParameter("role");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			System.out.println("1new role=" + role);
			System.out.println("1new user=" + username);
			System.out.println("1new pwd=" + password);

			MongoClient mongoClient = (MongoClient) com.kentropy.mongodb.MongoDAO
					.getMongoClient();
			DB db1 = mongoClient.getDB(db);

			DBCollection collection = db1.getCollection(credentials);
			BasicDBObject document = new BasicDBObject();
			BasicDBObject document1 = new BasicDBObject();
			document.put("username", muname);
			document.put("role", mrole);
			document.put("password", mpassword);

			System.out.println("1musername =" + muname);
			System.out.println("1mrole=" + mrole);
			System.out.println("1mpassword=" + mpassword);
			DBCursor cr1;
			DBCursor cr = collection.find(document);
			if (cr.size() > 0) {
				document1.put("username", username);
				document1.put("role", role);
				cr1 = collection.find(document1);

				/* 	   if(cr1.size()==0)
					    {    	
				 */
				System.out.println("inserted");
				BasicDBObject newDocument = new BasicDBObject();
				//	newDocument.put("password", pwd);
				newDocument.append(
						"$set",
						new BasicDBObject().append("username", username)
								.append("role", role)
								.append("password", password));
				BasicDBObject searchQuery = new BasicDBObject()
						.append("username", muname).append("role", mrole)
						.append("password", mpassword);
				collection.update(searchQuery, newDocument);
				response.sendRedirect("viewUser.jsp?err=1");
				/*  }
				else
				{
					response.sendRedirect("viewUser.jsp?err=2");
				} */

			} else {
				response.sendRedirect("viewUser.jsp?err=4");
			}
		} catch (Exception e) {
			System.out.print(e);
		}
	%>

</body>
</html>