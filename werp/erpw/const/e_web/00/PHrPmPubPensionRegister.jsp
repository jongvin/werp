<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*, java.sql.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : ������
/* �����ۼ��� : 2005-09-09
/* ���������� : 
/* ���������� : 
/***************************************************/
	
	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";
	
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
		<title><%=CITCommon.getProperty("company.name")%> - <%=CITCommon.getProperty("application.name")%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
			}
			
			// �Լ�����---------------------------------------------------------------------//

			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			
			// �̺�Ʈ����-------------------------------------------------------------------//
			function document_onKeyPress()
			{
				if (event.keyCode == 27)
				{
					btnCancel_onClick();
				}
			}
			
			function btnAdd_onClick()
			{
				if (C_isNull(frmFileLoad.NewFileName.value))
				{
					C_msgOk("��� ������ �����ϼ���.");
					return;
				}
				
				var ext = frmFileLoad.NewFileName.value.substring(frmFileLoad.NewFileName.value.lastIndexOf(".") + 1, frmFileLoad.NewFileName.value.length);
				
				if (C_isNull(ext) || (ext.toUpperCase() != "XLS"))
				{
					C_msgOk("���� ����(XLS)�� �����ϼ���.");
					return;
				}
				
				frmFileLoad.action = "./PHrPmPubPensionRegister_P.jsp?ACT=ADD";
				frmFileLoad.submit();
				
				window.returnValue = "O";
				window.close();
			}
			
			function btnCancel_onClick()
			{
				window.returnValue = "C";
				window.close();
			}
			
		//-->
		</script>
		
	</head>
	<body onload="C_Initialize()" onkeypress="javascript:document_onKeyPress()">
		<form name="frmFileLoad" method="post" action="./PHrPmPubPensionRegister_P.jsp" target="ifrmAdd" enctype="multipart/form-data">
			<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
				<TR>
					<TD align="center">
						<!-- ǥ�� �˾� �������� �ּ� DIV ũ��(��:250px �̻�, ����:400px ����) //-->
						<DIV id="divPopMain" style="WIDTH: 400px; HEIGHT: 150px;">
							<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td align="left" background="../images/pop_tit_bg.gif">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
												<td class="title_default">���ο��� ������� ���</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr height="2"> 
									<td></td>
								</tr>
								<tr> 
									<td height="100%" width="100%">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr align="center">
												<td width="15"><img src="../images/z1_sub2_bullet.gif"></td>
												<td width="40">���ϸ�</td>
												<td width="*">
													<input type="file" name="NewFileName" style="width:320px">
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr> 
									<td height="30" width="100%" bgcolor="#ECECEC">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
											<tr> 
												<td width="*" align="right">
													<input id="btnAdd" type="button" class="btn2_1" value="���" onclick="btnAdd_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
													<input id="btnCancel" type="button" class="btn2_1" value="���" onclick="btnCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												</td>
												<td width="10">&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</DIV>
					</TD>
				</TR>
			</TABLE>
		</form>
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