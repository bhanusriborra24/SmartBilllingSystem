<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

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

    ps = con.prepareStatement("DELETE FROM product WHERE product_id=?");
    ps.setInt(1, Integer.parseInt(id));

    int i = ps.executeUpdate();

    if(i > 0)
    {
%>

<script>
alert("Product Deleted Successfully.");
location="viewproduct.jsp";
</script>

<%
    }
}
catch(Exception e)
{
%>

<script>
alert("This product cannot be deleted because it is already used in billing.");
location="viewproduct.jsp";
</script>

<%
}
finally
{
    try{
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }catch(Exception ex){}
}
%>