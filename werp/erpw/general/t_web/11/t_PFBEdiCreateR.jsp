<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";

  try
  {
    	CITCommon.initPage(request, response, session);
	}
	catch (Exception ex)
	{
		throw new Exception("������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>��ȣȮ��</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/Popup.js"></script>
		<script language="javascript">
		<!--
			var lrArgs;
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;

				lrArgs = window.dialogArguments;
			}

			// �̺�Ʈ����-------------------------------------------------------------------//
			function	ConfirmSelected()
			{
				var arrRet = Array(3);
				arrRet[0] = "TRUE";
				arrRet[1] = txtMANAGER_PASS1.value;
				arrRet[2] = txtMANAGER_PASS2.value;
				
				window.returnValue = arrRet;
				window.close();
			}
			function imgOk_onClick()
			{
				ConfirmSelected();
			}

			function imgCancle_onClick()
			{
				window.returnValue = null;
				window.close();
			}

		//-->
		</script>
	</head>
	<body onload="C_Initialize();">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="398" height="210" border="0">
			<TR >
				<TD align="center">
					<!-- ǥ�� �˾� �������� �ּ� DIV ũ��(��:250px �̻�, ����:400px ����) //-->
					<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left" background="../images/pop_tit_bg.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="23"><img src="../images/pop_tit_normal2.gif"></td>
											<td class="title_default">��ȣȮ��</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr >
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="80%" border="1" cellspacing="0" cellpadding="0">
										<tr  bgcolor="ECECEC">
											<td align="center" bgcolor="ECECEC">
												<!-- ��� ���� //-->
												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>&nbsp;&nbsp;���õ� �ǿ� ���Ͽ� Ȯ��ó���մϴ�.</TR>
													<TR>&nbsp;</TR>
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="70">Ȯ�ξ�ȣ</td>
														<td width="70">
															<input id="txtMANAGER_PASS1" type="password" center datatype="hna" class="han"  style="width:80px" >
														</td>
														<td> &nbsp;</td>
													</TR>
												</TABLE>
												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="70">��ȣ���Է�</td>
														<td width="80">
															<input id="txtMANAGER_PASS2" type="password" center datatype="hna" style="width:80px" >
														</td>
													<td> &nbsp;</td>
													</TR>
												</TABLE>
												<!-- �˻��� ���� //-->
											</td>
										</tr>
										<tr>
											<td height="5" bgcolor="ECECEC"></td>
										</tr>
									</table>
									<table width="100%" height="20%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="right" bgcolor="ECECEC">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<TR >
														<TD width="100%" align="right">
															<input id="imgOk" type="button" class="img_btnOk" value="����" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="imgCancle" type="button" class="img_btnClose" value="���" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
														</TD>
													</TR>
												</TABLE>
											</td>
										</tr>
										<tr>
											<td height="8" bgcolor="ECECEC"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</DIV>
				</TD>
			</TR>
		</TABLE>
	</body>
</html>
