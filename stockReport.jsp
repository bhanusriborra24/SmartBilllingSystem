<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Stock Report</title>

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
    height:100vh;
    overflow:hidden;
    position:relative;
}

.back-btn{
    position:absolute;
    top:20px;
    left:20px;
    background:darkgreen;
    color:white;
    text-decoration:none;
    padding:10px 20px;
    border-radius:5px;
    font-weight:bold;
}

.back-btn:hover{
    background:#006400;
}

.container{
    width:80%;
    height:90vh;
    margin:40px auto;
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 0 10px gray;
    overflow-y:auto;
}

h1{
    text-align:center;
    color:darkgreen;
    margin-bottom:20px;
}

table{
    width:100%;
    border-collapse:collapse;
}

th,
td{
    border:1px solid #ccc;
    padding:10px;
    text-align:center;
}

th{
    background:darkgreen;
    color:white;
    position:sticky;
    top:0;
}

</style>

</head>

<body>
<a href="report.jsp" class="back-btn">Back</a>
<br>
<div class="container">

<h1>Stock Report</h1>

<table>

<tr>
    <th>Product</th>
    <th>Quantity</th>
    <th>Status</th>
</tr>

<%
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

    String sql = "SELECT product_name, quantity FROM product ORDER BY product_name";

    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();

    while(rs.next()){

        int qty = rs.getInt("quantity");
        String status;

        if(qty == 0)
            status = "Out of Stock";
        else if(qty <= 10)
            status = "Low Stock";
        else
            status = "Available";
%>

<tr>
    <td><%= rs.getString("product_name") %></td>
    <td><%= qty %></td>
    <td><%= status %></td>
</tr>

<%
    }

}catch(Exception e){

    out.println("<tr><td colspan='3'>" + e.getMessage() + "</td></tr>");

}finally{

    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();

}
%>

</table>
</div>

</body>

</html>