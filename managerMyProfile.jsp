<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");

if(username == null)
{
    response.sendRedirect("managerLogin.html");
    return;
}

String fullname="";
String email="";
String phone="";

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try
{
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

}
catch(Exception e)
{
    e.printStackTrace();
}
finally
{
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
<title>Manager My Profile</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    display:flex;
    background-image:url("img02.png");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    background-size:100% 100%;
    height:100vh;
    overflow-x: hidden;
    margin: 0;
}

.sidebar{
    width:250px;
    height:100vh;
    background:darkgreen;
    color:white;
    position:fixed;
}

.sidebar h2{
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
    background:#0b7d2a;
}

.main{
    margin-left:250px;
    width:100%;
}

.header{
    background:darkgreen;
    color:white;
    padding:20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.content{
    padding:50px;
}

.profile{
    width:600px;
    margin:auto;
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.2);
}

.profile h2{
    text-align:center;
    color:darkgreen;
    margin-bottom:25px;
}

.row{
    margin-bottom:30px;
}

.row label{
    display:block;
    font-weight:bold;
    margin-bottom:20px;
}

.row input{
    width:100%;
    padding:15px;
    border:1px solid #ccc;
    border-radius:6px;
    background:#f8f8f8;
    font-size:15px;
}

.btn{
    display:block;
    width:200px;
    margin:30px auto 0;
    text-align:center;
    text-decoration:none;
    background:darkgreen;
    color:white;
    padding:12px;
    border-radius:6px;
    font-weight:bold;
}

.btn:hover{
    background:#0b7d2a;
}


.btn-group{
    display:flex;
    justify-content:center;
    gap:20px;
    margin-top:25px;
}

.edit-btn,
.save-btn{
    width:130px;
    padding:12px;
    border:none;
    border-radius:6px;
    color:white;
    font-size:16px;
    cursor:pointer;
}

.edit-btn{
    background:#007bff;
}

.edit-btn:hover{
    background:#0056b3;
}

.save-btn{
    background:darkgreen;
}

.save-btn:hover{
    background:#006400;
}
</style>

</head>

<body>

<div class="sidebar">

<h2>Supermarket</h2>

<a href="managerDashboard.jsp">Dashboard</a>

<a href="managerMyProfile.jsp">My Profile</a>

</div>

<div class="main">

<div class="header">

<h2>Manager Profile</h2>

<div>
Welcome,
<b><%=username%></b>
</div>

</div>

<div class="content">

<div class="profile">

<h2>My Profile</h2>
<form action="updateManagerProfile.jsp" method="post">
<div class="row">
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
    <button type="button" class="edit-btn" onclick="enableEdit()">Edit</button>
    <button type="submit" class="save-btn">Save</button>
</div>
</form>
</div>

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
</html>