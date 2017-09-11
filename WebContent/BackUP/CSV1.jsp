<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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

String url =session.getServletContext().getRealPath("/")+"/csv/";
//String url = "D:/redcap/";
//String url = "C:/Users/pp/Desktop/CSV/";
//System.out.println("Date99 = "+ cal.getTime());
String datefrom=null;
String days=null;
String type=null;

days=request.getParameter("days");
type=request.getParameter("type");
String tor1=null;
String[] tor=null;
if(type==null)
{
	tor = new String[]{"lbw-babydetails", "kmcinit", "kmcdetails", "discharge"};
/* 	tor[0]="lbw-babydetails";
	tor[1]="kmc";
	tor[2]="discharge"; */
}
else
{
	tor = new String[]{type};
}
System.out.println("tor size="+tor.length);
 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
datefrom=request.getParameter("datefrom");
if(datefrom==null)
{
	Date dtfrom=new Date();
	Calendar c2 = Calendar.getInstance();
	c2.setTime(dtfrom); 
	c2.add(Calendar.DATE, -14);
	dtfrom= c2.getTime();
	datefrom=sdf.format(dtfrom);
}

	
Date dateto2=sdf.parse(datefrom);
Calendar c2 = Calendar.getInstance(); 
c2.setTime(dateto2); 
c2.add(Calendar.DATE, 6);
dateto2 = c2.getTime();
String dateto1=sdf.format(dateto2);

String dateto=null; 
dateto= request.getParameter("dateto"); //get value from form

if(dateto == null)
{
	if(days==null)
	{
		dateto = dateto1;

	}
	else
	{
		Date day=sdf.parse(datefrom);
		Calendar c3 = Calendar.getInstance(); 
		c2.setTime(day); 
		c2.add(Calendar.DATE, Integer.parseInt(days)-1);
		dateto2 = c2.getTime();
		dateto=sdf.format(dateto2);
		
	}
}
else
{
	Date dt2=(Date)sdf.parse(dateto);
	dateto=sdf.format(dt2);
} 

out.println("Date from = "+datefrom);
out.println("Date to="+dateto);	

//boolean alreadyExists = new File(outputFile).exists();
	
try {
	
	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	System.out.println("mongo = "+mongo);
	DB database = mongo.getDB(db);
	System.out.println("Used db ="+database);
	System.out.println("Connected to database sucessfully...");
	DBCollection collection = database.getCollection(coll);						
	/* System.out.println("Collection used ="+collection); 
	
	System.out.println("datefrom after convert="+datefrom);
	 *///SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date df = sdf.parse(datefrom);
  	Date dt = sdf.parse(dateto);
	//System.out.println("Dtfrom="+datefrom+"Dtto="+dateto);
	SimpleDateFormat sdf_ddmm = new SimpleDateFormat("yyyy-MM-dd");
	String date_from = sdf_ddmm.format(df);
	String date_to = sdf_ddmm.format(dt);
	
/* out.println("datefrom after convert into yyyy-MM-dd="+date_from);
out.println("dateto after convert into yyyy-MM-dd="+date_to); */
  	
	//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
	com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
	//int facility = value==null?1:Integer.parseInt(value);
	//System.out.println("Facility in  jsp page ="+facility);
	
	com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
	com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
	int res=0;				
	// use FileWriter constructor that specifies
	CsvWriter csvOutput=null;
	for(int i=0;i<tor.length;i++)
	{		
		String filename=tor[i]+"-"+datefrom+"_To_"+dateto+".csv";
		String outputFile=url+filename;
		out.println("<br>Output path="+outputFile);	
	if((tor[i].equalsIgnoreCase("lbw-babydetails")) || (tor[i].equalsIgnoreCase("kmcinit")) || (tor[i].equalsIgnoreCase("kmcdetails")) ||(tor[i].equalsIgnoreCase("discharge")))
	{
		//out.println("<br>"+ tor[i]);
	// if the file didn't already exist then we need to write out the header line
		if(tor[i].equalsIgnoreCase("LBW-Babydetails"))
		{
			type=tor[i];
			//System.out.println("inside baby");			
			ArrayList<DBObject> jsonArray = mongodao.generateBabydetails(date_from, date_to);
		   // out.println("Records="+jsonArray.size());
		    if(jsonArray.size()>0)
		    {
				csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
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
				csvOutput.write("surveyType");
				csvOutput.endRecord();
		      res=com.kentropy.mongodb.CSV.generateCSVBabydetails(jsonArray, outputFile,csvOutput);
		    }
		    else
		    	out.println("<span style=color:red> No records found between"+date_from+"to"+date_to+"</span>");
		}
		else if(tor[i].equalsIgnoreCase("kmcinit"))
		{			
			type=tor[i];
			ArrayList<DBObject> jsonArray = mongodao.generateKMCinit(date_from, date_to);
		    out.println("Json array size in kmc init ="+jsonArray.size());
		    if(jsonArray.size()>0)
		    {
				csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
				csvOutput.write("kent_id");				
				csvOutput.write("kmc_reg_no");
				csvOutput.write("kmc_initiation");	
				csvOutput.write("reason_for_dalay");
				csvOutput.write("date_of_kmc_initiation");
				csvOutput.write("time_of_kmc_initiation");
				csvOutput.write("am_pm");
				csvOutput.write("kmc_provider");
				csvOutput.write("feed_type");				
				csvOutput.endRecord();
		       res=com.kentropy.mongodb.CSV.generateCSVKMC(jsonArray, outputFile,csvOutput, type);
		    }
		    else
		    	out.println("<span style=color:red> No records found between"+date_from+"to"+date_to+"</span>");
		    
		}
		else if(tor[i].equalsIgnoreCase("kmcdetails"))
		{		
			type=tor[i];
			ArrayList<DBObject> jsonArray = mongodao.generateKMCdetails(date_from, date_to);
		    out.println("Json array size in kmc details="+jsonArray.size());
		    if(jsonArray.size()>0)
		    {
				csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
				csvOutput.write("kent_id");							
				csvOutput.write("date");
				csvOutput.write("kmc_done");	
				csvOutput.write("from");
				csvOutput.write("from_meridian");
				csvOutput.write("to");
				csvOutput.write("to_meridian");
				csvOutput.write("discharged");
				csvOutput.endRecord();
		       res=com.kentropy.mongodb.CSV.generateCSVKMC(jsonArray, outputFile,csvOutput,type);
		    }
		    else
		    	out.println("<span style=color:red> No records found between"+date_from+"to"+date_to+"</span>");
		    
		}
		else if(tor[i].equalsIgnoreCase("discharge"))
		{	
			type=tor[i];
			ArrayList<DBObject> jsonArray = mongodao.generateDischargedetails(date_from, date_to);
		    out.println("Json array size ="+jsonArray.size());
		    if(jsonArray.size()>0)
		    {
		    	csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
				csvOutput.write("kent_id");				
				csvOutput.write("date_of_outcome");
				csvOutput.write("time_of_discharge");
				csvOutput.write("meridian");	
				csvOutput.endRecord();	
				res=com.kentropy.mongodb.CSV.generateCSVDischarge(jsonArray, outputFile,csvOutput);
		    }
		    else
		    	out.println("<span style=color:red> No records found between"+date_from+"to"+date_to+"</span>");
		}
		  if(res==1)
		{
			 File file=new File(outputFile);
			 DecimalFormat df1=new DecimalFormat();
			 df1.setMaximumFractionDigits(2);
			 float size=file.length();
			 tor1=tor[i];
			 if(size>0)
			 {
				 out.println("file size="+df1.format(size/1024)+"KB");
		    int res1=new com.kentropy.mongodb.DeleteMongodbObject().insertCSVdetails(filename,datefrom,dateto,db,csv,tor1,df1.format(size/1024));	
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
	else	
	{
		out.println("<br><span style=color:red;font-size:25px;>Error: Please re-check inputs </span>");
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