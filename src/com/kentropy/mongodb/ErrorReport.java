package com.kentropy.mongodb;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.bson.types.ObjectId;
import org.json.JSONObject;

import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.WriteResult;
import com.mongodb.util.JSON;

public class ErrorReport 
{
	public static int checkDuplicates(String search,String db,String coll)
	{
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();	
		DB database = mongo.getDB(db);
		DBCollection collection = database.getCollection(coll);	
		java.util.List<DBObject> list2 = (java.util.List<DBObject>)JSON.parse(search);					
		Iterable<DBObject> output23 = collection.aggregate(list2).results();
		int i=0;
		int flag=0;
		int j=0;
		for(DBObject dbObj:output23)
			{
		      	System.out.println("iii="+i);
				//System.out.println("Objects are = "+dbObj);
				ObjectId id1 = (ObjectId) dbObj.get("_id");
				//convert ObjectID into date format
				//get each filtered object
				//BasicDBObject data0 = (BasicDBObject) dbObj.get("output");	
				//System.out.println("Objects are = "+data0);
				BasicDBObject data1 = (BasicDBObject) dbObj.get("output");
				//System.out.println("Objects are = "+data1);
				if(data1.containsField("dob"))
				{
					bd.dob = data1.getString("dob");
				}
				else{
				bd.dob = "-";
				}
				if(data1.containsField("unique_id"))
				{
					bd.u_id = data1.getString("unique_id");
				}
				else{
					bd.u_id = "-";
				}
			if(data1.containsField("pid1"))
			{
				bd.pid1 = data1.getString("pid1");
			}
			else{
				bd.pid1 = "-";
			}
			if(data1.containsField("pid2"))
			{
				bd.pid2 = data1.getString("pid2");
			}
			else{
				bd.pid2 = "-";
			}
			if(data1.containsField("time_of_birth"))
			{
				bd.time_of_birth = data1.getString("time_of_birth");
			}
			else{
				bd.time_of_birth = "-";
			}
			if(data1.containsField("thayi_card_no"))
			{
				bd.thayi_card_no = data1.getString("thayi_card_no");
			}
			else{
				bd.thayi_card_no = "-";
			}
			if(data1.containsField("mother_name"))
			{
				bd.mother_name = data1.getString("mother_name");//getInt("epic");
			}
			else{
				bd.mother_name = "-";
			}
			if(data1.containsField("sex"))
			{
				bd.sex = data1.getString("sex");//getInt("epic");
			}
			else{
				bd.sex = "-";
			}
			if(data1.containsField("phone1"))
			{
				bd.phone1 = data1.getString("phone1");
			}
			else{
				bd.phone1 = "-";
			}
			if(data1.containsField("birth_weight"))
			{
				bd.birth_weight = data1.getString("birth_weight");
			}	
			else{
				bd.birth_weight = "-";
			}
			if(data1.containsField("surveyType"))
			{	
				bd.surveytype = data1.getString("surveyType");	
			}
			else{
				bd.surveytype="-";
			}
			//original
			System.out.println("outside i--0"+i);
			if(i==0){
				System.out.println("inside i--0");
				if(data1.containsField("flag")){
					flag = data1.getInt("flag");
					if(flag==1){
						BasicDBObject newDocument = new BasicDBObject();
						newDocument.append("$set", new BasicDBObject().append("data.1.$.flag", 0));
						BasicDBObject searchQuery = new BasicDBObject().append("data.1.unique_id", bd.u_id);
						WriteResult out= collection.update(searchQuery, newDocument);
						System.out.println("out_data::"+out);
					}
				}
				else{//set flag for the first record when i==0,when no flag field.
					
					//flag=0;
					System.out.println("inside else");
					BasicDBObject newDocument = new BasicDBObject();
					newDocument.append("$set", new BasicDBObject().append("data.1.$.flag", 0));
					BasicDBObject searchQuery = new BasicDBObject().append("data.1.unique_id", bd.u_id);
					WriteResult out= collection.update(searchQuery, newDocument);
					System.out.println("out_data::"+out);
				}
			}
			//duplicate
			if(i>0){
				if(data1.containsField("flag")){
					flag = data1.getInt("flag");
					if(flag==0){
						BasicDBObject newDocument = new BasicDBObject();
						newDocument.append("$set", new BasicDBObject().append("data.1.$.flag", 1));
						BasicDBObject searchQuery = new BasicDBObject().append("data.1.unique_id", bd.u_id);
						WriteResult out= collection.update(searchQuery, newDocument);
						System.out.println("out_data::"+out);
					}
				}
				else{//set flag for the first record when i==0
					
					//flag=1;
					BasicDBObject newDocument = new BasicDBObject();
					newDocument.append("$set", new BasicDBObject().append("data.1.$.flag", 1));
					BasicDBObject searchQuery = new BasicDBObject().append("data.1.unique_id", bd.u_id);
					WriteResult out= collection.update(searchQuery, newDocument);
					System.out.println("out_data::"+out);
				}
			}
			System.out.println("");
			/*if(i>1)
			{
				BasicDBObject newDocument = new BasicDBObject();
				newDocument.append("$set", new BasicDBObject().append("data.1.$.status", 1));
				BasicDBObject searchQuery = new BasicDBObject().append("data.1.unique_id", bd.u_id);
				WriteResult out= collection.update(searchQuery, newDocument);
				System.out.println("out_data::"+out);
				 
			}	*/
			i++;	
			
	}
		return i;
	}
}



