<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<style>
	body {
		font-family: Arial, sans-serif;
		margin: 20px;
	}

	h3 {
		color: #333;
		margin-bottom: 10px;
	}

	table {
		border-collapse: collapse;
		width: 100%;
	}

	th, td {
		padding: 8px;
		text-align: left;
		border-bottom: 1px solid #ddd;
	}

	th {
		background-color: #f2f2f2;
	}

	hr {
		margin-top: 20px;
		margin-bottom: 20px;
		border: 0;
		border-top: 1px solid #ddd;
	}
</style>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{   
	out.println("<h3>Administrator Sales Report by Day</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	ResultSet rst = con.createStatement().executeQuery(sql);        
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");    

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
	}
	out.println("</table>");        
}
catch (SQLException ex) {
	out.println(ex); 
}
out.println("<hr>");
try 
{   
	out.println("<h3>List of all customers</h3>");
	sql = "select firstname, lastname from Customer";
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	ResultSet rst = con.createStatement().executeQuery(sql);        
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Name</th></tr>");    

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+" "+rst.getString(2)+"</td></tr>");
	}
	out.println("</table>");        
}
catch (SQLException ex) {
	out.println(ex); 
}
closeConnection();    
%><br>
<form method="get" action="index.jsp">
	<button type="submit">Return to Menu</button>
</form>
</body>
</html>
