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
		<%@page import="java.time.*" %>
		<%@page import = "java.util.*"%>
		<%@page import = "java.util.Date"%>
		<%@page import = "java.util.Calendar"%>	
		<%@ include file="Config.jsp" %>

<%
String url =session.getServletContext().getRealPath("/")+"/csv/";
//out.println("URL="+url);
/* SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
String datefrom =request.getParameter("datefrom"); //get value from form
Calendar cal = Calendar.getInstance();
cal.add(Calendar.DATE, -7); */
//System.out.println("Date99 = "+ cal.getTime());
String datefrom=null;
String days=null;
days=request.getParameter("days");
SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
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
System.out.println("Date from = "+datefrom);
//sdf.format(cal.getTime());
 //String dateto=request.getParameter("dateto");
		// sdf1.format(cal.getTime());
//out.println("Date99 = "+ datefrom);

/* if(datefrom == null)
{
	datefrom = "01/10/2016";
} */
//System.out.println("date from before submit="+new Date());	
 Date dateto2=sdf.parse(datefrom);
Calendar c2 = Calendar.getInstance(); 
c2.setTime(dateto2); 
c2.add(Calendar.DATE, 6);
dateto2 = c2.getTime();
String dateto1=sdf.format(dateto2);
System.out.println("date to + 7th day of date from ="+dateto1);
String dateto = request.getParameter("dateto"); //get value from form			
if(dateto == null)
{
	dateto = dateto1;
}
else
{
	Date dt2=(Date)sdf.parse(dateto);
	dateto=sdf.format(dt2);
} 
System.out.println("Date from = "+datefrom);
System.out.println("Date to="+dateto);	

String outputFile=url+"BATCH-"+datefrom+"_To_"+dateto+".csv"; 
//"C:/Users/pp/Downloads/baby66.csv";
//String output="C:/Users/pp/Downloads/baby"+dtfrom+"-"+dtto+".csv";

//System.out.println("String = test="+outputFile);
out.println("Path="+outputFile);
// before we open the file check to see if it already exists
boolean alreadyExists = new File(outputFile).exists();
	
try {
	
	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	System.out.println("mongo = "+mongo);
	DB database = mongo.getDB(db);
	System.out.println("Used db ="+database);
	System.out.println("Connected to database sucessfully...");
	DBCollection collection = database.getCollection(coll);						
	System.out.println("Collection used ="+collection); 
	
	System.out.println("datefrom after convert="+datefrom);
	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date df = sdf.parse(datefrom);
  	Date dt = sdf.parse(dateto);
	System.out.println("Dtfrom="+datefrom+"Dtto="+dateto);
	SimpleDateFormat sdf_ddmm = new SimpleDateFormat("yyyy-MM-dd");
	String date_from = sdf_ddmm.format(df);
	String date_to = sdf_ddmm.format(dt);
	
out.println("datefrom after convert into yyyy-MM-dd="+date_from);
out.println("dateto after convert into yyyy-MM-dd="+date_to);
  	
	//get BasicDBObject type object bcoz mongodb has object in type of BasicDBObject
	com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db,coll);				
	//int facility = value==null?1:Integer.parseInt(value);
	//System.out.println("Facility in  jsp page ="+facility);
	ArrayList<DBObject> jsonArray = mongodao.dataNormalization(date_from, date_to);
	com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
	com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
out.println("Json array size ="+jsonArray.size());
	int count=0;				
	// use FileWriter constructor that specifies open for appending
	CsvWriter csvOutput = new CsvWriter(new FileWriter(outputFile, true), ',');
	// if the file didn't already exist then we need to write out the header line
	if (!alreadyExists)
	{
		csvOutput.write("Record_ID");
		csvOutput.write("Pid1");
		csvOutput.write("Mother Name");
		csvOutput.write("Husband Name");
		csvOutput.write("DOB");
		csvOutput.write("Time of Birth");
		csvOutput.write("Birth Weight");
		csvOutput.write("Sex");
		csvOutput.write("Baby Status");
		csvOutput.write("Phone1");
		csvOutput.write("Phone2");
		csvOutput.write("Thayi_card No");
		csvOutput.endRecord();
	}
	// else assume that the file already has the correct header line
	for(int i=0; i<jsonArray.size(); i++)
				{
		System.out.println("Line1="+i);

					BasicDBObject data_obj = (BasicDBObject)jsonArray.get(i).get("data");
					
					if(data_obj.containsField("dob"))
					{
						bd.dob =data_obj.getString("dob");
					}
					else
						bd.dob = "-";
					if(data_obj.containsField("unique_id"))
					{
						bd.u_id = data_obj.getString("unique_id");
					}
					else
						bd.u_id = "-";
					if(data_obj.containsField("pid1"))
					{
						bd.pid1 = data_obj.get("pid1");
						if(bd.pid1 instanceof String)
						{
							bd.pid1 = data_obj.get("pid1");
						}
						else
						{
							bd.pid1 = data_obj.getInt("pid1");
						}						
						//System.out.println("pid1:"+bd.pid1);
					}
					else{
						bd.pid1 = "-";
					}
					
					if(data_obj.containsField("time_of_birth"))
					{
						bd.time_of_birth = data_obj.getString("time_of_birth");
					}
					else
						bd.time_of_birth = "-";
					//to ckeck whether the time is in 12hrs format									
					String time12hrs = tc.convert24To12Format((String)bd.time_of_birth);
					//System.out.println("time in 24hrs format = "+bd.time_of_birth);
					//System.out.println("time in 12hrs format = "+time12hrs);
					//System.out.println();
					bd.time_of_birth = time12hrs;									
					
					if(data_obj.containsField("thayi_card_no"))
					{
						bd.thayi_card_no = data_obj.getLong("thayi_card_no");
						//System.out.println("thayi_card_no:"+bd.thayi_card_no);
					}	
					else{
						bd.thayi_card_no ="-";
					}
					
					if(data_obj.containsField("baby_status"))
					{
						bd.baby_status = data_obj.getString("baby_status");
						String b_status=(String)bd.baby_status;
						if(b_status.equals("1"))
							bd.baby_status="Well";
						else if(b_status.equals("2"))
							bd.baby_status="Sick";
						else
							bd.baby_status="Dead";
					}
					else
						bd.baby_status = "-";
					
					if(data_obj.containsField("mother_name"))
					{
						bd.mother_name = data_obj.getString("mother_name");//getInt("epic");
					}
					else
						bd.mother_name = "-";
					
					if(data_obj.containsField("sex"))
					{
						bd.sex = data_obj.getString("sex");//getInt("epic");
						String sex1=(String)bd.sex;
						if (sex1.equals("1"))
							bd.sex="Male";
						else if(sex1.equals("2"))
							bd.sex="Female";
						else
							bd.sex="other";
					}
					else
						bd.sex = "-";
					
					if(data_obj.containsField("phone2"))
					{
						bd.phone2 = data_obj.getLong("phone2");
					}
					else
						bd.phone2 = "-";							
					
					if(data_obj.containsField("phone1"))
					{
						bd.phone1 = data_obj.getLong("phone1");
					}
					else
						bd.phone1 = "-";
					
					if(data_obj.containsField("uid"))
					{
						bd.uid = data_obj.get("uid");
						if(bd.uid instanceof String)
						{
							bd.uid = data_obj.get("uid");
						}
						else
						{
							bd.uid = data_obj.getInt("uid");
						}
						//System.out.println("uid:"+bd.u_id);
					}
					else{
						bd.uid ="-";
					}

					if(data_obj.containsField("birth_weight"))
					{
						bd.birth_weight = data_obj.getInt("birth_weight");
						//System.out.println("birth_weight:"+bd.birth_weight);
					}	
					else{
						bd.birth_weight="-";
					}
					
					if(data_obj.containsField("husband_name"))
					{
						bd.husband_name = data_obj.getString("husband_name");
					}
					else
						bd.husband_name = "-";
				
					// write out a records
					csvOutput.write(bd.u_id.toString());
					csvOutput.write(bd.pid1.toString());
					csvOutput.write(bd.mother_name.toString());
					csvOutput.write(bd.husband_name.toString());
					csvOutput.write(bd.dob.toString());
					csvOutput.write(bd.time_of_birth.toString());
					csvOutput.write(bd.birth_weight.toString());
					csvOutput.write(bd.sex.toString());
					csvOutput.write(bd.baby_status.toString());
					csvOutput.write(bd.phone1.toString());
					csvOutput.write(bd.phone2.toString());
					csvOutput.write(bd.thayi_card_no.toString());
					csvOutput.endRecord();
					/* System.out.println("Line="+i);
					System.out.println("Json array="+jsonArray.size()); */
				}
	csvOutput.close();

} catch (IOException e) {
	out.println(e);
	e.printStackTrace();
}

%>
</body>
</html>