<%@ page contentType="text/html;charset=euc-kr" %>
I'm mydomain세션 테스트용 
<%
	{
	String str = (String)session.getAttribute("count");
	int cnt=0;

	if(str == null || str.equals("null")){
		cnt = 0;
	}else{
		cnt = Integer.parseInt(str);
	}

	out.println("<br>Cur value :"+str);
	out.println("<br>session :"+session.getId());
	out.println("<br>session :"+session.getMaxInactiveInterval());

	str = String.valueOf(++cnt);
	session.setAttribute("count",str);
}
	
%>
<p>
<a href="http://52.2.202.41:7001/werp/session.jsp">second domain </a>
<br>
<a href="http://52.2.202.41:7001/werp/wiis_report.rar">wiis_report.rar </a>
<br>
<a href="http://52.2.202.41:7001/werp/wiis_report.zip">wiis_report.zip </a>
