package com.kentropy.mongodb;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.List.*;
import java.util.Vector;
import com.csvreader.CsvWriter;
import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.WriteResult;
import com.mongodb.client.MongoDatabase;
import com.mongodb.util.JSON;
import org.bson.types.ObjectId;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import com.csvreader.CsvWriter;

public class CSV 
{
	//baby details
	public static Object dob =" ";
	public static Object u_id = " ";
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
	
	public static int generateCSVBabydetails(ArrayList<DBObject> jsonArray,String outputFile, CsvWriter csvOutput) throws IOException
	{		
		com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
		//boolean alreadyExists = new File(outputFile).exists();
		//CsvWriter csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
		try
		{
			for(int i=0; i<jsonArray.size(); i++)
			{
				System.out.println("Line1="+i);
				BasicDBObject data_obj = (BasicDBObject)jsonArray.get(i).get("data");
						
				if(data_obj.containsField("dob"))
				{
					dob =data_obj.getString("dob");
				}
				else
				{
					dob =" ";
				}
				
				if(data_obj.containsField("unique_id"))
				{
					u_id = data_obj.getString("unique_id");
				}				
				else
				{
					u_id =" ";
				}
				
				if(data_obj.containsField("time_of_birth"))
				{
					time_of_birth = data_obj.getString("time_of_birth");
					//to ckeck whether the time is in 12hrs format									
					String time12hrs = tc.convert24To12Format((String)time_of_birth);
					time_of_birth = time12hrs;
				}
				else
				{
					time_of_birth =" ";
				}
						
				if(data_obj.containsField("thayi_card_no"))
				{
					thayi_card_no = data_obj.getLong("thayi_card_no");
					//System.out.println("thayi_card_no:"+bd.thayi_card_no);
				}
				else
				{
					thayi_card_no =" ";
				}
				
				if(data_obj.containsField("baby_status"))
				{
					baby_status = data_obj.getString("baby_status");					
				}
				else
				{
					baby_status =" ";
				}
				
				if(data_obj.containsField("mother_name"))
				{
					mother_name = data_obj.getString("mother_name");;
				}
				else
				{
					mother_name =" ";
				}
				
				if(data_obj.containsField("sex"))
				{
					sex = data_obj.getString("sex");					
				}
				else
				{
					sex =" ";
				}
				
				if(data_obj.containsField("phone2"))
				{
					phone2 = data_obj.getLong("phone2");
				}
				else
				{
					phone2=" ";
				}
					
				if(data_obj.containsField("phone1"))
				{
					phone1 = data_obj.getLong("phone1");
				}
				else
				{
					phone1=" ";
				}
				
				if(data_obj.containsField("birth_weight"))
				{
					birth_weight = data_obj.getInt("birth_weight");
					//System.out.println("birth_weight:"+bd.birth_weight);
				}	
				else
				{
					birth_weight =" ";
				}
				
				if(data_obj.containsField("husband_name"))
				{
					husband_name = data_obj.getString("husband_name");
				}
				else
				{
					husband_name =" ";
				}
				
				if(data_obj.containsField("half"))
				{
					half = data_obj.getString("half");
				}
				else
				{
					half =" ";
				}
				
				if(data_obj.containsField("surveyType"))
				{
					surveytype = data_obj.getString("surveyType");
				}				
				else
				{
					surveytype =" ";
				}
				
				// write out a records				
				csvOutput.write(u_id.toString());
				csvOutput.write(pid1.toString());
				csvOutput.write(mother_name.toString());
				csvOutput.write(husband_name.toString());
				csvOutput.write(dob.toString());
				csvOutput.write(time_of_birth.toString()+"  "+half.toString());				
				csvOutput.write(birth_weight.toString());
				csvOutput.write(sex.toString());
				csvOutput.write(baby_status.toString());
				csvOutput.write(phone1.toString());
				csvOutput.write(phone2.toString());
				csvOutput.write(thayi_card_no.toString());
				csvOutput.write(surveytype.toString());
				csvOutput.endRecord();
					/* System.out.println("Line="+i);
						System.out.println("Json array="+jsonArray.size()); */
			}
			csvOutput.close();
		}
		catch(Exception e)
		{
			System.out.println("Exception="+e);
		}
		return 1;
	}
	
	//kmc report
	public static int generateCSVKMC(ArrayList<DBObject> jsonArray,String outputFile, CsvWriter csvOutput, String filetype) throws IOException
	{		
		com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
		//boolean alreadyExists = new File(outputFile).exists();
		//CsvWriter csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
		//System.out.println("inside csv kmc java ="+jsonArray.size()+" type="+filetype);
		
		try
		{
			BasicDBObject comp_obj = null;			
			List<BasicDBObject> kmc_array=new ArrayList<BasicDBObject>();;
			// else assume that the file already has the correct header line
			for(int i=0; i<jsonArray.size(); i++)
			{							
				//fetch kmc initiation data
				if(filetype.equals("kmcinit"))
				{
					System.out.println("Line1="+i);						
					comp_obj = (BasicDBObject)jsonArray.get(i);	
					//System.out.println("kmcinit_docs = "+comp_obj);
					if(comp_obj.containsField("unique_id"))
					{
						u_id = comp_obj.get("unique_id");
					}
					else
					{
						u_id =" ";
					}
					
					if(comp_obj.containsField("kmc_reg_no"))
						kmc_reg_no = comp_obj.get("kmc_reg_no");
					else
						kmc_reg_no =" ";	
					
					if(comp_obj.containsField("kmc_initiation"))
						kmc_initiation = comp_obj.get("kmc_initiation");
					else
						kmc_initiation =" ";
					
					if(comp_obj.containsField("date_of_kmc_initiation"))
						date_of_kmc_initiation = comp_obj.get("date_of_kmc_initiation");
					else
						date_of_kmc_initiation =" ";
					
					if(comp_obj.containsField("time_of_kmc_initiation"))
						time_of_kmc_initiation = comp_obj.get("time_of_kmc_initiation");
					else
						time_of_kmc_initiation =" ";
					
					if(comp_obj.containsField("am_pm"))
						am_pm = comp_obj.get("am_pm");	
					else
						am_pm =" ";
					
					if(comp_obj.containsField("kmc_provider"))
					{														
						kmc_provider = comp_obj.get("kmc_provider");				
					}
					else
						kmc_provider =" ";
					
					if(comp_obj.containsField("feed_type"))
					{
						kmc_feed_type = comp_obj.get("feed_type");
					}
					else
						kmc_feed_type =" ";
					
					if(comp_obj.containsField("reason_for_dalay"))
					{
						reason = comp_obj.get("reason_for_dalay");
					}
					else
						reason =" ";
					
					if(kmc_initiation.equals("Discharged without initiation"))
					{			
						csvOutput.write(u_id.toString());
						csvOutput.write(kmc_reg_no.toString());
						csvOutput.write(kmc_initiation.toString());															
						csvOutput.endRecord();											
					}
					else
					{
						csvOutput.write(u_id.toString());
						csvOutput.write(kmc_reg_no.toString());
						csvOutput.write(kmc_initiation.toString());
						csvOutput.write(reason.toString());
						csvOutput.write(date_of_kmc_initiation.toString());
						csvOutput.write(time_of_kmc_initiation.toString());
						csvOutput.write(am_pm.toString());
						csvOutput.write(kmc_provider.toString());
						csvOutput.write(kmc_feed_type.toString());
						csvOutput.endRecord();
					}
				}
				else if(filetype.equals("kmcdetails"))
				{
					//System.out.println("size of array in kmc details java ="+jsonArray.size());
					comp_obj = (BasicDBObject)jsonArray.get(i);	
					System.out.println("kmcdetails_docs = "+comp_obj);
					if(comp_obj.containsField("unique_id"))
					{
						u_id = comp_obj.get("unique_id");
					}
					else
					{
						u_id =" ";
					}
					if(comp_obj.containsField("date"))
					{
						kmc_date = comp_obj.get("date");
					}
					else
					{
						kmc_date =" ";
					}
					if(comp_obj.containsField("kmc_done"))
					{
						kmc_done = comp_obj.get("kmc_done");
					}
					else
					{
						kmc_done =" ";
					}
					if(comp_obj.containsField("discharged"))
					{
						BasicDBList disch = (BasicDBList)comp_obj.get("discharged");
						discharged = disch.get(0);
					}
					else
					{
						discharged =" ";
					}
					
					if(comp_obj.containsField("kmc_time_slots_today"))
					{
						BasicDBList kmc_slot = (BasicDBList)comp_obj.get("kmc_time_slots_today");						
						for(int k=0; k<kmc_slot.size(); k++)
						{
							BasicDBObject kmc_slot_obj = (BasicDBObject)kmc_slot.get(k);
							System.out.println("kmc slots ="+kmc_slot_obj);
							if(kmc_slot_obj.containsField("from"))
							{
								kmc_from_time = kmc_slot_obj.get("from");
							}
							else
								kmc_from_time = " ";
							
							if(kmc_slot_obj.containsField("to"))
								kmc_to_time = kmc_slot_obj.get("to");
							else
								kmc_to_time = " ";
							
							if(kmc_slot_obj.containsField("from_meridian"))
								kmc_from_meridian = kmc_slot_obj.get("from_meridian");
							else
								kmc_from_meridian = " ";
							
							if(kmc_slot_obj.containsField("to_meridian"))
								kmc_to_meridian = kmc_slot_obj.get("to_meridian");
							else
								kmc_to_meridian = " ";
							
							csvOutput.write(u_id.toString());							
							csvOutput.write(kmc_date.toString());
							csvOutput.write(kmc_done.toString());															
							csvOutput.write(kmc_from_time.toString());
							csvOutput.write(kmc_from_meridian.toString());
							csvOutput.write(kmc_to_time.toString());
							csvOutput.write(kmc_to_meridian.toString());
							csvOutput.write(discharged.toString());
							csvOutput.endRecord();
						}
					}	
					else
					{
						csvOutput.write(u_id.toString());						
						csvOutput.write(kmc_date.toString());
						csvOutput.write(kmc_done.toString());
						csvOutput.endRecord();
					}
				}
			}//close for loop of comp_docs
			csvOutput.close();
		}
		catch(Exception e)
		{
			System.out.println("Exception="+e);
		}
		return 1;
	}
	
	//discharge report
	public static int generateCSVDischarge(ArrayList<DBObject> jsonArray,String outputFile, CsvWriter csvOutput) throws IOException
	{		
		com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
		//boolean alreadyExists = new File(outputFile).exists();
		//CsvWriter csvOutput = new CsvWriter(new FileWriter(outputFile), ',');
		try
		{
			// else assume that the file already has the correct header line
			for(int i=0; i<jsonArray.size(); i++)
			{
				System.out.println("Line1="+i);
				//System.out.println("json size ="+jsonArray.size());
				BasicDBObject dsch_obj=(BasicDBObject)jsonArray.get(i);
				System.out.println("disch_obj = "+dsch_obj);
				if(dsch_obj.containsField("unique_id"))
				{
					u_id = dsch_obj.get("unique_id");
				}
				else
				{
					u_id =" ";
				}
				if(dsch_obj.containsField("date_of_outcome"))
				{
					date_of_outcome=dsch_obj.get("date_of_outcome");
				}
				else
				{
					date_of_outcome =" ";
				}
				
				if(dsch_obj.containsField("time_of_discharge"))
				{
					time_of_discharge=dsch_obj.get("time_of_discharge");
				}
				else
				{
					time_of_discharge =" ";
				}
					
				if(dsch_obj.containsField("meridian"))
				{
					meridian=dsch_obj.get("meridian");
				}	
				else
				{
					meridian =" ";
				}
				
				csvOutput.write(u_id.toString());				
				csvOutput.write(date_of_outcome.toString());
				csvOutput.write(time_of_discharge.toString());
				csvOutput.write(meridian.toString());
				csvOutput.endRecord();			
			}
			csvOutput.close();
		}
		catch(Exception e)
		{
			System.out.println("Exception="+e);
		}
		return 1;
	}
	public static void main(String arg[])
	{
		
	}
}
