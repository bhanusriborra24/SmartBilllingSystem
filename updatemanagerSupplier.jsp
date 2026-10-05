<%@ page import="java.sql.*" %>

<%
String supplier_id = request.getParameter("supplier_id");
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

    String sql = "UPDATE supplier SET supplier_name=?, company_name=?, phone=?, email=?, address=? WHERE supplier_id=?";

    ps = con.prepareStatement(sql);

    ps.setString(1, supplier_name);
    ps.setString(2, company_name);
    ps.setString(3, phone);
    ps.setString(4, email);
    ps.setString(5, address);
    ps.setInt(6, Integer.parseInt(supplier_id));

    int i = ps.executeUpdate();

    if(i > 0)
    {
        response.sendRedirect("viewmanagerSupplier.jsp");
    }
    else
    {
        out.println("Update Failed");
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