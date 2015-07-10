<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_RNPaySumR.jsp(미불집계장부)
/* 2. 유형(시나리오) : shared window 출력
/* 3. 기  능  정  의 : 미불집계장부 
/* 4. 변  경  이  력 : 김흥수 작성(2006-06-19)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_RNPaySumR";
	String strPageName = "t_RNPaySumR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	CITData		lrArgData = null;
	
	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_NAME = "";
	String strDT_F = "";
	String strDT_T = "";
	
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
		lrArgData = new CITData();
		try
		{
			
			strSql = " select F_T_DateToString(Trunc(Sysdate,'MM')) DT_F,F_T_DateToString(SysDate) DT_T From Dual ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDT_F = lrReturnData.toString(0,"DT_F");
			strDT_T = lrReturnData.toString(0,"DT_T");
			
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
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
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=CITCommon.enSC(strDEPT_NAME)%>";

			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		</object>
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strPageName%>">
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
					</td>
				</tr>
				<tr>
					<td align="Center">
						<table width="200" height="100%" border="0" cellpadding="0" cellspacing="0">
							<tr valign="middle"> 
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="100%">
												<!-- 프로그래머 디자인 시작 //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class=font_green_bold>귀속사업장</td>
														<td width="112">
															<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()">
														</td>
														<td width="161">
															<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
														</td>
														<td width="30">
															<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="*">&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class=font_green_bold>현장</td>
														<td width="112">
															<input id="txtDEPT_CODE" type="text" style="width:110px" onblur="txtDEPT_CODE_onblur()">
														</td>
														<td width="161">
															<input id="txtDEPT_NAME" type="text" readOnly class="ro" style="width:160px">
														</td>
														<td width="30">
															<input id="btnDEPT_CODE" type="button" class="img_btnFind" value="검색" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="*">&nbsp;</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class="font_green_bold" >조회기간</td>
														<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDT_F%>"/></td>
														<td width="30">
															<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														<td width="15">~</td>
														<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDT_T%>"/></td>
														<td width="30">
															<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														<td width="*">&nbsp;</td>
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