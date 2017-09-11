<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>RedCap Data</title>
</head>
<body>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="com.csvreader.CsvWriter"%>
<%@page import="java.sql.*" %>
<%@page import="java.awt.List" %>
<%@page import="com.mongodb.ServerAddress" %>
<%@page import="com.mongodb.DBCursor" %>
<%@page import="com.mongodb.DBObject" %>
<%@page import="com.mongodb.BasicDBObject" %>
<%@page import="com.mongodb.DBCollection" %>
<%@page import="com.mongodb.DB" %>
<%@page import="com.mongodb.BasicDBObjectBuilder" %>
<%@page import="com.mongodb.BasicDBList" %>
<%@page import="com.mongodb.AggregationOutput" %>
<%@page import="com.mongodb.MongoException" %>
<%@page import="com.mongodb.MongoClient" %>
<%@page import="org.bson.types.ObjectId" %>
<%@page import="com.mongodb.ServerAddress" %>
<%@page import="java.awt.List" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.awt.List" %>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONArray" %>
<%@page import="java.text.*" %>
<%-- <%@page import="java.time.*" %> --%>	
<%@page import = "java.util.*"%>
<%@page import = "java.util.Date"%>
<%@page import = "java.util.Calendar"%>	
<%@ include file="Config.jsp" %>
 <script src="facilities.js">	</script>
<%
String date=null;
String value=null;
int value1=0;
int check=0;
date=request.getParameter("date");
//Date d1 = new Date();

value=request.getParameter("facility");
if(value==null){
	out.println("inside if value");
	value1=1;%>
	<script>
	
	var fac=facilities;
	var facArray = [];
	
	for(var i=0;i<fac.length;i++)
	{
		
		facArray.push(fac[i].value);
	}
	alert("hi"+facArray.length)
		document.getElementById("hiddenField").value=facArray;
	//alert(document.getElementById("hiddenField").value);
	</script>
	<%
}
else{
%>			<script>
			var facility=<%=value%>;
			var fac=facilities;
			alert(fac.length);
			var flag=0;
			for(var i=0;i<fac.length;i++)
				{        
				   if(fac[i].value==facility)
					   {
						  flag=1;		
					   }
				}
			if(flag==0)
				   alert("Pls enter valid facility");
			</script>
			<input type="hidden" id="hiddenField" name="hiddenField"/>
<%
}
String facValues=null;
int facilityvalue =value1;
System.out.println("facilityvalue="+value1);
if(facilityvalue == 1)
{
	facValues=request.getParameter("hiddenField");					
}
else
{
	facValues=value;
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
try {
	
	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	DB database = mongo.getDB(db);
	System.out.println("Used db ="+database);
	System.out.println("Connected to database sucessfully...");
	DBCollection collection = database.getCollection(coll);						
	Date d1 = sdf.parse(date);
	SimpleDateFormat sdf_ddmm = new SimpleDateFormat("yyyy-MM-dd");
	String date1 = sdf_ddmm.format(d1);	
	String date2 = sdf1.format(d1);	
	Date d2 = sdf1.parse(date2);
	
	Date dateto2=sdf1.parse(date2);
	Calendar c2 = Calendar.getInstance(); 
	c2.setTime(dateto2); 
	c2.add(Calendar.DATE, 6);
	dateto2 = c2.getTime();
	ObjectId obj1=new ObjectId(d2);
	ObjectId obj2=new ObjectId(dateto2);
	out.println("Object ID 1="+obj1);
	out.println("Object ID 2="+obj2);
	
	out.println("date after convert into yyyy-MM-dd="+date1);
	//out.println("Facility="+facility); 
	out.println("Date2="+date2);
	out.println("D2="+d2);
	System.out.println("Facilities="+facValues);
  	
	
	//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
	com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
	com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
	com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
	int res=0;					
		/* 	ArrayList<DBObject> jsonArray = mongodao.stage3Integration(facValues,obj1,obj2);
		   System.out.println("Records="+jsonArray.size());
		   if(jsonArray.size()>0)
		    {
		      System.out.println("Inside if size="+jsonArray.size());
		      res=com.kentropy.mongodb.CSV.redCapCollection(jsonArray,db,redcap);
		      out.println("Total records="+jsonArray.size());
		    }
		    else
		    	out.println("<span style=color:red> No records found on "+date+"in facility="+value+"</span>");
		 */
}
catch (Exception e)
{
	out.println(e);
	e.printStackTrace();
}

%>

</body>
</html>