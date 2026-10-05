<%@ page import="java.sql.*"%>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

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

    String sql = "UPDATE users SET password=? WHERE email=? AND role='Employee'";

    ps = con.prepareStatement(sql);

    ps.setString(1, password);
    ps.setString(2, email);

    int i = ps.executeUpdate();

    if(i > 0)
    {
%>

<script>
alert("Employee Password Reset Successfully");
location="employeeLogin.html";
</script>

<%
    }
    else
    {
%>

<script>
alert("Invalid Employee Email");
location="employeeForgotPassword.html";
history.back();
</script>

<%
    }

}
catch(Exception e)
{
    out.println(e);
}
finally
{
    try{
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }catch(Exception ex){}
}
%>