<%@ page import="java.sql.*" %>

<%
String msg = "";

if("POST".equalsIgnoreCase(request.getMethod()))
{
    String fullname = request.getParameter("fullname");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String username = request.getParameter("username");
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

        ps = con.prepareStatement(
            "INSERT INTO users(fullname,email,phone,username,password,role) VALUES(?,?,?,?,?,'Employee')"
        );

        ps.setString(1, fullname);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, username);
        ps.setString(5, password);

        int i = ps.executeUpdate();

        if(i > 0)
        {
            response.sendRedirect("employeemanagerList.jsp");
            return;
        }
        else
        {
            msg = "Employee Not Added!";
        }

    }
    catch(Exception e)
    {
        msg = e.getMessage();
    }
    finally
    {
        try
        {
            if(ps!=null) ps.close();
            if(con!=null) con.close();
        }
        catch(Exception e){}
    }
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Add Employee</title>

<style>

body{
    margin:0;
    font-family:Arial, Helvetica, sans-serif;
    background-image:url("img02.png");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    height: 100vh;
    display: flex;
}

.header{
    width:100%;
    height:70px;
    background:darkgreen;
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    position:fixed;
    top:0;
    left:0;
    box-shadow:0 2px 8px rgba(0,0,0,0.3);
    z-index:1000;
}

.header h2{
    margin:0;
    font-size:28px;
}

.container{
    width:450px;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 15px rgba(0,0,0,0.3);

    position:absolute;
    top:50%;
    left:50%;
    transform:translate(-50%,-50%);
}

input{
    width:100%;
    padding:10px;
    margin:10px 0;
    border:1px solid #ccc;
    border-radius:5px;
}

button{
    width:100%;
    padding:12px;
    background:darkgreen;
    color:white;
    border:none;
    border-radius:5px;
    font-size:16px;
    cursor:pointer;
}

.back{
    text-decoration:none;
    background:white;
    color:darkgreen;
    padding:8px 18px;
    border-radius:5px;
    font-weight:bold;
}

.back:hover{
    background:#f2f2f2;
}

.msg{
    color:red;
    text-align:center;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="header">
<h2>Add Employee</h2>
</div>
<div class="container">

<form method="post">
<label>Employee Name</label>
<input type="text" name="fullname" placeholder="Full Name" required>
<label>Email</label>
<input type="email" name="email" placeholder="Email" required>
<label>Phone Number</label>
<input type="tel" name="phone" placeholder="Phone Number" maxlength="10" minlength="10" required>
<label>Usrename</label>
<input type="text" name="username" placeholder="Username" required>
<label>Password</label>
<input type="password" name="password" placeholder="Password" required>

<button type="submit">Add Employee</button>

</form>

<div class="msg">
<%=msg%>
</div>

</div>
<center>
        <a href="employeemanagerList.jsp" class="back">Back</a>
</center>
</body>
</html>