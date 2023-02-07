
<%
	session.setAttribute("seslog", null);
	session.setAttribute("idList", null);
	session.setAttribute("cart", null);
	session.setAttribute("address", null);
	session.setAttribute("amount", null);
	session.setAttribute("list", null);
	session.setAttribute("sesreg", null);

	response.sendRedirect("index.jsp");
%>