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

<title>Employees</title>

<style>

body{
    margin:0;
    font-family:Arial;
    background:#f4f6f9;
}

.container{
    padding:30px;
}

.delete-btn{
    background:red;
    color:white;
    padding:8px 15px;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
}

.delete-btn:hover{
    background:darkred;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
}

.header{
    background:darkgreen;
    color:white;
    padding:20px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 2px 8px rgba(0,0,0,0.2);
}

.header h2{
    margin:0;
    font-size:28px;
}

.header div{
    font-size:18px;
    font-weight:bold;
}

th,td{
    padding:15px;
    border:1px solid #ddd;
    text-align:center;
}

th{
    background:darkgreen;
    color:white;
}

tr:nth-child(even){
    background:#f9f9f9;
}

.back{
    display:inline-block;
    margin-bottom:20px;
    background:darkgreen;
    color:white;
    padding:15px 40px;
    text-decoration:none;
    border-radius:5px;
}

.add-btn{
    background:darkgreen;
    color:white;
    padding:8px 15px;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="header">

<h2>Employee Details</h2>

<div>
Welcome <b><%=username%></b>
</div>

</div>

<div class="container">

<a href="managerDashboard.jsp" class="back">Back</a>

<table>

<tr>

<th>ID</th>
<th>Full Name</th>
<th>Email</th>
<th>Phone</th>
<th>Username</th>
<th>Delete</th>

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

ps=con.prepareStatement(
"SELECT id,fullname,email,phone,username FROM users WHERE role='Employee'"
);

rs=ps.executeQuery();

while(rs.next())
{
%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("fullname")%></td>

<td><%=rs.getString("email")%></td>

<td><%=rs.getString("phone")%></td>

<td><%=rs.getString("username")%></td>



<td>
<a href="deletemanagerEmployee.jsp?id=<%=rs.getInt("id")%>"
class="delete-btn"
onclick="return confirm('Are you sure you want to delete this employee?');">
Delete
</a>
</td>

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

}catch(Exception e){}

}

%>

</table>

</div>
<div class="container">
        <center>
    <a href="addmanagerEmployee.jsp" class="add-btn">Add Employee</a>
    </center>
</div>
</body>

</html>