<%@ page import="java.sql.*" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/supermarketdb",
        "root",
        ""
    );

    String sql = "SELECT * FROM users WHERE (username=? OR email=?) AND password=? AND role='Employee'";

    ps = con.prepareStatement(sql);
    ps.setString(1, username);
    ps.setString(2, username);
    ps.setString(3, password);

    rs = ps.executeQuery();

    if(rs.next())
    {
        session.setAttribute("id", rs.getInt("id"));
        session.setAttribute("fullname", rs.getString("fullname"));
        session.setAttribute("username", rs.getString("username"));

        response.sendRedirect("employeeDashboard.jsp");
    }
    else
    {
%>

<script>
alert("Invalid Employee Username/Email or Password");
location="employeeLogin.html";
history.back();
</script>

<%
    }

}
catch(Exception e)
{
    out.println("<h3>Database Error</h3>");
    out.println(e);
}
finally
{
    try
    {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
    catch(Exception ex){}
}
%>