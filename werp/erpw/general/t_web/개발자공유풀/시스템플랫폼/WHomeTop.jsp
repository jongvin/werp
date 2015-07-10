<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData  lrReturnData       = null;
	String	  strSql             = null;
	String	  strDate            = null;
	String	  strWeek            = null;
	String	  strDongil_logo_url = null;
	String	  strHelp_url        = null;
	String	  strSitemap_url     = null;
	String	  strUser_nm         = null;

	try
	{
  		CITCommon.initPage(request, response, session);
    CITData lrArgData = new CITData();

  		strSql   = "SELECT TO_CHAR(SYSDATE,'YYYY')||'년'||TO_CHAR(SYSDATE,'MM')||'월'||TO_CHAR(SYSDATE,'DD')||'일' AS DT \n";
  		strSql  += "  FROM DUAL \n";

    lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
    strDate      = lrReturnData.toString(0,"DT");

  		strSql   = "SELECT CASE (SELECT TO_CHAR(SYSDATE,'D') FROM DUAL) \n";
  		strSql  += "             WHEN '1' THEN '일' \n";
  		strSql  += "             WHEN '2' THEN '월' \n";
  		strSql  += "             WHEN '3' THEN '화' \n";
  		strSql  += "             WHEN '4' THEN '수' \n";
  		strSql  += "             WHEN '5' THEN '목' \n";
  		strSql  += "             WHEN '6' THEN '금' \n";
  		strSql  += "             ELSE '토'          \n";
  		strSql  += "        END AS WEEK             \n";
  		strSql  += "   FROM DUAL                    \n";

    lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
    strWeek      = lrReturnData.toString(0,"WEEK");

 			strSql   = "SELECT DONGIL_LOGO_URL, \n";
 			strSql  += "       HELP_URL       , \n";
 			strSql  += "       SITEMAP_URL      \n";
 			strSql  += "  FROM TCC_SYS_SYSTEM   \n";
 			strSql  += " WHERE SYS_ID = ?       \n";

 			lrArgData.addColumn("SYS_ID",CITData.VARCHAR2);
 			lrArgData.addRow();
 			lrArgData.setValue("SYS_ID",session.getAttribute("sys_id"));

  		lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

    strDongil_logo_url = lrReturnData.toString(0,"DONGIL_LOGO_URL");
    strHelp_url        = lrReturnData.toString(0,"HELP_URL");
    strSitemap_url     = lrReturnData.toString(0,"SITEMAP_URL");
	}
	catch (Exception ex)
	{
    out.println(ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>동일토건 - 통합정보시스템</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript">
	<!--
		//-->
		</script>
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<table width="100%" height=50 border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td height="50" align="left" valign="top" background="../images/z1_top_bg.gif">
					<table width="990" height="50" border="0" cellpadding="0" cellspacing="0">
						<tr>
  					<td width="180" rowspan="2" align="left" valign="top"><a href="<%=strDongil_logo_url%>" target="mainFrame" onFocus="blur()"><img src="../images/z1_top_dong_logo.gif" border="0"></a></td>
							<td width="810">
								<table width="800" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width="20">&nbsp;</td>
  								<td align="right" class="top_support">
           <table width="150" border="0" cellspacing="0" cellpadding="0">
  										<tr align="center">
		  									<td><a href="<%=strHelp_url%>" target="mainFrame" onFocus="blur()"><img src="../images/btn_top_help.gif" width="52" height="11"></a></td>
				  							<td><a href="<%=strSitemap_url%>" target="mainFrame" onFocus="blur()"><img src="../images/btn_top_sitemap.gif" width="73" height="11"></a></td>
						 			 	</tr>
							 		 </table>
          </td>
									</tr>
									<tr>
										<td width="20"><br>&nbsp;</td>
										<td><span class="font_top_info"><%=strDate%> (<%=strWeek%>) | <%=session.getAttribute("user_nm")%>님 안녕하세요.</span></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
