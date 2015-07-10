<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFinSecurtyR.jsp(����������Ȳ)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ����������Ȳ��ȸ
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-07)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
	String strDate = CITDate.getNow("yyyy-MM-dd");
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WFinSecurtyR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String	strCombo = "";
	String	strCombo2 = "";
	String	strDfltKindCode = "";
	String	strDTF = "";
	String	strDTT = "";
	String strUserNo = "";
	CITData		lrArgData = null;
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
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
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select "+"\n"+
				"	1 SEQ,"+"\n"+
				"	a.SEC_KIND_CODE CODE,"+"\n"+
				"	a.SEC_KIND_NAME NAME"+"\n"+
				"From	T_FIN_SEC_KIND a"+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	2 SEQ,"+"\n"+
				"	'%' CODE,"+"\n"+
				"	'��ü' NAME"+"\n"+
				"From	Dual"+"\n"+
				"Order By 1,2";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select "+"\n"+
				"	1 SEQ,"+"\n"+
				"	a.SEC_KIND_CODE CODE,"+"\n"+
				"	a.SEC_KIND_NAME NAME"+"\n"+
				"From	T_FIN_SEC_KIND a"+"\n"+
				"Order By 1,2";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo2 = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strDfltKindCode = lrReturnData.toString(0,"CODE");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select"+"\n"+
				"	F_T_DATETOSTRING(Add_Months(Sysdate,-1)) DTF,"+"\n"+
				"	F_T_DATETOSTRING(Sysdate) DTT"+"\n"+
				"From	Dual "+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDTF = lrReturnData.toString(0,"DTF");
			strDTT = lrReturnData.toString(0,"DTT");
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
			var 		oldData1 = "";
			var			oldData2 = "";
			var			vDate = "<%=strDate%>";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDfltCode = "<%=strDfltKindCode%>";
			var			sDTF = "<%=strDTF%>";
			var			sDTT = "<%=strDTT%>";
			var			sEmpNo = "<%=strUserNo%>";

			// �̺�Ʈ����-------------------------------------------------------------------//

		//-->
		</script>

		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsSECU_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsITR_CALC_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id=dsITR_AMT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id=dsREMOVE_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><object id="transREMOVE_SLIP"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsREMOVE_SLIP=dsREMOVE_SLIP)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DVD">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td width="55" class="font_green_bold" >�����</td>
											<td width="72">
												<input id="txtCOMP_CODE" type="text" style="width:70px"  onfocus="txtCOMP_CODE_onfocus()"  onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="*">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>

										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >����</td>
											<td width="290" class="font_green_bold" >
												<select  name="cboSECU_KIND_CODE"  style="WIDTH: 220px" onchange="cboSECU_KIND_CODE_onChange()">
													<%=strCombo%>
												</select>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="72" class="font_green_bold" >
												<select  name="cboDATE_CLS"  style="WIDTH: 70px" onchange="cboDATE_CLS_onChange()">
													<OPTION value="A" SELECTED> ������</OPTION>
													<OPTION value="B"> ������</OPTION>
												</select>
											</td>

											<td width="72">
												<input id="txtDATE_FROM" type="text" style="width:70px"  Datatype="date">
											</td>
											<td width=22>
												<input id="btnDATE_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnDATE_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="20">&nbsp;~&nbsp; </td>
											<td width="72">
												<input id="txtDATE_TO" type="text" style="width:70px"  Datatype="date">
											</td>
											<td width=*>
												<input id="btnDATE_TO" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnDATE_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20">&nbsp;</td>
														<td class="font_green_bold">&nbsp;</td>
														<td align="right" width="*">
															<input id="btnMakeInSlip" type="button" class="img_btn6_1" value="������ǥ����" title="" onclick="btnMakeInSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnShowInSlip" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowInSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRemoveSlip" type="button" class="img_btn6_1" value="������ǥ����" title="" onclick="btnRemoveSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnMakeInItrSlip" type="button" class="img_btn8_1" value="����������ǥ����" title="" onclick="btnMakeInItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnShowInItrSlip" type="button" class="img_btn8_1" value="����������ǥ����" onclick="btnShowInItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRemoveItrSlip" type="button" class="img_btn8_1" value="����������ǥ����" title="" onclick="btnRemoveItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> ����������Ȳ ����</td>
														<td align="right" width="*">
															<input id="btnMakeReturnSlip" type="button" class="img_btn6_1" value="��ȯ��ǥ����" title="" onclick="btnMakeReturnSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnMakeSaleSlip" type="button" class="img_btn6_1" value="�Ű���ǥ����" title="" onclick="btnMakeSaleSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnShowRetSlip" type="button" class="img_btn10_1" value="��ȯ(�Ű�)��ǥ����" onclick="btnShowRetSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRemoveReturnSlip" type="button" class="img_btn10_1" value="��ȯ(�Ű�)��ǥ����" title="" onclick="btnRemoveReturnSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<FC> Name=�������Ǳ��� 		ID=SEC_KIND_CODE	Width=120 EditStyle=Combo Data='<%=strCombo2%>'
														</FC>
														<FC> Name=���ǹ�ȣ 		ID=REAL_SECU_NO		Width=120
														</FC>
														<C> Name='��Ź����' 		ID='CONSIGN_BANK'			Align=Center	 Width=70
														</C>
														<C> Name='�����' 		ID='BANK_NAME'			Width=160
														</C>
														<C> Name=������ 		ID=PUBL_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=������ 		ID=EXPR_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=���Ǳݾ� 		ID=PERSTOCK_AMT		Width=95 SumText=@sum
														</C>
														<C> Name=����� 		ID=GET_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=���ó 		ID=GET_PLACE			 Width=160
														</C>
														<C> Name=���ݾ� 		ID=INCOME_AMT		Width=95 SumText=@sum
														</C>
														<C> Name=�������� 		ID=BF_GET_ITR_AMT	Width=95 SumText=@sum
														</C>
														<C> Name=�������ڹ��μ� 		ID=BF_GET_ITR_TAX	Width=95 SumText=@sum
														</C>
														<C> Name=���� 			ID=INTR_RATE	    Width=80
														</C>
														<C> Name=��ȯ�� 		ID=RETURN_DT		Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=�Ű��� 		ID=SALE_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=�Ű��ݾ� 		ID=SALE_AMT			Width=95 SumText=@sum
														</C>
														<C> Name='��ȯ/�Ű�������' 		ID=SALE_ITR_AMT			Width=95 SumText=@sum
														</C>
														<C> Name=�Ű��ù̼����� 		ID=SALE_NP_ITR_AMT			Width=95 SumText=@sum
														</C>
														<C> Name='��ȯ/�Ű����μ�' 		ID=SALE_TAX			Width=95 SumText=@sum
														</C>
														<C> Name=ó�мս� 		ID=SALE_LOSS			Width=95 SumText=@sum
														</C>
														<C> Name=������ǥ��ȣ 	    ID=MAKE_SLIPNO		Width=120
														</C>
														<C> Name=����������ǥ��ȣ 	    ID=PRE_ITR_SLIPNO		Width=120
														</C>
														<C> Name=��ȯ��ǥ��ȣ 	    ID=RE_MAKE_SLIPNO		Width=120
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
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
							<tr>
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> �������� (�̼�)���� ����</td>
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
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB01">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ViewSummary" VALUE="1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<C> Name=���ڱ��� 		ID=KIND_TAG	Width=120 EditStyle=Combo Data='1:�̼�����,2:���ڼ���'
														</C>
														<C> Name=������ 		ID=CALC_DT_FROM			Align=Center	 Width=90 EditStyle=Popup
														</C>
														<C> Name=����� 		ID=CALC_DT_TO			Align=Center	 Width=90 EditStyle=Popup
														</C>
														<C> Name=�̼����ڱݾ� 		ID=NP_ITR_AMT		Width=100 SumText=@sum
														</C>
														<C> Name=���ڼ��ͱݾ� 		ID=ITR_AMT		Width=100 SumText=@sum
														</C>
														<C> Name=��� 		ID=REMARKS		Width=260
														</C>
														<C> Name=��ǥ��ȣ 		ID=MAKE_SLIPNO		Width=120
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL ������������//-->
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