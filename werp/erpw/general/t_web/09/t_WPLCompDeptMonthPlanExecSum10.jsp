<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : ���α׷� ID(���α׷� �ѱ۸�)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2003-02-01), ��ö�� ����(2003-04-02)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WPLCompDeptMonthPlanExecSum10";
	String strPageName = "t_WPLCompDeptMonthPlanExecSum10";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsCOPY=dsCOPY)";
	
	CITData		lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String strCLSE_ACC_ID = "";
	String strACC_ID = "";
	String strEMP_NO  = "";
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
		strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
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
		//ȸ�� �˻�
		try
		{
			lrArgData = new CITData();
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			
			strSql = 
				"Select"+"\n"+
				"	a.CLSE_ACC_ID ,"+"\n"+
				"	a.ACC_ID"+"\n"+
				"From	T_YEAR_CLOSE a,"+"\n"+
				"		("+"\n"+
				"			Select"+"\n"+
				"				b.COMP_CODE,"+"\n"+
				"				Max(b.CLSE_ACC_ID) CLSE_ACC_ID"+"\n"+
				"			From	T_BUDG_YEAR b"+"\n"+
				"			Where	b.COMP_CODE = ?"+"\n"+
				"			Group By "+"\n"+
				"				b.COMP_CODE"+"\n"+
				"		) b"+"\n"+
				"Where	a.COMP_CODE = b.COMP_CODE"+"\n"+
				"And		a.CLSE_ACC_ID = b.CLSE_ACC_ID"+"\n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			if(lrReturnData.getRowsCount() >= 1)
			{
				strCLSE_ACC_ID = lrReturnData.toString(0,"CLSE_ACC_ID");
				strACC_ID = lrReturnData.toString(0,"ACC_ID");
			}
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		//ȸ�� �˻� ����
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
			var			sClseAccId = "<%=strCLSE_ACC_ID%>";
			var			sAccId = "<%=strACC_ID%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=CITCommon.enSC(strDEPT_NAME)%>";
			var			sEmpNo	   ="<%= strEMP_NO %>";
			// �̺�Ʈ����-------------------------------------------------------------------//
			var 			vMon1 ='';
	  		var 			vMon2 ='';
	  		var 			vMon3 ='';
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id=dsCOPY classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strPageName%>">
			<input type='hidden' name='REQUEST_NAME' value="">
			<Input type='hidden' name='REPORT_NO' value="">
			<Input type='hidden' name='REPORT_FILE_NAME' value="">
			<Input type='hidden' name='PARAMETERS' value="">
		</form>
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
											<td width="45" class=font_green_bold>ȸ��</td>
											<td width="52">
												<input id="txtCLSE_ACC_ID" type="text" style="width:50px" onblur="txtCLSE_ACC_ID_onblur()">
											</td>
											<td width="60">
												<input id="txtACC_ID" type="text" readOnly class="ro" style="width:40px"> ��
											</td>
											<td width="70">
												<input id="btnACC_ID" type="button" class="img_btnFind" value="�˻�" onclick="btnACC_ID_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											
											<td>&nbsp; </td>
										</tr>
										<!--
										<tr>
											
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class=font_green_bold>����</td>
											<td width="52">
												<input id="txtDEPT_CODE" type="text" style="width:50px" onblur="txtDEPT_CODE_onblur()">
											</td>
											<td width="200">
												<input id="txtDEPT_NAME" type="text" readOnly class="ro" style="width:198px">
											</td>
											<td width="70">
												<input id="btnDEPT_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class=font_green_bold>���ؿ�</td>
											<td width="52">
												<select id=cboMONTH width=30>
													<option value=01>1��
													<option value=02>2��
													<option value=03>3��
													<option value=04>4��
													<option value=05>5��
													<option value=06>6��
													<option value=07>7��
													<option value=08>8��
													<option value=09>9��
													<option value=10>10��
													<option value=11>11��
													<option value=12>12��
												</select>
											</td>
											<td>&nbsp; </td>
										</tr>
										-->
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
											<td class="font_green_bold"> �����ܼ���</td>
											<td align="right" width="*">
												<input id="btnPrint" type="button" class="img_btn4_1" value="���" onclick="btnquery_prt_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												
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
									
									<OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=���� ID=biz_plan_item_name Align=Center Width=100 
											</C> 
											<G>name='1��' ID=C1 
												<C> Name=���� ID=exec_amt01 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt01 Width=75
												</C>
												<C> Name=���� ID=forecast_amt01 Width=75 
												</C> 
											</G>
											<G>name='2��' ID=C2 
												<C> Name=���� ID=exec_amt02 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt02 Width=75
												</C>
												<C> Name=���� ID=forecast_amt02 Width=75 
												</C> 
											</G>
											<G>name='3��' ID=C3 
												<C> Name=���� ID=exec_amt03 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt03 Width=75
												</C>
												<C> Name=���� ID=forecast_amt03 Width=75 
												</C> 
											</G>
											<G>name='4��' ID=C4 
												<C> Name=���� ID=exec_amt04 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt04 Width=75
												</C>
												<C> Name=���� ID=forecast_amt04 Width=75 
												</C> 
											</G>
											<G>name='5��' ID=C5 
												<C> Name=���� ID=exec_amt05 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt05 Width=75
												</C>
												<C> Name=���� ID=forecast_amt05 Width=75 
												</C> 
											</G>
											<G>name='6��' ID=C6 
												<C> Name=���� ID=exec_amt06 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt06 Width=75
												</C>
												<C> Name=���� ID=forecast_amt06 Width=75 
												</C> 
											</G>
											<G>name='7��' ID=C7 
												<C> Name=���� ID=exec_amt07 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt07 Width=75
												</C>
												<C> Name=���� ID=forecast_amt07 Width=75 
												</C> 
											</G>
											<G>name='8��' ID=C8 
												<C> Name=���� ID=exec_amt08 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt08 Width=75
												</C>
												<C> Name=���� ID=forecast_amt08 Width=75 
												</C> 
											</G>
											<G>name='9��' ID=C9 
												<C> Name=���� ID=exec_amt09 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt09 Width=75
												</C>
												<C> Name=���� ID=forecast_amt09 Width=75 
												</C> 
											</G>
											<G>name='10��' ID=C10 
												<C> Name=���� ID=exec_amt10 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt10  Width=75
												</C>
												<C> Name=���� ID=forecast_amt10  Width=75 
												</C> 
											</G>
											<G>name='11��' ID=C11 
												<C> Name=���� ID=exec_amt11 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt11 Width=75
												</C>
												<C> Name=���� ID=forecast_amt11 Width=75 
												</C> 
											</G>
											<G>name='12��' ID=C12
												<C> Name=���� ID=exec_amt12 Width=75 
												</C> 
												<C> Name=��ȹ  ID=plan_amt12 Width=75
												</C>
												<C> Name=���� ID=forecast_amt12 Width=75 
												</C> 
											</G>
											">
									</OBJECT>
									
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