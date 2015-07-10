<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_PLovFilterR(�����˾��� ���͵��)
/* 2. ����(�ó�����) : �����˾��� ���� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	String strLovNo = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>ȸ�����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var strLovNo = "<%=strLovNo%>";
			
			function Initialize()
			{
				G_addDataSet(dsFilters, trans, gridFilters, null, "����");
				G_addDataSet(dsFilterArgs, trans, gridFilterArgs, null, "���� �Է�����");
				G_addDataSet(dsFilterSeq, null, null, "t_PLovFilterR_q.jsp?ACT=FILTER_SEQ", "���͹�ȣ");
				G_addDataSet(dsFilterArgSeq, null, null, "t_PLovFilterR_q.jsp?ACT=FILTER_ARG_SEQ", "�������ڹ�ȣ");
				G_addDataSet(dsArgsList, null, null, null, "�Է����� ����Ʈ");
				G_addDataSet(dsResult, null, null, null, "SQL ������");
				
				G_addRel(dsFilters, dsFilterArgs);
				G_addRelCol(dsFilterArgs, "LOV_NO", "LOV_NO");
				G_addRelCol(dsFilterArgs, "FILTER_SEQ", "FILTER_SEQ");
				
				G_Load(dsArgsList, null);
				G_Load(dsFilters, null);
				
				gridFilters.focus();
			}
			
			// ���ǰ��� �Լ�----------------------------------------------------------------//
			function SetSession()
			{
			}
			
			function GetSession()
			{
			}
			
			function ReportSession(asName, asValue)
			{
			}
			
			// �Լ�����---------------------------------------------------------------------//
			function checkFilter()
			{
				if (dsFilters.RowPosition < 1)
				{
					C_msgOk("���͸� �����Ͻʽÿ�.");
					return false;
				}
				
				return true;
			}
			
			function checkSave()
			{
				if (dsFilters.IsUpdated || G_isChanged(dsFilters.id))
				{
					var ret = C_msgYesNo("����� ������ �ݵ�� �����ϼž� �մϴ�.<br><br>" + G_MSG_SAVE, "����");
			
					if (ret == "Y")
					{
						G_saveAllData(dsFilters);
					}
					else
					{
						return false;
					}
				}
				
				return true;
			}
			
			// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
			// ��ȸ
			function btnquery_onclick()
			{
				if (G_FocusDataset == dsFilters)
				{
					G_Load(dsFilters, null);
				}
				else if (G_FocusDataset == dsFilterArgs)
				{
					if (checkFilter()) G_Load(dsFilterArgs, null);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// �߰�
			function btnadd_onclick()
			{
				if (G_FocusDataset == dsFilters)
				{
					G_addRow(dsFilters);
				}
				else if (G_FocusDataset == dsFilterArgs)
				{
					if (checkFilter()) G_addRow(dsFilterArgs);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ����
			function btninsert_onclick()
			{
				if (G_FocusDataset == dsFilters)
				{
					G_insertRow(dsFilters);
				}
				else if (G_FocusDataset == dsFilterArgs)
				{
					if (checkFilter()) G_insertRow(dsFilterArgs);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ����
			function btndelete_onclick()
			{
				if (G_FocusDataset == dsFilters)
				{
					if (dsFilters.CountRow < 1) return;
				
					var ret = C_msgYesNo("�����Ͻðڽ��ϱ�?", "����");
					
					if (ret == "Y")
					{
						dsFilterArgs.ClearData();
						G_deleteRow(dsFilters);
					}
				}
				else if (G_FocusDataset == dsFilterArgs)
				{
					if (checkFilter()) G_deleteRow(dsFilterArgs);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ����
			function btnsave_onclick()
			{
				if (G_FocusDataset == dsFilters)
				{
					G_saveDataMsg(dsFilters);
				}
				else if (G_FocusDataset == dsFilterArgs)
				{
					if (checkFilter()) G_saveDataMsg(dsFilterArgs);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsFilters)
				{
					dataset.DataID = "t_PLovFilterR_q.jsp?ACT=FILTERS";
					dataset.DataID += "&LOV_NO=" + strLovNo;
				}
				else if (dataset == dsFilterArgs)
				{
					dataset.DataID = "t_PLovFilterR_q.jsp?ACT=FILTER_ARGS";
					dataset.DataID += "&LOV_NO=" + strLovNo;
					dataset.DataID += "&FILTER_SEQ=" + dsFilters.NameString(dsFilters.RowPosition, "FILTER_SEQ");
				}
				else if (dataset == dsArgsList)
				{
					dataset.DataID = "t_PLovFilterR_q.jsp?ACT=ARGS_LIST";
					dataset.DataID += "&LOV_NO=" + strLovNo;
				}
				else if (dataset == dsResult)
				{
					dataset.DataID = "t_PLovFilterR_q.jsp?ACT=SQL";
					dataset.DataID += "&LOV_NO=" + strLovNo;
					dataset.DataID += "&FILTER_SEQ=" + dsFilters.NameString(dsFilters.RowPosition, "FILTER_SEQ");
				}
			}
			
			function OnRowInserted(dataset, row)
			{
				if (dataset == dsFilters)
				{
					G_Load(dsFilterSeq, null);
					
					dsFilters.NameValue(row, "LOV_NO") = strLovNo;
					dsFilters.NameValue(row, "FILTER_SEQ") = dsFilterSeq.NameString(dsFilterSeq.RowPosition, "FILTER_SEQ");
					dsFilters.NameValue(row, "DIS_SEQ") = dsFilters.NameMax("DIS_SEQ", 0, 0) + 1;
					dsFilters.NameValue(row, "FILTER_NAME") = "FILTER_" + dsFilters.NameString(row, "DIS_SEQ");
					dsFilters.NameValue(row, "TYPE") = "S";
					dsFilters.NameValue(row, "LABEL_NAME") = dsFilters.NameValue(row, "FILTER_NAME");
					dsFilters.NameValue(row, "LABEL_WIDTH") = 50;
					dsFilters.NameValue(row, "WIDTH") = 100;
				}
				else if (dataset == dsFilterArgs)
				{
					G_Load(dsFilterArgSeq, null);
					
					dsFilterArgs.NameValue(row, "FILTER_ARG_SEQ") = dsFilterArgSeq.NameString(dsFilterArgSeq.RowPosition, "FILTER_ARG_SEQ");
					dsFilterArgs.NameValue(row, "DIS_SEQ") = dsFilterArgs.NameMax("DIS_SEQ", 0, 0) + 1;
					dsFilterArgs.NameValue(row, "TYPE") = "A";
				}
			}
			
			function OnColumnChanged(dataset, row, colid)
			{
				if (dataset == dsFilters)
				{
					if (colid == "DIS_SEQ")
					{
						dataset.NameValue(row, "FILTER_NAME") = "FILTER_" + dataset.NameString(row, colid);
					}
					else if (colid == "TYPE")
					{
						if (dataset.NameString(row, colid) == "D")
						{
							dataset.NameValue(row, "DATE_TYPE") = "D";
						}
						else
						{
							dataset.NameValue(row, "DATE_TYPE") = "";
						}
					}
				}
			}
			
			// �̺�Ʈ����-------------------------------------------------------------------//
			function document_onKeyDown()
			{
				if (event.keyCode == 27)
				{
					imgCancle_onClick();
				}
			}
			
			function btnExeSql_onClick()
			{
				if (!checkFilter()) return;
				if (!checkSave()) return;
				
				if (dsFilters.NameString(dsFilters.RowPosition, "TYPE") != "C")
				{
					C_msgOk("�޺�Ÿ���� ���͸� SQL ������ �����մϴ�.");
					return;
				}
				
				G_Load(dsResult, null);
				
				if (dsResult.NameString(0, "RESULT") == "OK")
				{
					C_msgOk("SQL ������ ���������� �Ϸ�Ǿ����ϴ�.");
				}
				else
				{
					C_msgError(dsResult.NameString(0, "MESSAGE"));
				}
			}
			
			function imgCancle_onClick()
			{
				if (dsFilters.IsUpdated || G_isChanged(dsFilters.id))
				{
					var ret = C_msgYesNo("����� ������ ���� �Ͻðڽ��ϱ�?", "����");
			
					if (ret == "Y")
					{
						if (!G_saveAllData(dsFilters)) return;
					}
				}
				
				window.returnValue = null;
				window.close();
			}
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsFilters classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsFilterArgs classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsFilterSeq classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsFilterArgSeq classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsArgsList classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id=dsResult classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id=trans  classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
			<param name="KeyValue" value="Service1(I:dsFilters=dsFilters, I:dsFilterArgs=dsFilterArgs)">
			<param name="Action" value="./t_PLovFilterR_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()"">
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="left" background="../images/pop_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
								<td class="title_default">�����˾� ���͵��</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td height="100%" width="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="bottom">
								<td width="100%" height="26">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold">����</td>
											<td align="right">
												<input id="btnExeSql" type="button" class="img_btn4_1" value="SQL����" onclick="btnExeSql_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;&nbsp;
												<input id="btnRETRIEVE" type="button" class="img_btn2_1" value="��ȸ" onclick="btnquery_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnADD" type="button" class="img_btn2_1" value="�߰�" onclick="btnadd_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnINSERT" type="button" class="img_btn2_1" value="����" onclick="btninsert_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnDELETE" type="button" class="img_btn2_1" value="����" onclick="btndelete_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="btnSAVE" type="button" class="img_btn2_1" value="����" onclick="btnsave_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridFilters WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsFilters">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=���� ID=DIS_SEQ Width=40 Align=Center
											</FC> 
											<FC> Name=���͸� ID=FILTER_NAME Width=80 Edit=None
											</FC>
											<C> Name=Ÿ�� ID=TYPE Width=50 EditStyle=Combo Data='S:����,N:����,D:��¥,C:�޺�'
											</C>
											<C> Name=��¥Ÿ�� ID=DATE_TYPE Width=60 EditStyle=Combo Data='D:�����,M:���,Y:��'
											</C>
											<C> Name=�󺧸� ID=LABEL_NAME Width=100
											</C>
											<C> Name=���� ID=LABEL_WIDTH Width=50
											</C>
											<C> Name=������ ID='WIDTH' Width=50
											</C>
											<C> Name=�Է�����(GET) ID=DEFAULT_ARG_NAME Width=100 EditStyle=Lookup Data='dsArgsList:CODE:NAME'
											</C>
											<C> Name=�Է�����(SET) ID=RETURN_ARG_NAME Width=100 EditStyle=Lookup Data='dsArgsList:CODE:NAME'
											</C>
											<C> Name=VALUE_�÷� ID=VALUE_COL Width=80
											</C>
											<C> Name=TEXT_�÷� ID=TEXT_COL Width=80
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
								</td>
							</tr>
							<tr>
								<td width="100%" height="200">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold">���� �Է�����</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
												<table width="100%" height="179" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100%" height="100%">
															<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridFilterArgs WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																<PARAM NAME="DataID" VALUE="dsFilterArgs">
																<PARAM NAME="Editable" VALUE="true">
																<PARAM NAME="ColSelect" VALUE="true">
																<PARAM NAME="ColSizing" VALUE="true">
																<PARAM NAME="Format" VALUE=" 
																	<C> Name=���� ID=DIS_SEQ Width=40 Align=Center
																	</C> 
																	<C> Name=Ÿ�� ID=TYPE Width=70 EditStyle=Combo Data='A:�Է�����,F:����'
																	</C>
																	<C> Name=�Է�����(����)�� ID=FILTER_ARG_NAME Width=110 
																	</C>
																	<C> Name=�⺻�� ID=DEFAULT_VALUE Width=80 
																	</C> 
																	">
															</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
														</td>
													</tr>
												</table>
											</td>
											<td width="*" onActivate="G_focusDataset(dsFilters)">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="25">SQL</td>
														<td width="*"><textarea id="txtSQL" style="width:450;height:200" wrap="off"></textarea></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<TD width="100%" align="right">
												<input id="imgCancle" type="button" class="img_btnClose" value="�ݱ�" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</DIV>
		<!-- ���콺 Bind ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><object id=binFilters classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
			<param name="DataID" value="dsFilters">
			<param name="BindInfo" value="
				<C>Col=SQL		Ctrl=txtSQL		Param=Value</C>
				">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
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