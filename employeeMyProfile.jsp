<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
String username=(String)session.getAttribute("username");

if(username==null)
{
    response.sendRedirect("employeeLogin.html");
    return;
}

String fullname="";
String email="";
String phone="";

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/supermarketdb",
        "root",
        ""
    );

    ps=con.prepareStatement("SELECT * FROM users WHERE username=?");
    ps.setString(1,username);

    rs=ps.executeQuery();

    if(rs.next())
    {
        fullname=rs.getString("fullname");
        email=rs.getString("email");
        phone=rs.getString("phone");
    }

}catch(Exception e){
    e.printStackTrace();
}
finally{

    try{
        if(rs!=null) rs.close();
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }catch(Exception e){}
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Employee My Profile</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{

    background-image:url("img02.png");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    background-size:100% 100%;
    overflow: hidden;
    justify-content:center;
    align-items:center;
    height:100vh;
}

/* Sidebar */

.sidebar{
    width:240px;
    height:100vh;
    background:darkgreen;
    position:fixed;
}

.sidebar h2{
    color:white;
    text-align:center;
    padding:20px;
    border-bottom:1px solid #555;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:15px 20px;
    font-size:17px;
}

.sidebar a:hover{
    background:#006400;
}
.header{
    background:darkgreen;
    color:white;
    margin-left:240px;
    padding:30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.profile-box{

    width:600px;
    margin:40px auto;
    background:white;
    padding:35px;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,.2);

}

.profile-box h2{

    text-align:center;
    color:darkgreen;
    margin-bottom:30px;

}

.form-group{

    margin-bottom:20px;

}

.form-group label{

    display:block;
    margin-bottom:8px;
    font-weight:bold;

}

.form-group input{

    width:100%;
    padding:12px;
    border:1px solid #ccc;
    border-radius:6px;
    background:#f8f8f8;
    font-size:16px;

}

.back-btn{

    display:block;
    width:180px;
    margin:25px auto 0;
    text-align:center;
    background:darkgreen;
    color:white;
    padding:12px;
    text-decoration:none;
    border-radius:6px;

}

.back-btn:hover{

    background:#006400;

}

.btn-group{
    display:flex;
    justify-content:center;
    gap:20px;
    margin-top:20px;
}

.btn-group button{
    padding:10px 30px;
    border:none;
    border-radius:5px;
    font-size:16px;
    color:white;
    cursor:pointer;
}

.btn-group button:first-child{
    background:#007bff;
}

.btn-group button:last-child{
    background:darkgreen;
}

</style>

</head>

<body>

<div class="sidebar">

<h2>Supermarket</h2>

<a href="employeeDashboard.jsp">Dashboard</a>

<a href="employeeMyProfile.jsp">My Profile</a>

<a href="employeeLogout.jsp">Logout</a>

</div>

<div class="header">

    <h2>Employee Dashboard</h2>
        <div>
            Welcome,
            <b><%= username %></b>
        </div>
    </div>
<div class="profile-box">

<h2>My Profile</h2>

<form action="updateEmployeeProfile.jsp" method="post">

<div class="form-group">
<label>Full Name</label>
<input type="text" id="fullname" name="fullname" value="<%=fullname%>" readonly>
</div>

<div class="form-group">
<label>Email</label>
<input type="email" id="email" name="email" value="<%=email%>" readonly>
</div>

<div class="form-group">
<label>Phone Number</label>
<input type="text" id="phone" name="phone" value="<%=phone%>" readonly>
</div>

<div class="form-group">
<label>Username</label>
<input type="text" id="username" name="newUsername" value="<%=username%>" readonly>
</div>

<div class="btn-group">
    <button type="button" onclick="enableEdit()">Edit</button>
    <button type="submit">Save</button>
</div>

</form>

</div>

</div>
<script>
function enableEdit()
{
    document.getElementById("fullname").readOnly = false;
    document.getElementById("email").readOnly = false;
    document.getElementById("phone").readOnly = false;
    document.getElementById("username").readOnly = false;
    document.getElementById("fullname").focus();
}
</script>
</body>
</html