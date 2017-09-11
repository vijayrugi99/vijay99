<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		 <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
		<title> Duplicate Error Report </title>
		<link rel="stylesheet" type="text/css" href="Reports_Stylesheet.css">
		<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
		   <!-- must include -->
   <style>
.table-responsive2 {
width:100%;
margin-bottom:15px;
overflow-x:auto;
overflow-y:hidden;
-webkit-overflow-scrolling:touch;
-ms-overflow-style:-ms-autohiding-scrollbar;
border:1px solid #ddd
}

.table-responsive2 table {
    table-layout: fixed;
}
.tableheader {
	width: 1549px;
	margin-bottom:0px;
	border:1px solid #999;

}
.tablebody {
	height: 500px;
	overflow-y: auto;
	width: 1565px;
	margin-bottom:20px;
}
   </style>
   <script>
				
				function confirmFun( id,uid){
					
					    //var call_jsp ='putBack.jsp?db='+db+'&coll='+coll+'&ID='+ID+'&delColl='+delColl;
					    var call_jsp ='DelDuplicate.jsp?id='+id+'&uid='+uid;
						window.location.href=call_jsp;
				}
				</script>
	</head>	
	
	<body>
		<%@page import="java.sql.*" %>
		<%@page import="java.awt.List" %>
		<%@page import="com.mongodb.ServerAddress" %>
		<%@page import="com.mongodb.DBCursor" %>
		<%@page import="com.mongodb.DBObject" %>
		<%@page import="com.mongodb.BasicDBObject" %>
		<%@page import="com.mongodb.DBCollection" %>
		<%@page import="com.mongodb.DB" %>
		<%@page import="com.mongodb.BasicDBObjectBuilder" %>
		<%@page import="com.mongodb.BasicDBList" %>
		<%@page import="com.mongodb.AggregationOutput" %>
		<%@page import="com.mongodb.MongoException" %>
		<%@page import="com.mongodb.MongoClient" %>
		<%@page import="org.bson.types.ObjectId" %>
		<%@page import="com.mongodb.ServerAddress" %>
		<%@page import="java.awt.List" %>
		<%@page import="java.util.ArrayList"%>
		<%@page import="java.awt.List" %>
		<%@page import="org.json.JSONObject" %>
		<%@page import="org.json.JSONArray" %>
		<%@page import="java.text.*" %>
		<%@page import = "java.util.*"%>
		<%@page import = "com.mongodb.util.JSON"%>
		<%@page import = "java.util.Date"%>
		<%@page import = "java.util.Calendar"%>	
		<%@ include file="Config.jsp" %>
		<%-- <%@ include file="home.jsp" %> --%>	
		<%	
			try
			{	
				//get connection to mongodb	
				MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
				com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();					
				
				DB database = mongo.getDB(db);
				//System.out.println("Used db ="+database);
				//System.out.println("Connected to database sucessfully...");
				DBCollection collection = database.getCollection(coll);						
				//System.out.println("Collection used ="+collection);
				String query=null;
				int flag=0;
				//query for duplicate pid1 in different ObjectIds
				String strPid = "[{$project:{\"_id\":\"$_id\",data:{$arrayElemAt:[\"$data\", 1]}}},";
                       strPid+= "{$unwind:\"$data\"},";
                       strPid+= "{$match:{\"data.unique_id\":{$exists:true}}},";
                       strPid+= "{$group:{_id:{u_id:\"$data.unique_id\"},";                       
                       strPid+= " count:{$sum:1}}},";
                       strPid+= "{$match:{count:{$gt:1}}}";
                       strPid+= "]";
                String str = "[{$project: {output:{$arrayElemAt: [\"$data\",1]},facility:{$arrayElemAt: [\"$data\",0]}}},{$unwind: \"$output\"},{$unwind: \"$facility\"}]";//all records
               	java.util.List<DBObject> list = (java.util.List<DBObject>)JSON.parse(str);	    		
       			Iterable<DBObject> output = collection.aggregate(list).results();//object contains all records       			
       			//System.out.println("No. of error reports ="+list.size());  
       			String strObjects = null;				
				%>				
				<!-- create table and header for the table -->	
						 <div class="container">
						 <font color=brown><center><h1>Duplicate Records</h1></center></font>	
			<div class="row">
		     <div class="exporttable table-responsive2">
		     
                    <table class="table table-bordered table-striped tableheader">
                      <thead>
                        <tr>		
						<th style="width:50px"> Sl. No.</th>
						<th style="width:80px">Status</th>
						<th style="width:200px"> Unique ID</th>	
						<th style="width:200px"> Object ID </th>						
						<!-- <th rowspan="2" width="300"> Entered Date </th> -->						
						<!-- <th rowspan="2" width="300"> Period </th> -->						
						<th style="width:80px"> Facility </th>							
						<th style="width:100px"> Baby DOB </th>							
						<th style="width:80px"> Patient ID1 </th> 					
						<!--<th style="width:80px"> Patient ID2 </th> --> 
						<th style="width:100px"> Mother Name </th>
						<th style="width:100px"> Husband Name </th>
						<th style="width:80px"> Time of Birth </th>
						<th style="width:80px"> Baby Birth Weight </th>
						<th style="width:80px"> Baby Sex </th>
						<th style="width:100px"> Phone1 </th>
						<th style="width:100px"> Thayi Card No </th>
					</tr>				
                      </thead>
                    </table>
                    <div class="tablebody">
                      <table class="table table-bordered table-striped" >
                        <tbody>
				<%
				int k=0;
				String uniqueID = null;
				String query4 = null;
				String status="-";
				String sex=null;
				SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/MM/yyyy");
					String dob=null;
				//Iteration to each repeating pids
				for(DBObject obj: output)//this contains all records, if used str string
				{					
					
					ObjectId id = (ObjectId) obj.get("_id");
	       			BasicDBObject data = (BasicDBObject) obj.get("output");
	       			BasicDBObject data0 = (BasicDBObject) obj.get("facility");
	       			if(data0.containsField("facility")){
	       				bd.facility = data0.getInt("facility");
	       			}
	       			else{
	       				bd.facility="-";
	       			}
	       			if(data.containsField("pid1"))
					{
						bd.pid1 = data.getString("pid1");
					}
				
					else{
						bd.pid1 = "-";
					}
					
					if(data.containsField("time_of_birth"))
					{
						bd.time_of_birth = data.getString("time_of_birth");
					}
					else{
						bd.time_of_birth = "-";
					}
					if(data.containsField("mother_name"))
					{
					bd.mother_name = data.getString("mother_name");
					}
					else{
						bd.mother_name = "-";
					}
					if(data.containsField("dob1"))
					{
						bd.dob = data.getString("dob1");
						//System.out.println("Date="+bd.dob);
						dob=(String)bd.dob;
						Date date = sdfSource.parse(dob);
						dob = sdfDestination.format(date);
						//System.out.println("Date1="+bd.dob);
					}
					else{
						dob = "-";
					}
					if(data.containsField("sex"))
					{
						bd.sex = data.getString("sex");
						if(bd.sex.equals("1"))
							sex="Male";
						else if(bd.sex.equals("2"))
							sex="Female";
						else
							sex="Other";
					}
					else{
						sex = "-";
					}
					if(data.containsField("unique_id"))
					{
						bd.u_id = data.getString("unique_id");
					}
					else{
						bd.u_id = "-";
					}
					
					if(data.containsField("thayi_card_no"))
					{
						bd.thayi_card_no = data.getString("thayi_card_no");
					}
					else{
						bd.thayi_card_no = "-";
					}
					if(data.containsField("phone1"))
					{
						bd.phone1 = data.getString("phone1");
					}
					else{
						bd.phone1 = "-";
					}
					if(data.containsField("birth_weight"))
					{
						bd.birth_weight = data.getString("birth_weight");
					}	
					else{
						bd.birth_weight = "-";
					}
					if(data.containsField("husband_name"))
					{
						bd.husband_name = data.getString("husband_name");
					}
					else{
						bd.husband_name = "-";
					}
					
					if(data.containsField("flag")){
					flag=data.getInt("flag");
					if(flag==1){
					status="Duplicate";	
					}
					
					if(flag==0){
						status="Original";	
						}
					}
					int returnAck  =0;
					
					if(bd.pid1!="-" && bd.time_of_birth!="-" && bd.sex!="-")
					{
						
						query ="[{$project: {output:{$arrayElemAt: [\"$data\",1]}}},{$unwind: \"$output\"},{$match: {\"output.pid1\":{$eq: '"+bd.pid1+"'}}},"
				               	 +"{$match: {\"output.time_of_birth\":{$eq: '"+bd.time_of_birth+"'}}},{$match: {\"output.mother_name\":{$eq:'"+bd.mother_name+"'}}},"
				               	  +"{$match: {\"output.dob1\":{$eq:'"+bd.dob+"' }}},"
				               	  +" {$match: {\"output.surveyType\":{$in: [\"inborn_lbw\",\"outborn_lbw\"]}}},"
				               	   +"{$match: {\"output.sex\":{$eq:'"+bd.sex+"'}}},{$match: {\"output.flag\":{$ne:'1'}}}]";
				        	
						returnAck = com.kentropy.mongodb.ErrorReport.checkDuplicates(query,db,coll);
						
						  //System.out.println("returnAck=="+returnAck);
						if(returnAck>1){
							  %>	
							    <tr>
								<td style="width:50px" rowspan = <%= (obj.get("count"))%>><%= (++k)%></td>						
							    <% 
							  %>	
							  <%-- DelDuplicate.jsp?id=<%=id%>&uid=<%= bd.u_id%>&data=<%=data%> --%>
							  <%-- delObj('<%=id%>','<%= bd.u_id%>','<%=data%>') --%>
							  <%-- <a href="DelDuplicate.jsp?id=<%=id%>&uid=<%= bd.u_id%>" --%>
							  <td style="width:80px;color:red"><b>
							  <%=status %></b>
							  <%
							  if(status.equals("Duplicate"))
							  {%>
							    <div class="modal fade" id="myModal" role="dialog"  data-backdrop="static" width="20%">
                                <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                <div align="center">
                                <div class="modal-body">
                                <p style="color:red"><b>Are You Sure You Want To Delete This Record....? <br> Please Confirm..!</b></p>
                                </div>
                                <a  class="btn btn-warning " onclick="confirmFun('<%=id%>','<%= bd.u_id%>')">Yes</a>&nbsp;&nbsp;
                                <button type="button"  class="btn btn-info"  data-toggle="modal"  data-dismiss="modal" >No</button>
                                <div class="modal-footer">
                                </div>
                                </div>
                                </div>
                                </div>
                               </div>
								  <button  type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#myModal" <%-- <%-- onclick="confirmFun('<%=id%>','<%= bd.u_id%>')" --%> --%> Delete</button></td>
							 <% }
							  %>
							  
							  </td>
							    <td style="width:200px"> <%= bd.u_id%></td>
							    <td style="width:200px"> <%= id%> </td>    	
								<td style="width:80px"><%= bd.facility%></td> 	
								<td style="width:100px"><%= dob%></td>						
								<td style="width:80px"> <%= bd.pid1%> </td> 
								<%-- <td><%= bd.surveytype%></td> --%>						
								<%-- <td style="width:80px"><%= bd.pid2%></td> --%>
								<td style="width:100px"><%= bd.mother_name%></td>
								<td style="width:100px"><%= bd.husband_name%></td>
								<td style="width:80px"><%= bd.time_of_birth%></td>
								<td style="width:80px"><%= bd.birth_weight%></td>
								<td style="width:80px"><%= sex%></td>
								<td style="width:100px"><%= bd.phone1%></td>
								<td style="width:100px"><%= bd.thayi_card_no%></td>
							</tr>
						  
						<%				
						 }
					
					}
				}
				%>
				</table></div></div></div></div>
				
	    <%					
			}
			catch(Exception  e)
			{
				System.out.println("Exception::"+e);
				e.printStackTrace();
			}				
		%>
		</body></html>
		