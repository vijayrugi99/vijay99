package com.kentropy.mongodb;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;

import com.kentropy.mongodb.MongoDAO;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.WriteResult;
public class Classification {
	
	
	public static String SAME="m",DIFF="n",DNE="d";
	public MongoDAO mongodao=null;
public String match(String var1,String var2){
	    
		if((var1 == null || var1.equals("")) && (var2==null || var2.equals(""))){
			return DNE;
	    }
		 if(var1.equals(var2)){
					return SAME;
					}
		return DIFF;
		}
// method to get values from the dbobject passed
public String getValue(DBObject obj,String field) throws JSONException{
	if(!obj.containsField(field)){
		return "";
	}
	if(obj.containsField(field)){
		
		if(obj.get(field) instanceof Double){
			 double value=(Double) obj.get(field);
		     int in=(int)value;
			 return String.valueOf(in);
		}		
		return obj.get(field).toString();
	}
	return "";
}
	public String matchBabies(DBObject obj1,DBObject obj2) throws JSONException{
		String[] fields={"dob","mother_name","husband_name","thayi_card_no","sex","phone1","birth_weight"	,"time_of_birth","enteredDate","facility"};
		String result="";
		for(int i=0;i<fields.length;i++){
			result+=match(getValue(obj1,fields[i]),getValue(obj2,fields[i]));
			//result+="-";
		}		
		return result;
	}
	public String getType(String matchingResult){
		//System.out.println(matchingResult);
		String[][] comp={
				            {"Duplicate","^mmmmm[m|n|d]mmmm$"},
	         	            {"Readmit","^mmmmm[m|n|d]mmnm$"},
	         	            {"Readmit","^mmmmm[m|n|d]mm[m|n|d]n$"},
				         	{"Duplicate","^mmmmm[m|n|d]mm[m|n|d][m|n|d]$"},
				         	{"Group","^mmmmm[m|n|d]mn[m|n|d][m|n|d]$"},
				         	{"Readmit","^mmmmm[m|n|d]n[m|n|d]n[m|n|d]$"},
				         	{"Group","^mmmmm[m|n|d]n[m|n|d]mm$"},
				         	{"Readmit","^mmmmm[m|n|d]mn[m|n|d]n$"},
				         	{"Readmit","^mmmmm[m|n|d]n[m|n|d]mn$"},
				         	{"Group","^mmmmn[m|n|d][m|n|d][m|n|d][m|n|d][m|n|d]$"},
				         	{"Unique","^mmmn[m|n|d][m|n|d][m|n|d][m|n|d][m|n|d][m|n|d]$"},
				         	{"Unresolved","^mmmd[m|n|d]d[m|n|d][m|n|d][m|n|d][m|n|d]$"},
				         	{"Group","^mmmmm[m|n|d]nm[m|n|d][m|n|d]$"},
				         	{"Unique","^mmmd[m|n|d]n[m|n|d][m|n|d][m|n|d][m|n|d]$"},
				         	{"Group","^mmmdnm[m|n|d][m|n|d][m|n|d][m|n|d]$"},   //clear
				         	{"Readmit","^mmmdmmn[m|n|d]n[m|n|d]$"},
				         	{"Group","^mmmdmmn[m|n|d]mm$"},
				         	{"Group","^mmmdmmmn[m|n|d][m|n|d]$"},
				         	{"Duplicate","^mmmdmmmm[m|n|d][m|n|d]$"},
				         	
				};
		//if(maichingResult.matches("^mmmmm[m|n|d]mm[m|n|d][m|n|d]$")){
		
		for(int i=0;i<comp.length;i++){
			
		if(matchingResult.matches(comp[i][1])){
			
			return comp[i][0];
		}
		}
		return null;
	}
	
	/**
	 * @param datefrm 
	 * @param dateto
	 * @param facility
	 * @param mongodao
	 * @param countColl
	 * @return
	 * @throws JSONException
	 */
	public int classifyLBWS(Date datefrm,Date dateto, String facility,MongoDAO mongodao,String countColl) throws JSONException
	{
		int d=0;
		int r=0;
		int g=0;
		ArrayList<DBObject> jsonArray=mongodao.listOfBabiesEnteredOneday(datefrm,dateto,facility);
		//System.out.println("jsonarray---"+jsonArray);
		System.out.println("total records entered in given date ="+jsonArray.size());
		for(int i=0;i<jsonArray.size();i++) // list of babies entered in given date
		{  		
			//System.out.println("i= "+i);
			System.out.println("Baby enterd in given date = "+jsonArray.get(i));
			DBObject object=jsonArray.get(i); //baby entered in given date
			ArrayList<DBObject> dmfmatch=mongodao.listOfRepeatingBabies(datefrm,dateto,object.get("dob").toString(),object.get("mother_name").toString(),object.get("husband_name").toString());
			System.out.println("dummyrecords::"+dmfmatch);
			if(dmfmatch.size()>1)
			{
				for(int j=0;j<dmfmatch.size();j++)
				{
					DBObject rec1=dmfmatch.get(j);
					System.out.println("Repeating record #"+j+" ="+rec1.get("unique_id"));
					String t_uid =(String) rec1.get("unique_id"); //original
					//System.out.println("j= "+j);
				    for(int k=j+1;k<dmfmatch.size();k++)
				    {
						//System.out.println("k= "+k);
						DBObject rec2=dmfmatch.get(k);
						System.out.println("Repeating record #"+j+" comparing with record #"+k+"= "+rec2.get("unique_id"));
						String o_uid=(String)rec2.get("unique_id");
						   //System.out.println("old uids= "+o_uid);
						if(rec1.get("objectid").equals(rec2.get("objectid")) && (rec1.get("unique_id").equals(rec2.get("unique_id"))))
							   continue;
				        String type=matchBabies(rec1, rec2);
				        System.out.println("Matching regex ="+type);
				        System.out.println("Type of the record = "+getType(type));
				        System.out.println();
				        String typeOf=getType(type);
				        String recType=null;
				        System.out.println("Record typeOf="+typeOf);
				        if(!typeOf.equals("Unique") && !typeOf.equals("Unresolved"))
				        {
					        if(typeOf.equals("Duplicate")){
					        	d++;
					          recType="duplicateof";
					        }
					        if(typeOf.equals("Readmit")){
					        	r++;
						       	  recType="readmitof";
						    }
					        if(typeOf.equals("Group")){
					        	g++;
						      	  recType="groupid";
						    }
					        System.out.println("Record type="+recType+"Record typeOf="+typeOf);
					        if(recType.equals("groupid"))
					        {
					        	updateGroupID(recType,o_uid,t_uid,mongodao.db, mongodao.collection,mongodao,countColl);	
					        }
					        else
					        {
						        updateType(recType,o_uid,t_uid,mongodao.db, mongodao.collection,mongodao,countColl);
						        System.out.println("Inside update Record Type="+recType+"O_uid="+o_uid+"T_uid="+t_uid);
					        }
				        }
					}
				}				
			}
			else
			{
				System.out.println("unique baby");
			}
		}
		System.out.println("Total Duplicate="+d+"Group="+g+"Readmit="+r);
		return jsonArray.size();
	}
	
	public void generate20Percent(Date datefrm,Date dateto,String facility,MongoDAO mongodao, MongoDAO mongodao1, String countColl)
	{		
	   ArrayList<DBObject> jsonArray =mongodao.listOfUniqueBabies(datefrm,dateto,facility);
		//ArrayList<DBObject> jsonArray =mongodao.stage3Integration("100","595698a884fca60b2cdbae55","595e81a884fca60b2cdbae56");
	   //System.out.println("uniquebabysize::"+jsonArray.size());
	   System.out.println("inside generate20 percent");
		int len=jsonArray.size();
		System.out.println("json size ="+len);
		Collections.shuffle(jsonArray);
		int size=0;
		if(len<=10)
			size=1;
		else
			size=len*20/100;
		 DB database = mongodao1.getMongoClient().getDB(mongodao1.db);
		DBCollection collection= database.getCollection(mongodao1.collection);
		System.out.println("db coll"+database+"colll"+collection);
		System.out.println("20 % size = "+size);
		int count=0;
		for(DBObject doc:jsonArray)
		{		
			System.out.println("insert loop");
			BasicDBObject searchQuery = new BasicDBObject("unique_id", doc.get("unique_id"));
			int total=collection.find(searchQuery).count();
			if(total>0)
			{
				System.out.println("unique-id--already exist "+doc.get("unique_id"));
				System.out.println("  ");
			}
			else
			{
				//System.out.println("insert loop");
				doc.put("record_id",getNextRecordID("recordid",mongodao.db,countColl,mongodao));
				collection.insert(doc);
				count++;
				if(count==size)
					break;
			}
		}		
	}
	
	public static Object getNextRecordID(String name,String db,String coll,MongoDAO mongodao) 
	{
		  //MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		System.out.println("inside generate reocrd name="+name+"db="+db+"coll="+coll);
		  DB database = mongodao.getMongoClient().getDB(db);
	      DBCollection collection= database.getCollection(coll);
	    BasicDBObject searchQuery = new BasicDBObject("name", name);
	    BasicDBObject increase = new BasicDBObject("seq", 1);
	    BasicDBObject updateQuery = new BasicDBObject("$inc", increase);
	    DBObject result = collection.findAndModify(searchQuery, null, null,
	            false, updateQuery, true, false);
	    System.out.println("seq="+result.get("seq"));
	    return result.get("seq");
	}
	public static void updateType(String type,String o_id,String d_id,String db,String coll,MongoDAO mongodao,String countColl) 
	{
		if(type!=null){
		  //System.out.println("type--- "+type);
		  //System.out.println("originalid--"+o_id);
			//System.out.println("duplicateid--"+d_id);
		  DB database = mongodao.getMongoClient().getDB(db);
	      DBCollection collection= database.getCollection(coll);
	      BasicDBObject doc = new BasicDBObject();
	      BasicDBObject newDocument = new BasicDBObject();
	      BasicDBObject searchQuery=new BasicDBObject();
	      System.out.println("Update type="+type);
	      newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,d_id));
	      searchQuery = new BasicDBObject("data.1.unique_id", o_id);
	      WriteResult n=collection.updateMulti(searchQuery, newDocument);
	      System.out.println("Result"+n);
	     // return n.getN();
	     }
	}
	
	public static void updateGroupID(String type,String o_id,String d_id,String db,String coll,MongoDAO mongodao,String grpcoll) 
	{
		String grp1=null;
		String grp2=null;
		WriteResult n = null;
		if(type!=null){
		  DB database = mongodao.getMongoClient().getDB(db);
	      DBCollection collection= database.getCollection(coll);
	      BasicDBObject doc = new BasicDBObject();
	      BasicDBObject doc1 = new BasicDBObject();
	      BasicDBObject newDocument = new BasicDBObject();
	      BasicDBObject searchQuery=new BasicDBObject();
	      System.out.println("Update type="+type);
	      doc.put("data.1.unique_id", o_id);
	      DBCursor cr=collection.find(doc);
	      if(cr.size()>0)
	      {
	    	  DBObject obj=cr.next();
	    	  if(obj.containsField("groupid"))
	    	  {
	    		  grp1=(String) obj.get("groupid");
	    		  System.out.println("Groud id exists"+o_id);
	    	  }  
	      }
	      doc1.put("data.1.unique_id", d_id);
	      DBCursor cr1=collection.find(doc1);
	      if(cr1.size()>0)
	      {
	    	  DBObject obj1=cr1.next();
	    	  if(obj1.containsField("groupid"))
	    	  {
	    		  grp2=(String) obj1.get("groupid");
	    		  System.out.println("Groud id exists"+d_id);
	    	  }  
	      }
	      if(grp1==null && grp2==null)
	      {
	    	  int groupid=(Integer) getNextRecordID("groupid",mongodao.db,grpcoll,mongodao);
	    	  System.out.println("Group id test="+groupid+"unique id="+o_id+"dup uni="+d_id);
	    	  newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,groupid));
		      searchQuery = new BasicDBObject("data.1.unique_id", o_id).append("data.1.unique_id", d_id);

	      }
	      else if(grp1!=null && grp2==null)
	      {
	    	  newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,grp1));
		      searchQuery = new BasicDBObject("data.1.unique_id", d_id);
	    	  System.out.println("Group id test="+grp1+"unique id="+o_id+"dup uni="+d_id);

	      }
	      else if(grp1==null && grp2!=null)
	      {
	    	  newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,grp2));
		      searchQuery = new BasicDBObject("data.1.unique_id", o_id);
		      System.out.println("Group id test="+grp2+"unique id="+o_id+"dup uni="+d_id);
	      }
	      n=collection.updateMulti(searchQuery, newDocument);
	      System.out.println("Result Duplicate"+n);
	     // return n.getN();
	     }
	}
	
	/*
	public static void main(String[] args) throws JSONException{
		
		Classification obj=new Classification();
		Date date = new Date("08/16/2017");
		MongoDAO mdao = MongoDAO.initMongodao("35.154.204.175","copy","admin","kent@#14","redcap_test");
		obj.classifyLBWS(date, "100",mdao);
		//com.kentropy.mongodb.CSV obj1 = new com.kentropy.mongodb.CSV();
		obj.generate20Percent(date, "102,134,100,101,102,126,109",mdao);
		
		}*/
}		
	


















