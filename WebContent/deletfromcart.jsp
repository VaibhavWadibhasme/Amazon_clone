
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
	String seslog = (String) session.getAttribute("seslog");
	int id = Integer.parseInt(request.getParameter("id"));
	int qyt = Integer.parseInt(request.getParameter("qyt"));
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
		String sql = "delete from cart where email='" + seslog + "' and id='" + id + "' and qyt='"+qyt+"'";
		PreparedStatement pst = con.prepareStatement(sql);
		int i = pst.executeUpdate();
		if (i > 0) {
			response.sendRedirect("cart.jsp");
		}
	} catch (Exception e) {
		out.println("Exception : " + e);
	}
%>