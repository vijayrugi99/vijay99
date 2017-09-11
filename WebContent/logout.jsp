<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <script>
	function noBack(){
		window.history.forward(1)
		browser.cache.offline.enable=false
		
	}
	</script>
</head>
<body onload="noBack()">
<% 
 session.removeAttribute("username"); 
 session.invalidate();

 response.sendRedirect(request.getContextPath() + "/login.jsp?val="+1);
%>
 <h1> Logout was done successfully.</h1>
</body>
</html>