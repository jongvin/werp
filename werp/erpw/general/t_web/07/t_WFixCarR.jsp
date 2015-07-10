<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WFixCarR.jsp(�����ڻ��������)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : �����ڻ�������� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WFixCarR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	CITData		lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String strDEPREC_FINISH 		= "";
	String strFIXED_CLS		 	= "";
	String strGET_CLS		 		= "";
	String strDEPREC_CLS	 		= "";
	String strNEW_OLD_ASSET	 	= "";
	String strDEPREC_FINISH_NAME	= "";
	String strINCNTRY_OUTCNTRY_CLS = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
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
			
		try
		{
			lrArgData = new CITData();
			strSql  =  " Select CODE_LIST_ID as CODE, 				\n";
			strSql += "        CODE_LIST_NAME as NAME 				\n";
			strSql += " From   V_T_CODE_LIST 					\n";
			strSql += " Where  CODE_GROUP_ID = 'DEPREC_FINISH' 	\n";
			strSql += " And    USE_TAG = 'T' 						\n";
			strSql += " Order by SEQ 							\n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// �߿��� �κ�
			strDEPREC_FINISH = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
			strDEPREC_FINISH_NAME = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �Ϸᱸ�� Select ���� -> " + ex.getMessage());
		}

		
		try
		{
			lrArgData = new CITData();
			strSql  =  " Select CODE_LIST_ID as CODE, \n";
			strSql += "         CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'DEPREC_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// �߿��� �κ�
			strDEPREC_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �Ϸᱸ�� Select ���� -> " + ex.getMessage());
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
			var			olddata1 = "";
			var			olddata2 = "";
			var			olddata3 = "";
			var			olddata4 = "";
			var			strAssetClsCode ="E"; //�ڻ������ڵ� - ����
			var			strAssetName = "";
			var			strAssetMngNo = "";
			var			strDeprecFinishName = "";
			var			strFixAssetSeq = "";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
			
		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsDEPREC_FINISH classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >�����</td>
											<td width="52">
												<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width=60>&nbsp;</td>
										
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >�Ϸᱸ��</td>
											<td width="102">
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><OBJECT id="cboDEPREC_FINISH" style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT codebase="../../../cabfiles/LuxeCombo.cab#version=1,1,0,16">
													<PARAM NAME="ComboStyle" VALUE="5">
													<PARAM NAME="EditExprFormat" VALUE="%;CODE_LIST_NAME">
													<PARAM name="ListExprFormat" value="%;CODE_LIST_NAME">
													<PARAM NAME="Index" VALUE="0">
													<PARAM NAME="Sort" VALUE="-1">
													<PARAM NAME="SearchColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="SortColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="BindColumn" VALUE="CODE_LIST_ID">
													<PARAM NAME="ComboDataID" VALUE="dsDEPREC_FINISH">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
											</td>
											<td width=*>&nbsp;</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >ǰ�񱸺�</td>
											<td width="52">
												<input id="txtITEM_CODE" type="text" style="width:50px" onblur="txtITEM_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtITEM_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnITEM_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnITEM_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="3">&nbsp;</td>
											<td width="20">&nbsp;</td>
											<td width="28">&nbsp;</td>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >ǰ����</td>
											<td width="52">
												<input id="txtITEM_NM_CODE" type="text" style="width:50px" onblur="txtITEM_NM_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtITEM_NM_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="30">
												<input id="btnITEM_NM_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnITEM_NM_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="3">&nbsp;</td>
											<td width="20">&nbsp;</td>
											<td width="30">&nbsp;</td>
											<td width="10">&nbsp;</td>
											<td width=*>&nbsp;</td>
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
								<td class="font_green_bold">�ڻ�⺻����</td>
								<td align="right">
									&nbsp;
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" height="350" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="false">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=�ڻ��ȣ 		ID=ASSET_MNG_NO	Align=Center	 Width=100   	Show='true'     Sort='true'
											</C>
											<C> Name=�ڻ��Ī 		ID=ASSET_NAME		Align=Left	 Width=250   	Show='true'  Sort='true'
											</C>
											<C> Name=�Ϸᱸ�� 		ID=DEPREC_FINISH_NAME Align=Center	 Width=100 Show='true'
											</C>
											<C> Name=������ȣ 		ID=CAR_NO		Align=Left	 Width=100   	Show='true'  Sort='true'
											</C>
											<C> Name=�����ȣ 		ID=CAR_BODY_NO		Align=Left	 Width=100   	Show='true'  Sort='true'
											</C>
											<C> Name=���� 			ID=CAR_YEAR		Align=center	 Width=50   	Show='true'  Sort='true'
											</C> 
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL ������������//-->
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
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> �������γ���</td>
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
							<tr  valign="top"
>
								<td width="100%"  height="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td bgcolor="#FFFFFF">
												<!-- ���α׷��� ������ ���� //-->
												<!-- �������� ���̺� ���� //-->
												
												<!-- �������� ���̺� ���� //-->
												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">������ȣ</td>
														<td width="218"> <input id="txtCAR_NO" type="text" style="width:216px" ></td>
														<td width="36">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">�����ȣ</td>
														<td width="198"> <input id="txtCAR_BODY_NO" type="text" style="width:196px" ></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">����</td>
														<td width="100">
														      <input id="txtCAR_YEAR" type="text"  style="width : 98px" RIGHT>
														</td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">����</td>
														<td width="102"><input id="txtCAR_LENGTH" type="text"   style="width:98px" center></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">�ʺ�</td>
														<td width="100"> <input id="txtCAR_WIDTH" type="text" style="width:98px" center></td>
														<td width="23">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">����</td>
														<td width="102"> <input id="txtCAR_HEIGHT" type="text"   style="width:100px" center></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">�߷�</td>
														<td width="102"><input id="txtCAR_WEIGHT" type="text"   style="width:98px" center></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">��ⷮ</td>
														<td width="102"><input id="txtCAR_CC" type="text"  style="width:98px" center></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">�����</td>
														<td width="100"> <input id="txtCAR_CYLINDER" type="text"  style="width:98px" center></td>
														<td width="23">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">���Ľ��ι�ȣ</td>
														<td width="102"> <input id="txtCAR_FORM_NO" type="text"  style="width:100px" center></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">����</td>
														<td width="102"><input id="txtCAR_OIL" type="text" style="width:98px" center></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">�뵵</td>
														<td width="102"><input id="txtCAR_USE" type="text" style="width:98px" center></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">�����</td>
														<td width="100"> <input id="txtCAR_USER" type="text" style="width:98px" center></td>
														<td width="23">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">����˻������</td>
														<td width="102"> 
															<input id="txtREGULAR_CHECK_START" type="text" datatype="date" style="width:80px" center><input id="btnREGULAR_CHECK_START" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnREGULAR_CHECK_START_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">����˻�������</td>
														<td width="102"><input id="txtREGULAR_CHECK_END" type="text" datatype="date" style="width:80px" center><input id="btnREGULAR_CHECK_END" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnREGULAR_CHECK_END_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">��漼</td>
														<td width="102"><input id="txtGET_TAX" type="text" datatype="currency" style="width:98px" center></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">��ϼ�</td>
														<td width="100"> <input id="txtREG_TAX" type="text" datatype="currency" style="width:98px" center></td>
														<td width="23">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">�ΰ���</td>
														<td width="102"><input id="txtVAT_TAX" type="text" datatype="currency" style="width:100px" center></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="10">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">�����������</td>
														<td width="102"><input id="txtINSURANCE_START" type="text" datatype="date" style="width:80px" center><input id="btnINSURANCE_START" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnINSURANCE_START_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
														<td width="20">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80">������������</td>
														<td width="100"> <input id="txtINSURANCE_END" type="text" datatype="date" style="width:80px" center><input id="btnINSURANCE_END" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnINSURANCE_END_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<!-- �������� ���̺� ���� //-->
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="10"></td>
													</tr>
												</table>
												<!-- �������� ���̺� ���� //-->
												<!-- ���α׷��� ������ ���� //-->
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
		<!-- ���콺 Bind ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=ADE_Bind_1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
	<PARAM NAME="DataID" VALUE="dsMAIN">
	<PARAM NAME="BindInfo" VALUE="
		<C>Col=CAR_NO                     	Ctrl=txtCAR_NO                Param=value
		</C>
		<C>Col=CAR_BODY_NO          	Ctrl=txtCAR_BODY_NO       Param=value
		</C>
		<C>Col=CAR_YEAR                  	Ctrl=txtCAR_YEAR              Param=value
		</C>
		<C>Col=CAR_LENGTH              	Ctrl=txtCAR_LENGTH              Param=value
		</C>
		<C>Col=CAR_WIDTH               	Ctrl=txtCAR_WIDTH              Param=value
		</C>
		<C>Col=CUST_SEQ                 	Ctrl=hiCUST_SEQ               	Param=value
		</C>
		<C>Col=CAR_HEIGHT              	Ctrl=txtCAR_HEIGHT               Param=value
		</C>
		<C>Col=CAR_WEIGHT             	Ctrl=txtCAR_WEIGHT              Param=value
		</C>
		<C>Col=CAR_CC                    	Ctrl=txtCAR_CC                	 Param=value
		</C>
		<C>Col=CAR_CYLINDER           	Ctrl=txtCAR_CYLINDER             Param=value
		</C>
		<C>Col=CAR_FORM_NO           	Ctrl=txtCAR_FORM_NO             Param=value
		</C>
		<C>Col=CAR_OIL                    	Ctrl=txtCAR_OIL               	  Param=value
		</C>
		<C>Col=CAR_USE                     	Ctrl=txtCAR_USE                		Param=value
		</C>
		<C>Col=CAR_USER               	Ctrl=txtCAR_USER          		Param=value
		</C>
		<C>Col=REGULAR_CHECK_START  Ctrl=txtREGULAR_CHECK_START   Param=value
		</C>
		<C>Col=REGULAR_CHECK_END      Ctrl=txtREGULAR_CHECK_END      Param=value
		</C>
		<C>Col=GET_TAX                  	Ctrl=txtGET_TAX             		Param=value
		</C>
		<C>Col=REG_TAX                		Ctrl=txtREG_TAX           			Param=value
		</C>
		<C>Col=VAT_TAX                	Ctrl=txtVAT_TAX           		Param=value
		</C>
		<C>Col=INSURANCE_START         Ctrl=txtINSURANCE_START               	Param=value
		</C>
		<C>Col=INSURANCE_END              Ctrl=txtINSURANCE_END               	Param=value
		</C>
		
		">
</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL ������������//-->
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