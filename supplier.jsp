<%@ page import="java.sql.*" %>

<%
String supplier_name = request.getParameter("supplier_name");
String company_name = request.getParameter("company_name");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String address = request.getParameter("address");

Connection con = null;
PreparedStatement ps = null;

try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/supermarketdb",
        "root",
        ""
    );

    String sql = "INSERT INTO supplier(supplier_name, company_name, phone, email, address) VALUES(?,?,?,?,?)";

    ps = con.prepareStatement(sql);

    ps.setString(1, supplier_name);
    ps.setString(2, company_name);
    ps.setString(3, phone);
    ps.setString(4, email);
    ps.setString(5, address);

    int i = ps.executeUpdate();

    if(i > 0)
    {
%>
        <script>
            alert("Supplier Added Successfully...");
            window.location="supplier.html";
        </script>
<%
    }
    else
    {
%>
        <script>
            alert("Supplier Not Added...");
            window.location="supplier.html";
        </script>
<%
    }

}
catch(Exception e)
{
    out.println("<h3>Error : " + e.getMessage() + "</h3>");
}
finally
{
    try
    {
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
    catch(Exception e){}
}
%>