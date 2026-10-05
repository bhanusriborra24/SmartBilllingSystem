<%@ page session="true" %>
<%@ page import="java.util.*" %>

<%

String product_id = request.getParameter("id");


ArrayList<HashMap<String,String>> cart =
(ArrayList<HashMap<String,String>>)session.getAttribute("cart");


if(cart != null && product_id != null)
{

    Iterator<HashMap<String,String>> iterator = cart.iterator();


    while(iterator.hasNext())
    {

        HashMap<String,String> item = iterator.next();


        if(item.get("id").equals(product_id))
        {
            iterator.remove();
            break;
        }

    }


    session.setAttribute("cart",cart);

}


response.sendRedirect("billing.jsp");


%>