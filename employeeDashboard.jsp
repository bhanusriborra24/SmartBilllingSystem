<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");

if(username == null)
{
    response.sendRedirect("employeeLogin.html");
    return;
}
%>

<%
int totalProducts = 0;
int totalBills = 0;
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

    // Total Products
    ps = con.prepareStatement("SELECT COUNT(*) FROM product");
    rs = ps.executeQuery();

    if(rs.next()){
        totalProducts = rs.getInt(1);
    }

    rs.close();
    ps.close();

    // Today's Bills
    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM bill WHERE DATE(bill_date)=CURDATE()"
    );
    rs = ps.executeQuery();

    if(rs.next()){
        totalBills = rs.getInt(1);
    }

    rs.close();
    ps.close();

    // Today's Sales
    ps = con.prepareStatement(
        "SELECT IFNULL(SUM(total_amount),0) FROM bill WHERE DATE(bill_date)=CURDATE()"
    );
    rs = ps.executeQuery();

    if(rs.next()){
        totalSales = rs.getDouble(1);
    }

}
catch(Exception e){
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
<title>Employee Dashboard</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
    font: size 17px;;
}


body{
    display:flex;
    background-image:url("image1.png");
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
    left: 0;
    top: 0;
}

.sidebar h2{
    text-align:center;
    padding:20px;
    border-bottom:1px solid gray;
}

.sidebar a{
    display:block;
    color:white;
    text-decoration:none;
    padding:15px 20px;
    font-size: 17px;
}

.sidebar a:hover{
    background:darkgreen;
}

.main{
    margin-left:240px;
    width:100%;
}

.dashboard-cards{
    width:700px;
    margin:50px auto;
    display:grid;
    grid-template-columns:repeat(2,300px);
    justify-content:center;
    gap:30px;
}

.card{
    width:300px;
    height:180px;
    background:#fff;
    border-radius:15px;
    text-align:center;
    text-decoration:none;
    color:#222;
    padding:25px;
    box-shadow:0 4px 12px rgba(0,0,0,.15);
    transition:.3s;
}

.card:hover{
    transform:translateY(-6px);
    box-shadow:0 8px 18px rgba(0,0,0,.2);
}



.icon{
    font-size:45px;
    margin-bottom:15px;
}

.card h3{
    color:#006400;
    margin-bottom:10px;
    font-size:28px;
}

.card p{
    font-size:18px;
    color:#555;
}

/* Sales card center */

.sales-card{
    grid-column:1 / 3;
    justify-self:center;
    width: 300px;
}


@media(max-width:768px){

.dashboard-cards{
    grid-template-columns:1fr;
}
}

.header{
    background:darkgreen;
    color:white;
    padding:20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

/* Statistics Section */

.stats{
    display:flex;
    justify-content:space-evenly;
    gap:25px;
    padding:30px;
}

.stat-box{
    width:280px;
    height:120px;
    background:white;
    border-left:6px solid darkgreen;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
    text-align:center;
    padding:20px;
    transition:.3s;
}

.stat-box:hover{
    transform:translateY(-5px);
    box-shadow:0 8px 18px rgba(0,0,0,0.2);
}

.stat-box h4{
    color:#555;
    font-size:18px;
    margin-bottom:12px;
}

.stat-box span{
    font-size:32px;
    color:darkgreen;
    font-weight:bold;
}

.content{
    padding:30px;
}



.logout{
    color:white;
    text-decoration:none;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="sidebar">

<h2> Supermarket</h2>

<a href="employeeDashboard.jsp">Dashboard</a>

<a href="employeeMyProfile.jsp"> My Profile</a>

<a href="employeeLogout.jsp"> Logout</a>

</div>

<div class="main">

<div class="header">
    <h2>Employee Dashboard</h2>

        <div>
            Welcome,
            <b><%= username %></b>
        </div>
    </div>
<br><br>
    <div class="stats">

    <div class="stat-box">
        <h4>Today's Bills</h4>
        <span><%= totalBills %></span>
    </div>

    <div class="stat-box">
        <h4>Today's Sales</h4>
        <span><%= totalSales %></span>
    </div>

</div>
<br><br><br>
<div class="dashboard-cards">

    <a href="employeeviewproduct.jsp" class="card">
        <div class="icon"></div>
        <h3>Products</h3>
        <p>View Available Products</p>
    </a>

    <a href="billing.jsp" class="card">
        <div class="icon"></div>
        <h3>Billing</h3>
        <p>Create Customer Bills</p>
    </a>

</div>


</div>

</body>
</html>
