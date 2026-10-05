<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

String message="";

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
""
);

// UPDATE

if(request.getMethod().equalsIgnoreCase("POST"))
{

int id=Integer.parseInt(request.getParameter("product_id"));

ps=con.prepareStatement("UPDATE product SET category_id=?,product_name=?,brand=?,weight=?,stock=?,expiry_date=? WHERE product_id=?");

ps.setInt(1,Integer.parseInt(request.getParameter("category_id")));
ps.setString(2,request.getParameter("product_name"));
ps.setString(3,request.getParameter("brand"));
ps.setString(4,request.getParameter("weight"));
ps.setInt(5,Integer.parseInt(request.getParameter("stock")));
ps.setString(6,request.getParameter("expiry_date"));
ps.setInt(7,id);

int i=ps.executeUpdate();

if(i>0)
{
response.sendRedirect("viewmanagerproduct.jsp");
return;
}
else
{
message="Update Failed";
}

}

int id=Integer.parseInt(request.getParameter("id"));

ps=con.prepareStatement("SELECT * FROM product WHERE product_id=?");
ps.setInt(1,id);

rs=ps.executeQuery();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Product</title>

<style>

body{

    background-image:url("img02.png");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    background-size:100% 100%;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    overflow: hidden;
}

.container{
width:700px;
margin:40px auto;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0 0 10px gray;
}

h2{
text-align:center;
color:darkgreen;
margin-bottom:20px;
}

label{
display:block;
margin-top:10px;
font-weight:bold;
}

input{
width:100%;
padding:10px;
margin-top:5px;
margin-bottom:15px;
}

button{
width:100%;
padding:12px;
background:darkgreen;
color:white;
border:none;
cursor:pointer;
font-size:16px;
}

a{
text-decoration:none;
background:#444;
color:white;
padding:10px 20px;
border-radius:5px;
}

.back-btn{
    position:absolute;
    top:20px;
    left:20px;
    background:darkgreen;
    color:white;
    text-decoration:none;
    padding:10px 20px;
    border-radius:6px;
    font-size:16px;
    font-weight:bold;
    transition:0.3s;
}

.back-btn:hover{
    background:#006400;
}

</style>

</head>

<body>
<a href="viewmanagerproduct.jsp" class="back-btn">Back</a>
<div class="container">

<h2>Edit Product</h2>

<%
if(!message.equals(""))
{
%>

<p style="color:green;text-align:center;"><%=message%></p>

<%
}

if(rs.next())
{
%>

<form method="post" action="editmanagerproduct.jsp">

<input type="hidden"
name="product_id"
value="<%=rs.getInt("product_id")%>">

<label>Category ID</label>

<input type="number"
name="category_id"
value="<%=rs.getInt("category_id")%>"
required>

<label>Product Name</label>

<input type="text"
name="product_name"
value="<%=rs.getString("product_name")%>"
required>

<label>Brand</label>

<input type="text"
name="brand"
value="<%=rs.getString("brand")%>"
required>

<label>Weight</label>

<input type="text"
name="weight"
value="<%=rs.getString("weight")%>"
required>

<label>Stock</label>

<input type="number"
name="stock"
value="<%=rs.getInt("stock")%>"
required>

<label>Expiry Date</label>

<input type="date"
name="expiry_date"
value="<%=rs.getDate("expiry_date")%>"
required>

<button type="submit">
Update Product
</button>

</form>

<%
}
%>

<br>

</div>

</body>

</html>

<%
if(rs!=null) rs.close();
if(ps!=null) ps.close();
if(con!=null) con.close();
%>