<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> Delete Records </title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</head>		
	<body>		
		<%@ include file="Config.jsp"%> 	
		<% 			
			String objid = request.getParameter("id1");	
			String filename = request.getParameter("filename");
			//System.out.println("Object id ="+objid);			
			try
			{
				int n = new com.kentropy.mongodb.DeleteMongodbObject().delete(objid, db, coll, delColl);
				if(n==1){
					 %>
					 	<script>
					       $(document).ready(function(){
					     	  $('#myModal').modal('show');
					      });
					     </script>
					 	<div class="modal fade" id="myModal" role="dialog"  data-backdrop="static" width="20%">
					     <div class="modal-dialog">
					     <div class="modal-content">
					     <div align="center">
					     <div class="modal-body">
					     <p style="color:red"><b>Record Successfully Deleted...</b></p>
					     </div>
					    <button type="button" class="btn btn-primary"onclick="window.location.href='<%=filename%>'"><b>OKay</b></button>
					     <div class="modal-footer">
					     </div>
					     </div>
					     </div>
					     </div>
					     </div>
					     <%
					    }
						else{
							%>
					 	<script>
					       $(document).ready(function(){
					     	  $('#myModal1').modal('show');
					      });
					     </script>
					 	<div class="modal fade" id="myModal1" role="dialog"  data-backdrop="static" width="20%">
					     <div class="modal-dialog">
					     <div class="modal-content">
					     <div align="center">
					     <div class="modal-body">
					     <p style="color:red"><b>Sorry unable deleted the record...</b></p>
					     </div>
					    <button type="button" class="btn btn-primary"onclick="window.location.href='BabyDetails_by_facility_date.jsp'"><b>OKay</b></button>
					     <div class="modal-footer">
					     </div>
					     </div>
					     </div>
					     </div>
					     </div>
					     <%
						}
					//out.println("<h3 style = text-align:center;color:brown;margin-top:50px>"+str+"</h3>");				
			}
			catch(Exception e)
			{			
				e.printStackTrace();				
				//out.println("<h3 style = text-align:center;color:brown;margin-top:50px> Object already Exists in Delete Record collection, Duplication not allowed</h3>");
			}		
		%>	
		<
	</body>
</html>