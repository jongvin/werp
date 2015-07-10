<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WAccCodeR(����������)
/* 2. ����(�ó�����) : ���������� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���������� ��Ϲ� ��ȸ�ϴ� ���α׷� 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-10-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WAccCodeR";
	String strPageName = "t_WAccCodeR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strACC_GRP = "";
	String strCUST_MNG = "";
	String strACC_LVL = "";
	String strACC_GRP1 = "";
	
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
			strSql += "Union \n";
			strSql += "Select \n";
			strSql += "		'%', \n";
			strSql += "		'��ü', \n";
			strSql += "		-1  \n";
			strSql += "from dual \n";
			strSql += "Order By \n";
			strSql += "	3 \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_GRP = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �����׷��ڵ� Select ���� -> " + ex.getMessage());
		}
		
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
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsACC_REMAIN_POSITION classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
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
								<td class="td_green">
									<!-- ���α׷��� ������ ���� //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >��±���</td>
											<td width="117">
												<SELECT id="cboExportTag" style="WIDTH: 60px">
													<OPTION VALUE='P' selected>PDF
													<OPTION VALUE='E'>EXCEL
													<OPTION VALUE='W'>WORD
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >���౸��</td>
											<td width="100">
												<SELECT id="cboRunTag" style="WIDTH: 80px">
													<OPTION VALUE='1' selected>�ٷν���
													<OPTION VALUE='2'>��û
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class="font_green_bold" >��û��</td>
											<td width="120"><input id="txtRequestName" type="text" style="width:120px"></td>
											<td  width="*"  align=right><input id="btnPreView" type="button" class="img_btn4_1" value="���" onclick="btnPreView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
										</tr>
									</table>
									<!-- ���α׷��� ������ ���� //-->
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td height="5"></td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >�����׷�</td>
											<td width="118"><select id="cboACC_GRP" style="WIDTH: 80px" class="input_listbox_default"><%=strACC_GRP%></select></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >�� �� ��</td>
											<td width="*"><input id="txtACC_NAME" type="text" style="width:150px"></td>
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
					<td width="100%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="15" height="20"><img src="../images/bullet1.gif"></td>
								<td width="90" class="font_green_bold">�������� ���</td>
								<td  width="*"  align=right>&nbsp;</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" height="230" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="false">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=�����ڵ� ID=ACC_CODE Align=Center Width=80 EditLimit=10
											</FC>
											<FC> Name=�׷� ID=ACC_GRP Align=Center EditStyle=Combo Data='<%=strACC_GRP1%>' Width=70
											</FC>
											<FC> Name=���� ID=ACC_LVL Align=Center EditStyle=Combo Data='<%=strACC_LVL%>' Width=70
											</FC>
											<FC> Name='��  ��  ��' ID=ACC_NAME Align=Left Width=250 Color={Decode(ACC_LVL,1,'#990000',2,'#FF0000',3,'#FF7E00',4,'#457700',5,'blue',6,'#000066')}
											</FC>
											<C> Name=������Ҹ� ID=ACC_SHRT_NAME Align=Left Width=250
											</C>
											<C> Name=�����ܾ���ġ ID=ACC_REMAIN_POSITION Align=Center  EditStyle=LookUp Data='dsACC_REMAIN_POSITION:CODE_LIST_ID:CODE_LIST_NAME' Width=90
											</C>
											<C> Name=�Է±��� ID=FUND_INPUT_CLS Align=Center EditStyle=CheckBox Width=60
											</C>
											<C> Name='����ǥ���?' ID=PRINT_SHEET_TAG Align=Center EditStyle=CheckBox Width=80
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
								</td>
							</tr>
						</table>
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
						<!-- �������� ���̺� ���� //-->
					</td>
				</tr>
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" onActivate="G_focusDataset(dsMAIN)">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td width="*" class="font_green_bold"> �������� ó������</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="*" height="5"></td>
										</tr>
									</table>
									<div id="divFreeForm">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">��������</td>
												<td width="90"><input id="txtCOMPUTER_ACC" type="text" tabindex="-1" style="width : 80px;" readOnly class="ro"></td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�ܾװ���</td>
												<td width="90"><input id="chkACC_REMAIN_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'ACC_REMAIN_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�������</td>
												<td width="90"><input id="chkBUDG_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'BUDG_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">��������</td>
												<td width="90"><input id="chkBUDG_EXEC_CLS" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'BUDG_EXEC_CLS') = this.checked ? 'T' : 'F'"></td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�������</td>
												<td width="*"><input id="chkSUMMARY_CLS" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'SUMMARY_CLS') = this.checked ? 'T' : 'F'"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�ŷ�ó�ڵ�</td>
												<td width="20"><input id="chkCUST_CODE_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'CUST_CODE_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboCUST_CODE_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�ŷ�ó��</td>
												<td width="20"><input id="chkCUST_NAME_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'CUST_NAME_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboCUST_NAME_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">��������</td>
												<td width="20"><input id="chkBANK_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'BANK_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboBANK_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">���°���</td>
												<td width="20"><input id="chkACCNO_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'ACCNO_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboACCNO_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">���¼�ǥ</td>
												<td width="20"><input id="chkCHK_NO_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'CHK_NO_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="50">
													<select  id="cboCHK_NO_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">���޾���</td>
												<td width="20"><input id="chkBILL_NO_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'BILL_NO_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboBILL_NO_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">��������</td>
												<td width="20"><input id="chkREC_BILL_NO_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'REC_BILL_NO_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboREC_BILL_NO_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">��������</td>
												<td width="20"><input id="chkSECU_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'SECU_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboSECU_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">CP ��ȣ</td>
												<td width="20"><input id="chkCP_NO_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'CP_NO_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboCP_NO_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">���Աݹ�ȣ</td>
												<td width="20"><input id="chkLOAN_NO_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'LOAN_NO_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="50">
													<select  id="cboLOAN_NO_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�����ڻ�</td>
												<td width="20"><input id="chkFIXED_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'FIXED_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboFIXED_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">������</td>
												<td width="20"><input id="chkDEPOSIT_PAY_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'DEPOSIT_PAY_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboDEPOSIT_PAY_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">���������</td>
												<td width="20"><input id="chkANTICIPATION_DT_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'ANTICIPATION_DT_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboANTICIPATION_DT_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�����ȣ</td>
												<td width="20"><input id="chkEMP_NO_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'EMP_NO_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboEMP_NO_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">ī���ȣ</td>
												<td width="20"><input id="chkCARD_SEQ_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'CARD_SEQ_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboCARD_SEQ_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">�����������</td>
												<td width="20"><input id="chkPAY_CON_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'PAY_CON_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="70">
													<select  id="cboPAY_CON_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="90">��ݾ���������</td>
												<td width="20"><input id="chkBILL_EXPR_MNG" type="CheckBox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'BILL_EXPR_MNG') = this.checked ? 'T' : 'F'"></td>
												<td width="50">
													<select  id="cboBILL_EXPR_MNG_TG"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*" height="5"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="head_line">
												<td width="*" height="1"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*" height="5"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�1(����)</td>
												<td width="180"><input id="txtMNG_NAME_CHAR1" type="text" style="width:178px"  ></td>
												<td width="250">
													<select  id="cboMNG_TG_CHAR1"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�2(����)</td>
												<td width="180"><input id="txtMNG_NAME_CHAR2" type="text" style="width:178px"  ></td>
												<td width="50">
													<select  id="cboMNG_TG_CHAR2"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�3(����)</td>
												<td width="180"><input id="txtMNG_NAME_CHAR3" type="text" style="width:178px"  ></td>
												<td width="250">
													<select  id="cboMNG_TG_CHAR3"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�4(����)</td>
												<td width="180"><input id="txtMNG_NAME_CHAR4" type="text" style="width:178px"  ></td>
												<td width="50">
													<select  id="cboMNG_TG_CHAR4"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*" height="5"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="head_line">
												<td width="*" height="1"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*" height="5"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�1(����)</td>
												<td width="180"><input id="txtMNG_NAME_NUM1" type="text" style="width:178px"  ></td>
												<td width="250">
													<select  id="cboMNG_TG_NUM1"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�2(����)</td>
												<td width="180"><input id="txtMNG_NAME_NUM2" type="text" style="width:178px"  ></td>
												<td width="50">
													<select  id="cboMNG_TG_NUM2"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�3(����)</td>
												<td width="180"><input id="txtMNG_NAME_NUM3" type="text" style="width:178px"  ></td>
												<td width="250">
													<select  id="cboMNG_TG_NUM3"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�4(����)</td>
												<td width="180"><input id="txtMNG_NAME_NUM4" type="text" style="width:178px"  ></td>
												<td width="50">
													<select  id="cboMNG_TG_NUM4"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*" height="5"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="head_line">
												<td width="*" height="1"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*" height="5"></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�1(��¥)</td>
												<td width="180"><input id="txtMNG_NAME_DT1" type="text" style="width:178px"  ></td>
												<td width="250">
													<select  id="cboMNG_TG_DT1"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�2(��¥)</td>
												<td width="180"><input id="txtMNG_NAME_DT2" type="text" style="width:178px"  ></td>
												<td width="50">
													<select  id="cboMNG_TG_DT2"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�3(��¥)</td>
												<td width="180"><input id="txtMNG_NAME_DT3" type="text" style="width:178px"  ></td>
												<td width="250">
													<select  id="cboMNG_TG_DT3"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="15"><img src="../images/bullet3.gif"></td>
												<td width="95">�����׸�4(��¥)</td>
												<td width="180"><input id="txtMNG_NAME_DT4" type="text" style="width:178px"  ></td>
												<td width="50">
													<select  id="cboMNG_TG_DT4"  style="WIDTH: 50px">
														<OPTION value='F' selected> ����</OPTION>
														<OPTION value='T'> �ʼ�</OPTION>
													</select>
												</td>
												<td width="*">&nbsp;</td>
											</tr>
										</table>
									</div>
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
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=ADE_Bind_1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
			<PARAM NAME="DataID" VALUE="dsMAIN">
			<PARAM NAME="BindInfo" VALUE="
				<C>Col=COMPUTER_ACC Ctrl=txtCOMPUTER_ACC Param=value
				</C>
				<C>Col=ACC_REMAIN_MNG Ctrl=chkACC_REMAIN_MNG Param=checked
				</C>
				<C>Col=BUDG_MNG Ctrl=chkBUDG_MNG Param=checked
				</C>
				<C>Col=BUDG_EXEC_CLS Ctrl=chkBUDG_EXEC_CLS Param=checked
				</C>
				<C>Col=SUMMARY_CLS Ctrl=chkSUMMARY_CLS Param=checked
				</C>
				<C>Col=CUST_CODE_MNG Ctrl=chkCUST_CODE_MNG Param=checked
				</C>
				<C>Col=CUST_CODE_MNG_TG Ctrl=cboCUST_CODE_MNG_TG Param=value
				</C>
				<C>Col=CUST_NAME_MNG Ctrl=chkCUST_NAME_MNG Param=checked
				</C>
				<C>Col=CUST_NAME_MNG_TG Ctrl=cboCUST_NAME_MNG_TG Param=value
				</C>
				<C>Col=BANK_MNG Ctrl=chkBANK_MNG Param=checked
				</C>
				<C>Col=BANK_MNG_TG Ctrl=cboBANK_MNG_TG Param=value
				</C>
				<C>Col=ACCNO_MNG Ctrl=chkACCNO_MNG Param=checked
				</C>
				<C>Col=ACCNO_MNG_TG Ctrl=cboACCNO_MNG_TG Param=value
				</C>
				<C>Col=CHK_NO_MNG Ctrl=chkCHK_NO_MNG Param=checked
				</C>
				<C>Col=CHK_NO_MNG_TG Ctrl=cboCHK_NO_MNG_TG Param=value
				</C>
				<C>Col=BILL_NO_MNG Ctrl=chkBILL_NO_MNG Param=checked
				</C>
				<C>Col=BILL_NO_MNG_TG Ctrl=cboBILL_NO_MNG_TG Param=value
				</C>
				<C>Col=REC_BILL_NO_MNG Ctrl=chkREC_BILL_NO_MNG Param=checked
				</C>
				<C>Col=REC_BILL_NO_MNG_TG Ctrl=cboREC_BILL_NO_MNG_TG Param=value
				</C>
				<C>Col=SECU_MNG Ctrl=chkSECU_MNG Param=checked
				</C>
				<C>Col=SECU_MNG_TG Ctrl=cboSECU_MNG_TG Param=value
				</C>
				<C>Col=CP_NO_MNG Ctrl=chkCP_NO_MNG Param=checked
				</C>
				<C>Col=CP_NO_MNG_TG Ctrl=cboCP_NO_MNG_TG Param=value
				</C>
				<C>Col=LOAN_NO_MNG Ctrl=chkLOAN_NO_MNG Param=checked
				</C>
				<C>Col=LOAN_NO_MNG_TG Ctrl=cboLOAN_NO_MNG_TG Param=value
				</C>
				<C>Col=FIXED_MNG Ctrl=chkFIXED_MNG Param=checked
				</C>
				<C>Col=FIXED_MNG_TG Ctrl=cboFIXED_MNG_TG Param=value
				</C>
				<C>Col=DEPOSIT_PAY_MNG Ctrl=chkDEPOSIT_PAY_MNG Param=checked
				</C>
				<C>Col=DEPOSIT_PAY_MNG_TG Ctrl=cboDEPOSIT_PAY_MNG_TG Param=value
				</C>
				<C>Col=ANTICIPATION_DT_MNG Ctrl=chkANTICIPATION_DT_MNG Param=checked
				</C>
				<C>Col=ANTICIPATION_DT_MNG_TG Ctrl=cboANTICIPATION_DT_MNG_TG Param=value
				</C>
				<C>Col=EMP_NO_MNG Ctrl=chkEMP_NO_MNG Param=checked
				</C>
				<C>Col=EMP_NO_MNG_TG Ctrl=cboEMP_NO_MNG_TG Param=value
				</C>
				<C>Col=CARD_SEQ_MNG Ctrl=chkCARD_SEQ_MNG Param=checked
				</C>
				<C>Col=CARD_SEQ_MNG_TG Ctrl=cboCARD_SEQ_MNG_TG Param=value
				</C>
				<C>Col=PAY_CON_MNG Ctrl=chkPAY_CON_MNG Param=checked
				</C>
				<C>Col=PAY_CON_MNG_TG Ctrl=cboPAY_CON_MNG_TG Param=value
				</C>
				<C>Col=BILL_EXPR_MNG Ctrl=chkBILL_EXPR_MNG Param=checked
				</C>
				<C>Col=BILL_EXPR_MNG_TG Ctrl=cboBILL_EXPR_MNG_TG Param=value
				</C>
				<C>Col=MNG_NAME_CHAR1 Ctrl=txtMNG_NAME_CHAR1 Param=value
				</C>
				<C>Col=MNG_TG_CHAR1 Ctrl=cboMNG_TG_CHAR1 Param=value
				</C>
				<C>Col=MNG_NAME_CHAR2 Ctrl=txtMNG_NAME_CHAR2 Param=value
				</C>
				<C>Col=MNG_TG_CHAR2 Ctrl=cboMNG_TG_CHAR2 Param=value
				</C>
				<C>Col=MNG_NAME_CHAR3 Ctrl=txtMNG_NAME_CHAR3 Param=value
				</C>
				<C>Col=MNG_TG_CHAR3 Ctrl=cboMNG_TG_CHAR3 Param=value
				</C>
				<C>Col=MNG_NAME_CHAR4 Ctrl=txtMNG_NAME_CHAR4 Param=value
				</C>
				<C>Col=MNG_TG_CHAR4 Ctrl=cboMNG_TG_CHAR4 Param=value
				</C>
				<C>Col=MNG_NAME_NUM1 Ctrl=txtMNG_NAME_NUM1 Param=value
				</C>
				<C>Col=MNG_TG_NUM1 Ctrl=cboMNG_TG_NUM1 Param=value
				</C>
				<C>Col=MNG_NAME_NUM2 Ctrl=txtMNG_NAME_NUM2 Param=value
				</C>
				<C>Col=MNG_TG_NUM2 Ctrl=cboMNG_TG_NUM2 Param=value
				</C>
				<C>Col=MNG_NAME_NUM3 Ctrl=txtMNG_NAME_NUM3 Param=value
				</C>
				<C>Col=MNG_TG_NUM3 Ctrl=cboMNG_TG_NUM3 Param=value
				</C>
				<C>Col=MNG_NAME_NUM4 Ctrl=txtMNG_NAME_NUM4 Param=value
				</C>
				<C>Col=MNG_TG_NUM4 Ctrl=cboMNG_TG_NUM4 Param=value
				</C>
				<C>Col=MNG_NAME_DT1 Ctrl=txtMNG_NAME_DT1 Param=value
				</C>
				<C>Col=MNG_TG_DT1 Ctrl=cboMNG_TG_DT1 Param=value
				</C>
				<C>Col=MNG_NAME_DT2 Ctrl=txtMNG_NAME_DT2 Param=value
				</C>
				<C>Col=MNG_TG_DT2 Ctrl=cboMNG_TG_DT2 Param=value
				</C>
				<C>Col=MNG_NAME_DT3 Ctrl=txtMNG_NAME_DT3 Param=value
				</C>
				<C>Col=MNG_TG_DT3 Ctrl=cboMNG_TG_DT3 Param=value
				</C>
				<C>Col=MNG_NAME_DT4 Ctrl=txtMNG_NAME_DT4 Param=value
				</C>
				<C>Col=MNG_TG_DT4 Ctrl=cboMNG_TG_DT4 Param=value
				</C>
				">
		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
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