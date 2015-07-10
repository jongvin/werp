<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_PLovFilterRelR(�����˾��� ���Ͱ�����)
/* 2. ����(�ó�����) : �����˾��� ���Ͱ��� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	String strLovNo = "";
	String strFilters = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
		
		CITData lrArgData = new CITData();
		
		try
		{
			strSql  = " Select FILTER_SEQ, ";
			strSql += "        FILTER_NAME ";			
			strSql += " From   T_LOV_FILTERS ";
			strSql += " Where  LOV_NO = ? ";
			strSql += "  And   TYPE = 'C' ";
			strSql += " Order by DIS_SEQ ";
			
			lrArgData.addColumn("LOV_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("LOV_NO", strLovNo);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strFilters = CITCommon.toGauceComboString(lrReturnData, "FILTER_SEQ", "FILTER_NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:���� Select ���� -> " + ex.getMessage());
		}
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
				G_addDataSet(dsFilterRels, trans, gridFilterRels, null, "���Ͱ���");
				G_addDataSet(dsFilterRelSeq, null, null, "t_PLovFilterRelR_q.jsp?ACT=FILTER_REL_SEQ", "���Ͱ����ȣ");
				
				G_Load(dsFilterRels, null);
				gridFilterRels.focus();
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
			
			// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
			// ��ȸ
			function btnquery_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_Load(dsFilterRels, null);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// �߰�
			function btnadd_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_addRow(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ����
			function btninsert_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_insertRow(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ����
			function btndelete_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_deleteRow(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ����
			function btnsave_onclick()
			{
				if (G_FocusDataset == dsFilterRels)
				{
					G_saveDataMsg(dsFilterRels);
				}
				
				if (G_FocusObject != null) G_FocusObject.focus();
			}
			
			// ���� ������ �̺�Ʈ����-------------------------------------------------------//
			function OnLoadBefore(dataset)
			{
				if (dataset == dsFilterRels)
				{
					dataset.DataID = "t_PLovFilterRelR_q.jsp?ACT=FILTER_RELS";
					dataset.DataID += "&LOV_NO=" + strLovNo;
				}
			}
			
			function OnRowInserted(dataset, row)
			{
				if (dataset == dsFilterRels)
				{
					G_Load(dsFilterRelSeq, null);
					
					dsFilterRels.NameValue(row, "LOV_NO") = strLovNo;
					dsFilterRels.NameValue(row, "FILTER_REL_SEQ") = dsFilterRelSeq.NameString(dsFilterRelSeq.RowPosition, "FILTER_REL_SEQ");
					dsFilterRels.NameValue(row, "DIS_SEQ") = dsFilterRels.NameMax("DIS_SEQ", 0, 0) + 1;
				}
			}
			
			function OnColumnChanged(dataset, row, colid)
			{
				
			}
			
			// �̺�Ʈ����-------------------------------------------------------------------//
			function document_onKeyDown()
			{
				if (event.keyCode == 27)
				{
					imgCancle_onClick();
				}
			}
			
			function imgCancle_onClick()
			{
				if (dsFilterRels.IsUpdated || G_isChanged(dsFilterRels.id))
				{
					var ret = C_msgYesNo("����� ������ ���� �Ͻðڽ��ϱ�?", "����");
			
					if (ret == "Y")
					{
						if (!G_saveAllData(dsFilterRels)) return;
					}
				}
				
				window.returnValue = null;
				window.close();
			}
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsFilterRels classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsFilterRelSeq classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=trans  classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F>
			<param name="KeyValue" value="Service1(I:dsFilterRels=dsFilterRels)">
			<param name="Action" value="./t_PLovFilterRelR_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
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
								<td class="title_default">�����˾� ���Ͱ�����</td>
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
											<td class="font_green_bold">���Ͱ���</td>
											<td align="right">
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridFilterRels WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsFilterRels">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=���� ID=DIS_SEQ Width=40 Align=Center
											</C> 
											<C> Name=�θ����� ID=M_FILTER_SEQ Width=120 EditStyle=Combo Data='<%=strFilters%>'
											</C>
											<C> Name=�ڽ����� ID=D_FILTER_SEQ Width=120 EditStyle=Combo Data='<%=strFilters%>'
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
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