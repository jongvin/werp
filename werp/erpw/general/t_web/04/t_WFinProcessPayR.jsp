<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFinProcessPayR.jsp(������ް���)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-13) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFinProcessPayR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMASTER=dsMASTER,I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02,I:dsSUB03=dsSUB03,I:dsSUB04=dsSUB04,I:dsSUB05=dsSUB05)";
	
	String	strOut = "";
	String	strSql = "";
	String	strAct = "";
	String	strCOMP_CODE = "";
	String	strDEPT_CODE = "";
	String	strCOMPANY_NAME = "";
	String	strDATE  = CITDate.getNow("yyyy-MM-dd");
	String	strCombo = "";
	String	strACCNO = "";	
	String	strACCNO_G = "";
	String	strDTF = "";
	String	strDTT = "";
	String	strBANK_MAIN_CODE = "";
	String	strUserNo = "";
	String	strNAME = "";
	CITData		lrArgData = new CITData();
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strNAME = CITCommon.NvlString(session.getAttribute("name"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			
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
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select"+"\n"+
				"	a.ACC_KIND_CODE CODE,"+"\n"+
				"	a.ACC_KIND_NAME NAME,"+"\n"+
				"	2 GRP"+"\n"+
				"From	T_FIN_PAY_SUM_ACC_GROUP a"+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	'%',"+"\n"+
				"	'��ü',"+"\n"+
				"	1"+"\n"+
				"From	Dual"+"\n"+
				"Order By"+"\n"+
				"	3,1";
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
			var sTab ="1";
			var vDATE 			 = '<%=strDATE%>';
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDTF = "<%=strDTF%>";
			var			sDTT = "<%=strDTT%>";
			var			sEmpNo = "<%=CITCommon.enSC(strUserNo)%>";
			var			sEmpName = "<%=CITCommon.enSC(strNAME)%>";
			// �̺�Ʈ����-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="1:CUST_CODE:CUST_NAME ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsMASTER classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsDETAIL classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsACC_INFO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="1:CUST_CODE:CUST_NAME ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="1:CUST_CODE:CUST_NAME ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB03 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="1:CUST_CODE:CUST_NAME ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB04 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="1:CUST_CODE:CUST_NAME ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB05 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param NAME=SubSumExpr          value="2:CUST_CODE:CUST_NAME,1:EXEC_KIND_TAG:EXEC_KIND_TAG_NM ">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><object id=dsSEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL ������������//--><object id=dsREMOVE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL ������������//--><object id=dsCUST_ACC classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL ������������//--><object id=dsSLIP_INFO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_SLIP_INFO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__18"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_PAY classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__18); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__19"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_PAY_INFO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__19); </script> <!--CONVPAGE_TAIL ������������//-->
		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__20"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__20); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__21"> <!--CONVPAGE_TAIL ������������//--><object id="transMAKE"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsMAKE=dsMAKE)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=MAKE">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__21); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__22"> <!--CONVPAGE_TAIL ������������//--><object id="transMAKE_SLIP"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsMAKE_SLIP_INFO=dsMAKE_SLIP_INFO,I:dsMAKE_SLIP=dsMAKE_SLIP)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=MAKE_SLIP">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__22); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__23"> <!--CONVPAGE_TAIL ������������//--><object id="transMAKE_PAY"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsMAKE_PAY_INFO=dsMAKE_PAY_INFO,I:dsMAKE_PAY=dsMAKE_PAY)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=MAKE_SLIP">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__23); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__24"> <!--CONVPAGE_TAIL ������������//--><object id="transREMOVE"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsREMOVE=dsREMOVE)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=REMOVE">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__24); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- ���� ���̺� ���� //-->
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="0"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class="font_green_bold" >�����</td>
											<td width="52">
												<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="60">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15" height="20"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >��ȸ�Ⱓ</td>
											<td width="82">
												<input id="txtF_PUBL_DT" type="text" datatype="DATE" style="width:80px">
											</td>
											<td width=22>
												<input id="btnF_PUBL_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnF_PUBL_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="10">
												~
											</td>
											<td width="82">
												<input id="txtE_PUBL_DT" type="text" datatype="DATE" style="width:80px">
											</td>
											<td width=22>
												<input id="btnE_PUBL_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnE_PUBL_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width=*>
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="*" height="3"></td>
							</tr>
							<tr> 
								<td height="100%" width="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120" height="100%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="50%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> ������޸��</td>
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
																	<td height="100%">
																		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__25"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMASTER WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																			<PARAM NAME="DataID" VALUE="dsMASTER">
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=UsingOneClick  value="1">
																			<PARAM NAME="Format" VALUE=" 
																				<C> Name=������ ID=WORK_DT Width=90 EditStyle=Popup
																				</C>
																				">
																		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__25); </script> <!--CONVPAGE_TAIL ������������//-->
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td height="50%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> ��ǥ������</td>
																				<td align="right" width="*">
																					&nbsp;
																				</td>
																			</tr>
																		</table>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td align="right" width="*">
																					<input id="btnShowPaySlip" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnShowPaySlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																				</td>
																			</tr>
																		</table>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td align="right" width="*">
																					<input id="btnRemoveSlipDetail" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnRemoveSlipDetail_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																	<td height="100%">
																		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__26"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridDETAIL WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																			<PARAM NAME="DataID" VALUE="dsDETAIL">
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=UsingOneClick  value="1">
																			<PARAM NAME="Format" VALUE=" 
																				<C> Name=��ǥ��ȣ ID=MAKE_SLIPNO Width=100
																				</C>
																				">
																		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__26); </script> <!--CONVPAGE_TAIL ������������//-->
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
											<td width="10">
												&nbsp;
											</td>
											<td width="*" height="100%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="50%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="100%">
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> ������޴��</td>
																				<td width="55"  >���� : </td>
																				<td width="122" class="font_green_bold" >
																					<select  name="cboSUM_ACC_GROUP"  style="WIDTH: 120px" onchange="cboSUM_ACC_GROUP_onChange()">
																						<%=strCombo%>
																					</select>
																				</td>
																				<td align="right" width="*">
																					<input id="btnSelectAll1" type="button" class="img_btn7_1" value="���μ���/���" onclick="btnSelectAll1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																					&nbsp;
																					<input id="btnMakeDestList" type="button" class="img_btn8_1" value="���޴��������" onclick="btnMakeDestList_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																	<td height="100%">
																		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__27"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																			<PARAM NAME="DataID" VALUE="dsMAIN">
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ViewSummary" VALUE="1">
																			<param name=SuppressOption value="1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=UsingOneClick  value="1">
																			<PARAM NAME="Format" VALUE=" 
																				<FC> Name='����' ID=CHK_TAG Align=Center Width=40 EditStyle=CheckBox 	
																				</FC> 
																				<FC> Name='����ڹ�ȣ' ID=CUST_CODE Align=Center Width=80 	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</FC> 
																				<FC> Name=�ŷ�ó�� ID=CUST_NAME Width=120  	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</FC> 
																				<C> Name=�����ݾ� ID=SET_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=������ݾ� ID=PRE_RESET_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name='�ܾ�(���ݾ�)' ID=REMAIN_AMT Width=90 value={SET_AMT - PRE_RESET_AMT} SumText={SUM(SET_AMT) - SUM(PRE_RESET_AMT)} Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=�ݹ������ݾ� ID=EXCEPT_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=���ݺ��� ID=C_RATIO Width=60 Align='Right' Color={Decode(TARGET_SLIP_ID,'','red','black')} Edit=RealNumeric Dec=2
																				</C>
																				<C> Name=�������� ID=B_RATIO Width=60 Align='Right'  Color={Decode(TARGET_SLIP_ID,'','red','black')} Edit=RealNumeric Dec=2
																				</C>
																				<C> Name=�ݹ�ó���ݾ� ID=EXEC_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=��ó���ݾ� ID=N_EXEC_AMT Width=90 value={SET_AMT - PRE_RESET_AMT - EXCEPT_AMT - EXEC_AMT} Color={Decode(TARGET_SLIP_ID,'','red','black')} 
																						SumText={SUM(SET_AMT) - SUM(PRE_RESET_AMT) - SUM(EXCEPT_AMT) - SUM(EXEC_AMT)}
																				</C>
																				<C> Name=��ǥ����ݾ� ID=SLIP_EXEC_AMT Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=�̹���ݾ� ID=N_SLIP_EXEC_AMT Width=90 value={SET_AMT - PRE_RESET_AMT - EXCEPT_AMT - SLIP_EXEC_AMT}  Color={Decode(TARGET_SLIP_ID,'','red','black')}
																						SumText={SUM(SET_AMT) - SUM(PRE_RESET_AMT) - SUM(EXCEPT_AMT) - SUM(SLIP_EXEC_AMT)}
																				</C>
																				<C> Name=���� ID=ACC_NAME Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=���� ID=SUMMARY Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=��ǥ��ȣ ID=MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				<C> Name=�����ڱݰ��� ID=OUT_ACCNO3 Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																				</C>
																				">
																		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__27); </script> <!--CONVPAGE_TAIL ������������//-->
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td height="50%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr height="23">
																					<!-- ���α׷��� ���� ���� //-->
																				<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
																				<td width="70" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a href="javascript:selectTab(1, 5);" onfocus="this.blur()">����</a></td>
																				<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
																				<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
																				<td width="140" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(2, 5);" onfocus="this.blur()">����ī��-�ܴ��</a></td>
																				<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
																				<td width="6"><img id="imgTabLeft3" src="../images/Content_tab_after.gif"></td>
																				<td width="70" id="tab3" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(3, 5);" onfocus="this.blur()">�ǹ�����</a></td>
																				<td width="6"><img id="imgTabRight3" src="../images/Content_tab_back.gif"></td>
																				<td width="6"><img id="imgTabLeft4" src="../images/Content_tab_after.gif"></td>
																				<td width="70" id="tab4" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(4, 5);" onfocus="this.blur()">����</a></td>
																				<td width="6"><img id="imgTabRight4" src="../images/Content_tab_back.gif"></td>
																				<td width="6"><img id="imgTabLeft5" src="../images/Content_tab_after.gif"></td>
																				<td width="70" id="tab5" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(5, 5);" onfocus="this.blur()">��ü����</a></td>
																				<td width="6"><img id="imgTabRight5" src="../images/Content_tab_back.gif"></td>
																				<td width="*" >
																					&nbsp;
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
																<tr> 
																	<td height="2"></td>
																</tr>
																<tr>
																	<td height="100%" width="100%">
																		<div id=divTabPage1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
																			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="100%">
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td width="*">
																								&nbsp;
																								</td>
																								<td width="*" align="center">
																									<input id="btnSet1" type="button" class="img_btn6_1" value="�������߰�" onclick="btnSet1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemove1" type="button" class="img_btn6_1" value="������������" onclick="btnRemove1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																								</td>
																								<td width="*">
																									���������� : 
																									<select  name="cboACCNO1"  onchange="cboACCNO1_onChange()">
																										<%=strACCNO%>
																									</select>
																								</td>
																							</tr>
																						</table>
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td align="right" width="*">
																									<input id="btnSelectAllC1" type="button" class="img_btn7_1" value="���μ���/���" onclick="btnSelectAllC1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnMakeSlip1" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnMakeSlip1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemoveSlip1" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnRemoveSlip1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnMakeFBS1" type="button" class="img_btn6_1" value="FBS�ڷ����" onclick="btnMakeFBS1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnShowListSlipR1" type="button" class="img_btn6_1" value="û����ǥ����" onclick="btnShowListSlipR1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnShowListSlipP1" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowListSlipP1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																						<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__28"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																							<PARAM NAME="DataID" VALUE="dsSUB01">
																							<param name=SuppressOption value="1">
																							<PARAM NAME="Editable" VALUE="-1">
																							<PARAM NAME="ColSelect" VALUE="-1">
																							<PARAM NAME="ViewSummary" VALUE="1">
																							<PARAM NAME="ColSizing" VALUE="-1">
																							<param name=UsingOneClick  value="1">
																							<PARAM NAME="Format" VALUE=" 
																								<FC> Name='����' ID=CHK_TAG Align=Center Width=40 EditStyle=CheckBox 	
																								</FC> 
																								<FC> Name='����ڹ�ȣ' ID=CUST_CODE Align=Center Width=80 	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</FC> 
																								<FC> Name=�ŷ�ó�� ID=CUST_NAME Width=120  	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</FC> 
																								<C> Name=���ޱݾ� ID=EXEC_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���������� ID=OUT_ACC_NO Width=180 Color={Decode(TARGET_SLIP_ID,'','red','black')}  EditStyle=Combo Data='<%=strACCNO_G%>'
																								</C>
																								<G> Name='�ŷ�ó�Աݰ���' id=G1
																									<C> Name=�Աݰ��� ID=IN_ACC_NO Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																									</C>
																									<C> Name=�Ա����� ID=IN_BANK_MAIN_CODE Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}  EditStyle=Combo Data='<%=strBANK_MAIN_CODE%>'
																									</C>
																									<C> Name=������ ID=ACCNO_OWNER Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																									</C>
																								</G>
																								<C> Name=���� ID=ACC_NAME Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���� ID=SUMMARY Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=û����ǥ��ȣ ID=MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=������ǥ��ȣ ID=PAY_MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								">
																						</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__28); </script> <!--CONVPAGE_TAIL ������������//-->
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
																		</div>
																		<div id=divTabPage2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
																			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="100%">
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td width="*">
																								&nbsp;
																								</td>
																								<td width="*" align="center">
																									<input id="btnSet2" type="button" class="img_btn6_1" value="�������߰�" onclick="btnSet2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemove2" type="button" class="img_btn6_1" value="������������" onclick="btnRemove2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																								</td>
																								<td width="*">
																									���������� : 
																									<select  name="cboACCNO2"  onchange="cboACCNO2_onChange()">
																										<%=strACCNO%>
																									</select>
																									�����������ġ�и���������
																									<input id="chkMatchAccNo" type="CheckBox" class="check" >
																								</td>
																							</tr>
																						</table>
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td align="right" width="*">
																									<input id="btnSelectAllC2" type="button" class="img_btn7_1" value="���μ���/���" onclick="btnSelectAllC2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnMakeSlip2" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnMakeSlip2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemoveSlip2" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnRemoveSlip2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnMakeFBS2" type="button" class="img_btn6_1" value="FBS�ڷ����" onclick="btnMakeFBS2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnShowListSlipR2" type="button" class="img_btn6_1" value="û����ǥ����" onclick="btnShowListSlipR2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnShowListSlipP2" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowListSlipP2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																						<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__29"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																							<PARAM NAME="DataID" VALUE="dsSUB02">
																							<param name=SuppressOption value="1">
																							<PARAM NAME="Editable" VALUE="-1">
																							<PARAM NAME="ColSelect" VALUE="-1">
																							<PARAM NAME="ViewSummary" VALUE="1">
																							<PARAM NAME="ColSizing" VALUE="-1">
																							<param name=UsingOneClick  value="1">
																							<PARAM NAME="Format" VALUE=" 
																								<FC> Name='����' ID=CHK_TAG Align=Center Width=40 EditStyle=CheckBox 	
																								</FC> 
																								<FC> Name='����ڹ�ȣ' ID=CUST_CODE Align=Center Width=80 	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</FC> 
																								<FC> Name=�ŷ�ó�� ID=CUST_NAME Width=120  	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</FC> 
																								<C> Name=���ޱݾ� ID=EXEC_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���������� ID=OUT_ACC_NO Width=180 Color={Decode(TARGET_SLIP_ID,'','red','black')}  EditStyle=Combo Data='<%=strACCNO_G%>'
																								</C>
																								<C> Name=������ ID=EXPR_DT Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')} EditStyle=Popup
																								</C>
																								<G> Name='�ŷ�ó�Աݰ���' id=G1
																									<C> Name=�Աݰ��� ID=IN_ACC_NO Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																									</C>
																									<C> Name=�Ա����� ID=IN_BANK_MAIN_CODE Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}  EditStyle=Combo Data='<%=strBANK_MAIN_CODE%>'
																									</C>
																									<C> Name=������ ID=ACCNO_OWNER Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																									</C>
																								</G>
																								<C> Name=���� ID=ACC_NAME Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���� ID=SUMMARY Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=û����ǥ��ȣ ID=MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=������ǥ��ȣ ID=PAY_MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								">
																						</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__29); </script> <!--CONVPAGE_TAIL ������������//-->
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
																		</div>
																		<div id=divTabPage3  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
																			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="100%">
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td width="*">
																								&nbsp;
																								</td>
																								<td width="*" align="center">
																									<input id="btnSet3" type="button" class="img_btn6_1" value="�������߰�" onclick="btnSet3_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemove3" type="button" class="img_btn6_1" value="������������" onclick="btnRemove3_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																								</td>
																								<td width="*">
																									���������� : 
																									<select  name="cboACCNO3"  onchange="cboACCNO3_onChange()">
																										<%=strACCNO%>
																									</select>
																								</td>
																							</tr>
																						</table>
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td align="right" width="*">
																									<input id="btnSelectAllC3" type="button" class="img_btn7_1" value="���μ���/���" onclick="btnSelectAllC3_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnMakeSlip3" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnMakeSlip3_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemoveSlip3" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnRemoveSlip3_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnShowListSlipR3" type="button" class="img_btn6_1" value="û����ǥ����" onclick="btnShowListSlipR3_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnShowListSlipP3" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowListSlipP3_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																						<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__30"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB03 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																							<PARAM NAME="DataID" VALUE="dsSUB03">
																							<param name=SuppressOption value="1">
																							<PARAM NAME="Editable" VALUE="-1">
																							<PARAM NAME="ColSelect" VALUE="-1">
																							<PARAM NAME="ViewSummary" VALUE="1">
																							<PARAM NAME="ColSizing" VALUE="-1">
																							<param name=UsingOneClick  value="1">
																							<PARAM NAME="Format" VALUE=" 
																								<FC> Name='����' ID=CHK_TAG Align=Center Width=40 EditStyle=CheckBox 	
																								</FC> 
																								<FC> Name='����ڹ�ȣ' ID=CUST_CODE Align=Center Width=80 	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</FC> 
																								<FC> Name=�ŷ�ó�� ID=CUST_NAME Width=120  	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</FC> 
																								<C> Name=���ޱݾ� ID=EXEC_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���������� ID=OUT_ACC_NO Width=180 Color={Decode(TARGET_SLIP_ID,'','red','black')}  EditStyle=Combo Data='<%=strACCNO_G%>'
																								</C>
																								<C> Name='������ȣ' ID=CHK_BILL_NO Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=������ ID=EXPR_DT Width=90 Color={Decode(TARGET_SLIP_ID,'','red','black')} EditStyle=Popup
																								</C>
																								<C> Name=���� ID=ACC_NAME Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���� ID=SUMMARY Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=û����ǥ��ȣ ID=MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=������ǥ��ȣ ID=PAY_MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								">
																						</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__30); </script> <!--CONVPAGE_TAIL ������������//-->
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
																		</div>
																		<div id=divTabPage4  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
																			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="100%">
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td width="*">
																								&nbsp;
																								</td>
																								<td width="*" align="center">
																									<input id="btnSet4" type="button" class="img_btn6_1" value="�������߰�" onclick="btnSet4_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemove4" type="button" class="img_btn6_1" value="������������" onclick="btnRemove4_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																								</td>
																								<td width="*">
																								&nbsp;
																								</td>
																							</tr>
																						</table>
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td align="right" width="*">
																									<input id="btnSelectAllC4" type="button" class="img_btn7_1" value="���μ���/���" onclick="btnSelectAllC4_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnMakeSlip4" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnMakeSlip4_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnRemoveSlip4" type="button" class="img_btn4_1" value="��ǥ����" onclick="btnRemoveSlip4_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									&nbsp;
																									<input id="btnShowListSlipR4" type="button" class="img_btn6_1" value="û����ǥ����" onclick="btnShowListSlipR4_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnShowListSlipP4" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowListSlipP4_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																						<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__31"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB04 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																							<PARAM NAME="DataID" VALUE="dsSUB04">
																							<param name=SuppressOption value="1">
																							<PARAM NAME="Editable" VALUE="-1">
																							<PARAM NAME="ColSelect" VALUE="-1">
																							<PARAM NAME="ViewSummary" VALUE="1">
																							<PARAM NAME="ColSizing" VALUE="-1">
																							<param name=UsingOneClick  value="1">
																							<PARAM NAME="Format" VALUE=" 
																								<FC> Name='����' ID=CHK_TAG Align=Center Width=40 EditStyle=CheckBox 	
																								</FC> 
																								<FC> Name='����ڹ�ȣ' ID=CUST_CODE Align=Center Width=80 	suppress=1 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</FC> 
																								<C> Name=���ޱݾ� ID=EXEC_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���� ID=ACC_NAME Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=���� ID=SUMMARY Width=200 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=û����ǥ��ȣ ID=MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								<C> Name=������ǥ��ȣ ID=PAY_MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'','red','black')}
																								</C>
																								">
																						</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__31); </script> <!--CONVPAGE_TAIL ������������//-->
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
																		</div>
																		<div id=divTabPage5  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
																			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="100%">
																						<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td align="right" width="*">
																									&nbsp;
																									&nbsp;
																									<input id="btnShowListSlipR5" type="button" class="img_btn6_1" value="û����ǥ����" onclick="btnShowListSlipR5_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																									<input id="btnShowListSlipP5" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowListSlipP5_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																						<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__32"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB05 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																							<PARAM NAME="DataID" VALUE="dsSUB05">
																							<param name=SuppressOption value="1">
																							<PARAM NAME="Editable" VALUE="-1">
																							<PARAM NAME="ColSelect" VALUE="-1">
																							<PARAM NAME="ViewSummary" VALUE="1">
																							<PARAM NAME="ColSizing" VALUE="-1">
																							<param name=UsingOneClick  value="1">
																							<PARAM NAME="Format" VALUE=" 
																								<FC> Name='����' ID=CHK_TAG Align=Center Width=40 EditStyle=CheckBox 	
																								</FC> 
																								<FC> Name='����ڹ�ȣ' ID=CUST_CODE Align=Center Width=80 	suppress=2 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</FC> 
																								<FC> Name=�ŷ�ó�� ID=CUST_NAME Width=120  	suppress=2 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</FC> 
																								<FC> Name='����' ID=EXEC_KIND_TAG_NM Align=Center suppress=1 Width=80 	Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</FC> 
																								<C> Name=���ޱݾ� ID=EXEC_AMT Width=90 SumText=@Sum Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</C>
																								<C> Name=���������� ID=OUT_ACC_NO Width=180  EditStyle=Combo Data='<%=strACCNO_G%>' Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</C>
																								<G> Name='�ŷ�ó�Աݰ���' id=G1
																									<C> Name=�Աݰ��� ID=IN_ACC_NO Width=90 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																									</C>
																									<C> Name=�Ա����� ID=IN_BANK_MAIN_CODE Width=100 EditStyle=Combo Data='<%=strBANK_MAIN_CODE%>' Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																									</C>
																									<C> Name=������ ID=ACCNO_OWNER Width=90 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																									</C>
																								</G>
																								<C> Name='������ȣ' ID=CHK_BILL_NO Width=90 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</C>
																								<C> Name=���� ID=ACC_NAME Width=200 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</C>
																								<C> Name=���� ID=SUMMARY Width=200 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</C>
																								<C> Name=û����ǥ��ȣ ID=MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</C>
																								<C> Name=������ǥ��ȣ ID=PAY_MAKE_SLIPNO Width=100 Color={Decode(TARGET_SLIP_ID,'',Decode(SubCount(level=1),SubCount(level=2),'blue','red'),'black')}
																								</C>
																								">
																						</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__32); </script> <!--CONVPAGE_TAIL ������������//-->
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
																		</div>
																	</td>
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