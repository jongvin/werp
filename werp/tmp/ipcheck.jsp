<%@ page import="java.io.IOException,java.net.InetAddress,javax.servlet.ServletException,javax.servlet.http.*"%>
<%
		String s;
        InetAddress inetaddress = InetAddress.getLocalHost();
        s = inetaddress.getHostAddress();
        out.println("IP : " + s);
%>