<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WETaxCompanyR(����� ���)
/* 2. ����(�ó�����) : ������� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� :
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-11)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WETaxCompanyR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strCombo = "";
	String strAdjust = "";
	String strPayStatus = "";
	String	strDTF = "";
	String	strUserNo = "";
	String	strTaxType = "";
	String	strDealClass = "";
	CITData		lrArgData = null;
	PrintWriter	mmm;
	/*
	String strPageURI = request.getRequestURI();
	StringTokenizer _st = new StringTokenizer(strPageURI,"/");
	String strTemp = "";
	while(_st.hasMoreTokens()){
	  strTemp = _st.nextToken();
	}

	strFileName = strTemp.replace(".jsp","");
	*/
	try
	{
		CITCommon.initPage(request, response, session);
		//����� ����
/*		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
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
		//����� ���� ����
*/		
		lrArgData = new CITData();
		try
		{
			strSql  = " Select \n";
			strSql += "     CD_CODE CODE, \n";
			strSql += "     KN_CODE NAME \n";
			strSql += " From	 TB_WT_COMMON_CODE  \n";
			strSql += " Where	 CD_CLASS = 'TAX002'  \n";
			strSql += " Union \n";
			strSql += " Select \n";
			strSql += "     '' CODE, \n";
			strSql += "     '' NAME \n";
			strSql += " From	 DUAL  \n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strTaxType = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
		}				
		lrArgData = new CITData();
		try
		{
			strSql  = " Select \n";
			strSql += "     CD_CODE CODE, \n";
			strSql += "     KN_CODE NAME \n";
			strSql += " From	 TB_WT_COMMON_CODE  \n";
			strSql += " Where	 CD_CLASS = 'TAX003'  \n";
			strSql += " Union \n";
			strSql += " Select \n";
			strSql += "     '' CODE, \n";
			strSql += "     '' NAME \n";
			strSql += " From	 DUAL  \n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDealClass = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

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
</script>
		
		<script language="javascript">
		<!--
			var	sSelectPageName = "<%=strFileName%>_q.jsp";
		//-->
		</script>

		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td width="379">
											<table width="379" border="0" cellspacing="0" cellpadding="0">
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="80" class=font_green_bold>�迭���ڵ�</td>
											<td width="62">
											<input name="txtCOMP_CODE" type="text" class="han" style="width:60px" onblur="txtCOMP_CODE_onblur()"></td>
											<td width="152">
											<input name="txtCOMP_NAME" type="text" class="ro" readOnly style="width:150px" ></td>
											<td width="70">
											<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td>&nbsp; </td>
											</table>
											</td>
											<td width="230">
											<table width="230" border="0" cellspacing="0" cellpadding="0">
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="80" class=font_green_bold>����ڹ�ȣ</td>
											<td width="120">
											<input name="txtHREG_NUM" type="text" class="han" style="width:120px" VALUE="" ></td>
											<td>&nbsp; </td>
											</table>
											</td>
											<td width="245">
											<table width="245" border="0" cellspacing="0" cellpadding="0">
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class=font_green_bold>��ȣ</td>
											<td width="150">
											<input name="txtHCOMPANY" type="text" class="han" style="width:150px" VALUE="" ></td>
											<td>&nbsp; </td>
											</table>
											</td>
											<td>&nbsp; </td>
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
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> ����� ���</td>
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
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td id="kkk" width="*" height="100%">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="Format" VALUE="
														<FC> Name=�迭���ڵ� ID=COM_ID Align=Center Width=70 Edit=none
														</FC>
														<FC> Name=����ڹ�ȣ ID=REG_NUM Width=100 Edit=none
														</FC>
														<C> Name=��ȣ ID=COMPANY  Width=250 Edit=none
														</C>
														<C> Name=WEBTAX21_ID ID=BIZNO2 Align=Center Width=100 Edit=none
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
												&nbsp;
											</td>
											<td width="15">&nbsp;</td>
											<td width="400" height="100%" valign="top" onActivate="G_focusDataset(dsMAIN)">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="30"><img src="../images/bullet2.gif"></td>
														<td class="font_green_bold"> ���γ���</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�迭���ڵ�</td>
														<td width="62">
														<input id="txtCOM_ID" type="text" notnull style="width:60px" onblur="txtCOM_ID_onblur()" ></td>
														<td width="152">
														<input id="txtCOM_NAME" type="text" notnull class="ro"  style="width:150px" ></td>
														<td width="*">
														<input id="btnCOM_ID" type="button" class="img_btnFind" value="�˻�" onclick="btnCOM_ID_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">����ڵ�Ϲ�ȣ</td>
														<td width="*"><input id="txtREG_NUM" type="text" notnull style="width:212px" onblur="txtREG_NUM_onblur()"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">������ڵ�</td>
														<td width="*"><input id="txtSAUP_CODE" type="text"  style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��ȣ</td>
														<td width="*"><input id="txtCOMPANY" type="text" style="width:260" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�ּ�</td>
														<td width="52"><input id="txtZIP_CODE" type="text" style="width:50px" onblur="txtZIP_CODE_onblur()"></td>
														<td width="210"><input id="txtADDRESS" type="text" class="ro" readonly style="width:208px" tabindex="-1"></td>
														<td width="*"><input id="btnZIP_CODE" type="button" class="img_btnFind_S" title="�����ȣã��" onclick="btnZIP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="115">&nbsp;</td>
														<td width="*"><input id="txtADDRESS2" type="text" style="width:260px"></td>
													</tr>
												</table>												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��ǥ��</td>
														<td width="*"><input id="txtEMPLOYER" type="text" style="width:180px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">����</td>
														<td width="*"><input id="txtBIZ_COND" type="text" style="width:180px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">����</td>
														<td width="*"><input id="txtBIZ_ITEM" type="text" style="width:180px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��ȭ��ȣ</td>
														<td width="*"><input id="txtTEL_NO" type="text" style="width:180px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">FAX��ȣ</td>
														<td width="*"><input id="txtFAX_NO" type="text" style="width:180px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��꼭���౸��</td>
														<td width="*">
															<select  id="cboTAXPUB_CLASS"  style="WIDTH: 150px">
															  <OPTION value='' selected> </OPTION>
																<OPTION value='10'>10 �Ϲݰ�꼭</OPTION>
																<OPTION value='20'>20 ���ݰ�꼭</OPTION>
															</select>
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��������</td>
														<td width="*">
															<select  id="cboTAX_TYPE"  style="WIDTH: 150px">
																<%=strTaxType%>
															</select>
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�ŷ�����</td>
														<td width="*">
															<select  id="cboDEAL_CLASS"  style="WIDTH: 150px">
																<%=strDealClass%>
															</select>
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">WEBTAX ID</td>
														<td width="*"><input id="txtWEBTAX21_ID" type="text" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�Է���</td>
														<td width="*"><input id="txtINSERT_DATE" type="text" readonly class="ro" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">�Է���</td>
														<td width="*"><input id="txtINSERT_EMP" type="text" readonly class="ro" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">����������</td>
														<td width="*"><input id="txtUPDATE_DATE" type="text" readonly class="ro" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">������</td>
														<td width="*"><input id="txtUPDATE_EMP" type="text" readonly class="ro" style="width:150px"></td>
													</tr>
												</table>												
											</td>
										</tr>
									</table>
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
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" VALUE="dsMAIN">
			<PARAM NAME="BindInfo" VALUE="
				<C> Col=COM_ID 					Ctrl=txtCOM_ID 				Param=value</C>
				<C> Col=COM_NAME				Ctrl=txtCOM_NAME 			Param=value</C>
				<C> Col=REG_NUM 				Ctrl=txtREG_NUM 			Param=value</C>
				<C> Col=SAUP_CODE				Ctrl=txtSAUP_CODE			Param=value</C>
				<C> Col=COMPANY 				Ctrl=txtCOMPANY	 			Param=value</C>
				<C> Col=EMPLOYER				Ctrl=txtEMPLOYER			Param=value</C>
				<C> Col=ZIP_CODE				Ctrl=txtZIP_CODE			Param=value</C>
				<C> Col=ADDRESS 				Ctrl=txtADDRESS 			Param=value</C>
				<C> Col=BIZ_COND 				Ctrl=txtBIZ_COND	 		Param=value</C>
				<C> Col=BIZ_ITEM 				Ctrl=txtBIZ_ITEM	 		Param=value</C>
				<C> Col=TEL_NO  				Ctrl=txtTEL_NO 				Param=value</C>
				<C> Col=FAX_NO  				Ctrl=txtFAX_NO 				Param=value</C>
				<C> Col=TAXPUB_CLASS 		Ctrl=cboTAXPUB_CLASS  Param=value</C>
				<C> Col=TAX_TYPE    		Ctrl=cboTAX_TYPE 			Param=value</C>
				<C> Col=DEAL_CLASS  		Ctrl=cboDEAL_CLASS 		Param=value</C>
				<C> Col=WEBTAX21_ID 		Ctrl=txtWEBTAX21_ID 	Param=value</C>
				<C> Col=INSERT_DATE 		Ctrl=txtINSERT_DATE 	Param=value</C>
				<C> Col=UPDATE_DATE 		Ctrl=txtUPDATE_DATE 	Param=value</C>
				<C> Col=INSERT_EMP  		Ctrl=txtINSERT_EMP 		Param=value</C>
				<C> Col=UPDATE_EMP  		Ctrl=txtUPDATE_EMP 		Param=value</C>
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
