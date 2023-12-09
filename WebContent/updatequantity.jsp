<%
  int itemqty = 0; // Assuming itemqty is initially 0

  // Retrieve the value of itemqty from the request parameter
  String itemqtyParam = request.getParameter("itemqty");
  if (itemqtyParam != null) {
    itemqty = Integer.parseInt(itemqtyParam);
  }

  // Increment the value of itemqty by 1
  itemqty += 1;

  // Display the updated value of itemqty
  out.println("Item Quantity: " + itemqty);
%>
