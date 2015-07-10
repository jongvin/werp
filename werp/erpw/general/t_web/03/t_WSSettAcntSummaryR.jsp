<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WSSettAcntSummaryR(�繫��ǥ�������ȸ(����庰�μ�))
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WSSettAcntSummaryR";
	String strPageName = "t_WSSettAcntSummaryR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsHEAD=dsHEAD)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String	strDATE			= CITDate.getNow("yyyy-MM-dd");
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	CITData		lrArgData = new CITData();
	
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
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
			var			vDATE 				= '<%=strDATE%>';
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->

		<script language="JavaScript" for="cboSHEET_CODE" event="OnSelChange()">
			ChangeFormat();
			Retrieve();
		</script>
		<script language="JavaScript" for="cboCOMP_CODE" event="OnSelChange()">
			EnableDisableProjCode();
			Retrieve();
		</script>
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id="dsSEARCH" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id="dsSHEET_CODE" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsACC_ID" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="dsCOMPANY" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id="dsHEAD" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id="dsMAIN" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id="dsMAKE" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id="dsDEPT_CODE" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><object id="dsSHEET_DEL" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><object id="dsFULL_PROJ" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL ������������//-->
		
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL ������������//--><object id="dsCFULL_PROJ" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		   <param name=DataID		value="dsFULL_PROJ">
		   <param name=Logical	   value="true">
			<param name=GroupExpr	value="ITEM_CODE:ITEM_NAME:ITEM_LVL,PROJ_NAME,CURR_AMT:PAST_AMT">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL ������������//--><object id="transMake"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	      <param name="KeyValue" value="Service1(I:dsMAKE=dsMAKE)">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL ������������//-->
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
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="100" class="font_green_bold" >�繫��ǥ����</td>
											<TD width="185">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL ������������//--><OBJECT id="cboSHEET_CODE"  style="width:180px" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT>
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="ComboDataID" VALUE="dsSHEET_CODE">
													<PARAM NAME="EditExprFormat" VALUE="%;SHEET_NAME">
													<PARAM name="ListExprFormat" value="%;SHEET_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="0">
													<PARAM NAME="SearchColumn" VALUE="SHEET_NAME">
													<PARAM NAME="BindColumn"  VALUE="SHEET_CODE">
											    </OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL ������������//-->
											</TD>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="100" class="font_green_bold" >�����</td>
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
											<td width="70" class="font_green_bold" >�μ�/����</td>
											<TD width="52">
												<input id="txtDEPT_CODE" type="text" datatype="AN" UpperCase ColName="�����ڵ�"  style="width : 50px" >
											</TD>
											<TD width="202">
												<input id="txtPROJ_NAME" type="text" datatype="HAN" UpperCase readOnly class="ro" ColName="�����" style="width : 200px" >
											</TD>
											<TD width="40">
												<input id="btnSearchProj" type="button" class="img_btnFind" value="�˻�" onclick="btnSearchProj_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</TD>
											<td width="5">&nbsp;</td>
											<td width="20"><input id="chkDEPT_CODE" type="checkbox" class="check" onfocus="this.blur()" onClick="chkDEPT_CODE_onclick()"></td>
											<td>������</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td height="5"></td>
							</tr>
							<!-- ���α׷��� ������ ���� //-->
							<tr valign="top"> 
								<td width="100%" height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<!-- ���� ���̺� ���� //-->
												<!-- �������� ���̺� ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="10"></td>
													</tr>
												</table>
												<!-- �������� ���̺� ���� //-->
												<!-- ���� ���̺� ���� //-->
												<!-- ���� Ÿ��Ʋ ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<!-- ���α׷� ���� ���� //-->
														<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
														<td width="120" class="font_green_bold"> �繫��ǥ�ۼ�����</td>
														<td align="right">
															<input id="btnMake" type="button" class="img_btn6_1" value="�繫��ǥ����" onclick="btnMake_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnPreview" type="button" class="img_btn2_1" value="�μ�" onclick="btnPreview_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<!-- ���α׷� ���� ���� //-->
													</tr>
												</table>
												<!-- ���� Ÿ��Ʋ ���� //-->
											</td>
										</tr>
										<tr>
											<td height="30">
												<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
													<tr>
														<td >
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="50">���</td>
																	<td width="72">
																		<input id="txtCURR_ACC_FDT_H"	type="hidden">
																		<input id="txtCURR_ACC_FDT" type="text"  DataType="DATE" ColName="��������" style="width : 70px" onchange="txtCURR_ACC_FDT_onchange()" onfocus="txtCURR_ACC_FDT_H.value = txtCURR_ACC_FDT.value">
																	</td>
																	<td width=22>
																		<input id="btnCURR_ACC_FDT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnCURR_ACC_FDT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																	</td>
																	<td width="10">
																		~
																	</td>
																	<td width="72">
																		<input id="txtCURR_ACC_EDT_H"	type="hidden">
																		<input id="txtCURR_ACC_EDT" type="text" DataType="DATE"  ColName="���������" style="width : 70px" onchange="txtCURR_ACC_EDT_onchange()" onfocus="txtCURR_ACC_EDT_H.value = txtCURR_ACC_EDT.value">
																	</td>
																	<td width=22>
																		<input id="btnCURR_ACC_EDT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnCURR_ACC_EDT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																	</td>
																	<td width="80">
																		<input id="txtCURR_ACC_ID" type="text" readOnly datatype="HNC" class="ro" ColName="���" style="width : 40px">&nbsp;��
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="50">����</td>
																	<td width="72">
																		<input id="txtPAST_ACC_FDT_H"	type="hidden">
																		<input id="txtPAST_ACC_FDT" type="text"  DataType="DATE" ColName="���������" style="width : 70px" onchange="txtPAST_ACC_FDT_onchange()" onfocus="txtPAST_ACC_FDT_H.value = txtPAST_ACC_FDT.value">
																	</td>
																	<td width=22>
																		<input id="btnPAST_ACC_FDT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnPAST_ACC_FDT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																	</td>
																	<td width="10">
																		~
																	</td>
																	<td width="72">
																		<input id="txtPAST_ACC_EDT_H"	type="hidden">
																		<input id="txtPAST_ACC_EDT" type="text" DataType="DATE"  ColName="����������" style="width : 70px" onchange="txtPAST_ACC_EDT_onchange()" onfocus="txtPAST_ACC_EDT_H.value = txtPAST_ACC_EDT.value">
																	</td>
																	<td width=22>
																		<input id="btnPAST_ACC_EDT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnPAST_ACC_EDT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																	</td>
																	<td width="80">
																		<input id="txtPAST_ACC_ID_H"	type="hidden">
																		<input id="txtPAST_ACC_ID" type="text" readOnly datatype="HNC" class="ro" ColName="����" style="width : 40px" onfocus="txtPAST_ACC_ID_H.value = txtPAST_ACC_ID.value">&nbsp;��
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">�ۼ���</td>
																	<td width="72">
																		<input id="txtEDIT_DT" type="text" DataType="DATE"  ColName="�ۼ���" style="width : 70px" >
																	</td>
																	<td width=22>
																		<input id="btnEDIT_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnEDIT_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																	</td>
																	<td>
																	&nbsp;
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td  height="100%" width="100%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
													<tr>
														<td bgcolor="#FFFFFF"  height="100%">
															<!-- ���α׷� ������ ���� //-->
															<div id="divgridMAIN" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
				   											<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
				   												<tr>
				   													<td HEIGHT="100%">
				   														<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
				   															<PARAM NAME="Editable" VALUE="-1">
				   															<PARAM NAME="ColSelect" VALUE="-1">
				   															<PARAM NAME="ColSizing" VALUE="-1">
				   															<param name="UsingOneClick" value=-1>
				   															<PARAM NAME="Format" VALUE="
				   																<FC> Name=�ڵ� ID=ITEM_CODE Width=80
				   																</FC>
				   																<C> Name=�׸�� ID='ITEM_NAME' Width=280
				   																</C>
				   																<G> Name='����' id=G1
				   																	<C> Name='����ݾ�(��)' ID='PAST_LEFT' Width=100
				   																	</C>
				   																	<C> Name='����ݾ�(��)' ID='PAST_RIGHT' Width=100
				   																	</C>
				   																</G>
				   																<G> Name='���' id=G2
				   																	<C> Name='���ݾ�(��)' ID='CURR_LEFT' Width=100
				   																	</C>
				   																	<C> Name='���ݾ�(��)' ID='CURR_RIGHT' Width=100
				   																	</C>
				   																</G>
				   																">
				   															<PARAM NAME="DataID" VALUE="dsMAIN">
				   														</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL ������������//-->
				   													</td>
				   												</tr>
				   											</table>
				   										</div>
				   										<div id="divgridMAIN1" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
				   											<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
				   											   <tr>
				   											      <td HEIGHT="100%">
				                                          	<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL ������������//--><object id=gridMAIN1 classid=CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49	height="100%" width="100%">
				                                          		<param name="DataID"		value="dsCFULL_PROJ">
				                                          		<PARAM NAME="Editable" VALUE="-1">
				                                          		<PARAM NAME="ColSelect" VALUE="-1">
				   															<PARAM NAME="ColSizing" VALUE="-1">
				   															<param name="UsingOneClick" value=-1>
				                                          		<param name="Format"		value='
				                                          			<FC>id=ITEM_NAME	name="�׸��" width=230</FC>
				                                          			<R>
				                                          			   <G>name=$xkeyname_$$
				                                        					   <C>id=CURR_AMT_$$	name="���ݾ�"	width=120 BgColor=#FFECEC </C>
				                                        					   <C>id=PAST_AMT_$$	name="����ݾ�"	width=120 BgColor=#E0F4FF</C>
				                                        					</G>
				                                          			</R>
				                                          			'>
				                                          	</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL ������������//-->
				                                          </td>
				                                 		</tr>
				                                 	</table>
				   										</div>
															<!-- ���α׷� ������ ���� //-->
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