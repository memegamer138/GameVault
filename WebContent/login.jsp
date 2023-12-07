<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<style>
body {
	background-color: #f2f2f2;
	font-family: Arial, Helvetica, sans-serif;
}

.container {
	margin: 0 auto;
	text-align: center;
	display: inline;
	background-color: #ffffff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

h3 {
	color: #333333;
}

.error-message {
	color: #ff0000;
}

input[type="text"],
input[type="password"] {
	padding: 10px;
	border: 1px solid #cccccc;
	border-radius: 3px;
	font-size: 14px;
}

.submit {
	background-color: #4caf50;
	color: #ffffff;
	border: none;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px;
	border-radius: 3px;
	cursor: pointer;
}

.submit:hover {
	background-color: #45a049;
}

</style>
</head>
<body>

<div class="container">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p class=\"error-message\">" + session.getAttribute("loginMessage").toString() + "</p>");
%>

<br>
<form name="MyForm" method="post" action="validateLogin.jsp">
<center><table>
<tr>
	<td><div align="right"><font size="2">Username:</font></div></td>
	<td><input type="text" name="username" size="10" maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font size="2">Password:</font></div></td>
	<td><input type="password" name="password" size="10" maxlength="10"></td>
</tr>
</table></center>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>
