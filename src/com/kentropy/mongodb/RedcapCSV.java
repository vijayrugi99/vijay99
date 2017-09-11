package com.kentropy.mongodb;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.csvreader.CsvWriter;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.WriteResult;

public class RedcapCSV {
	
	//baby details
		public static Object dob =" ";
		public static Object record_id = " ";
		public static Object pid1 = " ";	
		public static Object mother_name = " ";
		public static Object sex =" ";
		public static Object phone1 = " ";
		public static Object birth_weight=" ";
		public static Object husband_name =" ";
		public static Object phone2 =" ";
		public static Object surveytype = " ";
		public static Object baby_status = " ";
		public static Object time_of_birth = " ";
		public static Object thayi_card_no = " ";
		public static Object half = " ";
		public static Object facility = " ";
		public static Object community_from = " ";
		public static Object fac_name="";
		public static Object type_fac="";
		
		
		//kmc init fields
		public static Object kmc_reg_no = " ";
		public static Object kmc_initiation = " ";	
		public static Object date_of_kmc_initiation = " ";
		public static Object time_of_kmc_initiation = " ";	
		public static Object am_pm = " ";
		public static Object kmc_feed_type = " ";	
		public static Object reason = " ";
		public static Object kmc_provider = " ";
		//kmc details fields
		public static Object kmc_done = " ";
		public static Object kmc_date = " ";
		public static Object kmc_from_time = " ";
		public static Object kmc_to_time = " ";
		public static Object kmc_from_meridian = " ";
		public static Object kmc_to_meridian = " ";
		public static Object discharged = " ";	
		//discharge fields
		public static Object date_of_outcome=" ";
		public static Object time_of_discharge=" ";
		public static Object meridian=" ";
		static Object kmc_surveytype=null;
		public MongoDAO mongodao=null;
		
		
		public static int generateRedcapCSV(ArrayList<DBObject> jsonArray,String outputFile, CsvWriter csvOutput) throws IOException
		{
			
			System.out.println("jsonArray size="+jsonArray.size());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
			com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
			try
			{
				for(int i=0; i<jsonArray.size(); i++)
				{
					System.out.println("Line1="+i);
					BasicDBObject data_obj = (BasicDBObject)jsonArray.get(i);	
					if(data_obj.containsField("record_id"))
					{
						record_id = data_obj.get("record_id");
					}
					if(data_obj.containsField("pid1"))
					{
						pid1 = data_obj.get("pid1");
						if(pid1 instanceof String)
						{
							pid1 = data_obj.get("pid1");
						}
						else
						{
							pid1 = data_obj.getInt("pid1");
						}						
				
					}
					else
						pid1="";

					if(data_obj.containsField("time_of_birth"))
					{
						time_of_birth = data_obj.getString("time_of_birth");
					}
					else
						time_of_birth="";
					if(data_obj.containsField("half"))
					{
						half = data_obj.getString("half");
					}
					else
						half="";
					//to ckeck whether the time is in 12hrs format									
				/*	String time12hrs = tc.convert24To12Format((String)time_of_birth);
					time_of_birth = time12hrs;	*/								
							
					if(data_obj.containsField("thayi_card_no"))
					{
						thayi_card_no = data_obj.getLong("thayi_card_no");
					}	
					else
						thayi_card_no="";
					if(data_obj.containsField("baby_status"))
					{
						baby_status = data_obj.getString("baby_status");					
					}
					else
						baby_status="";

					if(data_obj.containsField("phone2"))
					{
						phone2 = data_obj.getLong("phone2");
					}
					else
						phone2="";
						
					if(data_obj.containsField("phone1"))
					{
						phone1 = data_obj.getLong("phone1");
					}
					else
						phone1="";
					if(data_obj.containsField("birth_weight"))
					{
						birth_weight = data_obj.getInt("birth_weight");
						//System.out.println("birth_weight:"+bd.birth_weight);
					}	

					if(data_obj.containsField("sex"))
					{
						sex = data_obj.getString("sex");
						//System.out.println("birth_weight:"+bd.birth_weight);
					}	
					else
						sex="";
					
					if(data_obj.containsField("surveyType"))
					{
						surveytype = data_obj.getString("surveyType");
					}
					if(surveytype.equals("homeborn_listing"))
					{
						
						String[] time_half=((String) time_of_birth).split(" ");
						time_of_birth=time_half[0];
						half=time_half[1].toUpperCase();
						type_fac="2";
					}
					else
					{
						type_fac="1";
					}
					if(data_obj.containsField("kmc_reg_no"))
					{
						kmc_reg_no=data_obj.getString("kmc_reg_no");
					}
					else
						kmc_reg_no="";
					
					if(data_obj.containsField("date_of_outcome"))
					{
						date_of_outcome=data_obj.getString("date_of_outcome");
						Date dod=sdf.parse((String) date_of_outcome);
						date_of_outcome=sdf1.format(dod);
					}
					else
						date_of_outcome="";

					// write out a records	
					csvOutput.write(record_id.toString());
					csvOutput.write(type_fac.toString());
					if(type_fac.equals("1"))   // If baby born in facility
					{
						csvOutput.write(data_obj.getString("facility"));
						csvOutput.write(data_obj.getString(""));
						csvOutput.write(data_obj.getString(""));
					}
					else // If baby born in home
					{
						csvOutput.write(data_obj.getString(""));
						if(data_obj.getString("community_from").equals("other"))
						csvOutput.write(data_obj.getString("community_from-Comment"));
							else
						csvOutput.write(data_obj.getString("community_from"));
						csvOutput.write(data_obj.getString("taluk_from"));
					}
			    	csvOutput.write(data_obj.getString("unique_id"));
					csvOutput.write(pid1.toString());
					csvOutput.write(data_obj.getString("mother_name"));
					csvOutput.write(data_obj.getString("husband_name"));
					csvOutput.write(data_obj.getString("dob"));
					csvOutput.write(time_of_birth.toString());
					csvOutput.write(half.toString());
					csvOutput.write(birth_weight.toString());
					csvOutput.write(sex.toString());
					csvOutput.write(baby_status.toString());
					csvOutput.write(phone1.toString());
					csvOutput.write(phone2.toString());
					csvOutput.write(thayi_card_no.toString());
					csvOutput.write(surveytype.toString());
					csvOutput.write(data_obj.getString("enteredDate"));
			    	csvOutput.write(kmc_reg_no.toString());
				//	csvOutput.write(date_of_outcome.toString());
					csvOutput.endRecord();
				}
				csvOutput.close();
				return 1;
			}
	catch(Exception e)
	{
		System.out.println("exception"+e);
		return 0;
	}		
}

	/**
	 * @param jsonArray
	 * @param outputFile
	 * @param csvOutput
	 * @return
	 * @throws IOException
	 */
	public int generateRedcapCSVDischarge(ArrayList<DBObject> jsonArray,
			String outputFile, CsvWriter csvOutput) throws IOException {

		System.out.println("jsonArray size=" + jsonArray);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
		try {
			
			
			for (int i = 0; i < jsonArray.size(); i++) {

				System.out.println("Line1=" + i);
				DBObject data_obj = jsonArray.get(i);
				if (data_obj.containsField("record_id")) {
					record_id = data_obj.get("record_id");
				}
				if (data_obj.containsField("date_of_outcome")) {
					date_of_outcome = data_obj.get("date_of_outcome");
					Date dod = sdf.parse((String) date_of_outcome);
					date_of_outcome = sdf1.format(dod);
				} else
					date_of_outcome = "";
				System.out.println("date_of_outcome=" + date_of_outcome);
				csvOutput.write(record_id.toString());
				csvOutput.write((String) data_obj.get("unique_id"));
				csvOutput.write((String) data_obj.get("kmc_reg_no"));
				csvOutput.write(date_of_outcome.toString());
				csvOutput.endRecord();
			}
			csvOutput.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return 1;
	}
		
		
		
		
public int updateCSVRecord(MongoDAO mongodao,MongoDAO mdao)

{  System.out.println("Inside updateCSVRecord Database="+mongodao.db+"collection="+mongodao.collection);
	try
	{
	MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
	//MongoDAO mdao = MongoDAO.initMongodao("35.154.204.175","copy","admin","kent@#14","test_Nov11");
	//DB database = MongoDAO.getMongoClient().getDB(mongodao.db);
	DB database=mongo.getDB(mongodao.db);
    DBCollection collection= database.getCollection(mongodao.collection);
    System.out.println("Database="+database+"collection="+collection);
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");	
    SimpleDateFormat sdf1=new SimpleDateFormat("dd/MM/yyyy");
    Date dt=new Date();
    String dod_ent=sdf.format(dt);
    BasicDBObject doc = new BasicDBObject();
    BasicDBObject newDocument = new BasicDBObject();
    BasicDBObject searchQuery = new BasicDBObject();
    DBObject query_kmc = new BasicDBObject("kmc_reg_no", new BasicDBObject("$exists", false));
    DBObject query_dod = new BasicDBObject("date_of_outcome", new BasicDBObject("$exists", false));
	DBCursor result_kmc = collection.find(query_kmc);
	DBCursor result_dod = collection.find(query_dod);
    System.out.println("result_dod="+result_dod.size());
    String unique_id=null;
    //DB db = MongoDAO.getMongoClient().getDB(mdao.db);
    DB db=mongo.getDB(mdao.db);
    DBCollection coll= db.getCollection(mdao.collection);
    while(result_kmc.hasNext())
    {
    	unique_id=(String) result_kmc.next().get("unique_id");
    	ArrayList<DBObject> dbobj=mdao.getBaby1(unique_id);
    	System.out.println("Unique id00=="+unique_id);

    	BasicDBList comp_bdb= (BasicDBList) dbobj.get(0).get("comp_docs");
    	if(comp_bdb.size()>0)
    	{
    		System.out.println("bdb="+comp_bdb);
    		BasicDBObject comp_obj = (BasicDBObject)comp_bdb.get(0);
	    	String kmc_reg_no = (String) comp_obj.get("kmc_reg_no");
	    	System.out.println("kmc_reg_no="+kmc_reg_no);
	    	newDocument = new BasicDBObject().append("$set", new BasicDBObject("kmc_reg_no",kmc_reg_no));
		    searchQuery = new BasicDBObject("unique_id", unique_id);
	    	WriteResult wr=collection.update(searchQuery, newDocument);
	    	System.out.println("Result="+wr.getN());
    	}
    }
    
   while(result_dod.hasNext())
    {
    	unique_id=(String) result_dod.next().get("unique_id");
    	ArrayList<DBObject> dbobj=mdao.getBaby1(unique_id);
    	BasicDBList bdb= (BasicDBList) dbobj.get(0).get("discharge_docs");
    	if(bdb.size()>0)
    	{
    		System.out.println("discharge doc bdb="+bdb);
    		BasicDBObject comp_obj = (BasicDBObject)bdb.get(0);
	    	String date_of_outcome = (String) comp_obj.get("date_of_outcome");
	    	Date dou=sdf1.parse(date_of_outcome);
	    	date_of_outcome=sdf.format(dou);
	    	System.out.println("date_of_outcome="+date_of_outcome);
	    	newDocument = new BasicDBObject().append("$set", new BasicDBObject("date_of_outcome",date_of_outcome).append("dod_ent", dod_ent));
		    searchQuery = new BasicDBObject("unique_id", unique_id);
	    	WriteResult wr=collection.update(searchQuery, newDocument);
	    	System.out.println("Result="+wr.getN());
    	}
    }
    
    return 1;
	}
	catch(Exception e)
	{
		System.out.println(e);
		return 0;
	}
	
	
}
public static void main(String[] args) 
{
	/*try{
	String datefrom="";
	String dateto="";
	String facValues="all";
	HttpSession session=null;
	String url =session.getServletContext().getRealPath("/")+"/redcapCSV/";
	CsvWriter csvOutput=null;
	String filename="redcap_csv.csv";
	String outputFile=url+filename;
	RedcapCSV rcsv=new RedcapCSV();
	Classification classify = new Classification();
	String db="copy";
	MongoDAO mongodao = new MongoDAO(db,"test_Nov11");	
	MongoDAO mongodao1 = new MongoDAO(db,"redcap");	
	MongoDAO mongodao2 = new MongoDAO(db,"homeborn");
	int result=0;
	classify.classifyLbwGroup(new Date(datefrom),new Date(dateto),facValues,mongodao);
	result=classify.generate20Percent(new Date(datefrom),new Date(dateto),facValues,mongodao, mongodao1,mongodao2,"counter");
	rcsv.updateCSVRecord(mongodao1,mongodao);
	ArrayList<DBObject> jsonArray = mongodao1.generateRedcapData(new Date(datefrom), new Date(dateto),facValues);
	System.out.println("Records="+jsonArray.size());
	int res=0;
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
		    	System.out.println("<span style=color:red> No records found between"+datefrom+"to"+dateto+"</span>");
		    }
  if(res==1)
		{
		 File file=new File(outputFile);
		 DecimalFormat df1=new DecimalFormat();
		 df1.setMaximumFractionDigits(2);
		 float size1=file.length();
		 System.out.println("file length="+file.length());
		 if(size1>0)
		 {
			     System.out.println("file size="+df1.format(size1/1024)+"KB");
		        int res1=new com.kentropy.mongodb.DeleteMongodbObject().insertCSVdetails(filename,datefrom,dateto,db,"csvdata","redcap",df1.format(size1/1024));	
			    if(res1==3)
				{
					System.out.println("<span style=color:red>File replaced</span>");
				}
				else if(res1==1)
				{
					System.out.println("<span style=color:green>File created successfully</span>");
				} 
			    }
			    else
			   {
				 System.out.println("No records");
			  } 
	}    
	}
	catch(Exception e)
	{
		System.out.println(e);
	}*/
	
	//rcsv.updateCSVRecord();

}}