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
public class Classification2 {
	
	public static String SAME="m",DIFF="n",DNE="d";
	public MongoDAO mongodao=null;
public String match(String var1,String var2){
	    System.out.println("var1--"+var1);
	    System.out.println("var2--"+var2);
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
			 double value=(double) obj.get(field);
		     int in=(int)value;
			 return String.valueOf(in);
		}
		if(obj.get(field)==null)
			return "";
		return obj.get(field).toString();
	}
	return "";
}
/*public String matchBabies(DBObject obj1,DBObject obj2) throws JSONException{
	String[] fields={"dob"	,"mother_name","husband_name"	,"thayi_card_no","sex","phone1","birth_weight"	,"time_of_birth","enteredDate","facility"};
	String result="";
	for(int i=0;i<fields.length;i++){
		result+=match(getValue(obj1,fields[i]),getValue(obj2,fields[i]));
		//result+="-";
	}		
	return result;
}*/

	public String matchBabies(DBObject obj1,DBObject obj2) throws JSONException{
		preProcess(obj1);
		preProcess(obj2);
		String[] fields={"dob"	,"mother_name","husband_name"	,"thayi_card_no-pid1","sex","ph1-ph2","birth_weight"	,"time_of_birth","enteredDate","facility"};
		String result="";
		for(int i=0;i<fields.length;i++){
			String[] fields1=fields[i].split("-");
			System.out.println("splited array-"+fields[i]+" "+fields1.length);
			System.out.println("splited arrayeee-"+fields1[0]);
			//System.out.println("splited arrayeee-"+fields1[1]);
			
			String res="";
			for(int j=0;j<fields1.length;j++){
				/*if(fields1[j].equals("phone1")){
					if(obj2.containsField("phone1")){
						res=match(getValue(obj1,"phone1"),getValue(obj2,"phone1"));
					}
					else if(obj2.containsField("phone2")){
						res=match(getValue(obj1,"phone1"),getValue(obj2,"phone2"));
					}
				}
				else{*/
				//System.out.println("splited array-"+fields1[j]);
				res=match(getValue(obj1,fields1[j]),getValue(obj2,fields1[j]));
				System.out.println("res before=="+res);
				System.out.println("fields[j]--"+fields1[j]);
				if(res.equals("m"))
					break;
				}
			//}
			System.out.println("result "+res);
				result+=res;
			//result+="-";
		}		
		return result;
	}
	public String getType(String matchingResult){
		System.out.println(matchingResult);
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
		//if(maichingResult.matches("^mmmmm[m|n|d]mm[m|n|d][m|n|d]$")){
		
		for(int i=0;i<comp.length;i++){
			
		if(matchingResult.matches(comp[i][1])){
			
			return comp[i][0];
		}
		}
		return null;
	}
	public void preProcess(DBObject obj){
		String phone2=null;
		String phone1=null;
		if(obj.containsField("phone1")){
			phone1 = obj.get("phone1").toString();
			phone2=phone1;
		}
		
		if(obj.containsField("phone2")){
			phone2 = obj.get("phone2").toString();
			phone1=phone2;
		}
		/*if(obj.get("phone1")!= null){
			phone1 = obj.get("phone1").toString();
		 }*/
		/*if(obj.get("phone2")!= null){
			phone2 = obj.get("phone2").toString();	
		 }*/   
		     
		     ArrayList<String> li=new ArrayList();
		     if(phone1!=null)
		     li.add(phone1);
		     if(phone2!=null)
		     li.add(phone2);
		     Collections.sort(li);
		     for (int i = 0; i < li.size(); i++) {
		    	 obj.put("ph"+(i+1),li.get(i) );
			     	
			}
		     //obj.put("ph2", li.get(1));
		    // System.out.println("obj---"+obj);
		}
		
		
	
	public int classifyLBWS(Date datefrm,Date dateto, String facility,MongoDAO mongodao) throws JSONException
	{
		int d=0,r=0,g=0,un=0,u=0;
		//ArrayList<DBObject> jsonArray=mongodao.listOfBabiesEnteredOneday( datefrm,dateto,facility);
		//System.out.println("jsonarray---"+jsonArray);
		//System.out.println("total records entered in given date ="+jsonArray.size());
		//for(int i=0;i<jsonArray.size();i++) // list of babies entered in given date
		//{  		
			//System.out.println("i= "+i);
			//System.out.println("Baby enterd in given date = "+jsonArray.get(i));
			//DBObject object=jsonArray.get(i); //baby entered in given date
			ArrayList<DBObject> dmfmatch=mongodao.listOfRepeatingMother(datefrm,dateto,facility);
			System.out.println("dummyrecords--size::"+dmfmatch.size());// 19 records of repeating mothers
			String gid=null;
			String gid1=null;
			String gid2=null;
			
			if(dmfmatch.size()>0)
			{
				for(int j=0;j<dmfmatch.size();j++)
				{
					DBObject eachObj=dmfmatch.get(j);
					BasicDBList list=(BasicDBList) eachObj.get("unique_id"); 
					System.out.println("list---"+list);
					for(int p=0;p<list.size();p++){ //size 2
					String uid1 = (String) list.get(p);
					  System.out.println(" uid 1 ="+uid1);
					DBObject obj1 =(DBObject) mongodao.babyByUniqueID(uid1);//get Object
					  System.out.println(" obj1-1-1-1  ="+obj1);
					  gid1=null;
					  if(obj1.containsField("groupid")){
							 gid1=(String)obj1.get("groupid");
						}
					  System.out.println("gid1--"+gid1);
				    for(int k=0;k<list.size();k++)//second
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
						       	updateType(recType,uid2,uid1,mongodao.db, mongodao.collection,mongodao);
							    }
						        if(typeOf.equals("Unsesolved")){
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
		//}
		System.out.println("duplicate--"+d+"--readmit--"+r+"--group--"+g+","+count+"--unresolved--"+un+"--unique--"+u);
		return dmfmatch.size();
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
	public void generate20Percent(Date datefrm,Date dateto,String facility,MongoDAO mongodao,MongoDAO mongodao1,String counter)
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
	
	
	public static String getRandomString(int length) {
        return (String) UUID.randomUUID().toString().subSequence(0, length);
    }
	
public static void main(String[] args) throws JSONException{
	Classification2 obj=new Classification2();
	//mm/dd/yy
	Date date = new Date("11/01/2016");
	Date date2 =new Date("08/26/2017");
	MongoDAO mdao = MongoDAO.initMongodao("35.154.204.175","copy","admin","kent@#14","test_Nov11");
	obj.classifyLBWS(date, date2, "all",mdao);
	
	}


}
	

















