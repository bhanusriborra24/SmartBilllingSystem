<%@ page import="java.sql.*" %>
<%@ page import="java.sql.SQLIntegrityConstraintViolationException" %>

<%
String id = request.getParameter("id");

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

    String sql = "DELETE FROM users WHERE id=?";

    ps = con.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(id));

    int result = ps.executeUpdate();

    response.sendRedirect("employeemanagerList.jsp");
}
catch(SQLIntegrityConstraintViolationException e)
{
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cannot Delete</title>

<style>
body{
    margin:0;
    font-family:Arial,sans-serif;
    background:#f4f6f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    width:420px;
    background:white;
    padding:30px;
    border-radius:10px;
    text-align:center;
    box-shadow:0 0 10px rgba(0,0,0,.2);
}

h2{
    color:red;
}

p{
    font-size:17px;
    color:#333;
}

a{
    display:inline-block;
    margin-top:20px;
    padding:10px 20px;
    background:darkgreen;
    color:white;
    text-decoration:none;
    border-radius:5px;
}

a:hover{
    background:#006400;
}
</style>

</head>

<body>

<div class="box">
    <h2>Cannot Delete Employee</h2>

    <p>
        This employee cannot be deleted because billing records exist for this employee.
    </p>

    <a href="employeemanagerList.jsp">Back</a>
</div>

</body>
</html>

<%
}
catch(Exception e)
{
    out.println("<h3>Error : " + e.getMessage() + "</h3>");
}
finally
{
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>