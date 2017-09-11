package com.kentropy.mongo;

import java.util.ArrayList;
import java.util.List;

import org.bson.Document;

import com.kentropy.mongodb.MongoDAO;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.WriteConcern;
import com.mongodb.WriteResult;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.util.JSON;

public class MongoUtils {

	String host;
	String db;
	public MongoUtils(String host, String db)
	{
		this.host=host;
		this.db=db;
		
	}
	
	public void insertJSON1(String colName,String json)
	{
		Mongo mongo = new Mongo(host, 27017);
		DB db1 = mongo.getDB(db);
		DBObject dbObject = (DBObject)JSON.parse(json);


		DBCollection  collection= db1.getCollection(colName) ;
		collection.setWriteConcern(WriteConcern.SAFE);
				WriteResult wrt=collection.insert(dbObject);
				System.out.println(dbObject.get("_id"));
	}
	public void insertJSON(String colName,String json)
	{
		MongoClient mc=null;
	
		if(MongoDAO.mongo==null)
		{
		MongoCredential credential = MongoCredential.createCredential("ken-admin",
                "admin",
                "kent@#14".toCharArray());
		List<MongoCredential> list= new ArrayList<MongoCredential>();
		
		ServerAddress sa = new ServerAddress(host);
		list.add(credential);
		 mc= new MongoClient(sa,list);
		}
		 else
			 mc=MongoDAO.mongo;
		MongoDatabase db=mc.getDatabase(this.db);
	MongoCollection<Document> col=	db.getCollection(colName); 
	//DBObject dbObject = (DBObject)JSON.parse("{message:'hello world'}");
	//col.insertOne(arg0)
	Document doc=new Document();
	doc=Document.parse(json);
	System.out.println(doc);
	col.insertOne(doc);
	System.out.println(doc.get("_id"));
		
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
MongoUtils mu= new MongoUtils("54.162.202.102", "test");
mu.insertJSON("test2", "{message:'Hello world'}");
	}

}
