
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
	String email = (String) session.getAttribute("seslog");
	int id = Integer.parseInt(request.getParameter("pid"));
	int qyt = Integer.parseInt(request.getParameter("qyt"));

	try {
		int sellerqyt = 0;
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
		String sql = "select no_of_qyt from product_details where id='" + id + "' ";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();
		while (rs.next()) {
			sellerqyt = rs.getInt(1);
		}
		if (sellerqyt - qyt >= 0) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
				String sql1 = "insert into cart (email,id,qyt,status) values" + "('" + email + "','" + id + "','"
						+ qyt + "','0')";
				PreparedStatement pst1 = con1.prepareStatement(sql1);
				int i = pst1.executeUpdate();
				if (i > 0) {
					out.println("added to cart");
				}
			} catch (Exception e) {
				out.println("Exception : " + e);
			}
		}else{
			out.println("Out of Stock for Now!");
		}
	} catch (Exception e) {
		out.println("Exception : " + e);
	}
%>