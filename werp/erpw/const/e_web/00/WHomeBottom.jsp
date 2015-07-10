<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*, java.io.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";
	String strAct = "";
	String strFileName = "C:\\Project\\DONGRIM\\AdbeRdr70_kor.exe";
	String strMsg = "";

    try
    {
    	CITCommon.initPage(request, response, session, false);
    	
    	strAct = CITCommon.toKOR(request.getParameter("ACT"));
    	
    	if (strAct.equals("DOWNLOAD"))
    	{
    		File lrFile = new File(strFileName);
    		
    		if (lrFile.exists())
    		{
				BufferedInputStream bin = new BufferedInputStream(new FileInputStream(lrFile));
        		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
				
				response.setHeader("Content-Type", "application/octet-stream");
				response.setHeader("Content-Disposition", "attachment; filename=" + CITCommon.URLEncoding("AdbeRdr70_kor.exe"));
				response.setHeader("Content-Length", Long.toString(lrFile.length()));
				
				byte[] buf = new byte[2048]; //buffer size 2K.
				int read = 0;
				
				while ((read = bin.read(buf)) != -1)
				{
					bos.write(buf,0,read);
				}
				
				bos.close();
            	bin.close();
    		}
    		else
    		{
    			strMsg = "파일이 존재하지 않습니다.";
    		}
    	}
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><%=CITCommon.getProperty("company.name")%> - <%=CITCommon.getProperty("application.name")%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var strMsg = "<%=strMsg%>";
			
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				if (!C_isNull(strMsg))
				{
					C_msgOk(strMsg);
				}
			}
			
			function download()
			{
				frmDownLoad.ACT.value = "DOWNLOAD";
				frmDownLoad.submit();
			}
		//-->
		</script>
	</head>

	<body onload="C_Initialize()">
		<form name="frmDownLoad" method="post" action="./WHomeBottom.jsp" target="_self">
			<INPUT type='hidden' name='ACT' value="">
		</form>
		<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="10" bgcolor="#E5E5E5"></td>
				<td bgcolor="#E5E5E5"><img align="absmiddle" src="../images/adobe.gif">Adobe Reader(<a href="javascript:download()">다운로드</a>)</td>
				<!--
				<td bgcolor="#E5E5E5"><img align="absmiddle" src="../images/adobe.gif">Adobe Reader(<a href="../AdbeRdr70_kor.zip">다운로드</a>)</td>
				//-->
				<td align="right" bgcolor="#E5E5E5">Copyright ⓒ DAEBOSYSTEM corp. All Rights Reserved.</td>
				<td width="10" bgcolor="#E5E5E5"></td>
			</tr>
		</table>
	</body>
</html>
