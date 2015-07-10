<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*, javax.servlet.http.*" errorPage="Error.jsp javax.servlet.http.*" contentType="text/html;charset=euc-kr" %>
<%
   	CITData  lrReturnData       = null;
   	String	  strSql             = null;
   	String	  strCONTENT_URL     = null;

    try
    {
      	CITCommon.initServerPage(request, response, session);
   	}
   	catch (Exception ex)
   	{
		     throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	   }

 			try
 			{
       CITData lrArgData = new CITData();

    			strSql   = "SELECT USER_NM          \n";
    			strSql  += "  FROM TCC_EMPLOYE      \n";
    			strSql  += " WHERE USER_NO = ?      \n";

    			lrArgData.addColumn("USER_NO",CITData.VARCHAR2);
    			lrArgData.addRow();
    			lrArgData.setValue("USER_NO",CITCommon.toKOR(request.getParameter("user_no")));

   				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

       session.setAttribute("user_no", CITCommon.toKOR(request.getParameter("user_no")));
       session.setAttribute("user_nm", lrReturnData.toString(0,"USER_NM"));
       session.setAttribute("user_id", CITCommon.toKOR(request.getParameter("user_id")));
       session.setAttribute("sys_id", CITCommon.toKOR(request.getParameter("sys_id")));

       strSql = "{call SPCC_SESSION_I(?,?,?)}";

       lrArgData.removeAll();

  					lrArgData.addColumn("SYS_ID", CITData.NUMBER);
  					lrArgData.addColumn("USER_NO", CITData.NUMBER);
  					lrArgData.addColumn("SESSION_ID", CITData.VARCHAR2);

  					lrArgData.addRow();
  					lrArgData.setValue("SYS_ID",     session.getAttribute("sys_id"));
  					lrArgData.setValue("USER_NO",    session.getAttribute("user_no"));
  					lrArgData.setValue("SESSION_ID", session.getId());

   				CITDatabase.executeProcedure(strSql, lrArgData);

       lrArgData.removeAll();

    			strSql   = "SELECT CONTENT_URL      \n";
    			strSql  += "  FROM TCC_SYS_SYSTEM   \n";
    			strSql  += " WHERE SYS_ID = ?       \n";

    			lrArgData.addColumn("SYS_ID",CITData.VARCHAR2);
    			lrArgData.addRow();
    			lrArgData.setValue("SYS_ID",session.getAttribute("sys_id"));

   				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

       strCONTENT_URL = lrReturnData.toString(0,"CONTENT_URL");
   	}
   	catch (Exception ex)
   	{
		     throw new Exception("TCC_SYS_SYSTEM -> " + ex.getMessage());
	   }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
	<head>
		<title>동일토건 - 통합정보시스템</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
	</head>

	<frameset rows="50,*" frameborder="NO" border="0" framespacing="0">
		<frame src="./WHomeTop.jsp" name="topFrame" scrolling="NO" noresize >
		<frameset cols="180,*" frameborder="NO" border="0" framespacing="0">
 		<frame src="./WHomeMenu.jsp" name="leftFrame" scrolling="no" noresize>
	 	<frameset rows="*,20" frameborder="NO" border="0" framespacing="0">
    <frame src="<%=strCONTENT_URL%>" name="mainFrame" scrolling="auto">
    <frame src="./WHomeBottom.jsp" name="bottomFrame" scrolling="no" noresize >
   </frameset>
		</frameset>
	</frameset>
	<noframes>
	</noframes>
</html>
