<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixAssetClsCodeR.jsp(�ڻ������ڵ���)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ������ۼ�(2006-01-16)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFixAssetClsCodeR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
		<!--
			var oldData ="";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
			// �̺�Ʈ����-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- ���� ���̺� ���� //-->
						
						<!-- ���� ���̺� ���� //-->
						<!-- �������� ���̺� ���� //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
						<!-- �������� ���̺� ���� //-->
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> �����ڻ������ڵ�</td>
											<td align="right" width="*">
												&nbsp;
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=�ڻ������ڵ� ID=ASSET_CLS_CODE Align=Center Width=90 
											</FC> 
											<FC> Name=�ڻ������� ID=ASSET_CLS_NAME Width=100
											</FC> 
											<C> Name=�����ڵ� ID=ASSET_ACC_CODE Width=80   Align=Center  
											</C> 
											<C> Name=������ ID=ASSET_ACC_NAME Width=150  Align=left  EditStyle=popup
											</C>  
											<C> Name=������ ID=SRVLIFE Width=70 align=center
											</C>
											<C> Name=ó�г�� ID=DISLIFE Width=70 align=center
											</C>
											<C> Name=���ΰ������� ID=VAT_ACC_CODE Width=100 show=false
											</C>
											<C> Name=���ΰ������� ID=VAT_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=�󰢴���װ��� ID=SUM_ACC_CODE Width=100 show=false
											</C>
											<C> Name=�󰢴���װ��� ID=SUM_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=ó���Ͱ��� ID=SELL_PORF_ACC_CODE Width=100 show=false
											</C>
											<C> Name=ó���Ͱ��� ID=SELL_PORF_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=ó�мհ��� ID=SELL_LOSS_ACC_CODE  Width=100 show=false
											</C>
											<C> Name=ó�мհ��� ID=SELL_LOSS_ACC_NAME  Width=120  EditStyle=popup
											</C>
											<C> Name=���Ͱ��� ID=APPR_PROF_ACC_CODE  Width=100 show=false
											</C>
											<C> Name=���Ͱ��� ID=APPR_PROF_ACC_NAME  Width=120  EditStyle=popup
											</C> 
											<C> Name=�򰡼հ��� ID=APPR_LOSS_ACC_CODE Width=100 show=false
											</C>
											<C> Name=�򰡼հ��� ID=APPR_LOSS_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=�ں���������� ID=CAP_EXP_ACC_CODE Width=100 show=false
											</C>
											<C> Name=�ں���������� ID=CAP_EXP_ACC_NAME Width=120  EditStyle=popup
											</C>  
											<C> Name=�ں�������ΰ������� ID=CAP_EXP_VAT_ACC_CODE Width=100 show=false
											</C>
											<C> Name=�ں�������ΰ������� ID=CAP_EXP_VAT_ACC_NAME Width=130  EditStyle=popup
											</C>
											<C> Name=�Ű����� ID=SELL_ACC_CODE Width=100 show=false
											</C>
											<C> Name=�Ű����� ID=SELL_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=�Ű��ΰ������� ID=SELL_VAT_ACC_CODE Width=100 show=false
											</C>
											<C> Name=�Ű��ΰ������� ID=SELL_VAT_ACC_NAME Width=120  EditStyle=popup
											</C>
											<C> Name=������ ID=TRA_ACC_CODE Width=100 show=false
											</C>
											<C> Name=������ ID=TRA_ACC_NAME Width=100  EditStyle=popup
											</C>    
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
								</td>
							</tr>
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
			</table>
		</div>
		<!-- ���콺 Bind ��ü���� ���� //-->
		<!-- ���콺 Bind ��ü���� ���� //-->
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