<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WWorkCodeR.jsp(자동전표코드등록)
/* 2. 유형(시나리오) : 화면 디자인
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WTaxAccountR";
	String strFileName01 = "t_WTaxAccountR";
	String strReportName = "r_t_060017";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsSUB01=dsSUB01)";

	String strDate = CITDate.getNow("yyyy-MM-dd");
	/* 세션정보 */
	String strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));

	String strOut = "";
	String strSql = "";
	String strAct = "";

	String strCOMP_CODE = "";
	String strCOMPANY_NAME = "";
	
	String strTAX_YEAR = "";
	String cboTAX_YEAR = "";
	String strTAX_GI = "";
	String strTAX_CONF = "";
	String strUDT_TAG = "";
	String strRCPTBILL_CLS = "";
	String cboRCPTBILL_CLS = "";
	String strSALEBUY_CLS = "";
	String cboSALEBUY_CLS = "";
	String strVAT_CODE = "";
	String strSUBTR_CLS = "";
	String cboSUBTR_CLS = "";

	try
	{
		CITCommon.initPage(request, response, session);
		
		CITData lrArgData = new CITData();		

		//세무신고기수 - 년도
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

			strTAX_YEAR = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			cboTAX_YEAR = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//세무신고기수 - 기수
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TAX_GI' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTAX_GI = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//세무신고기수 - 예정/확정
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TAX_CONF' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTAX_CONF = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//수정여부
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'UDT_TAG' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strUDT_TAG = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//계산서구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where a.CODE_GROUP_ID = 'RCPTBILL_CLS' \n";
			//strSql += "And	a.CODE_LIST_ID IN ('01','02') \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strRCPTBILL_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			cboRCPTBILL_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//매입/매출
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SALEBUY_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strSALEBUY_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			cboSALEBUY_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//부가세코드
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.VAT_CODE AS CODE, \n";
			strSql += "		a.VAT_NAME AS NAME \n";
			strSql += "From	T_ACC_VAT_CODE a \n";
			strSql += "Where a.VAT_CODE IS NOT NULL \n";
			strSql += "--And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.VAT_CODE ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strVAT_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SUBTR_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strSUBTR_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			cboSUBTR_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 계좌구분코드 Select 오류 -> " + ex.getMessage());
		}

		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", CITCommon.NvlString(session.getAttribute("dept_code")));
				
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
				throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
			}

		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//사업장 설정 종료
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>회계관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
var sSelectPageName = "<%=strFileName%>_q.jsp";
var	sReportName = "<%=strReportName%>";
var	sCompCode = "<%=strCOMP_CODE%>";
var	sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
var	vDate = "<%=strDate%>";
var	vPAGE_ID = "[<%=strUserNo%>]"+"t_WTaxAccountR";
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4_1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4_1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<param name="KeyValue" value="<%=strUpdateKeyValue%>">
	<param name="Action"    value="<%=strFileName%>_tr.jsp">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
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
						<!-- 조건 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>사업장</td>
		<td width="112">
			<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="161">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="40">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="찾색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="75" class="font_green_bold" >연도</td>
		<td width="60">
			<select id="cboTAX_YEAR" name="cboTAX_YEAR" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default" onchange="dsMAIN.ResetStatus();G_Load(dsMAIN);">
			<!--
			<option value='%'>전  체</option>
			-->
			<%=cboTAX_YEAR%>
			</select>
		</td>
		<td width="10">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >신고기수</td>
		<td width="60">
			<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboTAX_WORK"  style="width:150" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT >
				<PARAM NAME="ComboStyle" VALUE="5">
				<PARAM NAME="ComboDataID" VALUE="dsMAIN">
				<PARAM NAME="EditExprFormat" VALUE="%;WORK_NAME">
				<PARAM name="ListExprFormat" value="%;WORK_NAME">
				<PARAM NAME="Index" VALUE="0">
				<PARAM NAME="Sort" VALUE="0">
				<PARAM NAME="SearchColumn" VALUE="WORK_NO">
			</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >귀속부서</td>

		<td width="112"><input id="txtDEPT_CODE" 	type="text" style="width:110px" onblur="txtDEPT_CODE_onblur()"></td>
		<td width="161">
			<input id="txtDEPT_NAME" type="text" readOnly left class="ro" style="width:159px">
		</td>
		<td width="40">
			<input id="btnDEPT_CODE" type="button" class="img_btnFind" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="75" class="font_green_bold" >매입/매출</td>
		<td width="60">
			<select id="cboSALEBUY_CLS" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default" onchange="gridSUB01.focus();btnquery_onclick();">
			<option value='%'>전  체</option>
			<%=cboSALEBUY_CLS%>
			</select>
		</td>
		<td width="10">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >계산서구분</td>
		<td width="130">
			<select id="cboRCPTBILL_CLS" style="WIDTH: 130px" tabindex="-1" class="input_listbox_default">\
			<option value='%'>전  체</option>
			<%=cboRCPTBILL_CLS%>
			</select>
		</td>
		<td width="10">&nbsp;</td>	
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >공제구분</td>
		<td width="60">
			<select id="cboSUBTR_CLS" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default">
			<option value='%'>전  체</option>
			<%=cboSUBTR_CLS%>
			</select>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >거래처</td>
		<td width="112"> <input name="txtCUST_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtCUST_CODE_onblur()"></td>
		<td width="161"> <input name="txtCUST_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnCUST_CODE" type="button" class="img_btnFind" onclick="btnCUST_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="75" class="font_green_bold" >
			<select id="cboDATE_CLS" style="WIDTH: 75px" tabindex="-1" class="input_listbox_default">
				<option value='P'>증빙일자</option>
				<option value='M' selected>전표일자</option>
			</select>
		</td>
		<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70"  class="font_green_bold" >부가세코드</td>
		<td width="112">  <input name="txtVAT_CODE" 	type="text" datatype="han" style="width:110px" 	VALUE="" onblur="txtVAT_CODE_onblur()"></td>
		<td width="162"> <input name="txtVAT_NAME"	type="text" class="ro" readOnly style="width:160px"	VALUE=""></td>
		<td width="40">
			<input id="btnVAT_CODE" type="button" class="img_btnFind" onclick="btnVAT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="75" class="font_green_bold" >부가세계정</td>
		<td width="112"> <input name="txtACC_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtACC_CODE_onblur()"></td>
		<td width="161"> <input name="txtACC_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnACC_CODE" type="button" class="img_btnFind" onclick="btnACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
												<!-- 프로그래머 디자인 종료 //-->
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
						</table>
						<!-- 조건 테이블 종료 //-->
						<!-- 간격조정 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 종료 //-->
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 부가세자료</td>
											<td align="right" width="*">
												&nbsp;
<input name="btnDeleteToUpdate" type="button" class="img_btn6_1" onclick="btndelete_to_update_onclick();" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="삭제==>수정" />
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB01">
													<PARAM NAME="Editable" VALUE="1">
													<PARAM NAME="ColSelect" VALUE="1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<param name=UsingOneClick  value="1">
													<PARAM name="MultiRowSelect" value=true>
													<PARAM NAME="ViewSummary" 	VALUE=1>
													<PARAM NAME="Format" VALUE=" 
<FC> Name=수정	ID=UDT_TAG	Align=Center	Width=50   	Show='true'		Edit='None' EditStyle='Combo' Data='<%=strUDT_TAG%>'
</FC>
<C> Name=세무사업장			ID=TAX_COMP_NAME	Align=Left		Width=100
</C>
<C> Name=계정명 			ID=ACC_NAME			Align=left		Width=120   Show='true'		EditStyle='Combo'		Edit=''
</C>
<C> Name=계산서구분 		ID=RCPTBILL_CLS		Align=Center	Width=80	Show='true'		Edit='None'		EditStyle='Combo' Data='<%=strRCPTBILL_CLS%>'
</C>
<C> Name='매입/매출' 		ID=SALEBUY_CLS		Align=Center	Width=80   	Show='true'		Edit='None'		EditStyle='Combo' Data='<%=strSALEBUY_CLS%>'
</C>
<C> Name='공제구분'			ID='SUBTR_CLS'		Align=Center	EditStyle=Combo	Data='<%=strSUBTR_CLS%>' Width=60
</C>
<C> Name='공통매입'			ID=COMMBUY_CLS		Align=Center	Width=50   	Show='true' 	EditStyle=CheckBox	Edit='none'
</C>
<C> Name=전표일자 			ID=MAKE_DT			Align=Center	Width=80   	Show='true'		Edit='None'		
</C>
<C> Name=발행일 			ID=PUBL_DT			Align=Center	Width=80   	Show='true'		
</C>
<C> Name=부가세코드 		ID=VAT_CODE 		Align=left 	Width=80   	Show='true'		EditStyle='Combo' Data='\' \':\' \',<%=strVAT_CODE%>' SumText='   합  계  : '
</C>
<C> Name=공급가액 			ID=SUPAMT			Align=Right		Width=80   	Show='true'	SumText=@sum	SumBgColor=#FFCCCC
</C>
<C> Name=부가세액 			ID=VATAMT			Align=Right		Width=80   	Show='true'	SumText=@sum	SumBgColor=#CEEEFF
</C>
<C> Name=부서명 			ID=DEPT_NAME		Align=left		Width=120   Show='true'	
</C>
<C> Name=거래처명 			ID=CUST_NAME		Align=left		Width=120   Show='true'	
</C>
<C> Name='카드/현금금영수증번호' ID=CARD_CASH_NO		Align=Left		Width=150   Show='true'
</C>
<C> Name=전기누락분			ID=MISSING_TAG		Align=Center	Width=80   	Show='true' 	EditStyle=CheckBox	Edit='none'
</C>
<C> Name=비고 				ID=REMARK			Align=Left		Width=200   Show='true'
</C>
<C> Name=전표번호 			ID=MAKE_SLIPNOLINE	Align=left		Width=120   Show='true'		Edit='none'
</C>
<C> Name=사업장 			ID=COMP_CODE		Align=Center	Width=100 	Show='false'	Edit='none' 	Show='false'
</C>
<C> Name=작업번호 			ID=WORK_NO			Align=Center	Width=60   	Show='false'	Edit='none'
</C>
<C> Name=순번 				ID=SEQ				Align=Center	Width=60   	Show='false'	Edit='none'
</C>
<C> Name=전표ID 			ID=SLIP_ID			Align=Right		Width=85   	Show='false'	Edit='none'
</C>
<C> Name=전표IDSEQ 			ID=SLIP_IDSEQ		Align=Right		Width=80   	Show='false'	Edit='none'
</C>
<C> Name=권번 				ID=BOOK_NO			Align=Right		Width=80   	Show='false'	Edit='none'
</C>
<C> Name=순번 				ID=BOOK_SEQ			Align=Right		Width=80   	Show='false'	Edit='none'
</C>
<C> Name=폐기일자 			ID=ANNULMENT_DT		Align=Center	Width=80   	Show='false'	Edit='none'
</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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

				<!-- 프로그래머 디자인 종료 //-->
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!-- 가우스 Bind 객체정의 종료 //-->
	</body>
</html>
<%
	try
	{
		CITCommon.finalPage();
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 종료 오류 -> " + ex.getMessage());
	}
%>