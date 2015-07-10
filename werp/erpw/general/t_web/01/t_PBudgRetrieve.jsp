<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WCustCodeR.jsp(���ڵ�)
/* 2. ����(�ó�����) : 
/* 3. ��  ��  ��  �� : ���α׷� ���� 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_PBudgRetrieve";
//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN, I:dsCUST_ACCNO=dsCUST_ACCNO, I:dsPAY_STOP=dsPAY_STOP)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strTRADE_CLS = "";
	String strCUST_ACCNO_CLS = "";
	String strGROUP_COMP_CLS = "";
	String strPAY_STOP_CLS = "";
	
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
			strSql += "Where	a.CODE_GROUP_ID = 'TRADE_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Union \n";
			strSql += "Select \n";
			strSql += "		'%', \n";
			strSql += "		'��ü', \n";
			strSql += "		-1  \n";
			strSql += "from dual \n";
			strSql += "Order By \n";
			strSql += "	3, 1 \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTRADE_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� �ŷ�ó�����ڵ� Select ���� -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select 										\n";
			strSql += "		a.CODE_LIST_ID AS CODE, 				\n";
			strSql += "		a.CODE_LIST_NAME AS NAME 				\n";
			strSql += "From	V_T_CODE_LIST a 					   	\n";
			strSql += "Where	a.CODE_GROUP_ID = 'CUST_ACCNO_CLS' 	\n";
			strSql += "And	a.USE_TAG = 'T' 							\n";
			strSql += "Order by	a.SEQ 								\n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCUST_ACCNO_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ���±����ڵ� Select ���� -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'GROUP_COMP_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strGROUP_COMP_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ���±����ڵ� Select ���� -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'PAY_STOP_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strPAY_STOP_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ������������ Select ���� -> " + ex.getMessage());
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
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL ������������//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL ������������//-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
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
		<td width="70" class=font_green_bold>�ͼӻ����</td>
		<td width="112">
			<input id="txtCOMP_CODE_F" 	   	type="hidden"/>
			<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()" onfocus="txtCOMP_CODE_F.value = txtCOMP_CODE.value">
		</td>
		<td width="161">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="30">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>�۾����</td>
		<td width="52">
			<input id="txtBUDG_YM" type="text" notNull datatype="DATEYM" style="width:50px">
		</td>
		<td width="20"><input id="btnBUDG_YM" type="button" class="img_btnCalendar_S" title="�޷�" onclick="btnBUDG_YM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�ͼӺμ�</td>
		<td width="112">
			<input id="txtDEPT_CODE_F" 	   	type="hidden"/>
			<input id="txtDEPT_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtDEPT_CODE_onblur()" onfocus="txtDEPT_CODE_F.value = txtDEPT_CODE.value">
		</td>
		<td width="161"> <input name="txtDEPT_NAME" type="text" class="ro" readOnly style="width:160px" VALUE=""></td>
		<td width="40">
			<input id="btnDEPT" type="button" class="img_btnFind" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="30">&nbsp;</td>	
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >��������</td>
		<td width="112">
			<input name="txtACC_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtACC_CODE_onblur()" onfocus="txtACC_CODE_F.value = txtACC_CODE.value">
		</td>
		<td width="161"> <input name="txtACC_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input id="txtACC_CODE_F" type="hidden"/>
			<input name="btnACC_CODE" type="button" class="img_btnFind" onclick="btnACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
		</td>
		<td width="*">&nbsp;</td>
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
								<td width="150" class="font_green_bold">�������������</td>
								<td align="right" width="*">
									<input id="btnRETRIEVE" type="button" class="img_btn2_1" value="��ȸ" onclick="btnquery_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
									<input id="btnCLOSE" type="button" class="img_btn2_1" value="�ݱ�" onclick="window.close()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="*" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="175" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="SuppressOption" VALUE=1>
										<PARAM NAME="ViewSummary" 	VALUE=1>
										<PARAM NAME="Format" VALUE=" 
<C> Name=�����μ�	ID=CHK_DEPT_NAME Width=80 Edit=none Suppress=1
</C> 
<C> Name=��������	ID=CTL_BUDG_CODE_NAME Width=80 Edit=none Suppress=2
</C> 
<C> Name=���� 		ID=BUDG_CODE_NAME Width=80 Edit=none Suppress=3  SumText='��      �� : ' SumColor=BLUE
</C>
<C> Name=�����̿�	ID=PRE_JAN_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
</C>
<G> Name=�������	ID=CUR
	<C> Name=��û��	ID=REQ_AMT Width=90 Edit=none  SumText=@sum  SumBgColor=#FFCCCC
	</C>
	<C> Name=������	ID=ASSIGN_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
	</C>
	<C> Name=��Ȯ������	ID=NOT_SIL_AMT Width=90 Edit=none SumText=@sum  SumBgColor=#FFCCCC
	</C>
	<C> Name=����	ID=SIL_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
	</C>
</G>
<C> Name=�ܾ�	ID=JAN_AMT Width=90 Edit=none SumText=@sum SumBgColor=#CEEEFF
</C>
											">
									</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL ������������//-->
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="15" height="20"><img src="../images/bullet1.gif"></td>
								<td width="150" class="font_green_bold">��ǥ���೻��</td>
								<td align="right" width="*">&nbsp;</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="*" height="100%">
									<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL ������������//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="285" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsSUB01">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="SuppressOption" VALUE=1>
<%
String  strBgColor = "BgColor ={Decode(CONF_YN,'Ȯ��','#E0F4FF','white')}";
String  strColor=    "Color   ={Decode(CONF_YN,'Ȯ��','black',  ,'black')}";
%>
										<PARAM NAME="Format" VALUE=" 
<FC> Name=��ǥ��ȣ	ID=MAKE_SLIPNO	Align=Center Width=100 Sort=true BgColor=#ECF5EB Edit='none' suppress='1'
<%=strBgColor%> <%=strColor%>
</FC>
<FC> Name=����	ID=MAKE_SLIPLINE	Align=Right	 Width=30 Sort=true BgColor=#ECF5EB Edit='none'
<%=strBgColor%> <%=strColor%>
</FC>
<FC> Name=Ȯ��	ID=CONF_YN	Align=Center	 Width=30 Sort=true BgColor=#ECF5EB Edit='none'
<%=strBgColor%> <%=strColor%>
</FC>
<C> Name=�����ڵ� 		ID=ACC_CODE 			Align=Left Width=80 Sort=true BgColor=#FFFCE0 Edit='none' SumText=@count
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=�������� 		ID=ACC_NAME 			Align=Left	 Width=120 Sort=true BgColor=#FFFCE0 Edit='none'
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=���� 			ID=DB_AMT 				Align=Right	 SumBgColor=#FFCCCC BgColor=#FFECEC Width=95 Edit='none' SumText=@sum
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=�뺯 			ID=CR_AMT 				Align=Right	 SumBgColor=#CEEEFF BgColor=#E0F4FF Width=95 Edit='none' SumText=@sum
<%=strBgColor%> <%=strColor%>
</C>
<C> Name='��        ��' ID=SUMMARY1 			Align=Left	 Width=170 Sort=true Edit='none'
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=�����ڵ� 		ID=VAT_NAME 			Align=Left Width=100 Sort=true Edit='none'
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=�ŷ�ó�ڵ� 	ID=CUST_CODE 			Align=Left	 Width=110 Sort=true Edit='none'
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=�ŷ�ó�� 		ID=CUST_NAME 			Align=Left	 Width=140 Sort=true Edit='none'
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=�ͼӺμ� 		ID=DEPT_NAME 			Align=Left	 Width=100 Sort=true Edit='none'
<%=strBgColor%> <%=strColor%>
</C>
<C> Name=����� 		ID=BANK_NAME 			Align=Left	 Width=100 Sort=true Edit='none'
<%=strBgColor%> <%=strColor%>
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