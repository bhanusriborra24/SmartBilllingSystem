<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%

Integer user_id = (Integer)session.getAttribute("id");

String total_amount = request.getParameter("total_amount");
String payment_mode = request.getParameter("payment_mode");


if(user_id == null)
{
    response.sendRedirect("employeeLogin.html");
    return;
}


ArrayList<HashMap<String,String>> cart =
(ArrayList<HashMap<String,String>>)session.getAttribute("cart");


if(cart == null || cart.size()==0)
{
    out.println("Cart is empty");
    return;
}



Connection con=null;

PreparedStatement ps=null;

ResultSet rs=null;



try
{

Class.forName("com.mysql.cj.jdbc.Driver");


con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
""
);


// Start transaction

con.setAutoCommit(false);



// 1. Insert into bill table


ps = con.prepareStatement("INSERT INTO bill(user_id,bill_date,total_amount,payment_mode) VALUES(?,CURDATE(),?,?)",Statement.RETURN_GENERATED_KEYS);


ps.setInt(1,user_id);

ps.setDouble(2,Double.parseDouble(total_amount));

ps.setString(3,payment_mode);


ps.executeUpdate();



rs = ps.getGeneratedKeys();


int bill_id=0;


if(rs.next())
{
    bill_id = rs.getInt(1);
}



// 2. Insert bill items


for(HashMap<String,String> item : cart)
{


int product_id =
Integer.parseInt(item.get("id"));


int quantity =
Integer.parseInt(item.get("qty"));


double price =
Double.parseDouble(item.get("price"));


double total =
Double.parseDouble(item.get("total"));



// insert bill_items

ps = con.prepareStatement("INSERT INTO bill_items(bill_id,product_id,quantity,price,total) VALUES(?,?,?,?,?)");


ps.setInt(1,bill_id);

ps.setInt(2,product_id);

ps.setInt(3,quantity);

ps.setDouble(4,price);

ps.setDouble(5,total);


ps.executeUpdate();




// 3. Update stock


ps = con.prepareStatement("UPDATE product SET stock = stock - ? WHERE product_id = ?");

ps.setInt(1, quantity);
ps.setInt(2, product_id);

ps.executeUpdate();



}



// commit

con.commit();



// clear cart

session.removeAttribute("cart");



%>
<!DOCTYPE html>
<html>
<head>
<title>Supermarket Bill</title>

<style>

body{
    background:#f2f2f2;
    font-family:Courier New, monospace;
}

.bill{
    width:420px;
    margin:30px auto;
    background:#fff;
    border:1px solid #000;
    padding:20px;
}

.center{
    text-align:center;
}

table{
    width:100%;
    border-collapse:collapse;
    margin-top:10px;
}

th,td{
    padding:5px;
    text-align:left;
}

.right{
    text-align:right;
}

.line{
    border-top:1px dashed black;
    margin:8px 0;
}

button{
    margin-top:20px;
    padding:10px 20px;
    background:green;
    color:white;
    border:none;
    cursor:pointer;
}

.back-btn{
    background:#006400;
    color:white;
    border:none;
    padding:10px 20px;
    border-radius:5px;
    cursor:pointer;
    font-size:15px;
    font-weight:bold;
    margin-bottom:15px;
}

.back-btn:hover{
    background:#008000;
}

</style>

<script>
function printBill(){
    window.print();
}
</script>

</head>

<body>
<div class="top-back">
    <button type="button" onclick="window.location.href='billing.jsp'">
        Back
    </button>
</div>
<div class="bill">

<div class="center">
<h2>SUPERMARKET BILL</h2>
</div>

<div class="line"></div>

<p><b>Bill No :</b> <%=bill_id%></p>
<p><b>Date :</b> <%=new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new java.util.Date())%></p>
<p><b>Employee :</b> <%=session.getAttribute("username")%></p>
<p><b>Payment :</b> <%=payment_mode%></p>

<div class="line"></div>

<table>

<tr>
<th>Product</th>
<th>Qty</th>
<th>Price</th>
<th>Total</th>
</tr>

<%
for(HashMap<String,String> item : cart)
{
%>

<tr>
<td><%=item.get("name")%></td>
<td><%=item.get("qty")%></td>
<td><%=item.get("price")%></td>
<td><%=item.get("total")%></td>
</tr>

<%
}
%>

</table>

<div class="line"></div>

<h3 class="right">
Grand Total : <%=total_amount%>
</h3>

<div class="line"></div>

<div class="center">
<b>Thank You! Visit Again</b>
</div>

<div class="center">
<button onclick="printBill()">Print Bill</button>
<a href="billing.jsp">
<button>New Bill</button>
</a>
</div>

</div>

</body>

</html>


<%

}

catch(Exception e)
{

try
{
con.rollback();
}
catch(Exception ex){}


out.println(e);

}


%>