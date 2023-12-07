<!DOCTYPE html>
<html>
<head>
<title>GameVault CheckOut Line</title>
</head>
<body>

<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">
Customer ID: <input type="text" name="customerId" size="50"><br><br>
    <label for="cardNumber">Card Number:</label>
    <input type="text" id="cardNumber" name="cardNumber" required><br><br>
    
    <label for="expiryDate">Expiry Date:</label>
    <input type="text" id="expiryDate" name="expiryDate" required><br><br>
    
    <label for="cvv">CVV:</label>
    <input type="text" id="cvv" name="cvv" required><br><br>
    <input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

<%
    String expiryDate = request.getParameter("expiryDate");
    String cvv = request.getParameter("cvv");
    String cardNumber = request.getParameter("cardNumber");

    if (expiryDate != null && cvv != null && cardNumber != null) {
        if (expiryDate.matches("\\d{2}/\\d{2}")) {
            String[] dateParts = expiryDate.split("/");
            int month = Integer.parseInt(dateParts[0]);
            int year = Integer.parseInt(dateParts[1]);
            if (month >= 1 && month <= 12 && year >= 2022) {
                if (cvv.matches("\\d{3}")) {
                    if (cardNumber.matches("\\d{16}")) {
                        // Valid input, continue with the transaction
                    } else {
                        out.println("Invalid card number");
                    }
                } else {
                    out.println("Invalid CVV");
                }
            } else {
                out.println("Invalid expiry date");
            }
        } else {
            out.println("Invalid expiry date format");
        }
    }
%>

</body>
</html>
