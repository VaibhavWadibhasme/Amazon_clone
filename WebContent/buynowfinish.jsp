<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
	String seslog = (String) session.getAttribute("seslog");
	List cart = (List) session.getAttribute("cart");
	List address = (List) session.getAttribute("address");
	List amount = (List) session.getAttribute("amount");

	String msg = "";
	Iterator itr = cart.iterator();
	while (itr.hasNext()) {
		msg = msg + itr.next() + "\n";
	}
	msg = msg + "Delivary address\n";
	Iterator itr1 = address.iterator();
	while (itr1.hasNext()) {
		msg = msg + itr1.next() + "\n";
	}
	msg = msg + "----------------------------------------\n";
	msg = msg + "Order Summery\n";
	Iterator itr2 = amount.iterator();
	while (itr2.hasNext()) {
		msg = msg + itr2.next() + "\n";
	}
	msg = msg + "----------------------------------------\n";

	String subject = "Your order placed sucessfully";

	//Get properties object    
	Properties props = new Properties();
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.socketFactory.port", "465");
	props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.port", "465");

	//get Session 
	Session session1 = Session.getInstance(props, new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication("vaibhavwadibhasme1@gmail.com", "owtxgctlxhpjcbni");
		}
	});

	//compose message 
	try {
		MimeMessage message = new MimeMessage(session1);
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(seslog));
		message.setSubject(subject);
		message.setText(msg);
		//send message  
		Transport.send(message);
	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}

	List list = (List) session.getAttribute("list");
	Iterator itr3 = list.iterator();
	while (itr3.hasNext()) {
		int id = (int) itr3.next();
		int qyt = (int) itr3.next();
		//adding in cart with status 1 so can visible in orders
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
			String sql = "insert into cart (email,id,qyt,status) values('" + seslog + "','" + id + "','" + qyt
					+ "','1')";
			PreparedStatement pst = con.prepareStatement(sql);
			int i = pst.executeUpdate();
			if (i > 0) {
				System.out.println("status change");
			}
		} catch (Exception e) {
			out.println("Exception : " + e);
		}

		//substracting qyt from product
		int sellerqyt = 0;
		String sellername = null;
		String pname = null;
		int pprice = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
			String sql = "select * from product_details where id='" + id + "' ";
			PreparedStatement pst = con.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				sellername = rs.getString("seller_name");
				pname = rs.getString("product_name");
				pprice = rs.getInt("product_price");
				sellerqyt = rs.getInt("no_of_qyt");
			}
			//add to orderplaced
			String sql2 = "insert into order_placed (seller,buyer,product_id,qyt,status) values ('" + sellername
					+ "','" + seslog + "','" + id + "','" + qyt + "','0')";
			PreparedStatement pst2 = con.prepareStatement(sql2);
			int k = pst2.executeUpdate();
			if (k > 0) {
				System.out.println("Order placed ");
			}
			//update seller qyt
			sellerqyt = sellerqyt - qyt;
			String sql1 = "update product_details set no_of_qyt='" + sellerqyt + "' where id='" + id + "' ";
			PreparedStatement pst1 = con.prepareStatement(sql1);
			int j = pst1.executeUpdate();
			if (j > 0) {
				System.out.println("seller qyt change ");
			}

			//sending msg to seller
			String subject2 = "Order placed for your Product";

			//Get properties object    
			Properties props2 = new Properties();
			props2.put("mail.smtp.host", "smtp.gmail.com");
			props2.put("mail.smtp.socketFactory.port", "465");
			props2.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props2.put("mail.smtp.auth", "true");
			props2.put("mail.smtp.port", "465");

			//get Session 
			Session session2 = Session.getInstance(props2, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("vaibhavwadibhasme1@gmail.com", "owtxgctlxhpjcbni");
				}
			});

			//compose message
			String sellermsg = "------------------------------------------\nProduct Name : " + pname
					+ "\nProduct Price : " + pprice + "\nOrder Qyt : " + qyt + "\nOrder Price : " + qyt * pprice
					+ "\nQyt remaining : " + sellerqyt + "\n------------------------------------------";
			try {
				MimeMessage message = new MimeMessage(session2);
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(sellername));
				message.setSubject(subject2);
				message.setText(sellermsg);
				//send message  
				Transport.send(message);
			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}

		} catch (Exception e) {
			out.println("Exception : " + e);
		}
	}
	response.sendRedirect("order.jsp");// we will took data of having status 1 and show on order page
%>