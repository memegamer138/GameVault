<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style>
	body {
		font-family: Arial, sans-serif;
		background-color: #f2f2f2;
	}

	h3 {
		color: #333;
	}

	table {
		border-collapse: collapse;
		width: 100%;
		margin-bottom: 20px;
	}

	th, td {
		padding: 10px;
		text-align: left;
		border-bottom: 1px solid #ddd;
	}

	th {
		background-color: #f2f2f2;
		font-weight: bold;
	}

	/* Increase font size by 4 */
	body {
		font-size: calc(100% + 4px);
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

// Print Customer information
String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{   

	out.println("<center><h3>Customer Profile</h3></center>");
	out.println("<hr>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);    
	ResultSet rst = pstmt.executeQuery();
	
	if (rst.next())
	{
		out.println("<table>");
		out.println("<tr><th><center>Id</center></th><td><center>"+rst.getString(1)+"</center></td></tr>");    
		out.println("<tr><th><center>First Name</center></th><td><center>"+rst.getString(2)+"</center></td></tr>");
		out.println("<tr><th><center>Last Name</center></th><td><center>"+rst.getString(3)+"</center></td></tr>");
		out.println("<tr><th><center>Email</center></th><td><center>"+rst.getString(4)+"</center></td></tr>");
		out.println("<tr><th><center>Phone</center></th><td><center>"+rst.getString(5)+"</center></td></tr>");
		out.println("<tr><th><center>Address</center></th><td><center>"+rst.getString(6)+"</center></td></tr>");
		out.println("<tr><th><center>City</center></th><td><center>"+rst.getString(7)+"</center></td></tr>");
		out.println("<tr><th><center>State</center></th><td><center>"+rst.getString(8)+"</center></td></tr>");
		out.println("<tr><th><center>Postal Code</center></th><td><center>"+rst.getString(9)+"</center></td></tr>");
		out.println("<tr><th><center>Country</center></th><td><center>"+rst.getString(10)+"</center></td></tr>");
		out.println("<tr><th><center>User id</center></th><td><center>"+rst.getString(11)+"</center></td></tr>");        
		out.println("</table></center>");
		out.println("<center><h2><a href=\"index.jsp\">Home</a></h2>");
	}
}
catch (SQLException ex) 
{   out.println(ex); 
}
finally
{   
	closeConnection();    
	out.println("</div>"); // Close the container div
}
%>

</body>
</html>
