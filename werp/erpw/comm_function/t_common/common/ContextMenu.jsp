<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : FlexGridContextMenu(FlexGrid�� ContextMenu)
/* 2. ����(�ó�����) : FlexGrid�� ContextMenu
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";
	
	String strContextMenuID = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strContextMenuID = CITCommon.toKOR(request.getParameter("CMID"));
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>ȸ�����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<style type="text/css">
		<!--
			.menuItem		{ cursor:default; width:100%; height:18px; padding-top:3px; padding-left:15px; background-Color:menu; color:black; }
			.highlightItem	{ cursor:default; width:100%; height:18px; padding-top:3px; padding-left:15px; background-Color:highlight; color:white; }
			.lineItem		{ cursor:default; width:100%; height:18px; padding-top:3px; padding-left:4px; background-Color:menu; color:#808080; }
		//-->
		</style>
		<script language="javascript">
		<!--
			var strContextMenuID = "<%=strContextMenuID%>";
			
			function Initialize()
			{
				divMenuMain.innerHTML = parent.CM_MENU_HTML;
			}
			
			// �Լ�����---------------------------------------------------------------------//
			function switchMenu()
			{
				var obj = event.srcElement;
				
				if (obj.disabled == false && obj.className == "menuItem")
				{
					obj.className = "highlightItem";
				}
				else if (obj.className == "highlightItem")
				{
					obj.className = "menuItem";
				}
			}
			
			function selectMenu(aMenuID)
			{
				parent.CM_ContextMenuHide(strContextMenuID, aMenuID);
			}
			
			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			
			// �̺�Ʈ����-------------------------------------------------------------------//
			
		//-->
		</script>
		
	</head>
	<body onload="Initialize()" onselectstart="return false" oncontextmenu="return false">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
			<TR>
				<TD>
					<!-- ǥ�� �˾� �������� �ּ� DIV ũ��(��:250px �̻�, ����:400px ����) //-->
					<div id="divMenuMain" Hidefocus onmouseover="switchMenu()" onmouseout="switchMenu()" style="width:170px; background-Color:menu; border:outset 2px">
					</div>
				</TD>
			</TR>
		</TABLE>
	</body>
</html>
<%
	try
	{
		CITCommon.finalPage();
	}
	catch (Exception ex)
	{
		throw new Exception("������ ���� ���� -> " + ex.getMessage());
	}
%>