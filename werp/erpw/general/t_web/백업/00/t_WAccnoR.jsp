<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WAccnoR.jsp(���� ���)
/* 2. ����(�ó�����) : ȭ�������
/* 3. ��  ��  ��  �� : ���� ��� �� ��ȸ
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-29)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WAccnoR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strACCT_CLS = "";
	String strACCT_CLS_NAME = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strBANKCODE = "";
	try
	{
		CITCommon.initPage(request, response, session);
		
		CITData lrArgData = new CITData();
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			//CITData		lrArgData = new CITData();
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
		
		lrArgData = new CITData();		
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'ACCNO_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACCT_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
			strACCT_CLS_NAME = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ���±��� Select ���� -> " + ex.getMessage());
		}		
		lrArgData = new CITData();
		try
		{
			strSql  = " Select	A.BANK_CODE CODE, \n";
			strSql += " 		A.BANK_NAME  NAME\n";
			strSql += " From	T_BANK_CODE A \n";
			strSql += " Order By  A.BANK_NAME \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strBANKCODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
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
		<object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id=dsBANK_MAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id=dsBANK_CODE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
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
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class="font_green_bold" >�����</td>
											<td width="52">
												<input id="txtCOMP_CODE_S" type="text" style="width:50px" onblur="txtCOMP_CODE_S_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME_S" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="100">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >���ົ��</td>
											<td width="200">
												<OBJECT id="cboBANK_MAIN_CODE"  style="width:150" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT >
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="ComboDataID" VALUE="dsBANK_MAIN">
													<PARAM NAME="EditExprFormat" VALUE="%;BANK_MAIN_NAME">
													<PARAM name="ListExprFormat" value="%;BANK_MAIN_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="0">
													<PARAM NAME="SearchColumn" VALUE="BANK_MAIN_NAME">
											    </OBJECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >��������</td>
											<td width="*">
												<OBJECT id="cboBANK_CODE"  style="width:150" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT >
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="ComboDataID" VALUE="dsBANK_CODE">
													<PARAM NAME="EditExprFormat" VALUE="%;BANK_NAME">
													<PARAM name="ListExprFormat" value="%;BANK_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="0">
													<PARAM NAME="SearchColumn" VALUE="BANK_NAME">
											    </OBJECT>
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
											<td class="font_green_bold"> ���� ���</td>
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
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="*" height="100%">
												<OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="Format" VALUE=" 
														<FC> Name=���¹�ȣ ID=ACCNO Width=135 Edit=none
														</FC> 
														<FC> Name=���¸� ID=ACCT_NAME Width=115 Edit=none
														</FC> 
														<C> Name=���±��� ID=ACCT_CLS Align=Center Width=60 Edit=none EditStyle=Combo	Data='<%=strACCT_CLS_NAME%>'
														</C> 
														<C> Name=����� ID=BANK_NAME Width=115 Edit=none
														</C> 
														<C> Name=�о��� ID=HSMS_USE_CLS Align=Center Width=55  Edit=none Editstyle=checkbox
														</C> 
														<C> Name=��뱸�� ID=USE_CLS Align=Center Width=55  Edit=none Editstyle=checkbox
														</C> 
														">
												</OBJECT>
												&nbsp;
											</td>
											<td width="15">&nbsp;</td>
											<td width="400" height="100%" valign="top" onActivate="G_focusDataset(dsMAIN)">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="30"><img src="../images/bullet2.gif"></td>
														<td class="font_green_bold"> ���γ���</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���¹�ȣ</td>
														<td width="*"><input id="txtACCNO" type="text" style="width:130px" datatype="N" MaxLength="20" notnull></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���¸�</td>
														<td width="*"><input id="txtACCT_NAME" type="text" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">������</td>
														<td width="*"><input id="txtACC_OWNER" type="text" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��������</td>
														<td width="*">
															<select  id="cboBANK_CODE2"  >
																<%=strBANKCODE%>
															</select>
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���±���</td>
														<td width="*"><select id="cboACCT_CLS" style="WIDTH: 80px" class="input_listbox_default"><%=strACCT_CLS%></select></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���ް��¿���</td>
														<td width="*"><input id="chkPAY_ACCNO_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'PAY_ACCNO_CLS') = this.checked ? 'T' : 'F'"></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���°��¿���</td>
														<td width="*"><input id="chkCHK_ACCNO_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'CHK_ACCNO_CLS') = this.checked ? 'T' : 'F'"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���������ѵ���</td>
														<td width="*"><input id="txtCHK_MAX_AMT" type="text" datatype="currency" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�������</td>
														<td width="72"><input id="txtCONT_DT" type="text" datatype="date" style="width:70px"></td>
														<td width="*"><input id="btnCONT_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnCONT_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��������</td>
														<td width="72"><input id="txtEXPR_DT" type="text" datatype="date" style="width:70px"></td>
														<td width="*"><input id="btnEXPR_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnEXPR_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���游������</td>
														<td width="72"><input id="txtEXPR_CHG_DT" type="text" datatype="date" style="width:70px"></td>
														<td width="*"><input id="btnEXPR_CHG_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnEXPR_CHG_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�ߵ��ؾ���</td>
														<td width="72"><input id="txtMIDD_CANCEL_DT" type="text" Datatype="date" style="width:70px"></td>
														<td width="*"><input id="btnMIDD_CANCEL_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnMIDD_CANCEL_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">����</td>
														<td width="*"><input id="txtORG_AMT" type="text" datatype="currency" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">������ݾ�</td>
														<td width="*"><input id="txtEXPR_AMT" type="text" datatype="currency" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�����ڱݾ�</td>
														<td width="*"><input id="txtMONTH_INTR_AMT" type="text" datatype="currency" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">����</td>
														<td width="*"><input id="txtINTR_RATE" type="text" datatype="dotcurrency" style="width:50px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">ȸ����Աݾ�</td>
														<td width="*"><input id="txtPAYMENT_SEQ_AMT" type="text" datatype="currency" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">ȸ���������</td>
														<td width="*"><input id="txtPAYMENT_SEQ_DAY" type="text" datatype="N" style="width:30px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�ͼӺμ�</td>
														<td width="77">
															<input id="txtDEPT_CODE_H" type="hidden">
															<input id="txtDEPT_CODE" type="text" style="width:75px" onblur="txtDEPT_CODE_onblur()" onfocus="txtDEPT_CODE_H.value = txtDEPT_CODE.value">
														</td>
														<td width="182"><input id="txtDEPT_NAME" type="text" class="ro" readonly style="width:180px" tabindex="-1"></td>
														<td width="*"><input id="btnDEPT_CODE" type="button" class="img_btnFind_S" title="�μ��ڵ�ã��" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�����ڵ�</td>
														<td width="77">
															<input id="txtACC_CODE_H" type="hidden">
															<input id="txtACC_CODE" type="text" style="width:75px" onblur="txtACC_CODE_onblur()"  onfocus="txtACC_CODE_H.value = txtACC_CODE.value">
														</td>
														<td width="182"><input id="txtACC_NAME" type="text" class="ro" readonly style="width:180px" tabindex="-1"></td>
														<td width="*"><input id="btnACC_CODE" type="button" class="img_btnFind_S" title="�����ڵ�ã��" onclick="btnACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���ڰ����ڵ�</td>
														<td width="77">
															<input id="txtITR_ACC_CODE_H" type="hidden">
															<input id="txtITR_ACC_CODE" type="text" style="width:75px" onblur="txtITR_ACC_CODE_onblur()"  onfocus="txtITR_ACC_CODE_H.value = txtITR_ACC_CODE.value">
														</td>
														<td width="182"><input id="txtITR_ACC_NAME" type="text" class="ro" readonly style="width:180px" tabindex="-1"></td>
														<td width="*"><input id="btnITR_ACC_CODE" type="button" class="img_btnFind_S" title="�����ڵ�ã��" onclick="btnITR_ACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�о��뿩��</td>
														<td width="*"><input id="chkHSMS_USE_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'HSMS_USE_CLS') = this.checked ? 'T' : 'F'"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��뱸��</td>
														<td width="*"><input id="chkUSE_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'USE_CLS') = this.checked ? 'T' : 'F'"></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">������� �����</td>
														<td width="*"><input id="chkVIRTUAL_ACCOUNT_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'VIRTUAL_ACCOUNT_CLS') = this.checked ? 'T' : 'F'"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">FBS���¿���</td>
														<td width="*"><input id="chkFBS_ACCOUNT_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'FBS_ACCOUNT_CLS') = this.checked ? 'T' : 'F'"></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">FBS��ü���ɿ���</td>
														<td width="*"><input id="chkFBS_TRANSFER_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'FBS_TRANSFER_CLS') = this.checked ? 'T' : 'F'"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�ܾ׸�ǥ����</td>
														<td width="*"><input id="txtFBS_DISPLAY_ORDER" type="text" datatype="currency" style="width:100px" MaxLength="5"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">���</td>
														<td width="*"><textarea id="txtREMARKS" style="width:290; height:80" wrap="off"></textarea></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
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
		<OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" VALUE="dsMAIN">
			<PARAM NAME="BindInfo" VALUE="
				<C> Col=ACCNO 					Ctrl=txtACCNO 				Param=value</C>
				<C> Col=ACCT_NAME 				Ctrl=txtACCT_NAME 			Param=value</C>
				<C> Col=ACC_OWNER 				Ctrl=txtACC_OWNER 			Param=value</C>
				<C> Col=ACCT_CLS 				Ctrl=cboACCT_CLS	 		Param=value</C>
				<C> Col=PAY_ACCNO_CLS			Ctrl=chkPAY_ACCNO_CLS		Param=checked</C>
				<C> Col=CHK_ACCNO_CLS			Ctrl=chkCHK_ACCNO_CLS		Param=checked</C>
				<C> Col=CHK_MAX_AMT 			Ctrl=txtCHK_MAX_AMT 		Param=value</C>
				<C> Col=CONT_DT	 				Ctrl=txtCONT_DT	 			Param=value</C>
				<C> Col=EXPR_DT	 				Ctrl=txtEXPR_DT	 			Param=value</C>
				<C> Col=EXPR_CHG_DT 			Ctrl=txtEXPR_CHG_DT 		Param=value</C>
				<C> Col=MIDD_CANCEL_DT 			Ctrl=txtMIDD_CANCEL_DT 		Param=value</C>
				<C> Col=ORG_AMT 				Ctrl=txtORG_AMT 			Param=value</C>
				<C> Col=EXPR_AMT 				Ctrl=txtEXPR_AMT 			Param=value</C>
				<C> Col=MONTH_INTR_AMT 			Ctrl=txtMONTH_INTR_AMT 		Param=value</C>
				<C> Col=INTR_RATE 				Ctrl=txtINTR_RATE 			Param=value</C>
				<C> Col=PAYMENT_SEQ_AMT 		Ctrl=txtPAYMENT_SEQ_AMT 	Param=value</C>
				<C> Col=PAYMENT_SEQ_DAY 		Ctrl=txtPAYMENT_SEQ_DAY 	Param=value</C>
				<C> Col=DEPT_CODE 				Ctrl=txtDEPT_CODE 			Param=value</C>
				<C> Col=DEPT_NAME 				Ctrl=txtDEPT_NAME 			Param=value</C>
				<C> Col=ACC_CODE 				Ctrl=txtACC_CODE 			Param=value</C>
				<C> Col=ACC_NAME 				Ctrl=txtACC_NAME 			Param=value</C>
				<C> Col=ITR_ACC_CODE 			Ctrl=txtITR_ACC_CODE 		Param=value</C>
				<C> Col=ITR_ACC_NAME 			Ctrl=txtITR_ACC_NAME 		Param=value</C>
				<C> Col=HSMS_USE_CLS 			Ctrl=chkHSMS_USE_CLS 		Param=checked</C>
				<C> Col=REMARKS 				Ctrl=txtREMARKS 			Param=value</C>
				<C> Col=USE_CLS 				Ctrl=chkUSE_CLS 			Param=checked</C>
				<C> Col=FBS_ACCOUNT_CLS			Ctrl=chkFBS_ACCOUNT_CLS 	Param=checked</C>
				<C> Col=FBS_TRANSFER_CLS		Ctrl=chkFBS_TRANSFER_CLS	Param=checked</C>
				<C> Col=VIRTUAL_ACCOUNT_CLS		Ctrl=chkVIRTUAL_ACCOUNT_CLS	Param=checked</C>
				<C> Col=FBS_DISPLAY_ORDER		Ctrl=txtFBS_DISPLAY_ORDER 	Param=value</C>
				<C> Col=BANK_CODE				Ctrl=cboBANK_CODE2 	Param=value</C>
			">
		</OBJECT>
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