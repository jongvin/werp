<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : �������
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-10-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";

	String strReportResponseUrl = "http://52.10.123.200/WIIS_REPORT/Reports_Temp";
	String strState = "";

	try
	{
		CITCommon.initPage(request, response, session);

		//strReportResponseUrl = CITCommon.getProperty("report.response.url", "");

		CITData lrArgData = new CITData();

		try
		{
			strSql  = " Select '%' as CODE, ";
			strSql += "        '��ü' as NAME ";
			strSql += " From   Dual ";
			strSql += " Union All ";
			strSql += " Select CODE_LIST_ID as CODE, ";
			strSql += "        CODE_LIST_NAME as NAME ";
			strSql += " From   V_T_CODE_LIST ";
			strSql += " Where  CODE_GROUP_ID = 'REPORT_REQUEST_STATE' ";
			strSql += " And    USE_TAG = 'T' ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strState = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ����ó Select ���� -> " + ex.getMessage());
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
		<script language="javascript">
		<!--
			var strReportResponseUrl = "<%=strReportResponseUrl%>";

			function Initialize()
			{
				G_addDataSet(dsRequest, trans, gridRequest, "", "������û����");
				gridRequest.focus();
				G_Load(dsRequest, null);
			}

			// �Լ�����---------------------------------------------------------------------//

			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsRequest)
				{
					dataset.DataID = "t_WCcReportRequestRetrieve_q.jsp?ACT=REQUEST_LIST&REQUEST_NAME=" + txtRequestName.value + "&STATE=" + cboState.value;
				}
			}

			function OnLoadCompleted(dataset, rowcnt)
			{
			}

			function OnRowInserted(dataset, row)
			{
			}

			function OnRowDeleted(dataset, row)
			{
			}

			function OnColumnChanged(dataset, row, colid)
			{
			}

			function OnPopup(dataset, grid, row, colid, data)
			{
			}

			// �̺�Ʈ����-------------------------------------------------------------------//
			function btnReportView_onClick()
			{
				if (dsRequest.RowPosition < 1)
				{
					C_msgOk("��û������ �����Ͻʽÿ�.");
					return;
				}

				if (dsRequest.NameString(dsRequest.RowPosition, "STATE") != "C")
				{
					C_msgOk("��û�� �Ϸ���� �ʾҽ��ϴ�.");
					return;
				}

				window.open(strReportResponseUrl + "/" + dsRequest.NameString(dsRequest.RowPosition, "REQUEST_FILE_NAME"));
			}

			// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
			// ��ȸ
			function btnquery_onclick()
			{
				D_defaultLoad();
				
			}
			
			
			// ����
			function btnsave_onclick()
			{
				D_defaultSave();
			}
			
			// ���
			function btncancel_onclick()
			{
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			function btnLoad_onClick()
			{
				G_Load(dsRequest, null);
			}

			function btnDel_onClick()
			{
				G_deleteRow(dsRequest);
			}

			function btnDelAll_onClick()
			{
				G_deleteAllRow(dsRequest);
			}

			function btnSave_onClick()
			{
				G_saveDataMsg(dsRequest);
			}

		//-->
		</script>

		<object id=dsRequest classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id=trans classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
	      <param name="KeyValue" value="Service1(I:dsRequest=dsRequest)">
		  <param name="Action" value="./t_WCcReportRequestRetrieve_tr.jsp">
		</object>
	</head>
	<body onload="C_Initialize()">
		<!-- ǥ�� �������� ���� DIV ���� : ũ��(��:100%px, ����:530px) //-->
		<div id="divMainFix"  class="main_div">
		<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100%">
					<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
					<!-- ���� ���̺� ���� //-->
					<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr class="head_line">
										<td width="*" height="1"></td>
									</tr>
									<tr>
										<td class="td_green">
											<!-- ���α׷��� ������ ���� //-->
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="50" class="font_green_bold">��û��</td>
													<td width="250"><input id="txtRequestName" type="text" style="width:200px"></td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="65" class="font_green_bold">��û����</td>
													<td width="*"><select id="cboState" style="width: 80px"><%=strState%></select></td>
												</tr>
											</table>
											<!-- ���α׷��� ������ ���� //-->
										</td>
									</tr>
									<tr class="head_line">
										<td width="*" height="1"></td>
									</tr>
								</table>
								<!-- ���� ���̺� ���� //-->
							</td>
						</tr>
						<tr>
							<td>
								<!-- �������� ���̺� ���� //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- �������� ���̺� ���� //-->
							</td>
						</tr>
						<tr>
							<td>
								<!-- ���� ���̺� ���� //-->
								<!-- ���� Ÿ��Ʋ ���� //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- ���α׷��� ���� ���� //-->
										<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
										<td class="font_green_bold"> ��û����</td>
										<td align="right">
											<input id="btnReportView" type="button" class="img_btn6_1" value="��������" onclick="btnReportView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											<input id="btnDel" type="button" class="img_btn2_1" value="����" onclick="btnDel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											<input id="btnDelAll" type="button" class="img_btn4_1" value="��ü����" onclick="btnDelAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
										</td>
										<!-- ���α׷��� ���� ���� //-->
									</tr>
								</table>
								<!-- ���� Ÿ��Ʋ ���� //-->
								<!-- ���� ���� ���� //-->
							</td>
						</tr>
						<tr>
							<td HEIGHT="100%">
								<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%" HEIGHT="100%">
											<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
												<tr>
													<td bgcolor="#FFFFFF" HEIGHT="100%">
														<!-- ���α׷��� ������ ���� //-->
														<table width="100%" HEIGHT="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td HEIGHT="100%">
																	<OBJECT id=gridRequest WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49>
																		<PARAM NAME="Editable" VALUE="false">
																		<PARAM NAME="ColSelect" VALUE="-1">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM NAME="Format" VALUE="
																			<C> Name=��û�� ID=REQUEST_NAME Width=150 Sort=true
																			</C>
																			<C> Name=������ ID=REPORT_NAME Width=150 Sort=true
																			</C>
																			<C> Name=���� ID=STATE_NAME Width=50 Sort=true
																			</C>
																			<C> Name=��û���� ID=REQUEST_DATE Width=125 Sort=true
																			</C>
																			<C> Name=�Ϸ����� ID=COMPLETE_DATE Width=125 Sort=true
																			</C>
																			<C> Name=������������ ID=DELETE_EXPECT_DATE Width=80
																			</C>
																			<C> Name=��� ID=REMARK Width=200
																			</C>
																			">
																		<PARAM NAME="DataID" VALUE="dsRequest">
																	</OBJECT>
																</td>
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
					</table>
				</td>
			</tr>
		</table>
		</div>
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
