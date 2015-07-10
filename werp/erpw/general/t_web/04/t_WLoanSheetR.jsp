<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WLoanSheetR.jsp(���Դ������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-05) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WLoanSheetR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMASTER=dsMASTER,I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strLOAN_ACC_CODE = "";
	String strLOAN_ACC_CODE_G = "";
	String strDATE  = CITDate.getNow("yyyyMMdd");
	String strUserNo = "";
	String strFL_LOAN_KIND_CODE = "";
	CITData		lrArgData = new CITData();
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
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

				strSql = " 	Select \n";
				strSql += " 		a.LOAN_KIND_CODE CODE,\n";
				strSql += " 		a.LOAN_KIND_NAME NAME \n";
				strSql += " 	From	T_FIN_LOAN_KIND a \n";
				strSql += " 	Order By \n";
				strSql += " 		a.LOAN_KIND_CODE \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strLOAN_ACC_CODE_G = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strLOAN_ACC_CODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql =	
				"select fl_loan_kind_code code,"+"\n"+
				"	   decode(fl_loan_kind_tag, '1','�� �� ','�� �� ') || fl_loan_kind_name  NAME"+"\n"+
				" from t_fl_loan_kind_code "+"\n"+
				" order by fl_loan_kind_code"+"\n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strFL_LOAN_KIND_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
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
			var			sEmpNo = "<%=strUserNo%>";
			// �̺�Ʈ����-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMASTER classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsSLIP_INFO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOAN_CONT_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOAN_REFUND_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id=dsGUAR_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><object id=dsDVD classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL ������������//--><object id=dsCALC_ITR_AMT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL ������������//--><object id=dsCALC_PE_ITR_AMT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL ������������//--><object id=dsCALC_DATE1 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL ������������//--><object id=dsCALC_DATE3 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL ������������//--><object id=dsCALC_DATE2 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL ������������//--><object id=dsPE_SLIP_ID classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL ������������//--><object id=dsAE_SLIP_ID classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__18"> <!--CONVPAGE_TAIL ������������//--><object id=dsSLIP_REMAIN_AMT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__18); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__19"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAKE_ITR_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__19); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__20"> <!--CONVPAGE_TAIL ������������//--><object id=dsREMOVE_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__20); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__21"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOAN_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__21); </script> <!--CONVPAGE_TAIL ������������//-->

		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__22"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__22); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__23"> <!--CONVPAGE_TAIL ������������//--><object id="transDvd"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsDVD=dsDVD)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DVD">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__23); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__24"> <!--CONVPAGE_TAIL ������������//--><object id="transMAKE_ITR_SLIP"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsMAKE_ITR_SLIP=dsMAKE_ITR_SLIP)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DVD">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__24); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__25"> <!--CONVPAGE_TAIL ������������//--><object id="transREMOVE_SLIP"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsREMOVE_SLIP=dsREMOVE_SLIP)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DVD">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__25); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >�����ڵ�</td>
											<td width="52">
												<input id="txtBANK_CODE" type="text" style="width:50px" onblur="txtBANK_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtBANK_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="60">
												<input id="btnBANK_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnBANK_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
								<td width="100%" height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="50%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="60%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="100%">
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> ���Ծ���</td>
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
																		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__26"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMASTER WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																			<PARAM NAME="DataID" VALUE="dsMASTER">
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=UsingOneClick  value="1">
																			<PARAM NAME="Format" VALUE=" 
																				<C> Name=����� ID=BANK_NAME Width=200
																				</C> 
																				<C> Name=���Ծ����� ID=LOAN_CONT_NAME Width=200
																				</C> 
																				<C> Name=�����ѵ��ݾ� ID=LIMIT_AMT Width=90
																				</C>
																				<C> Name=���������� ID=LOAN_CONT_EXPR_DT Width=90 align=Center editStyle=Popup 
																				</C>
																				<C> Name=���Ա���Ȳ����  ID=FL_LOAN_KIND_CODE Width=120 align=Center EditStyle=Combo Data='<%= strFL_LOAN_KIND_CODE %> '
																				</C>
																				<C> Name=��� ID=REMARK Width=260
																				</C> 
																				">
																		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__26); </script> <!--CONVPAGE_TAIL ������������//-->
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td height="40%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="100%">
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> ���Դ���</td>
																				<td align="right" width="*">
																					<!--<input id="btnMakeSchedule" type="button" class="img_btn6_1" value="��ȯ��������" onclick="btnMakeSchedule_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">//-->
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
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=UsingOneClick  value="1">
																			<PARAM NAME="Format" VALUE=" 
																				<FG> Name='�⺻����' ID=BASE
																					<FC> Name='���Թ�ȣ' ID=REAL_LOAN_NO Align=Center Width=120 
																					</FC> 
																					<FC> Name=����� ID=BANK_NAME Width=120   visible=false
																					</FC> 
																					<C> Name=�������� ID=LOAN_KIND_CODE Width=120 EditStyle=Combo Data='<%=strLOAN_ACC_CODE_G%>'
																					</C> 
																					<FC> Name=���Ը� ID=LOAN_NAME Width=120
																					</FC> 
																				</FG>
																				<G> Name='�⺻����' ID=BASE2
																					<C> Name=���Աݾ� ID=LOAN_AMT Width=90
																					</C>
																					<C> Name=������ ID=LOAN_FDT Width=90 align=Center editStyle=Popup 
																					</C>
																					<C> Name=������ ID=LOAN_EXPR_DT Width=90 align=Center editStyle=Popup
																					</C>
																					<C> Name=���游���� ID=CHG_EXPR_DT Width=90 align=Center editStyle=Popup
																					</C>
																				<G> Name='���ݻ�ȯ' ID=ORG
																					<C> Name='��ġ(��)' ID=ORG_REFUND_YEAR Width=70 align=center
																					</C>
																					<C> Name='��ȯ�Ⱓ(��)' ID=ORG_REFUND_DIV_YEAR Width=80 align=center
																					</C>
																					<C> Name='��ȯ�ֱ�(��)' ID=ORG_REFUND_MONTH Width=80 align=center
																					</C>
																					<C> Name='���ʻ�ȯ��' ID=ORG_REFUND_FIRST_MONTH Width=90  align=Center  editStyle=Popup
																					</C>
																				</G>
																				<G> Name='���ڳ���' ID=INTR
																					<C> Name=������� ID=TITLE_INTR_RATE Width=60
																					</C>
																					<C> Name=�������� ID=REAL_INTR_RATE Width=60
																					</C>
																					<C> Name='����������' ID=INTR_REFUND_FIRST_DT Width=90  align=Center  editStyle=Popup
																					</C>
																					<C> Name='��������' ID=INTR_REFUND_DAY Width=70 align=center
																					</C>
																					<C> Name='�����ֱ�(��)' ID=INTR_REFUND_DIV_MONTH Width=80 align=center
																					</C>
																				</G>
																				<G> Name='��Ÿ����' ID=ETC
																					<C> Name=��� ID=REMARK Width=200
																					</C> 
																				</G>
																				">
																		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__27); </script> <!--CONVPAGE_TAIL ������������//-->
																	</td>
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
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr height="23">
																		<!-- ���α׷��� ���� ���� //-->
																	<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
																	<td width="140" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a href="javascript:selectTab(1, 2);" onfocus="this.blur()">���� �� ��ȯ ����</a></td>
																	<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
																	<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
																	<td width="70" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(2, 2);" onfocus="this.blur()">��������</a></td>
																	<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
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
																					<td align="right" width="*">
																						<input id="btnCalcItrAmt" type="button" class="img_btn6_1" value="���ڰ��" onclick="btnCalcItrAmt_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																						&nbsp;&nbsp;
																						<!--<input id="btnExecSchedule" type="button" class="img_btn6_1" value="������ν���" onclick="btnExecSchedule_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">-->
																						&nbsp;&nbsp;
																						<input id="btnMakeLoanSlip" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnMakeLoanSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																						<input id="btnMakeRefundSlip" type="button" class="img_btn6_1" value="��ȯ��ǥ����" onclick="btnMakeRefundSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																						<input id="btnMakeItrSlip" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnMakeItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																						<input id="btnRemoveSlip" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnRemoveSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																					</td>
																				</tr>
																			</table>
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td align="right" width="*">
																						<input id="btnShowLoanSlip" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowLoanSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																						<input id="btnShowRefundSlip" type="button" class="img_btn6_1" value="��ȯ��ǥ����" onclick="btnShowRefundSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																						<input id="btnShowItrSlip" type="button" class="img_btn6_1" value="������ǥ����" onclick="btnShowItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
																				<PARAM NAME="Editable" VALUE="-1">
																				<PARAM NAME="ColSelect" VALUE="-1">
																				<PARAM NAME="ViewSummary" VALUE="1">
																				<PARAM NAME="ColSizing" VALUE="-1">
																				<param name=UsingOneClick  value="1">
																				<PARAM NAME="Format" VALUE=" 
																					<FC> Name='����/��ȯ/������' ID=REFUND_INTR_DT Align=Center Width=100 EditStyle=Popup SumText='��  ��'
																					</FC> 
																					<G> Name='����/��ȯ����' id=G1
																						<C> Name=���Աݾ� ID=LOAN_AMT Width=90  SumText=@Sum
																						</C> 
																						<C> Name=���ݻ�ȯ ID=REFUND_AMT Width=90  SumText=@Sum
																						</C> 
																						<C> Name=�ܾ� ID=LOAN_REMAIN_AMT Width=90  
																						</C> 
																					</G>
																					<G> Name='����������' id=G3
																						<C> Name='���ڱ���' ID=ITR_TAG Align=Center Width=90 EditStyle=Combo Data='1:������������,2:������������,3:�������ڹ���,4:������������,5:������ݻ�ȯ,6:������ݻ�ȯ,7:������������'
																						</C> 
																						<C> Name='���ݾ�' ID=ITR_TAR_TAG Align=Center Width=90 EditStyle=Combo Data='A:�ܾ�,R:��ȯ��,X: '
																						</C> 
																						<C> Name='��������' ID=INTR_START_DT Align=Center Width=90 EditStyle=Popup
																						</C> 
																						<C> Name='���������' ID=INTR_END_DT Align=Center Width=90 EditStyle=Popup
																						</C> 
																						<C> Name=���������� ID=INTR_AMT Width=90  SumText=@Sum
																						</C> 
																					</G>
																					<G> Name='���޺�� ��������' id=G31
																						<C> Name='��������' ID=PE_START_DT Align=Center Width=90 EditStyle=Popup
																						</C> 
																						<C> Name='���������' ID=PE_END_DT Align=Center Width=90 EditStyle=Popup
																						</C> 
																						<C> Name=�����ݾ� ID=PE_ITR_AMT Width=90  SumText=@Sum
																						</C> 
																						<C> Name='������ǥ��ȣ' ID=PE_RESET_SLIP_NO Align=Center Width=120 
																						</C> 
																						<C> Name=�����ݾ� ID=PE_RESET_ITR_AMT Width=90  SumText=@Sum
																						</C> 
																					</G>
																					<G> Name='�����޺�� ��������' id=G32
																						<C> Name='��������' ID=AE_START_DT Align=Center Width=90 EditStyle=Popup
																						</C> 
																						<C> Name='���������' ID=AE_END_DT Align=Center Width=90 EditStyle=Popup
																						</C> 
																						<C> Name=�����ݾ� ID=AE_ITR_AMT Width=90  SumText=@Sum
																						</C> 
																						<C> Name='������ǥ��ȣ' ID=AE_RESET_SLIP_NO Align=Center Width=120 
																						</C> 
																						<C> Name=�����ݾ� ID=AE_RESET_ITR_AMT Width=90  SumText=@Sum
																						</C> 
																					</G>
																					<G> Name='��������' id=G2
																						<C> Name='������' ID=REFUND_SCH_DT Align=Center Width=90 EditStyle=Popup
																						</C> 
																						<C> Name=���ݻ�ȯ ID=REFUND_SCH_ORG_AMT Width=90   SumText=@Sum
																						</C> 
																						<C> Name=�����ܾ� ID=SCH_LOAN_REMAIN_AMT Width=90  
																						</C> 
																						<C> Name=�������� ID=REFUND_SCH_INTR_AMT Width=90   SumText=@Sum
																						</C> 
																					</G>
																					<G> Name='��ǥ����' id=G4
																						<C> Name='������ǥ��ȣ' ID=LOAN_SLIP_NO Align=Center Width=120 
																						</C> 
																						<C> Name='��ȯ��ǥ��ȣ' ID=REFUND_SLIP_NO Align=Center Width=120 
																						</C> 
																						<C> Name='����������ǥ��ȣ' ID=INTR_SLIP_NO Align=Center Width=120 
																						</C> 
																					</G>
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
																		<td width="100%" height="100%">
																			<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__29"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																				<PARAM NAME="DataID" VALUE="dsSUB01">
																				<PARAM NAME="Editable" VALUE="-1">
																				<PARAM NAME="ColSelect" VALUE="-1">
																				<PARAM NAME="ColSizing" VALUE="-1">
																				<param name=UsingOneClick  value="1">
																				<PARAM NAME="Format" VALUE=" 
																					<FC> Name='������ȣ' ID=GUAR_NO Align=Center Width=100 
																					</FC> 
																					<FC> Name=����ó ID=GUARANTOR Width=120
																					</FC> 
																					<C> Name=�������� ID=GUAR_NOTE Width=200 
																					</C> 
																					<C> Name=���������� ID=GUAR_START_DT Width=90  align=Center EditStyle=Popup
																					</C> 
																					<C> Name=���������� ID=GUAR_END_DT Width=90  align=Center EditStyle=Popup  
																					</C>
																					<C> Name=�������� ID=GUAR_ORG_AMT Width=90
																					</C>
																					<C> Name=������ ID=GUAR_AMT Width=90
																					</C>
																					<C> Name=�������� ID=GUAR_RATE Width=90
																					</C>
																					<C> Name=�����ᳳ���� ID=GUAR_PAYMENT_DT Width=90 align=Center  EditStyle=Popup  
																					</C>
																					<C> Name=������ ID=GUAR_ESTAB_DT Width=90 align=Center  EditStyle=Popup  
																					</C>
																					<C> Name=������ ID=GUAR_CANCEL_DT Width=90 align=Center  EditStyle=Popup  
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