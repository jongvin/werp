<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : ���α׷� ID(���α׷� �ѱ۸�)
/* 2. ����(�ó�����) : �˾�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2003-02-01), ��ö�� ����(2003-04-02)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
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
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
			}
			
			// ���ǰ��� �Լ�----------------------------------------------------------------//
			function SetSession()
			{
			}
			
			function GetSession()
			{
			}
			
			function ReportSession(asName, asValue)
			{
			}
			
			// �Լ�����---------------------------------------------------------------------//
			
			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
			{
			}
			
			function OnLoadBefore(dataset)
			{
			}
			
			function OnLoadCompleted(dataset, rowcnt)
			{
			}
			
			function OnRowInsertBefore(dataset)
			{
				return true;
			}
			
			function OnRowInserted(dataset, row)
			{
			}
			
			function OnRowDeleteBefore(dataset)
			{
				return true;
			}
			
			function OnRowDeleted(dataset, row)
			{
			}
			
			function OnColumnChanged(dataset, row, colid)
			{
			}
			
			function OnExit(dataset, grid, row, colid, olddata)
			{
			}
			
			function OnPopup(dataset, grid, row, colid, data)
			{
			}
			
			// �̺�Ʈ����-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<object id=dsTest classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="left" background="../images/pop_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
								<td class="title_default">Ÿ��Ʋ</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td height="100%" width="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<TABLE width="100%" height="100%" cellSpacing="0" cellPadding="0" border="0">
										<TR>
											<TD width="10" ><IMG src="../images/bullet3.gif" ></TD>
											<TD width="55" noWrap="true">�˻�����</TD>
											<TD WIDTH="*"><INPUT type="text" id="txtSearch" style="WIDTH:100%" onKeyDown="txtSearch_onKeyDown()"></TD>
											<TD width="2">&nbsp;</TD>
											<TD width="50">
												<input id="btnRetrieve" type="button" class="img_btnFind" value="�˻�" onclick="btnRetrieve_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</TD>
											<td width="4">&nbsp;</td>
										</TR>
									</TABLE>
								</td>
							</tr>
							<tr>
								<td width="100%" height="*">
									<OBJECT id=gridArgs WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsLovArgs">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=���� ID=DIS_SEQ Align=Center Width=30 
											</FC> 
											<FC> Name=���ڸ� ID=NAME Width=105
											</FC> 
											<C> Name=Ÿ�� ID=TYPE Width=40 EditStyle=Combo Data='S:����,N:����,D:��¥'
											</C> 
											<C> Name=�⺻�� ID=DEFAULT_VALUE Width=75
											</C> 
											<C> Name=����? ID=SESSION_TAG Width=40 EditStyle=CheckBox
											</C> 
											<C> Name=���Ǻ����� ID=SESSION_NAME Width=100
											</C> 
											">
									</OBJECT>
								</td>
							</tr>
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<TD width="100%" align="right">
												<input id="imgOk" type="button" class="img_btnOk" value="Ȯ��" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="imgCancle" type="button" class="img_btnClose" value="�ݱ�" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</DIV>
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