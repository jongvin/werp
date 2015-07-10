<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*, java.sql.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-09-09
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
	
	CITData lrReturnData = null;
	String strOut = "";
	String strSql = "";
	
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
		<title><%=CITCommon.getProperty("company.name")%> - <%=CITCommon.getProperty("application.name")%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript">
		<!--
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
			}
			
			// 함수관련---------------------------------------------------------------------//

			// 공통 재정의 이벤트관련-------------------------------------------------------//
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyPress()
			{
				if (event.keyCode == 27)
				{
					btnCancel_onClick();
				}
			}
			
			function btnAdd_onClick()
			{
				if (C_isNull(frmFileLoad.NewFileName.value))
				{
					C_msgOk("등급 파일을 선택하세요.");
					return;
				}
				
				var ext = frmFileLoad.NewFileName.value.substring(frmFileLoad.NewFileName.value.lastIndexOf(".") + 1, frmFileLoad.NewFileName.value.length);
				
				if (C_isNull(ext) || (ext.toUpperCase() != "XLS"))
				{
					C_msgOk("엑셀 파일(XLS)을 선택하세요.");
					return;
				}
				
				frmFileLoad.action = "./PHrPmPubPensionRegister_P.jsp?ACT=ADD";
				frmFileLoad.submit();
				
				window.returnValue = "O";
				window.close();
			}
			
			function btnCancel_onClick()
			{
				window.returnValue = "C";
				window.close();
			}
			
		//-->
		</script>
		
	</head>
	<body onload="C_Initialize()" onkeypress="javascript:document_onKeyPress()">
		<form name="frmFileLoad" method="post" action="./PHrPmPubPensionRegister_P.jsp" target="ifrmAdd" enctype="multipart/form-data">
			<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
				<TR>
					<TD align="center">
						<!-- 표준 팝업 페이지의 최소 DIV 크기(폭:250px 이상, 높이:400px 고정) //-->
						<DIV id="divPopMain" style="WIDTH: 400px; HEIGHT: 150px;">
							<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td align="left" background="../images/pop_tit_bg.gif">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
												<td class="title_default">국민연금 등급파일 등록</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr height="2"> 
									<td></td>
								</tr>
								<tr> 
									<td height="100%" width="100%">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr align="center">
												<td width="15"><img src="../images/z1_sub2_bullet.gif"></td>
												<td width="40">파일명</td>
												<td width="*">
													<input type="file" name="NewFileName" style="width:320px">
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr> 
									<td height="30" width="100%" bgcolor="#ECECEC">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
											<tr> 
												<td width="*" align="right">
													<input id="btnAdd" type="button" class="btn2_1" value="등록" onclick="btnAdd_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
													<input id="btnCancel" type="button" class="btn2_1" value="취소" onclick="btnCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												</td>
												<td width="10">&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</DIV>
					</TD>
				</TR>
			</TABLE>
		</form>
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