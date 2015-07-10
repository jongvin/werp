<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_RBudgResultAmtR.jsp(���������ȸ)
/* 2. ����(�ó�����) : shared window ��ȸ �� �Է�
/* 3. ��  ��  ��  �� : ���������ȸ 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-1-11)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	
	CITData lrReturnData = null;
//������ �� �κ��� ���⸸ �մ���!!!!!
//���ϸ�	
	String strFileName = "./t_RTaxReport0001";
	String strFileName01 = "t_RTaxReport0001";
	String strReportName = "r_t_0600"; // ������ 2�ڸ��� �������������� ���� �����Ѵ�.

//���� �׼�
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strDate = CITDate.getNow("yyyy-MM-dd");

	CITData		lrArgData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";

	String cboTAX_YEAR = "";
	
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

		//�����Ű��� - �⵵
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TAX_YEAR' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			cboTAX_YEAR = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:�����ڵ��� ��ǥ�����ڵ� Select ���� -> " + ex.getMessage());
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
var	sSelectPageName = "<%=strFileName%>_q.jsp";
var	sReportName = "<%=strReportName%>";
var	sCompCode = "<%=strCOMP_CODE%>";
var	sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
var	sDeptCode = "<%=strDEPT_CODE%>";
var	sDeptName = "<%=CITCommon.enSC(strDEPT_NAME)%>";
var	vDate     = "<%=strDate%>";
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
		<div id="divMainFix" class="main_div" align=center>
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
				<tr valign="top">
					<td height="25">
						<table width="100%"  border="0" cellpadding="0" cellspacing="0">
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
											<td width="80">
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
											<td width="*"><input id="txtRequestName" type="text" style="width:220px"></td>
										</tr>
									</table>
									<!-- ���α׷��� ������ ���� //-->
								</td>
							</tr>
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
						</table>
					</tr>
				</tr>
				<tr>
					<td align="Center">
						<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
							<tr valign="middle"> 
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="200"></td>
											<td width="100%">
												<!-- ���α׷��� ������ ���� //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>���������</td>
		<td width="62">
			<input id="txtCOMP_CODE_F" 	   	type="hidden"/>
			<input id="txtCOMP_CODE" type="text" style="width:60px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="150">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
		</td>
		<td width="20">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="�˻�" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�Ű���</td>
		<td width="62">
			<select id="cboTAX_YEAR" name="cboTAX_YEAR" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default" onchange="dsMAIN.ResetStatus();G_Load(dsMAIN);">
			<%=cboTAX_YEAR%>
			</select>
		</td>
		<td width="150">
			<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL ������������//--><OBJECT id="cboTAX_WORK"  style="width:150" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT >
				<PARAM NAME="ComboStyle" VALUE="5">
				<PARAM NAME="ComboDataID" VALUE="dsMAIN">
				<PARAM NAME="EditExprFormat" VALUE="%;WORK_NAME">
				<PARAM name="ListExprFormat" value="%;WORK_NAME">
				<PARAM NAME="Index" VALUE="0">
				<PARAM NAME="Sort" VALUE="0">
				<PARAM NAME="SearchColumn" VALUE="WORK_NO">
			</OBJECT><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL ������������//-->
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >�۾�����</td>
		<td width="72"><input id="txtWRITE_DT" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnWRITE_DT" type="button" class="img_btnCalendar_S" onClick="btnWRITE_DT_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >���ı���</td>
		<td width="265">
			<select id="cboTAX_TYPE" name="cboTAX_TYPE" style="WIDTH: 464px" tabindex="-1" class="input_listbox_default" onchange="txtTAX_TYPE_DESC.value=(eval('txtTAX_TYPE_DESC_'+this.value).value);">
				<OPTION VALUE='01_0'>1. ���ݰ�꼭�հ�ǥ ǥ��</OPTION>
				<OPTION VALUE='01_1'>1-1. ����ó�����ݰ�꼭�հ�ǥ</OPTION>
				<OPTION VALUE='01_2'>1-2. ����ó�����ݰ�꼭�հ�ǥ</OPTION>
				<OPTION VALUE='02_0'>2. ��꼭�հ�ǥ ǥ��</OPTION>
				<OPTION VALUE='02_1'>2-1. ����ó����꼭�հ�ǥ</OPTION>
				<OPTION VALUE='02_2'>2-2. ����ó����꼭�հ�ǥ</OPTION>
				<OPTION VALUE='03'> 3. �ſ�ī�������ǥ��������</OPTION>
				<OPTION VALUE='09'> 4-1. ���Ժΰ���(������Լ��׾Ⱥ�)</OPTION>
				<OPTION VALUE='18'> 4-2. �Ⱥ���������</OPTION>
				<OPTION VALUE='10'> 5. �������� ���� ���Լ��� ����</OPTION>
				<OPTION VALUE='11'> 6. ���Լ��� �Ұ��� ����(���� �ں��� ����)</OPTION>
				<OPTION VALUE='12'> 7. �ǹ�������ڻ�������</OPTION>
				<OPTION VALUE='13'> 8. ��ȭȹ�����</OPTION>
				<OPTION VALUE='14'> 9-1. �Ϲݰ����� �ΰ���ġ�� �Ű� - ����庰</OPTION>
				<OPTION VALUE='19'> 9-2. �Ϲݰ����� �ΰ���ġ�� �Ű� - �Ѱ�����</OPTION>
				<OPTION VALUE='15'>10. �������Լ��� �����Ű�</OPTION>
<!--
				<OPTION VALUE='06'>06.����ΰ����Ѱ�ǥ</OPTION>
				<OPTION VALUE='07'>07.���Ժΰ����Ѱ�ǥ</OPTION>
				<OPTION VALUE='09'>09.�⺰���庰������Ȳ</OPTION>
				<OPTION VALUE='10'>10.���庰��������Ȳ</OPTION>
				<OPTION VALUE='11'>11.�Ұ�������</OPTION>
				<OPTION VALUE='12'>12.�⵵�⺰����ΰ���(�Ⱥк���)</OPTION>
				<OPTION VALUE='13'>13.���庰����ǥ�ؾȺк���</OPTION>
				<OPTION VALUE='14'>14.���庰�Ⱥг���</OPTION>
				<OPTION VALUE='15'>15.�μ��������ΰ�������</OPTION>
				<OPTION VALUE='16'>16.���Ը������</OPTION>
				<OPTION VALUE='17'>17.���Ը���ó�����ݰ�꼭����ǥ</OPTION>
-->
			</select>
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >���ļ���</td>
		<td width="465">
<textarea id="txtTAX_TYPE_DESC" readonly class="ro" rows=7 style='width:464px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����/����
- ��꼭���� : ���ݰ�꼭
</textarea>
                 <div id="divTAX_TYPE_DESC_ARRAY" style="position:absolute; left:50px; top:50px; width:0px; hight:0px; display:none;"><!---->
<textarea class="iinput" id="txtTAX_TYPE_DESC_01_0" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����/����
- ��꼭���� : ���ݰ�꼭
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_01_1" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ���ݰ�꼭
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_01_2" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ���ݰ�꼭
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_02_0" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����/����
- ��꼭���� : ��꼭
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_02_1" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ��꼭
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_02_2" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ��꼭
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_03"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : �ſ�ī��/���ݿ�����
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_09"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- �Ⱥ���������
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_18"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ��ü
- ��Ÿ
  111221900 : ���޺ΰ��� �����ڻ꼼�ݰ�꼭
  ���� ������ CJ���� ����������� ó��.(��, ����������� CJ���߷� ����� ��ǥ.)
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_10"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ��ü
- ��Ÿ
  111221200 : ���޺ΰ��� �����Ұ���
  111221400 : ���޺ΰ��� �鼼�Ұ���
  111221100 : ���޺ΰ��� �������Ұ���
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_11"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ��ü
- ��Ÿ
  111221400 : ���޺ΰ��� �鼼�Ұ���
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_12"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ���ݰ�꼭
- ��Ÿ
  111221900 : ���޺ΰ��� �����ڻ꼼�ݰ�꼭
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_13"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ��ü
- ��Ÿ
  210130800 : �����ΰ��� ��������Ÿ 
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_14"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>1. ����ǥ�ع� ���⼼��
   - ���� ���ݰ�꼭���κ� : �������� ������ ���ݰ�꼭 ����.
          �� Ÿ            : �������� ������ ���ݰ�꼭 �̹��� ����.(�����ΰ��� ������Ÿ ��� )
   - ������ ���ݰ�꼭���κ� : ������ ���ݰ�꼭 ����.
            �� Ÿ            : ������ ���ݰ�꼭 �̹��� ����.(�����ΰ��� ��������Ÿ ��� )
2. ���Լ���
   - ���ݰ�꼭����� �Ϲݸ��� : �����ڻ��� ������ ���Լ��ݰ�꼭.
   - ���ݰ�꼭����� �����ڻ� : �����ڻ� ���� ���ݰ�꼭.(111221900 ���޺ΰ��� �����ڻ꼼�ݰ�꼭)
   - ��Ÿ�������Լ���          : �ſ�ī�������ǥ������������, �������Լ���(111222100 ���޺ΰ��� �������Լ���)
   - �������� ���� ���Լ���    : �Ұ��� ����, ���� ���Լ��� �鼼�����.
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_19"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>20 : ���κ긴���� ������ �����հ�

1. ����ǥ�ع� ���⼼��
   - ���� ���ݰ�꼭���κ� : �������� ������ ���ݰ�꼭 ����.
          �� Ÿ            : �������� ������ ���ݰ�꼭 �̹��� ����.(�����ΰ��� ������Ÿ ��� )
   - ������ ���ݰ�꼭���κ� : ������ ���ݰ�꼭 ����.
            �� Ÿ            : ������ ���ݰ�꼭 �̹��� ����.(�����ΰ��� ��������Ÿ ��� )
2. ���Լ���
   - ���ݰ�꼭����� �Ϲݸ��� : �����ڻ��� ������ ���Լ��ݰ�꼭.
   - ���ݰ�꼭����� �����ڻ� : �����ڻ� ���� ���ݰ�꼭.(111221900 ���޺ΰ��� �����ڻ꼼�ݰ�꼭)
   - ��Ÿ�������Լ���          : �ſ�ī�������ǥ������������, �������Լ���(111222100 ���޺ΰ��� �������Լ���)
   - �������� ���� ���Լ���    : �Ұ��� ����, ���� ���Լ��� �鼼�����.
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_15"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- ���ⱸ�� : ����
- ��꼭���� : ���� ��꼭 �������Լ��׸� ���õ�
  ��꼭 - ��꼭 �������� �����
  �ſ�ī��, ���ݿ����� - �ſ�ī��� �������� �����
  ��Ÿ - ��,��ε� �������� �����
- ��Ÿ
  111222100 : ���޺ΰ��� �������Լ���
</textarea>
                 </div>
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>

												<!-- ���α׷��� ������ ���� //-->
											</td>
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
						</table>
					</td>
				</tr>
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