<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Redcap CSV Discharge</title>
<script src="facilities.js">	</script>
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

<%

//String url =session.getServletContext().getRealPath("/")+"/redcapCSV/";
//String url = "D:/";
String url = "C:/Users/pp/Desktop/CSV/";
SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy"); //date format
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd"); //date format

String datefrom = request.getParameter("datefrom"); //get value from form
if(datefrom == null)
{
	Date dt = new Date();
	datefrom = sdf.format(dt);
}
else
{
	String[] datestr = datefrom.split("/");
	String newdate = datestr[1]+"/"+datestr[0]+"/"+datestr[2];
	datefrom = newdate;
}
out.println("from date="+datefrom);
String dateto = request.getParameter("dateto"); //get value from form
if(dateto == null)
{
	/* Calendar cal= Calendar.getInstance();
	cal.setTime(new Date(datefrom));
	cal.add(Calendar.DATE, 1);
	Date endDate= cal.getTime();
	dateto = sdf.format(endDate); */
	dateto=datefrom;
}
else
{
	String[] dateend = dateto.split("/");
	String newdate1 = dateend[1]+"/"+dateend[0]+"/"+dateend[2];
	dateto=newdate1;
}
out.println("to date="+dateto);

Date dt1=sdf.parse(datefrom);
datefrom=sdf1.format(dt1);
Date dt2=sdf.parse(dateto);
dateto=sdf1.format(dt2);
out.println("after converting yyyy-MM-dd"+datefrom+"and dateto="+dateto);
String facility = request.getParameter("facility"); 
if(facility==null)
{
	facility ="all";
}	

//MongoClient object & mondao objects
MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);	
com.kentropy.mongodb.MongoDAO mongodao1 = new com.kentropy.mongodb.MongoDAO(db,redcap);	
com.kentropy.mongodb.RedcapCSV obj=new com.kentropy.mongodb.RedcapCSV();
obj.updateCSVRecord(mongodao1,mongodao);
 ArrayList<DBObject> jsonArray = mongodao1.generateRedcapDischarge(datefrom, dateto,facility);
out.println("Records="+jsonArray.size());
// use FileWriter constructor that specifies
CsvWriter csvOutput=null;
String filename="discharge_redcap_facility-"+facility+"-"+datefrom+".csv";
String outputFile=url+filename;
out.println("<br>Output path="+outputFile);	
int res=0;
if(jsonArray.size()>0)
{
	   csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
	   csvOutput.write("record_id");
	   csvOutput.write("kent_id");
	   csvOutput.write("kmc_reg_no");
	   csvOutput.write("dod");
	   csvOutput.endRecord();
	   res=obj.generateRedcapCSVDischarge(jsonArray, outputFile,csvOutput);
 }
else
{
	   	out.println("<span style=color:red> No records found between"+datefrom+"to"+dateto+"</span>");
 }

/* if(res==1)
			{
			 File file=new File(outputFile);
			 DecimalFormat df1=new DecimalFormat();
			 df1.setMaximumFractionDigits(2);
			 float size=file.length();
			 if(size>0)
			 {
				     out.println("file size="+df1.format(size/1024)+"KB");
			        int res1=new com.kentropy.mongodb.DeleteMongodbObject().insertCSVdetails(filename,datefrom,dateto,db,csv,"dod_redcap",df1.format(size/1024));	
				    if(res1==3)
					{
						out.println("<span style=color:red>File replaced</span>");
					}
					else if(res1==1)
					{
						out.println("<span style=color:green>File created successfully</span>");
					} 
				    }
				    else
				   {
					 out.println("No records");
				  } 
		}    */
	



%>
</body>
</html>