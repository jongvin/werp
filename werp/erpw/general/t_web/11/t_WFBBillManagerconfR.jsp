<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFBManagerconfR.jsp(�������޽���)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-20)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFBBillManagerconfR";
	String strPageName = "t_WFBBillManagerconfR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strPAY_KIND = "";
	String strCOMP_MAIN = "";
	String strCOMP_CODE = "";
	String strCOMP_NAME = "";
	String strDEPT_CODE = "";
	String strEMP_NO = "";	
	String strBANK_CODE = "";
	String strDate = CITDate.getNow("yyyy-MM-dd");

	try
	{
		CITCommon.initPage(request, response, session);
		CITData lrArgData = new CITData();
		
		try
		{	//���ޱ���
			strSql  = 
				"select "+"\n"+
				"	2 GB,"+"\n"+
				"	a.LOOKUP_CODE  CODE, "+"\n"+
				"	a.LOOKUP_VALUE NAME  "+"\n"+
				"from	T_FB_LOOKUP_VALUES a "+"\n"+
				"where lookup_type = upper('pay_kind_gubun')"+"\n"+
				"and   use_yn      = 'Y'"+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	1,"+"\n"+
				"	'%',"+"\n"+
				"	'��ü'"+"\n"+
				"From	Dual"+"\n"+
				"order by"+"\n"+
				"	1,2"+"\n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strPAY_KIND = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
			
			//ó������
			strSql  = 
				"select "+"\n"+
				"	2 GB,"+"\n"+
				"	a.LOOKUP_CODE  CODE, "+"\n"+
				"	a.LOOKUP_VALUE NAME  "+"\n"+
				"from	T_FB_LOOKUP_VALUES a "+"\n"+
				"where lookup_type = upper('bill_pay_status')"+"\n"+
				"and   LOOKUP_CODE <> '0'"+"\n"+
				"and   use_yn      = 'Y'"+"\n"+
				"order by"+"\n"+
				"	1,2"+"\n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strCOMP_MAIN = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");			

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
	strEMP_NO = CITCommon.toKOR((String)session.getAttribute("emp_no"));
	if(CITCommon.isNull(strCOMP_CODE))
	{
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		CITData		lrArgData = new CITData();
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
				strCOMP_NAME = lrReturnData.toString(0,"COMPANY_NAME");
	
				session.setAttribute("comp_code", strCOMP_CODE);
				session.setAttribute("comp_name", strCOMP_NAME);
			}				
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
	}
	else
	{
		strCOMP_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
	}
	try
	{
		CITData lrArgData = new CITData();
		
		lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
		lrArgData.addRow();
		lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			
		//���ฮ��Ʈ
		strSql  = 
			"select "+"\n"+
			"	a.BANK_MAIN_CODE  CODE, "+"\n"+
			"	a.BANK_MAIN_NAME NAME  "+"\n"+
			"from	VIEW_FBS_ACCOUNTS a "+"\n"+
			"where a.COMP_CODE = ? "+"\n"+
			"and   a.FBS_TRANSFER_CLS = 'T' "+"\n"+
			"group by"+"\n"+
			"	a.BANK_MAIN_CODE , "+"\n"+ 
			"	a.BANK_MAIN_NAME "+"\n";
			
		lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
		strBANK_CODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
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
			var			sCompCode = "<%=strCOMP_CODE%>";

		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="dsPASS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->				
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	    <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td class=td_green>
												<!-- ���α׷��� ������ ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class=font_green_bold>�����</td>
														<td width="219">
														<table width="219" border="0" cellspacing="0" cellpadding="0">
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
														<td width="70" class=font_green_bold>���ޱ���</td>
														<td width="313">
														<table width="313" border="0" cellspacing="0" cellpadding="0">
														<td width="230">
															<select id="txtPAY_GUBUN" style="WIDTH: 200px " ;">
																<%=strPAY_KIND%>
															</select>
														</td>
														</table>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class=font_green_bold>ó������</td>
														<td width="150">
															<select id="txtPAY_STATUS" style="WIDTH: 150px " onchange="btnquery_onclick();">
																<%=strCOMP_MAIN%>
															</select>
														</td>														
														<td>&nbsp; </td>			
													</tr>
													<tr>													
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="70" class="font_green_bold" >��������</td>													
													<td width="219">
													<table width="219" border="0" cellspacing="0" cellpadding="0">
													<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"></td>
													<td width="30"><input id="btnDTS_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
													<td width="15">~</td>
													<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"></td>
													<td width="30"><input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
													</table>	
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="70" class="font_green_bold" >����ó</td>
													<td width="313">
													<table width="313" border="0" cellspacing="0" cellpadding="0">
													<td width="112"> <input name="txtCUST_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtCUST_CODE_onblur()"></td>
													<td width="161"> <input name="txtCUST_NAME" type="text" class="ro" readOnly style="width:159px" VALUE="">
													<input name="txtCUST_SEQ" type="hidden" class="ro" style="width:159px" VALUE="">
													</td>
													<td width="40">
														<input name="btnCUST_CODE" type="button" class="img_btnFind" onclick="btnCUST_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" /></td>
													</table>													
													</td>	
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="70" class=font_green_bold>����</td>
													<td width="150">
														<select id="txtBANK_CODE" style="WIDTH: 150px " ;">
															<%=strBANK_CODE%>
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
											<td class="font_green_bold"> ���ھ������γ���</td>
											<td align="right" width="*">
											<input id="btnSELECT_ALL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSELECT_ALL_onClick()" 	value="��ü����" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											<input id="btnCANCEL_ALL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnCANCEL_ALL_onClick()" 	value="�������" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											<input id="btnCASH_CONFIRM"	type="button" tabindex="-1" class="img_btn6_1" onClick="btnCASH_CONFIRM_onClick()"value="���ε��" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											<input id="btnCASH_CANCEL" 	type="button" tabindex="-1" class="img_btn7_1" onClick="btnCASH_CANCEL_onClick()" value="���ε�����" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
											<input id="btnCASH_PRINT" 	type="button" tabindex="-1" class="img_btn4_1" onClick="btnCASH_PRINT_onClick()" 	value="���" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
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
											<td width="100%" style="background:#F6F6F6">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td >
															<!-- ���α׷��� ������ ���� //-->
															<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="black">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >�ѱݾ�</td>
																	<td width="160">
																	<input name="txtTOTAL_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>													
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="84" >���οϷ�ݾ�</td>
																	<td width="160">
																	<input name="txtPAY_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC"  ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="70" >�̽��αݾ�</td>
																	<td width="160">
																	<input name="txtNOPAY_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60" >���ñݾ�</td>
																	<td width="160">
																	<input name="txtSELECT_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>																															
																	<td>&nbsp; </td>			
																</tr>
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >�ѰǼ�</td>
																	<td width="160">
																	<input name="txtTOTAL_CNT" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>													
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="84" >���οϷ�Ǽ�</td>
																	<td width="160">
																	<input name="txtPAY_CNT" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC"  ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="70" >�̽��ΰǼ�</td>
																	<td width="160">
																	<input name="txtNOPAY_CNT" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60" >���ðǼ�</td>
																	<td width="160">
																	<input name="txtSELECT_CNT" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE="
											<C> Name=seq ID=PAY_SEQ  Align=Center   Edit='none' Width=40  show=false
											</C>
											<C> Name=���� ID=SELECT_YN  Align=Center   Width=40  EditStyle=CheckBox
											</C>
											<C> Name=���ޱݾ� ID=PAY_AMT Align=Right  Edit='none' Width=70
											</C>
											<C> Name=���ޱ��� ID=PAY_KIND_GUBUN_NAME Align=Left  Edit='none' Width=100 
											</C>
											<C> Name=ó������ ID=PAY_STATUS_NAME  Align=Left  Edit='none' Width=70
											</C>
											<C> Name=ó������ ID=PAY_STATUS  Align=Left  Edit='none' Width=70 show=false
											</C>
											<C> Name=�������� ID=PAY_DUE_YMD Align=Center  Edit='none' Width=70
											</C>
											<C> Name=������ ID=PAY_YMD Align=Center  Edit='none' Width=70 show=false
											</C>											
											<C> Name=������ ID=FUTURE_YMD  Align=Center   Width=70
											</C>
											<C> Name=����ó����ڹ�ȣ ID=REGIST_NUM  Align=Center   Width=100
											</C>
											<C> Name=����ó�� ID=CUST_NAME  Align=Left  Edit='none' Width=70
											</C>
											<C> Name=ī��or��ǥ��ȣ ID=CHECK_NO  Align=Left  Edit='none' Width=100
											</C>
											<C> Name=����� ID=OUT_BANK_CODE_NAME  Align=Left  Edit='none' Width=70
											</C>											
											<C> Name=������� ID=DESCRIPTION  Align=Left Edit='none'  Width=70
											</C>
											<C> Name=����� ID=COMPANY_NAME Align=Left Edit='none'  Width=100
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
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