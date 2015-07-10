<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.io.*, java.util.Properties" %>

<html>
<body>
<%
   String prevVal;
      Properties p = System.getProperties();
      %>
	 <font color="red">sun.boot.class.path:</font> 
		<%=p.getProperty("sun.boot.class.path")%><br>
		   <font color="red">java.ext.dirs:</font>   
			  <%=p.getProperty("java.ext.dirs")%><br>
			     <font color="red">java.class.path:</font>  
				    <%=p.getProperty("java.class.path")%><br>

				    </body>
				    </html>
