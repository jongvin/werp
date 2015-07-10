<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBCashTransferR.jsp(������ü���)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-14)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFBCashTransferR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strTRANSFER_STATUS = "";
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

	String strWORK_CODE = "FBS_000001";

	try
	{
		CITCommon.initPage(request, response, session);
		CITData lrArgData = new CITData();
		
		try
		{				
			//��ü����
			strSql  = 
				"select "+"\n"+
				"	2 GB,"+"\n"+
				"	DECODE(a.LOOKUP_CODE ,'I',1,'S',2,3) SORT,"+"\n"+
				"	a.LOOKUP_CODE  CODE, "+"\n"+
				"	a.LOOKUP_VALUE NAME  "+"\n"+
				"from	T_FB_LOOKUP_VALUES a "+"\n"+
				"where lookup_type = upper('FUND_TRANSFER_STATUS')"+"\n"+
				"and   use_yn      = 'Y'"+"\n"+
				"and   LOOKUP_CODE IN ('C','F','I','S') "+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	1,"+"\n"+
				"	1 ,"+"\n"+
				"	'%',"+"\n"+
				"	'��ü'"+"\n"+
				"From	Dual"+"\n"+
				"order by"+"\n"+
				"	1,2"+"\n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strTRANSFER_STATUS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");			

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �������� Select ���� -> " + ex.getMessage());
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

	//�����
	strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
	strNAME = CITCommon.NvlString(session.getAttribute("name"));
	
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
		<title>FBS����</title>
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
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsDAY_CLOSE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsAUTO_FBS_CASH_TRANS_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	    <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
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
														<td width="90" class=font_green_bold>�����</td>
														<td width="250">
														<table width="250" border="0" cellspacing="0" cellpadding="0">
														<td width="31">
														<input name="txtCOMP_CODE" type="text" class="ro" readOnly style="width:30px" VALUE="<%=strCOMP_CODE%>" ></td>
														<td width="155">
														<input name="txtCOMP_NAME" type="text" class="ro" readOnly style="width:155px" VALUE="<%=strCOMP_NAME%>" >
														<input name="txtEMP_NO" type="hidden" class="ro" style="width:30px" VALUE="<%=strEMP_NO%>" >
														<input name="txtMANAGER_PASS1" type="hidden" class="ro" style="width:30px" >
														<input name="txtMANAGER_PASS2" type="hidden" class="ro" style="width:30px" ></td>
														</td>	
														<td>&nbsp; </td>
														</table>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90" class="font_green_bold" >��ü��������</td>													
														<td width="250">
														<table width="250" border="0" cellspacing="0" cellpadding="0">
														<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"></td>
														<td width="30"><input id="btnDTS_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
														<td>&nbsp; </td>
														</table>	
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>��ü����</td>
														<td width="150">
															<select id="txtTRANSFER_STATUS" style="WIDTH: 150px " onchange="btnquery_onclick();">
																<%=strTRANSFER_STATUS%>
															</select>
														</td>														
														<td>&nbsp; </td>			
													</tr>
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90" class=font_green_bold>��ݰ��¹�ȣ</td>
														<td width="250">
														<table width="250" border="0" cellspacing="0" cellpadding="0">
														<td width="130">
														<input name="txtOUTACCOUNT_CODE" type="text" datatype="han"  style="width:128px" VALUE="" onblur="txtOUTACCOUNT_CODE_onblur()"></td>
														<td width="80">
														<input name="txtOUTBANK_NAME" type="text" class="ro" readOnly style="width:78px" VALUE="" >
														<input name="txtOUTBANK_CODE" type="hidden" class="ro" style="width:30px" VALUE="" >
														</td>
													  <td width="40">
														<input name="btnOUTACCOUNT_CODE" type="button" class="img_btnFind" onclick="btnOUTACCOUNT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
														</td>
														<td>&nbsp; </td>
														</table>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90" class=font_green_bold>�Աݰ��¹�ȣ</td>
														<td width="250">
														<table width="250" border="0" cellspacing="0" cellpadding="0">
														<td width="130">
														<input name="txtINACCOUNT_CODE" type="text" datatype="han" style="width:128px" VALUE="" onblur="txtINACCOUNT_CODE_onblur()" ></td>
														<td width="80">
														<input name="txtINBANK_NAME" type="text" class="ro" readOnly style="width:78px" VALUE="" >
														<input name="txtINBANK_CODE" type="hidden" class="ro" style="width:30px" VALUE="" >
														</td>	
														<td width="40">
														<input name="btnINACCOUNT_CODE" type="button" class="img_btnFind" onclick="btnINACCOUNT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
														</td>
														</table>
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
								<!-- ���� Ÿ��Ʋ ���� //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- ���α׷��� ���� ���� //-->
										<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
										<td class="font_green_bold"> ��ǥ��������</td>
										<td align="right">
<input id="btnSlipCreate" type="button" class="img_btn4_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="��ǥ����" onclick="btnSlipCreate_onClick()"/>
<input id="btnSlipDelete" type="button" class="img_btn4_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="��ǥ����" onclick="btnSlipDelete_onClick()"/>
<input id="btnSeq_Create"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnSeq_Create_onClick()"value="��ü����" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
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
																<td width="5">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="80">��ǥ�ۼ�����</td>
																<td width="78">
																	<input id="txtSLIP_MAKE_DT_F"	type="hidden"/>
																	<input id="txtSLIP_MAKE_DT"	type="text" datatype="date" style="width:77px"/>
																</td>
																<td width="21">
																	<input id="btnSLIP_MAKE_DT" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnSLIP_MAKE_DT_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width=27">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >�����</td>
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
																<td width="5">&nbsp;</td>
																<td width="15">&nbsp;</td>
																<td width="60">&nbsp;</td>
																<td width="146">&nbsp;</td>
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
								<!-- ���� ���� ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold">������ü���</td>
											<td align="right" width="*">
<input name="btnSlipRetrieve" type="button" class="img_btn6_1" onclick="btnSlipRetrieve_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�� ǥ �� ȸ" />
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�� �� �� ��" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�ϰ��������" />

											</td>
										</tr>
									</table>									
									<!-- �������� ���̺� ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="5"></td>
										</tr>
									</table>
									<!-- �������� ���̺� ���� //-->	
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE="
<C> Name=seq ID=TRANSFER_SEQ  Align=Center   Edit='none' Width=40  show=false
</C>
<C> Name=���� ID=SELECT_YN  Align=Center   Width=30  EditStyle=CheckBox
</C>
<FC> Name=���� ID=MAKE_CLS Align=Center EditStyle=CheckBox Width=30	Edit='none'
</FC>
<FC> Name=Ȯ�� ID=KEEP_CLS Align=Center EditStyle=CheckBox Width=30	Edit='none'
</FC>
<C> Name=������� ID=OUT_BANK_CODE  Align=Left  Edit='none' Width=100 show=false
</C>
<C> Name=������� ID=OUT_BANK_NAME  Align=Left  Edit='none' Width=100 
</C>
<C> Name=��ݰ��¹�ȣ ID=OUT_ACCOUNT_NO  Align=Left Edit='none'  Width=100
</C>
<C> Name=�Ա����� ID=IN_BANK_CODE  Align=Left  Edit='none' Width=100 show=false
</C>
<C> Name=�Ա����� ID=IN_BANK_NAME  Align=Left  Edit='none' Width=100
</C>
<C> Name=�Աݰ��¹�ȣ ID=IN_ACCOUNT_NO  Align=Left  Edit='none' Width=100
</C>
<C> Name=�����ܾ� ID=REMAIN_AMT Align=Right  Edit='none' Width=100
</C>
<C> Name=�������� ID=STD_YMD  Edit='none' Width=100 show=false
</C>
<C> Name=��ü�ݾ� ID=TRANSFER_AMT Align=Right  Edit='none' Width=100
</C>
<C> Name=������ ID=TRANSFER_YMD Align=Center  Edit='none' Width=70
</C>
<C> Name=��ü������ ID=REQUEST_YMD Align=Center  Edit='none' Width=70 show=false
</C>
<C> Name=��ü���� ID=TRANSFER_STATUS  Align=Left  Edit='none' Width=100 show=false
</C>
<C> Name=���� ID=DESCRIPTION  Align=Left  Edit='none' Width=100 show=false
</C>
<C> Name=��ü���� ID=TRANSFER_STATUS_NAME  Align=Left  Edit='none' Width=150
</C>
<C> Name=��ǥ��ȣ ID=MAKE_SLIPNO  Align=Center Edit='none'  Width=90
</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
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