<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";

    try
    {
    	CITCommon.initPage(request, response, session);
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>동일토건 - 통합정보시스템</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="right" bgcolor="#E5E5E5">Copyright ⓒ dihv corp. All Rights Reserved.</td>
				<td width="10" bgcolor="#E5E5E5"></td>
			</tr>
		</table>
	</body>
</html>
