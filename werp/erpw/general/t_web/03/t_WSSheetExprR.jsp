<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WSSheetExprR(�繫��ǥ��ĵ��)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WSSheetExprR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN , I:dsSUB01=dsSUB01)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
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
			
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->

		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id="dsSHEET_CODE" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id="dsMAIN" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsSUB01" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="dsSELECT01" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id="dsSELECT02" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id="dsPOSITION" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id="dsREMAIN_CLS" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id="dsCALC_CLS" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><object id="dsMAKE" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><object id="dsMAKE2" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL ������������//--><object id="transMake"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	      <param name="KeyValue" value="Service1(I:dsMAKE=dsMAKE)">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL ������������//--><object id="transMake2"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	      <param name="KeyValue" value="Service1(I:dsMAKE2=dsMAKE2)">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td width="100" class="font_green_bold" >�繫��ǥ����</td>
											<TD width="135">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL ������������//--><OBJECT id="cbo_SHEET_CODE"  style="width:200px" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT >
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="ComboDataID" VALUE="dsSHEET_CODE">
													<PARAM NAME="EditExprFormat" VALUE="%;SHEET_NAME">
													<PARAM name="ListExprFormat" value="%;SHEET_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="0">
													<PARAM NAME="SearchColumn" VALUE="SHEET_NAME">
											    </OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL ������������//-->
											</TD>
											<td>&nbsp;</td>
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
					<td width="100%" height="250">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold">�繫��ǥ�׸�</td>
											<td align="right">
												<input id="btnMake2" type="button" class="img_btn4_1" value="��ĺ���" onclick="btnMake2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnMake" type="button" class="img_btn6_1" value="�����ڵ�����" onclick="btnMake_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
									<table width="100%" border="0" height="100%" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<param name="UsingOneClick" value=-1>
													<PARAM NAME="Format" VALUE="
														<FC> Name=�ڵ� ID=ITEM_CODE Width=80 Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'black',6,'black')}
														</FC>
														<C> Name=�׸�� ID='ITEM_NAME' Width=280 Color={Decode(ITEM_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'black',6,'black')}
														</C>
														">
													<PARAM NAME="DataID" VALUE="dsMAIN">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL ������������//-->
											</td>
											<td width="560" height="100%">
												<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">�׸�</td>
																	<td width="250">
																		<input id="txtITEM_CODE" type="text" datatype="N" ColName="�׸��ڵ�" maxlength="10" style="width : 80px">
																		<input id="txtITEM_NAME" type="text" datatype="HANC" ColName="�׸��" style="width : 160px">
																	</td>
																	<td width="*">&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">������</td>
																	<td width="160"><input id="txtITEM_ENG_NAME" type="text" datatype="HANC" ColName="������"  style="width : 160px"></td>
																	<td width="*">&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">��������</td>
																	<td width="90">
																		<select  id="cboITEM_LVL"  style="WIDTH: 100px">
																			<%
																			strSql  = "Select \n";
																			strSql  += "	a.CODE_LIST_ID , \n";
																			strSql  += "	a.CODE_LIST_NAME \n";
																			strSql  += "From	V_T_CODE_LIST a \n";
																			strSql  += "Where	a.CODE_GROUP_ID = 'ITEM_LVL' \n";
																			strSql  += "Order By \n";
																			strSql  += "	a.SEQ";
																			lrReturnData = CITDatabase.selectQuery(strSql, new CITData());
																			if(lrReturnData != null)
																			{
																				strOut = "";
																				for (int i = 0; i < lrReturnData.getRowsCount(); i++)
																				{
																					strOut += "<OPTION value='"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_ID"))+"'>"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_NAME"))+"</OPTION> ";
																				}
																				out.println(strOut);
																			}
																			%>
																		</select>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">��ȣ����</td>
																	<td width="90">
																		<select  id="cboSEQ_TYPE"  style="WIDTH: 100px">
																			<%
																			strSql  = "Select \n";
																			strSql  += "	a.SEQ_TYPE, \n";
																			strSql  += "	a.SEQ_TYPE_NAME \n";
																			strSql  += "From	T_SHEET_SEQ_TYPE a \n";
																			strSql  += "Union Select '0','�⺻����' from dual \n";
																			strSql  += "Order By \n";
																			strSql  += "	1";
																			lrReturnData = CITDatabase.selectQuery(strSql, new CITData());
																			if(lrReturnData != null)
																			{
																				strOut = "";
																				for (int i = 0; i < lrReturnData.getRowsCount(); i++)
																				{
																					strOut += "<OPTION value='"+CITCommon.enSC(lrReturnData.toString(i, "SEQ_TYPE"))+"'>"+CITCommon.enSC(lrReturnData.toString(i, "SEQ_TYPE_NAME"))+"</OPTION> ";
																				}
																				out.println(strOut);
																			}
																			%>
																		</select>
																	</td>
																	<td width="*">&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">���/����</td>
																	<td width="90">
																		<select  id="cboCURR_PAST_CLS"  style="WIDTH: 100px">
																			<%
																			strSql  = "Select \n";
																			strSql  += "	a.CODE_LIST_ID , \n";
																			strSql  += "	a.CODE_LIST_NAME , \n";
																			strSql  += "	a.SEQ \n";
																			strSql  += "From	V_T_CODE_LIST a \n";
																			strSql  += "Where	a.CODE_GROUP_ID = 'CURR_PAST_CLS' \n";
																			strSql  += "And		a.USE_TAG = 'T' \n";
																			strSql  += "Order By \n";
																			strSql  += "	a.SEQ, \n";
																			strSql  += "	a.CODE_LIST_ID";
																			lrReturnData = CITDatabase.selectQuery(strSql, new CITData());
																			if(lrReturnData != null)
																			{
																				strOut = "";
																				for (int i = 0; i < lrReturnData.getRowsCount(); i++)
																				{
																					strOut += "<OPTION value='"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_ID"))+"'>"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_NAME"))+"</OPTION> ";
																				}
																				out.println(strOut);
																			}
																			%>
																		</select>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">��ı���</td>
																	<td width="90">
																		<select  id="cboEXPR_SEQ1"  style="WIDTH: 100px">
																			<%
																			strSql  = "Select \n";
																			strSql  += "	a.CODE_LIST_ID , \n";
																			strSql  += "	a.CODE_LIST_NAME , \n";
																			strSql  += "	a.SEQ \n";
																			strSql  += "From	V_T_CODE_LIST a \n";
																			strSql  += "Where	a.CODE_GROUP_ID = 'EXPR_SEQ1' \n";
																			strSql  += "And		a.USE_TAG = 'T' \n";
																			strSql  += "Order By \n";
																			strSql  += "	a.SEQ, \n";
																			strSql  += "	a.CODE_LIST_ID";
																			lrReturnData = CITDatabase.selectQuery(strSql, new CITData());
																			if(lrReturnData != null)
																			{
																				strOut = "";
																				for (int i = 0; i < lrReturnData.getRowsCount(); i++)
																				{
																					strOut += "<OPTION value='"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_ID"))+"'>"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_NAME"))+"</OPTION> ";
																				}
																				out.println(strOut);
																			}
																			%>
																		</select>
																	</td>
																	<td width="*">&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">��¿���</td>
																	<td width="90">
																		<select  id="cboOUT_CLS"  style="WIDTH: 100px">
																			<%
																			strSql  = "Select \n";
																			strSql  += "	a.CODE_LIST_ID , \n";
																			strSql  += "	a.CODE_LIST_NAME , \n";
																			strSql  += "	a.SEQ \n";
																			strSql  += "From	V_T_CODE_LIST a \n";
																			strSql  += "Where	a.CODE_GROUP_ID = 'OUT_CLS' \n";
																			strSql  += "And		a.USE_TAG = 'T' \n";
																			strSql  += "Order By \n";
																			strSql  += "	a.SEQ, \n";
																			strSql  += "	a.CODE_LIST_ID";
																			lrReturnData = CITDatabase.selectQuery(strSql, new CITData());
																			if(lrReturnData != null)
																			{
																				strOut = "";
																				for (int i = 0; i < lrReturnData.getRowsCount(); i++)
																				{
																					strOut += "<OPTION value='"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_ID"))+"'>"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_NAME"))+"</OPTION> ";
																				}
																				out.println(strOut);
																			}
																			%>
																		</select>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="100">�û�ǥ�ܾ���ġ</td>
																	<td width="60">
																		<select  id="cboPOSITION"  style="WIDTH: 60px">
																			<%
																			strSql  = "Select \n";
																			strSql  += "	a.CODE_LIST_ID , \n";
																			strSql  += "	a.CODE_LIST_NAME , \n";
																			strSql  += "	a.SEQ \n";
																			strSql  += "From	V_T_CODE_LIST a \n";
																			strSql  += "Where	a.CODE_GROUP_ID = 'POSITION' \n";
																			strSql  += "And		a.USE_TAG = 'T' \n";
																			strSql  += "Order By \n";
																			strSql  += "	a.SEQ, \n";
																			strSql  += "	a.CODE_LIST_ID";
																			lrReturnData = CITDatabase.selectQuery(strSql, new CITData());
																			if(lrReturnData != null)
																			{
																				strOut = "";
																				for (int i = 0; i < lrReturnData.getRowsCount(); i++)
																				{
																					strOut += "<OPTION value='"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_ID"))+"'>"+CITCommon.enSC(lrReturnData.toString(i, "CODE_LIST_NAME"))+"</OPTION> ";
																				}
																				out.println(strOut);
																			}
																			%>
																		</select>
																	</td>
																	<td width="*">&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table width="100%"  border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">����</td>
																	<td width="60">
																		<select  id="cboUPLINE_CLS"  style="WIDTH: 50px">
																			<option value="T">�¿�</option>
																			<option value="L">��</option>
																			<option value="R">��</option>
																			<option value="F">����</option>
																		</select>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60">�Ʒ���</td>
																	<td width="60">
																		<select  id="cobDOWNLINE_CLS"  style="WIDTH: 50px">
																			<option value="T">�¿�</option>
																			<option value="L">��</option>
																			<option value="R">��</option>
																			<option value="F">����</option>
																		</select>
																	</td>
																	<td width="20">
																		<input id="chkBOLD_CLS" type="CheckBox" class="check" >
																	</td>
																	<td width="60">�������</td>
																	<td width="*">&nbsp;</td>
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
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
									<!-- �������� ���̺� ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="5"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- �������� ���̺� ���� //-->
					</td>
				</tr>
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="400">
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
														<td class="font_green_bold"> �������׸�</td>
														<td align="right">
															&nbsp;
														</td>
														<!-- ���α׷� ���� ���� //-->
													</tr>
												</table>
												<!-- ���� Ÿ��Ʋ ���� //-->
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
										<tr>
											<td bgcolor="#FFFFFF"  height="100%">
												<!-- ���α׷� ������ ���� //-->
												<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr  height="100%">
														<td HEIGHT="100%">
															<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																<PARAM NAME="Editable" VALUE="-1">
																<PARAM NAME="ColSelect" VALUE="-1">
																<PARAM NAME="ColSizing" VALUE="-1">
																<PARAM NAME="Format" VALUE="
																	<C> Name='����/�׸�' ID='ACC_CODE' Edit=None Width=80
																	</C>
																	<C> Name='����/�׸��' ID=ACC_CODE_NAME Edit=None Width=130
																	</C>
																	<C> Name='����' ID=REMAIN_CLS EditStyle=LookUp  Data='dsREMAIN_CLS:CODE_LIST_ID:CODE_LIST_NAME' Width=50
																	</C>
																	<C> Name='��ȣ' ID=CALC_CLS EditStyle=LookUp  Data='dsCALC_CLS:CODE_LIST_ID:CODE_LIST_NAME' Width=50
																	</C>
																	<C> Name='��ġ' ID='POSITION' EditStyle=LookUp  Data='dsPOSITION:CODE_LIST_ID:CODE_LIST_NAME' Width=50
																	</C>
																	">
																<PARAM NAME="DataID" VALUE="dsSUB01">
															</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL ������������//-->
														</td>
													</tr>
												</table>
												<!-- ���α׷� ������ ���� //-->
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10">
									&nbsp;
								</td>
								<td >
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
														<td class="font_green_bold"> ��������</td>
														<td align="right">
															&nbsp;
														</td>
														<!-- ���α׷� ���� ���� //-->
													</tr>
												</table>
												<!-- ���� Ÿ��Ʋ ���� //-->
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
										<tr>
											<td bgcolor="#FFFFFF"  height="100" width="100%">
												<!-- ���α׷� ������ ���� //-->
												<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr  height="100%">
														<td >
															<input id="btnApplySelect01" type="button" class="btn_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="<<" onclick="btnApplySelect01_onClick()"/>
														</td>
														<td width="10">
															&nbsp;
														</td>
														<td HEIGHT="100%" width="100%">
															<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSELECT01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																<PARAM NAME="Editable" VALUE="0">
																<PARAM NAME="ColSelect" VALUE="-1">
																<PARAM NAME="ColSizing" VALUE="-1">
																<PARAM NAME="Format" VALUE="
																	<C> Name=���� ID=ACC_LVL_NAME Width=40
																	</C>
																	<C> Name=�����ڵ� ID='ACC_CODE' Width=80 Color={Decode(ACC_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'blue',6,'#000066')}
																	</C>
																	<C> Name=������ ID='ACC_NAME' Width=160 Color={Decode(ACC_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'blue',6,'#000066')}
																	</C>
																	<C> Name=��ġ ID=ACC_REMAIN_POSITION_NAME Width=40
																	</C>
																	">
																<PARAM NAME="DataID" VALUE="dsSELECT01">
															</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL ������������//-->
														</td>
													</tr>
												</table>
												<!-- ���α׷� ������ ���� //-->
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
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
														<td class="font_green_bold"> ��ü����</td>
														<td align="right">
															&nbsp;
														</td>
														<!-- ���α׷� ���� ���� //-->
													</tr>
												</table>
												<!-- ���� Ÿ��Ʋ ���� //-->
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
										<tr>
											<td bgcolor="#FFFFFF"  height="100%" width="100%">
												<!-- ���α׷� ������ ���� //-->
												<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr  height="100%">
														<td>
															<input id="btnApplySelect02" type="button" class="btn_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="<<" onclick="btnApplySelect02_onClick()"/>
														</td>
														<td width="10">
															&nbsp;
														</td>
														<td HEIGHT="100%" width="100%">
															<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__18"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSELECT02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																<PARAM NAME="Editable" VALUE="0">
																<PARAM NAME="ColSelect" VALUE="-1">
																<PARAM NAME="ColSizing" VALUE="-1">
																<PARAM NAME="Format" VALUE="
																	<FC> Name=�ڵ� ID=ITEM_CODE Width=80
																	</FC>
																	<C> Name=�׸�� ID='ITEM_NAME' Width=240
																	</C>
																	">
																<PARAM NAME="DataID" VALUE="dsSELECT02">
															</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__18); </script> <!--CONVPAGE_TAIL ������������//-->
														</td>
													</tr>
												</table>
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
		</div>
		<!-- ���콺 Bind ��ü���� ���� //-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__19"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=ADE_Bind_1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
	<PARAM NAME="DataID" VALUE="dsMAIN">
	<PARAM NAME="BindInfo" VALUE="
		<C>Col=ITEM_CODE     Ctrl=txtITEM_CODE       Param=value    Disable=disabled	   </C>
		<C>Col=ITEM_NAME     Ctrl=txtITEM_NAME       Param=value    Disable=disabled     </C>
		<C>Col=ITEM_ENG_NAME Ctrl=txtITEM_ENG_NAME   Param=value    Disable=disabled		</C>
		<C>Col=CURR_PAST_CLS Ctrl=cboCURR_PAST_CLS   Param=value    Disable=disabled		</C>
		<C>Col=POSITION      Ctrl=cboPOSITION        Param=value    Disable=disabled		</C>
		<C>Col=EXPR_SEQ1     Ctrl=cboEXPR_SEQ1       Param=value    Disable=disabled		</C>
		<C>Col=OUT_CLS       Ctrl=cboOUT_CLS         Param=value    Disable=disabled		</C>
		<C>Col=BOLD_CLS      Ctrl=chkBOLD_CLS        Param=checked  Disable=disabled		</C>
		<C>Col=UPLINE_CLS    Ctrl=cboUPLINE_CLS      Param=value    Disable=disabled		</C>
		<C>Col=DOWNLINE_CLS  Ctrl=cobDOWNLINE_CLS    Param=value    Disable=disabled		</C>
		<C>Col=ITEM_LVL      Ctrl=cboITEM_LVL        Param=value    Disable=disabled		</C>
		<C>Col=SEQ_TYPE      Ctrl=cboSEQ_TYPE        Param=value    Disable=disabled		</C>
		">
</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__19); </script> <!--CONVPAGE_TAIL ������������//-->
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