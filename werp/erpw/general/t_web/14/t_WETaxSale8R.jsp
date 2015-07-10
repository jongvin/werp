<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WETaxSale5R.jsp(�ݷ����ݰ�꼭����)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-23) 
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null; 

//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WETaxSale8R";
	String strFileName01 = "t_WETaxSale8R";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMP_NAME = "";
	String strPAY_KIND = "";	
	String strEMP_NO = "";	
	String strDate  = CITDate.getNow("yyyyMMdd");
	String strCOM_ID = "";
	String strEMP_ID = "";	
	String strREG_NUM = "";
	String strSECT_NAME = "";
	String strEMP_NAME = "";
	String strEMAIL = "";
	String strMOBILE = "";

	try
	{
		CITCommon.initPage(request, response, session);
		CITData		lrArgData = new CITData();		
		
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strEMP_NO = CITCommon.toKOR((String)session.getAttribute("emp_no"));		

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
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMP_NAME)%>";
			var			sComid 		= "<%=strCOM_ID%>";
			var			sEmpid 		= "<%=strEMP_ID%>";
			var			sRegnum 	= "<%=strREG_NUM%>";
			var			sSectname = "<%=strSECT_NAME%>";
			var			sEmpname 	= "<%=strEMP_NAME%>";
			var			sEmail 		= "<%=strEMAIL%>";
			var			sMobile 	= "<%=strMOBILE%>";
			var			sDate  		= "<%=strDate%>";
			
		// �̺�Ʈ����-------------------------------------------------------------------//

		//-->
		</script>

		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize()">
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
											<td class=td_green>
												<!-- ���α׷��� ������ ���� //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class="font_green_bold" >�ۼ�����</td>													
														<td width="239">
														<table width="219" border="0" cellspacing="0" cellpadding="0">
														<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"></td>
														<td width="30"><input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
														<td width="15">~</td>
														<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"></td>
														<td width="30"><input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
														</table>	
														</td>	
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="150" class="font_green_bold" >�����ڻ����ȣ</td>
														<td width="152">
														<input id="txtSUP_REGNUM" type="text" class="han" onblur="btnSUP_REGNUM_onblur()" style="width:150px" ></td>
														<td width="162">
														<input id="txtSUP_COMPANY" type="text" class="ro" readOnly style="width:160px" ></td>														
														<td width="50">
														<input id="btnSUP_REGNUM" type="button" class="img_btnFind" value="�˻�" onclick="btnSUP_REGNUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td>&nbsp; </td>			
													</tr>
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class="font_green_bold" >������ȣ</td>
														<td width="239" align="left" >
															<input id="txtDOC_NUMBER"	type="text" center datatype="n"  maxlength=32 style="width:152px" tabindex="2" />
															<input id="btnDOCU_NO" type="button" class="img_btnFind" value="�˻�" onclick="btnDOCU_NO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>

														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="150" class="font_green_bold" >���޹޴��� �ڻ����ȣ</td>
														<td width="152">
														<input id="txtBUY_REGNUM" type="text" class="han" onblur="btnBUY_REGNUM_onblur()" style="width:150px" ></td>
														<td width="162">
														<input id="txtBUY_COMPANY" type="text" class="ro" readOnly style="width:160px" ></td>														
														<td width="50">
														<input id="btnBUY_REGNUM" type="button" class="img_btnFind" value="�˻�" onclick="btnBUY_REGNUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td>&nbsp; </td>			
													</tr>

												</table>
												<!-- ���α׷��� ������ ���� //-->
											</td>
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
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr >
												<td width="15" height="20"><img src="../images/bullet1.gif"></td>
												<td class="font_green_bold"> �ݷ����ݰ�꼭��Ȳ</td>												
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
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="ViewSummary" 	VALUE=0>
													<PARAM NAME="Format" VALUE="
														<C> Name=������ȣ ID=DOC_NUMBER  					Align=left  	Edit='none' Width=145
														</C>
														<C> Name=����������ȣ ID=BEF_DOC_NUMBER  	Align=left  	Edit='none' Width=145
														</C>
														<C> Name=�ۼ����� ID=GEN_TM  							Align=Left  	Edit='none' Width=70
														</C>
														<C> Name=ó������ ID=STATUS  							Align=Center  Edit='none'	Width=80
														</C>
														<C> Name=�������� ID=SUP_REGNUM 					Align=Left   	Edit='none'	Width=80 
														</C>
														<C> Name=�����ڻ����ȣ ID=SUP_COMPANY 		Align=Left   	Edit='none'	Width=105 
														</C>
														<C> Name=�޴��ڻ����ȣ ID=BUY_REGNUM 		Align=Left   	Edit='none'	Width=80 
														</C>
														<C> Name=���ް��� ID=BUY_COMPANY 					Align=Left  	Edit='none' Width=105
														</C>
														<C> Name=���� ID=TAX_SUPPRICE  						Align=right  	Edit='none' Width=95
														</C>														
														<C> Name=�ѱݾ� ID=PAY_TOTALPRICE  				Align=right  	Edit='none' Width=95	
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
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