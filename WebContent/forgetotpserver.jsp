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
<%
	int otp = Integer.valueOf(request.getParameter("otp"));
	int sesotp = (int) session.getAttribute("sesotp");
	String email = (String) session.getAttribute("sesemail");
	String password = "";
	if (otp == sesotp) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
			String sql = "select password from signup_data where email='" + email + "'";
			PreparedStatement pst = con.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				password = rs.getString(1);
			}
		} catch (Exception e) {
			out.print("Exception : " + e);
		}

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
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject("This is Your Password");
			message.setText("This is your password " + password);
			//send message  
			Transport.send(message);
			response.sendRedirect("signin.jsp");
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

	} else {
		session.setAttribute("sesval", "Enter valid opt");
		response.sendRedirect("forgetotp.jsp");
	}
%>