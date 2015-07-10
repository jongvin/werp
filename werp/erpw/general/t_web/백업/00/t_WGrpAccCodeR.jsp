<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WUserAuthR.jsp(����ں����Ѱ���)
/* 2. ����(�ó�����) : Left-Right(Master-Detail)
/* 3. ��  ��  ��  �� : ����ں����Ѱ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : ����
/* 6. Ư  ��  ��  �� : ����
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WGrpAccCodeR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strACC_LVL = "";
	String strACC_GRP1 = "";
	String strACC_REMAIN_POSITION = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		CITData lrArgData = new CITData();
		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME, \n";
			strSql += "		a.SEQ \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'ACC_GRP' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By \n";
			strSql += "	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_GRP1 = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �����׷��ڵ�1 Select ���� -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME, \n";
			strSql += "		a.SEQ \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By \n";
			strSql += "	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_REMAIN_POSITION = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �����׷��ڵ�1 Select ���� -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME, \n";
			strSql += "		a.SEQ \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'ACC_LVL' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By \n";
			strSql += "	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_LVL = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ���������ڵ� Select ���� -> " + ex.getMessage());
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
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<object id="dsMAIN" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object>
		<object id="dsSUB01" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object>
		<object id="dsSUB02" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object>
		<object id="dsCOPY" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object>
		<object id="dsSET" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object>
		<object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
		<object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
		<object id="transSet"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="Service1(I:dsSET=dsSET)">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- ���� ���̺� ���� //-->
						<!--
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="120" class="font_green_bold" >���� �Ǵ� ���</td>
											<td width="200"><input id="txtSEARCH_CONDITION" type="text" style="width:150px"></td>
											<td width="*" align="right">
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
						</table>
						//-->
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
				<tr>
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="280" height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> �����׷�</td>
														<td align="right" width="*">
															&nbsp;
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
										<tr>
											<td height="100%">
												<OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<C> Name=�׷��ڵ� ID=ACC_GRP_CODE Align=Center  Width=70 </C>
														<C> Name=�׷��   ID=ACC_GRP_NAME Align=Left  Width=130 </C>
														<C> Name=��� ID=USE_TAG EditStyle='checkbox' Align=Center  Width=30
														</C>
														">
													<PARAM NAME="DataID" VALUE="dsMAIN">
												</OBJECT>
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10"></td>
								<td width="*">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="48%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="100%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> ���õ� ���������ڵ�</td>
																				<td align="right" width="*">
<input name="btnAllCheck1" type="button" class="btn60" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="��ü����" onclick="btnAllCheck1_onClick()"/>
&nbsp;
<input name="btnAllUnCheck1" type="button" class="btn60" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="��ü����" onclick="btnAllUnCheck1_onClick()"/>
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
																<tr>
																	<td height="100%" width="100%">
																		<OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=MultiRowSelect  value="false">
																			<PARAM NAME="Format" VALUE="
<FC> Name=����     ID=CHK_CLS EditStyle='checkbox' Align=Center  Width=30</FC>
<FC> Name=�����ڵ� ID=ACC_CODE Align=Center Width=70 EditLimit=10 Edit='none'</FC>
<C> Name=�׷� ID=ACC_GRP Align=Center EditStyle=Combo Data='<%=strACC_GRP1%>' Width=40 Edit='none'</C>
<C> Name=���� ID=ACC_LVL Align=Center EditStyle=Combo Data='<%=strACC_LVL%>' Width=40 Edit='none'</C>
<C> Name=������ ID=ACC_NAME Align=Left Width=220 Color={Decode(ACC_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'blue',6,'#000066')} Edit='none'</C>
<C> Name=������Ҹ� ID=ACC_SHRT_NAME Align=Left Width=185 </C>
<C> Name=�����ܾ���ġ ID=ACC_REMAIN_POSITION Align=Center Edit='none'  EditStyle=Combo Data='<%=strACC_REMAIN_POSITION%>' Width=90</C>
<C> Name=�Է±��� ID=FUND_INPUT_CLS Align=Center Edit='none' EditStyle=CheckBox Width=50 </C>
																				">
																			<PARAM NAME="DataID" VALUE="dsSUB01">
																		</OBJECT>
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
										<tr>
											<td width="100%" height="4%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100%" align='center'>
															<input name="btnGrantCompCode" type="button" class="btn" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="����" onclick="btnGrantCompCode_onClick()"/>
															&nbsp;
															<input name="btnRevokeCompCode" type="button" class="btn" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="����" onclick="btnRevokeCompCode_onClick()"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="48%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="100%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> ���õ��� ���� ���������ڵ�</td>
																				<td align="right" width="*">
<input name="btnAllCheck2" type="button" class="btn60" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="��ü����" onclick="btnAllCheck2_onClick()"/>
&nbsp;
<input name="btnAllUnCheck2" type="button" class="btn60" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="��ü����" onclick="btnAllUnCheck2_onClick()"/>
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
																<tr>
																	<td height="100%" width="100%">
																		<OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=MultiRowSelect  value="false">
																			<PARAM NAME="Format" VALUE="
<FC> Name=����     ID=CHK_CLS EditStyle='checkbox' Align=Center  Width=30</FC>
<FC> Name=�����ڵ� ID=ACC_CODE Align=Center Width=70 EditLimit=10 Edit='none'</FC>
<C> Name=�׷� ID=ACC_GRP Align=Center EditStyle=Combo Data='<%=strACC_GRP1%>' Width=40 Edit='none'</C>
<C> Name=���� ID=ACC_LVL Align=Center EditStyle=Combo Data='<%=strACC_LVL%>' Width=40 Edit='none'</C>
<C> Name=������ ID=ACC_NAME Align=Left Width=220 Color={Decode(ACC_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'blue',6,'#000066')} Edit='none'</C>
<C> Name=������Ҹ� ID=ACC_SHRT_NAME Align=Left Width=185 </C>
<C> Name=�����ܾ���ġ ID=ACC_REMAIN_POSITION Align=Center Edit='none'  EditStyle=Combo Data='<%=strACC_REMAIN_POSITION%>' Width=90</C>
<C> Name=�Է±��� ID=FUND_INPUT_CLS Align=Center Edit='none' EditStyle=CheckBox Width=50 </C>
																				">
																			<PARAM NAME="DataID" VALUE="dsSUB02">
																		</OBJECT>
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
