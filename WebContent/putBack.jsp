<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<% 
String db=request.getParameter("db");
String coll=request.getParameter("coll");
Object ID = request.getParameter("ID");
String delColl=request.getParameter("delColl");
int res = com.kentropy.mongodb.DeleteMongodbObject.insertDeletedRecordById(db,coll,ID,delColl);
System.out.println("results::"+res);
 if(res==1){
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
    <button type="button" class="btn btn-primary"onclick="window.location.href='deletedRecords.jsp'"><b>OKay</b></button>
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
    <button type="button" class="btn btn-primary"onclick="window.location.href='deletedRecords.jsp'"><b>OKay</b></button>
     <div class="modal-footer">
     </div>
     </div>
     </div>
     </div>
     </div>
     <%
	}
%>
<%-- <center>
<br>
<br>
<br>
<br>
<h2></h2><span style="color:red"><%=res %></span></h2><br>
<button type="button" class="btn btn-default"onclick="window.document.location.href='deletedRecords.jsp'">Back</button>
</center> --%>
</body>
</html>