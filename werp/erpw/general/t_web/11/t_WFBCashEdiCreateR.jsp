<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WEdiCreateR.jsp(������ü���ϻ���)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-23) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null; 

//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WFBCashEdiCreateR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsCOPY=dsCOPY)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMP_NAME = "";
	String strPAY_KIND = "";	
	String strEMP_NO = "";	
	String strDate  = CITDate.getNow("yyyyMMdd");

	CITData		lrArgData = new CITData();
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strEMP_NO = CITCommon.toKOR((String)session.getAttribute("emp_no"));		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
			
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
		//����� ���� ����
		lrArgData = new CITData();
		try
		{			
			//���ޱ���
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
			var			sCompName = "<%=CITCommon.enSC(strCOMP_NAME)%>";

			
		// �̺�Ʈ����-------------------------------------------------------------------//

		//-->
		</script>

		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsBANK classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsACCOUNT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id="dsPASS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id="dsDateChk" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->	
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
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
											<td class=td_green>
												<!-- ���α׷��� ������ ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>�����</td>
														<td width="219">
															<table width="219" border="0" cellspacing="0" cellpadding="0">
															<td width="31">
																<input name="txtCOMP_CODE" type="text" class="ro" readOnly style="width:30px" VALUE="<%=strCOMP_CODE%>" ></td>
															<td width="155">
																<input name="txtCOMP_NAME" type="text" class="ro" readOnly style="width:155px" VALUE="<%=strCOMP_NAME%>" >
																<input name="txtEMP_NO" type="hidden" class="ro" style="width:30px" VALUE="<%=strEMP_NO%>" >
																<input name="txtMANAGER_PASS1" type="hidden" class="ro" style="width:30px" >
																<input name="txtMANAGER_PASS2" type="hidden" class="ro" style="width:30px" ></td>
															<td>&nbsp; </td>
															</table>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>���ޱ���</td>
														<td width="240">
															<table width="219" border="0" cellspacing="0" cellpadding="0">
																<td width="219">
																	<select id="txtPAY_GUBUN" style="WIDTH: 200px " onchange="btncontrol_onclick();">
																		<%=strPAY_KIND%>
																	</select>
																</td>
																<td>&nbsp; </td>
															</table>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" class="font_green_bold" >���޿�������</td>
														<td width="150">
															<table width="102" border="0" cellspacing="0" cellpadding="0">
																<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"></td>
																<td width="30"><input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
															</table>
														</td>	
														<td>&nbsp; </td>			
													</tr>
													<tr> 
													<td height="2"></td>
													</tr>
													<tr>													
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="60" class="font_green_bold" >�������</td>
													<td width="219">
														<table width="219" border="0" cellspacing="0" cellpadding="0">
															<td width="219">
																<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><object id=cboBANK_CODE width=188 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
																	<PARAM NAME="ComboStyle" VALUE="5">
																	<param name=ComboDataID		value=dsBANK>
																	<PARAM NAME="EditExprFormat" VALUE="%;NAME">
																	<PARAM name="ListExprFormat" value="%;NAME">
																	<param name=BindColumn  value="Name">			
																</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
															</td>
															<td>&nbsp; </td>
														</table>
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="60" class="font_green_bold" >��ݰ���</td>
													<td width="219">
														<table width="219" border="0" cellspacing="0" cellpadding="0">
															<td width="219">
																<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL ������������//--><object id=cboACCOUNT_NO width=202 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
																	<PARAM NAME="ComboStyle" VALUE="5">
																	<param name=ComboDataID		value=dsACCOUNT>
																	<PARAM NAME="EditExprFormat" VALUE="%;NAME">
																	<PARAM name="ListExprFormat" value="%;NAME">
																	<param name=BindColVal  value="Name">
																</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL ������������//-->															
															</td>
															<td>&nbsp; </td>
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
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> ��ü���ϻ����ڷ�</td>
														<td align="right" width="*">
														<input id="btnSELECT_ALL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSELECT_ALL_onClick()" 	value="��ü����" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
														<input id="btnCANCEL_ALL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnCANCEL_ALL_onClick()" 	value="�������" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
														<input id="btnEDI_CREATE"	  type="button" tabindex="-1" class="img_btn6_1" onClick="btnEDI_CREATE_onClick()"value="��ü���ϻ���" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
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
																	<td width="45" >�ѰǼ�</td>
																	<td width="160">
																	<input name="txtTOTAL_CNT" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60" >���ñݾ�</td>
																	<td width="160">
																	<input name="txtSELECT_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
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
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<param name=UsingOneClick  value="1">
													<PARAM NAME="Format" VALUE=" 
														<C> Name=seq ID=PAY_SEQ  Align=Center   Edit='none' Width=40  show=false
														</C>
														<C> Name=���� ID=SELECT_YN  Align=Center   Width=40  EditStyle=CheckBox
														</C>
														<C> Name=���ޱݾ� ID=PAY_AMT Align=Right  Edit='none' Width=150
														</C>
														<C> Name=���ޱ��� ID=PAY_KIND_GUBUN_NAME Align=Left  Edit='none' Width=100 
														</C>
														<C> Name=���޿����� ID=PAY_DUE_YMD Align=Center  Edit='none' Width=100
														</C>
														<C> Name=����ó ID=CUST_NAME  Align=Left  Edit='none' Width=200
														</C>
														<C> Name=�Ա����� ID=IN_BANK_CODE_NAME  Align=Left  Edit='none' Width=100
														</C>
														<C> Name=�Աݰ��¹�ȣ ID=IN_ACCOUNT_NO  Align=Left  Edit='none' Width=200
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL ������������//-->
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
														<td class="font_green_bold"> ��ü���ϻ����̷�</td>
														<td align="right" width="*">
															<input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>">
															<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															<input id="btnREC_SEND" type="button" class="img_btn5_1" value="�����Ͽ���" title="" onclick="btnRECSEND_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnEDI_DELETE" type="button" class="img_btn8_1" value="��ü���ϻ���" title="" onclick="btnEDIDELETE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnEDI_SEND" type="button" class="img_btn8_1" value="��ü���ϼ۽�" title="" onclick="btnEDISEND_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRESULT_RECV" type="button" class="img_btn6_1" value="ó���������" title="" onclick="btnRESULTRECV_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" VALUE="dsSUB01">
														<PARAM NAME="Editable" VALUE="-1">
														<PARAM NAME="ColSelect" VALUE="-1">														
														<PARAM NAME="ColSizing" VALUE="-1">
														<param name=UsingOneClick  value="1">
														<PARAM NAME="Format" VALUE=" 
															<C> Name=EDI�̷��Ϸù�ȣ ID=EDI_HISTORY_SEQ  Align=Center   Edit='none' Width=40  show=false
															</C>
															<C> Name=�������� ID=STD_YMD  Align=Center   Edit='none' Width=40  show=false
															</C>
															<C> Name=���ϸ� ID=SEND_FILE_NAME  Align=Center   Edit='none' Width=40  show=false
															</C>
															<C> Name=���� ID=SELECT_YN  Align=Center   Width=40  EditStyle=CheckBox
															</C>
															<C> Name=������� ID=OUT_BANK_CODE_NAME  Align=Left  Edit='none' Width=100
															</C>
															<C> Name=��ݰ��¹�ȣ ID=OUT_ACCOUNT_NO  Align=Left  Edit='none' Width=200
															</C>
															<C> Name=�ѱݾ� ID=PAY_AMT Align=Right  Edit='none' Width=150
															</C>
															<C> Name=�Ǽ� ID=EDI_CNT  Align=Center  Edit='none' Width=50
															</C>
															<C> Name=�۽��Ͻ� ID=SEND_DATE  Align=Center  Edit='none' Width=100
															</C>
															<C> Name=�����Ͻ� ID=RECV_DATE  Align=Center  Edit='none' Width=100
															</C>
															<C> Name=ó������޼��� ID=RESULT_TEXT  Align=Left  Edit='none' Width=200
															</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL ������������//-->
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