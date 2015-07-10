<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/***************************************************/
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-10-31
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
	String		strCODE = "";
	String		strNAME = "";
	String		strACT = "NONE";
	String		strERRM = "";
	String		strOutObject = "";
	try
	{
		CITCommon.initPage(request, response, session, false);
		
		strACT = CITCommon.toKOR(CITCommon.NvlString(request.getParameter("ACT")));
		
		if(strACT.equals("PRINT"))
		{
			strCODE = CITCommon.toKOR(request.getParameter("CODE"));
			strNAME = CITCommon.toKOR(request.getParameter("NAME"));
			strOutObject = "<OBJECT ID='UserControl1' CLASSID='CLSID:2492CE04-4A8C-493C-99F8-8CC5258D4B1B' CODEBASE='ninebridge.CAB#version=1,0,0,0'> " +
							"<PARAM NAME='Name' VALUE='"+CITCommon.enSC(strNAME)+"'> "+
							"<PARAM NAME='Barcode' VALUE='"+strCODE+"'> "+
							"</OBJECT>";
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
				frmList.ACT.value = "NONE";
			}

			// 함수관련---------------------------------------------------------------------//
			function	PrintBarCode(asCode,asName)
			{
				frmList.ACT.value = "PRINT";
				frmList.CODE.value = asCode;
				frmList.NAME.value = asName;
				frmList.submit();
			}
		//-->
		</script>
	</head>
	<body onload="C_Initialize()">
	    <FORM name="frmList" action="./BarCode.jsp" method="post" >
			<INPUT type='hidden' name='ACT' value="<%=CITCommon.enSC(strACT)%>">
			<INPUT type='hidden' name='CODE' value="<%=CITCommon.enSC(strCODE)%>">
			<INPUT type='hidden' name='NAME' value="<%=CITCommon.enSC(strNAME)%>">
			<%=CITCommon.enSC(strERRM)%>
		</FORM>
		<%=strOutObject%>
	</body>
</html>
