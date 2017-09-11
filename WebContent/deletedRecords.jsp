<%@page import="com.kentropy.mongodb.DeleteMongodbObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
   	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
	<title>Deleted Records</title>
	<link rel="stylesheet" href="Responsive_Style.css">
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
		width: 1150px;
		margin-bottom:0px;
		border:1px solid #999;
	
	}
	.tablebody {
		height: 600px;
		overflow-y: auto;
		width: 1165px;
		margin-bottom:20px;
	}
   </style>
	<script>
	function confirmFun( db,coll,ID,delColl){
		//var val=confirm("Are You Sure You Want To Insert Back....?\n please Confirm..!");
		//if (val==true){
		    var call_jsp ='putBack.jsp?db='+db+'&coll='+coll+'&ID='+ID+'&delColl='+delColl;
			window.location.href=call_jsp;
		//}
		
	}
	function confirmFun2( db,coll,ID,uid,delColl){
		var val=confirm("Are You Sure You Want To Insert Back....?\n please Confirm..!");
		if (val==true){
		    var call_jsp ='putBack1.jsp?db='+db+'&coll='+coll+'&ID='+ID+'&uid='+uid+'&delColl='+delColl;
			window.location.href=call_jsp;
		}
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
		<%@ include file="home.jsp" %>  
		<%@ page import ="com.mongodb.WriteResult" %>
		<%-- <%@page import="com.kentropy.mongodb.DeleteMongodbObject" %> --%>
		
   		<%
        	com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
		//MongoClient mongoclient = (MongoClient) request.getSession().getServletContext().getAttribute("MONGO_CLIENT");
		MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
		//com.kentropy.mongodb.MongoDAO mongodao = new com.kentropy.mongodb.MongoDAO(db, coll);
		DB database = mongo.getDB(db);
		DBCollection collection = database.getCollection(delColl);
		DBCursor cursor = collection.find();
		%>
		<br />
	 	<div class="container">
		<h2 style="text-align:center;color:brown;"> Deleted Records </h2>
		<div class="row">
		<div id="Deleted Records" class="exporttable table-responsive2">
        <table class="table table-bordered table-striped tableheader">
        <thead>
           <tr>
               	<th style="width:50px"> Sl. No.</th>
				<th style="width:250px"> ObjectID </th>
				<th style="width:150px"> Operation</th>
				<th style="width:200px"> Babies Unique ID </th>
				<th style="width:100px"> Facility </th>
				<th style="width:100px"> Baby DOB </th>
				<th style="width:100px"> Patient ID1 </th>
				<th style="width:100px"> Mother Name </th>
				<th style=""> Husband Name </th>	
			</tr>				
		</thead>
        </table>
        <div class="tablebody">
        <table class="table table-bordered table-striped" >
        <tbody>
		<%	
		int count=1;
		Object uid="-";
		Object fac="-";
		Object dob="-";
		Object pid1="-";
		Object mname="-";
		Object hname="-";
		while(cursor.hasNext())
		{
			DBObject obj = cursor.next();
			//System.out.println("Object::"+obj);
			Object id = obj.get("objectId");
			//System.out.println("ID="+id);
			// if statements to find records deleted by uniqueid 
			if(obj.containsField("output"))
			{
				DBObject ob = (DBObject)obj.get("output");
				if(ob.containsField("unique_id"))
				{
					 uid = ob.get("unique_id");
				}
				if(ob.containsField("dob"))
				{
					 dob = ob.get("dob");
				}
				if(ob.containsField("pid1"))
				{
					 pid1 = ob.get("pid1");
				}
				if(ob.containsField("mother_name"))
				{
					 mname = ob.get("mother_name");
				}
				if(ob.containsField("husband_name"))
				{
					 hname = ob.get("husband_name");
				}
				if(obj.containsField("facility"))
				{
					DBObject fa =  (DBObject)obj.get("facility");
					if(fa.containsField("facility"))
					{
						 fac = fa.get("facility");
					}
				}
					%>		   
			<tr>
				<td style="width:50px"><%= count++%> </td>
				<td style="width:250px"><%= id %> </td>
				<td style="width:150px">
					<button  type="button" style="color:black;" class="btn btn-info btn-sm" onclick="confirmFun2('<%=db%>','<%=coll%>','<%=id %>','<%=uid %>','<%=delColl %>')" id="btn" class="btn btn-default">
					InsertBack</button>
				</td>
				<td style="width:200px"> <%= uid %> </td>
				<td style="width:100px"><%=fac %></td>
				<td style="width:100px"> <%= dob %> </td>
				<td style="width:100x"> <%= pid1 %> </td>
				<td style="width:100px;word-wrap:break-word;"> <%=mname %> </td>
				<td style="word-wrap:break-word;"> <%= hname %> </td>
			</tr> 
			<%				
			}
			Object id1 = obj.get("_id");
			Object ID=(Object)id1;
			//String ID=(String)id2;
			// if statemnet to find records deleted by _id
			if(obj.containsField("data"))
			{
				BasicDBList list = (BasicDBList)obj.get("data");
				DBObject data0 =(DBObject)list.get(0);
				BasicDBList data1 = (BasicDBList)list.get(1);
				int size =data1.size();
				if(data0.containsField("facility"))
				 {
					bd.facility=data0.get("facility");
					
				 }
				else
				{
					bd.facility="-";
				}
		    	 %>
				<tr>
					<td  style="vertical-align:middle;width:50px"rowspan=<%=data1.size() %>><%= count++%></td>
					<td  style="vertical-align:middle;width:250px" rowspan=<%=data1.size() %>><%=ID %></td>
			    	<td  style="vertical-align:middle;width:150px" rowspan=<%=data1.size() %>>
			    		<button  style="color:black;" type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">  
			    		InsertBack</button>
			    	</td>
	   			<% 
				for(int p=0;p<data1.size();p++)
				{
					BasicDBObject Array = (BasicDBObject) data1.get(p);
					if(Array.containsField("unique_id"))
					{
						bd.u_id = Array.get("unique_id");
						//System.out.println("uid:"+bd.u_id);
					}
					else
					bd.u_id ="-";	
					if(Array.containsField("pid1"))
					{
						bd.pid1 = Array.getInt("pid1");
						//System.out.println("pid1:"+bd.pid1);
					}
					else
					bd.pid1 = "-";
					if(Array.containsField("time_of_birth"))
					{
					bd.time_of_birth = Array.get("time_of_birth");
					//System.out.println("time_of_birth:"+bd.time_of_birth);
					}
					else
					bd.time_of_birth = "-";
			
					if(Array.containsField("mother_name"))
					{
						bd.mother_name = Array.get("mother_name");//getInt("epic");
			   			//System.out.println("mother_name:"+bd.mother_name);
					}
					else
					bd.mother_name = "-";	
					if(Array.containsField("sex"))
					{
						bd.sex = Array.get("sex");
			   			//System.out.println("sex:"+bd.sex);
					}
					else
					bd.sex = "-";
			
					if(Array.containsField("phone1"))
					{
					bd.phone1 = Array.get("phone1");
					//System.out.println("phone1:"+bd.phone1);
					}
					else
					bd.phone1 = "-";	
					if(Array.containsField("unique_id"))
					{
						bd.uid = Array.get("unique_id");
			   			//System.out.println("uid:"+bd.u_id);
					}
					else
					bd.uid ="-";
			
					if(Array.containsField("dob"))
					{
						bd.dob = Array.get("dob");
			 			//System.out.println("dob:"+bd.dob);
					}
					else
					{
						bd.dob="-";
					}
			
					if(Array.containsField("birth_weight"))
					{
						bd.birth_weight = Array.get("birth_weight");
			 	 		//System.out.println("birth_weight:"+bd.birth_weight);
					}	
					else
					bd.birth_weight="-";
			
					if(Array.containsField("husband_name"))
					{
						bd.husband_name = Array.get("husband_name");
			   			//	System.out.println("husband_name:"+bd.husband_name);
					}
					else{
					bd.husband_name="-";
					}
					if(Array.containsField("dob"))
					{
						bd.dob = Array.get("dob");
			 			//System.out.println("dob:"+bd.dob);
					}
					else
					{
						bd.dob="-";
					}
				%>
			
					<td style="width:200px"> <%= bd.uid %> </td>	
					<td style="width:100px"><%=bd.facility %></td>
					<td style="width:100px"> <%= bd.dob %> </td>
					<td style="width:100px"> <%= bd.pid1 %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.mother_name %> </td>
					<td style="word-wrap:break-word;"> <%= bd.husband_name %> </td>
		   		</tr>
					<div class="modal fade" id="myModal" role="dialog"  data-backdrop="static" width="20%">
					    <div class="modal-dialog">
					      <!-- Modal content-->
					      <div class="modal-content">
					        <!-- <div class="modal-header">
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					          <h4 class="modal-title">Modal Header</h4>
					        </div> -->
					         <div align="center">
					        <div class="modal-body">
					          <p style="color:red"><b>Are You Sure You Want To Insert Back....? <br> please Confirm..!</b></p>
					        </div>
					        <a  class="btn btn-info " onclick="confirmFun('<%=db%>','<%=coll%>','<%=ID %>','<%=delColl %>')">Okay</a>&nbsp;&nbsp;
					        <button type="button"  class="btn btn-info"  data-toggle="modal"  data-dismiss="modal" >Cancel</button>
					        <div class="modal-footer">
					        </div>
					      </div>
					      
					    </div>
					  </div>
					  </div>
				<%		    
			}
		}
	}	
   %>    
 </tbody>
</table>
</div></div>
</div>
</div>
<%@include file="tableexport.jsp" %>
</body>
</html>