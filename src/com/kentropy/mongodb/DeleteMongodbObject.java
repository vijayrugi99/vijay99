package com.kentropy.mongodb;

import java.util.Date;

import org.bson.Document;
import org.bson.types.ObjectId;
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

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/**
 * This code is to delete the complete object from the collection 
 *
 */

public class DeleteMongodbObject 
{
	/**
	 * @param id - is object id of a document
	 * @param dbName - is name of the database
	 * @param coll - is name of the collection
	 * @param deleteColl - is name of the delete collection
	 *
	 */
	public  int delete(String id,String dbName,String coll,String deletedColl) throws JSONException
	{
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		DB db = mongo.getDB(dbName);
		DBCollection collection = db.getCollection(coll);
		int num=0;
		BasicDBObject query = new BasicDBObject();
		query.put("_id", new ObjectId(id));
		DBCursor cursor = collection.find(query);
		//String result = null;
		//System.out.println("Cursor length = "+cursor.length());
		while(cursor.hasNext())
		{	
			DBObject obj= cursor.next();
			WriteResult wr=db.getCollection(deletedColl).insert(obj);
			System.out.println("insert obj="+wr);
			WriteResult remov = collection.remove(obj);	
			System.out.println("Remove obj="+remov);
			JSONObject res = new JSONObject(remov);
			num = res.getInt("n");
		 }
		return num;
	} 
	
	/**
	 * @param dbName is the database name 
	 * @param coll is the collection name 
	 * @param deletedColl is the collection name from where records has to be deleted 
	 * @param json is the actual data which is to be inserted 
	 * @return
	 * @throws JSONException
	 */
	public  String deleteObject(String dbName,String coll,String deletedColl,BasicDBObject json) throws JSONException
	{
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		DB db = mongo.getDB(dbName);
		System.out.println("database used by me::"+db);
		System.out.println("Connected to database sucessfully...");
		DBCollection collection = db.getCollection(coll);
		System.out.println("collection used by me::"+collection);
		System.out.println("object passed ::"+json);
			WriteResult wr=db.getCollection(deletedColl).insert(json);
			System.out.println("insert obj="+wr);
			JSONObject res=new JSONObject(wr);
			int n = res.getInt("n");
			String result="";
			if(n==0)
			{
				result = "Record Deleted Successfully";
				return result;
			}					
			else
			{
				result = "Record is not Deleted";
				return result;
			}
	}	
	
	/**
	 * @param dbName is the database name
	 * @param coll is the collection name
	 * @param id is the record id
	 * @param delColl is the collection name from which the record has to be deleted
	 * @return
	 */
	public static int insertDeletedRecordById(String dbName,String coll,Object id,String delColl)
	{
		//System.out.println("Record not inserted");
		System.out.println(dbName);
		System.out.println(coll);
		System.out.println(id);
		//id= new ObjectId("57dfc4d08728b36a5be1ba56");
		//ObjectId id1=  (ObjectId)id;
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		DB db = mongo.getDB(dbName);
		int n=0;
		DBCollection collection = db.getCollection(coll);
		DBCollection collection2 = db.getCollection(delColl);
		String id1=(String)id;
		DBObject findInTestColl = new BasicDBObject("_id", new ObjectId(id1));
		DBCursor cursor = collection.find(findInTestColl);
		if(cursor.size() == 0)
		{	
			//insert the record
			DBObject findInDeletedRec = new BasicDBObject("_id", new ObjectId(id1));
			DBCursor cursor2 = collection2.find(findInDeletedRec);
			System.out.println("test1--"+cursor2);
			if(cursor2.hasNext())
			{
				System.out.println("ID="+id1);
				while(cursor2.hasNext())
				{
					System.out.println("ID="+id1);
					DBObject obj = cursor2.next();
					System.out.println("OBJ=="+obj);
					WriteResult out = db.getCollection(coll).insert(obj);
					System.out.println("out="+out);
					//insert function returns 0 if success
					if(out.getN()==0)
					{
						System.out.println("inserted successfully");
					}
					else
					{
						System.out.println("Record not inserted");
					}					
					DBObject deleteRec = new BasicDBObject("_id", new ObjectId(id1));
					WriteResult res = collection2.remove(deleteRec);
					n=res.getN();
					System.out.println("res:"+res);					
				}
			}		
		}
		return n;
	}
	
	public static String insertDeletedRecordByUniqueId(String dbName,String coll,Object id,String uid,String delColl)
	{
		String res="Sorry the Record you are trying to insert is already exist in the test collection";
		String res1="The Record Inserted Successfully";
		System.out.println("0::"+uid);
		System.out.println("0::"+id);
		System.out.println("0::"+dbName);
		System.out.println("0::"+coll);
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		DB db = mongo.getDB(dbName);
		System.out.println("Connected to database sucessfully...");
		DBCollection testColl = db.getCollection(coll);
		DBCollection DeletedColl = db.getCollection(delColl);
		BasicDBObject query = new BasicDBObject();
		String id1=(String)id;
		//query.put("data.1.unique_id", uid);
		//DBCursor cursor = collection.find(query);
		//System.out.println("cursordata::"+cursor.next());
		BasicDBObject findInTest = new BasicDBObject("_id",new ObjectId(id1));
		DBCursor cursor = testColl.find(findInTest);
		while(cursor.hasNext()){
			System.out.println("inside cursor--:"+cursor.next());
		}
		uid = "150fef5d-0459-4adf-bc7f-adf71bf1710a";
		if(cursor.size() != 0){
			System.out.println("entered inside id loop");
			BasicDBObject findInTest2 = new BasicDBObject("_id",new ObjectId(id1));
			/*ArrayList<BasicDBObject> list= new ArrayList<BasicDBObject>();    			
			list.add(new BasicDBObject("_id", new BasicDBObject("$eq",uid)));
			list.add(new BasicDBObject("data.1.output", fno));
			list.add(new BasicDBObject("data.1.surveyType", survey));*/
			
    		BasicDBObject findUidInTest = new BasicDBObject("output", new BasicDBObject( "unique_id",uid));
        	//BasicDBObject update = new BasicDBObject("$pull",objectQuery);
    		DBCursor cursor1 = testColl.find(findInTest2,findUidInTest);
    		while(cursor1.hasNext()){
    			System.out.println("inside cursor1--:"+cursor1.next());
    		}
    		if(cursor1.size() == 0){
    			System.out.println("entered inside uid loop");
    			BasicDBObject findInDelColl = new BasicDBObject("_id",new ObjectId(id1));
    			DBCursor cursor2 = DeletedColl.find(findInDelColl);
    			System.out.println("killll---:"+cursor2);
    			while(cursor2.hasNext()){
    				System.out.println("entered inside while loop");
    				DBObject obj = cursor.next();
    				Object obj2 = obj.get("output");
    				System.out.println("output object::"+obj2);
    			    BasicDBObject searchTest = new BasicDBObject("_id",new ObjectId(id1));
    	   		    //BasicDBObject objectQuery1 = new BasicDBObject("data.1", new BasicDBObject( "unique_id",uid));
    	        	DBObject update = new BasicDBObject("$push", new BasicDBObject("data", obj2));
    	        	WriteResult out = testColl.update( searchTest, update );
				if(out.getN()==1)
				{
					return res1;
				}
				else
				{
					System.out.println("Record not inserted");
				}
			
		    }
    		}
    		else{
    			String res3 = "uniqueid already exist in the collection";
    			return res3;
    		}
		} 
    		else
    		{
    			String res4="ID already exist in the collection";
    			System.out.println("working fine");
    			System.out.println(res);
    			return res4;
    		}
    		return null;
    }	
	
	public int insertRemarks(String dbName,String collname,String name,String id,String role ,String callerName,String rem,String period,String type,String cph,String survey)
	{
		Date callDate = new Date();
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String callDate1 = df.format(date);
			MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
			DB db = mongo.getDB(dbName);
			DBCollection collection = db.getCollection(collname);
			BasicDBObject doc = new BasicDBObject();
			System.out.println("sop inside insert remarks");
			doc.append("unique_id",id);
			doc.append("Name", name);
			doc.append("callerName", callerName);
			doc.append("role", role);
			doc.append("remarks", rem);
			doc.append("callDate",callDate);
			doc.append("callDate1",callDate1);
			doc.append("status","failed");
			doc.append("surveyType",survey);
			doc.append("kmc_period",period);
			doc.append("type", type);
			doc.append("phone", cph);	
                	WriteResult out=collection.insert(doc);
		if(out.getN()==0)
		{
			return 1;
		}
		else
		{
			return 0;
		}
    
	}
       public static int insertFeedBack(String dbName,String collname,String name,String role,String phone ,String email,String issue){
		Date date = new Date();
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		DB db = mongo.getDB(dbName);
		DBCollection collection = db.getCollection(collname);
		BasicDBObject doc = new BasicDBObject();
		doc.append("Uname", name);
		doc.append("role", role);
		doc.append("phone", phone);
		doc.append("email", email);
		doc.append("issue",issue);
		doc.append("Date", date);
		doc.append("status","Open");
		System.out.println("inside insert feedback");
		WriteResult out=collection.insert(doc);
		if(out.getN()==0){
			return 1;
		}
		else
		{
			return 0;
		}
	}
        //method to insert comments from directly from the calldetails_allBabies report
	/**
	 * @param dbName
	 * @param collname
	 * @param id
	 * @param comment
	 * @return
	 */
	public static int insertComment(String dbName,String collname,String id ,String comment){
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		DB db = mongo.getDB(dbName);
		DBCollection collection = db.getCollection(collname);
		BasicDBObject findRec = new BasicDBObject("_id",new ObjectId(id));
		DBCursor cursor = collection.find(findRec);
		System.out.println("cursor--"+cursor.size());
		if(cursor.size()>0){
			System.out.println("cursor size--"+cursor.size());
			BasicDBObject updateDoc = new BasicDBObject();
			BasicDBObject searchRec = new BasicDBObject("_id",new ObjectId(id));
			updateDoc.append("$set", new BasicDBObject().append("comments", comment));
			WriteResult res =collection.update(searchRec, updateDoc);
			if(res.getN()==1){ // WriteResult object  holds value 1 for update and 0 for insert
				return 1;
			}
			else
			{
				return 0;
			}
		}
		return -1;
	}

	/*csv data insert or update*/	
	public int insertCSVdetails(String filename, String datefrom,String dateto,String db2,String coll,String reportType,String size) throws ParseException
	{
		System.out.println("Datefrom="+datefrom+"dateto="+dateto);
	    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    SimpleDateFormat df1 = new SimpleDateFormat("MM/dd/yyyy");
	    SimpleDateFormat sdf = new SimpleDateFormat ("dd-MM-yyyy HH:mm:ss");
	    sdf.setTimeZone(TimeZone.getTimeZone("IST"));
			MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		  	DB db21 = mongoClient.getDB(db2); 
		  	DBCollection collection= db21.getCollection(coll);
		    BasicDBObject document = new BasicDBObject();
		    BasicDBObject document1 = new BasicDBObject();
		    Date date = new Date();
		    String created=sdf.format(date);
		     
			String created1 = df.format(date);
			Date datefrom1=df1.parse(datefrom);
			Date dateto1=df1.parse(dateto);
			datefrom = df.format(datefrom1);
			dateto = df.format(dateto1);
			System.out.println("Datefrom1="+datefrom+"dateto1="+dateto);
		    System.out.println("created --"+created);
		    document.put("filename",filename);
		    document1.put("filename",filename);
		    document.put("datefrom",datefrom);
		    document.put("dateto",dateto);
		    document.put("created",created);
		    document.put("type", reportType);
		    document1.put("type", reportType);
		    document.put("size", size);
		    document.put("created1", created1);
		    
		    
		    DBCursor cursor = collection.find(document1);
		    System.out.println("cursor size = "+cursor.size());
		    if(cursor.size()>0)
		    {
		    	DBObject obj = cursor.next();
		    	String mfilename = (String)obj.get("filename");
		    	String mdatefrom = (String)obj.get("datefrom");
		    	String mdateto = (String)obj.get("dateto");
		    	Date mcreated = (Date)obj.get("created");
		    	String mcreated1 = (String)obj.get("created1");
		    	BasicDBObject newDocument = new BasicDBObject();
		    	//	newDocument.put("password", pwd);
		    	newDocument.append("$set",  new BasicDBObject().append("filename", filename).append("datefrom", datefrom).append("dateto", dateto).append("created", date).append("created1", created1));
		    	BasicDBObject searchQuery = new BasicDBObject().append("filename",mfilename).append("datefrom", mdatefrom).append("dateto", mdateto).append("created", mcreated).append("created1", mcreated1);
		    	collection.update(searchQuery, newDocument);
		    	return 3;
		    }
		    else
		    {
		    	WriteResult wr =collection.insert(document);		    
			    if(wr.getN()==0)
			    {
			    	return 1;
			    }
		    }
		    return cursor.size();
		}
	// download details 
    public int insertDownloadDetails(String user,String role,String db2,String coll,String oid)
	{		
			MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		  	DB db21 = mongoClient.getDB(db2); 
		  	DBCollection collection= db21.getCollection(coll);
		  	BasicDBObject obj = new BasicDBObject();
		  	obj.put("_id", new ObjectId(oid));
		  	BasicDBObject obj4 = new BasicDBObject();
		    BasicDBObject document = new BasicDBObject();
		    BasicDBList downloads = new BasicDBList();
		    Date date = new Date();
		    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String created1 = df.format(date);
		    System.out.println("created --"+created1);
		    DBCursor cursor = collection.find(obj);
		    System.out.println("created --"+cursor.size());
		    BasicDBObject data = new BasicDBObject();
	    	BasicDBObject data1 = new BasicDBObject();
		    if(cursor.size() > 0){
		    	System.out.println("data-"+cursor.next());
		    	DBObject listItem = new BasicDBObject("downloads", new BasicDBObject("user",user).append("role",role).append("Date",new Date()));
		    	DBObject updateQuery = new BasicDBObject("$push", listItem);
		    	collection.update(obj, updateQuery);
		    }
		    return 1;
	}

}
	/*public static void main(String[] args)
	{
		DeleteMongodbObject obj= new DeleteMongodbObject();
		obj.insertDeletedRecordById("test","test_Nov11","57dfc4d08728b36a5be1ba56");
		
		
	}*/
	