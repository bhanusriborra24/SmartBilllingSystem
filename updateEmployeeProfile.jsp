<%@ page import="java.sql.*" %>

<%
String oldUsername = (String)session.getAttribute("username");

if(oldUsername == null)
{
    response.sendRedirect("employeeLogin.html");
    return;
}

String fullname = request.getParameter("fullname");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String newUsername = request.getParameter("newUsername");

Connection con = null;
PreparedStatement ps = null;

try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/supermarketdb",
        "root",
        ""
    );

    String sql = "UPDATE users SET fullname=?, email=?, phone=?, username=? WHERE username=?";

    ps = con.prepareStatement(sql);

    ps.setString(1, fullname);
    ps.setString(2, email);
    ps.setString(3, phone);
    ps.setString(4, newUsername);
    ps.setString(5, oldUsername);

    int rows = ps.executeUpdate();

    if(rows > 0)
    {
        session.setAttribute("username", newUsername);
        response.sendRedirect("employeeMyProfile.jsp");
    }
    else
    {
        response.sendRedirect("employeeMyProfile.jsp");
    }

}
catch(Exception e)
{
    out.println(e);
}
finally
{
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>