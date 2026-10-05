

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<title>ADMIN</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial;
}

body{
    background-image:url("index1img.png");
    background-size:cover;
    background-position:left;
    background-repeat:no-repeat;
    background-size: 100% 100%;
    display:flex;
    justify-content:center;
    align-items:left;
    height:100vh;
}

.container{
    width:100%;
    height:100vh;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:flex-end;
    padding-right:300px;
    gap:30px;
}

.card{
    width:340px;
    height:220px;
    background:darkgreen;
    border-radius:15px;
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    box-shadow:0 5px 15px rgba(0,0,0,.3);
    cursor:pointer;
    transition:.3s;
}


.card:hover{
transform:scale(1.05);
background:darkolivegreen;
}

.card h2{
color:white;
font-size:28px;
}

.card i{
    font-size:60px;
    margin-bottom:20px;
}
</style>

</head>

<body>

<div class="header">

</div>

<div class="container">

<div class="card" onclick="location.href='adminLogin.html'">
<i class="fa-solid fa-user-shield"></i>
<h2>ADMIN</h2>

</div>

<div class="card" onclick="location.href='managerLogin.html'">
<i class="fa-solid fa-user-tie"></i>
<h2>MANAGER</h2>

</div>

<div class="card" onclick="location.href='employeeDashboard.jsp'">
<i class="fa-solid fa-user-group"></i>
<h2>EMPLOYEE</h2>

</div>

</div>

</body>
</html>