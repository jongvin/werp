<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFinProcessPay3R.jsp(������ް����ŷ�ó����)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-16) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFinProcessPay3R";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsMAKE_SLIP=dsMAKE_SLIP,O:dsMAKE_SLIP_RET=dsMAKE_SLIP_RET)";

	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String	strACCNO = "";	
	String	strACCNO_G = "";
	String	strCombo = "";
	String	strCombo2 = "";
	CITData		lrArgData = null;
	String 		strDT_F;
	String 		strDT_T;
	String		strUserNo = "";
	String		strNAME = "";
	String	strBANK_MAIN_CODE = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strNAME = CITCommon.NvlString(session.getAttribute("name"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));

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
				"Select"+"\n"+
				"	a.ACC_KIND_CODE CODE,"+"\n"+
				"	a.ACC_KIND_NAME NAME,"+"\n"+
				"	2 GRP"+"\n"+
				"From	T_FIN_PAY_SUM_ACC_GROUP a"+"\n"+
				"Where	a.PAY_TAR_TAG = '1' "+"\n"+
				"Order By"+"\n"+
				"	3,1";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		//����� ���� ����
		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select"+"\n"+
				"	a.ACCNO CODE,"+"\n"+
				"	d.ACC_NAME||'-'||b.BANK_NAME||'('||a.ACCNO||')' NAME"+"\n"+
				"From	T_ACCNO_CODE a,"+"\n"+
				"		T_BANK_CODE b,"+"\n"+
				"		T_BANK_MAIN c,"+"\n"+
				"		T_ACC_CODE d"+"\n"+
				"Where	a.BANK_CODE = b.BANK_CODE"+"\n"+
				"And		b.BANK_MAIN_CODE = c.BANK_MAIN_CODE"+"\n"+
				"And		a.ACC_CODE = d.ACC_CODE"+"\n"+
				"And		a.PAY_ACCNO_CLS = 'T'"+"\n"+
				"Order By"+"\n"+
				"	a.ACC_CODE,"+"\n"+
				"	c.BANK_MAIN_CODE,"+"\n"+
				"	a.ACCNO"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strACCNO_G = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strACCNO = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
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
				"	a.CODE_LIST_ID CODE,"+"\n"+
				"	a.CODE_LIST_NAME NAME"+"\n"+
				"From	V_T_CODE_LIST a"+"\n"+
				"Where	a.CODE_GROUP_ID = 'OUT_KIND_TG'"+"\n"+
				"And		a.USE_TAG = 'T'"+"\n"+
				"Order By"+"\n"+
				"	a.SEQ";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo2 = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select F_T_DATETOSTRING(Sysdate) DT_T,F_T_DATETOSTRING(Add_Months(Sysdate,-1)) DT_F From Dual ";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDT_F = lrReturnData.toString(0,"DT_F");
			strDT_T = lrReturnData.toString(0,"DT_T");
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
				"	a.BANK_MAIN_CODE CODE,"+"\n"+
				"	a.BANK_MAIN_SHORT_NAME NAME"+"\n"+
				"From	T_BANK_MAIN a"+"\n"+
				"Order By"+"\n"+
				"	a.BANK_MAIN_CODE"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strBANK_MAIN_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
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
			var			sDate = "<%=strDate%>";
			var			sEmpNo = "<%=strUserNo%>";
			var			sName = "<%=CITCommon.enSC(strNAME)%>";

		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="1:MASKED_CUST_CODE:CUST_NAME ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsIN_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__117"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_SLIP_RET classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__117); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
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
														<td  width="50"> ��������</td>
														<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDT_T%>"/></td>
														<td width="30">
															<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="55"  >���� : </td>
														<td width="122" class="font_green_bold" >
															<select  name="cboSUM_ACC_GROUP"  style="WIDTH: 120px" >
																<%=strCombo%>
															</select>
														</td>
														<td>&nbsp; </td>
													</tr>
												</table>
												<!-- ���α׷��� ������ ���� //-->
											</td>
										</tr>
										<tr>
											<td class=td_green>
												<!-- ���α׷��� ������ ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="96" class=font_green_bold>����������</td>
														<td width="52">
															<select  name="cboACCNO1"  >
																<%=strACCNO%>
															</select>
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
											<td class="font_green_bold"> �����</td>
											<td align="right" width="*">
												�����������&nbsp;
												<input id="txtDT_APPLY" type="text" datatype="date" style="width:70px" value = "<%=strDT_T%>"/>
												<input id="btnDT_APPLY" type="button" class="img_btnCalendar_S" onClick="btnDT_APPLY_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
												<input id="btnSelectDt" type="button" class="img_btn6_1" value="�� �͸� ����" onclick="btnSelectDt_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												&nbsp;
												<input id="btnSelectAll1" type="button" class="img_btn4_1" value="���μ���" onclick="btnSelectAll1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnDeSelectAll1" type="button" class="img_btn4_1" value="�������" onclick="btnDeSelectAll1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												&nbsp;
												<input id="btnShowListSlip" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnShowListSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE="
											<FC> Name='����' ID=CHK_TAG Align=Center Width=40 EditStyle=CheckBox 	
											</FC> 
											<FC> Name='����ڹ�ȣ' ID=MASKED_CUST_CODE Align=Center Width=80 Color={Decode(MAKE_SLIPNO,'','red','black')}	suppress=1
											</FC> 
											<FC> Name=�ŷ�ó�� ID=CUST_NAME Width=120 Color={Decode(MAKE_SLIPNO,'','red','black')}	suppress=1
											</FC> 
											<C> Name=��꼭���� ID=MNG_ITEM_DT1 Width=90 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=ä���ܾ� ID=REMAIN_AMT Width=100 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=�������� ID=B_RATIO align=right Width=60 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=���ݺ��� ID=C_RATIO align=right Width=60 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=���ޱݾ� ID=EXEC_AMT Width=100 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=��������� ID=ANTICIPATION_DT Width=90 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=��ǥ��ȣ ID=MAKE_SLIPNO Width=100 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=�����ڵ� ID=ACC_CODE Width=100 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=������ ID=ACC_NAME Width=160 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name='����������' ID=OUT_ACC_NO Width=320 EditStyle=Combo Data='<%=strACCNO_G%>' Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=�Աݰ��� ID=IN_ACC_NO Width=160 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=�Ա����� ID=IN_BANK_MAIN_CODE Width=80 EditStyle=Combo Data='<%=strBANK_MAIN_CODE%>' Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											<C> Name=������ ID=ACCNO_OWNER Width=90 Color={Decode(MAKE_SLIPNO,'','red','black')}
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
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