<html>
	<head>
        <title>Greeting Form JSP</title>
	</head>
	<body>
		<%
            String username=request.getParameter("txtuname");
			out.println("Hello ! "+username);
			out.println("<br><br>Welcome "+username);
		%>
	</body>
</html>