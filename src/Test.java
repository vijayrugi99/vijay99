

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Test {

    public static void main(String[] args) throws FileNotFoundException, IOException, ParseException {
   
        JSONObject obj = new JSONObject();
        String filename="D:/Java_Workspace/Testing_Reports/WebContent/test_facilities.js";
    	//String url =session.getServletContext().getRealPath("/");
    	  obj.put("value", 123);
          obj.put("text", "new");
          obj.put("taluk", 1);
       //   String jsonText = obj.toString();
    	FileWriter file = new FileWriter(filename,true);
    	file.write(obj.toString());
    	//file.write("Testing data");
    	System.out.println("Successfully Copied JSON Object to File...");
    	//System.out.println("\nJSON Object: " + obj);
    	file.flush();
    	file.close();
    }
}
