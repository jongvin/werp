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
	String strFileName = "./t_WSlipMngRemainDetailR";
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
<input id="txtDT_F"			type="hidden">
<input id="txtDT_T"			type="hidden">
<input id="txtCOMP_CODE"	type="hidden">
<input id="txtDEPT_CODE"	type="hidden">
<input id="txtCUST_CODE"	type="hidden">
<input id="txtACC_CODE"		type="hidden">
<input id="txtBANK_CODE"	type="hidden">
<input id="txtMNG_ITEM_CHAR1"	type="hidden">
<input id="txtMNG_ITEM_CHAR2"	type="hidden">
<input id="txtMNG_ITEM_CHAR3"	type="hidden">
<input id="txtMNG_ITEM_CHAR4"	type="hidden">
<input id="txtMNG_ITEM_NUM1"	type="hidden">
<input id="txtMNG_ITEM_NUM2"	type="hidden">
<input id="txtMNG_ITEM_NUM3"	type="hidden">
<input id="txtMNG_ITEM_NUM4"	type="hidden">
<input id="txtMNG_ITEM_DT1"	type="hidden">
<input id="txtMNG_ITEM_DT2"	type="hidden">
<input id="txtMNG_ITEM_DT3"	type="hidden">
<input id="txtMNG_ITEM_DT4"	type="hidden">
				<!-- ���α׷��� ������ ���� //-->
				<tr valign="top"> 

					<td width="100%" height="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> �����׸��ܾ���ȸ ���γ���<input id="txtDUMMY" 		type="text" style="width:0px;height:0px;border:none"></td>
											<td align="right" width="*">
<!--
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="�� ü �� ��" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="��ü�������" />
-->
<input id="btnSearch" type="button" tabindex="-1" class="img_btn4_1" onClick="btnquery_onclick()" 	value="�� ȸ" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnClose" type="button" tabindex="-1" class="img_btn4_1" onClick="window.close()" 	value="�� ��" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />

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
										<PARAM NAME="SuppressOption" 	VALUE=1>
<%
String  strBgColor = "BgColor = {ROW_COLOR}";
String  strColor=    "Color   ={Decode(ACC_NAME,'  �� ü ��   ','red',    '  �� ǥ ��   ','green',  'black')}";
//BgColor={Decode(TG,'A','',(Decode(TG,'B','','#EBEBEB')))}
//Color={Decode(TG,'A','BLUE','D','RED','')}#E0FEFF
%>
										<PARAM NAME="Format" VALUE="
<C> Name=�׷� 		ID=ACC_GRP				Align=Left	 Width=95   	Edit='none' 	Show='false'
</C>
<C> Name=�׷�� 	ID=ACC_GRP_NAME			Align=Left	 Width=55   	Edit='none' 	Show='true' SubSumText=''
suppress=1
BgColor = {ROW_COLOR}
</C>
<C> Name=�����ڵ� 	ID=ACC_CODE_P			Align=Left	 Width=80   	Edit='none' 	Show='true'
suppress=2
BgColor = {ROW_COLOR}
</C>
<C> Name=������ 	ID=ACC_NAME_P			Align=Left	 Width=190   	Edit='none' 	Show='true' SubSumText='�����׷�Ұ�' SumText='��         �� : ' SumColor=BLUE
suppress=3
BgColor = {ROW_COLOR}
</C>
<C> Name=��ǥ���� 	ID=MAKE_DT_P			Align=Center Width=80   	Edit='none' 	Show='true' SubSumText='�����׷�Ұ�' SumText='��         �� : ' SumColor=BLUE
BgColor = {ROW_COLOR}
</C>
<C> Name='��   ��' 	ID=DB_AMT				Align=Right	 Width=105   	Edit='none' 	SumText=@sum	SumColor=Black	SumBgColor=#F2A6A6  SumTextAlign=right
BgColor = {Decode(ROW_COLOR,'#FFFFFF','#FFECEC', ROW_COLOR)}
</C>
<C> Name='��   ��' 	ID=CR_AMT				Align=Right	 Width=105   	Edit='none'  	SumText=@sum	SumColor=Black	SumBgColor=#A8C9FF  SumTextAlign=right
BgColor = {Decode(ROW_COLOR,'#FFFFFF','#E0F4FF', ROW_COLOR)}
</C>
<C> Name='��   ��' 	ID=REMAIN_AMT			Align=Right	 Width=110   	Edit='none' 	Show='false'  	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
BgColor = {Decode(ROW_COLOR,'#FFFFFF','#F2F9E8', ROW_COLOR)}
</C>
<C> Name='�����ܾ�' 	ID=Running_Total		Align=Right	 Width=110   	Edit='none' 	Show='false'  	SumText=@sum	SumColor=Black	SumBgColor=#C4E693  SumTextAlign=right
BgColor = {Decode(ROW_COLOR,'#FFFFFF','#F2F9E8', ROW_COLOR)}
<C> Name='�ͼӺμ�' 	ID=DEPT_NAME			Align=Left	 Width=120   	Edit='none' 	Show='true' SubSumText='�����׷�Ұ�' SumText='��         �� : ' SumColor=BLUE
BgColor = {ROW_COLOR}
<C> Name=��ǥ��ȣ	ID=MAKE_SLIPNOLINE	Align=Left	 Width=110 Sort=true BgColor=#ECF5EB Edit='none'
BgColor = {Decode(ROW_COLOR,'#FFFFFF','#F2F9E8', ROW_COLOR)}
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