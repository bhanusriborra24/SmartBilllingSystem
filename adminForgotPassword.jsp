<%@ page import="java.sql.*"%>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

Connection con=null;
PreparedStatement ps=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
"");

String sql="UPDATE admin SET password=? WHERE email=?";

ps=con.prepareStatement(sql);

ps.setString(1,password);
ps.setString(2,email);

int i=ps.executeUpdate();

if(i>0){

out.println("<script>");
out.println("alert('Password Reset Successfully');");
out.println("location='adminLogin.html';");
out.println("</script>");

}
else{

out.println("<script>");
out.println("alert('Invalid Email or Phone Number');");
out.println("location='adminForgotPassword.html';");
out.println("</script>");

}

}
catch(Exception e){

out.println(e);

}

%>