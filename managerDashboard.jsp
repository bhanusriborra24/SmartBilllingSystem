<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
String username = (String)session.getAttribute("username");

if(username == null)
{
    response.sendRedirect("managerLogin.html");
    return;
}
%>

<%
int totalEmployees = 0;
int totalProducts = 0;
double totalSales = 0;

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/supermarketdb",
        "root",
        ""
    );

    // Total Employees
    ps = con.prepareStatement("SELECT COUNT(*) FROM users WHERE role='Employee'");
    rs = ps.executeQuery();

    if(rs.next()){
        totalEmployees = rs.getInt(1);
    }

    rs.close();
    ps.close();

    // Total Products
    ps = con.prepareStatement("SELECT COUNT(*) FROM product");
    rs = ps.executeQuery();

    if(rs.next()){
        totalProducts = rs.getInt(1);
    }

    rs.close();
    ps.close();

    // Total Sales
    ps = con.prepareStatement("SELECT IFNULL(SUM(total_amount),0) FROM bill");

    rs = ps.executeQuery();

    if(rs.next()){
        totalSales = rs.getDouble(1);
    }

    if(rs!=null)
    rs.close();

    if(ps!=null)
    ps.close();

}

catch(Exception e){
    e.printStackTrace();
}
if(con!=null)
{
    con.close();
}

%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    display:flex;
    background-image:url("image1.png");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    min-height:100vh;
    overflow-x:hidden;
}

.sidebar{
    width:250px;
    height:100vh;
    background:darkgreen;
    color:white;
    position:fixed;
    left:0;
    top:0;
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
    background:green;
}

.main{
    margin-left:250px;
    width:calc(100% - 250px);
    min-height:100vh;
}

.header{
    background:darkgreen;
    color:white;
    height:70px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:0 30px;
}

.header h2{
    font-size:28px;
}

.header h3{
    font-size:20px;
}

.content{
    padding:30px;
    width:100%;
}

.cards{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:30px;
    width:100%;
}

.card{
    background:white;
    border-radius:12px;
    padding:30px;
    text-align:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
    min-height:180px;
    width:100%;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

.card h3{
    color:darkgreen;
    margin-bottom:10px;
}

.card h1{
    font-size:32px;
    color:#333;
}

.card p{
    color:#555;
    margin-bottom:10px;
}

.card a{
    text-decoration:none;
    color:white;
    background:darkgreen;
    padding:8px 15px;
    border-radius:5px;
    display:inline-block;
    margin-top:10px;
}

.card a:hover{
    background:green;
}

.notifyBtn{
    background:white;
    color:darkgreen;
    border:none;
    padding:8px 15px;
    border-radius:5px;
    cursor:pointer;
    font-weight:bold;
}

.notificationBox{
    display:none;
    position:absolute;
    top:45px;
    right:0;
    width:320px;
    background:white;
    color:black;
    border-radius:8px;
    box-shadow:0 4px 12px rgba(0,0,0,0.3);
    padding:15px;
    z-index:999;
    max-height:300px;
    overflow-y:auto;
}

.notificationBox h3{
    color:darkgreen;
    margin-bottom:10px;
}

.notificationBox p{
    padding:8px;
    border-bottom:1px solid #ddd;
}

.notification-area{
    position:relative;
}

.back-btn{
    background:white;
    color:darkgreen;
    padding:8px 18px;
    border-radius:5px;
    text-decoration:none;
    font-size:15px;
    font-weight:bold;
}

.back-btn:hover{
    background:#eee;
}

.logout{
    background:red;
}

.logout:hover{
    background:darkred;
}

.btn{
    display:block;
    width:100%;
    background:darkgreen;
    color:white;
    padding:15px;
    text-decoration:none;
    border-radius:5px;
    font-size:18px;
    margin-bottom:20px;
}

.btn:hover{
    background:green;
}

@media(max-width:1000px){

    .cards{
        grid-template-columns:repeat(2,1fr);
    }

}

@media(max-width:700px){

    .sidebar{
        width:200px;
    }

    .main{
        margin-left:200px;
        width:calc(100% - 200px);
    }

    .cards{
        grid-template-columns:1fr;
    }

}

</style>

<script>

function toggleNotification()
{
    var box=document.getElementById("notificationBox");

    if(box.style.display=="block")
        box.style.display="none";
    else
        box.style.display="block";
}

</script>

</head>

<body>
    
<div class="sidebar">

<h2>Billing System</h2>

<a href="managerDashboard.jsp"> Dashboard</a>

<a href="managerMyProfile.jsp">My Profile</a>

<a href="managerLogout.jsp"> Logout</a>

</div>
<div class="main">

<div class="header">

<a href="managerLogin.html" class="back-btn">Back</a>
<div class="header">

</div>

<div style="display:flex;align-items:center;gap:20px;">

<div style="position:relative;">

 <%
int notificationCount = 0;

Class.forName("com.mysql.cj.jdbc.Driver");
Connection countCon = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
"");

PreparedStatement cps;
ResultSet crs;

cps = countCon.prepareStatement(
"SELECT COUNT(*) FROM product WHERE stock < 10");
crs = cps.executeQuery();

if(crs.next())
    notificationCount += crs.getInt(1);

crs.close();
cps.close();

cps = countCon.prepareStatement(
"SELECT COUNT(*) FROM product WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(),INTERVAL 7 DAY)");
crs = cps.executeQuery();

if(crs.next())
    notificationCount += crs.getInt(1);

crs.close();
cps.close();
countCon.close();
%>

<button onclick="toggleNotification()" class="notifyBtn">
&#128276; Notifications (<%=notificationCount%>)
</button>

<div id="notificationBox" class="notificationBox">

<h3>Notifications</h3>
<%
Connection notifyCon=null;
PreparedStatement psNotify=null;
ResultSet rsNotify=null;
boolean hasNotification=false;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

notifyCon=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
"");

psNotify=notifyCon.prepareStatement(
"SELECT product_name,stock FROM product WHERE stock<10");

rsNotify=psNotify.executeQuery();

while(rsNotify.next())
{
    hasNotification=true;
    notificationCount++;
%>

<p>
     <b><%=rsNotify.getString("product_name")%></b>
stock is low. Remaining Stock :
<b><%=rsNotify.getInt("stock")%></b>
</p>
<%
}

rsNotify.close();
psNotify.close();


// Expiry Products

psNotify=notifyCon.prepareStatement(
"SELECT product_name,expiry_date FROM product WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(),INTERVAL 7 DAY)");
rsNotify=psNotify.executeQuery();

while(rsNotify.next())
{
hasNotification=true;
notificationCount++;
%>

<p>
<b><%=rsNotify.getString("product_name")%></b>
expires on
<b><%=rsNotify.getDate("expiry_date")%></b>
</p>
<%
}

rsNotify.close();
psNotify.close();


if(!hasNotification)
{
%>

<p>No New Notifications</p>

<%
}
%>

<%

if(notifyCon!=null) notifyCon.close();

}catch(Exception e){
    out.println(e);
}
%>
</div>

</div>

<div>
Welcome,
<b><%=username%></b>
</div>

</div>

</div>

<div class="content">
<center>
<h2>Dashboard Overview</h2>
<br>
<br>

<div class="cards">

<div class="card summary">
    <h3>Total Employees</h3>
    <h1><%= totalEmployees %></h1>
</div>

<div class="card summary">
    <h3>Total Sales</h3>
    <h1><%= totalSales %></h1>
</div>
</div>

<br><br>

<h2>Management Modules</h2>

<br><br>

<div class="cards">



<div class="card">
<h3> Categories</h3>
<p>Manage Categories</p>
<a href="viewmanagercategory.jsp">Open</a>
</div>

<div class="card">
<h3> Products</h3>
<p>Manage Products</p>
<a href="viewmanagerproduct.jsp">Open</a>
</div>

<div class="card">
<h3> Suppliers</h3>
<p>Manage Suppliers</p>
<a href="viewmanagerSupplier.jsp">Open</a>
</div>

<div class="card">
<h3> Employees</h3>
<p>Manage Employees</p>
<a href="employeemanagerList.jsp">Open</a>
</div>


<div class="card">
<h3> Reports</h3>
<p>View Sales Reports</p>
<a href="reportmanager.jsp">Open</a>
</div>

</div>

</div>
</center>
</div>
</body>
</html> 