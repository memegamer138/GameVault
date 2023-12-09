<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<style>

	body {
		font-family: Arial, sans-serif;
		background-color: black; /* Changed background color to black */
		color: white; /* Changed text color to white */
	}
	h1 {
		color: #333;
		text-align: center;
	}
	table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 20px;
	}
	th, td {
		padding: 10px;
		text-align: left;
		border-bottom: 1px solid #ddd;
	}
	th {
		background-color: #f2f2f2;
	}

	.total {
		text-align: right;
		font-weight: bold;
	}
	.checkout-link {
		display: block;
		text-align: center;
		margin-top: 20px;
	}
	.continue-shopping-link {
		display: block;
		text-align: center;
		color: #0066cc;
		margin-top: 20px;
	}
</style>
</head>
<body>
<%@ include file="header.jsp"%>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{   out.println("<h1>Your shopping cart is empty!</h1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th style=\"background-color: black; color: white;\">Product Id</th><th style=\"background-color: black; color: white;\">Product Name</th><th style=\"background-color: black; color: white;\">Quantity</th>");
	out.println("<th style=\"background-color: black; color: white;\">Price</th><th  style=\"background-color: black; color: white\">Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{   Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}       

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" class=\"total\">Order Total</td>"
			+"<td class=\"total\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<a href=\"checkout.jsp\" class=\"checkout-link\">Check Out</a>");
}
%>
<a href="listprod.jsp" class="continue-shopping-link">Continue Shopping</a>
</body>
</html>
