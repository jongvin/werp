<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WChangeBillPwR.jsp(������ü��ȣ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
//���ϸ�	
	String strFileName = "./t_WChangeBillPwR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	String	strUserNo;

	try
	{
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
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
		<title>���ξ�ȣ����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sEmpNo = "<%=strUserNo%>";
			
			// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
			// ��ȸ
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
	</head>
	<body onload="C_Initialize()">
		<iframe width="0" height="0" name="ifrmLovSession" src="../common/LovSession.jsp" frameborder="0" tabindex="-1"></iframe>
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr  valign="center"> 
					<td height="100%" width="100%" align="center">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center">
									<table width="200" height="160" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">�����ȣ</td>
														<td width="*">
															<input id="txtOLD_PASSWORD" type="password" datatype="hna"   style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">�űԾ�ȣ</td>
														<td width="*">
															<input id="txtNEW_PASSWORD" type="password" datatype="hna"   style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">��ȣ���Է�</td>
														<td width="*">
															<input id="txtNEW_PASSWORD_CONFIRM" type="password" datatype="hna"   style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<TD width="*" align="center">
												<input id="imgOk" type="button" class="img_btnOk" value="Ȯ��" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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