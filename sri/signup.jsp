<%@ page import="java.sql.*" %>

<%
if(request.getMethod().equalsIgnoreCase("POST")){

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmpassword = request.getParameter("confirmpassword");
    String role = request.getParameter("role");
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String address = request.getParameter("address");
    String mobile = request.getParameter("mobile");
    String email = request.getParameter("email");
    String altemail = request.getParameter("altemail");
    String gender = request.getParameter("gender");
    String dob = request.getParameter("dob");

    String[] hobbyArray = request.getParameterValues("hobbies");
    String hobbies = "";

    if(hobbyArray != null){
        hobbies = String.join(", ", hobbyArray);
    }

    try{

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/logindb",
            "root",
            ""
        );

        PreparedStatement check = con.prepareStatement(
    "SELECT * FROM signup WHERE username=?"
);

check.setString(1, username);

ResultSet rs = check.executeQuery();

if(rs.next())
{
    out.println("<script>");
    out.println("alert('Username already exists!');");
    out.println("window.location='signup.jsp';");
    out.println("</script>");

    rs.close();
    check.close();
    con.close();
    return;
}

        PreparedStatement ps = con.prepareStatement(
        "INSERT INTO signup(username,password,confirmpassword,role,firstname,lastname,address,mobile,email,altemail,gender,hobbies,dob) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");

        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, confirmpassword);
        ps.setString(4, role);
        ps.setString(5, firstname);
        ps.setString(6, lastname);
        ps.setString(7, address);
        ps.setString(8, mobile);
        ps.setString(9, email);
        ps.setString(10, altemail);
        ps.setString(11, gender);
        ps.setString(12, hobbies);
        ps.setString(13, dob);

        int i = ps.executeUpdate();

if(i > 0){
    response.sendRedirect("signup.jsp");
}else{
    out.println("<h3>Registration Failed</h3>");
}

ps.close();
con.close();


    }catch(Exception e){

    }
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Successfully</title>

<style>
body{
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg,#C9D6FF,#E2E2E2);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container{
    background: linear-gradient(135deg,#FFD194,#FF6A88);
    padding: 30px;
    text-align: center;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
}

h2{
    color: green;
}

a{
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    background: #4CAF50;
    color: white;
    padding: 10px 20px;
    border-radius: 5px;
}

a:hover{
    background: #388E3C;
}
</style>

</head>
<body>

<div class="container">
    <h2>Registration Successfully!</h2>
    <p>Your account has been created successfully.</p>

    <a href="log.html">Go to Login</a>
</div>

</body>
</html>