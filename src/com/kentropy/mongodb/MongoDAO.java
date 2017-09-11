package com.kentropy.mongodb;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.WriteResult;
import com.mongodb.client.MongoDatabase;
import com.mongodb.util.JSON;

import org.bson.types.ObjectId;

/**
 * This code having getBaby(),getDateRange(),getPendingKMCInitiation(),queryBabiesByFacility(),executeQuery(),
 * getKMCInitiated(),getPendingDischarge(),getBabiesForPeriod(),getMongoClient(),Duplicate(), update().
 *
 */
public class MongoDAO 
{
	public static MongoClient mongo= null;
	public String db=null;
	public String collection=null;
	
	//constructor
	/**
	 * Constructor use to create object 
	 *@param db - database name
	 *@param collection - collection name
	 *@version 1.0 2016
	 */
	public MongoDAO(String db,String collection)
	{
		this.db=db;
		this.collection=collection;		
	}
	
	//mongoclient initialization
		/**
		 * This method id used for mongoclient initiation
		 */
		public static MongoClient getMongoClient()
		{
			return mongo;
		}
		
	/**
	 *query to get the only mother details using unique_id
	 * @param unique_id - unique_id of the baby
	 * @return list of objects
	 * @version 1.0 2016
	 */
	public  ArrayList<DBObject> getBaby(String uniqueId)
	{
		MongoDatabase db1=mongo.getDatabase(db);
		System.out.println("unique_id inside getBaby() = "+uniqueId);
		String qry="[{$project:" +
				"{facility:{$arrayElemAt: [\"$data\",0]}," +
						"baby_NoKMC:{$arrayElemAt: [\"$data\",1]}}}," +
								"{$unwind: \"$baby_NoKMC\"}," +
										"{$match:{\"baby_NoKMC.unique_id\":{$eq:\""+uniqueId+"\"}}}]";			
		 return executeQuery(qry);			
	}
	
	/**
	 * This method used to insert data into collection
	 * @param json - string 	 
	 * @version 1.0, 2016
	 */
     public void insert(String json)
	 {
		DBObject obj = (DBObject)JSON.parse(json); //convert json string into DB object
	    WriteResult result = mongo.getDB(db).getCollection(collection).insert(obj); //insert objetc int collection
	 }
     
     	
	/**
	 * query to get the kmc,discharge,mother details of the baby using unique_id
	 * @param unique_id - unique_id of the baby
	 * @return list of object
	 * @version 1.0, 2016
	 */
	public  ArrayList<DBObject> getBaby1(String uniqueId)
	{
		String str="";
		String facilityQuery="";
		String match="\"data.unique_id\":{$eq:\""+uniqueId+"\"}";
		String matchQ=	"	              {	                  $match:{"+match+facilityQuery+""+"}" +
					"}" ;
			str="["+babyQuery1+","+matchQ+                   
			      "]";
			//System.out.println("Query = "+str);					
			return executeQuery(str);	
	}
	
	/**
	 * This method used to create a vector using start date and end date
	 * @param start - start date
	 * @param end - end date
	 * @return Vector of type Date
	 * @version 1.0, 2016
	 */
	public Vector<Date> getDateRange(Date start,Date end)
	{
		Vector<Date> v  = new Vector<Date>();
		Calendar cal=Calendar.getInstance();
		cal.setTime(start);
		Date tmp=start;
		v.add(start);
		while(end.after(tmp))
		{
			cal.add(Calendar.DATE,1);
			tmp=cal.getTime();
			v.add(tmp);
		}
		return v;
	}
	
	//query to get baby, kmc, discharge deatils of the baby using lookup
	String babyQuery1="{$project:{\"_id\":\"$_id\",facility:{$arrayElemAt:[\"$data\", 0]}," +
		"	              data:{$arrayElemAt:[\"$data\", 1]}}}," +
		"	              {$unwind:\"$data\"}," +
				"	              {$lookup:{" +
				"	                      from:\"kmc\"," +
				"	                      localField:\"data.unique_id\"," +
				"	                      foreignField:\"unique_id\"," +
              		"	                      as:\"comp_docs\"" +
              		"	              }}," +
              		 "{$lookup:{" +
						"	                      from:\"discharge\"," +
						"	                      localField:\"data.unique_id\"," +
						"	                      foreignField:\"unique_id\"," +
                      		"	                      as:\"discharge_docs\"" +
                      		"	              }}";
	
	/**
	 * query to get the list of babies present b/w given dob, facility
	 * @param facility - facility value
	 * @param datefrom - baby dob
	 * @param dateto - baby dob
	 * @return list of objects
	 * @version 1.0, 2017
	 */
	public  ArrayList<DBObject> babiesByDOB(String facility, String datefrom, String dateto)
	{
		String str="";
		String match="\"$and\":[{\"data.dob1\":{\"$gte\":'"+datefrom+"',\"$lte\":'"+dateto+"'}}],"
					+ "$or:[{\"facility.facility\":{\"$in\":["+facility+"]}}]";		
		
		String matchQ=	"{$match:{"+match+""+"}" +
					"}" ;
			str="["+babyQuery1+","+matchQ+",{$sort:{\"data.dob1\":1}}]";
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}	
	
	/**
	 * query to get the details of babies which are pending for kmc initiation
	 * @param facility - facility value
	 * @return list of objects
	 * @version 1.0, 2017
	 */
	public ArrayList<DBObject> getPendingKMCInitiation(int facility)
	{
		//return null;
		System.out.println("Facility = "+facility);
		String match = "\"discharge_docs\":{$eq:[]},\"comp_docs\":{$eq:[]}, " +
		"\"data.surveyType\":{$ne:'inborn_normal'}";		
		return queryBabiesByFacility(facility, match);	
	}
	
	/**
	 * query to get the details of babies which are pending for kmc initiation, filter by facility and period
	 * @param facility - facility value
	 * @param datefrom - from1 date
	 * @param dateto - from1 date
	 * @return list of objects
	 * @version 1.0, 2017
	 */
	public ArrayList<DBObject> getPendingKMCInitiation(String facility, String datefrom, String dateto)
	{
		//return null;
		System.out.println("Facility = "+facility);
		String match = "\"discharge_docs\":{$eq:[]},\"comp_docs\":{$eq:[]}, " +
		"\"data.surveyType\":{$ne:'inborn_normal'},"+
		"$or:[{\"facility.facility\":{\"$in\":["+facility+"]}}],"+
		"\"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'}";
		return queryByFacilityTaluk(match);	
	}
	
	/**
	 * query to get the babies details by facility and matching query
	 * @param facility - facility value
	 * @param match - matching query
	 * @return list of objects
	 * @version 1.0, 2017
	 */
	public  ArrayList<DBObject> queryBabiesByFacility(int facility, String match)
	{
		String str="";
		String facilityQuery="";
		if(facility!=1)
		{
			facilityQuery=",\"facility.facility\":"+facility+"";
		}
		String matchQ=	"{$match:{"+match+facilityQuery+""+"}}" ;
			str="["+babyQuery1+","+matchQ+                   
			      "]";
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}
	
	/**
	 * This method has query to get the babies details by matching query	 
	 * @param match - match query using $in operation
	 * @return list of objects
	 * @version 1.0, 2017
	 */
	public  ArrayList<DBObject> queryByFacilityTaluk(String match)
	{
		String str="";				
		String matchQ=	"{$match:{"+match+""+"}" +
					"}" ;
			str="["+babyQuery1+","+matchQ+",{$sort:{\"facility.from1\":1}}]";
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}
	
	/**
	 * This method has query to get the babies details by facility and match query with sort by period
	 * @param facility - facility value
	 * @param match - matching query
	 * @return list of objects
	 * @version 1.0, 2017
	 */
	public  ArrayList<DBObject> queryBabiesByPeriodSort(int facility, String match)
	{
		String str="";
		String facilityQuery="";
		if(facility!=1)
		{
			facilityQuery=",\"facility.facility\":"+facility+"";
		}
		String matchQ=	"	              {	                  $match:{"+match+facilityQuery+""+"}" +
					"}";
			str="["+babyQuery1+","+matchQ+",{$sort:{\"facility.from1\":1}}]";
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}
	
	/**
	 * This method has query to get the babies details by facility, match query, limit, skip
	 * @param facility - facility value
	 * @param match - match query
	 * @param limit - limit the no. of records per page
	 * @param skip - skip the above no. of records
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public  ArrayList<DBObject> queryByLimitPerPage(int facility, String match, int limit, int skip)
	{
		String str="";
		String facilityQuery="";
		if(facility!=1)
		{
			facilityQuery=",\"facility.facility\":"+facility+"";
		}
		String matchQ=	"{$match:{"+match+facilityQuery+""+"}" +
					"}" ;
			str="["+babyQuery1+","+matchQ+",{$skip:"+skip+"},{$limit:"+limit+"}" +                  
			      "]";
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}
	
	/**
	 This method has query to get the babies details by facility, match query, limit, skip with period sort
	 * @param facility - facility value
	 * @param match - match query
	 * @param limit - limit the no. of records per page
	 * @param skip - skip the above no. of records
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public  ArrayList<DBObject> queryByLimitPerPage(String facility, String match, int limit, int skip)
	{
		String str="";		
		String matchQ=	"{$match:{"+match+""+"}" +
					"}" ;
			str="["+babyQuery1+","+matchQ+",{$sort:{\"facility.from1\":1}},{$skip:"+skip+"},{$limit:"+limit+"}" +                  
			      "]";
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}	
	
	/**
	 * This method use to execute queries
	 * @param str - Passing query
	 * @return list of objects
	 * @version 1.0 2016
	 */
    public ArrayList<DBObject> executeQuery(String str)
    {
    	//System.out.println("str inside execute query = "+str);	    	
    	java.util.List<DBObject> list = (java.util.List<DBObject>)JSON.parse(str);	
    	//System.out.println("List size in mongo execute query= "+list.size());
    	Iterable<DBObject> output = mongo.getDB(db).getCollection(collection).aggregate(list).results(); 
    	//System.out.println("output in mongo execute query= "+output);
	    ArrayList<DBObject> jsonlist = new ArrayList<DBObject>();
	    try
	    {	    	
		   for(DBObject dbobj: output)
		   {	    	  
		    	//System.out.println("data at mongodao = "+dbobj);
		    	jsonlist.add(dbobj);
		    }	      
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace(); 
	    }	    
	    return jsonlist;
	}
   
	//kmc initiation
    /**
	 * This method has query to get the kmc initiated babies 
	 * @param facility - facility value
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> getKMCInitiated(int facility)
	{
		System.out.println("Facility in mongoDAO page= "+facility);
		String match = "\"discharge_docs\":{$eq:[]},\"comp_docs\":{$ne:[]}, "
				+ "\"comp_docs.init_date1\":{$exists:true}," +
		"\"data.surveyType\":{$ne:'inborn_normal'}";		
		
		return queryBabiesByFacility(facility, match);
	}	
		
	 /**
	 * This method has match query to get babies pending for discharge
	 * @param facility - facility value
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> getPendingDischarge(int facility)
	{
		System.out.println("Facility = "+facility);
		String match = "\"discharge_docs\":{$eq:[]}, " +
		"\"data.surveyType\":{$ne:'inborn_normal'}";
		return queryBabiesByFacility(facility, match);
	}
	
	/**
	 * This method has match query to get the babies which are pending for kmc initiation and 
	 * discharged without entering discharge details 
	 * @param facility - facility value
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> kmcDischargeRecords(int facility)
	{
		System.out.println("Facility = "+facility);
		String match = "\"discharge_docs\":{$eq:[]},"+
				"\"comp_docs\":{$ne:[]}," +
				"\"data.surveyType\":{$ne:'inborn_normal'}";
		return queryBabiesByFacility(facility, match);
	}
	
	/**
	 * This method has match query to get the babies which are pending for kmc initiation and 
	 * discharged without entering discharge details with records per page method
	 * @param facility - facility value
	 * @param limit - limit no. of. records per page
	 * @param skip - no. of records to be skip
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> kmcDischargeRecordsByLimit(int facility, int limit, int skip)
	{
		System.out.println("Facility = "+facility);		
		String match = "\"discharge_docs\":{$eq:[]},"+	
				"\"comp_docs\":{$ne:[]}," +
				"\"data.surveyType\":{$ne:'inborn_normal'}";
		return queryByLimitPerPage(facility, match, limit, skip);
	}	
	
	/**
	 * This method has match query to get the babies which are pending for kmc initiation and 
	 * discharged without entering discharge details with records per page method, $in operation
	 * @param facility - facility value
	 * @param limit - limit no. of. records per page
	 * @param skip - no. of records to be skip
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> kmcDischargeRecordsByLimit(String facility, int limit, int skip)
	{
		System.out.println("Facility = "+facility);		
		String match = "\"discharge_docs\":{$eq:[]},"+	
				"\"comp_docs\":{$ne:[]}," +
				"$or:[{\"facility.facility\":{\"$in\":["+facility+"]}}],"+
				"\"data.surveyType\":{$ne:'inborn_normal'}";
		return queryByLimitPerPage(facility, match, limit, skip);
	}
	
	/**
	 * This method has match query to get the details of the discharged babies with records per page method
	 * @param facility - facility value
	 * @param limit - limit no. of. records per page
	 * @param skip - no. of records to be skip
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> dischargedBabiesWithLimit(int facility, int limit, int skip)
	{
		System.out.println("Facility = "+facility);		
		String match = "\"discharge_docs\":{$ne:[]},"+				
				"\"data.surveyType\":{$ne:'inborn_normal'}";
		return queryByLimitPerPage(facility, match, limit, skip);
	}
	
	/**
	 * This method has match query to get the details of the discharged babies b/w given discharged dates
	 * @param facility - facility value
	 * @param datefrom - discharged date
	 * @param dateto - discharged date
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> dischargedBabies(String facility, String datefrom, String dateto)
	{
		String sortby="dischDate";
		System.out.println("Facility = "+facility);		
		String match = "\"discharge_docs\":{$ne:[]},"+				
				"\"data.surveyType\":{$ne:'inborn_normal'},"+
				"$or:[{\"facility.facility\":{\"$in\":["+facility+"]}}],"+
				"\"discharge_docs.outcome_date1\":{$gte:'"+datefrom+"',$lt:'"+dateto+"'}";
		return queryBabiesByPeriodTalukSort(match,sortby);
	}
	
	/**
	 * This method has match query to count no. of. lbws,normal,kmc initiated babies, 
	 * discharged babies, kmc initiated but not discharged babies b/w given dates
	 * @param facility - facility value	 
	 * @param datefrom = baby dob
	 * @param dateto = baby dob
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> totalBabyCount(int facility, String datefrom, String dateto)
	{
		System.out.println("Facility = "+facility);		
		//String match = "\"_id\":{$gte:{'$oid':'"+obfrom+"'}, $lte:{'$oid':'"+obto+"'}},";
		String match = "\"data.dob1\":{$gte:'"+datefrom+"',$lt:'"+dateto+"'}";
				//match+= "\"data.surveyType\":{$ne:'inborn_normal'}";
		return queryBabiesByFacility(facility, match);
	}
	
	/**
	 * This method has match query to count no. of. lbws,normal,kmc initiated babies, 
	 * discharged babies, kmc initiated but not discharged babies. using $in operation
	 * @param facility - facility value	 
	 * @param datefrom = baby dob
	 * @param dateto = baby dob
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> totalBabyCount(String facility, String datefrom, String dateto)
	{
		String sortby="dob";
		System.out.println("Facility = "+facility);
		String match = "\"data.dob1\":{$gte:'"+datefrom+"',$lt:'"+dateto+"'},"+
				"$or:[{\"facility.facility\":{\"$in\":["+facility+"]}}]";
		return queryBabiesByPeriodTalukSort(match, sortby);
	}
		
	/**
	 * This method has match query to get list of the babies which are still in 7th day life(whether discharged/not), 
	 * baby under 28th day life but discharged with in 7th day life,  
	 * baby under 28th day life	 
	 * @param facility - facility value
	 * @param kmcPeriod = kmcperiod of the baby
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> getBabiesForPeriod(String facility,int kmcPeriod)
	{		
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String tc_7=sdf.format(cal.getTime());
		cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH,-28);
		String tc_28=sdf.format(cal.getTime());
		System.out.println(tc_28);
		System.out.println(tc_7);
		String periodFilter="";
		String[] periodFilters= {"","",",\"data.dob1\":{$lte:'"+tc_7+"',$gt:'"+tc_28+"'},$or:[{\"discharge_docs.outcome_date1\":{$gt:'"+tc_7+"'}},{\"discharge_docs.outcome_date1\":{$exists:false}}]",//1st option
				",\"discharge_docs.outcome_date1\":{$lte:'"+tc_7+"'},\"data.dob1\":{$gt:'"+tc_28+"'}",//2nd option
				",\"data.dob1\":{$lte:'"+tc_28+"'}"//3rd option
				};
		System.out.println("Facility = "+facility);
		String match = " " +
		"\"data.surveyType\":{$ne:'inborn_normal'}, \"comp_docs.kmc_reg_no\":{$exists:true}"+periodFilters[kmcPeriod]
				+ ",\"facility.facility\":{\"$in\":["+facility+"]}";
		return queryByFacilityTaluk(match);
	}
	
	/**
	 * This method has match query to get list of the babies which are still in 7th day life(whether discharged/not), 
	 * baby under 28th day life but discharged with in 7th day life,  
	 * baby under 28th day life	with limits per page
	 * @param facility - facility value
	 * @param kmcPeriod = kmcperiod of the baby
	 * @param limit - no. of. records per page
	 * @param skip - skip no. of. records
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> getBabiesForPeriodCC(int facility,int kmcPeriod,int limit, int skip)
	{
		
		System.out.println("Facility = "+facility+"KMCPeriod="+kmcPeriod+"Limit="+limit+"skip="+skip);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String tc_7=sdf.format(cal.getTime());
		cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH,-28);
		String tc_28=sdf.format(cal.getTime());
		System.out.println(tc_28);
		System.out.println(tc_7);
		String periodFilter="";
		String[] periodFilters= {"","",",\"data.dob1\":{$lte:'"+tc_7+"'},\"data.dob1\":{$gt:'"+tc_28+"'},\"discharge_docs.date_of_outcome\":{$gte:'"+tc_7+"'}",
				",\"discharge_docs.date_of_outcome\":{$lte:'"+tc_7+"'},\"data.dob1\":{$gt:'"+tc_28+"'}",
				",\"data.dob1\":{$lte:'"+tc_28+"'}"
				};
		System.out.println("Facility = "+facility);
		String match = " " +
		"\"data.surveyType\":{$ne:'inborn_normal'}"+periodFilters[kmcPeriod];
		return queryByLimitPerPage(facility, match, limit, skip);
		//return queryBabiesByFacility(facility, match);
	}
	
	//duplicates methods
	/**
	 * This used to get details of the baby by uniqueID
	 * @param uniqueId - Baby UniqueId
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> getRecordByUniqueid(String uniqueId)
	{
		MongoDatabase db1=mongo.getDatabase(db);
		String uniqueIdQuery = "[{$project: {output:{$arrayElemAt: [\"$data\",1]},facility:{$arrayElemAt: [\"$data\",0]}}},"
		+ "{$unwind: \"$output\"},{$unwind: \"$facility\"},"
		   + "{$match: {\"output.unique_id\":\""+uniqueId+"\"}}]";
	
		return executeQuery(uniqueIdQuery);
	}
	
	/**
	 * This has query to get the duplicates babies
	 * @return list of objects
	 * @version 1.0 2017
	 */	
	public ArrayList<DBObject> getDuplicates()
	{
		MongoDatabase db1=mongo.getDatabase(db);
		String str = "[{$project:{\"_id\":1,data:{$arrayElemAt:[\"$data\", 1]}}},"
                         +"{$unwind:\"$data\"},"
                          +"{$match:{\"data.pid1\":{$exists:true}, \"data.surveyType\":{$ne:\"inborn_normal\"}}},"
                          +"{$group:{_id:{pid:\"$data.pid1\",mother_name:\"$data.mother_name\", dob1:\"$data.dob1\",birth_weight:\"$data.birth_weight\",time_of_birth:\"$data.time_of_birth\",surveyType:\"$data.surveyType\"},"                    
                          +"count:{$sum:1}}},"
                         +"{$match:{count:{$gt:1}}}]";
                     
		return executeQuery(str);
	}
	
	/**
	 * This method use to get details of babies based on time_of_birth and birth_weight
	 * @param birth_weight - birth_weight of baby
	 * @param time_of_birth - time_of_birth of baby
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public  ArrayList<DBObject> getDetails(Object birth_weight,Object time_of_birth)
	{	
		String details = "[{$project:{\"_id\":1,data:{$arrayElemAt:[\"$data\", 1]},facility:{$arrayElemAt: [\"$data\",0]}}},"
                         +"{$unwind:\"$data\"},"
                         +"{$match: {'data.birth_weight':"+birth_weight+"}},"
                         +"{$match: {'data.time_of_birth':'"+time_of_birth+"'}}]";
		
		return executeQuery(details);		
	}
	 
	//This method is used to add status field for each duplicate document
	/**
	 * This method is used to add status field for each duplicate document
	 * @param u_id - unique_id of baby
	 * @version 1.0 2017
	 */
	public void update(Object u_id)
	{
		MongoDatabase db1=mongo.getDatabase(db);		
		BasicDBObject newDocument = new BasicDBObject();
		newDocument.append("$set", new BasicDBObject().append("data.1.$.status", 1));
		BasicDBObject searchQuery = new BasicDBObject().append("data.1.unique_id", u_id);
		WriteResult out= mongo.getDB(db).getCollection(collection).update(searchQuery, newDocument);
		System.out.println("out_data::"+out);		
	}
	
	/**
	 * This used to get details of the login user 
	 * @param role - user role
	 * @param uname - username
	 * @param pass - user password
	 * @return 
	 * @version 1.0 2017
	 */
	public int getUser(String role,String uname, String pass,String credentials)
	{
		try{
			MongoDatabase db1=mongo.getDatabase(db);
			BasicDBObject obj= new BasicDBObject();
			//obj.put("role", role);
			obj.put("username", uname);
			//obj.put("password", pass);
			DBCursor  out =   mongo.getDB(db).getCollection(credentials).find(obj);
			if(out.size()== 0){
				//User not found
				return -1;
			}
			else
			{
			System.out.println(out);
			while(out.hasNext()){
			DBObject dbobj = out.next();
			if(!dbobj.get("role").equals(role))
			{
				//role not matched
			    return -2;	
			}
			if(dbobj.get("role").equals(role))
			{ 
					
			  if(dbobj.get("password").equals(pass))
			  {
				   //Role & password matched
					return 2;
		      }
			  else
			  {
				  //role matched password  not matched
				  return -3;
			  }
			  
			}
			}	
			}
		}
		catch(Exception e){
			System.out.println(e);
		}
		return 0;
	}
	
	/**
	 * This is used get details of the kmc initiated babies
	 * @param facility - facility value
	 * @param dobFrom - baby dob date
	 * @param dobTo - baby dob date
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> kmcInitBabies(int facility, String dobFrom, String dobTo)
	{
		System.out.println("Facility in mongoDAO page= "+facility);
		String match = "\"data.surveyType\":{$ne:'inborn_normal'},comp_docs:{$ne:[]},\"data.dob1\":{$gte:\""+dobFrom+"\",$lt:\""+dobTo+"\"}";		
		return queryBabiesByFacility(facility, match);		
	}
	
	/**
	 * This is used to get details of kmc not initiated babies 
	 * @param facility - facility value
	 * @param dobFrom - baby dob date
	 * @param dobTo - baby dob date
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> kmcNotInitBabies(int facility, String dobFrom, String dobTo)
	{
		System.out.println("Facility in mongoDAO page= "+facility);
		String match = "\"data.surveyType\":{$ne:'inborn_normal'},comp_docs:{$eq:[]},\"data.dob1\":{$gte:\""+dobFrom+"\",$lt:\""+dobTo+"\"}";		
		return queryBabiesByFacility(facility, match);		
	}
	
	/**
	 * This method has query to get details of duplicate babies	group by mother,father name, dob
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> duplicateRecords()
	{		
		MongoDatabase db1=mongo.getDatabase(db);		
		String qry="[{$project:{data:{$arrayElemAt:[\"$data\", 1]}, facility:{$arrayElemAt:[\"$data\", 0]}}},";
				qry+="{$unwind:\"$data\"}, {$unwind:\"$facility\"},";
				qry+="{ $group: { ";
				qry+="_id: { mother: \"$data.mother_name\", dob: \"$data.dob\", father:\"$data.husband_name\"},";
				qry+="count: { $sum:  1 },";
				qry+="docs: { $push: \"$_id\" },";
				qry+="data:{$push:\"$data\"},";
				qry+="facility:{$push:\"$facility\"}";
				qry+="}},";
				qry+="{ $match: {";
				qry+="count: { $gt : 1 }, \"data.surveyType\":{$ne:\"inborn_normal\"},";
				qry+="$or:[{\"data.readmit\":{$exists:false}, \"data.group_id\":{$exists:false}}]";
				qry+="}}";
				qry+="]";
		System.out.println("query = "+qry);
		 return executeQuery(qry);		
	}
	
	/**
	 * This method has query to get details of babies for the given mother,husband name,dob
	 * @param mothername - mother name
	 * @param fathername - father name
	 * @param dob - baby dob
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> duplicateBabies(String mothername, String fathername, String dob)
	{		
		MongoDatabase db1=mongo.getDatabase(db);		
		String qry="[{$project:{data:{$arrayElemAt:[\"$data\", 1]}, facility:{$arrayElemAt:[\"$data\", 0]}}},";
				qry+="{$unwind:\"$data\"}, {$unwind:\"$facility\"},";
				qry+="{ $match: {";
				qry+="\"data.surveyType\":{$ne:\"inborn_normal\"},";
    			qry+="\"data.mother_name\":{$eq:'"+mothername+"'},";
    			qry+="\"data.husband_name\":{$eq:'"+fathername+"'},";
    			qry+="\"data.dob\":{$eq:'"+dob+"'},";
    			qry+="}}";
    			qry+="]";
		System.out.println("query = "+qry);
		 return executeQuery(qry);		
	}
	
	/**
	 * This is used to get lbw babies call success details sort by dob
	 * @param facility - facility value	 
	 * @param datefrom - baby dob
	 * @param dateto - baby dob
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> callSuccessBabies(int facility,String datefrom, String dateto)
	{
		System.out.println("Facility = "+facility);
		String match = "\"data.surveyType\":{$ne:'inborn_normal'},"; 
				match += "\"comp_docs.kmc_reg_no\":{$exists:true},";
				match += "\"data.dob1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},";
				match +="\"comp_docs.visit_date\":{$exists:true}";
		return queryBabiesByPeriodSort(facility, match);
	}
	
	/**
	 * This is used to get call success details babies sort by period	
	 *  @param facility - facility value	 
	 * @param datefrom - from period
	 * @param dateto - to period
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> kmcCCDetails(int facility,String datefrom, String dateto)
	{
		System.out.println("Facility = "+facility);
		String match = "\"data.surveyType\":{$ne:'inborn_normal'},"; 
				match += "\"comp_docs.kmc_reg_no\":{$exists:true},";
				match += "\"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},";
				match +="\"comp_docs.visit_date\":{$exists:true}";
		return queryBabiesByPeriodSort(facility, match);
	}
	
	/**
	 * This is used to get call success details of the babies filter by period,facility	
	 *  @param facility - facility value	 
	 * @param datefrom - from period
	 * @param dateto - to period
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> kmcCCDetails(String facility,String datefrom, String dateto)
	{
		String sortby="period";
		System.out.println("Facility = "+facility);
		String match = "\"data.surveyType\":{$ne:'inborn_normal'},"; 
				match += "\"comp_docs.kmc_reg_no\":{$exists:true},";
				match += "\"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},";
				match +="\"comp_docs.visit_date\":{$exists:true},"+
						"$or:[{\"facility.facility\":{\"$in\":["+facility+"]}}]";;
		return queryBabiesByPeriodTalukSort(match, sortby);
	}
	
	/**
	 * This is used to get call success and fail detail of the babies
	 * @param facility - facility value	 
	 * @param datefrom - baby dob
	 * @param dateto - baby dob
	 * @return list of babies
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> callSuccess_FailureBabies(int facility,String datefrom, String dateto)
	{
		System.out.println("Facilityin mongodao = "+facility);
		String match = "\"data.surveyType\":{$ne:'inborn_normal'},"; 
			   match += "\"comp_docs.kmc_reg_no\":{$exists:true},";
			   match += "\"data.dob1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},";
			   match += "$or: [{\"comp_docs.status\":{$exists:true}}, {\"comp_docs.visit_date\":{$exists:true}}]";
		return queryBabiesByFacility(facility, match);
	}
	
	/**
	 * This is used to get no. of. success and fail attempts made for each baby sort by period
	 * @param facility - facility value
	 * @param kmcPeriod - kmc period
	 * @param datefrom - from period
	 * @param dateto - to period
	 * @param birthWeight -  baby birth weight
	 **/
	public ArrayList<DBObject> callAttemptDetails(String facility,String datefrom, String dateto,int kmcPeriod, int birthWeight)
	{
		String sortby="period";
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String tc_7=sdf.format(cal.getTime());
		cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH,-28);
		String tc_28=sdf.format(cal.getTime());
		System.out.println(tc_28);
		System.out.println(tc_7);			
		String[] birthWeightFilter= {"","",",\"data.birth_weight\":{$lt:2000}",
				",\"data.birth_weight\":{$gte:2000, $lte:2499}",
				",\"data.birth_weight\":{$gte:2500}"};
		System.out.println("Facility = "+facility);
		String match = " " +
		"\"data.surveyType\":{$ne:'inborn_normal'}, \"comp_docs.kmc_reg_no\":{$exists:true},"
		+"$or:[{\"comp_docs.status\":{$exists:true}},{\"comp_docs.visit_date\":{$exists:true}}],"	
		+"\"facility.facility\":{\"$in\":["+facility+"]},"
		+ "\"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},"						
		+ "\"comp_docs.kmc_period\":{$eq:'"+kmcPeriod+"'}"+birthWeightFilter[birthWeight];
		return queryBabiesByPeriodTalukSort(match, sortby);		
	}
	
	/**
	 * This is used to get no. of. success and fail attempts made for each baby without sort
	 * @param facility - facility value
	 * @param kmcPeriod - kmc period
	 * @param datefrom - from period
	 * @param dateto - to period
	 * @param birthWeight -  baby birth weight
	 **/
	public ArrayList<DBObject> callAttemptDetails(int facility,String datefrom, String dateto,int kmcPeriod, int birthWeight)
	{
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String tc_7=sdf.format(cal.getTime());
		cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH,-28);
		String tc_28=sdf.format(cal.getTime());
		System.out.println(tc_28);
		System.out.println(tc_7);			
		String[] birthWeightFilter= {"","",",\"data.birth_weight\":{$lt:2000}",
				",\"data.birth_weight\":{$gte:2000, $lte:2499}",
				",\"data.birth_weight\":{$gte:2500}"};
		System.out.println("Facility = "+facility);
		String match = " " +
		"\"data.surveyType\":{$ne:'inborn_normal'}, \"comp_docs.kmc_reg_no\":{$exists:true},"
		+ "\"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},"
				+ "$or: [{\"comp_docs.status\":{$exists:true}}, {\"comp_docs.visit_date\":{$exists:true}}],"		
				+ "\"comp_docs.kmc_period\":{$eq:'"+kmcPeriod+"'}"+birthWeightFilter[birthWeight];
		return queryBabiesByPeriodSort(facility, match);		
	}
	
	/**
	 * This is used to get details of the babies b/w given dates and facility
	 * @param facility - facility value
	 * @param datefrom - from period
	 * @param dateto - to period
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> babyFacilityTalukArray(String facility,String datefrom, String dateto)
	{
		String sortby="period";
		System.out.println("SB="+facility);
		String match = "\"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},"
					+ "$or:[{\"facility.facility\":{\"$in\":["+facility+"]}}]";
		return queryBabiesByPeriodTalukSort(match,sortby);	
	}
	
	/**
	* This is used combine match query with sorting by period/dob/dischargedate
	* @param match - matching query
	* @param sortby - sortby field
	* @return list of objects
	* @version 1.0 2017
	*/
	public  ArrayList<DBObject> queryBabiesByPeriodTalukSort(String match, String sortby)
	{
		String str="";
		String facilityQuery="";
		String matchQ=	"{	$match:{"+match+facilityQuery+""+"}" +
				"}";
		if(sortby.equals("period"))			
		{
			str="["+babyQuery1+","+matchQ+",{$sort:{\"facility.from1\":1}}]";
		}
		else if(sortby.equals("dischDate"))
		{
			str="["+babyQuery1+","+matchQ+",{$sort:{\"discharge_docs.outcome_date1\":1}}]";
		}
		else if(sortby.equals("dob"))
		{
			str="["+babyQuery1+","+matchQ+",{$sort:{\"data.dob1\":1}}]";
		}
		else
		{
			str="["+babyQuery1+","+matchQ+"]"; //when no sorting
		}
		System.out.println("Query = "+str);	
		return executeQuery(str);	
	}
	
	/**
	 * This method has match query to get list of the babies which are still in 7th day life(whether discharged/not), 
	 * baby under 28th day life but discharged with in 7th day life,  
	 * baby under 28th day life	 
	 * @param facility - facility value
	 * @param kmcPeriod = kmcperiod of the baby
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> getBabiesForPeriod(int facility,int kmcPeriod)
	{
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String tc_7=sdf.format(cal.getTime());
		cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH,-28);
		String tc_28=sdf.format(cal.getTime());
		System.out.println(tc_28);
		System.out.println(tc_7);
		String periodFilter="";
		String[] periodFilters= {"","",",\"data.dob1\":{$lte:'"+tc_7+"',$gt:'"+tc_28+"'},$or:[{\"discharge_docs.outcome_date1\":{$gt:'"+tc_7+"'}},{\"discharge_docs.outcome_date1\":{$exists:false}}]",//1st option
				",\"discharge_docs.outcome_date1\":{$lte:'"+tc_7+"'},\"data.dob1\":{$gt:'"+tc_28+"'}",//2nd option
				",\"data.dob1\":{$lte:'"+tc_28+"'}"//3rd option
				};
		System.out.println("Facility = "+facility);
		String match = " " +
		"\"data.surveyType\":{$ne:'inborn_normal'}, \"comp_docs.kmc_reg_no\":{$exists:true}"+periodFilters[kmcPeriod];
		return queryBabiesByFacility(facility, match);
	}
	
	/**
	 * This is used to get under 28day's babies with period sort $in operation
	 * @param facility - facility value
	 * @param datefrom - from period
	 * @param dateto - to period
	 * @return list of objects
	 * @version 1.0 2017 
	 **/
	public ArrayList<DBObject> normal28dayBaby(String facility,String datefrom, String dateto)
	{
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String tc_7=sdf.format(cal.getTime());
		cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH,-28);
		String tc_28=sdf.format(cal.getTime());
		System.out.println(tc_28);
		System.out.println(tc_7);		
		System.out.println("Facility = "+facility);
		String match = " \"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'}," +
						"\"data.surveyType\":{$eq:'inborn_normal'},"
						+ "\"data.dob1\":{$lte:'"+tc_28+"'},"+
						"\"comp_docs.visit_date\":{$exists:false},"+
						"\"facility.facility\":{\"$in\":["+facility+"]}";
		return queryByFacilityTaluk(match);
	}
	
	/**
	 * This is used to get details of homebron babies 
	 * @param taluk - taluk code
	 * @param town - town code
	 * @param birthweight - baby weight
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> homeBornBabies(String taluk, String town, int birthweight)
	{
		String[] birthWeightFilter= {"", ",\"birth_weight\":{$lte:2000, $gte:1}",
				",\"birth_weight\":{$gt:2000}",
				",\"birth_weight\":{$eq:-1}"};		
		String str = null;
		
		if(taluk.equals("5"))
		{
			taluk="other";
		}
		if(town.equals("other"))
		{
			str = "[{"+
					"$match:{"+
					"\"taluk_from\":'"+taluk+"',"+
					"\"community_from\":{$eq:'"+town+"'}"+
					birthWeightFilter[birthweight]+
				"}},{$sort:{\"start_date1\":1}}]";
		}
		else
		{
			if(town.equals("1"))
			{
				str = "[{"+
						"$match:{"+
						"\"taluk_from\":'"+taluk+"'"+					
						birthWeightFilter[birthweight]+
					"}},{$sort:{\"start_date1\":1}}]";
			}
			else
			{
				str = "[{"+
						"$match:{"+
						"\"taluk_from\":'"+taluk+"',"+
						"\"community_from\":{$in:["+town+"]}"+
						birthWeightFilter[birthweight]+
					"}},{$sort:{\"start_date1\":1}}]";
			}
		}
		return executeQuery(str);	
	}
	
	/**
	 * This is used to get baby details b/w given dates
	 * @param datefrom - from period
	 * @param dateto = to period
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> generateBabydetails(String datefrom, String dateto)
	{
		String str = "[{"+
            "$project:{"+
            "facility:{$arrayElemAt:[\"$data\", 0]},"+ 
            "data:{$arrayElemAt:[\"$data\", 1]}}},"+              
             "{$unwind:\"$data\"}, "+
             "{$match:{"+
                         "\"facility.from1\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'},"+
                         "\"data.surveyType\":{$ne:\"inborn_normal\"}"+
             "}},"+ 
              "{$sort:{\"facility.from1\":1}}]";
		return executeQuery(str);	
	}
	
	/**
	 * This is used to combine matching queries
	 * @param match - match query
	 * @param sortby - sortby field
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public  ArrayList<DBObject> queryBabiesByMatch(String match, String sortby)
	{
		String str="";
		String s = sortby;
		String matchQ=	"{$match:{"+match+""+"}" +
					"}" ;	                  

		if(sortby.equals("period"))			
		{
			str="["+babyQuery1+","+matchQ+",{$sort:{\"facility.from1\":1}}]";
		}
		else if(sortby.equals("dischDate"))
		{
			str="["+babyQuery1+","+matchQ+",{$sort:{\"discharge_docs.outcome_date1\":1}}]";
		}
		else if(sortby.equals("dob"))
		{
			str="["+babyQuery1+","+matchQ+",{$sort:{\"data.dob1\":1}}]";
		}
		else
		{
			str="["+babyQuery1+","+matchQ+"]"; //when no sorting
		}
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}
	
	/**
	 * This is used to execute queries by passing collection name
	 * @param str - Passing query string
	 * @param collection - collection name
	 * @return list of objects
	 * @version 1.0 2017
	 */
    public ArrayList<DBObject> executeQuery(String str, String collection)
    {
    	System.out.println("str inside execute query = "+str);	
    	
    	java.util.List<DBObject> list = (java.util.List<DBObject>)JSON.parse(str);	
    	//System.out.println("List size in mongo execute query= "+list.size());
    	Iterable<DBObject> output = mongo.getDB(db).getCollection(collection).aggregate(list).results(); 
    	//System.out.println("output in mongo execute query= "+output);
	    ArrayList<DBObject> jsonlist = new ArrayList<DBObject>();
	    try
	    {	    	
		   for(DBObject dbobj: output)
		   {	    	  
		    	//System.out.println("data at mongodao = "+dbobj);
		    	jsonlist.add(dbobj);
		    }	      
	    }
	    catch(Exception e)
	    {
	    	e.printStackTrace(); 
	    }	    
	    return jsonlist;
	}
    
	/**
	 * This is used to get kmc provided babies details for the given dates
	 * @param datefrom - kmc provided date
	 * @param dateto - kmc provided date
	 * @param datefrom & dateto = from and to date of from1 period
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> generateKMCdetails(String datefrom, String dateto)
	{
		String str = "[{"+
                "$match:{"+
                        "\"date\":{$exists:true},"+
                        "\"date1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'}"+
                "}},"+
                "{$sort:{\"date1\":1}}]";
		return executeQuery(str,"kmc");		
	}
	
	/**
	 * This is used to get kmc initiated babies details for the given dates
	 * @param datefrom - kmc initiated date
	 * @param dateto - kmc initiated date
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> generateKMCinit(String datefrom, String dateto)
	{		
		String str = "[{"+
                "$match:{"+
                        "\"kmc_reg_no\":{$exists:true},"+
                        "\"init_date1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'}"+
                "}},"+
                "{$sort:{\"init_date1\":1}}]";
		return executeQuery(str,"kmc");	
	}
	
	/**
	 * This is used to gete discharged babies details for the given dates
	 * @param datefrom - discharged date
	 * @param dateto - discharged date
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> generateDischargedetails(String datefrom, String dateto)
	{
		String str = "[{"+
		    "$match:{"+
		        "\"date_of_outcome\":{$exists:true},"+
		        "\"outcome_date1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'}"+
		    "}},"+
		    "{$sort:{\"outcome_date1\":1}}]";
		    return executeQuery(str,"discharge");
	}	
	
	/**
	 * This is used to get details of the redcap csv files generated details for the given dates
	 * @param datefrom - file created date
	 * @param dateto - file created date
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> csvdata(String datefrom, String dateto)
	{
		String str = "[{$match:{"+
								"\"type\":{$ne:'redcap'},"+
                                "\"datefrom\":{$gte:'"+datefrom+"'},"+
                                "\"dateto\":{$lte:'"+dateto+"'}"+
                    "}}]";
		return executeQuery(str);	
	}
	
	/**
	 * This is used to get baby details by passing match query	
	 * @param match - match query
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public  ArrayList<DBObject> queryBabiesByFacility(String match)
	{
		String str="";		
		String matchQ=	"{$match:{"+match+"}}";
			str="["+babyQuery1+","+matchQ+                   
			      "]";
			System.out.println("Query = "+str);					
			return executeQuery(str);	
	}	
	
	/**
	 * This is used to get details of the babies entered for the given date
	 * @param startDt- entered date
	 * @param endDate - entered date
	 * @param facility - facility code
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> listOfBabiesEnteredOneday(Date startDt,Date endDate, String facility)
	{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String startdate = sdf.format(startDt);
		System.out.println("starte date ="+startdate);
		if(endDate==null)
		{	
			//calculate end date
			Calendar cal= Calendar.getInstance();
			cal.setTime(startDt);
			cal.add(Calendar.DATE, 1);
			endDate= cal.getTime();	
			//endDate=startDt;
		}
		String enddate = sdf.format(endDate);
		System.out.println("end date ="+enddate);
		String start=new ObjectId(startDt).toHexString();//startdate to objectid
		String end=new ObjectId(endDate).toHexString();//enddate to objectid
		System.out.println("start objid ="+start);
		System.out.println("end objid ="+end);
				String str=    "[{$project:{"+
				                           "facility:{$arrayElemAt:[\"$data\", 0]},"+
				                           "data:{$arrayElemAt:[\"$data\", 1]}}},"+
				                         "{$unwind:\"$data\"},{$match:{"+
				                         "\"_id\":{$gte:{$oid:\""+start+"\"},$lt: {$oid:\""+end+"\"}},";
				                         //"\"data.surveyType\":{$ne:\"inborn_normal\"},";
				                         if(!facility.equals("all"))
				                         {
				                        	str+= "\"facility.facility\":{$in:["+facility+"]}";
				                         }				                         
				                        str+="}}]";
		//System.out.println("executing listOfBabiesEnteredOneday");
					ArrayList<DBObject> l1=executeQuery(str);
					//System.out.println("L1="+l1);
					ArrayList<DBObject> l2=new ArrayList<DBObject>();
					for(DBObject doc1:l1)
					{
						//System.out.println(doc1);
						DBObject facilityarray=(DBObject)doc1.get("facility");
						DBObject data=(DBObject)doc1.get("data");	
						Object facv = facilityarray.get("facility");
						int facVal=0;
						if(facv instanceof Integer)
						{
							//System.out.println("facility in int");
							Integer fac = (Integer)facv;
							facVal=fac.intValue();
						}
						if(facv instanceof Double)
						{
							//System.out.println("facility in double");
							Double fac=(Double)facv;
							facVal=fac.intValue();
						}
						data.put("facility", facVal+"");
						//data.put("objectid",((ObjectId)doc1.get("_id")).getDate().toString());
						data.put("objectid",doc1.get("_id").toString());
						data.put("enteredDate",facilityarray.get("to_date"));
						l2.add(data);						
					}
					return l2;
	}
	
	/**
	 * This is used get details of the repeating babies which are having same dob, mothername, husband name
	 * @param startDt - document created date
	 * @param endDate - document created date
	 * @param dob - baby dob
	 * @param mother - mother name 
	 * @param father - husband name
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> listOfRepeatingBabies(Date startDt, Date endDate,String dob, String mother, String father)
	{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String startdate = sdf.format(startDt);
		//System.out.println("starte date ="+startdate);
		//calculate end date
		if(endDate==null)
		{
			Calendar cal= Calendar.getInstance();
			cal.setTime(startDt);
			cal.add(Calendar.DATE, 1);
			endDate= cal.getTime();
			//endDate = startDt;
		}	
		String enddate = sdf.format(endDate);
		//System.out.println("end date ="+enddate);
		
		String start=new ObjectId(startDt).toHexString();//startdate to objectid
		String end=new ObjectId(endDate).toHexString();//enddate to objectid
		//System.out.println("start objid ="+start);
		//System.out.println("end objid ="+end);
		
		String str="[{$project:{"+
				        "facility:{$arrayElemAt:[\"$data\", 0]},"+
				                                    "data:{$arrayElemAt:[\"$data\", 1]}}},"+
				                         "{$unwind:\"$data\"},{$match:{"+	
				                         "\"_id\":{$gte:{$oid:'58203bba8728b36accf07238'}, $lt:{$oid:'"+end+"'}},"+        
				                         //"\"data.surveyType\":{$ne:\"inborn_normal\"},"+
				                         "\"data.dob\":{$eq:'"+dob+"'},"+
				                         "\"data.mother_name\":{$eq:'"+mother+"'},"+
				                         "\"data.husband_name\":{$eq:'"+father+"'}"+
				                        "}}]";
		//System.out.println("executing listOfRepeatingBabies");
					ArrayList<DBObject> l1=executeQuery(str);
					ArrayList<DBObject> l2=new ArrayList<DBObject>();
					for(DBObject doc1:l1)
					{
						//System.out.println(doc1);
						DBObject facility=(DBObject)doc1.get("facility");
						DBObject data=(DBObject)doc1.get("data");	
						Object facv = facility.get("facility");
						int facVal=0;
						if(facv instanceof Integer)
						{
							//System.out.println("facility in int");
							Integer fac = (Integer)facv;
							facVal=fac.intValue();
						}
						if(facv instanceof Double)
						{
							//System.out.println("facility in double");
							Double fac=(Double)facv;
							facVal=fac.intValue();
						}											
						data.put("facility", facVal+"");
						//data.put("enteredDate",((ObjectId)doc1.get("_id")).getDate().toString());
						data.put("objectid",doc1.get("_id").toString());
						data.put("enteredDate",facility.get("to_date"));
						l2.add(data);						
					}					
					return l2;
	}
	
	/**
	 * This is used to get details of the unique babies (which are not duplicate, readmit)
	 * @param startDt - document created date
	 * @param endDate - document created date
	 * @param facility - facility code
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> listOfUniqueBabies(Date startDt, Date endDate,String facility)
	{
		System.out.println("collection used in unique query ="+collection);
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String startdate = sdf.format(startDt);
		System.out.println("starte date ="+startdate);
		//calculate end date
		if(endDate==null)
		{
			Calendar cal= Calendar.getInstance();
			cal.setTime(startDt);
			cal.add(Calendar.DATE, 1);
			endDate= cal.getTime();
			//endDate = startDt;
		}
		String enddate = sdf.format(endDate);
		System.out.println("end date ="+enddate);	
		
		String start=new ObjectId(startDt).toHexString();//startdate to objectid
		String end=new ObjectId(endDate).toHexString();//enddate to objectid
		/*System.out.println(start);
		System.out.println(end);
		*/
		System.out.println("executing listOfUniqueBabies");
		String str = "[{$project:{\"_id\":\"$_id\",facility:{$arrayElemAt:[\"$data\", 0]},"+    	              
                           "data:{$arrayElemAt:[\"$data\", 1]}}},"+    	              
                           "{$unwind:\"$data\"},"+
                           "{$lookup:{from:\"kmc\","+
                               "localField:\"data.unique_id\","+
                               "foreignField:\"unique_id\","+
                               "as:\"kmc_docs\"}},"+
                            "{$lookup:{from:\"discharge\","+
                               "localField:\"data.unique_id\","+
                               "foreignField:\"unique_id\","+
                              "as:\"discharge_docs\"}},"+
                           "{$match:{\"_id\":{$gte:{$oid:'"+start+"'}, $lt:{$oid:'"+end+"'}},"+
                           		"\"data.duplicateof\":{$exists:false},"+
                           		"\"data.readmitof\":{$exists:false},"+
                           		"\"data.surveyType\":{$ne:'inborn_normal'},";
                           		if(!facility.equals("all"))
		                         {
		                        	str+= "\"facility.facility\":{$in:["+facility+"]}";
		                         }				                         
		                        str+="}},{$sort:{\"facility.to1\":1}}]";
		    System.out.println("TOtal Unique babies query="+str);                    
			ArrayList<DBObject> l1=executeQuery(str);
			ArrayList<DBObject> l2=new ArrayList<DBObject>();
			for(DBObject doc1:l1)
			{
				//System.out.println(doc1);
				DBObject facilityarray=(DBObject)doc1.get("facility");
				DBObject data=(DBObject)doc1.get("data");
				BasicDBList kmc_list=(BasicDBList)doc1.get("kmc_docs");
				BasicDBList disch_list=(BasicDBList)doc1.get("discharge_docs");
				Object facv = facilityarray.get("facility");
				int facVal=0;
				if(facv instanceof Integer)
				{
					//System.out.println("facility in int");
					Integer fac = (Integer)facv;
					facVal=fac.intValue();
				}
				if(facv instanceof Double)
				{
					//System.out.println("facility in double");
					Double fac=(Double)facv;
					facVal=fac.intValue();
				}
				data.put("facility", facVal+"");
				//data.put("enteredDate",((ObjectId)doc1.get("_id")).getDate().toString());
				//data.put("objectid",doc1.get("_id").toString());
				data.put("enteredDate",facilityarray.get("to_date"));
				data.put("objectid",doc1.get("_id").toString());
				if(kmc_list.size()>0)
				{
					DBObject kmc_data=(DBObject)kmc_list.get(0);
					data.put("kmc_reg_no", kmc_data.get("kmc_reg_no"));
				}
				if(disch_list.size()>0)
				{
					DBObject disch_data=(DBObject)disch_list.get(0);
					data.put("date_of_outcome", disch_data.get("outcome_date1"));
				}
				l2.add(data);						
			}
			System.out.println("total unique babies ="+l2.size());
			return l2;	
	}
	
	/**
	 * This is used to establish a connection to mongodb
	 * @param host - mongodb ip address
	 * @param db - database name
	 * @param user - username
	 * @param pwd - password
	 * @param coll - collection name
	 * @return mongo object
	 * @version 1.0 2017
	 **/
	public static MongoDAO initMongodao(String host, String db, String user, String pwd,String coll)
	{		
		// TODO Auto-generated method stub
				mongo=new MongoClient("35.154.204.175", 27017);
				List<MongoCredential> credentials = new ArrayList<MongoCredential>();
		    	credentials.add(
		    	    MongoCredential.createScramSha1Credential(
		    	        "ken-admin",
		    	        user,
		    	        pwd.toCharArray()
		    	    )
		    	);
		    	ServerAddress sa = new ServerAddress(host);
		    	 mongo = new MongoClient( sa, credentials );
				MongoDAO mdao=new MongoDAO(db, coll);
				mdao.mongo=mongo;
				return mdao;
	}
	
	/**
	 * This is used to get cc details of the 28th day life normal babies 
	 * @param facility - facility value
	 * @param datefrom - from period
	 * @param dateto - to period
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> monitoringNormalBaby(String facility,String datefrom, String dateto)
	{
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		String tc_7=sdf.format(cal.getTime());
		cal=Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH,-28);
		String tc_28=sdf.format(cal.getTime());
		System.out.println(tc_28);
		System.out.println(tc_7);
		/*String periodFilter="";
		String[] periodFilters= {"","",",\"data.dob1\":{$lte:'"+tc_7+"',$gt:'"+tc_28+"'},$or:[{\"discharge_docs.outcome_date1\":{$gt:'"+tc_7+"'}},{\"discharge_docs.outcome_date1\":{$exists:false}}]",//1st option
				",\"discharge_docs.outcome_date1\":{$lte:'"+tc_7+"'},\"data.dob1\":{$gt:'"+tc_28+"'}",//2nd option
				",\"data.dob1\":{$lte:'"+tc_28+"'}"//3rd option
				};*/
		System.out.println("Facility = "+facility);
		String match = " \"facility.from1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'}," +
						"\"data.surveyType\":{$eq:'inborn_normal'},"
						+ "\"data.dob1\":{$lte:'"+tc_28+"'},"+
						"\"comp_docs.visit_date\":{$exists:true},"+
						"\"comp_docs.surveyType\":{$eq:'normal_cc'},"+
						"\"facility.facility\":{\"$in\":["+facility+"]}";
		return queryByFacilityTaluk(match);
	}
	
	/**
	* This is used to get details of the babies (after 20% sampling from redcap collection) for the given dates
	* @param datefrom - document created date
	* @param dateto - document created date
	* @param facility - facility code
	* @return list of objects
	* @version 1.0 2017
	*/
	public ArrayList<DBObject> generateRedcapData(Date datefrom, Date dateto,String facility)
	{	
	String obj1 = new ObjectId(datefrom).toHexString();
	String obj2 = new ObjectId(dateto).toHexString();
	System.out.println("Objid1 = "+obj1);
	System.out.println("Objid2 = "+obj2);
	String str = "[{"+
	  "$match:{"+
	    "\"objectid\":{$gte:'"+obj1+"', $lt:'"+obj2+"'},";
	//        "\"_id\":{$gte:{$oid:'"+obj1+"'}, $lte:{$oid:'"+obj2+"'}},";
	//"\"kmc_reg_no\":{$exists:true}";
	      if(!facility.equals("all"))
	          {
	         	str+= "\"facility\":'"+facility+"'";
	          }	                        
	         str+="}}]";
	System.out.println("Query redcap="+str);
	  return executeQuery(str,"redcap");
	}
	
	/**
	* This is used to get details of the discharged babies (after 20% sampling from redcap collection) for the given dates
	* @param datefrom -discharged date
	* @param dateto - discharged date
	* @param facility - facility code
	* @return list of objects
	* @version 1.0 2017
	*/
	public ArrayList<DBObject> generateRedcapDischarge(String datefrom, String dateto,String facility)
	{	
		String str = "[{"+
	  "$match:{"+
	"\"date_of_outcome\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'}";
		   //"\"dod_ent\":{$gte:'"+datefrom+"', $lt:'"+dateto+"'}";
	      if(!facility.equals("all"))
	          {
	         	str+= "\"facility\":'"+facility+"'";
	          }	                        
	         str+="}}]";
	System.out.println("Query redcap="+str);
	  return executeQuery(str,"redcap");
	}
	

	/**
	 * This is used to get details of the home born babies for the given dates
	 * @param datefrom - date of listing
	 * @param dateto - date of listing
	 * @param taluk - taluk code
	 * @param town - community code
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> monitoringHomebornBaby(String taluk, String town, String datefrom, String dateto)
	{		
		String str = null;		
		if(taluk.equals("5")) //when taluk other
		{
			taluk="other";
		}
		if(town.equals("other")) //when cocmmunity other
		{
			str = "[{"+
					"$match:{"+
					"\"taluk_from\":'"+taluk+"',"+
					"\"community_from\":{$eq:'"+town+"'},"+	
					"\"start_date1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'}"+
				"}},{$sort:{\"start_date1\":1}}]";
		}
		else
		{
			if(town.equals("1"))//community all
			{
				str = "[{"+
						"$match:{"+
						"\"taluk_from\":'"+taluk+"',"+
						"\"start_date1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'}"+
					"}}]";
			}
			else 
			{
				str = "[{"+
						"$match:{"+
						"\"taluk_from\":'"+taluk+"',"+
						"\"community_from\":{$in:["+town+"]},"+
						"\"start_date1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'}"+
					"}},{$sort:{\"start_date1\":1}}]";
			}
		}
		return executeQuery(str);	
	}
	
	/**
	 * This is used get list of repeating mother for the given dates (using $group operation)
	 * @param startDt - document created date
	 * @param endDate - document created date
	 * @param facvalue - facility code
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> listOfRepeatingMother(Date startDt, Date endDate, String facvalue)
	{
		System.out.println("executing listOfRepeatingmother");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String startdate = sdf.format(startDt);
		//System.out.println("starte date in java="+startdate);
		//calculate end date
		if(endDate==null)
		{
			Calendar cal= Calendar.getInstance();
			cal.setTime(startDt);
			cal.add(Calendar.DATE, 1);
			endDate= cal.getTime();
		}	
		String enddate = sdf.format(endDate);
		//System.out.println("end date in java="+enddate);
		
		String start=new ObjectId(startDt).toHexString();//startdate to objectid
		String end=new ObjectId(endDate).toHexString();//enddate to objectid
		//System.out.println("start objid ="+start);
		//System.out.println("end objid ="+end);
		
		String str="[{$project:{facility:{$arrayElemAt:[\"$data\", 0]},"+
                               "data:{$arrayElemAt:[\"$data\", 1]}}},"+
                               "{$unwind:\"$data\"}, "+
                               "{$match:{"+
                               			//"\"data.surveyType\":{$ne:'inborn_normal'},"+
                                         "\"data.readmitof\":{$exists:false} ,"+
                                         "\"data.duplicateof\":{$exists:false},"+
                                         "\"_id\":{$gte:{$oid:'58203bba8728b36accf07238'}, $lt:{$oid:'"+end+"'}}"+
                                    "}},"+
                                    "{$group:{\"_id\":{\"dob\":\"$data.dob\", \"mother\":\"$data.mother_name\", \"father\":\"$data.husband_name\"},"+
                                                "objectid:{$addToSet:\"$_id\"},"+
                                                "unique_id:{$addToSet:\"$data.unique_id\"},"+
                                                "\"count\":{$sum:1}"+
                                    "}},"+
                                    "{$match:{\"count\":{$gt:1},"+
                                               "objectid:{$gte:{$oid:'"+start+"'}}"+
                                    "}}]";		
		ArrayList<DBObject> l1=executeQuery(str);
		return l1;
	}	
	
	/**
	 * This is used get list of repeating mother for the given dates(using $group operation) 
	 * including homeborn babies
	 * @param startDt - document created date
	 * @param endDate - document created date
	 * @param facvalue - facility code
	 * @return list of objects
	 * @version 1.0 2017
	 */
	public ArrayList<DBObject> listOfRepeatingMother(Date startDt, Date endDate, String facvalue, String coll)
	{
		System.out.println("executing listOfRepeatingmother");
		String str=null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String startdate = sdf.format(startDt);
		System.out.println("starte date in java="+startdate);
		//calculate end date
		if(endDate==null)
		{
			Calendar cal= Calendar.getInstance();
			cal.setTime(startDt);
			cal.add(Calendar.DATE, 1);
			endDate= cal.getTime();
		}	
		String enddate = sdf.format(endDate);
		System.out.println("end date in java="+enddate);
		
		String start=new ObjectId(startDt).toHexString();//startdate to objectid
		String end=new ObjectId(endDate).toHexString();//enddate to objectid
		System.out.println("start objid ="+start);
		System.out.println("end objid ="+end);
		
		if(coll.equals("homeborn"))
		{
			str="[{$match:{\"data.readmitof\":{$exists:false},"+
                    "\"data.duplicateof\":{$exists:false},"+                                       
                   "\"_id\":{$gte:{$oid:'"+start+"'},$lte:{$oid:'"+end+"'}}}},"+
                   //"\"_id\":{$gte:{$oid:'595f60e48728b3496fd5c962'},$lte:{$oid:'59aa35a3a2cc180be0385c48'}}}},"+
            "{$group:{\"_id\":{dob:\"$dob\", mother:\"$mother_name\", father:\"$husband_name\"},"+
                        "objectid:{$addToSet:\"$_id\"},"+
                        "unique_id:{$addToSet:\"$unique_id\"},"+
                        "\"count\":{$sum:1}}},"+
            "{$match:{\"count\":{$gt:1}}}]";
		}
		
		else if(coll.equals("test_Nov11") || coll.equals("test"))
		{
			str="[{$project:{facility:{$arrayElemAt:[\"$data\", 0]},"+
                    "data:{$arrayElemAt:[\"$data\", 1]}}},"+
                    "{$unwind:\"$data\"},"+
                    "{$match:{\"data.readmitof\":{$exists:false} ,"+
                              "\"data.duplicateof\":{$exists:false},"+
                              "\"_id\":{$gte:{$oid:'58203bba8728b36accf07238'}, $lt:{$oid:'"+end+"'}}"+
                         "}},"+
                         "{$group:{\"_id\":{\"dob\":\"$data.dob\", \"mother\":\"$data.mother_name\", \"father\":\"$data.husband_name\"},"+
                                     "objectid:{$addToSet:\"$_id\"},"+
                                     "unique_id:{$addToSet:\"$data.unique_id\"},"+
                                     "\"count\":{$sum:1}"+
                         "}},"+
                         "{$match:{\"count\":{$gt:1},"+
                                    "objectid:{$gte:{$oid:'"+start+"'}}"+
                         "}}]";
		}
		ArrayList<DBObject> l1=executeQuery(str,coll);
		return l1;
	}	
	
	/**
	 * This is used to get details of the baby by unique_id 
	 * @param u_id - baby unique_id
	 * @return object
	 * @version 1.0 2017
	 **/
	public BasicDBObject babyByUniqueID(String u_id)
	{		
		System.out.println("executing baby by u_id");
		String str = "[{$project:{\"_id\":\"$_id\",facility:{$arrayElemAt:[\"$data\", 0]},"+    	              
                           "data:{$arrayElemAt:[\"$data\", 1]}}},"+    	              
                           "{$unwind:\"$data\"},"+
                           "{$match:{\"data.unique_id\":{$eq:'"+u_id+"'}"+ 
                           "}}]";		                    
			ArrayList<DBObject> l1=executeQuery(str);
			BasicDBObject l2=new BasicDBObject();
			DBObject data= new BasicDBObject();
			for(DBObject doc1:l1)
			{
				//System.out.println(doc1);
				DBObject facilityarray=(DBObject)doc1.get("facility");
				data=(DBObject)doc1.get("data");	
				Object facv = facilityarray.get("facility");
				int facVal=0;
				if(facv instanceof Integer)
				{
					//System.out.println("facility in int");
					Integer fac = (Integer)facv;
					facVal=fac.intValue();
				}
				if(facv instanceof Double)
				{
					//System.out.println("facility in double");
					Double fac=(Double)facv;
					facVal=fac.intValue();
				}
				data.put("facility", facVal+"");
				//data.put("enteredDate",((ObjectId)doc1.get("_id")).getDate().toString());				
				data.put("enteredDate",facilityarray.get("to_date"));
				data.put("objectid",doc1.get("_id").toString());
				//l2.add(data);	
				//l2.put("data", data);
			}			
			return (BasicDBObject)data;	
	}
	
	/**
	 * This is used to get details of the baby by unique_id including homeborn babies
	 * @param u_id - baby unique_id
	 * @param coll - collection name
	 * @return object
	 * @version 1.0 2017
	 **/
	public BasicDBObject babyByUniqueID(String u_id, String coll)
	{		
		System.out.println("executing baby by u_id");
		String str=null;
		if(coll.equals("test_Nov11") || coll.equals("test"))
		{
			str = "[{$project:{\"_id\":\"$_id\",facility:{$arrayElemAt:[\"$data\", 0]},"+    	              
                    "data:{$arrayElemAt:[\"$data\", 1]}}},"+    	              
                    "{$unwind:\"$data\"},"+
                    "{$match:{\"data.unique_id\":{$eq:'"+u_id+"'}"+ 
                    "}}]";	
		}
		else if(coll.equals("homeborn"))
		{
			str = "[{$match:{unique_id:{$eq:'"+u_id+"'}}}]";
		}
			
		ArrayList<DBObject> l1=executeQuery(str,coll);
		if(coll.equals("test_Nov11") || coll.equals("test"))
		{
			BasicDBObject l2=new BasicDBObject();
			DBObject data= new BasicDBObject();
			for(DBObject doc1:l1)
			{
				//System.out.println(doc1);
				DBObject facilityarray=(DBObject)doc1.get("facility");
				data=(DBObject)doc1.get("data");	
				Object facv = facilityarray.get("facility");
				int facVal=0;
				if(facv instanceof Integer)
				{
					//System.out.println("facility in int");
					Integer fac = (Integer)facv;
					facVal=fac.intValue();
				}
				if(facv instanceof Double)
				{
					//System.out.println("facility in double");
					Double fac=(Double)facv;
					facVal=fac.intValue();
				}
				data.put("facility", facVal+"");
				//data.put("enteredDate",((ObjectId)doc1.get("_id")).getDate().toString());				
				data.put("enteredDate",facilityarray.get("to_date"));
				data.put("objectid",doc1.get("_id").toString());
				//l2.add(data);	
				//l2.put("data", data);
			}			
			return (BasicDBObject)data;	
		}
		else //when homeborn collection used
		{
			return (BasicDBObject)l1.get(0);
		}
	}
	
	/**
	 * This is used to get details of the unique babies (which are not duplicate, readmit) 
	 * including home babies
	 * @param startDt - document created date
	 * @param endDate - document created date
	 * @param facility - facility code
	 * @param coll - collection name
	 * @return list of objects
	 * @version 1.0 5/9/2017
	 **/
	public ArrayList<DBObject> listOfUniqueBabies(Date startDt, Date endDate,String facility, String coll)
	{
		System.out.println("collection used in unique query ="+collection);
		String str1 = null;
		String str2 = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		 SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");	
		    Date dt=new Date();
		    String dod_ent=sdf1.format(dt);
		String startdate = sdf.format(startDt);
		System.out.println("starte date ="+startdate);
		//calculate end date
		if(endDate==null)
		{
			Calendar cal= Calendar.getInstance();
			cal.setTime(startDt);
			cal.add(Calendar.DATE, 1);
			endDate= cal.getTime();
			//endDate = startDt;
		}
		String enddate = sdf.format(endDate);
		System.out.println("end date ="+enddate);	
		
		String start=new ObjectId(startDt).toHexString();//startdate to objectid
		String end=new ObjectId(endDate).toHexString();//enddate to objectid
		/*System.out.println(start);
		System.out.println(end);
		*/
		System.out.println("executing listOfUniqueBabies");
		str1 = "[{$match:{\"_id\":{$gte:{$oid:'"+start+"'}, $lt:{$oid:'"+end+"'}},"+
				 "\"readmitof\":{$exists:false},"+
				"\"birth_weight\":{$gt:0,$lt:2000},"+
                                 "\"duplicateof\":{$exists:false}}}]";
		
		str2 = "[{$project:{\"_id\":\"$_id\",facility:{$arrayElemAt:[\"$data\", 0]},"+    	              
                    "data:{$arrayElemAt:[\"$data\", 1]}}},"+    	              
                    "{$unwind:\"$data\"},"+
                    "{$lookup:{from:\"kmc\","+
                        "localField:\"data.unique_id\","+
                        "foreignField:\"unique_id\","+
                        "as:\"kmc_docs\"}},"+
                     "{$lookup:{from:\"discharge\","+
                        "localField:\"data.unique_id\","+
                        "foreignField:\"unique_id\","+
                       "as:\"discharge_docs\"}},"+
                    "{$match:{\"_id\":{$gte:{$oid:'"+start+"'}, $lt:{$oid:'"+end+"'}},"+
                    		"\"data.duplicateof\":{$exists:false},"+
                    		"\"data.readmitof\":{$exists:false},"+
                    		"\"data.surveyType\":{$ne:'inborn_normal'},";
                    		if(!facility.equals("all"))
	                         {
	                        	str2+= "\"facility.facility\":{$in:["+facility+"]}";
	                         }				                         
	                        str2+="}},{$sort:{\"facility.to1\":1}}]";
		
		
		    System.out.println("TOtal Unique babies query1="+str1);    
		    System.out.println("TOtal Unique babies query2 ="+str2);  
			ArrayList<DBObject> l1=executeQuery(str2,coll);
			ArrayList<DBObject> l3=executeQuery(str1,"homeborn");
			System.out.println("L3 = "+l3);
			DBObject data1 = null;
			ArrayList<DBObject> l2=new ArrayList<DBObject>();
				for(DBObject doc1:l1)
				{
					//System.out.println(doc1);
					DBObject facilityarray=(DBObject)doc1.get("facility");
					DBObject data=(DBObject)doc1.get("data");
					BasicDBList kmc_list=(BasicDBList)doc1.get("kmc_docs");
					BasicDBList disch_list=(BasicDBList)doc1.get("discharge_docs");
					Object facv = facilityarray.get("facility");
					int facVal=0;
					if(facv instanceof Integer)
					{
						//System.out.println("facility in int");
						Integer fac = (Integer)facv;
						facVal=fac.intValue();
					}
					if(facv instanceof Double)
					{
						//System.out.println("facility in double");
						Double fac=(Double)facv;
						facVal=fac.intValue();
					}
					data.put("facility", facVal+"");
					//data.put("enteredDate",((ObjectId)doc1.get("_id")).getDate().toString());
					//data.put("objectid",doc1.get("_id").toString());
					data.put("enteredDate",facilityarray.get("to_date"));
					data.put("objectid",doc1.get("_id").toString());
					if(kmc_list.size()>0)
					{
						DBObject kmc_data=(DBObject)kmc_list.get(0);
						data.put("kmc_reg_no", kmc_data.get("kmc_reg_no"));
					}
					if(disch_list.size()>0)
					{
						DBObject disch_data=(DBObject)disch_list.get(0);
						data.put("date_of_outcome", disch_data.get("outcome_date1"));
						data.put("dod_ent", dod_ent);
						
					}
					l2.add(data);						
				}
				System.out.println("total unique babies ="+l2.size());
				
				for(int i=0;i<l3.size();i++)
				{
					//System.out.println("Object id="+doc2.get("_id").toString());
					BasicDBObject obj=(BasicDBObject)l3.get(i);
					obj.append("objectid",obj.get("_id").toString());
				}
				/*l3.add(obj);
				//l2.addAll(l3);*/	
				//System.out.println("Size of l3="+l3.size());
				l3.addAll(l2);
				//System.out.println("Size of l2&l3="+l3.size());
				return l3;						
	}
	
	/**
	 * This is used to get details 20% sampling babies for the given dates
	 * @param datefrom - created1 date
	 * @param dateto - created1 date
	 * @param type - type of the files created
	 * @return list of objects
	 * @version 1.0 2017
	 **/
	public ArrayList<DBObject> redcapCSVData(String datefrom, String dateto,String type)
	{
		String str = "[{$match:{"+
								"\"type\":{$eq:'"+type+"'},"+
								"\"created1\":{$gte:'"+datefrom+"',$lt:'"+dateto+"'}"+
								//"\"datefrom\":{$gte:'"+datefrom+"'},"+
                                //"\"dateto\":{$lte:'"+dateto+"'}"+
                    "}}]";
		return executeQuery(str);	
	}
	
	/**
	 * This is used to get list of babies which are duplicate, readmit, group, unresolved
	 * @param datefrom - from period 
	 * @param dateto - to period
	 * @param facility - facility code
	 * @param type - type(whether dupliate/readmit/group/unresolved)
	 **/
	public ArrayList<DBObject> classified_babies(String facility,String datefrom, String dateto, String type)
	{
		String str = null;
		str = "[{$project:{\"_id\":\"$_id\","+
                                    "facility:{$arrayElemAt:[\"$data\", 0]},"+
                                    "data:{$arrayElemAt:[\"$data\", 1]}"+
                            "}},{$unwind:\"$data\"},"+
                            "{$match:{"+
                            			"\"facility.from1\":{$gte:'"+datefrom+"', $lte:'"+dateto+"'},"+
                            			"\"facility.facility\":{\"$in\":["+facility+"]},";
							if(type.equals("Duplicate"))
							{
								str+="\"data.duplicateof\":{$exists:true}";
							}
							else if(type.equals("Readmit"))
							{
								str+="\"data.readmitof\":{$exists:true}";
							}
							else if(type.equals("Group"))
							{
								str+="\"data.groupid\":{$exists:true}";
							}
							else if(type.equals("Unresolved"))
							{
								str+="\"data.unresolved\":{$exists:true}";
							}
                            str+="}}]";
		return executeQuery(str);	
	}
	
	
	//main metod
	public static void main(String[] args) 
	{
		MongoDAO mdao = MongoDAO.initMongodao("35.154.204.175","copy","admin","kent@#14","test_Nov11");
		//System.out.println(mdao.listOfRepeatingMother(new Date("07/11/2016"), new Date("08/26/2017"), "all").size());
		//System.out.println(mdao.babyByUniqueID("121f28f8-ebb5-477a-8001-63f82fc12579"));
		//System.out.println(mdao.generateRedcapData(new Date("07/11/2016"), new Date("29/08/2017"),"all"));
		//System.out.println(mdao.listOfBabiesEnteredOneday(new Date("11/07/2016"), new Date("11/10/2016"), "100").get(0));
		//System.out.println(mdao.listOfBabiesEnteredOneday(new Date("08/12/2017"), "100").get(0));//stage 1 valid date
		//System.out.println(mdao.listOfBabiesEnteredOneday(new Date("08-20-20"),"100").size());//stage 1 date=null(today date)		
		
		//System.out.println(mdao.listOfRepeatingBabies(new Date("08/14/2017"),null,"23/7/2017", "Pushpa", "Devappa").size());
		//System.out.println(mdao.listOfRepeatingBabies(new Date("08/14/2017"),"23/7/2017", "Pushpa", "Devappa").get(0).get("unique_id"));
		//System.out.println(mdao.listOfRepeatingBabies(new Date("08/14/2017"),"23/7/2017", "Pushpa", "Devappa").get(1).get("unique_id"));
		//System.out.println(mdao.listOfRepeatingBabies("10/8/2017", "Tanjum", "Babusab").get(0).get("unique_id"));//stage 2 valid dob, mothername, fathername
		//System.out.println(mdao.listOfRepeatingBabies("10/8/2017", "Tanjum", "Babusab").get(1).get("unique_id"));
		//System.out.println(mdao.listOfRepeatingBabies("10/8/2017", "Tanjum", "Babusab").get(1));
		//System.out.println(mdao.listOfRepeatingBabies("23/7/2017", "Renuka", "Neelappa").get(1).get("unique_id"));
		//System.out.println(mdao.listOfRepeatingBabies("23/7/2017", "", "").size());//valid dob, null mother and father name			
		//System.out.println(mdao.listOfRepeatingBabies("23/7/2017", "nv123", "Neelappa").size());//valid dob, invalid morther and valid father
		//System.out.println(mdao.listOfRepeatingBabies("23/7/2017", "Renuka", "nv123").size());//valid dob, valid morther and invalid father
		//System.out.println(mdao.listOfRepeatingBabies("", "", ""));//valid dob, null mother and father name
		//System.out.println(mdao.listOfUniqueBabies(new Date("11/07/2016"),new Date("08/26/2017"),"all").get(0));
		
		/*int unique_size = mdao.listOfUniqueBabies(new Date("11/07/2016"),new Date("08/26/2017"),"all").size();
		ArrayList<DBObject> babies = mdao.listOfUniqueBabies(new Date("11/07/2016"),new Date("08/26/2017"),"all");
		for(int i=0; i<unique_size; i++)
		{
			System.out.println("array "+i+"="+ babies.get(i));
		}*/	
		
		//System.out.println("size of repeating mothers = "+mdao.listOfRepeatingMother(new Date("11/01/2016"), new Date("09/04/2017"), "all").size());
		//System.out.println("size of repeating mothers = "+mdao.babyByUniqueID("5bc26d54-7fae-4247-8e50-871773534987","homeborn"));
		/*ArrayList<DBObject> babies = mdao.listOfUniqueBabies(new Date("11/01/2016"), new Date("09/04/2017"), "all","test_Nov11");
		
		for(int i=0; i<babies.size();i++)
		{
			BasicDBObject b = (BasicDBObject)babies.get(i);
			System.out.println("size of repeating mothers = "+b);
		}*/		
	}
}
