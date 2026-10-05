<%@ page import="java.sql.*"%>

<%

String email=request.getParameter("email");
String phone=request.getParameter("phone");
String password=request.getParameter("password");

Connection con=null;
PreparedStatement ps=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
"");

String sql="UPDATE users SET password=? WHERE email=? AND phone=?";

ps=con.prepareStatement(sql);

ps.setString(1,password);
ps.setString(2,email);
ps.setString(3,phone);

int i=ps.executeUpdate();

if(i>0){

out.println("<script>");
out.println("alert('Password Reset Successfully');");
out.println("location='login.html';");
out.println("</script>");

}
else{

out.println("<script>");
out.println("alert('Invalid Email or Phone Number');");
out.println("location='forgotpassword.html';");
out.println("</script>");

}

}
catch(Exception e){

out.println(e);

}

%>