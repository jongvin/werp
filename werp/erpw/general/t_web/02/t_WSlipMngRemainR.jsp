<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WDeptR(�μ��ڵ�)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-30)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_WSlipMngRemainR";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strACC_GRP_CODE = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		try
		{
			CITData lrArgData = new CITData();
			strSql += "SELECT \n";
			strSql += "	''||ACC_GRP_CODE CODE, \n";
			strSql += "	ACC_GRP_NAME NAME \n";
			strSql += "FROM \n";
			strSql += "	T_ACC_GRP \n";
			strSql += "WHERE \n";
			strSql += "	USE_TAG = 'T' \n";
			strSql += "ORDER BY \n";
			strSql += "	ACC_GRP_CODE \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_GRP_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �����׷��ڵ�1 Select ���� -> " + ex.getMessage());
		}
		
		//����� ����
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
			CITData		lrArgData = new CITData();
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
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";

		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
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
											<td class=td_green>
												<!-- ���α׷��� ������ ���� //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>�ͼӻ����</td>
		<td width="112">
			<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="161">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="30">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >��ǥ����</td>
		<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�ͼӺμ�</td>
		<td width="112"> <input name="txtDEPT_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtDEPT_CODE_onblur()"></td>
		<td width="161"> <input name="txtDEPT_NAME" type="text" class="ro" readOnly style="width:160px" VALUE=""></td>
		<td width="40">
			<input name="btnDEPT" type="button" class="img_btnFind" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="30">&nbsp;</td>	
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�ŷ�ó</td>
		<td width="112">
			<input name="txtCUST_SEQ" type="hidden">
			<input name="txtCUST_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtCUST_CODE_onblur()">
		</td>
		<td width="161"> <input name="txtCUST_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnCUST_CODE" type="button" class="img_btnFind" onclick="btnCUST_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >��������</td>
		<td width="112">
			<input name="txtACC_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtACC_CODE_onblur()">
			<input id="txtACC_LVL" type="hidden">
			<input id="txtFUND_INPUT_CLS" type="hidden">
		</td>
		<td width="161"> <input name="txtACC_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnACC_CODE" type="button" class="img_btnFind" onclick="btnACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�������</td>
		<td width="112"> <input id="txtBANK_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtBANK_CODE_onblur()"></td>
		<td width="161"> <input id="txtBANK_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input id="btnBANK_CODE" type="button" class="img_btnFind" onclick="btnBANK_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="*">&nbsp;</td>
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
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
											<!-- ���α׷��� ������ ���� //-->
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr width="*">
         										<td width="*" height="5"></td>
         									</tr>
											</table>
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
												   <td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkDEPT_CODE" type="CheckBox" class="check"></td>
													<td width="85" style="color:#003366">�ͼӺμ���</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkCUST_CODE" type="CheckBox" disabled class="check"></td>
													<td width="85" style="color:#003366"><input id="txtCUST_CODE_MNG" 	   type="hidden">�ŷ�ó��</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkBANK_CODE" type="CheckBox" disabled class="check"></td>
													<td width="85" style="color:#003366"><input id="txtLOAN_MNG" 	   type="hidden">���������</td>
													
													<td width="15">&nbsp;</td>
													<td width="18">&nbsp;</td>
													<td width="85">&nbsp;</td>
													
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_CHAR1" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_CHAR1" 	   type="hidden">
													   <input id="txtMNG_NAME_CHAR1" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����1" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_CHAR2" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_CHAR2" 	   type="hidden">
													   <input id="txtMNG_NAME_CHAR2" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����2" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_CHAR3" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_CHAR3" 	   type="hidden">
													   <input id="txtMNG_NAME_CHAR3" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����3" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_CHAR4" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_CHAR4" 	   type="hidden">
													   <input id="txtMNG_NAME_CHAR4" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����4" >
													</td>
													<td width="*">&nbsp;</td>
												</tr>
											</table>
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_NUM1" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_NUM1" 	   type="hidden">
													   <input id="txtMNG_NAME_NUM1" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����1" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_NUM2" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_NUM2" 	   type="hidden">
													   <input id="txtMNG_NAME_NUM2" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����2" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_NUM3" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_NUM3" 	   type="hidden">
													   <input id="txtMNG_NAME_NUM3" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����3" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_NUM4" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_NUM4" 	   type="hidden">
													   <input id="txtMNG_NAME_NUM4" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-����4" >
													</td>
													
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_DT1" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_DT1" 	   type="hidden">
													   <input id="txtMNG_NAME_DT1" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-��¥1" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_DT2" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_DT2" 	   type="hidden">
													   <input id="txtMNG_NAME_DT2" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-��¥2" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_DT3" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_DT3" 	   type="hidden">
													   <input id="txtMNG_NAME_DT3" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-��¥3" >
													</td>
													<td width="15"><img src="../images/bullet3.gif"></td>
													<td width="10"><input id="chkMNG_TG_DT4" type="CheckBox" disabled class="check"></td>
													<td width="85">
													   <input id="txtMNG_ITEM_DT4" 	   type="hidden">
													   <input id="txtMNG_NAME_DT4" 		type="text" readOnly style="width:85px;border:none" value="�����׸�-��¥4" >
													</td>

													<td width="*">&nbsp;</td>
												</tr>
											</table>
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr width="*">
         										<td width="*" height="5"></td>
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
											<td class="font_green_bold"> ��ǥ����</td>
											<td align="right" width="*">
<!--
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�� ü �� ��" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="��ü�������" />
-->
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
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="ViewSummary" 	VALUE=0>
<%
String  strBgColor = "BgColor ={Decode(ACC_NAME,'  �� ü ��   ','#E0F4FF','  �� ǥ ��   ','#FFFCE0','white')}";
String  strColor=    "Color   ={Decode(ACC_NAME,'  �� ü ��   ','red',    '  �� ǥ ��   ','green',  'black')}";
%>
										<PARAM NAME="Format" VALUE="
<C> Name=���� 		ID=DB_AMT 		Align=Right	 SumBgColor=#FFCCCC BgColor=#FFECEC Width=150 Edit='none' SumText=@sum
</C>
<C> Name=�뺯 		ID=CR_AMT 		Align=Right	 SumBgColor=#CEEEFF BgColor=#E0F4FF Width=150 Edit='none' SumText=@sum
</C>
										">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
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