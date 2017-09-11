<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	
	<title>All Documents</title>
  	<script src="facilities.js">	</script>
	<script src="ken_kmc_html.js"></script>
	<link rel="stylesheet" type="text/css" href="Responsive_Style.css">
  
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  	<!-- must include -->
   	<style>
   		.table>tbody>tr>td{vertical-align:middle;}
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
		width: 2450px;
		margin-bottom:0px;
		border:1px solid #999;
		text-align:center;
	
		}
		.tablebody {
		height: 400px;
		overflow-y: auto;
		width: 2465px;
		margin-bottom:20px;
		}   
   	</style>		
</head>

<body>
	<%@ page import="java.sql.*" %>
	<%@page import="java.awt.List" %>
	<%@page import= "java.util.*" %>
	<%@page import="com.mongodb.ServerAddress" %>
	<%@page import="com.mongodb.DBCursor" %>
	<%@page import="com.mongodb.DBObject" %>
	<%@page import="com.mongodb.BasicDBObject" %>
	<%@page import="com.mongodb.DBCollection" %>
	<%@page import="com.mongodb.DB" %>
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
	<%@page import="com.mongodb.util.JSON" %>
	<%@page import="java.text.*" %>
	<%@include file="Config.jsp" %>
  
	<%@include file="handleEvent.jsp" %> 
	
		<% 
			//logic to set page number to 1 default			
			String pageNo = request.getParameter("page");
			if(pageNo == null)
			{
				pageNo = "1";
			}
			
			//logic to set records per page to 5 default
			int records=5;
			int records1=1;

			if(records1==1)
			{
				records1=5;
			}

			if(request.getParameter("recordsPerPage")!=null)
			{
				records=Integer.parseInt(request.getParameter("recordsPerPage"));
				records1+=records;
			}
			System.out.println("Record  per page from dropdown list = "+records);
			//calculate no of records per page and page number
			System.out.println("pagenumber from request = "+pageNo);
			//out.print("<h3>Page No: "+pageNo+"</h3>");				
			int pageNum = Integer.parseInt(pageNo);
			int currentPageNum = Integer.parseInt(pageNo);
			int recordPerPage = records;				
			System.out.println("Record  per page = "+recordPerPage);
		
			if(pageNum==1)
			{}  
			else if(request.getParameter("btnPressed").equals("next"))
			{  
				pageNum=pageNum-1;  
			    System.out.println("pagenumber when next pressed= "+pageNum);
			    pageNum=pageNum*recordPerPage+1; 
			    System.out.println("pageid no after calculation in next = "+pageNum);
			}	
			else if(request.getParameter("btnPressed").equals("back"))
			{  
				pageNum=pageNum-1;  
			    System.out.println("pageNumber when back pressed = "+pageNum);
			   	pageNum=pageNum*recordPerPage+1; 
			   	System.out.println("page no after calculation in back = "+pageNum);
			}
		
			System.out.println("no of records per page ="+recordPerPage);
			int skipValue = pageNum-1;	
			System.out.println("no of Skip values="+skipValue);
			String countv=request.getParameter("count");
			String countp=request.getParameter("countp");
			int count=1;
			if(countv == null)
			{
			  count=1;
			}
			else
			{
				count=Integer.parseInt(countv);
			}
			if(pageNum==1)
			{
				count=0;
			}
			if(pageNum>1)
			{
				count=(Integer.parseInt(pageNo)*Integer.parseInt(request.getParameter("recordsPerPage"))-Integer.parseInt(request.getParameter("recordsPerPage")));
			}	
		%>		
		<div class="container">
		<center>
		<form action="allDocuments.jsp" method="POST" class="form-inline">
		<h1 style = "color:brown"> All Documents </h1>			
		<div class="form-group">
			<div id="filters2"></div>
			<script>
				var filterStr= DropdownFilter(recordsFilter,"<%= records%>");				
				filters2.innerHTML=filterStr;
			</script>
		 	</div>
		<br />
		<button type="submit" class="btn btn-primary">Submit</button>
		<br /> 																					
		</form>	
		</center>
		</div>	
		<br />				
		<div class="container">
		<div class="row">
		<div id="allDocument" class="exporttable table-responsive2">
        <table class="table table-bordered table-striped tableheader">
        <thead>
              <tr>	
					<th style="width:50px;text-align:center;"> Sl. No.</th>
					<th style="width:200px;text-align:center;"> ObjectID </th>
					<th style="width:200px;text-align:center;"> Babies Unique ID </th>
					<th style="width:100px;text-align:center;"> Baby DOB </th>
					<th style="width:100px;text-align:center;"> SurveyType </th>
					<th style="width:100px;text-align:center;"> Patient_ID1 </th>
					<th style="width:100px;text-align:center;"> Patient_ID2 </th>
					<th style="width:150px;text-align:center;"> Mother Name </th>
					<th style="width:150px;text-align:center;"> Husband Name </th>
					<th style="width:100px;text-align:center;"> Time of Birth </th>
					<th style="width:100px;text-align:center;"> Birth Weight </th>
					<th style="width:100px;text-align:center;"> Baby Sex </th>
					<th style="width:100px;text-align:center;"> Baby Status </th>
					<th style="width:100px;text-align:center;"> Taluk From </th>
					<th style="width:100px;text-align:center;"> Taluk To </th>
					<th style="width:100px;text-align:center;"> Community to </th>
					<th style="width:100px;text-align:center;"> Community From </th>
					<th style="width:100px;text-align:center;"> Phone1 </th>
					<th style="width:100px;text-align:center;"> Phone2 </th>
					<th style="width:100px;text-align:center;"> Thayi Card No </th>
					<th style="width:100px;text-align:center;"> UID </th>
					<th style="text-align:center;"> EPIC </th>
				</tr>
          </thead>
          </table>
          <div class="tablebody">
          <table class="table table-bordered table-striped" ><tbody>
        <%
		try
		{
			com.kentropy.kmc.bean.BabyDetails bd = new com.kentropy.kmc.bean.BabyDetails();
			com.kentropy.kmc.bean.TimeCalculation tc = new com.kentropy.kmc.bean.TimeCalculation();
			int i=0;
			//MongoClient mongoclient = (MongoClient) request.getSession().getServletContext().getAttribute("MONGO_CLIENT");
			MongoClient mongo = (MongoClient)com.kentropy.mongodb.MongoDAO.getMongoClient();
			DB database = mongo.getDB(db);
			//System.out.println("Connected to daabase sucessfully...");
			DBCollection collection = database.getCollection(coll);
			String str=null;
			if(recordPerPage==1)
			{
				str="[{$project: {data:{$arrayElemAt: [\"$data\",1]}}},{$unwind: \"$data\"}]";
				System.out.println("query = "+str);
				System.out.println("Inside the records true");
			}
			else
			{
				/* str="[{$project: {data:{$arrayElemAt: [\"$data\",1]}}},{$unwind: \"$data\"}]"; */
  			str="[{$project: {data:{$arrayElemAt: [\"$data\",1]}}},{$unwind: \"$data\"},{$skip :"+skipValue+"},{$limit:"+records1+"}]";
			System.out.println("query = "+str);
				System.out.println("Inside the records false");
			}
			java.util.List<BasicDBObject> lists = (java.util.List<BasicDBObject>)JSON.parse(str);
			Object ID = "-";
			Object u_id1 = "-";
			int size=0;
			Iterable<DBObject> outputs = collection.aggregate(lists).results();
			
			int cnt=0;
			for(DBObject db2:outputs)
			 {
				 ++size;
			 }
			  System.out.println("Size of Array="+size);
				if(recordPerPage==1)
				{
					recordPerPage=size;
				} 
		     for(DBObject db1:outputs)
			{
		    	// System.out.println("size::"+size);
			    if(cnt==recordPerPage)
			    {
			    	continue;
			    }
				++cnt;
				System.out.println("++Cnt="+cnt);
				ObjectId objid = (ObjectId) db1.get("_id");
		    	 BasicDBObject Array=(BasicDBObject)db1.get("data");				
				/*System.out.println("db1 ::"+db1);
				System.out.println("Output inside::"+outputs);
				System.out.println("List item in array name="+Array.get("mother_name")); */
				if(Array.containsField("unique_id"))
				{
					bd.u_id = Array.get("unique_id");
					//System.out.println("uid:"+bd.u_id);
				}
				else{
					bd.u_id ="-";
				}
				if(Array.containsField("pid1"))
				{
					bd.pid1 = Array.get("pid1");
					if(bd.pid1 instanceof String)
					{
						bd.pid1 = Array.get("pid1");
					}
					else
					{
						bd.pid1 = Array.getInt("pid1");
					}						
					//System.out.println("pid1:"+bd.pid1);
				}
				else{
					bd.pid1 = "-";
				}
				if(Array.containsField("pid2"))
				{
					bd.pid2 = Array.get("pid2");
					if(bd.pid2 instanceof String)
					{
						bd.pid2 = Array.get("pid2");
					}
					else
					{
						bd.pid2 = Array.getInt("pid2");
					}
					//System.out.println("pid2:"+bd.pid2);
				}
				else{
					bd.pid2 ="-";
				}
				if(Array.containsField("time_of_birth"))
				{
					bd.time_of_birth = Array.get("time_of_birth");
					//System.out.println("time_of_birth:"+bd.time_of_birth);
				}
				else{
					bd.time_of_birth = "-";
				}
				//to ckeck whether the time is in 12hrs format									
				String time12hrs = tc.convert24To12Format((String)bd.time_of_birth);
				/* System.out.println("time in 24hrs format = "+bd.time_of_birth);
				System.out.println("time in 12hrs format = "+time12hrs);
				System.out.println(); */
				bd.time_of_birth = time12hrs;
				
				if(Array.containsField("thayi_card_no"))
				{
					bd.thayi_card_no = Array.getLong("thayi_card_no");
					//System.out.println("thayi_card_no:"+bd.thayi_card_no);
				}	
				else{
					bd.thayi_card_no ="-";
				}
				
				if(Array.containsField("baby_status"))
				{
					bd.baby_status = Array.get("baby_status");
					String b_status=(String)bd.baby_status;
					if(b_status.equals("1"))
						bd.baby_status="Well";
					else if(b_status.equals("2"))
						bd.baby_status="Sick";
					else
						bd.baby_status="Dead";
						
					//	System.out.println("baby_status:"+bd.baby_status);
				}
				else{
					bd.baby_status ="-";
				}
				if(Array.containsField("mother_name"))
				{
					bd.mother_name = Array.get("mother_name");//getInt("epic");
					//System.out.println("mother_name:"+bd.mother_name);
				}
				else{
						bd.mother_name = "-";
				}
				if(Array.containsField("sex"))
				{
					bd.sex = Array.get("sex");
					String sex1=(String)bd.sex;
					if (sex1.equals("1"))
						bd.sex="Male";
					else if(sex1.equals("2"))
						bd.sex="Female";
					else
						bd.sex="other";
					//System.out.println("sex:"+bd.sex);
				}
				else{
					bd.sex = "-";
				}
				if(Array.containsField("phone2"))
				{
					bd.phone2 = Array.get("phone2");//getInt("epic");
					//System.out.println("phone2:"+bd.phone2);
				}
				else{
					bd.phone2 = "-";
				}
				if(Array.containsField("epic"))
				{
					bd.epic = Array.get("epic");
					if(bd.epic instanceof String)
					{
						bd.epic = Array.get("epic");
					}
					else
					{	
						bd.epic = Array.getInt("epic");
					}
					//System.out.println("epic:"+bd.epic);
				}	
				else{
					bd.epic ="-";
				}
				if(Array.containsField("phone1"))
				{
					bd.phone1 = Array.get("phone1");
					//System.out.println("phone1:"+bd.phone1);
				}
				else{
					bd.phone1 = "-";
				}
				if(Array.containsField("uid"))
				{
					bd.uid = Array.get("uid");
					if(bd.uid instanceof String)
					{
						bd.uid = Array.get("uid");
					}
					else
					{
						bd.uid = Array.getInt("uid");
					}
					//System.out.println("uid:"+bd.u_id);
				}
				else{
					bd.uid ="-";
				}
				if(Array.containsField("taluk_from"))
				{
					bd.taluk_from = Array.get("taluk_from");
					if(bd.taluk_from instanceof String)
					{
						if(bd.taluk_from.equals("other"))
						{
							bd.taluk_from = Array.get("taluk_from")+" [" +Array.get("taluk_from-Comment")+"]";
							//System.out.println("taluk_from:"+bd.taluk_from);
						}
						else
						{
							bd.taluk_from = Array.get("taluk_from");
						}
					}
					else
					{
						bd.taluk_from = Array.getInt("taluk_from");
						//System.out.println("taluk_from:"+bd.taluk_from);
					}
				}	
				else{
					bd.taluk_from ="-";
				}
				if(Array.containsField("taluk_to"))
				{
					bd.taluk_to = Array.get("taluk_to");
					if(bd.taluk_to instanceof String)
					{
						if(bd.taluk_to.equals("other"))
						{
							bd.taluk_to = Array.get("taluk_to")+" [" +Array.get("taluk_to-Comment")+"]";
							//System.out.println("taluk_to:"+bd.taluk_to);
						}
						else
						{
							bd.taluk_from = Array.get("taluk_to");
						}
					}
					else
					{
						bd.taluk_to = Array.getInt("taluk_to");
						//System.out.println("uid:"+bd.taluk_to);
					}
				}
				else{
					bd.taluk_to="-";
				}
				if(Array.containsField("community_to"))
				{
					bd.community_to = Array.get("community_to");
					if(bd.community_to instanceof String)
					{
						if(bd.community_to.equals("other"))
						{
							bd.community_to = Array.get("community_to")+" [" +Array.get("community_to-Comment")+"]";
							//System.out.println("community_to:"+bd.community_to);
						}
					}
					else
					{
						bd.community_to = Array.getInt("community_to");
						//System.out.println("community_to:"+bd.community_to);
					}
				}
				else{
					bd.community_to ="-";
				}
				if(Array.containsField("community_from") )
				{
					bd.community_from = Array.get("community_from");
					if(bd.community_from instanceof String)
					{
						if(bd.community_from.equals("other"))
						{
							bd.community_from = Array.get("community_from")+" [" +Array.get("community_from-Comment")+"]";
							//System.out.println("community_from:"+bd.community_from);
						}
					}						
					else
					{
						bd.community_from = Array.getInt("community_from");
						//System.out.println("community_from:"+bd.community_from);
					}
				}
				else{
					bd.community_from = "-";
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
				if(Array.containsField("birth_weight"))
				{
					bd.birth_weight = Array.getInt("birth_weight");
					//System.out.println("birth_weight:"+bd.birth_weight);
				}	
				else{
					bd.birth_weight="-";
				}					
				if(Array.containsField("husband_name"))
				{
					bd.husband_name = Array.get("husband_name");
					//	System.out.println("husband_name:"+bd.husband_name);
				}
				else{
					bd.husband_name="-";
				}
				if(Array.containsField("surveyType"))
				{	
					bd.surveytype = Array.get("surveyType");	
					//System.out.println("surveytype:"+bd.surveytype);
				}
				else
				{
					bd.surveytype="-";
				}
				%>
	            <tr>			
					<td style="width:50px;"> <%= ++count%> </td>
					<td style="width:200px;word-wrap:break-word;"> <%= objid%> </td>				
					<td style="width:200px;word-wrap:break-word;"> <%= bd.u_id%><br />
						<%-- <a href = deleteObject.jsp?id=<%= objid%>> <%= bd.u_id %></a>  --%>
						<%-- <button type="button" class="btn btn-warning btn-sm" style="color:black;" onclick="window.location.href='deleteObject.jsp?id=<%= objid%>&uid=<%=bd.u_id%>'"> Delete </button> --%>
						<div class="modal fade" id="myModal" role="dialog"  data-backdrop="static" width="20%">
                                <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                <div align="center">
                                <div class="modal-body">
                                <p style="color:red"><b>Are You Sure , Want To Delete This Record....? <br> Please Confirm..!</b></p>
                                </div>
                                <a  class="btn btn-warning" onclick="window.location.href='duplicateCheck.jsp?id1=<%=objid%>&id2=<%=bd.u_id%>'">Yes</a>&nbsp;&nbsp;
                                <button type="button"  class="btn btn-info"  data-toggle="modal"  data-dismiss="modal" >No</button>
                                <div class="modal-footer">
                                </div>
                                </div>
                                </div>
                                </div>
                               </div>
								  
								  <button  type="button" class="btn btn-warning btn-sm" style="color:black;" data-toggle="modal" data-target="#myModal"> Delete</button></td>
							
					</td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.dob %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.surveytype %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.pid1 %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.pid2 %> </td>
					<td style="width:150px;word-wrap:break-word;"> <%= bd.mother_name %> </td>
					<td style="width:150px;word-wrap:break-word;"> <%= bd.husband_name %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.time_of_birth %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.birth_weight %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.sex %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.baby_status %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.taluk_from %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.taluk_to %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.community_to %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.community_from %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.phone1 %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.phone2 %> </td>							    	
					<td style="width:100px;word-wrap:break-word;"> <%= bd.thayi_card_no %> </td>
					<td style="width:100px;word-wrap:break-word;"> <%= bd.uid %> </td>
					<td style="word-wrap:break-word;"> <%= bd.epic %> </td>																			
				</tr>			
				<%				
          }	
		     %>
		     	<tr> <td colspan="22"> <h4 style="text-align:left; color:red;"> ----End of Records----</h4> </td></tr>
		     <%	
		     //System.out.println("Document count::"+i);		
			i++;
				
		%>
		   </tbody>
           </table>
           </div>
           </div></div>		
            </div>		
    	
    	<% 	
		if(recordPerPage != 1)
		{
			
			if(currentPageNum == 1 && (size>cnt || size==cnt))
			{
				%>
				<center>
				<div class="container" >	
					<ul class="pager">						
						<li><a href="allDocuments.jsp?btnPressed=next&page=<%=currentPageNum+1%>&recordsPerPage=<%= recordPerPage%>&count=<%= count%>"" style="background-color:skyblue; color:black"> NEXT </a> </li>
					</ul>
				</div>
				</center>
				<%
			}
			else if(currentPageNum > 1 && size==cnt)
			{
				%>
				<center>
				<div class="container" >	
					<ul class="pager">			
						<li ><a href="allDocuments.jsp?btnPressed=back&page=<%=currentPageNum-1%>&recordsPerPage=<%= recordPerPage%>&countp=<%= count%>"" style="background-color:skyblue; color:black"> Previous </a> </li>	
					</ul>
				</div>
				</center>
				<%
			}
			else if(currentPageNum > 1 && size>cnt)
			{
				%>
				<center>
				<div class="container" >	
					<ul class="pager">			
						<li ><a href="allDocuments.jsp?btnPressed=back&page=<%=currentPageNum-1%>&recordsPerPage=<%= recordPerPage%>&countp=<%= count%>"" style="background-color:skyblue; color:black"> Previous </a> </li>			
						
						<li><a href="allDocuments.jsp?btnPressed=next&page=<%=currentPageNum+1%>&recordsPerPage=<%= recordPerPage%>&count=<%= count%>"" style="background-color:skyblue; color:black"> NEXT </a> </li>
					</ul>
				</div>
				</center>
				<%
			}	
		}
	}//close try block
	catch(Exception e)
	{
		System.out.println(e);
	}
%>	
  
			<%@include file="tableexport.jsp" %>
</body>
</html>