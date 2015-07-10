<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_PSlipFixDeprecR(�������ڵ���ǥ����)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-06)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	String  strDATE  = CITDate.getNow("yyyyMMdd");
	String  strDATE1  = CITDate.getNow("yyyy-MM-dd");
	
	CITData lrReturnData = null;  
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strDt_Trans = CITDate.getNow("yyyyMMdd");
	String strDate = 	 CITDate.getNow("yyyy-MM-dd");
	String strFileName = "./t_PSlipFixDeprecR";
	
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strMAKE_SLIPCLS = "";
	String strCOMP_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_CODE = "";
	String strDEPT_NAME = "";
	String strINOUT_DEPT_CODE = "";
	String strINOUT_DEPT_NAME = "";
	String strDEPT_COMP_CODE = "";
	String strDEPT_COMP_NAME = ""; 
	String strDEPT_TAX_COMP_CODE = "";
	String strDEPT_TAX_COMP_NAME = "";
	String strEMP_NO = "";
	String strNAME = "";
	String strSLIP_TRANS_CLS = "";
	String strDEPT_CHG_CLS = "";
	String strSLIP_KIND_TAG = "";
	
	String strCHARGE_PERS = "";
	String strCHARGE_PERS_NAME = "";
	
	String strCashAccCode = "111010100";
	
	String strWORK_CODE = "FIX00003";
	
	try
	{
/*
out.println(""+(String)session.getAttribute("file_upload_dir"));
out.println(""+(String)session.getAttribute("emp_no"));
out.println(""+(String)session.getAttribute("name"));
out.println(""+(String)session.getAttribute("slip_trans_cls"));
out.println(""+(String)session.getAttribute("dept_chg_cls"));
out.println(""+(String)session.getAttribute("comp_code"));
out.println(""+(String)session.getAttribute("dept_code"));
out.println(""+(String)session.getAttribute("long_name"));
*/
			
		CITCommon.initPage(request, response, session, false);
		
		CITData lrArgData = new CITData();

		//�����
		strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
		strNAME = CITCommon.NvlString(session.getAttribute("name"));
		
		//����
		strSLIP_TRANS_CLS = CITCommon.NvlString(session.getAttribute("slip_trans_cls"));
		strDEPT_CHG_CLS = CITCommon.NvlString(session.getAttribute("dept_chg_cls"));
		
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));

		//ȸ����ǥ�з�����
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SLIP_KIND_TAG' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			//strSql += "And	( ( 'T'='"+strSLIP_TRANS_CLS+"' ) Or  ( 'F'='"+strSLIP_TRANS_CLS+"' And a.CODE_LIST_ID IN ('A','C') ) )  \n";
			strSql += "And	a.CODE_LIST_NAME = '�ڵ�' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strSLIP_KIND_TAG = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ��ǥ�����ڵ� Select ���� -> " + ex.getMessage());
		}

		//��ǥ����
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'MAKE_SLIPCLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strMAKE_SLIPCLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ��ǥ�����ڵ� Select ���� -> " + ex.getMessage());
		}
		
		try
		{
			lrArgData.addColumn("WORK_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("WORK_CODE", strWORK_CODE);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			
			strSql  = " Select	a.COMP_CODE, \n";
			strSql += " 		b.COMPANY_NAME, \n";
			strSql += " 		b.DEPT_CODE INOUT_DEPT_CODE , \n";
			strSql += " 		c.DEPT_NAME INOUT_DEPT_NAME , \n";
			strSql += " 		a.COMP_CODE DEPT_COMP_CODE , \n";
			strSql += " 		b.COMPANY_NAME DEPT_COMP_NAME , \n";
			strSql += " 		a.TAX_COMP_CODE DEPT_TAX_COMP_CODE, \n";
			strSql += " 		d.COMPANY_NAME DEPT_TAX_COMP_NAME, \n";
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
			strSql += " And	a.COMP_CODE = b.COMP_CODE(+) \n";
			strSql += " And	b.DEPT_CODE = c.DEPT_CODE(+) \n";
			strSql += " And	a.TAX_COMP_CODE = d.COMP_CODE(+) \n";
			strSql += " And	a.COMP_CODE = e.COMP_CODE(+) \n";



			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			if(lrReturnData.getRowsCount() >= 1)
			{
				strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
				strCOMPANY_NAME = lrReturnData.toString(0,"COMPANY_NAME");
				strINOUT_DEPT_CODE = lrReturnData.toString(0,"INOUT_DEPT_CODE");
				strINOUT_DEPT_NAME = lrReturnData.toString(0,"INOUT_DEPT_NAME");
				strDEPT_COMP_CODE = lrReturnData.toString(0,"DEPT_COMP_CODE");
				strDEPT_COMP_NAME = lrReturnData.toString(0,"DEPT_COMP_NAME");
				strDEPT_TAX_COMP_CODE = lrReturnData.toString(0,"DEPT_TAX_COMP_CODE");
				strDEPT_TAX_COMP_NAME = lrReturnData.toString(0,"DEPT_TAX_COMP_NAME");
				strCHARGE_PERS = lrReturnData.toString(0,"CHARGE_PERS");
				strCHARGE_PERS_NAME = lrReturnData.toString(0,"CHARGE_PERS_NAME");

				session.setAttribute("comp_code", strCOMP_CODE);
				session.setAttribute("comp_name", strCOMPANY_NAME);
			}
			
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
			
			var			sEmpno = "<%=strEMP_NO%>";
			var			sName = "<%=strNAME%>";
			
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sDt_Trans = "<%=strDt_Trans%>";
			var			sDate = "<%=strDate%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=strCOMPANY_NAME%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=strDEPT_NAME%>";
			var			sInout_DeptCode = "<%=strINOUT_DEPT_CODE%>";
			var			sInout_DeptName = "<%=strINOUT_DEPT_NAME%>";
			var			sDept_CompCode = "<%=strDEPT_COMP_CODE%>";
			var			sDept_CompName = "<%=strDEPT_COMP_NAME%>";
			var			sDept_Tax_CompCode = "<%=strDEPT_TAX_COMP_CODE%>";
			var			sDept_Tax_CompName = "<%=strDEPT_TAX_COMP_NAME%>";
			var			sEmpno = "<%=strEMP_NO%>";
			var			sName = "<%=strNAME%>";
			var			sSlip_Trans_Cls = "<%=strSLIP_TRANS_CLS%>";
			var			sDept_Chg_Cls = "<%=strDEPT_CHG_CLS%>";
			
			var			vCashAccCode = "<%=strCashAccCode%>";
			var			vWORK_CODE = "<%=strWORK_CODE%>";
			
			var			sCHARGE_PERS = "<%=strCHARGE_PERS%>";
			var			sCHARGE_PERS_NAME = "<%=strCHARGE_PERS_NAME%>";
			var			vDATE = "<%=strDATE%>";
			var			vDATE1 = "<%=strDATE1%>";
			var 			lrArgs;
			var			vDiv="";
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsDAY_CLOSE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsWORK_SLIP_IDSEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id=dsNEW_WORK_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id=dsCOST_DEPT_KND_TAG classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%" colspan=2>
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
											<td width="80" class="font_green_bold" >�����</td>
											<td width="52">
												<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="50">&nbsp;</td>
 											<td width="15"><img src="../images/bullet3.gif"></td>
 											<td width="60" class=font_green_bold >�۾�����</td>
											<td width="75"> <input id="txtWORK_DT_FROM" type="text" datatype="DATE" style="width:70px" VALUE="" onChange="txtWORK_DT_FROM_onChange()"></td>
											<td width="20"><input id="btnWORK_DT_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnWORK_DT_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="12">~</td>
											<td width="75"> <input id="txtWORK_DT_TO" type="text" datatype="DATE" align="Center" style="width:70px" VALUE="" onChange="txtWORK_DT_TO_onChange()"></td>
											<td width="20"><input id="btnWORK_DT_TO" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnWORK_DT_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="50">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="80" class="font_green_bold" >�������屸��</td>
											<td width="102">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><OBJECT id="cboCOST_DEPT_KND_TAG" style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;COST_DEPT_KND_NAME">
													<PARAM name="ListExprFormat" value="%;COST_DEPT_KND_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="COST_DEPT_KND_TAG">
													<PARAM NAME="SortColumn" VALUE="COST_DEPT_KND_TAG">
													<PARAM NAME="BindColumn" VALUE="COST_DEPT_KND_TAG">
													<PARAM NAME="ComboDataID" VALUE="dsCOST_DEPT_KND_TAG">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
											</td>
											<td width=*>&nbsp;</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
						</table>
						<!-- �������� ���̺� ���� //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
						<!-- �������� ���̺� ���� //-->
								<!-- �������� ���̺� ���� //-->
								<table width="800" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- �������� ���̺� ���� //-->
								<!-- ���� ���̺� ���� //-->
								<!-- ���� Ÿ��Ʋ ���� //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- ���α׷��� ���� ���� //-->
										<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
										<td class="font_green_bold"> ��������ǥ �ڵ�����</td>
										<td align="right">
										<input id="btnSlipCreate" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="��������ǥ����" onclick="btnSlipCreate_onClick()"/>
										<!--<input id="btnSlipDelete" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="��������ǥ����" onclick="btnSlipDelete_onClick()"/>-->
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
																<td width="60">��ǥ��ȣ</td>
																<td width="58">
																	<input id="txtSLIP_MAKE_DT_F"	type="hidden"/>
																	<input id="txtSLIP_MAKE_DT"	type="text" center datatype="n"  maxlength=8 style="width:57px" tabindex="2" onblur="txtSLIP_MAKE_DT_onblur()" onfocus="txtSLIP_MAKE_DT_F.value = txtSLIP_MAKE_DT.value"/>
																</td>
																<td width="21">
																	<input id="btnSLIP_MAKE_DT" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnSLIP_MAKE_DT_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width="60">
																	<select id="cboSLIP_KIND_TAG" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default">
																		<%=strSLIP_KIND_TAG%>
																	</select>
																</td>
																<td width="9" class="font_green_bold" ></td>
																<td width="28">
																	<input id="txtSLIP_MAKE_COMP_CODE_F"	type="hidden"/>
																	<input id="txtSLIP_MAKE_COMP_CODE"	type="text" center datatype="an" maxlength=3 style="width:26px" tabindex="1" class="ro" readOnly="true"/>
																</td>
																<td width="9" class="font_green_bold" ></td>
																<td width="35">
																	<input id="txtSLIP_MAKE_SEQ_F"		type="hidden"/>
																	<input id="txtSLIP_MAKE_SEQ"		type="text" center style="width:33px" tabindex="4" class="ro" readOnly="true"/>
																</td>
																<td width="145">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >�� �� ��</td>
																<td width="102">
																	<input id="txtSLIP_MAKE_COMP_NAME" 		type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
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
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="425">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >�������</td>
																<td width="102">
																	<input id="txtSLIP_CHARGE_PERS"		type="hidden"/>
																	<input id="txtSLIP_CHARGE_PERS_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
																</td>
																<td width="38">
																	<!--
																	<input name="btnCHARGE_PERS" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_CHARGE_PERS_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="�������ã��" />
																	-->
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
								<!-- ���� ���̺� ���� //-->
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
				<tr valign="top"> 
					<td width="65%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> ��ǥ������</td>
											<td align="right" width="*">
											<input id="btnQuery"	type="button" class="img_btn4_1" onclick="btnQuery_onClick()"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�� ȸ" />

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
										<PARAM NAME="Editable" VALUE="false">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE="							
											<C> Name=�۾����� 		ID=WORK_SEQ		Align=Center	Width=60   Show='true'
											</C>
											<C> Name=�۾����� 		ID=WORK_DT			Align=Left	 Width=80   	 Show='true'
											</C>
											<C> Name=�۾��� 			ID=WORK_NAME		Align=Left	 Width=200   	 Show='true'
											</C>
											<C> Name=�Ⱓ������ 		ID=WORK_FROM_DT	Align=Center	 Width=80   	Show='true'
											</C>
											<C> Name=�Ⱓ������ 		ID=WORK_TO_DT		Align=Center	 Width=80   	Show='true'
											</C>
											<C> Name=��ǥ��ȣ 		ID=SLIP_ID				Align=Center	 Width=80   	Show='true'
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