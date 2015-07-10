<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_RBudgResultAmtR.jsp(예산실적조회)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 예산실적조회 
/* 4. 변  경  이  력 : 한재원 작성(2006-1-11)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_RTaxReport0001";
	String strFileName01 = "t_RTaxReport0001";
	String strReportName = "r_t_0600"; // 마지막 2자리는 세무서식종류에 따라 지정한다.

//저장 액션
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
		
		//사업장 설정
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
				throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
			}
		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//사업장 설정 종료

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

			cboTAX_YEAR = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}
		
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
var	sSelectPageName = "<%=strFileName%>_q.jsp";
var	sReportName = "<%=strReportName%>";
var	sCompCode = "<%=strCOMP_CODE%>";
var	sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
var	sDeptCode = "<%=strDEPT_CODE%>";
var	sDeptName = "<%=CITCommon.enSC(strDEPT_NAME)%>";
var	vDate     = "<%=strDate%>";
//-->
</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
									<!-- 프로그래머 디자인 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >출력구분</td>
											<td width="80">
												<SELECT id="cboExportTag" style="WIDTH: 60px">
													<OPTION VALUE='P' selected>PDF
													<OPTION VALUE='E'>EXCEL
													<OPTION VALUE='W'>WORD
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >실행구분</td>
											<td width="100">
												<SELECT id="cboRunTag" style="WIDTH: 80px">
													<OPTION VALUE='1' selected>바로실행
													<OPTION VALUE='2'>요청
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class="font_green_bold" >요청명</td>
											<td width="*"><input id="txtRequestName" type="text" style="width:220px"></td>
										</tr>
									</table>
									<!-- 프로그래머 디자인 종료 //-->
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
												<!-- 프로그래머 디자인 시작 //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>세무사업장</td>
		<td width="62">
			<input id="txtCOMP_CODE_F" 	   	type="hidden"/>
			<input id="txtCOMP_CODE" type="text" style="width:60px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="150">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
		</td>
		<td width="20">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >신고기수</td>
		<td width="62">
			<select id="cboTAX_YEAR" name="cboTAX_YEAR" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default" onchange="dsMAIN.ResetStatus();G_Load(dsMAIN);">
			<%=cboTAX_YEAR%>
			</select>
		</td>
		<td width="150">
			<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboTAX_WORK"  style="width:150" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT >
				<PARAM NAME="ComboStyle" VALUE="5">
				<PARAM NAME="ComboDataID" VALUE="dsMAIN">
				<PARAM NAME="EditExprFormat" VALUE="%;WORK_NAME">
				<PARAM name="ListExprFormat" value="%;WORK_NAME">
				<PARAM NAME="Index" VALUE="0">
				<PARAM NAME="Sort" VALUE="0">
				<PARAM NAME="SearchColumn" VALUE="WORK_NO">
			</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >작업일자</td>
		<td width="72"><input id="txtWRITE_DT" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnWRITE_DT" type="button" class="img_btnCalendar_S" onClick="btnWRITE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >서식구분</td>
		<td width="265">
			<select id="cboTAX_TYPE" name="cboTAX_TYPE" style="WIDTH: 464px" tabindex="-1" class="input_listbox_default" onchange="txtTAX_TYPE_DESC.value=(eval('txtTAX_TYPE_DESC_'+this.value).value);">
				<OPTION VALUE='01_0'>1. 세금계산서합계표 표지</OPTION>
				<OPTION VALUE='01_1'>1-1. 매출처별세금계산서합계표</OPTION>
				<OPTION VALUE='01_2'>1-2. 매입처별세금계산서합계표</OPTION>
				<OPTION VALUE='02_0'>2. 계산서합계표 표지</OPTION>
				<OPTION VALUE='02_1'>2-1. 매출처별계산서합계표</OPTION>
				<OPTION VALUE='02_2'>2-2. 매입처별계산서합계표</OPTION>
				<OPTION VALUE='03'> 3. 신용카드매출전표등수취명세서</OPTION>
				<OPTION VALUE='09'> 4-1. 매입부가세(공통매입세액안분)</OPTION>
				<OPTION VALUE='18'> 4-2. 안분율산출산식</OPTION>
				<OPTION VALUE='10'> 5. 공제받지 못할 매입세액 명세서</OPTION>
				<OPTION VALUE='11'> 6. 매입세액 불공제 내역(토지 자본적 지출)</OPTION>
				<OPTION VALUE='12'> 7. 건물등감가상각자산취득명세서</OPTION>
				<OPTION VALUE='13'> 8. 외화획득명세서</OPTION>
				<OPTION VALUE='14'> 9-1. 일반과세자 부가가치세 신고서 - 사업장별</OPTION>
				<OPTION VALUE='19'> 9-2. 일반과세자 부가가치세 신고서 - 총괄납부</OPTION>
				<OPTION VALUE='15'>10. 의제매입세액 공제신고서</OPTION>
<!--
				<OPTION VALUE='06'>06.매출부가세총괄표</OPTION>
				<OPTION VALUE='07'>07.매입부가세총괄표</OPTION>
				<OPTION VALUE='09'>09.기별현장별매입현황</OPTION>
				<OPTION VALUE='10'>10.현장별월매입현황</OPTION>
				<OPTION VALUE='11'>11.불공제내역</OPTION>
				<OPTION VALUE='12'>12.년도기별매출부가세(안분비율)</OPTION>
				<OPTION VALUE='13'>13.현장별과세표준안분비율</OPTION>
				<OPTION VALUE='14'>14.현장별안분내역</OPTION>
				<OPTION VALUE='15'>15.부서계정별부가세명세서</OPTION>
				<OPTION VALUE='16'>16.매입매출명세서</OPTION>
				<OPTION VALUE='17'>17.매입매출처별세금계산서집계표</OPTION>
-->
			</select>
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >서식설명</td>
		<td width="465">
<textarea id="txtTAX_TYPE_DESC" readonly class="ro" rows=7 style='width:464px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입/매출
- 계산서종류 : 세금계산서
</textarea>
                 <div id="divTAX_TYPE_DESC_ARRAY" style="position:absolute; left:50px; top:50px; width:0px; hight:0px; display:none;"><!---->
<textarea class="iinput" id="txtTAX_TYPE_DESC_01_0" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입/매출
- 계산서종류 : 세금계산서
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_01_1" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매출
- 계산서종류 : 세금계산서
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_01_2" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 세금계산서
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_02_0" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입/매출
- 계산서종류 : 계산서
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_02_1" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매출
- 계산서종류 : 계산서
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_02_2" rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 계산서
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_03"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 신용카드/현금영수증
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_09"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 안분율산출산식
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_18"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 전체
- 기타
  111221900 : 선급부가세 고정자산세금계산서
  지사 매입은 CJ개발 본사매입으로 처리.(단, 세무사업장이 CJ개발로 발행된 전표.)
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_10"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 전체
- 기타
  111221200 : 선급부가세 차량불공제
  111221400 : 선급부가세 면세불공제
  111221100 : 선급부가세 교제성불공제
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_11"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 전체
- 기타
  111221400 : 선급부가세 면세불공제
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_12"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 세금계산서
- 기타
  111221900 : 선급부가세 고정자산세금계산서
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_13"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매출
- 계산서종류 : 전체
- 기타
  210130800 : 예수부가세 영세율기타 
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_14"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>1. 과세표준및 매출세액
   - 과세 세금계산서교부분 : 영세율을 제외한 세금계산서 전부.
          기 타            : 영세율을 제외한 세금계산서 미발행 전부.(예수부가세 과세기타 등등 )
   - 영세율 세금계산서교부분 : 영세율 세금계산서 전부.
            기 타            : 영세율 세금계산서 미발행 전부.(예수부가세 영세율기타 등등 )
2. 매입세액
   - 세금계산서수취분 일반매입 : 고정자산을 제외한 매입세금계산서.
   - 세금계산서수취분 고정자산 : 고정자산 매입 세금계산서.(111221900 선급부가세 고정자산세금계산서)
   - 기타공제매입세액          : 신용카드매출전표수취명세서제출분, 의제매입세액(111222100 선급부가세 의제매입세액)
   - 공제받지 못할 매입세액    : 불공제 매입, 공통 매입세액 면세사업분.
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_19"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>20 : 나인브릿지를 제외한 전사합계

1. 과세표준및 매출세액
   - 과세 세금계산서교부분 : 영세율을 제외한 세금계산서 전부.
          기 타            : 영세율을 제외한 세금계산서 미발행 전부.(예수부가세 과세기타 등등 )
   - 영세율 세금계산서교부분 : 영세율 세금계산서 전부.
            기 타            : 영세율 세금계산서 미발행 전부.(예수부가세 영세율기타 등등 )
2. 매입세액
   - 세금계산서수취분 일반매입 : 고정자산을 제외한 매입세금계산서.
   - 세금계산서수취분 고정자산 : 고정자산 매입 세금계산서.(111221900 선급부가세 고정자산세금계산서)
   - 기타공제매입세액          : 신용카드매출전표수취명세서제출분, 의제매입세액(111222100 선급부가세 의제매입세액)
   - 공제받지 못할 매입세액    : 불공제 매입, 공통 매입세액 면세사업분.
</textarea>
<textarea class="iinput" id="txtTAX_TYPE_DESC_15"   rows=4 style='width:264px; border:solid 1;border-color:#999999;scrollbar-face-color: #FFFFFF;
scrollbar-highlight-color: #91a3be;
scrollbar-3dlight-color: #FFFFFF;
scrollbar-shadow-color: #91a3be;
scrollbar-darkshadow-color: #FFFFFF;
scrollbar-track-color: #FFFFFF;
scrollbar-arrow-color: #91a3be;'
>- 매출구분 : 매입
- 계산서종류 : 현재 계산서 의제매입세액만 세팅됨
  계산서 - 계산서 의제매입 발행분
  신용카드, 현금영수증 - 신용카드등 의제매입 발행분
  기타 - 농,어민등 의제매입 발행분
- 기타
  111222100 : 선급부가세 의제매입세액
</textarea>
                 </div>
		</td>
		<td width=*>&nbsp;</td>
	</tr>
</table>

												<!-- 프로그래머 디자인 종료 //-->
											</td>
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
						</table>
					</td>
				</tr>
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