<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@page
	import="org.eclipse.jdt.internal.compiler.flow.TryFlowContext, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement"%>
<%
	int id =(Integer)session.getAttribute("id");
	String seslogseller = (String) session.getAttribute("seslogseller");
	String path = "G:\\JAVA Program\\Eclipse2\\web\\WebContent\\product_img";
	if (ServletFileUpload.isMultipartContent(request)) {
		try {

			String fname1 = null;
			String fname2 = null;
			String pname = null;
			String category = null;
			String sname = null;
			double pprice = 0;
			int qyt = 0;
			String specification = null;

			String fpath = null;
			List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			for (FileItem item : multiparts) {
				if (!item.isFormField()) {
					if (item.getFieldName().equalsIgnoreCase("image1")) {
						fname1 = new File(item.getName()).getName();
						item.write(new File(path + File.separator + fname1));
					}
					if (item.getFieldName().equalsIgnoreCase("image2")) {
						fname2 = new File(item.getName()).getName();
						item.write(new File(path + File.separator + fname2));
					}

				} else {
					if (item.getFieldName().equalsIgnoreCase("pname")) {
						pname = item.getString();
					}
					if (item.getFieldName().equalsIgnoreCase("category")) {
						category = item.getString();
					}
					if (item.getFieldName().equalsIgnoreCase("sname")) {
						sname = item.getString();
					}
					if (item.getFieldName().equalsIgnoreCase("pprice")) {
						pprice = Double.valueOf(item.getString());
					}
					if (item.getFieldName().equalsIgnoreCase("quantity")) {
						qyt = Integer.valueOf(item.getString());
					}
					if (item.getFieldName().equalsIgnoreCase("specification")) {
						specification = item.getString();
					}
				}
			}

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
				String sql = "update product_details set product_name='" + pname + "',category='" + category
						+ "',search_name='" + sname + "',product_price='" + pprice + "',no_of_qyt='" + qyt
						+ "',specification='" + specification + "',image1='" + fname1 + "',image2='" + fname2
						+ "'where seller_name='" + seslogseller + "' and id='" + id + "'";
				PreparedStatement pst = con.prepareStatement(sql);
				int i = pst.executeUpdate();
				if (i > 0) {
					session.setAttribute("message", "Product added Successfully!!!");
					response.sendRedirect("sellerdashboard.jsp");
				}
			} catch (Exception e) {
				out.println(" " + e.getMessage());
			}

		} catch (Exception ex) {
			out.println(" " + ex.getMessage());
		}
	}
%>