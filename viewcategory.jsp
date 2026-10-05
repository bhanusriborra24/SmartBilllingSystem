<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");

if(username == null)
{
    response.sendRedirect("adminLogin.html");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Categories</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
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


.container{
    width:90%;
    margin:20px auto;
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.2);
    display:flex;
    flex-direction:column;
    height:calc(100vh - 40px);
}

h2{
    text-align:center;
    color:darkgreen;
    margin-bottom:20px;
}

.top{
    display:flex;
    justify-content:space-between;
    margin-bottom:20px;
}

.top a{
    text-decoration:none;
    background:darkgreen;
    color:white;
    padding:10px 20px;
    border-radius:5px;
}

.table-container{
    flex:1;
    overflow-y:auto;
    overflow-x:auto;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:darkgreen;
    color:white;
        position:sticky;
    top:0;
    z-index:100;

}

th,td{
    border:1px solid #ddd;
    padding:12px;
    text-align:center;
}

tr:nth-child(even){
    background:#f2f2f2;
}

</style>

</head>

<body>

<div class="container">

<div class="top">

<h2>Category List</h2>
<a href="adminDashboard.jsp">Back</a>
</div>
<div class="table-container">
<table>

<tr>
<th>Category ID</th>
<th>Category Name</th>
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

ps=con.prepareStatement("SELECT * FROM category ORDER BY category_id");

rs=ps.executeQuery();

while(rs.next())
{
%>

<tr>

<td><%=rs.getInt("category_id")%></td>

<td><%=rs.getString("category_name")%></td>

</tr>

<%
}

}
catch(Exception e)
{
out.println("<tr><td colspan='2'>"+e.getMessage()+"</td></tr>");
}
finally{

try{
if(rs!=null) rs.close();
if(ps!=null) ps.close();
if(con!=null) con.close();
}catch(Exception e){}

}

%>

</table>
</div>
</div>

</body>
</html>