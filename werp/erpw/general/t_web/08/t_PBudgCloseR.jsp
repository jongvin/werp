<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_PBudgCloseR.jsp(������û �ϰ� ���)
/* 2. ����(�ó�����) : �˾�
/* 3. ��  ��  ��  �� : ������û �ϰ� ��Ͻ� ������ �Է� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-27)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strFileName = "./t_PBudgCloseR";
	
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
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsTest classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="left"  height="36" background="../images/pop_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
								<td class="title_default">�����ϵ��</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td align=center>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="40">&nbsp;</td>
								<TD width="10" ><IMG src="../images/bullet3.gif" ></TD>
								<TD width="40" align=center>������</TD>
								<TD WIDTH="72"><INPUT type="text" id="txtREQ_CLSE_DT"  Datatype="date" notNull  style="WIDTH:70" ></TD>
								
								<td width="70">
									<input id="btnREQ_CLSE_DT" type="button" class="img_btnCalendar_S" onClick="btnREQ_CLSE_DT_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
								</td>
								
								<td width="20">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td align="left">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<TD width="100%" align="center">
									&nbsp;
								</TD>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td align="left">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<TD width="100%" align="center">
									<input id="imgOk" type="button" class="img_btnOk" value="Ȯ��" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="imgCancle" type="button" class="img_btnClose" value="�ݱ�" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
								</TD>
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