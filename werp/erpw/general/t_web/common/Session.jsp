<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/***************************************************/
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-10-31
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
	String		strNAMES = "";
	String		strVALUES = "";
	String		strACT = "NONE";
	String		strERRM = "";
	try
	{
		CITCommon.initPage(request, response, session, false);
		
		strACT = CITCommon.toKOR(CITCommon.NvlString(request.getParameter("ACT")));
		
		if(strACT.equals("GET"))
		{
			strNAMES = CITCommon.toKOR(request.getParameter("NAMES")).replaceAll("\r","");
			String[]		strNAMEARRAY = strNAMES.split("\n");
			
			for(int i = 0 ; i < strNAMEARRAY.length ; i ++)
			{
				String strVALUE = CITCommon.toKOR(CITCommon.NvlString(session.getAttribute(strNAMEARRAY[i])));
				
				if(i == 0)
				{
					strVALUES = strVALUE;
				}
				else
				{
					strVALUES = strVALUES + "\n"+ strVALUE;
				}
			}
		}
		else if(strACT.equals("SET"))
		{
			strNAMES = CITCommon.toKOR(request.getParameter("NAMES")).replaceAll("\r","");
			strVALUES = CITCommon.toKOR(request.getParameter("VALUES")).replaceAll("\r","");
			String[] strNAMEARRAY = strNAMES.split("\n");
			String[] strVALUEARRAY = strVALUES.split("\n");
			
			for(int i = 0 ; i < strNAMEARRAY.length ; i ++)
			{
				session.setAttribute(strNAMEARRAY[i],strVALUEARRAY[i]);
				CITDebug.PrintMessages(strNAMEARRAY[i]);
				CITDebug.PrintMessages(strVALUEARRAY[i]);
			}
		}
	}
	catch (Exception ex)
	{
		strERRM = ex.getMessage();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>회계관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
				if(frmList.ACT.value == "GET")
				{
					ReportSession(frmList.NAMES.value,frmList.VALUES.value);
				}
				else if(frmList.ACT.value == "SET")
				{
					ReportSession(frmList.NAMES.value,frmList.VALUES.value);
				}
				frmList.ACT.value = "NONE";
			}

			// 함수관련---------------------------------------------------------------------//
			function	SetSessionValue(asName,asValue)
			{
				frmList.ACT.value = "SET";
				frmList.NAMES.value = asName;
				frmList.VALUES.value = asValue;
				frmList.submit();
			}
			function	GetSessionValue(asName)
			{
				frmList.ACT.value = "GET";
				frmList.NAMES.value = asName;
				frmList.submit();
			}
			function	ReportSession(asName,asValue)
			{
				var lsNames = asName.split("\n");
				var lsValues = asValue.split("\n");
				for( var i = 0 ; i < lsNames.length ; i ++)
				{
					parent.ReportSession(lsNames[i],lsValues[i]);
				}
				
			}
		//-->
		</script>
	</head>
	<body onload="C_Initialize()">
	    <FORM name="frmList" action="./Session.jsp" method="post" >
			<INPUT type='hidden' name='ACT' value="<%=CITCommon.enSC(strACT)%>">
			<INPUT type='hidden' name='NAMES' value="<%=CITCommon.enSC(strNAMES)%>">
			<INPUT type='hidden' name='VALUES' value="<%=CITCommon.enSC(strVALUES)%>">
			<%=CITCommon.enSC(strERRM)%>
		</FORM>
	</body>
</html>
