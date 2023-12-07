<!DOCTYPE html>
<html>
<head>
	<title>GameVault Main Page</title>
	<style>
		body {
			background-color: #f2f2f2;
			font-family: Arial, sans-serif;
		}

		h1 {
			color: #333333;
			text-align: center;
			margin-top: 50px;
		}

		h2 {
			color: #666666;
			text-align: center;
			margin-top: 30px;
		}

		a.button {
			display: inline-block;
			padding: 10px 20px;
			background-color: #0066cc;
			color: #ffffff;
			text-decoration: none;
			border-radius: 5px;
		}

		a.button:hover {
			background-color: #0056b3;
		}

		h3 {
			color: #999999;
			text-align: center;
			margin-top: 20px;
		}
	</style>
	
</head>
<body>
<h1>Welcome to GameVault</h1>

<h2><a href="login.jsp" class="button">Login</a></h2>

<h2><a href="listprod.jsp" class="button">Begin Shopping</a></h2>

<h2><a href="listorder.jsp" class="button">List All Orders</a></h2>

<h2><a href="customer.jsp" class="button">Customer Info</a></h2>

<h2><a href="admin.jsp" class="button">Administrators</a></h2>

<h2><a href="logout.jsp" class="button">Log out</a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3>Signed in as: "+userName+"</h3>");
%>
</body>
</html>
