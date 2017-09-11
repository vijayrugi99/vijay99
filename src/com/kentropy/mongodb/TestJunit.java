/**
 * 
 */
package com.kentropy.mongodb;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import org.junit.Test;

import com.csvreader.CsvWriter;
import com.mongodb.DBObject;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

public class TestJunit {
	public String unique_id="dad7b7c6-e3e8-445c-8187-d3ca37d14b79";
	public String db="copy";
	public String collection="redcap";
 MongoDAO mongodao=new MongoDAO(db, collection);    
   @Test
   public void testPrintMessage() throws IOException {
	   //ArrayList<DBObject> result=mongodao.getBaby1(unique_id);
	   ArrayList<DBObject> jsonArray1=null;
	   CsvWriter csvOutput=null;
	   System.out.println(mongodao.collection);
	   ArrayList<DBObject> jsonArray = mongodao.generateRedcapData(new Date("07/01/2017"), new Date("09/08/2017"),"all");
	   System.out.println(jsonArray.size());
	//   assertEquals(jsonArray1,jsonArray);
	   int res=RedcapCSV.generateRedcapCSV(jsonArray, "C:/Users/pp/Desktop/CSV/", csvOutput);
	  // assertEquals(19,res);
	  
	  // System.out.println("Result="+result);
      //assertNotNull(result1);

   }

  
}