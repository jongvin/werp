<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WETaxItemR(��ǰ�ڵ���)
/* 2. ����(�ó�����) : ������� ��ȸ �� �Է�
/* 3. ��  ��  ��  �� :
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-11)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/

	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�
	String strFileName = "./t_WETaxItemR";
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
											<td width="80" class=font_green_bold>��ǰ�ڵ�</td>
											<td width="120">
											<input name="txtHITEM_CODE" type="text" class="han" style="width:120px" VALUE="" ></td>
											<td>&nbsp; </td>
											</table>
											</td>
											<td width="245">
											<table width="245" border="0" cellspacing="0" cellpadding="0">
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class=font_green_bold>��ǰ��</td>
											<td width="150">
											<input name="txtHITEM_NAME" type="text" class="han" style="width:150px" VALUE="" ></td>
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
									<form name="fileUploadForm" method="post" target="hidden" enctype="multipart/form-data">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> ��ǰ ���</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="150" class="font_green_bold">��ǰ���� UPLOAD</td>
														<td width="230"><input type="file" name="fileCMS" length='8' value=""></td>
														<td width="5" class=font_green_bold >&nbsp;</td>
														<td width="77"><input id="btnFileLoad" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="���Ϻҷ�����" onclick="btnFileLoad_onClick();" /></td>
														<td>&nbsp;</td>
									</form>				
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
														<FC> Name=��ǰ�ڵ� ID=ITEM_CODE Width=100 Edit=none
														</FC>
														<C> Name=��ǰ�� ID=ITEM_NAME  Width=250 Edit=none
														</C>
														<C> Name=��ǰũ�� ID=ITEM_SIZE Align=Center Width=100 Edit=none
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
														<td width="100">��ǰ�ڵ�</td>
														<td width="*"><input id="txtITEM_CODE" type="text" notnull style="width:100px" maxlength="18"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��ǰ��</td>
														<td width="*"><input id="txtITEM_NAME" type="text" notnull style="width:212px" maxlength="32"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">��ǰũ��</td>
														<td width="*"><input id="txtITEM_SIZE" type="text" style="width:212" maxlength="12"></td>
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
				<C> Col=ITEM_CODE 			Ctrl=txtITEM_CODE 		Param=value</C>
				<C> Col=ITEM_NAME				Ctrl=txtITEM_NAME			Param=value</C>
				<C> Col=ITEM_SIZE 			Ctrl=txtITEM_SIZE	 		Param=value</C>
				<C> Col=INSERT_DATE 		Ctrl=txtINSERT_DATE 	Param=value</C>
				<C> Col=UPDATE_DATE 		Ctrl=txtUPDATE_DATE 	Param=value</C>
				<C> Col=INSERT_EMP  		Ctrl=cboINSERT_EMP 		Param=value</C>
				<C> Col=UPDATE_EMP  		Ctrl=txtUPDATE_EMP 		Param=value</C>
			">
		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Bind ��ü���� ���� //-->
				<!--
				<C> Col=BUDG_DIVERT_CLS 		Ctrl=chkBUDG_DIVERT_CLS 		Param=checked</C>
				<C> Col=BUDG_TRANS_CLS 			Ctrl=chkBUDG_TRANS_CLS 			Param=checked</C>
				-->
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
