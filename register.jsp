<%@ page import="java.sql.*" %>

<%
String fullname = request.getParameter("fullname");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String username = request.getParameter("username");
String role = request.getParameter("role");
String password = request.getParameter("password");
String confirmPassword = request.getParameter("confirmPassword");

if(password == null || confirmPassword == null)
{
    out.println("Password field is missing.");
    return;
}

if(!password.equals(confirmPassword))
{
%>
<script>
alert("Password and Confirm Password do not match!");
history.back();
</script>
<%
return;
}

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

    // Check whether username or email already exists
    PreparedStatement check = con.prepareStatement(
        "SELECT * FROM users WHERE username=? OR email=?"
    );

    check.setString(1, username);
    check.setString(2, email);

    ResultSet rs = check.executeQuery();

    if(rs.next())
    {
        out.println("<script>");
        out.println("alert('Username or Email already exists!');");
        out.println("location='register.html';");
        out.println("</script>");
    }
    else
    {
        String sql = "INSERT INTO users(fullname,email,phone,username,role,password) VALUES(?,?,?,?,?,?)";

        ps = con.prepareStatement(sql);

        ps.setString(1, fullname);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, username);
        ps.setString(5, role);
        ps.setString(6, password);

        int i = ps.executeUpdate();

        if(i > 0)
        {
            out.println("<script>");
            out.println("alert('Registration Successful');");
            out.println("location='register.html';");
            out.println("</script>");
        }
        else
        {
            out.println("<script>");
            out.println("alert('Registration Failed');");
            out.println("location='register.html';");
            out.println("</script>");
        }
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
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }
    catch(Exception ex){}
}
%>