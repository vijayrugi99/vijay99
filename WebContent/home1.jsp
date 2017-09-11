<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv=”Pragma” content=”no-cache”>
		<meta http-equiv=”Expires” content=”-1?>
		<meta http-equiv=”CACHE-CONTROL” content=”NO-CACHE”>

 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="snackbar.css">
<title>Home page</title>
<style>
       #snackbar1 {
    visibility: hidden;
    min-width: 250px;
    margin-left: -125px;
    background-color: #333;
    color: #fff;
    text-align: center;
    border-radius: 2px;
    padding: 16px;
    position: fixed;
    z-index: 1;
    left: 50%;
    margin-top:250px;
    bottom: 30px;
    font-size: 17px;
}
#snackbar1.show {
    visibility: visible;
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}
        /*    #img
		    {
		     width:850pt;
		     top: 50px;
            
		    }*/
.modal-dialog{overflow:visible;min-height:100%!important;}

  
		     .navbar {
		 
      
  } 
	.dropdown-menu{background-color:#808080;}
	.dropdown-menu>li>a:hover { 
    		background-color: black;
		}
img {
    width: 100%;
    height: auto;
} 

</style>

   <script>
          function snackbar(){
   if(document.URL.indexOf("code") != -1) {
	   var x = document.getElementById("snackbar")
	    x.className = "show";
	    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
	}}
          
          function myfun()
          {
        	  $(document).ready(function(){
             	  $('#myModal').modal('show');
              });
          }
 </script>
</head>
<body onload="javascript:snackbar()" >
<div id="snackbar1">Password changed successfully</div>

<%
String err="";
err=request.getParameter("err");
if(err!=null){
if(err.equals("s"))
/* System.out.println("Err="+err);
if(err.equals("s")) */
{
	%>
	<script>
	var y = document.getElementById("snackbar1")
    y.className = "show";
    setTimeout(function(){ y.className = y.className.replace("show", ""); }, 2000);
      </script>
	
	    
<%}}
%>

<nav class="navbar navbar-inverse navbar-fixed-top">

  <div class="container-fluid">
    <div class="navbar-header">

    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="home1.jsp"><b><span class="label label-danger">KMC Project </span></b></a>
    </div>
<div class="collapse navbar-collapse" id="myNavbar">
    <ul class="nav navbar-nav">
    <% 
    String user=null;
     if(session.getAttribute("username") == null)
     {   
 	    response.sendRedirect(request.getContextPath() + "/index.html");

     }
     
      else {	 if(!session.getAttribute("role").equals("CallCenter"))
        {      
 %>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white">FI Forms</font></b><span class="caret"></span></a>
        <ul class="dropdown-menu">
	<li><a href="NewBorn.jsp"><b><font color="white">Facility new born baby listing form</font></b> </a><br></li>
	<li><a href="home_listing.jsp"><b><font color="white">Home Born listing form</font></b> </a><br></li>
          <li><a href="KMC_Pending_Details.jsp"><b><font color="white">Enter the KMC initiation date</font></b></a><br></li>
          <li><a href="KMC_Initiated_Records.jsp"><b><font color="white">KMC initiated babies(Enter KMC details)</font></b></a></li>
        </ul>
      </li>
      <%}
    	   
    	  
      %>
<%
if(!session.getAttribute("role").equals("fi"))
{      
 %>
	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white">Call Center Forms</font></b><span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="kmc_tracking.jsp" ><b><font color="white">Track KMC</font></b> </a></li>
	<li><a href="kmctrack_normal.jsp" ><b><font color="white">Track KMC(28day-normal)</font></b> </a></li>
	        </ul>
      </li>
<%} %>

    <%
  	if(!session.getAttribute("role").equals("CallCenter") && !session.getAttribute("role").equals("fi"))
{      
 %>
        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white">Data Reports</font></b><span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="allDocuments.jsp" ><b><font color="white">All listing  Documents</font></b></a><br></li>
        <li><a href="BabyDetails_by_facility_date.jsp" ><b><font color="white">New born listing report</font></b></a><br></li>
        <li><a href="BabyDetails_by_dob.jsp" ><b><font color="white">New born tabular listing report</font></b></a><br></li>
        <li><a href="homeborn_babies.jsp" ><b><font color="white">Home born listing report</font></b></a><br></li>
        <li><a href="Discharged_Babies.jsp"><b><font color="white">Discharged Babies</font></b></a><br><li>
	    <li><a href="Total_BabyCount.jsp"><b><font color="white">Total Babies Count per Week</font></b></a><li>
        </ul>
      </li>
<%} %>
<%
	  	if(!session.getAttribute("role").equals("CallCenter"))
{      
 %>
	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white">Error Reports</font></b><span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="ErrorReport.jsp" ><b><font color="white"> Extra Records</font></b></a><br></li>
          <li><a href="Each-Field-Report.jsp"><b><font color="white">Identifier Contact details Coverage</font></b></a><br></li>
          <li><a href="LBW_error_report.jsp"><b><font color="white">Mistmatch in lbw count and data collected</font></b></a><br></li>
          <li><a href="deletedRecords.jsp"><b><font color="white">Deleted-Records</font></b></a><br></li>
          <li><a href="foundDuplicates.jsp"><b><font color="white">Duplicate_Records</font></b></a></li>
        </ul>
      </li>
      <%} %>
         <%
  	if(!session.getAttribute("role").equals("CallCenter") && !session.getAttribute("role").equals("fi"))
{      
 %>
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white">Monitoring Reports</font></b><span class="caret"></span></a>
        <ul class="dropdown-menu">
           <li><a href="Facility_NM_Details.jsp"><b><font color="white"> Facility and nurse mentor(FI) details</font></b></a><br></li>
 	       <li><a href="searchCW.jsp" ><b><font color="white">Community Workers</font></b></a><br><li>
			<li><a href="DD_Report.jsp"><b><font color="white">Data-Dictionary</font></b></a><br></li>
			<li><a href="calldetails_allbabies.jsp"><b><font color="white">LBW Babies Call Status </font></b></a><br></li>
			<li><a href="call_attempt_report.jsp"><b><font color="white"> LBW Babies Call Attempts </font></b></a></li>
        </ul>
      </li>
      <%} %>
         <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white">Integration Reports</font></b><span class="caret"></span></a>
        <ul class="dropdown-menu">
           <li><a href="csvfile_report.jsp"><b><font color="white"> Redcap Data Export</font></b></a></li>
        </ul>
      </li>
    </ul>
  
<ul class="nav navbar-nav navbar-right">

       <%
             user=null;
       /* 
            if(session.getAttribute("username")==null)
           {   
        	   response.sendRedirect(request.getContextPath() + "/index.html");

           } 
           else */
          
        	   user = session.getAttribute("username").toString();
        	   if(session.getAttribute("role").equals("admin"))
        	   {      
                 
                %>
               <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><span class=" glyphicon glyphicon-user"></span><span class="caret"></span></b></a>
               <ul class="dropdown-menu">
               <li><a href="addUser.jsp"><b><font color="white">AddUser</font></b></a></li>
                <li><br><a href="viewUser.jsp"><b><font color="white">ModifyUser</font></b></a></li>
               </ul>
               <% 
               }
        	   else
        	   {
        		   %>
        		   <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><span class=" glyphicon glyphicon-comment"></span><span class="caret"></span></b></a>
                   <ul class="dropdown-menu">
                    <li><a onclick="myfun()"><b><font color="white">Help</font></b></a></li>
                    </ul>
                   <%
        	   }
           
      }
            %>
            </li> 
           <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white" size="4"><%=user%><span class="caret"></span></font></b></a>
           <ul class="dropdown-menu">
            <li><a href="CPass.jsp"><b><font color="white">Change Password</font></b></a></li>
            <li><br><a href="logout.jsp" ><span class=" glyphicon glyphicon-log-out"></span><b><font color="white">Logout</font></b></a></li>
            </ul>
            </li>
    </ul>
  </div>
  </div>
</nav>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-sm">
	<div class="modal-content">
	 <div class="modal-header">
	 <h3 style="color:brown;align:center"> Issue Details</h3>
		  <button type="button" class="close" data-dismiss="modal">&times;</button>
	  </div>
	  <div class="modal-body">	
	<div align="center">
	  <form class="form-inline" action="InsertFeedback.jsp" method="get">
		
    	<label for="phone">Phone Number:</label>
    	<input type="text" class="form-control" id="phone" name="phone" required>
  <br>
  <div align="center">
    <label for="email">Email address:</label>
    <input type="email" class="form-control" name="email" id="email">
  </div>
  <div align="center">
    <label for="issue">Issue:</label><br>
		<textarea rows="4" cols="30" class="form-control"></textarea>
  </div>
  <div align="center">
    <label for="file">Issue:</label>
    <input type="file" style="width:260px" class="form-control" name="file" id="file" accept="image/x-png,image/gif,image/jpeg" />
  </div><br>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
											</div>
									        </div>
									    </div>
									  </div>
							</div>
<div id="snackbar">Welcome to KMC</div>

<br>
<br>
<br>
<%String uri = request.getRequestURI();

String pageName = uri.substring(uri.lastIndexOf("/")+1);
if(pageName.equals("home1.jsp")){
%>

<center>
<img id="img" src="low-birth-weight-13-638.jpg" width="width=device-width">
</center> 
<%} %>

</body>
</html>