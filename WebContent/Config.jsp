<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Database configuration </title>
	</head>
	<%@page import="com.mongodb.MongoClient" %>
	<body>
		<% /********Configuration******/%> 
		<% String db = "copy";
			String coll = "test_Nov11";
			String delColl = "DeletedRecords";
			String kmccoll = "kmc";
			String dischargecoll = "discharge";
			String credentials = "credentials";
			String homeborn = "homeborn";
			String userActivity="userActivity";
			String csv="csvdata";
			String counter="counters";
            String redcap="redcap";
			String redcaptest="redcaptest";
		%>
	</body>
</html>