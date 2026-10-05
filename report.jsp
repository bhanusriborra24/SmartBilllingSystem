<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
String type = request.getParameter("type");

if(type != null)
{
    if(type.equals("sales"))
    {
        response.sendRedirect("salesReport.jsp");
    }
    else if(type.equals("stock"))
    {
        response.sendRedirect("stockReport.jsp");
    }
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Supermarket Billing Reports</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{

    font-family:Arial, Helvetica, sans-serif;

    background:url("img02.png");

    background-size:cover;

    background-position:center;

    background-repeat:no-repeat;

    background-attachment:fixed;

    display:flex;

    justify-content:center;

    align-items:center;

    height:100vh;

}

.back-btn{
    position:absolute;
    top:20px;
    left:20px;
    background:green;
    color:white;
    text-decoration:none;
    padding:10px 18px;
    border-radius:6px;
    font-size:16px;
    font-weight:bold;
    transition:0.3s;
}

.back-btn:hover{
    background:#006400;
}

.container{

    width:500px;

    padding:40px;

    background:rgba(255,255,255,0.88);

    border-radius:15px;

    box-shadow:0 10px 25px rgba(0,0,0,0.3);

    text-align:center;

}

h1{

    color:#008000;

    margin-bottom:35px;

    font-size:36px;

}

label{

    font-size:20px;

    font-weight:bold;

}

select{

    width:260px;

    padding:10px;

    font-size:17px;

    margin-top:15px;

    border:2px solid green;

    border-radius:6px;

    outline:none;

}

button{

    margin-top:30px;

    width:200px;

    padding:12px;

    font-size:18px;

    background:green;

    color:white;

    border:none;

    border-radius:6px;

    cursor:pointer;

    transition:.3s;

}

button:hover{

    background:#006400;

    transform:scale(1.05);

}

</style>

</head>

<body>
<a href="adminDashboard.jsp" class="back-btn">Back</a>
<div class="container">

<h1>Supermarket Billing Reports</h1>

<form method="post">

<label>Select Report</label>

<br><br>

<select name="type">

    <option value="">-- Select Report --</option>

<option value="sales">Sales Report</option>

<option value="stock">Stock Report</option>

</select>

<br>

<button type="submit">View Report</button>

</form>

</div>

</body>

</html>
