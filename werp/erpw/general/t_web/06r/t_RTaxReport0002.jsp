<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_RBudgResultAmtR.jsp(���������ȸ)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���������ȸ 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-1-11)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_RTaxReport0002";
	String strFileName01 = "t_RTaxReport0002";
	String strReportName = "r_t_060004";

//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strDate = CITDate.getNow("yyyy-MM-dd");

	CITData		lrArgData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";

	String cboRCPTBILL_CLS = "";
	String cboSALEBUY_CLS = "";
	String cboSUBTR_CLS = "";
	try
	{
		CITCommon.initPage(request, response, session);
		
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
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

		//��꼭����
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where a.CODE_GROUP_ID = 'RCPTBILL_CLS' \n";
			strSql += "And	a.CODE_LIST_ID IN ('01','02') \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			cboRCPTBILL_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ��ǥ�����ڵ� Select ���� -> " + ex.getMessage());
		}

		//����/����
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SALEBUY_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			cboSALEBUY_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ��ǥ�����ڵ� Select ���� -> " + ex.getMessage());
		}

		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SUBTR_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			cboSUBTR_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ���±����ڵ� Select ���� -> " + ex.getMessage());
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
var	sSelectPageName = "<%=strFileName%>_q.jsp";
var	sReportName = "<%=strReportName%>";
var	sCompCode = "<%=strCOMP_CODE%>";
var	sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
var	sDeptCode = "<%=strDEPT_CODE%>";
var	sDeptName = "<%=CITCommon.enSC(strDEPT_NAME)%>";
var	vDate     = "<%=strDate%>";
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
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strFileName01%>">
			<input type='hidden' name='REQUEST_NAME' value="">
			<Input type='hidden' name='REPORT_NO' value="">
			<Input type='hidden' name='REPORT_FILE_NAME' value="">
			<Input type='hidden' name='PARAMETERS' value="">
		</form>
		<div id="divMainFix" class="main_div" align=center>
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
				<tr valign="top">
					<td height="25">
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
							<tr>
								<td class="td_green">
									<!-- ���α׷��� ������ ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >��±���</td>
											<td width="80">
												<SELECT id="cboExportTag" style="WIDTH: 60px">
													<OPTION VALUE='P' selected>PDF
													<OPTION VALUE='E'>EXCEL
													<OPTION VALUE='W'>WORD
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >���౸��</td>
											<td width="100">
												<SELECT id="cboRunTag" style="WIDTH: 80px">
													<OPTION VALUE='1' selected>�ٷν���
													<OPTION VALUE='2'>��û
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class="font_green_bold" >��û��</td>
											<td width="*"><input id="txtRequestName" type="text" style="width:220px"></td>
										</tr>
									</table>
									<!-- ���α׷��� ������ ���� //-->
								</td>
							</tr>
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
						</table>
					</tr>
				</tr>
				<tr>
					<td align="Center">
						<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
							<tr valign="middle"> 
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="80"></td>
											<td width="100%">
												<!-- ���α׷��� ������ ���� //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>���������</td>
		<td width="72">
			<input id="txtTAX_COMP_CODE_F" type="hidden">
			<input id="txtTAX_COMP_CODE" type="text" style="width:70px" onblur="txtTAX_COMP_CODE_onblur()" onfocus="txtTAX_COMP_CODE_F.value = txtTAX_COMP_CODE.value">
		</td>
		<td width="161">
			<input id="txtTAX_COMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="40">
			<input id="btnTAX_COMP_CODE" type="button" class="img_btnFind" value="ã��" onclick="btnTAX_COMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >����/����</td>
		<td width="60">
			<select id="cboSALEBUY_CLS" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default">
			<option value='%'>��  ü</option>
			<%=cboSALEBUY_CLS%>
			</select>
		</td>
		<td width="10">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >��꼭����</td>
		<td width="130">
			<select id="cboRCPTBILL_CLS" style="WIDTH: 130px" tabindex="-1" class="input_listbox_default">\
			<option value='%'>��  ü</option>
			<%=cboRCPTBILL_CLS%>
			</select>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>�����</td>
		<td width="72">
			<input id="txtCOMP_CODE_F" type="hidden">
			<input id="txtCOMP_CODE" type="text" style="width:70px" onblur="txtCOMP_CODE_onblur()" onfocus="txtCOMP_CODE_F.value = txtCOMP_CODE.value">
		</td>
		<td width="161">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="40">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="ã��" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >��������</td>
		<td width="60">
			<select id="cboSUBTR_CLS" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default">
			<option value='%'>��  ü</option>
			<%=cboSUBTR_CLS%>
			</select>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�ͼӺμ�</td>

		<td width="72">
			<input id="txtDEPT_CODE_F" type="hidden">
			<input id="txtDEPT_CODE" 	type="text" style="width:70px" onblur="txtDEPT_CODE_onblur()" onfocus="txtDEPT_CODE_F.value = txtDEPT_CODE.value"></td>
		<td width="161">
			<input id="txtDEPT_NAME" type="text" readOnly left class="ro" style="width:159px">
		</td>
		<td width="40">
			<input id="btnDEPT_CODE" type="button" class="img_btnFind" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >
			��ǥ����
		</td>
		<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70"  class="font_green_bold" >�ΰ����ڵ�</td>
		<td width="72">
			<input id="txtVAT_CODE_F" type="hidden">
			<input name="txtVAT_CODE" 	type="text" datatype="han" style="width:70px" 	VALUE="" onblur="txtVAT_CODE_onblur()" onfocus="txtVAT_CODE_F.value = txtVAT_CODE.value">
		</td>
		<td width="162"> <input name="txtVAT_NAME"	type="text" class="ro" readOnly style="width:160px"	VALUE=""></td>
		<td width="40">
			<input id="btnVAT_CODE" type="button" class="img_btnFind" onclick="btnVAT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�ŷ�ó</td>
		<td width="112">
			<input id="txtCUST_CODE_F" type="hidden">
			<input name="txtCUST_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtCUST_CODE_onblur()" onfocus="txtCUST_CODE_F.value = txtCUST_CODE.value"></td>
		<td width="161"> <input name="txtCUST_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnCUST_CODE" type="button" class="img_btnFind" onclick="btnCUST_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�ΰ�������</td>
		<td width="72">
			<input id="txtACC_CODE_F" type="hidden">
			<input name="txtACC_CODE" type="text" datatype="han" style="width:70px" VALUE="" onblur="txtACC_CODE_onblur()" onfocus="txtACC_CODE_F.value = txtACC_CODE.value"></td>
		<td width="162"> <input name="txtACC_NAME" type="text" class="ro" readOnly style="width:160px" VALUE=""></td>
		<td width="40">
			<input name="btnACC_CODE" type="button" class="img_btnFind" onclick="btnACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
												<!-- ���α׷��� ������ ���� //-->
											</td>
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
						</table>
					</td>
				</tr>
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