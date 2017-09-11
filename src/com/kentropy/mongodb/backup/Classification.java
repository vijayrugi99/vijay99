package com.kentropy.mongodb;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;

import com.kentropy.mongodb.MongoDAO;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.WriteResult;

import java.util.UUID;

	/**
	 * @author lenovo
	 *
	 */
public class Classification
{	
	public static String SAME="m",DIFF="n",DNE="d";
	public MongoDAO mongodao=null;		
	public String match(String var1,String var2)
	{
	    //System.out.println("var1--"+var1);
	    //System.out.println("var2--"+var2);
		if((var1 == null || var1.equals("")) && (var2==null || var2.equals("")))
		{
			return DNE;
		}
		if(var1.equals(var2))
		{
			return SAME;
		}
		return DIFF;
	}	
	
	// method to get values from the dbobject passed
	public String getValue(DBObject obj,String field) throws JSONException
	{
		if(!obj.containsField(field))
		{
			return "";
		}
		if(obj.containsField(field))
		{		
			if(obj.get(field) instanceof Double)
			{
				 double value=(Double) obj.get(field);
			     int in=(int)value;
				 return String.valueOf(in);
			}
			if(obj.get(field)==null)
				return "";
			return obj.get(field).toString();
		}
		return "";
	}

	//match fields
	public String matchBabies(DBObject obj1,DBObject obj2) throws JSONException
	{
		preProcess(obj1);
		preProcess(obj2);
		String[] fields={"dob","mother_name","husband_name","thayi_card_no-pid1","sex","ph1-ph2","birth_weight"	,"time_of_birth","enteredDate","facility"};
		String result="";
		for(int i=0;i<fields.length;i++)
		{
			String[] fields1=fields[i].split("-");
			System.out.println("splited array-"+fields[i]+" "+fields1[i]);
			//System.out.println("splited arrayeee-"+fields1[0]);
			//System.out.println("splited arrayeee-"+fields1[1]);
			
			String res="";
			for(int j=0;j<fields1.length;j++)
			{
				res=match(getValue(obj1,fields1[j]),getValue(obj2,fields1[j]));
				//System.out.println("res before=="+res);
				//System.out.println("fields[j]--"+fields1[j]);
				if(fields1[j].equals("thayi_card_no"))
				{
					if(res.equals("m") || res.equals("n"))
						break;
				}
				else if(res.equals("m"))
					break;
				if(fields1[j].equals("birth_weight"))
				{
					res=compareBW(getValue(obj1,fields1[j]),getValue(obj2,fields1[j]));
				}
			}
			
			System.out.println("result "+res);
				result+=res;
		}		
		return result;
	}
	
	private String compareBW(String value, String value2) {
		// TODO Auto-generated method stub
		int val1=Integer.parseInt(value);
		int val2=Integer.parseInt(value2);
		int res=Math.abs(val1-val2);
		if(res<100)
			return "n";
			else
				return "m";
	}

	//get regex type
	public String getType(String matchingResult)
	{
		//System.out.println("matching result = "+matchingResult);
		String[][] comp={
							{"Duplicate","^mmmmm[m|n|d]mmmm$"},
							{"Duplicate","^mmmdmmmmmm$"},
							{"Group","^mmmm[m|n|d][m|n|d]n[m|n|d][m|n|d][m|n|d]$"},
							{"Group","^mmmmn[m|n|d]m[m|n|d][m|n|d][m|n|d]$"},
							{"Group","^mmmmm[m|n|d]mn[m|n|d][m|n|d]$"}, 
							{"Unresolved","^mmmd[m|n|d]d[m|n|d][m|n|d][m|n|d][m|n|d]$"},
							{"Unresolved","^mmmmd[m|n|d]m[m|n|d][m|n|d][m|n|d]$"},
							{"Unresolved","^mmmm[m|n|d][m|n|d]md[m|n|d][m|n|d]$"},
							{"Readmit","^mmmmm[m|n|d]mm[m|n|d]n$"},
							{"Readmit","^mmmmm[m|n|d]mmnm$"},
							{"Readmit","^mmmdmmmmdm$"},
							{"Readmit","^mmmdmmmm[m|n|d]d$"},
							{"Unique","^mmmn[m|n|d][m|n|d][m|n|d][m|n|d][m|n|d][m|n|d]$"},
							{"Unique","^mmmd[m|n|d]n[m|n|d][m|n|d][m|n|d][m|n|d]$"},
				};
		for(int i=0;i<comp.length;i++)
		{			
			if(matchingResult.matches(comp[i][1]))
			{
				
				return comp[i][0];
			}
		}
		return null;
	}
	
	//sort phone numbers
	public void preProcess(DBObject obj)
	{
		String phone2=null;
		String phone1=null;
		if(obj.containsField("phone1"))
		{
			phone1 = obj.get("phone1").toString();
			phone2=phone1;
		}
		
		if(obj.containsField("phone2"))
		{
			phone2 = obj.get("phone2").toString();
			phone1=phone2;
		}
		ArrayList<String> li=new ArrayList();
		if(phone1!=null)
		     li.add(phone1);
		if(phone2!=null)
		     li.add(phone2);
		Collections.sort(li);
		for (int i = 0; i < li.size(); i++) 
		{
			obj.put("ph"+(i+1),li.get(i));
		}
	}	
	
	public static void updateGroupID(String type,String o_id,String d_id,MongoDAO mongodao,String gid) 
	{
		count++;
		if(type!=null){
		  DB database = mongodao.getMongoClient().getDB(mongodao.db);
	      DBCollection collection= database.getCollection(mongodao.collection);
	      BasicDBObject newDocument = new BasicDBObject();
	      BasicDBObject searchQuery=new BasicDBObject();

	      BasicDBObject newDocument2 = new BasicDBObject();
	      BasicDBObject searchQuery2=new BasicDBObject();
	    //  System.out.println("Update type="+type);
	      newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,gid));
		  searchQuery = new BasicDBObject("data.1.unique_id", o_id);
		  newDocument2 = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,gid));
		  searchQuery2= new BasicDBObject("data.1.unique_id", d_id);//new group id when both are null
	      WriteResult n=collection.updateMulti(searchQuery, newDocument);
	      WriteResult n2=collection.updateMulti(searchQuery2, newDocument2);
	      //System.out.println("Result"+n);
	      
	     }
	}
	
	/**
	 * @param type
	 * @param o_id
	 * @param d_id
	 * @param mongodao
	 * @param gid
	 */
	public static void updateGroupID1(String type,String o_id,String d_id,MongoDAO mongodao,String gid) 
	{
		count++;
		if(type!=null){
		  DB database = mongodao.getMongoClient().getDB(mongodao.db);
	      DBCollection collection= database.getCollection(mongodao.collection);
	      BasicDBObject newDocument = new BasicDBObject();
	      BasicDBObject searchQuery=new BasicDBObject();
	     // System.out.println("Update type="+type);
	      newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,gid));
		  searchQuery = new BasicDBObject("data.1.unique_id", o_id);//new group id when both are null
	      WriteResult n=collection.updateMulti(searchQuery, newDocument);
	     // System.out.println("Result"+n);
	      
	     }
	}
	public static int count=0;
	public static void updateGroupID2(String type,String o_id,String d_id,MongoDAO mongodao,String gid) 
	{
		count++;
		if(type!=null){
		  DB database = mongodao.getMongoClient().getDB(mongodao.db);
	      DBCollection collection= database.getCollection(mongodao.collection);
	      BasicDBObject newDocument = new BasicDBObject();
	      BasicDBObject searchQuery=new BasicDBObject();
	    //  System.out.println("Update type="+type);
	      newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,gid));
		  searchQuery = new BasicDBObject("data.1.unique_id", d_id);//new group id when both are null
	      WriteResult n=collection.updateMulti(searchQuery, newDocument);
	     System.out.println("Result"+n);
	      
	     }
	}
	
	public int generate20Percent(Date datefrm,Date dateto,String facility,MongoDAO mongodao,MongoDAO mongodao1,String counter)
	{ 		
	   ArrayList<DBObject> jsonArray =mongodao.listOfUniqueBabies(datefrm,dateto,facility);
		//ArrayList<DBObject> jsonArray =mongodao.stage3Integration("100","595698a884fca60b2cdbae55","595e81a884fca60b2cdbae56");
	   //System.out.println("uniquebabysize::"+jsonArray.size());
	   //System.out.println("inside generate20 percent");
		int len=jsonArray.size();
		Collections.shuffle(jsonArray);
		int size=0;
		if(len<=10)
			size=1;
		else
			size=len*20/100;
		 DB database = mongodao1.getMongoClient().getDB(mongodao1.db);
		DBCollection collection= database.getCollection(mongodao1.collection);
		System.out.println("db coll"+database+"colll"+collection);
		System.out.println("20 % size"+size);
		int count=0;
		for(DBObject doc:jsonArray)
		{
			doc.put("record_id",getNextRecordID("recordid",mongodao.db,counter,mongodao));
			BasicDBObject searchQuery = new BasicDBObject("unique_id", doc.get("unique_id"));
			int total=collection.find(searchQuery).count();
			if(total>0){
			System.out.println("unique-id--already exist "+doc.get("unique_id"));
			System.out.println("  ");
			}
			else
			{
			collection.insert(doc);
			count++;
			if(count==size)
				break;
			}
		}
		return 1;
	}
	
	@SuppressWarnings("deprecation")
	public static Object getNextRecordID(String name,String db,String coll,MongoDAO mongodao) 
	{
		  //MongoClient mongoClient = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		//System.out.println("inside generate reocrd ");
		  DB database = mongodao.getMongoClient().getDB(db);
	      DBCollection collection= database.getCollection(coll);
	    BasicDBObject searchQuery = new BasicDBObject("name", name);
	    BasicDBObject increase = new BasicDBObject("seq", 1);
	    BasicDBObject updateQuery = new BasicDBObject("$inc", increase);
	    DBObject result = collection.findAndModify(searchQuery, null, null,
	            false, updateQuery, true, false);
	    return result.get("seq");
	}
	public static void updateType(String type,String o_id,String d_id,String db,String coll,MongoDAO mongodao) 
	{
		if(type!=null){
		  //System.out.println("type--- "+type);
		  //System.out.println("originalid--"+o_id);
			//System.out.println("duplicateid--"+d_id);
		  DB database = mongodao.getMongoClient().getDB(db);
	      DBCollection collection= database.getCollection(coll);
	      BasicDBObject newDocument = new BasicDBObject();
	      newDocument = new BasicDBObject().append("$set", new BasicDBObject("data.1.$."+type,d_id));
	      BasicDBObject searchQuery = new BasicDBObject("data.1.unique_id", o_id);
	      WriteResult n=collection.update(searchQuery, newDocument);
	     // return n.getN();
	     }
	}
	
	
	public static String getRandomString(int length) 
	{
        return (String) UUID.randomUUID().toString().subSequence(0, length);
    }
	
	public int classifyLbwOneDay(Date datefrm,Date dateto, String facility,MongoDAO mongodao) throws JSONException
	{
		int d=0,r=0,g=0,un=0,u=0;
		ArrayList<DBObject> jsonArray=mongodao.listOfBabiesEnteredOneday( datefrm,dateto,facility);
		//System.out.println("jsonarray---"+jsonArray);
		System.out.println("total records entered in given date ="+jsonArray.size());
		System.out.println("list of babies entered in given date = ");
		for(int i=0;i<jsonArray.size();i++) // list of babies entered in given date
		{			
			//System.out.println("babies entered today = "+jsonArray.get(i));
			DBObject enteredBaby = jsonArray.get(i);
			ArrayList<DBObject> repeatingBabyList=mongodao.listOfRepeatingBabies(datefrm,dateto,enteredBaby.get("dob").toString(),enteredBaby.get("mother_name").toString(),enteredBaby.get("husband_name").toString());
			String gid=null;
			String gid1=null;
			String gid2=null;
			
			if(repeatingBabyList.size()>1) //if given dob,mother,husband repeating
			{
				for(int j=0;j<repeatingBabyList.size();j++)
				{
					//System.out.println("Repeating babies = "+repeatingBabyList.get(j));
					DBObject repeatingFirstBaby = repeatingBabyList.get(j);
					
					//get u_id
					String uid_firstbaby =(String) repeatingFirstBaby.get("unique_id");					
					
					//get groupid of first baby if exists
					gid1=null;
					if(repeatingFirstBaby.containsField("groupid"))
					{
						gid1=(String)repeatingFirstBaby.get("groupid");
					}
					//System.out.println("gid1 = "+gid1);
					
					for(int k=j+1; k<repeatingBabyList.size();k++)
					{
						DBObject repeatingSecondBaby = repeatingBabyList.get(k);
						String uid_secondbaby =(String) repeatingSecondBaby.get("unique_id");
						System.out.println("First baby uid ="+uid_firstbaby);
						System.out.println("second baby uid ="+uid_secondbaby);
						
						//get groupid of second baby if exists
						gid2=null;
						if(repeatingSecondBaby.containsField("groupid"))
						{
							gid2=(String)repeatingSecondBaby.get("groupid");
						}
						//System.out.println("gid2 = "+gid2);
						
						//compare two babies u_id
						if(repeatingFirstBaby.get("objectid").equals(repeatingSecondBaby.get("objectid")) && (repeatingFirstBaby.get("unique_id").equals(repeatingSecondBaby.get("unique_id"))))
							   continue;
						
						//match each field of two baby
						String type=matchBabies(repeatingFirstBaby, repeatingSecondBaby);
					    System.out.println("Matching regex ="+type);
					    System.out.println("Type of the record = "+getType(type));
					    
					    //get type of record based on match regex
					    String typeOf=getType(type);
				        String recType=null;
				        if(typeOf==null) //set type of record="" when null
					        	typeOf="";
					    System.out.println("****************************"+typeOf+"******************");
				        if(typeOf.equals("Group"))
				        {
					      	  recType="groupid";					      	  
					    }
				        if(recType!=null)
				        {
				        	//when type=group, check any baby have groupid/not, if exists append same to another baby
				        	if(recType.equals("groupid"))
				        	{
				        		++g;
				        		if(gid1==null && gid2==null)
				        		{
				        			//System.out.println("generate new group id");
				        			gid=getRandomString(8);
				        			updateGroupID( recType, uid_secondbaby, uid_firstbaby, mongodao,gid);
				        		}
				        		else if(gid1!=null && gid2==null)
				        		{
				        			//System.out.println("update group id of gid2 with gid1");
				        			updateGroupID1( recType, uid_secondbaby, uid_firstbaby, mongodao,gid1);//update t_uid
				        		}
				        		else if(gid1==null && gid2!=null)
				        		{
				        			//System.out.println("update group id of gid1 with gid2");
				        			updateGroupID2( recType, uid_secondbaby, uid_firstbaby, mongodao,gid2);//update o_uid
				        		}
				             }
				        }
				        
				        //check type=duplicate, if duplicate append first baby u_id to second baby
				        if(typeOf.equals("Duplicate"))
				        {
			        		 //System.out.println("inside duplicate");
			        		++d;
					        recType="duplicateof";
					        updateType(recType,uid_secondbaby,uid_firstbaby,mongodao.db, mongodao.collection,mongodao);
				        }
				        
				        //check type=readmit, if readmit append first baby u_id to second baby
					    if(typeOf.equals("Readmit"))
					    {
					        	//System.out.println("inside readmit");
					        ++r;
						    recType="readmitof";
						    System.out.println("Original="+uid_firstbaby+"Duplicate="+uid_secondbaby);
					       	updateType(recType,uid_secondbaby,uid_firstbaby,mongodao.db, mongodao.collection,mongodao);
						}
					    
					    //check type=unresolved, if unresolved append first baby u_id to second baby
					    if(typeOf.equals("Unresolved"))
					    {
					        	//System.out.println("inside unresolved");
					       ++un;
						   recType="unresolved";
					       updateType(recType,uid_secondbaby,uid_firstbaby,mongodao.db, mongodao.collection,mongodao);
						}
					    
					    //check type=unique, if unique append first baby u_id to second baby
					    if(typeOf.equals("Unique"))
					    {
					        	//System.out.println("inside readmit");
					        ++u;
						    recType="unique";
					       	updateType(recType,uid_secondbaby,uid_firstbaby,mongodao.db, mongodao.collection,mongodao);
						}
				        //System.out.println();				            
					}
				}				
			}
			else
			{
				//System.out.println("Unique Baby");
			}
			System.out.println();
		}
		System.out.println("duplicate--"+d+"--readmit--"+r+"--group--"+g+",---updated---"+count+"--unresolved--"+un+"--unique--"+u);
		return jsonArray.size();		
	}
	
	public int classifyLbwGroup(Date datefrm,Date dateto, String facility,MongoDAO mongodao) throws JSONException
	{
		int d=0,r=0,g=0,un=0,u=0;		
			ArrayList<DBObject> listOfMothers=mongodao.listOfRepeatingMother(datefrm,dateto,facility);
			System.out.println("list of mothers reapeting ="+listOfMothers.size());
			String gid=null;
			String gid1=null;
			String gid2=null;
			
			if(listOfMothers.size()>0)
			{
				for(int j=0;j<listOfMothers.size();j++)
				{
					DBObject eachObj=listOfMothers.get(j);
					BasicDBList list=(BasicDBList) eachObj.get("unique_id"); //copy o/p to one list
					System.out.println("list---"+list);
					for(int p=0;p<list.size();p++)
					{ 
						String uid1 = (String) list.get(p); 
						System.out.println(" uid 1 ="+uid1);
						DBObject obj1 =(DBObject) mongodao.babyByUniqueID(uid1);//get Object
					  System.out.println("obj1-1-1-1  ="+obj1);
					  gid1=null;
					  if(obj1.containsField("groupid")){
							 gid1=(String)obj1.get("groupid");
						}
					  System.out.println("gid1--"+gid1);
				    for(int k=p+1;k<list.size();k++)//second
				    {	gid2=null;
				    	String uid2 = (String) list.get(k);
				    	System.out.println(" uid 2 ="+uid2);
						DBObject obj2 = (DBObject)mongodao.babyByUniqueID(uid2);
						System.out.println(" obj2-2-2-2  ="+obj2);
						  if(obj2.containsField("groupid")){
								 gid2=(String)obj2.get("groupid");
								}
						  System.out.println("gid2--"+gid2);
						System.out.println("rec1obj-"+obj1.get("objectid"));
						System.out.println("rec1obj-"+obj2.get("objectid"));
						if(obj1.get("objectid").equals(obj2.get("objectid")) && (obj1.get("unique_id").equals(obj2.get("unique_id"))))
							   continue;
				        String type=matchBabies(obj1, obj2);
				        System.out.println("Matching regex ="+type);
				        System.out.println("Type of the record = "+getType(type));
				        System.out.println();
				        String typeOf=getType(type);
				          String recType=null;
				          if(typeOf==null)
					        	typeOf="";
					      
				          System.out.println("****************************"+typeOf+"******************");
				        if(typeOf.equals("Group")){
					      	  recType="groupid";
					      	  
					    }
				        if(recType!=null){
				        	if(recType.equals("groupid")){
				        		g++;
				        		if(gid1==null && gid2==null){
				        			//System.out.println("generate new group id");
				        			gid=getRandomString(8);
				        			updateGroupID( recType, uid2, uid1, mongodao,gid);
				        		}
				        		else if(gid1!=null && gid2==null){
				        			//System.out.println("update group id of gid2 with gid1");
				        			updateGroupID1( recType, uid2, uid1, mongodao,gid1);//update t_uid
				        		}
				        		else if(gid1==null && gid2!=null){
				        			//System.out.println("update group id of gid1 with gid2");
				        			updateGroupID2( recType, uid2, uid1, mongodao,gid2);//update o_uid
				        		}
				             }
				        }
				        	 if(typeOf.equals("Duplicate")){
				        		 //System.out.println("inside duplicate");
				        		 d++;
						          recType="duplicateof";
						         updateType(recType,uid2,uid1,mongodao.db, mongodao.collection,mongodao);
						        }
						        if(typeOf.equals("Readmit")){
						        	//System.out.println("inside readmit");
						        	r++;
							       	  recType="readmitof";
							       	System.out.println("Original="+uid2+"Duplicate="+uid1);
						       	updateType(recType,uid2,uid1,mongodao.db, mongodao.collection,mongodao);
							    }
						        if(typeOf.equals("Unresolved")){
						        	//System.out.println("inside unresolved");
						        	un++;
							       	  recType="unresolved";
						       	updateType(recType,uid2,uid1,mongodao.db, mongodao.collection,mongodao);
							    }
						        if(typeOf.equals("Unique")){
						        	//System.out.println("inside readmit");
						        	u++;
							       	  recType="unique";
						       	updateType(recType,uid2,uid1,mongodao.db, mongodao.collection,mongodao);
							    }
					}
				}			
			}
			}
			else
			{
				System.out.println("unique baby");
			}		
		System.out.println("duplicate--"+d+"--readmit--"+r+"--group--"+g+",---updated---"+count+"--unresolved--"+un+"--unique--"+u);
		return listOfMothers.size();
	}
	
	public static void main(String[] args) throws JSONException
	{
		Classification obj=new Classification();
		//mm/dd/yy
		Date date = new Date("11/01/2016");
		Date date2 =new Date("08/30/2017");
		MongoDAO mdao = MongoDAO.initMongodao("35.154.204.175","copy","admin","kent@#14","test_copy");
		obj.classifyLbwOneDay(date, date2, "all",mdao);	
		//obj.classifyLbwGroup(date, date2, "all",mdao);
	}
}
	

















