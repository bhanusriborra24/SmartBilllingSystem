<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

String supplier_name="";
String company_name="";
String phone="";
String email="";
String address="";

try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/supermarketdb",
        "root",
        ""
    );

    ps = con.prepareStatement("SELECT * FROM supplier WHERE supplier_id=?");
    ps.setInt(1, Integer.parseInt(id));

    rs = ps.executeQuery();

    if(rs.next())
    {
        supplier_name = rs.getString("supplier_name");
        company_name = rs.getString("company_name");
        phone = rs.getString("phone");
        email = rs.getString("email");
        address = rs.getString("address");
    }

}
catch(Exception e)
{
    out.println(e);
}
finally
{
    try
    {
        if(rs!=null) rs.close();
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }
    catch(Exception e){}
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Edit Supplier</title>

<style>

body{
    background:#f4f6f9;
    font-family:Arial;
}

body{

    background-image:url("img02.png");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
    background-size:100% 100%;
    display:flex;
    justify-content:center;
    align-items:center;
    overflow: hidden;
    height:100vh;
}

.container{
    width:500px;
    margin:40px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px gray;
}

h2{
    text-align:center;
    color:darkgreen;
}

label{
    font-weight:bold;
}

input{
    width:100%;
    padding:10px;
    margin-top:5px;
    margin-bottom:15px;
    border:1px solid #ccc;
    border-radius:5px;
}

textarea{
    width:100%;
    padding:10px;
    margin-top:5px;
    margin-bottom:15px;
    border:1px solid #ccc;
    border-radius:5px;
}

button{
    width:100%;
    padding:12px;
    background:darkgreen;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
    font-size:16px;
}

button:hover{
    background:green;
}

.back-btn{
    position:fixed;
    top:20px;
    left:20px;

    background:darkgreen;
    color:white;
    text-decoration:none;

    padding:10px 25px;
    border-radius:6px;

    font-size:16px;
    font-weight:bold;

    border:2px solid darkgreen;
}

.back-btn:hover{
    background:green;
    border:2px solid green;
}

</style>

</head>

<body>

<div class="container">

<h2>Edit Supplier</h2>

<form action="updatemanagerSupplier.jsp" method="post">

<input type="hidden" name="supplier_id" value="<%=id%>">

<label>Supplier Name</label>
<input type="text" name="supplier_name" value="<%=supplier_name%>" required>

<label>Company Name</label>
<input type="text" name="company_name" value="<%=company_name%>" required>

<label>Phone</label>
<input type="text" name="phone" value="<%=phone%>" required>

<label>Email</label>
<input type="email" name="email" value="<%=email%>" required>

<label>Address</label>
<textarea name="address" rows="4"><%=address%></textarea>

<button type="submit">Update Supplier</button>

</form>
<a href="viewmanagerSupplier.jsp" class="back-btn">Back</a>
</div>

</body>
</html>
