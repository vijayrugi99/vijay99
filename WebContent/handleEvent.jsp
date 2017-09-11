<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String ctrl=request.getParameter("ctrl");

if(ctrl!=null && ctrl.equals("ExportToexcel"))
{
	 response.setContentType("application/vnd.ms-excel");
     response.setHeader("Content-Disposition", "inline; filename="
             +request.getParameter("filename"));
     //out.println("ExportToExcel");
;
}

%>
    