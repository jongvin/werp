<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 프로그램 ID(프로그램 한글명)
/* 2. 유형(시나리오) : 팝업
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 홍길동 작성(2003-02-01), 김철수 수정(2003-04-02)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
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
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
			}
			
			// 세션관련 함수----------------------------------------------------------------//
			function SetSession()
			{
			}
			
			function GetSession()
			{
			}
			
			function ReportSession(asName, asValue)
			{
			}
			
			// 함수관련---------------------------------------------------------------------//
			
			// 공통 재정의 이벤트관련-------------------------------------------------------//
			function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
			{
			}
			
			function OnLoadBefore(dataset)
			{
			}
			
			function OnLoadCompleted(dataset, rowcnt)
			{
			}
			
			function OnRowInsertBefore(dataset)
			{
				return true;
			}
			
			function OnRowInserted(dataset, row)
			{
			}
			
			function OnRowDeleteBefore(dataset)
			{
				return true;
			}
			
			function OnRowDeleted(dataset, row)
			{
			}
			
			function OnColumnChanged(dataset, row, colid)
			{
			}
			
			function OnExit(dataset, grid, row, colid, olddata)
			{
			}
			
			function OnPopup(dataset, grid, row, colid, data)
			{
			}
			
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<object id=dsTest classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="left" background="../images/pop_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
								<td class="title_default">타이틀</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td height="100%" width="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<TABLE width="100%" height="100%" cellSpacing="0" cellPadding="0" border="0">
										<TR>
											<TD width="10" ><IMG src="../images/bullet3.gif" ></TD>
											<TD width="55" noWrap="true">검색조건</TD>
											<TD WIDTH="*"><INPUT type="text" id="txtSearch" style="WIDTH:100%" onKeyDown="txtSearch_onKeyDown()"></TD>
											<TD width="2">&nbsp;</TD>
											<TD width="50">
												<input id="btnRetrieve" type="button" class="img_btnFind" value="검색" onclick="btnRetrieve_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</TD>
											<td width="4">&nbsp;</td>
										</TR>
									</TABLE>
								</td>
							</tr>
							<tr>
								<td width="100%" height="*">
									<OBJECT id=gridArgs WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsLovArgs">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=순번 ID=DIS_SEQ Align=Center Width=30 
											</FC> 
											<FC> Name=인자명 ID=NAME Width=105
											</FC> 
											<C> Name=타입 ID=TYPE Width=40 EditStyle=Combo Data='S:문자,N:숫자,D:날짜'
											</C> 
											<C> Name=기본값 ID=DEFAULT_VALUE Width=75
											</C> 
											<C> Name=세션? ID=SESSION_TAG Width=40 EditStyle=CheckBox
											</C> 
											<C> Name=세션변수명 ID=SESSION_NAME Width=100
											</C> 
											">
									</OBJECT>
								</td>
							</tr>
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<TD width="100%" align="right">
												<input id="imgOk" type="button" class="img_btnOk" value="확인" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="imgCancle" type="button" class="img_btnClose" value="닫기" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</DIV>
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