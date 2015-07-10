<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_PFixDeprecCal";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	CITData lrArgData = null;
	String strOut = "";
	String strSql = "";
	String strDEPREC_CLS = "";
	String strDEPREC_FINISH = "";
    try
    {
    	CITCommon.initPage(request, response, session);

    		
		try 
		{
			lrArgData = new CITData();
			
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'DEPREC_FINISH' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// �߿��� �κ�
			strDEPREC_FINISH = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME"); // ���콺 �׸��� Combo�� ��� ���
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ���ű��� Select ���� -> " + ex.getMessage());
		}
		try
		{
			lrArgData = new CITData();
			
			strSql  = " Select CODE_LIST_ID as CODE, \n";
			strSql += "        CODE_LIST_NAME as NAME \n";
			strSql += " From   V_T_CODE_LIST \n";
			strSql += " Where  CODE_GROUP_ID = 'DEPREC_CLS' \n";
			strSql += " And    USE_TAG = 'T' \n";
			strSql += " Order by SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			// �߿��� �κ�
			strDEPREC_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME"); // ���콺 �׸��� Combo�� ��� ���
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ���ű��� Select ���� -> " + ex.getMessage());
		}
	}
	catch (Exception ex)
	{
		throw new Exception("������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>���Ͼ�üã��</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var lrArgs;
			var flag = false;
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
		//-->
		</script>
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><OBJECT id="dsDEPREC_FINISH"  classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		  <PARAM NAME="SyncLoad" VALUE="-1">
		</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
	</head>
	<body onload="C_Initialize();">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="792" height="374" border="0">
			<TR >
				<TD align="center">
					<!-- ǥ�� �˾� �������� �ּ� DIV ũ��(��:250px �̻�, ����:400px ����) //-->
					<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left" background="../images/pop_tit_bg.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="23"><img src="../images/pop_tit_normal2.gif"></td>
											<td class="title_default">������ ���ã��</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr >
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr  bgcolor="ECECEC">
											<td align="center" bgcolor="ECECEC">
												<!-- �˻��� ���� //-->
	 											<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 												<tr>
	 													<td width="15"><img src="../images/bullet1.gif"></td>
	 													<td width="75" class=font_green_bold >�����ڻ��</td>
	 													<td width="150"> <input id="txtASSET_NAME" type="text" Left class="box_ma5_white" VALUE="" style="width:148px"></td>
	 													<td align="left">
	 														<input id="btnLoad" type="button" class="img_btn2_1" value="��ȸ" onclick="btnLoad_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	 														<input id="btnSelectAll" type="button" class="img_btn4_1" value="��ü����" onclick="btnSelectAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	 														<input id="btnCancelAll" type="button" class="img_btn4_1" value="�������" onclick="btnCancelAll_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
	 													</td>
														<td>&nbsp;</td>
	 												</tr>
	 											</table>
												<!-- �˻��� ���� //-->
											</td>
										</tr>
										<tr  height="100%">
											<td width="100%" height="100%" align="center" bgcolor="ECECEC">
												<!-- ���α׷��� ������ ���� //-->
												<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN style="HEIGHT: 100% ; WIDTH: 100%"  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbgrid.cab#version=1,1,0,125">
													  <PARAM NAME="Editable" VALUE="-1">
													  <PARAM NAME="ColSelect" VALUE="-1">
													  <PARAM NAME="ColSizing" VALUE="-1">
													  <param name="MultiRowSelect"   value=true>
													  <param name="UsingOneClick"   value="1">
													  <PARAM NAME="Format" VALUE="
															<C> Name=���� ID=CHKTAG	 EditStyle=CheckBox 	Width=50
															</C>
															<C> Name=������ ID=FIX_ASSET_SEQ Align=CENTER Width=120 Show='false'
															</C>
															<C> Name=�󰢿ϷῩ�� ID=DEPREC_FINISH Align=CENTER Width=80 edit=none	EditStyle='Combo' Data='<%=strDEPREC_FINISH%>'
															</C>
															<C> Name=�ڻ������ȣ ID=ASSET_MNG_NO Align=Center Width=80 edit=none
															</C>
															<C> Name=�����ڻ�� ID=ASSET_NAME Align=left Width=150 edit=none
															</C>
															<C> Name=������� ID=GET_DT Align=Center Width=80 edit=none Mask='XXXX-XX-XX'
															</C>
															<C> Name=�󰢱��� ID=DEPREC_CLS Align=Center Width=60 edit=none		EditStyle='Combo' Data='<%=strDEPREC_CLS%>'
															</C>
															<C> Name=�󰢳�� ID=SRVLIFE Align=Right Width=60 edit=none
															</C>
															<C> Name=���� ID=ASSET_CNT Align=Right Width=60 edit=none
															</C>
															<C> Name=���� ID=DEPREC_RAT Align=Right Width=80 edit=none
															</C>
															<C> Name=��ΰ��� ID=BASE_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=��󰢾� ID=OLD_DEPREC_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=������ ID=GET_COST_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=���״��� ID=INC_SUM_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=���״��� ID=SUB_SUM_AMT Align=Right Width=100 edit=none
															</C>
															<C> Name=��/���ڻ� ID=NEW_OLD_ASSET Align=left Width=120 edit=none  Show='false'
															</C>
															<C> Name=�������ݾ� ID=CHG_GET_AMT Align=left Width=120 edit=none  Show='false'
															</C>
															<C> Name=��ġ�μ� ID=DEPT_CODE Align=left Width=120 edit=none Show='false'
															</C>
															<C> Name=��ġ�μ� ID=DEPT_NAME Align=left Width=120 edit=none
															</C>
															<C> Name=�԰� ID=ASSET_SIZE Align=left Width=100 edit=none  Show='false'
															</C>
															<C> Name=�۾����� ID=WORK_SEQ Align=left Width=120 edit=none  Show='false'
															</C>
															<C> Name=�Ű�/������� ID=SALE_DT Align=left Width=120 edit=none  Show='false'
															</C> 	
															<C> Name=ó�г�� ID=DISPOSE_YEAR Align=Center Width=120 edit=none  Show='false'
															</C>
														">
												  	<PARAM NAME="DataID" VALUE="dsMAIN">
												</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL ������������//-->
												<!-- ���α׷��� ������ ���� //-->
											</td>
										</tr>
										<tr>
											<td height="5" bgcolor="ECECEC"></td>
										</tr>
										<tr>
											<td align="right" bgcolor="ECECEC">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<TR align="right">
														<TD>
															<input id="btnImgOk" type="button" class="img_btn4_1" value="Ȯ��" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnImgCancel" type="button" class="img_btn4_1" value="���" onclick="imgCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</TD>
													</TR>
												</TABLE>
											</td>
										</tr>
										<tr>
											<td height="8" bgcolor="ECECEC"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</DIV>
				</TD>
			</TR>
		</TABLE>
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
