<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map,java.math.BigDecimal" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>GameVault Order Processing</title>
<style>
	body {
		background-color: #f2f2f2;
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
        background-color: black;
        color: white;
	}

	h1 {
		color: #333333;
		text-align: center;
	}

	table {
		margin: 0 auto;
		border-collapse: collapse;
	}

	th, td {
		padding: 10px;
		text-align: left;
		border-bottom: 1px solid #dddddd;
	}

	th {
		background-color: #000000;
	}

	td {
		background-color: #000000;
	}

	a {
		color: #333333;
		text-decoration: none;
	}

	a:hover {
		text-decoration: underline;
	}
</style>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (custId == null || custId.equals(""))
	out.println("<h1 style=\"color: red;\">Invalid customer id. Go back to the previous page and try again.</h1>");
else if (productList == null)
	out.println("<h1 style=\"color: red;\">Your shopping cart is empty!</h1>");
else
{
	// Check if customer id is a number
	int num=-1;
	try
	{
		num = Integer.parseInt(custId);
	} 
	catch(Exception e)
	{
		out.println("<h1 style=\"color: red;\">Invalid customer id. Go back to the previous page and try again.</h1>");
		return;
	}
		
	String sql = "SELECT customerId, firstName+' '+lastName, tax FROM Customer WHERE customerId = ?"; // Retrieve tax from customer table

	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);    

	try
	{
		getConnection();
		Statement stmt = con.createStatement();            
		stmt.execute("USE orders");

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		ResultSet rst = pstmt.executeQuery();
		int orderId=0;
		String custName = "";
		double tax = 0; // Initialize tax variable

		if (!rst.next())
			out.println("<h1 style=\"color: red;\">Invalid customer id. Go back to the previous page and try again.</h1>");
		else
		{   
			custName = rst.getString(2);
			tax = rst.getDouble(3); // Retrieve tax value from result set

			// Enter order information into database
			sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";

			// Retrieve auto-generated key for orderId
			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, num);
			pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			orderId = keys.getInt(1);

			out.println("<h1>Your Order Summary</h1>");
			out.println("<table><tr><th >Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Tax</th></tr>");
			double total = 0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				out.print("<tr><td>"+productId+"</td>");
				out.print("<td>"+product.get(1)+"</td>");
				out.print("<td align=\"center\">"+product.get(3)+"</td>");
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
				out.print("<td align=\"right\">"+currFormat.format(pr*qty*tax)+"</td></tr>"); // Multiply tax with subtotal
				out.println("</tr>");
				total = total + pr*qty + (pr*qty*tax); // Add tax to total

				sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, orderId);
				pstmt.setInt(2, Integer.parseInt(productId));
				pstmt.setInt(3, qty);
				pstmt.setString(4, price);
				pstmt.executeUpdate();                
			}
			out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
						   +"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
			out.println("</table>");

			// Update order total
			sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setDouble(1, total);
			pstmt.setInt(2, orderId);            
			pstmt.executeUpdate();                        

			out.println("<h1>Order completed. Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is: "+orderId+"</h1>");
			out.println("<h1>Shipping to customer: "+custId+" Name: "+custName+"</h1>");

			out.println("<center><h2><a href=\"index.jsp\" style=\"color: #3399FF;\">Return to shopping</a></h2></center>");
			
			// Clear session variables (cart)
			session.setAttribute("productList", null);
		}
	}
	catch (SQLException ex)
	{   out.println(ex);
	}    
	finally
	{
		closeConnection();
	}
}
%>
</body>
</html>