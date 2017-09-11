<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
	<title> Call to Community</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
	<%	
		String phone = request.getParameter("phoneNum");
		String commName = request.getParameter("commName");
		String role = request.getParameter("role");
		String mother = request.getParameter("mother");
	%>
	<div class="container">	
		<center>
		<h3 style="color:brown"> Community Details </h3>
		<%-- <form class="form-inline" method="post">										
			<div class="form-group">
				<label for="email">MotherName:</label>
				<input type="text" id="motherName" name="motherName" value="<%= mother%>" style = "text-align:center">&nbsp				
			</div>
			<div class="form-group">
				<label for="email">CommunityWorker:</label>	
				<input type="text" id="commName" name="commName" value="<%= commName%>" style = "text-align:center">&nbsp				
			</div>			
			
			<div class="form-group">
				<label for="email">PhoneNumber:</label>	
				<input type="text" id="phnum" name="phnum" value="<%= phone%>" style = "text-align:center">&nbsp				
			</div>
			<div class="form-group">
				<label for="email">Role:</label>
				<input type="text" id="role" name="role" value="<%= role%>" style = "text-align:center">				
			</div>			
			<br />
			<br />			
				<a href='tel:"<%= phone%>"' style="text-decoration:underline; text-align:center"> Make a call </a>			
		</form>	 --%>
		
		<form class="form-horizontal" method="post">										
			<div class="form-group">
			<div class="col-sm-offset-3">
				<label class="control-label col-sm-2" for="email">MotherName:</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" id="motherName" name="motherName" value="<%= mother%>" style = "text-align:center">
				</div>			
			</div>
			</div>
			<div class="form-group">
			<div class="col-sm-offset-3">
				<label class="control-label col-sm-2" for="email">CommunityWorker:</label>	
				<div class="col-sm-5">
					<input class="form-control" type="text" id="commName" name="commName" value="<%= commName%>" style = "text-align:center">	
				</div>			
			</div>			
			</div>
			<div class="form-group">
			<div class="col-sm-offset-3">
				<label class="control-label col-sm-2" for="email">PhoneNumber:</label>	
				<div class="col-sm-5">
					<input class="form-control" type="text" id="phnum" name="phnum" value="<%= phone%>" style = "text-align:center">	
				</div>			
			</div>
			</div>
			<div class="form-group">
			<div class="col-sm-offset-3">
				<label class="control-label col-sm-2" for="email">Role:</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" id="role" name="role" value="<%= role%>" style = "text-align:center">
				</div>				
			</div>	
			</div>		
			<br />					
				<a href='tel:"<%= phone%>"' style="text-decoration:underline; text-align:center"> Make a call </a>			
		</form>
		</center>
	</div>
	
</body>
</html>