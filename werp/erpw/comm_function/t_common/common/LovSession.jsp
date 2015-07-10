<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : LovSession(�����˾��� ���Ǻ������� ������)
/* 2. ����(�ó�����) : Session Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-10-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	String strLOVSessionName = "LOV_PARAMETER";
	String strVALUES = "";
	String strACT = "NONE";
	String strERRM = "";
	
	try
	{
		CITCommon.initPage(request, response, session, false);
		
		strACT = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strACT.equals("GET"))
		{
			Hashtable htArgs = null;
			Enumeration emKeys = null;
			String lsKey = "";
			String lsValue = "";
			
			if (session.getAttribute(strLOVSessionName) != null)
			{
				htArgs = (Hashtable)session.getAttribute(strLOVSessionName);
				emKeys = htArgs.keys();
				
				while (emKeys.hasMoreElements())
				{
					lsKey = emKeys.nextElement().toString();
					lsValue = htArgs.get(lsKey).toString();
					
					strVALUES += lsKey + "\t" + lsValue + "\n";
				}
				
				strVALUES = strVALUES.substring(0, strVALUES.length() - 1);
			}
		}
		else if (strACT.equals("SET"))
		{
			strVALUES = CITCommon.toKOR(request.getParameter("VALUES"));
			
			String [] arrArgs = null;
			Hashtable htArgs = null;
			
			if (session.getAttribute(strLOVSessionName) == null)
			{
				htArgs = new Hashtable();
			}
			else
			{
				htArgs = (Hashtable)session.getAttribute(strLOVSessionName);
				htArgs.clear();
			}
			
			arrArgs = strVALUES.replaceAll("\r", "").split("\n");
			
			for (int i = 0; i < arrArgs.length; i++)
			{
				String [] arrItem = arrArgs[i].split("\t");
				
				if (arrItem == null || arrItem.length < 1) continue;
				
				if (arrItem.length < 2)
				{
					htArgs.put(arrItem[0], "");
				}
				else
				{
					htArgs.put(arrItem[0], arrItem[1]);
				}
			}
			
			session.setAttribute(strLOVSessionName, htArgs);
		}
		else
		{
			strACT = "NONE";
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
		<title>ȸ�����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
			}

			// �Լ�����---------------------------------------------------------------------//
			function SetSessionValue(asValue)
			{
				frmList.ACT.value = "SET";
				frmList.VALUES.value = asValue;
				frmList.submit();
			}
			
			function GetSessionValue()
			{
				frmList.ACT.value = "GET";
				frmList.submit();
			}
		//-->
		</script>
	</head>
	<body onload="C_Initialize()">
	    <FORM name="frmList" action="./LovSession.jsp" method="post" >
			<INPUT type='hidden' name='ACT' value="<%=CITCommon.enSC(strACT)%>">
			<INPUT type='hidden' name='VALUES' value="<%=CITCommon.enSC(strVALUES)%>">
			<%=CITCommon.enSC(strERRM)%>
		</FORM>
	</body>
</html>
