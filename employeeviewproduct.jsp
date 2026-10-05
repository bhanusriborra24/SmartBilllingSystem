<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Products</title>

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
    justify-content:center;
    align-items:center;
    height:100vh;
    overflow: hidden;
}

.header{
    background:darkgreen;
    color:white;
    padding:20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}



.container{
    width:95%;
     margin:20px auto;
    height:calc(100vh - 110px);
    height: 80vh;
}

h2{
    color:darkgreen;
    margin-bottom:20px;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 2px 10px rgba(0,0,0,.2);
}

.table-container{
    height:100%;
    overflow-y:auto;
    overflow-x:auto;
    background:white;
    box-shadow:0 2px 10px rgba(0,0,0,.2);
}

th{
    position:sticky;
    top:0;
    background:darkgreen;
    color:white;
    padding:12px;
    z-index:100;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

tr:hover{
    background:#f1f1f1;
}

.back{
    display:inline-block;
    margin-top:20px;
    background:darkgreen;
    color:white;
    padding:10px 20px;
    text-decoration:none;
    border-radius:5px;
}

</style>

</head>

<body>

<div class="header">

<h3>View Products</h3>

<div>
Welcome, <b><%=username%></b><br>
</div>

</div>


<a class="back" href="employeeDashboard.jsp">Back to Dashboard</a>
<div class="container">

<div class="table-container">

<table>

<tr>

<th>ID</th>

<th>Category ID</th>

<th>Product Name</th>

<th>Brand</th>

<th>Weight</th>

<th>Price</th>

<th>Stock</th>

<th>Expiry Date</th>

</tr>

<%

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

ps=con.prepareStatement("SELECT * FROM product");

rs=ps.executeQuery();

while(rs.next())
{

%>

<tr>

<td><%=rs.getInt("product_id")%></td>

<td><%=rs.getInt("category_id")%></td>

<td><%=rs.getString("product_name")%></td>

<td><%=rs.getString("brand")%></td>

<td><%=rs.getString("weight")%></td>

<td> <%=rs.getDouble("price")%></td>

<td><%=rs.getInt("stock")%></td>

<td><%=rs.getDate("expiry_date")%></td>

</tr>

<%
}

}catch(Exception e){

out.println(e);

}finally{

try{

if(rs!=null) rs.close();
if(ps!=null) ps.close();
if(con!=null) con.close();

}catch(Exception ex){}

}

%>

</table>
</div>

<br>

</div>

</body>
</html>