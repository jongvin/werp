<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.net.*, java.io.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : ������
/* �����ۼ��� : 2005-01-14
/* ���������� :
/* ���������� :
/***************************************************/

	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";

	String strReportResponseUrl = "";
	String strState = "";

	try
	{
		CITCommon.initPage(request, response, session);

		strReportResponseUrl = CITCommon.getProperty("report.response.url", "");

		CITData lrArgData = new CITData();

		try
		{
			strSql  = " Select '%' as CODE, ";
			strSql += "        '��ü' as NAME ";
			strSql += " From   Dual ";
			strSql += " Union All ";
			strSql += " Select CODE_LIST_ID as CODE, ";
			strSql += "        CODE_LIST_NAME as NAME ";
			strSql += " From   VCC_CODE_LIST ";
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
		<title>������� - ���������ý���</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var strReportResponseUrl = "<%=strReportResponseUrl%>";

			function Initialize()
			{
				G_addDataSet(dsRequest, trans, gridRequest, "", "������û����");

				G_Load(dsRequest, null);
			}

			// �Լ�����---------------------------------------------------------------------//

			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsRequest)
				{
					dataset.DataID = "WCcReportRequestRetrieve_S.jsp?ACT=REQUEST_LIST&REQUEST_NAME=" + txtRequestName.value + "&STATE=" + cboState.value;
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

		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsRequest classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=trans classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
	      <param name="KeyValue" value="Service1(I:dsRequest=dsRequest)">
		  <param name="Action" value="./WCcReportRequestRetrieve_U.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
	</head>
	<body onload="C_Initialize()">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr height="*">
				<td width="800" align="left" valign="top">
					<!-- ǥ�� �������� ���� DIV ���� : ũ��(��:800px, ����:530px) //-->
					<div id="divMainFix" style="OVERFLOW: hidden; WIDTH: 800px; HEIGHT: 530px">
					<table width="800" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="800">
								<!-- ������ġ ���̺� ���� //-->
								<table width="800" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="top_font_green_small">
											<!-- ���α׷��� ���� ���� //-->
											<strong>������ġ</strong> :
											<a>��������</a> / <a>������û���</a>
											<!-- ���α׷��� ���� ���� //-->
										</td>
									</tr>
									<tr>
										<td height="1" bgcolor="#CCCCCC"></td>
									</tr>
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- ������ġ ���̺� ���� //-->
								<!-- ���� ���̺� ���� //-->
								<table width="800" border="0" cellspacing="0" cellpadding="0">
									<tr class="head_line">
										<td width="*" height="1"></td>
									</tr>
									<tr>
										<td class="td_green">
											<!-- ���α׷��� ������ ���� //-->
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="15"><img src="../images/z1_sub2_bullet.gif"></td>
													<td width="50" class="font_green_bold">��û��</td>
													<td width="250"><input id="txtRequestName" type="text" style="width:200px"></td>
													<td width="15"><img src="../images/z1_sub2_bullet.gif"></td>
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
								<!-- �������� ���̺� ���� //-->
								<table width="800" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- �������� ���̺� ���� //-->
								<!-- ���� ���̺� ���� //-->
								<!-- ���� Ÿ��Ʋ ���� //-->
								<table width="800" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- ���α׷��� ���� ���� //-->
										<td width="15" height="20"><img src="../images/z1_sub1_bullet.gif" width="9" height="9"></td>
										<td class="font_green_bold"> ��û����</td>
										<td align="right">
											<input id="btnReportView" type="button" class="btn6_1" value="��������" onclick="btnReportView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;&nbsp;
											<input id="btnLoad" type="button" class="btn2_1" value="��ȸ" onclick="btnLoad_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											<input id="btnDel" type="button" class="btn2_1" value="����" onclick="btnDel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											<input id="btnDelAll" type="button" class="btn4_1" value="��ü����" onclick="btnDelAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											<input id="btnSave" type="button" class="btn2_1" value="����" onclick="btnSave_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
										</td>
										<!-- ���α׷��� ���� ���� //-->
									</tr>
								</table>
								<!-- ���� Ÿ��Ʋ ���� //-->
								<!-- ���� ���� ���� //-->
								<table width="800" border="0" cellspacing="0" cellpadding="0">
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
																<td HEIGHT="440">
																	<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridRequest WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49>
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
																	</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
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
					</div>
					<!-- ǥ�� �������� ���� DIV ���� //-->
				</td>
			</tr>
		</table>
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
