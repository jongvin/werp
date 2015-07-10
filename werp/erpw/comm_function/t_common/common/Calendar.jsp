<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : Calendar(달력-년월일,년월)
/* 2. 유형(시나리오) : 달력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";
	
	Calendar calendar = null;
	
	String strCalendarID = "";
	String strType = "";
	String strDate = "";
	String strToDay = "";
	String strYear = "";
	String strMonth = "";
	String strDay = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strCalendarID = CITCommon.toKOR(request.getParameter("CID"));
		strType = CITCommon.toKOR(request.getParameter("TYPE"));
		strDate = CITCommon.toKOR(request.getParameter("DATE"));
		
		if (!CITCommon.isNull(strDate))
		{
			try
			{
				calendar = CITDate.getDateCalendar(strDate);
			}
			catch (Exception ex)
			{
				calendar = Calendar.getInstance();
			}
		}
		else
		{
			calendar = Calendar.getInstance();
		}
		
		strDate = CITDate.toString(calendar.getTime());
		strToDay = CITDate.getNow();
		
		strYear = strDate.substring(0, 4);
		strMonth = strDate.substring(5, 7);
		strDay = strDate.substring(8, 10);
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>회계관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<style type="text/css">
		<!--
			a:link		{ text-decoration: none ; color: #000000; }
			a:visited	{ text-decoration: none ; color: #000000; }
			a:active	{ text-decoration: underline ; color: #000000; }
			a:hover		{ text-decoration: underline ; color: #000000; }
		//-->
		</style>
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			var strCalendarID = "<%=strCalendarID%>";
			var strType = "<%=strType%>";
			var strToDay = "<%=strToDay%>";
			var strYear = "<%=strYear%>";
			var strMonth = "<%=strMonth%>";
			var strDay = "<%=strDay%>";
			
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				var arrYear = new Array();
				var arrMonth = new Array();
				
				for (var i = 1980; i < 2030; i++)
				{
					arrYear.push(i.toString() + "\t" + i.toString());
				}
				
				for (var i = 1; i < 13; i++)
				{
					arrMonth.push(C_LPad(i.toString(), 2, "0") + "\t" + C_LPad(i.toString(), 2, "0"));
				}
				
				if (strType == "M")
				{
					C_setArrayCombo(cboYear2, arrYear);
					
					cboYear2.value = strYear;
					divCalendarHead2.style.display = "block";
					divCalendarBody2.style.display = "block";
					
					document.all.ifrmCalendarBody2.src = "./CalendarBody.jsp?CID=" + strCalendarID + "&TYPE=" + strType + "&DATE=" + cboYear1.value + "-" + cboMonth1.value + "-01";
				}
				else
				{
					C_setArrayCombo(cboYear1, arrYear);
					C_setArrayCombo(cboMonth1, arrMonth);
					
					cboYear1.value = strYear;
					cboMonth1.value = strMonth;
					divCalendarHead1.style.display = "block";
					divCalendarBody1.style.display = "block";
				}
				
				YearMonthChange();
				
				parent.C_CalendarShow();
				// 반드시 포커스를 줘야함.
				this.focus();
			}
			
			// 함수관련---------------------------------------------------------------------//
			function YearMonthChange()
			{
				if (strType == "M")
				{
					document.all.ifrmCalendarBody2.src = "./CalendarBody.jsp?CID=" + strCalendarID + "&TYPE=" + strType + "&DATE=" + cboYear2.value + "-01-01";
				}
				else
				{
					document.all.ifrmCalendarBody1.src = "./CalendarBody.jsp?CID=" + strCalendarID + "&TYPE=" + strType + "&DATE=" + cboYear1.value + "-" + cboMonth1.value + "-01";
				}
			}
			
			function ChoiceToDay()
			{
				parent.C_CalendarHide(strCalendarID, strToDay);
			}
			
			function Cancle()
			{
				parent.C_CalendarHide(-1);
			}
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyPress()
			{
				if (event.keyCode == 27)
				{
					Cancle();
				}
			}
			
			function btnToDay_onClick()
			{
				cboYear1.value = strToDay.substring(0, 4);
				cboMonth1.value = strToDay.substring(5, 7);
				
				document.all.ifrmCalendarBody1.src = "./CalendarBody.jsp?CID=" + strCalendarID + "&TYPE=" + strType + "&DATE=" + strToDay;
			}
			
		//-->
		</script>
		
	</head>
	<body onload="C_Initialize()" onkeypress="javascript:document_onKeyPress()">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
			<TR>
				<TD align="center">
					<!-- 표준 팝업 페이지의 최소 DIV 크기(폭:250px 이상, 높이:400px 고정) //-->
					<DIV id="divPopMain" style="WIDTH:100%; HEIGHT:100%;">
						<table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr valign="top"> 
											<td height="100%" bgcolor="#FFFFFF">
												<DIV id="divCalendarHead1" style="WIDTH:100%; display:none">
													<TABLE width="100%" cellSpacing="0" cellPadding="0" border="0">
														<TR height="30" bgcolor="ECECEC">
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="30">년도</td>
															<td width="65">
																<select id="cboYear1" style="WIDTH: 54px" class="input_listbox_default" onChange="YearMonthChange()"></select>
															</td>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="18">월</td>
															<td width="*">
																<select id="cboMonth1" style="WIDTH: 40px" class="input_listbox_default" onChange="YearMonthChange()"></select>
															</td>
														</TR>
													</TABLE>
												</DIV>
												<DIV id="divCalendarHead2" style="WIDTH:100%; display:none">
													<TABLE width="100%" cellSpacing="0" cellPadding="0" border="0">
														<TR height="30" bgcolor="ECECEC">
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="30">년도</td>
															<td width="*">
																<select id="cboYear2" style="WIDTH: 54px" class="input_listbox_default" onChange="YearMonthChange()"></select>
															</td>
														</TR>
													</TABLE>
												</DIV>
												<TABLE width="100%" cellSpacing="0" cellPadding="0" border="0">
													<TR height="6">
														<td width="*"></td>
													</TR>
												</TABLE>
												<DIV id="divCalendarBody1" style="WIDTH:100%; display:none">
													<TABLE width="188" cellSpacing="0" cellPadding="0" border="0">
														<TR align="center">
															<td width="10"></td>
															<td width="24"><font color="red">일</font></td>
															<td width="24">월</td>
															<td width="24">화</td>
															<td width="24">수</td>
															<td width="24">목</td>
															<td width="24">금</td>
															<td width="24"><font color="blue">토</font></td>
															<td width="*"></td>
														</TR>
														<TR align="center">
															<td width="10"></td>
															<td height="2" colspan="7" bgcolor="blue"></td>
															<td width="*"></td>
														</TR>
														<TR align="center">
															<td height="4" colspan="9"></td>
														</TR>
														<TR align="center">
															<td width="10"></td>
															<td colspan="7"><iframe width="100%" height="96" name="ifrmCalendarBody1" src="" frameborder="0" tabindex="-1" scrolling="no"></iframe></td>
															<td width="*"></td>
														</TR>
														<TR align="center">
															<td width="10"></td>
															<td height="2" colspan="7" bgcolor="blue"></td>
															<td width="*"></td>
														</TR>
														<TR align="center">
															<td height="4" colspan="9"></td>
														</TR>
														<TR>
															<td width="10"></td>
															<td colspan="7">
																오늘 : <a href="#" onClick="ChoiceToDay()"><%=CITDate.getNow("yyyy년 MM월 dd일")%></a>
																<input id="btnToDay1" type="button" class="img_btnFind_s" title="오늘" onclick="btnToDay_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td width="*"></td>
														</TR>
													</TABLE>
												</DIV>
												<DIV id="divCalendarBody2" style="WIDTH:100%; display:none">
													<TABLE width="188" cellSpacing="0" cellPadding="0" border="0">
														<TR align="center">
															<td width="10"></td>
															<td height="2" colspan="7" bgcolor="blue"></td>
															<td width="*"></td>
														</TR>
														<TR align="center">
															<td height="4" colspan="9"></td>
														</TR>
														<TR align="center">
															<td width="10"></td>
															<td colspan="7"><iframe width="100%" height="30" name="ifrmCalendarBody2" src="" frameborder="0" tabindex="-1" scrolling="no"></iframe></td>
															<td width="*"></td>
														</TR>
														<TR align="center">
															<td width="10"></td>
															<td height="2" colspan="7" bgcolor="blue"></td>
															<td width="*"></td>
														</TR>
														<TR align="center">
															<td height="4" colspan="9"></td>
														</TR>
														<TR>
															<td width="10"></td>
															<td colspan="7">오늘 : <%=CITDate.getNow("yyyy년 MM월 dd일")%></td>
															<td width="*"></td>
														</TR>
													</TABLE>
												</DIV>
											</td>
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
		throw new Exception("페이지 종료 오류 -> " + ex.getMessage());
	}
%>