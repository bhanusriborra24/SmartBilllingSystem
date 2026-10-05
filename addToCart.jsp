<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%

String product_id = request.getParameter("product_id");
String quantity = request.getParameter("quantity");


if(product_id == null || quantity == null)
{
    response.sendRedirect("billing.jsp");
    return;
}


ArrayList<HashMap<String,String>> cart =
(ArrayList<HashMap<String,String>>)session.getAttribute("cart");


if(cart == null)
{
    cart = new ArrayList<HashMap<String,String>>();
}


Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;


try
{

Class.forName("com.mysql.cj.jdbc.Driver");


con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/supermarketdb",
"root",
""
);



ps = con.prepareStatement(
"select product_name,price from product where product_id=?"
);


ps.setInt(1,Integer.parseInt(product_id));


rs = ps.executeQuery();



if(rs.next())
{

String name = rs.getString("product_name");

double price = rs.getDouble("price");


int qty = Integer.parseInt(quantity);


double total = price * qty;



HashMap<String,String> item =
new HashMap<String,String>();


item.put("id",product_id);

item.put("name",name);

item.put("qty",quantity);

item.put("price",
String.valueOf(price));


item.put("total",
String.valueOf(total));



cart.add(item);



session.setAttribute("cart",cart);


}



}

catch(Exception e)
{

out.println(e);

}


response.sendRedirect("billing.jsp");


%>