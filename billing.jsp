<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%

String username=(String)session.getAttribute("username");
Integer user_id=(Integer)session.getAttribute("id");


if(username==null)
{
    response.sendRedirect("employeeLogin.html");
    return;
}


ArrayList<HashMap<String,String>> cart =
(ArrayList<HashMap<String,String>>)session.getAttribute("cart");


double grandTotal=0;

%>


<!DOCTYPE html>
<html>

<head>

<title>Billing</title>

<style>

*{
    font-family:Arial,sans-serif;
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
    height:100vh;
    overflow: hidden;
}


.container{

width:90%;
margin:auto;
background:white;
padding:25px;
margin-top:30px;

}


h1{

text-align:center;
color:#2c3e50;

}


select,input{

padding:10px;
width:250px;
margin:10px;

}


button{

background:darkgreen;
color:white;
border:none;
padding:12px 20px;
cursor:pointer;

}

.back-btn{
    background:#006400;
    color:white;
    border:none;
    padding:10px 25px;
    font-size:16px;
    font-weight:bold;
    border-radius:5px;
    cursor:pointer;
}

.back-btn:hover{
    background:#008000;
}

table{

width:100%;
border-collapse:collapse;
margin-top:20px;

}


th{

background:darkgreen;
color:white;

}


td,th{

border:1px solid gray;
padding:10px;
text-align:center;

}


.total{

text-align:right;
font-size:22px;

}


</style>


</head>


<body>


<div class="container">
<div style="margin-bottom:20px;">

<button type="button" class="back-btn"
onclick="window.location.href='employeeDashboard.jsp'">
    Back
</button>

</div>

<h1>
Supermarket Billing
</h1>


<h3>
Employee : <%=username%>
</h3>


<hr>


<h3>Select Product</h3>


<form action="addToCart.jsp" method="post">


<select name="product_id">


<option>Select Product</option>


<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");


Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
""
);


PreparedStatement ps=
con.prepareStatement(
"select product_id,product_name,price from product"
);


ResultSet rs=ps.executeQuery();


while(rs.next())
{

%>


<option value="<%=rs.getInt("product_id")%>">

<%=rs.getString("product_name")%>
-
<%=rs.getDouble("price")%>

</option>


<%

}

}

catch(Exception e)
{

out.println(e);

}

%>


</select>


<br>


Quantity:

<input type="number" name="quantity" value="1">


<br>


<button type="submit">
Add To Cart
</button>


</form>



<hr>



<h3>Cart Items</h3>


<table>


<tr>

<th>Product</th>
<th>Quantity</th>
<th>Price</th>
<th>Total</th>
<th>Action</th>

</tr>


<%


if(cart!=null)
{


for(HashMap<String,String> item : cart)
{


double total =
Double.parseDouble(item.get("total"));


grandTotal += total;


%>


<tr>

<td>
<%=item.get("name")%>
</td>


<td>
<%=item.get("qty")%>
</td>


<td>
<%=item.get("price")%>
</td>


<td>
<%=item.get("total")%>
</td>


<td>

<a href="removeCart.jsp?id=<%=item.get("id")%>">

Remove

</a>

</td>


</tr>


<%

}

}


%>



</table>



<div class="total">


<b>
Grand Total : <%=grandTotal%>
</b>


</div>


<br>



<form action="generateBill.jsp" method="post">


<input type="hidden"
name="total_amount"
value="<%=grandTotal%>">


Payment Mode:


<select name="payment_mode">


<option>Cash</option>

<option>UPI</option>

<option>Card</option>


</select>


<br>


<button type="submit">

Generate Bill

</button>


</form>



</div>


</body>

</html>
