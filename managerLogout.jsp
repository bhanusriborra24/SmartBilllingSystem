<%@ page session="true" %>
<%
session.invalidate();
response.sendRedirect("managerLogin.html");
%>