<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WReqPaySummationR(��ü����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-18)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WReqPaySummationR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDate = CITDate.getNow("yyyy-MM-dd");
	
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
			CITData		lrArgData = new CITData();
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				strSql = " select a.COMP_CODE,b.COMPANY_NAME from t_dept_code a,t_company b where a.DEPT_CODE = ? and a.COMP_CODE = b.COMP_CODE (+) ";

				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
					strCOMPANY_NAME = lrReturnData.toString(0,"COMPANY_NAME");
	
					session.setAttribute("comp_code", strCOMP_CODE);
					session.setAttribute("comp_name", strCOMPANY_NAME);
				}
				
			}
			catch (Exception ex)
			{
				throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
			}
		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//����� ���� ����
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
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";

		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsBATCH classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsSEND classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id="transBatch"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsBATCH=dsBATCH)">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id="transSEND"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsSEND=dsSEND)">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr  valign="center"> 
					<td height="100%" width="100%" align="center">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- ���� ���̺� ���� //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class=td_green>
												<!-- ���α׷��� ������ ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="45" class=font_green_bold>�����</td>
														<td width="52">
															<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
														</td>
														<td width="150">
															<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
														</td>
														<td width="70">
															<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>���¹�ȣ</td>
														<td width="181">
															<input id="txtBANK_CODE" 	type="hidden"/>
															<input id="txtACCNO_CODE" 		type="text" style="width:179px" onblur="txtACCNO_CODE_onblur()" />
														</td>
														<td width="124"><input id="txtBANK_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:179px"/></td>
														<td width="*">
															<input id="btnACCNO_CODE" type="button" class="img_btnFind_S" onClick="btnACCNO_CODE_onClick()" title="���¹�ȣã��" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														<td>&nbsp; </td>
													</tr>
												</table>
												<!-- ���α׷��� ������ ���� //-->
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
						</table>
						<!-- ���� ���̺� ���� //-->
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center">
									<table width="400" height="300" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">�����Ƿ��ѰǼ�</td>
														<td width="150">
															<input id="txtP_DA_REQ_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">Ÿ�����Ƿ��ѰǼ�</td>
														<td width="150">
															<input id="txtP_TA_REQ_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
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
														<td width="120">�����Ƿ��ѱݾ�</td>
														<td width="150">
															<input id="txtP_DA_REQ_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">Ÿ���Ƿ��ѱݾ�</td>
														<td width="150">
															<input id="txtP_TA_REQ_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
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
														<td width="120">��������Ǽ�</td>
														<td width="150">
															<input id="txtP_DA_SUCCESS_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">Ÿ������Ǽ�</td>
														<td width="150">
															<input id="txtP_TA_SUCCESS_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
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
														<td width="120">��������ݾ�</td>
														<td width="150">
															<input id="txtP_DA_SUCCESS_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">Ÿ������ݾ�</td>
														<td width="150">
															<input id="txtP_TA_SUCCESS_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
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
														<td width="120">����ҴɰǼ�</td>
														<td width="150">
															<input id="txtP_DA_FAIL_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">Ÿ��ҴɰǼ�</td>
														<td width="150">
															<input id="txtP_TA_FAIL_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
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
														<td width="120">����Ҵɱݾ�</td>
														<td width="150">
															<input id="txtP_DA_FAIL_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">Ÿ��Ҵɱݾ�</td>
														<td width="150">
															<input id="txtP_TA_FAIL_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
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
														<td width="120">���������</td>
														<td width="150">
															<input id="txtP_DA_COMMISSION" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">Ÿ�������</td>
														<td width="150">
															<input id="txtP_TA_COMMISSION" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="left">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">������</td>
														<td width="150">
															<input id="txtP_RESP_MSG" type="text" datatype="HNC"  readonly style="width:412px">
														</td>
														<td width="*">
															&nbsp;
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<TD width="*" align="center">
												<input id="btnGetData" type="button" class="img_btn6_1" value="��ü����"  onclick="btnGetData_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</TD>
										</tr>
										<tr>
											<TD width="*" align="center">
												�ִ� 1�а� ������ �� �ֽ��ϴ�.
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<!-- ���콺 Bind ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" 		VALUE="dsMAIN">
			<PARAM NAME="BindInfo"	VALUE="
				<C> Col=P_DA_REQ_CNT 				Ctrl=txtP_DA_REQ_CNT 				Param=value</C>
				<C> Col=P_DA_REQ_AMT 				Ctrl=txtP_DA_REQ_AMT 				Param=value</C>
				<C> Col=P_DA_SUCCESS_CNT 			Ctrl=txtP_DA_SUCCESS_CNT 				Param=value</C>
				<C> Col=P_DA_SUCCESS_AMT 			Ctrl=txtP_DA_SUCCESS_AMT 				Param=value</C>
				<C> Col=P_DA_FAIL_CNT 				Ctrl=txtP_DA_FAIL_CNT 				Param=value</C>
				<C> Col=P_DA_FAIL_AMT 				Ctrl=txtP_DA_FAIL_AMT 				Param=value</C>
				<C> Col=P_DA_COMMISSION 			Ctrl=txtP_DA_COMMISSION 				Param=value</C>
				<C> Col=P_TA_REQ_CNT 				Ctrl=txtP_TA_REQ_CNT 				Param=value</C>
				<C> Col=P_TA_REQ_AMT 				Ctrl=txtP_TA_REQ_AMT 				Param=value</C>
				<C> Col=P_TA_SUCCESS_CNT 			Ctrl=txtP_TA_SUCCESS_CNT 				Param=value</C>
				<C> Col=P_TA_SUCCESS_AMT 			Ctrl=txtP_TA_SUCCESS_AMT 				Param=value</C>
				<C> Col=P_TA_FAIL_CNT 				Ctrl=txtP_TA_FAIL_CNT 				Param=value</C>
				<C> Col=P_TA_FAIL_AMT 				Ctrl=txtP_TA_FAIL_AMT 				Param=value</C>
				<C> Col=P_TA_COMMISSION 			Ctrl=txtP_TA_COMMISSION 				Param=value</C>
				<C> Col=P_RESP_MSG 					Ctrl=txtP_RESP_MSG 				Param=value</C>
			">
		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
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
