<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFinPayChkBillR.jsp(���޾�������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ����
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-01)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WFinPayBillR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN01=dsMAIN01,I:dsMAIN03=dsMAIN03,I:dsMAIN05=dsMAIN05,I:dsLIST05=dsLIST05)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strISSUE_CLS = "";
	String strDATE  = CITDate.getNow("yyyyMMdd");
	String	strCombo = "";
	String	strDfltBillKind = "";
	String	strDTF = "";
	String	strDTT = "";

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
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select"+"\n"+
				"	a.BILL_KIND CODE,"+"\n"+
				"	a.BILL_NAME NAME"+"\n"+
				"From	T_FIN_BILL_KIND a"+"\n"+
				"Order By"+"\n"+
				"	a.BILL_KIND";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strDfltBillKind = lrReturnData.toString(0,"CODE");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select"+"\n"+
				"	F_T_DATETOSTRING(Add_Months(Sysdate,-1)) DTF,"+"\n"+
				"	F_T_DATETOSTRING(Sysdate) DTT"+"\n"+
				"From	Dual "+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDTF = lrReturnData.toString(0,"DTF");
			strDTT = lrReturnData.toString(0,"DTT");
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
			var			sDfltBillKind = "<%=strDfltBillKind%>";
			var			sDTF = "<%=strDTF%>";
			var			sDTT = "<%=strDTT%>";
			// �̺�Ʈ����-------------------------------------------------------------------//

		//-->
		</script>

		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN03 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN04 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN05 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id=dsSETSLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id=dsLIST05 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><object id=dsSEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td width=310>
												<div id=divSBox3  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%; display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15" height="20"><img src="../images/bullet3.gif"></td>
															<td width="42" class="font_green_bold" >������</td>
															<td width="82">
																<input id="txtF_PUBL_DT" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnF_PUBL_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnF_PUBL_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td width="10">
																~
															</td>
															<td width="82">
																<input id="txtE_PUBL_DT" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnE_PUBL_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnE_PUBL_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td align="right" width="*">
																&nbsp;
															</td>
														</tr>
													</table>
												</div>
												<div id=divSBox4  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15" height="20"><img src="../images/bullet3.gif"></td>
															<td width="42" class="font_green_bold" >������</td>
															<td width="82">
																<input id="txtF_EXPR_DT" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnF_EXPR_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnF_EXPR_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td width="10">
																~
															</td>
															<td width="82">
																<input id="txtE_EXPR_DT" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnE_EXPR_DT" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnE_EXPR_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td align="right" width="*">
																&nbsp;
															</td>
														</tr>
													</table>
												</div>
												<div id=divSBox5  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15" height="20"><img src="../images/bullet3.gif"></td>
															<td width="42" class="font_green_bold" >������</td>
															<td width="82">
																<input id="txtACPT_DT_FROM" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnACPT_DT_FROM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnACPT_DT_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td width="10">
																~
															</td>
															<td width="82">
																<input id="txtACPT_DT_TO" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnACPT_DT_TO" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnACPT_DT_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td align="right" width="*">
																&nbsp;
															</td>
														</tr>
													</table>
												</div>
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
								<td>
									<!-- ���� ���̺� ���� //-->
									<!-- ���� Ÿ��Ʋ ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr height="23">
												<!-- ���α׷��� ���� ���� //-->
											<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
											<td width="70" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a href="javascript:selectTab(1, 5);" onfocus="this.blur()">�̹���</a></td>
											<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
											<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
											<td width="70" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(2, 5);" onfocus="this.blur()">����</a></td>
											<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
											<td width="6"><img id="imgTabLeft3" src="../images/Content_tab_after.gif"></td>
											<td width="70" id="tab3" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(3, 5);" onfocus="this.blur()">��������</a></td>
											<td width="6"><img id="imgTabRight3" src="../images/Content_tab_back.gif"></td>
											<td width="6"><img id="imgTabLeft4" src="../images/Content_tab_after.gif"></td>
											<td width="70" id="tab4" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(4, 5);" onfocus="this.blur()">������</a></td>
											<td width="6"><img id="imgTabRight4" src="../images/Content_tab_back.gif"></td>
											<td width="6"><img id="imgTabLeft5" src="../images/Content_tab_after.gif"></td>
											<td width="70" id="tab5" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(5, 5);" onfocus="this.blur()">��������</a></td>
											<td width="6"><img id="imgTabRight5" src="../images/Content_tab_back.gif"></td>

											<!-- ���α׷��� ���� ���� //-->
											<td width=*>&nbsp;
											</td>
											<td>
												<div id=divInnerBox1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td align="right" width="*">
																<input id="btnInsertPopup" type="button" class="img_btn6_1" value="�����ϰ����" onclick="btnInsertPopup_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																<input id="btnMultiDel" type="button" class="img_btn6_1" value="�����ϰ�����" onclick="btnMultiDel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
														</tr>
													</table>
												</div>
												<div id=divInnerBox2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="*">
																&nbsp;
															</td>
														</tr>
													</table>
												</div>
											</td>

										</tr>
									</table>
									<!-- ���� Ÿ��Ʋ ���� //-->
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
						<!-- ���� ���̺� ���� //-->
						<!-- �������� ���̺� ���� //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="2"></td>
							</tr>
						</table>
						<!-- �������� ���̺� ���� //-->
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
				<tr valign="top">
					<td width="100%" height="100%">
						<!-- ù��° �� ������ ����//-->
						<div id=divTabPage1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN01">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<param name="MultiRowSelect"   value=true>
										<param name=UsingOneClick  value="1">
										<PARAM NAME="Format" VALUE="
											<FC> Name=���� ��ȣ ID=CHK_BILL_NO Align=Center Width=100
											</FC>
											<FC> Name=����� ID=BANK_NAME Width=140
											</FC>
											<FC> Name=�������� ID=BILL_KIND  EditStyle=Combo Data='<%=strCombo%>' Width=90
											</FC>
											<FC> Name=���±��� ID=STAT_CLS  EditStyle=Combo Data='1:�̹���,2:����,3:���,4:�н�,9:�����ȯ,0:��������' Width=70
											</FC>
											<C> Name=������ ID=ACPT_DT Width=70 EditStyle=Popup
											</C>
											<C> Name=������ ID=PUBL_DT Width=70 EditStyle=Popup
											</C>
											<C> Name=����ݾ� ID=PUBL_AMT Width=93
											</C>
											<C> Name=�ŷ�ó�ڵ� ID=CUST_CODE Width=90 editStyle=Popup
											</C>
											<C> Name=�ŷ�ó�� ID=CUST_NAME Width=160
											</C>
											<C> Name=��ü������ ID=CUST_DOUT_DT Width=70 EditStyle=Popup
											</C>
											<C> Name=������ ID=EXPR_DT Width=70 EditStyle=Popup
											</C>
											<C> Name='���/�н���' ID=DUSE_DT Width=90 EditStyle=Popup
											</C>
											<C> Name='�����ȯ��' ID=RETURN_DT Width=90 EditStyle=Popup
											</C>
											<C> Name=��� ID=REMARKS Width=200
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL ������������//-->
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
						<!-- ù��°�������� ���� //-->
						<!-- �ι�° �� ������ ����//-->
						<div id=divTabPage2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%; display=none ">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

							<tr>
								<td width="100%" height="70%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN02">
										<PARAM NAME="Editable" VALUE="0">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE="
											<FC> Name=������ȣ ID=CHK_BILL_NO Align=Center Width=100
											</FC>
											<FC> Name=����� ID=BANK_NAME Width=140
											</FC>
											<FC> Name=�������� ID=BILL_KIND  EditStyle=Combo Data='<%=strCombo%>' Width=90
											</FC>
											<FC> Name=�ŷ�ó�ڵ� ID=CUST_CODE Width=90 
											</FC>
											<FC> Name=�ŷ�ó�� ID=CUST_NAME Width=160
											</FC>
											<FC> Name=������ ID=PUBL_DT Align=Center Width=70
											</FC>
											<FC> Name=����ݾ� ID=PUBL_AMT Width=100
											</FC>
											<C> Name=������ ID=EXPR_DT Width=70
											</C>
											<C> Name=���游���� ID=CHG_EXPR_DT Width=70
											</C>
											<C> Name=��ü������ ID=CUST_DOUT_DT Width=70
											</C>
											<C> Name=ȸ���� ID=COLL_DT Width=70
											</C>
											<C> Name=������ ID=DISC_RAT Width=80
											</C>
											<C> Name=���ξ� ID=DISC_AMT Width=90
											</C>
											<C> Name=��ǥ��ȣ ID=MAKE_SLIPNO Width=120
											</C>
											<C> Name=��� ID=REMARKS Width=200
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL ������������//-->
								</td>
							</tr>
							<tr>
								<td width="100%" height="30%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> ������������</td>
			
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
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSETSLIP WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSETSLIP">
													<PARAM NAME="Editable" VALUE="0">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<FC> Name=�������� ID=GB Align=Center  Width=60
														</FC>
														<FC> Name=�ۼ���ǥ��ȣ ID=MAKE_SLIPNO Width=120
														</FC>
														<C> Name=���� ID=DB_AMT  Width=100
														</C>
														<C> Name=�뺯 ID=CR_AMT  Width=100
														</C>
														<C> Name=�ܾ� ID=REMAIN_AMT  Width=100
														</C>
														<C> Name='�μ�����' ID=DEPT_CODE  Width=90
														</C>
														<C> Name='�μ������' ID=DEPT_NAME  Width=160
														</C>
														<C> Name=���� ID=SUMMARY  Width=220
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL ������������//-->
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						</div>
						<!-- �ι�°�������� ���� //-->
						<!-- ����° �� ������ ����//-->
						<div id=divTabPage3  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100% ; display=none">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

							<tr>

								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN03 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN03">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE="
											<FC> Name=������ȣ  ID=CHK_BILL_NO Align=Center Width=100 Edit=None
											</FC>
											<FC> Name=�����  ID=BANK_NAME Width=180 Edit=None
											</FC>
											<C> Name=�ŷ�ó�ڵ�  ID=CUST_CODE Width=90  
											</C>
											<C> Name=�ŷ�ó��   ID=CUST_NAME  Width=160  
											</C>
											<C> Name=������     ID=PUBL_DT   Width=70 editStyle=Popup
											</C>
											<C> Name=����ݾ�   ID=PUBL_AMT Width=100
											</C>
											<C> Name=������     ID=EXPR_DT Width=70 editStyle=Popup
											</C>
											<C> Name=���游���� ID=CHG_EXPR_DT Width=70 Edit=None
											</C>
											<C> Name=��ü������  ID=CUST_DOUT_DT Width=70 editStyle=Popup
											</C>
											<C> Name=ȸ����  ID=COLL_DT Width=70 editStyle=Popup
											</C>
											<C> Name=������  ID=DISC_RAT Width=70
											</C>
											<C> Name=���ξ�  ID=DISC_AMT Width=90
											</C>
											<C> Name=���  ID=REMARKS Width=200
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL ������������//-->
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
						<!-- ����°�������� ���� //-->
						<!-- �׹�° �� ������ ����//-->
						<div id=divTabPage4  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100% ; display=none">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN04 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN04">
										<PARAM NAME="Editable" VALUE="0">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE="
											<FC> Name=������ȣ ID=CHK_BILL_NO Align=Center   Width=100
											</FC>
											<FC> Name=����� ID=BANK_NAME   Width=180
											</FC>
											<FC> Name=�������� ID=BILL_KIND  EditStyle=Combo Data='<%=strCombo%>' Width=90 edit=none
											</FC>
											<FC> Name=���±��� ID=STAT_CLS  EditStyle=Combo Data='1:�̹���,2:����,3:���,4:�н�,9:�����ȯ,0:��������' Width=70 edit=none
											</FC>
											<C> Name=�ŷ�ó�ڵ� ID=CUST_CODE Width=40   Width=90
											</C>
											<C> Name=�ŷ�ó�� ID=CUST_NAME   Width=160
											</C>
											<C> Name=������ ID=PUBL_DT   Width=70
											</C>
											<C> Name=����ݾ� ID=PUBL_AMT Width=100
											</C>
											<C> Name=������ ID=EXPR_DT   Width=70
											</C>
											<C> Name=���游���� ID=CHG_EXPR_DT Width=70
											</C>
											<C> Name='���/�н���' ID=DUSE_DT   Width=70
											</C>
											<C> Name=��ü������ ID=CUST_DOUT_DT Width=70
											</C>
											<C> Name=ȸ���� ID=COLL_DT   Width=70
											</C>
											<C> Name=������ ID=DISC_RAT Width=70
											</C>
											<C> Name=���ξ� ID=DISC_AMT Width=90
											</C>
											<C> Name=��� ID=REMARKS Width=200
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL ������������//-->
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
						<!-- �׹�°�������� ���� //-->
						<!-- �ټ���° �� ������ ����//-->
						<div id=divTabPage5  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100% ; display=none">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="70%">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN05 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN05">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													 <param name="MultiRowSelect"   value=true>
													<PARAM NAME="Format" VALUE="
														<FC> Name=������ȣ ID=CHK_BILL_NO Width=100
														</FC>
														<FC> Name=�������� ID=BILL_KIND  EditStyle=Combo Data='<%=strCombo%>' Width=90 edit=none
														</FC>
														<FC> Name=���±��� ID=STAT_CLS  EditStyle=Combo Data='1:�̹���,2:����,3:���,4:�н�,9:�����ȯ,0:��������' Width=70 edit=none
														</FC>
														<C> Name=����� ID=BANK_NAME Width=40 Width=180  edit=none
														</C>
														<C> Name=������ ID=ACPT_DT Width=70 edit=none
														</C>
														<C> Name=������ ID=PUBL_DT Width=70 editStyle=Popup
														</C>
														<C> Name=����ݾ� ID=PUBL_AMT Width=93
														</C>
														<C> Name=�ŷ�ó�ڵ� ID=CUST_CODE Width=90 edit=none
														</C>
														<C> Name=�ŷ�ó�� ID=CUST_NAME Width=160 edit=none
														</C>
														<C> Name=������ ID=EXPR_DT Width=70  editStyle=Popup
														</C>
														<C> Name=���游���� ID=CHG_EXPR_DT Width=70 edit=none
														</C>
														<C> Name=��ü������ ID=CUST_DOUT_DT Width=70  editStyle=Popup
														</C>
														<C> Name=ȸ���� ID=COLL_DT Width=70  editStyle=Popup
														</C>
														<C> Name=������ ID=DISC_RAT Width=90
														</C>
														<C> Name=���ξ� ID=DISC_AMT Width=90
														</C>
														<C> Name=��� ID=REMARKS Width=200
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL ������������//-->
											</td>
										</tr>
										<tr>
											<td height="30%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="100%">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																	<td class="font_green_bold"> �����Ϻ��泻��</td>
						
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
														<td width="100%" height="100%">
															<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridLIST05 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																<PARAM NAME="DataID" VALUE="dsLIST05">
																<PARAM NAME="Editable" VALUE="-1">
																<PARAM NAME="ColSelect" VALUE="-1">
																<PARAM NAME="ColSizing" VALUE="-1">
																<PARAM NAME="Format" VALUE="
																	<C> Name=������ ID=CHG_DT Width=90	editStyle=Popup
																	</C>
																	<C> Name=���������� ID=PRE_EXPR_DT Width=90 
																	</C>
																	<C> Name=���游���� ID=CHG_EXPR_DT Width=90	editStyle=Popup
																	</C>
																	<C> Name=��� ID=REMARKS Width=200
																	</C>
																	">
															</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL ������������//-->
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
						<!-- �׹�°�������� ���� //-->
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