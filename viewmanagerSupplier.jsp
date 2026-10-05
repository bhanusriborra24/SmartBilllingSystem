<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
String username=(String)session.getAttribute("username");

if(username==null)
{
    response.sendRedirect("managerLogin.html");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>View Suppliers</title>

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
font-size:24px;
}

.container{
width:95%;
margin:30px auto;
}

table{
width:100%;
border-collapse:collapse;
background:white;
box-shadow:0 0 10px gray;
}

th{
background:darkgreen;
color:white;
padding:12px;
}

td{
padding:12px;
text-align:center;
border-bottom:1px solid #ddd;
}

tr:hover{
background:#f2f2f2;
}

.edit{
background:#007bff;
color:white;
padding:8px 15px;
text-decoration:none;
border-radius:5px;
}

.delete{
background:red;
color:white;
padding:8px 15px;
text-decoration:none;
border-radius:5px;
}

.top-bar{
    padding:15px 20px;
}

.back-btn{
    display:inline-block;
    background:darkgreen;
    color:white;
    text-decoration:none;
    padding:10px 25px;
    border-radius:6px;
    font-size:16px;
    font-weight:bold;
}

.back-btn:hover{
    background:green;
}

</style>

</head>

<body>

<div class="header">

Supplier Details

</div>
<div class="top-bar">
    <a href="managerDashboard.jsp" class="back-btn">Back</a>
</div>
<div class="container">

<table>

<tr>

<th>ID</th>
<th>Supplier Name</th>
<th>Company</th>
<th>Phone</th>
<th>Email</th>
<th>Address</th>
<th>Edit</th>
<th>Delete</th>

</tr>

<%

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

ps=con.prepareStatement("select * from supplier");

rs=ps.executeQuery();

while(rs.next())
{

%>

<tr>

<td><%=rs.getInt("supplier_id")%></td>

<td><%=rs.getString("supplier_name")%></td>

<td><%=rs.getString("company_name")%></td>

<td><%=rs.getString("phone")%></td>

<td><%=rs.getString("email")%></td>

<td><%=rs.getString("address")%></td>

<td>

<a class="edit"
href="editmanagerSupplier.jsp?id=<%=rs.getInt("supplier_id")%>">

Edit

</a>

</td>

<td>

<a class="delete"
href="deletemanagerSupplier.jsp?id=<%=rs.getInt("supplier_id")%>"
onclick="return confirm('Delete Supplier?')">

Delete

</a>

</td>

</tr>

<%

}

}
catch(Exception e)
{

out.println(e);

}

%>

</table>

</div>

</body>

</html>