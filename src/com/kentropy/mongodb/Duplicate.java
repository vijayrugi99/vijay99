package com.kentropy.mongodb;

import java.util.ArrayList;

import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

public class Duplicate {
	public static MongoClient mongo= null;
	public String db=null;
	public String collection=null;
	/**
	 * This method has query to get details of duplicate babies	by using mother,husband name,dob,time_of_birth,sex,birth_weight,phone1
	 */
	public ArrayList<DBObject> duplicateUniqueID(MongoDAO mongo)
	{		
		//MongoDatabase db1=mongo.getDatabase(mongo.db);		
		String qry= "[ {$project:{_id:\"$_id\",facility:{$arrayElemAt:[\"$data\", 0]},data:{$arrayElemAt:[\"$data\", 1]}}}," ;
				qry+="{$unwind:\"$data\"},";
				qry+="{$match:{\"data.surveyType\":{$ne:\"inborn_normal\"}}},";
				qry+="{$group:{ ";
				qry+="_id: { mother_name: \"$data.mother_name\", husband_name: \"$data.husband_name\",dob:\"$data.dob1\",time_of_birth:\"$data.time_of_birth\",sex:\"$data.sex\",birth_weight:\"$data.birth_weight\",phone1:\"$data.phone1\"},";
				qry+="Unique_ID: { $addToSet: \"$data.unique_id\" }," ;
				qry+="SurveyType: { $addToSet: \"$data.surveyType\" }," ;
				qry+="count: { $sum: 1 }}}, ";
				qry+="{$match:{count: { $gt: 1 }}}";
				qry+="]";
		System.out.println("query = "+qry);
		ArrayList<DBObject> dbObject=mongo.executeQuery(qry);
		 return dbObject;		
	}
	public ArrayList<DBObject> getRecords(String unique_id)
	{
		return null;
		
		
		
	}
	
	
	
}
