<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>  -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home page</title>
<style>    
	.dropdown-menu{background-color:#808080;}
	.dropdown-menu>li>a:hover { 
    		background-color: black;
		}
img {
    width: 100%;
    height: auto;
}
</style>

</head>
<body>
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

    	System.out.print("hi");
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
			<li><a href="calldetails_allbabies.jsp"><b><font color="white">LBW Babies Call Status </font></b></a></li>
			<li><a href="call_attempt_report.jsp"><b><font color="white"> LBW Babies Call Attempts </font></b></a></li>
        </ul>
      </li>
      <%} %>
        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b><font color="white">Integration Reports</font></b><span class="caret"></span></a>
        <ul class="dropdown-menu">
           <li><a href="csvfile_report.jsp"><b><font color="white"> Redcap Data Export</font></b></a><br></li>
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

<br>
<br>
<br>
<%String uri = request.getRequestURI();

String pageName = uri.substring(uri.lastIndexOf("/")+1);
if(pageName.equals("home.jsp")){
%>

<center>
<img id="img" src="low-birth-weight-13-638.jpg" width="460" height="345">
</center> 
<%} %>

</body>
</html>