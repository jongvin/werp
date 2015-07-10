<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WETaxSaleR(���ݰ�꼭�Ǻ����)
/* 2. ����(�ó�����) : ȭ�������
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-09)
/* 5. ����  ���α׷� : ������ǥ�� ��� �� ��ȸ
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strDt_Trans = CITDate.getNow("yyyyMMdd");
	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strFileName = "./t_WETaxSaleR";
	String strFileName01 = "t_WETaxSaleR";
	
//���� �׼�
	String strUpdateKeyValue = "";
	strUpdateKeyValue  = "Service1(";
	strUpdateKeyValue += "I:dsSLIP_H=dsSLIP_H, ";
	strUpdateKeyValue += "I:dsSLIP_D=dsSLIP_D";
	strUpdateKeyValue += ")";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_CODE = "";
	String strDEPT_NAME = "";
	String strEMP_NO = "";
	String strNAME = "";
	String strCombo1 = "";
	String strCombo2 = "";
	String strCombo3 = "";
	String strCOM_ID = "";
	String strEMP_ID = "";	
	String strREG_NUM = "";
	String strSECT_NAME = "";
	String strEMP_NAME = "";
	String strEMAIL = "";
	String strMOBILE = "";
	String strCOMPANY = "";
	String strEMPLOYER = "";
	String strADDRESS = "";
	String strBIZCOND = "";
	String strBIZITEM = "";

	try
	{
/*
out.println(""+(String)session.getAttribute("file_upload_dir"));
out.println(""+(String)session.getAttribute("emp_no"));
out.println(""+(String)session.getAttribute("name"));
out.println(""+(String)session.getAttribute("slip_trans_cls"));
out.println(""+(String)session.getAttribute("dept_chg_cls"));
out.println(""+(String)session.getAttribute("comp_code"));
out.println(""+(String)session.getAttribute("dept_code"));
out.println(""+(String)session.getAttribute("long_name"));
*/
			
		CITCommon.initPage(request, response, session, false);
		
		CITData lrArgData = new CITData();

		//�����
		strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
		strNAME = CITCommon.NvlString(session.getAttribute("name"));
		
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));

		//ȸ���ڵ�
		lrArgData = new CITData();
 		try
		{
				lrArgData.addColumn("EMP_NO",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("EMP_NO", strEMP_NO);

				strSql  = " select com_id ,   \n"; 
				strSql += " 			 emp_id ,  	\n"; 
				strSql += " 			 reg_num ,  \n"; 
				strSql += " 			 sect_name ,\n"; 
				strSql += " 			 emp_name ,	\n"; 
				strSql += " 			 emp_no ,		\n"; 
				strSql += " 			 email ,		\n"; 
				strSql += " 			 mobile			\n"; 
				strSql += " from   tb_wt_user \n";
				strSql += " where  emp_no = ? \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOM_ID  		= lrReturnData.toString(0,"COM_ID");
					strEMP_ID  		= lrReturnData.toString(0,"EMP_ID");
					strREG_NUM 		= lrReturnData.toString(0,"REG_NUM");
					strSECT_NAME 	= lrReturnData.toString(0,"SECT_NAME");
					strEMP_NAME 	= lrReturnData.toString(0,"EMP_NAME");
					strEMAIL 			= lrReturnData.toString(0,"EMAIL");
					strMOBILE 		= lrReturnData.toString(0,"MOBILE"); 
				}	
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:ȸ���ڵ� Select ���� -> " + ex.getMessage());
		}			
	
		//ȸ������
		lrArgData = new CITData();
 		try
		{
				lrArgData.addColumn("COM_ID",CITData.VARCHAR2);
				lrArgData.addColumn("REG_NUM",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("COM_ID", strCOM_ID);
				lrArgData.setValue("REG_NUM",strREG_NUM);

				strSql  = " select company ,   	\n"; 
				strSql += " 			 employer ,  	\n"; 
				strSql += " 			 address ,		\n"; 
				strSql += " 			 biz_cond ,		\n"; 
				strSql += " 			 biz_item  		\n"; 
				strSql += " from   TB_WT_PLANT 	\n";
				strSql += " where  com_id = ? 	\n";
				strSql += " and    reg_num = ? 	\n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOMPANY 	= lrReturnData.toString(0,"COMPANY");
					strEMPLOYER = lrReturnData.toString(0,"EMPLOYER");
					strADDRESS 	= lrReturnData.toString(0,"ADDRESS");
					strBIZCOND 	= lrReturnData.toString(0,"BIZ_COND");
					strBIZITEM 	= lrReturnData.toString(0,"BIZ_ITEM");
				}	
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:ȸ������ Select ���� -> " + ex.getMessage());
		}	
	
		//û��/����
		lrArgData = new CITData();
 		try
		{
				strSql  = " Select \n";
				strSql += "     CD_CODE CODE, \n";
				strSql += "     KN_CODE NAME \n";
				strSql += " From	 TB_WT_COMMON_CODE  \n";
				strSql += " Where	 CD_CLASS = 'TAX004'  \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				strCombo1 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� û��/���� Select ���� -> " + ex.getMessage());
		}		

		//��������
		lrArgData = new CITData();
 		try
		{
				strSql  = " Select \n";
				strSql += "     CD_CODE CODE, \n";
				strSql += "     KN_CODE NAME \n";
				strSql += " From	 TB_WT_COMMON_CODE  \n";
				strSql += " Where	 CD_CLASS = 'TAX002'  \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				strCombo2 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ��ǥ�����ڵ� Select ���� -> " + ex.getMessage());
		}		

		//�������
		lrArgData = new CITData();
 		try
		{
				strSql  = " Select \n";
				strSql += "     CD_CODE CODE, \n";
				strSql += "     KN_CODE NAME \n";
				strSql += " From	 TB_WT_COMMON_CODE  \n";
				strSql += " Where	 CD_CLASS = 'TAX005'  \n";
	
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				strCombo3 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ��ǥ�����ڵ� Select ���� -> " + ex.getMessage());
		}				
		//����� ���� ����

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
			var			sDate  		= "<%=strDate%>";
			var			sEmpno 		= "<%=strEMP_NO%>";
			var			sComid 		= "<%=strCOM_ID%>";
			var			sEmpid 		= "<%=strEMP_ID%>";
			var			sRegnum 	= "<%=strREG_NUM%>";
			var			sSectname = "<%=strSECT_NAME%>";
			var			sEmpname 	= "<%=strEMP_NAME%>";
			var			sEmail 		= "<%=strEMAIL%>";
			var			sMobile 	= "<%=strMOBILE%>";
			var			sCompany 	= "<%=strCOMPANY%>";
			var			sEmployer = "<%=strEMPLOYER%>";
			var			sAddress 	= "<%=strADDRESS%>";
			var			sBizcond 	= "<%=strBIZCOND%>";
			var			sBizitem 	= "<%=strBIZITEM%>";
			
		//-->
		</script>
		
<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsSERIAL classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsSLIP_H classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsSLIP_D classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><object id=dsITEM classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->

<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<param name="KeyValue" value="<%=strUpdateKeyValue%>">
	<param name="Action"    value="<%=strFileName%>_tr.jsp">
</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->

<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><object id="transMAIN"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<param name="KeyValue" value="Service1(I:dsMAIN=dsMAIN)">
	<param name="Action"    value="./t_WSlipSelPrintR_tr.jsp">
</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()" tabindex="-1">
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strFileName01%>">
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
						<iframe width="0" height="0" name="hidden" src="" frameborder="0" tabindex="-1"></iframe>
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
											<td width="70" class="font_green_bold" >������ȣ</td>
											<td width="152">
												<input id="txtDOC_NUMBER"	type="text" center datatype="n"  maxlength=32 onblur="btnDOCU_NO_onblur()" style="width:150px" tabindex="2" />
											</td>
											<td width="21">
												<input id="btnDOCU_NO" type="button" class="img_btnFind" value="�˻�" onclick="btnDOCU_NO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td>&nbsp;</td>
										</tr>
									</table>

									<div id="divSLIP_H"  style="display:none">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*">
													<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" 		VALUE="dsSLIP_H">
														<PARAM NAME="Editable"  	VALUE="true">
														<PARAM NAME="ColSelect" 	VALUE="true">
														<PARAM NAME="ColSizing" 	VALUE="true">
														<PARAM NAME="ViewSummary" 	VALUE=1>
														<PARAM NAME="Format" 		VALUE="
															<C> Name=������ȣ 					ID=DOC_NUMBER	Width=100
															</C>
															<C> Name=ȸ���ڵ� 	  			ID=DOC_COM_ID	Width=100
															</C>
															<C> Name=�ۼ���� 					ID=DOC_YYMM 	Width=100
															</C>
															<C> Name=�����ް�����ȣ 		ID=MTSID			Width=100
															</C>
															<C> Name=���� 							ID=STATUS			Width=100
															</C>
															<C> Name=�ŷ���ó���䱸		ID=TX_REQ 		Width=100
															</C>
															<C> Name=��������						ID=DEL_STATUS Width=100
															</C>
															">
													</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL ������������//-->
													
												</td>
											</tr>
										</table>
									</div>
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
											<td class="font_green_bold"> ���ݰ�꼭</td>
											<td align="right" width="*">
<input id="btnDISPLAY"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnquery_prt_onclick();"	value="�̸�����"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnCANCEL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnCANCEL_onclick();"		value="�������"		onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnCREATE"	type="button" tabindex="-1" class="img_btn9_1" onClick="btnCREATE_onclick();"	value="���ڼ��ݰ�꼭����"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="100%" onActivate="G_focusDataset(dsSLIP_H)">
									<div id="divSLIP_H">
										<table width="100%" height="35%" border="1" bordercolor="black" cellspacing="0" cellpadding="2">
											<tr>
												<td colspan="2" style="background:#F6F6F6">
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="80">å��ȣ</td>
															<td width="80"><input id="txtREF_VOLUME" type="text" Datatype="N" right readOnly adsreadonly tabindex="-1" style="width:100px;background:#ECF5EB"/></td>
															<td width="10">��</td>
															<td width="80"><input id="txtREF_NUMBER" type="text" Datatype="N" right readOnly adsreadonly tabindex="-1" style="width:100px;background:#ECF5EB"/></td>
															<td width="10">ȣ</td>
															<td width="30">&nbsp;</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65">�Ϸù�ȣ</td>
															<td width="102">
											   				<input id="txtREF_SERIAL" type="text" tabindex="120" readOnly adsreadonly style="width:100px;background:#ECF5EB" />
															</td>
															<td width="*">&nbsp;</td>
														</tr>
													</table>
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15" height="30"><img src="../images/bullet2.gif"></td>
															<td width="420" class="font_green_bold"> ������</td>
															<td width="15" height="30"><img src="../images/bullet2.gif"></td>
															<td width="*" class="font_green_bold"> ���޹޴���</td>															
														</tr>
													</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >��Ϲ�ȣ</td>
														<td width="152">
														<input id="txtSUP_REGNUM" type="text" class="han" style="width:150px;background:#E0F4FF" readOnly ></td>
														<input id="txtSUP_ID" type="hidden" style="width:150px" ></td>
														<input id="txtDOC_COM_ID" type="hidden" style="width:150px" ></td>
														<input id="txtDOC_YYMM" type="hidden" style="width:150px" ></td>
														<input id="txtDEL_STATUS" type="hidden" style="width:150px" ></td>
														<input id="txtSENDER" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_EMPID" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_EMPEMAIL" type="hidden" style="width:150px" ></td>
														<input id="txtSUP_EMPMOBILE" type="hidden" style="width:150px" ></td>
														<td width="50">
														<input id="btnSUP_REGNUM" type="button" class="img_btnFind" value="�˻�" onclick="btnSUP_REGNUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="138">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >��Ϲ�ȣ</td>
														<td width="152">
														<input id="txtBUY_REGNUM" type="text" class="han" style="width:150px;background:#FFECEC" readOnly ></td>
														<input id="txtBUYCOM_ID" type="hidden" style="width:150px" ></td>
														<input id="txtRECEIVER" type="hidden" style="width:150px" ></td>
														<td width="*">
														<input id="btnBUY_REGNUM" type="button" class="img_btnFind" value="�˻�"  onclick="btnBUY_REGNUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >��ȣ(���θ�)</td>
														<td width="162">
														<input id="txtSUP_COMPANY" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >����</td>
														<td width="100">
														<input id="txtSUP_EMPLOYER" type="text" class="ro" readOnly style="width:100px"></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >��ȣ(���θ�)</td>
														<td width="162">
														<input id="txtBUY_COMPANY" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >����</td>
														<td width="*">
														<input id="txtBUY_EMPLOYER" type="text" class="ro" readOnly style="width:100px" ></td>
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >������ּ�</td>
														<td width="317">
														<input id="txtSUP_ADDRESS" type="text" class="ro" readOnly style="width:317px" ></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >������ּ�</td>
														<td width="*">
														<input id="txtBUY_ADDRESS" type="text" class="ro" readOnly style="width:317px" ></td>
													</tr>
												</table>	
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >����</td>
														<td width="162">
														<input id="txtSUP_BIZCOND" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >����</td>
														<td width="100">
														<input id="txtSUP_BIZITEM" type="text" class="ro" readOnly style="width:100px" ></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >����</td>
														<td width="162">
														<input id="txtBUY_BIZCOND" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >����</td>
														<td width="*">
														<input id="txtBUY_BIZITEM" type="text" class="ro" readOnly style="width:100px" ></td>														
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >���μ�</td>
														<td width="162">
														<input id="txtSUP_SECTOR" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >����</td>
														<td width="100">
														<input id="txtSUP_EMPLOYEE" type="text" class="ro" readOnly style="width:100px" ></td>
														<td width="23">&nbsp;</td>
														
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" >���μ�</td>
														<td width="162">
														<input id="txtBUY_SECTOR" type="text" class="ro" readOnly style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40" >����</td>
														<td width="*">
														<input id="txtBUY_EMPLOYEE" type="text" class="ro" readOnly style="width:100px" >
														<input id="btnBUY_EMPLOYEE" type="button" class="img_btnFind" value="�˻�"  onclick="btnBUY_EMPLOYEE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">�ۼ�����</td>
														<td width="72"><input id="txtGEN_TM" type="text" datatype="date" style="width:70px"></td>
														<td width="90"><input id="btnGEN_TM" type="button" class="img_btnCalendar_S" onClick="btnGEN_TM_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40">������</td>
														<td width="123"><input id="txtBLANK_NUM" type="text" class="ro" readOnly center style="width:30px" onchange="calcVATAMT();"/></td>

														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">���</td>
														<td width="*"> <input id="txtTAX_BIGO" type="text" style="width:317px"/></td>													
													</tr>
												</table>
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">���ް���</td>
														<td width="162"><input id="txtTAX_SUPPRICE" type="text" class="ro" readOnly right style="width:150px" />
														<input id="txtPAY_TOTALPRICE" type="hidden" style="width:150px" ></td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="40">����</td>
														<td width="100"> <input id="txtTAX_TAXPRICE" type="text" class="ro" readOnly right style="width:100px"/></td>

													</tr>
												</table>						
												</td>
											</tr>
										</table>
										<table width="100%" height="5%" border="0" cellspacing="0" cellpadding="0">
											<form name="fileUploadForm" method="post" target="hidden" enctype="multipart/form-data">
												<tr align=right >
													<td width="15" height="20" ><img src="../images/bullet1.gif"></td>
													<td class="font_green_bold"> �ŷ�����</td>
																<td width="200">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="110" class="font_green_bold">�ŷ��� UPLOAD</td>
																<td width="230"><input type="file" name="fileCMS" length='8' value=""></td>
																<td width="5" class=font_green_bold >&nbsp;</td>
																<td width="*"><input id="btnFileLoad" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="���Ϻҷ�����" onclick="btnFileLoad_onClick();" />
																<input id="btnADDROW"	type="button" tabindex="-1" class="img_btn6_1" onClick="btnADDROW_onclick();"		value="�ŷ����߰�"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
																<input id="btnDELETEROW"	type="button" tabindex="-1" class="img_btn6_1" onClick="btnDELETEROW_onClick()"			value="�ŷ�������" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
																</td>																
												  </tr>				
											</form>
										</table>
																																
										<table width="100%" height="59%" border="1" bordercolor="black" cellspacing="0" cellpadding="2">										
											<tr>
												<td width="690" height="100%">
													<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" 		VALUE="dsSLIP_D">
														<PARAM NAME="Editable"  	VALUE="true">
														<PARAM NAME="ColSelect" 	VALUE="true">
														<PARAM NAME="ColSizing" 	VALUE="true">
														<PARAM NAME="ViewSummary" 	VALUE=-1>
														<PARAM NAME="MultiRowSelect"VALUE="true">
														<PARAM NAME="Format" 		VALUE="
<FC> Name=���� 			ID=ITEM_SEQ	BgColor=#ECF5EB Width=34 Align=Center Edit='none'</FC>
<FC> Name=�ŷ��� 		ID=TAX_GENDATE			BgColor=#FFFCE0 Align=Center width=75 </FC>
<FC> Name=��ǰ�ڵ� 	ID=ITEM_CODE			BgColor=#FFFCE0 Align=Center width=120 </FC>
<FC> Name=��ǰ�� 		ID=ITEM_NAME 		BgColor=#FFFCE0 Width=150 </FC>
<C>  Name=�԰� 			ID=ITEM_UNIT 		Align=right Width=50 </C>
<C>  Name=����			ID=ITEM_NUM			width=100 </C>
<C>  Name=�ܰ�			ID=ITEM_DANGA		width=100 </C>
<C>  Name=���ް���		ID=TAX_SUPPRICE		BgColor=#ECF5EB	width=100 </C>
<C>  Name=����			ID=TAX_TAXPRICE	BgColor=#ECF5EB	width=100 </C>
<C>  Name=���			ID=ITEM_BIGO 		width=200 </C>
															">
													</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL ������������//-->
													<script> __ws__(gridSUB); </script>
												</td>
												<td width="*" height="100%" valign="top" onActivate="G_focusDataset(dsSLIP_H)">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">�����ް�����ȣ</td>
															<td width="*"> <input id="txtMTSID" type="text" class="ro" readOnly style="width:150px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">�ŷ���ó������</td>
															<td width="*"> <input id="txtTX_REQ" type="checkbox" style="width:50px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">�����ۼ�</td>
															<td width="*"> <input id="txtITEM_NUM" type="text" class="ro" readOnly center style="width:50px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">ó������</td>
															<td width="*"> <input id="txtSTATUS" type="hidden"  style="width:100px"/></td>															
															<td width="*"> <input id="txtSTATUS_NAME" type="text"  class="ro" readOnly style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">û��/����</td>
															<td width="*">
															<select  id="cboREF_TYPE"  style="WIDTH: 100px">
																<%=strCombo1%>
															</select></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">��������</td>
															<td width="*">
															<select  id="cboTAX_TYPE"  onchange="cboTAX_TYPE_onChange()"  style="WIDTH: 100px">
																<%=strCombo2%>
															</select></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">�������</td>
															<td width="*">
															<select  id="cboMSG_TYPE"  style="WIDTH: 100px">
																<%=strCombo3%>
															</select></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">��������</td>
															<td width="*">
															<select  id="cboRES_FLAG"  style="WIDTH: 100px">
																<OPTION value='1'>1 : ALL</OPTION>
																<OPTION value='0'>0 : Comfirm only</OPTION>
															</select></td>															
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">���޹޴���ID</td>
															<td width="*"> <input id="txtBUY_ID" type="text" class="ro" readOnly style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">���޹޴��ڻ��</td>
															<td width="*"> <input id="txtBUY_EMPID" type="text" class="ro" readOnly style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">���޹޴����̸���</td>
															<td width="*"> <input id="txtBUY_EMPEMAIL" type="text" style="width:100px"/></td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="100">���޹޴��ڸ����</td>
															<td width="*"> <input id="txtBUY_EMPMOBILe" type="text"  style="width:100px"/></td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- ���α׷��� ������ ���� //-->
			</table>
		</div>
		<!-- ���콺 Bind ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" 		VALUE="dsSLIP_H">
			<PARAM NAME="BindInfo"	VALUE="
				<C> Col=DOC_NUMBER 				Ctrl=txtDOC_NUMBER 									Param=value</C><!--����� set//-->
				<C> Col=DOC_COM_ID 				Ctrl=txtDOC_COM_ID 									Param=value</C>
				<C> Col=DOC_YYMM 					Ctrl=txtDOC_YYMM 										Param=value</C>
				<C> Col=MTSID 						Ctrl=txtMTSID												Param=value</C>
				<C> Col=STATUS						Ctrl=txtSTATUS											Param=value</C>
				<C> Col=STATUS_NAME				Ctrl=txtSTATUS_NAME									Param=value</C>
				<C> Col=TX_REQ  					Ctrl=txtTX_REQ											Param=checked</C>
				<C> Col=DEL_STATUS  			Ctrl=txtDEL_STATUS									Param=value</C>
				<C> Col=SENDER   					Ctrl=txtSENDER	 										Param=value</C>
				<C> Col=RECEIVER					Ctrl=txtRECEIVER 										Param=value</C>
				<C> Col=ERR_INDEX					Ctrl=txtERR_INDEX 									Param=value</C><!--������ //-->
				<C> Col=ERR_MSG 			 		Ctrl=txtERR_MSG		 									Param=value</C><!--������ //-->
				<C> Col=REF_VOLUME 		 		Ctrl=txtREF_VOLUME 									Param=value</C><!--������ //-->
				<C> Col=REF_NUMBER				Ctrl=txtREF_NUMBER		 							Param=value</C><!--������ //-->
				<C> Col=REF_SERIAL  			Ctrl=txtREF_SERIAL	 								Param=value</C><!--����� set//-->
				<C> Col=REF_TYPE   				Ctrl=cboREF_TYPE	 									Param=value</C>
				<C> Col=TAX_TYPE					Ctrl=cboTAX_TYPE 										Param=value</C>				
				<C> Col=MSG_TYPE   				Ctrl=cboMSG_TYPE	 									Param=value</C>
				<C> Col=RES_FLAG					Ctrl=cboRES_FLAG 										Param=value</C>
				<C> Col=SUP_ID						Ctrl=txtSUP_ID 											Param=value</C>
				<C> Col=SUP_REGNUM 				Ctrl=txtSUP_REGNUM									Param=value</C>
				<C> Col=SUP_COMPANY 			Ctrl=txtSUP_COMPANY									Param=value</C>
				<C> Col=SUP_EMPLOYER			Ctrl=txtSUP_EMPLOYER								Param=value</C>
				<C> Col=SUP_ADDRESS  			Ctrl=txtSUP_ADDRESS									Param=value</C>
				<C> Col=SUP_BIZCOND  			Ctrl=txtSUP_BIZCOND									Param=value</C>
				<C> Col=SUP_BIZITEM  			Ctrl=txtSUP_BIZITEM									Param=value</C>
				<C> Col=SUP_SECTOR				Ctrl=txtSUP_SECTOR									Param=value</C>
				<C> Col=SUP_EMPLOYEE			Ctrl=txtSUP_EMPLOYEE								Param=value</C>
				<C> Col=SUP_EMPID 				Ctrl=txtSUP_EMPID										Param=value</C>
				<C> Col=SUP_EMPEMAIL 			Ctrl=txtSUP_EMPEMAIL								Param=value</C>
				<C> Col=SUP_EMPMOBILE			Ctrl=txtSUP_EMPMOBILE								Param=value</C>
				<C> Col=BUY_COM_ID  			Ctrl=txtBUY_COM_ID									Param=value</C>
				<C> Col=BUY_ID  					Ctrl=txtBUY_ID											Param=value</C>
				<C> Col=BUY_COM_ID  			Ctrl=txtBUYCOM_ID										Param=value</C> 
				<C> Col=BUY_ID  					Ctrl=txtBUY_ID											Param=value</C>
				<C> Col=BUY_REGNUM   			Ctrl=txtBUY_REGNUM									Param=value</C>
				<C> Col=BUY_COMPANY				Ctrl=txtBUY_COMPANY									Param=value</C>
				<C> Col=BUY_EMPLOYER			Ctrl=txtBUY_EMPLOYER								Param=value</C>
				<C> Col=BUY_ADDRESS 			Ctrl=txtBUY_ADDRESS									Param=value</C>
				<C> Col=BUY_BIZCOND 			Ctrl=txtBUY_BIZCOND									Param=value</C>
				<C> Col=BUY_BIZITEM				Ctrl=txtBUY_BIZITEM									Param=value</C>
				<C> Col=BUY_SECTOR  			Ctrl=txtBUY_SECTOR									Param=value</C>
				<C> Col=BUY_EMPLOYEE  		Ctrl=txtBUY_EMPLOYEE								Param=value</C>
				<C> Col=BUY_EMPID 		   	Ctrl=txtBUY_EMPID   								Param=value</C>
				<C> Col=BUY_EMPEMAIL 	   	Ctrl=txtBUY_EMPEMAIL 								Param=value</C>
				<C> Col=BUY_EMPMOBILE	   	Ctrl=txtBUY_EMPMOBILE 							Param=value</C>
				<C> Col=SBM_TM  			   	Ctrl=txtSBM_TM  										Param=value</C><!-- systemdatetime //-->
				<C> Col=GEN_TM  			   	Ctrl=txtGEN_TM   										Param=value</C>
				<C> Col=DLV_TM   			   	Ctrl=txtDLV_TM   										Param=value</C><!-- ����� //-->
				<C> Col=RCV_TM				    Ctrl=txtRCV_TM 											Param=value</C><!-- ������ //-->
				<C> Col=ACT_TM				    Ctrl=txtACT_TM  										Param=value</C><!-- ó����(���ζǴ¹ݷ�)//-->
				<C> Col=DEL_TM 						Ctrl=txtDEL_TM											Param=value</C><!-- ������  //-->
				<C> Col=XMLFILE 					Ctrl=txtXMLFILE											Param=value</C>
				<C> Col=ADDFILE 			    Ctrl=txtADDFILE        							Param=value</C>   
				<C> Col=TAX_SUPPRICE	    Ctrl=txtTAX_SUPPRICE        				Param=value</C><!-- �ŷ��� ����� set //-->
				<C> Col=TAX_TAXPRICE      Ctrl=txtTAX_TAXPRICE        				Param=value</C><!-- �ŷ��� ����� set //-->
				<C> Col=PAY_TOTALPRICE    Ctrl=txtPAY_TOTALPRICE       				Param=value</C><!-- �ŷ��� ����� set //-->
				<C> Col=TAX_BIGO   		  	Ctrl=txtTAX_BIGO     								Param=value</C>
				<C> Col=ITEM_NUM			  	Ctrl=txtITEM_NUM     								Param=value</C><!-- �ŷ��� ����� set //-->
				<C> Col=BLANK_NUM			  	Ctrl=txtBLANK_NUM     							Param=value</C>				
			">
		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL ������������//-->
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