<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Redcap CSV Generate</title>
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

String url =session.getServletContext().getRealPath("/")+"/redcapCSV/";
//String url = "D:/";
//String url = "C:/Users/pp/Desktop/CSV/";
//System.out.println("Date99 = "+ cal.getTime());
String datefrom=null;
datefrom = request.getParameter("datefrom");	
String dateto=null;
datefrom = request.getParameter("datefrom");	
dateto=request.getParameter("dateto");
SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");


if(datefrom == null)
{
	Date today = new Date();
	String dtfrm = sdf.format(today); 
	System.out.println("date after convert ="+dtfrm);
	datefrom = dtfrm;				
}
else
{				
	String[] datestr = datefrom.split("/");
	String newdate = datestr[1]+"/"+datestr[0]+"/"+datestr[2];
	datefrom = newdate;
}
if(dateto==null)
{
	Calendar cal= Calendar.getInstance();
	cal.setTime(new Date(datefrom));
	cal.add(Calendar.DATE, 1);
	Date endDate= cal.getTime();
	dateto = sdf.format(endDate);
}
else
{
	String[] dateend = dateto.split("/");
	String newdate1 = dateend[1]+"/"+dateend[0]+"/"+dateend[2];
	dateto=newdate1;
}
String facility = request.getParameter("facility");
if(facility==null)
{
	facility ="all";
}	
else
{
	facility =request.getParameter("facility");
}	

out.println("start date ="+datefrom);
out.println("end date ="+dateto);
Date dtfrm=sdf.parse(datefrom);
String dtfrom=sdf1.format(dtfrm);
out.println("Date from="+sdf1.format(dtfrm));
try {
	String facValues=null;
	int facilityvalue =0;
	if(!facility.equals("all"))
	{
		facilityvalue =Integer.parseInt(facility);
	}								
	facValues=facility;
	out.println("facility values = "+facValues);
	
	//MongoClient object & mondao objects
//	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);	
	com.kentropy.mongodb.MongoDAO mongodao1 = new com.kentropy.mongodb.MongoDAO(db,redcap);		
//	System.out.println("mongo = "+mongo);
	//DB database = mongo.getDB(mongodao.db);
//	System.out.println("Used db ="+database);
	System.out.println("Connected to database sucessfully...");
//	DBCollection collection = database.getCollection(mongodao.collection);						
	com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
	com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
	int res=0;			
	//Generating 20% of unique babies details
	com.kentropy.mongodb.Classification classify = new com.kentropy.mongodb.Classification();
	int size = classify.classifyLbwGroup(new Date(datefrom),new Date(dateto),facValues,mongodao);
	int result=0;
	if(size>0)
	{
		result=classify.generate20Percent(new Date(datefrom),new Date(dateto),facValues,mongodao, mongodao1,counter);
	}
	else
	{
		out.println("<span style=color:red> No records found in DB between given date "+datefrom+" and facility "+facility+"</span>");
	}
	//Write csvdata from redcap collection
	if(result==1)
	{
		// use FileWriter constructor that specifies
		CsvWriter csvOutput=null;
		String filename="redcap_facility-"+facValues+"-"+dtfrom+".csv";
		String outputFile=url+filename;
		out.println("<br>Output path="+outputFile);	
		com.kentropy.mongodb.RedcapCSV obj=new com.kentropy.mongodb.RedcapCSV();
		obj.updateCSVRecord(mongodao1,mongodao);
		 ArrayList<DBObject> jsonArray = mongodao1.generateRedcapData(new Date(datefrom), new Date(dateto),facValues);
	    out.println("Records="+jsonArray.size());
		if(jsonArray.size()>0)
		{
					csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
				  	csvOutput.write("record_id");
				  	csvOutput.write("fac_home");
				  	csvOutput.write("fac_code");
				  	csvOutput.write("community_code");
				  	csvOutput.write("taluk_code");
				  	csvOutput.write("kent_id");
					csvOutput.write("pid1");
					csvOutput.write("mother_name");
					csvOutput.write("husband_name");
					csvOutput.write("dob");
					csvOutput.write("time_of_birth");	
					csvOutput.write("half");	
					csvOutput.write("birth_weight");
					csvOutput.write("sex");
					csvOutput.write("baby_status");
					csvOutput.write("phone1");
					csvOutput.write("phone2");
					csvOutput.write("thayi_card_no");
					csvOutput.write("surveytype");
					csvOutput.write("ent_date");
					csvOutput.write("kmc_reg_no");
				//	csvOutput.write("dod");
					csvOutput.endRecord();
			      res=com.kentropy.mongodb.RedcapCSV.generateRedcapCSV(jsonArray, outputFile,csvOutput);
			    }
			    else
			    {
			    	out.println("<span style=color:red> No records found between"+datefrom+"to"+dateto+"</span>");
			    }
	  if(res==1)
			{
			 File file=new File(outputFile);
			 DecimalFormat df1=new DecimalFormat();
			 df1.setMaximumFractionDigits(2);
			 float size1=file.length();
			 out.println("file length="+file.length());
			 if(size1>0)
			 {
				     out.println("file size="+df1.format(size1/1024)+"KB");
			        int res1=new com.kentropy.mongodb.DeleteMongodbObject().insertCSVdetails(filename,datefrom,dateto,db,csv,"redcap",df1.format(size1/1024));	
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
		}    
	}

}
catch (IOException e)
{
	out.println(e);
	e.printStackTrace();
}

%>
</body>
</html>