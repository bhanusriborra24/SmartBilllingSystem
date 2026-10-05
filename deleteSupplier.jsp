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

    String sql = "DELETE FROM supplier WHERE supplier_id=?";

    ps = con.prepareStatement(sql);

    ps.setInt(1, Integer.parseInt(id));

    int i = ps.executeUpdate();

    if(i > 0)
    {
        response.sendRedirect("viewSupplier.jsp");
    }
    else
    {
        out.println("<h3>Supplier Delete Failed!</h3>");
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
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }
    catch(Exception e){}
}
%>