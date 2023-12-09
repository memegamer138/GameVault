<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>GameVault Order List</title>
<style>
table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  text-align: left;
  padding: 8px;
}

th {
  background-color: #f2f2f2;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

.order-separator {
  border-top: 4px solid black; 
}
</style>
</head>
<body>

<h1>Order List</h1>

<%
String sql = "SELECT orderId, O.CustomerId, totalAmount, firstName+' '+lastName, orderDate FROM OrderSummary O, Customer C WHERE "
		+ "O.customerId = C.customerId";

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try  
{	
	getConnection();
    Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	ResultSet rst = stmt.executeQuery(sql);		

	
	// Use a PreparedStatement as will execute many times
	sql = "SELECT productId, quantity, price FROM OrderProduct WHERE orderId=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	while (rst.next())
	{	int orderId = rst.getInt(1);
		out.print("<table><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
		out.print("<tr><td>"+orderId+"</td>");
		out.print("<td>"+rst.getString(5)+"</td>");
		out.print("<td>"+rst.getInt(2)+"</td>");		
		out.print("<td>"+rst.getString(4)+"</td>");
		out.print("<td>"+currFormat.format(rst.getDouble(3))+"</td>");
		out.println("</tr>");

		// Retrieve all the items for an order
		pstmt.setInt(1, orderId);				
		ResultSet rst2 = pstmt.executeQuery();
		
		out.println("<tr><td colspan=\"5\"><table>");
		out.println("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		while (rst2.next())
		{
			out.print("<tr><td>"+rst2.getInt(1)+"</td>");
			out.print("<td>"+rst2.getInt(2)+"</td>");
			out.println("<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		}
		out.println("</table></td></tr>");
		out.println("<tr class=\"order-separator\"><td colspan=\"5\"></td></tr>"); // Add black line between orders
	}
	out.println("</table>");
	out.println("<center><h1><p><a href=\"index.jsp\">Return to Home Page</a></p></h1><center>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{
	closeConnection();
}
%>
</body>
</html>