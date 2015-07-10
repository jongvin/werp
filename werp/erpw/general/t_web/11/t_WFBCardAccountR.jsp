<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBCardAccountR.jsp(����ī��������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ����ī��������
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WFBCardAccountR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCombo = "";
	String strDTF = "";

	String strCOMP_CODE = "";
	String strCOMP_NAME = "";
	String strDEPT_CODE = "";
	String strEMP_NO = "";
	String strNAME = "";
	String strDt_Trans = CITDate.getNow("yyyyMMdd");
	String strDate = CITDate.getNow("yyyy-MM-dd");

	String strDEPT_NAME = "";
	
	String strCHARGE_PERS = "";
	String strCHARGE_PERS_NAME = "";

	String strINOUT_DEPT_CODE = "";
	String strINOUT_DEPT_NAME = "";

	String strSLIP_TRANS_CLS = "";
	String strDEPT_CHG_CLS = "";

	String strWORK_CODE = "FBS_000002";


	//�����
	strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
	strNAME = CITCommon.NvlString(session.getAttribute("name"));

	try
	{
		CITCommon.initPage(request, response, session);
		CITData	lrArgData = new CITData();
		try
		{
			lrArgData.addColumn("EMP_NO",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMP_NO", strEMP_NO);
		
			strSql =
				"Select Distinct"+"\n"+
				"	a.CARDNUMBER CODE,"+"\n"+
				"	a.CARDNUMBER||' '||b.NAME NAME"+"\n"+
				"From	T_CARD_MEMBER_HISTORY a ,"+"\n"+
				"     Z_AUTHORITY_USER      b  "+"\n"+
				"Where	a.CARDOWNEREMPNO  = b.EMPNO "+"\n"+
				"And    To_Char(Sysdate,'YYYYMMDD') Between a.USESTARTDATE And a.USEENDDATE"+"\n"+
				"And		? In ( a.CARDOWNEREMPNO,a.CARDSUBSTITUTEEMPNO)"+"\n";
				
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
				"Select"+"\n"+
				"	to_char(sysdate ,'yyyy')||'-'||to_char(sysdate ,'MM') DTF "+"\n"+
				"From	Dual "+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDTF = lrReturnData.toString(0,"DTF");
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

	//����� ����
	strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
	strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
	strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
	
	//����
	strSLIP_TRANS_CLS = CITCommon.NvlString(session.getAttribute("slip_trans_cls"));
	strDEPT_CHG_CLS = CITCommon.NvlString(session.getAttribute("dept_chg_cls"));
	try
	{
		CITData		lrArgData = new CITData();
		lrArgData.addColumn("WORK_CODE",CITData.VARCHAR2);
		lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
		lrArgData.addRow();
		lrArgData.setValue("WORK_CODE", strWORK_CODE);
		lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
		
		strSql  = " Select	a.COMP_CODE, \n";
		strSql += " 		b.COMPANY_NAME, \n";
		strSql += " 		b.DEPT_CODE INOUT_DEPT_CODE , \n";
		strSql += " 		c.DEPT_NAME INOUT_DEPT_NAME , \n";
		strSql += " 		a.TAX_COMP_CODE TAX_COMP_CODE, \n";
		strSql += " 		d.COMPANY_NAME TAX_COMP_NAME, \n";
		strSql += " 		e.CHARGE_PERS , \n";
		strSql += " 		e.CHARGE_PERS_NAME \n";
		strSql += " From	T_DEPT_CODE a, \n";
		strSql += " 		T_COMPANY b, \n";
		strSql += " 		T_DEPT_CODE c, \n";
		strSql += " 		T_COMPANY d, \n";
		strSql += " ( \n";
		strSql += " 	SELECT \n";
		strSql += " 		A.COMP_CODE, \n";
		strSql += " 		A.CHARGE_PERS, \n";
		strSql += " 		B.NAME CHARGE_PERS_NAME \n";
		strSql += " 	FROM \n";
		strSql += " 		T_WORK_CHARGE_PERS A, \n";
		strSql += " 		Z_AUTHORITY_USER B \n";
		strSql += " 	WHERE \n";
		strSql += " 		A.CHARGE_PERS = B.EMPNO \n";
		strSql += " 		AND A.WORK_CODE = :WORK_CODE \n";
		strSql += " ) e \n";
		strSql += " Where	a.DEPT_CODE =  ?   \n";
		strSql += " And		a.COMP_CODE = b.COMP_CODE(+) \n";
		strSql += " And		b.DEPT_CODE = c.DEPT_CODE(+) \n";
		strSql += " And		a.TAX_COMP_CODE = d.COMP_CODE(+) \n";
		strSql += " And		a.COMP_CODE = e.COMP_CODE(+) \n";



		lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		if(lrReturnData.getRowsCount() >= 1)
		{
			strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
			strCOMP_NAME = lrReturnData.toString(0,"COMPANY_NAME");
			strINOUT_DEPT_CODE = lrReturnData.toString(0,"INOUT_DEPT_CODE");
			strINOUT_DEPT_NAME = lrReturnData.toString(0,"INOUT_DEPT_NAME");
			strCHARGE_PERS = lrReturnData.toString(0,"CHARGE_PERS");
			strCHARGE_PERS_NAME = lrReturnData.toString(0,"CHARGE_PERS_NAME");

			session.setAttribute("comp_code", strCOMP_CODE);
			session.setAttribute("comp_name", strCOMP_NAME);
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
			var			sCompName = "<%=CITCommon.enSC(strCOMP_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDTF = "<%=strDTF%>";

			var			vWORK_CODE = "<%=strWORK_CODE%>";

			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sDt_Trans = "<%=strDt_Trans%>";
			var			sDate = "<%=strDate%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=strCOMP_NAME%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=strDEPT_NAME%>";
			var			sInout_DeptCode = "<%=strINOUT_DEPT_CODE%>";
			var			sInout_DeptName = "<%=strINOUT_DEPT_NAME%>";
			var			sEmpno = "<%=strEMP_NO%>";
			var			sName = "<%=strNAME%>";
			var			sSlip_Trans_Cls = "<%=strSLIP_TRANS_CLS%>";
			var			sDept_Chg_Cls = "<%=strDEPT_CHG_CLS%>";
			
			var			vWORK_CODE = "<%=strWORK_CODE%>";
			
			var			sCHARGE_PERS = "<%=strCHARGE_PERS%>";
			var			sCHARGE_PERS_NAME = "<%=strCHARGE_PERS_NAME%>";
			// �̺�Ʈ����-------------------------------------------------------------------//

		//-->
		</script>

		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsDAY_CLOSE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsAUTO_FBS_CARD_ACNT_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id=dsACCT_CHK classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	    <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->		
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
											<td width="70" class="font_green_bold" >ī���ȣ</td>
											<td width="240" class="font_green_bold" align="left" >
												<select  name="cboCARDNUMBER"  style="WIDTH: 220px" >
													<%=strCombo%>
												</select>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="70" class="font_green_bold" >��������</td>
											<td width="72">
												<input id="txtDATE_FROM" type="hidden" style="width:70px" datatype="DATEYM" >
												<input id="txtDATE_DISPLAY" type="text" style="width:70px" datatype="date" onchange="txtDATE_DISPLAY_onChange()">
											</td>
											<td width=22>
												<input id="btnDATE_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnDATE_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
                      <td>&nbsp; </td>
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
					<td width="100%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- ���α׷��� ���� ���� //-->
										<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
										<td class="font_green_bold"> ��ǥ��������</td>
										<td align="right">
<input id="btnSlipCreate" type="button" class="img_btn6_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�ڵ���ǥ����" onclick="btnSlipCreate_onClick()"/>
<input id="btnSlipDelete" type="button" class="img_btn6_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�ڵ���ǥ����" onclick="btnSlipDelete_onClick()"/>
										</td>

										<!-- ���α׷��� ���� ���� //-->
									</tr>
								</table>
								<!-- ���� Ÿ��Ʋ ���� //-->
								<!-- ���� ���� ���� //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
												<tr>
													<td bgcolor="#FFFFFF">
													<!-- ���α׷��� ������ ���� //-->
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="70">��ǥ����</td>
																<td width="78">
																	<input id="txtSLIP_MAKE_DT_F"	type="hidden"/>
																	<input id="txtSLIP_MAKE_DT"	type="text" datatype="date" style="width:77px"/>
																</td>
																<td width="21">
																	<input id="btnSLIP_MAKE_DT" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnSLIP_MAKE_DT_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width=27">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >�� �� ��</td>
																<td width="102">
																	<input id="txtSLIP_MAKE_COMP_CODE"	type="hidden"/>
																	<input id="txtSLIP_MAKE_COMP_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
																</td>
																<td width="38">
																	<input name="btnSLIP_MAKE_COMP_CODE"	type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_MAKE_COMP_CODE_onClick()" title="�����ã��" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >�ۼ��μ�</td>
																<td width="122">
																	<input id="txtSLIP_MAKE_DEPT_CODE"	type="hidden"/>
																	<input id="txtSLIP_MAKE_DEPT_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:120px"/>
																</td>
																<td width="40">
																	<input name="btnSLIP_MAKE_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_MAKE_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="�ۼ��μ�ã��" />
																</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="15">&nbsp;</td>
																<td width="70">&nbsp;</td>
																<td width="126">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >�������</td>
																<td width="102">
																	<input id="txtSLIP_CHARGE_PERS"		type="hidden"/>
																	<input id="txtSLIP_CHARGE_PERS_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
																</td>
																<td width="38">
																	<input name="btnCHARGE_PERS" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_CHARGE_PERS_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="�������ã��" />
																</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >�ⳳ�μ�</td>
																<td width="122">
																	<input id="txtSLIP_INOUT_DEPT_CODE"	type="hidden"/>
																	<input id="txtSLIP_INOUT_DEPT_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:120px"/>
																</td>
																<td width="40">
																	<input name="btnSLIP_INOUT_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_INOUT_DEPT_CODE_onClick()" title="�ⳳ�μ�ã��" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="80">���������</td>
																<td width="78">
																	<input id="txtPAYHOPEDATE_F"	type="hidden"/>
																	<input id="txtPAYHOPEDATE"		type="text" datatype="date" style="width:77px"/>
																</td>
																<td width="21">
																	<input id="btnPAYHOPEDATE" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnPAYHOPEDATE_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														<!-- ���α׷��� ������ ���� //-->
													</td>
												</tr>
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
				<tr valign="top">
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> ����ī��û������</td>
														<td align="right" width="*">
<input id="btnBUDG"				type="button" tabindex="-1" class="img_btn6_1" onClick="btnBUDG_onClick()"			value="���������ȸ" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />														
<input name="btnSlipRetrieve" type="button" class="img_btn6_1" onclick="btnSlipRetrieve_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�� ǥ �� ȸ" />
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�� �� �� ��" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�ϰ��������" />
<!--<input id="btnCARD_FINISH"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnCARD_FINISH_onClick()"value="����Ϸ�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />//-->
<!--												<input id="btnCARD_PRINT" 	type="button" tabindex="-1" class="img_btn4_1" onClick="btnCARD_PRINT_onClick()" 	value="���" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />//-->
														</td>
													</tr>
												</table>
									<!-- SUM ���̺� ���� //-->
									<!-- �������� ���̺� ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="5"></td>
										</tr>
									</table>
									<!-- �������� ���̺� ���� //-->	
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line"> 
											<td width="*" height="1"></td>
										</tr>
										<tr> 
											<td width="100%"  style="background:#F6F6F6">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td >
															<!-- ���α׷��� ������ ���� //-->
															<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="black">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >�ѱݾ�</td>
																	<td width="165">
																	<input name="txtTOTAL_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>													
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="84" >��ó���ݾ�</td>
																	<td width="165">
																	<input name="txtNOUSE_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC"  ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >���κ�</td>
																	<td width="165">
																	<input name="txtCOMPANY_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >���κ�</td>
																	<td width="165">
																	<input name="txtPERSON_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
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
									<!-- SUM ���̺� ���� //-->												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
<FC> Name=����	ID=SELECT_YN	Align=Center	EditStyle=CheckBox	Width=30	</FC>
<FC> Name=����	ID=MAKE_CLS		Align=Center	EditStyle=CheckBox	Width=30	Edit='none'	</FC>
<FC> Name=Ȯ��	ID=KEEP_CLS		Align=Center	EditStyle=CheckBox	Width=30	Edit='none'	</FC>
<FC> Name=ī���ȣ 		ID='CARDNUMBER'	Align=Center	Width=100 						</FC>
<FC> Name=������ 		ID='ADJUSTYEARMONTH'	Align=Center	Width=100  show=false	</FC>
<FC> Name=�����Ϸù�ȣ  ID='ACCTSUBSEQ'	Align=Center	Width=160 		 show=false		</FC>
<C> Name='�����Ͻ�' 	ID='USE_DATE_TIME'			Align=Center	 Width=120			</C>
<C> Name='û���ݾ�' 	ID='AMT'			Width=80   									</C>
<C> Name='���ް���' 	ID='SUPPLYAmt'			Width=80   									</C>
<C> Name='�ΰ���' 	  ID='VatAmt'			Width=80   									</C>
<C> Name='�̿�ó' 		ID=MERCHANTNAME		Width=140 									</C>
<C> Name='���������' ID='PAYHOPEDATE'	Align=Center	 Width=70			show=false </C>
<C> Name='ó������' 	ID=USAGEGUBUN		Align=Center	 Width=70 EditStyle=Combo Data='P:���κ�,C:���κ�,1:��ó��'	</C>
<C> Name='�ͼӺμ�' 	ID=DEPT_NAME			Width=160 </C>
<C> Name='������' 	ID=ACC_NAME			Width=160 </C>
<C> Name='�ΰ�������'	ID=VAT_ACC_NAME		Width=160 </C>
<C> Name='���ι�ȣ' 	ID=APPROVALNumber	Width=100   </C>
<C> Name='����' 	    ID=MCCName		Width=100         </C>
<C> Name='��������' 	ID=TAXGubun		Width=70 	</C>
<C> Name=��ǥ��ȣ ID=MAKE_SLIPNO  Align=Center Edit='none'  Width=90</C>													
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
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