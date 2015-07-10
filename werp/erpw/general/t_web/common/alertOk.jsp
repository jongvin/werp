<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	/***************************************************/
	/* 최초작성자 : 강덕율
	/* 최초작성일 : 2005-10-31
	/* 최종수정자 : 
	/* 최종수정일 : 
	/***************************************************/
%>
<%
	try
	{
		CITCommon.initPage(request, response, session, false);
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
		<script language="javascript">
		<!--
			function Initialize()
			{
				var arrArg = window.dialogArguments;
				
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				txtMessage.noWrap = false;
				
				if (arrArg != null && arrArg.length > 0 && !C_isNull(arrArg[0]))
				{
					txtMessage.innerHTML = arrArg[0];
					txtTitle.innerHTML = arrArg[1];
				}
			}

			// 함수관련---------------------------------------------------------------------//
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyPress()
			{
				if (event.keyCode == 13 || event.keyCode == 27)
				{
					btnOk_onClick();
				}
				else if (event.keyCode == 79 || event.keyCode == 111)
				{
					btnOk_onClick();
				}
			}
			
			function btnOk_onClick()
			{
				window.returnValue = "O";
				window.close();
			}
			
		//-->
		</script>
	</head>
	<body onload="C_Initialize()" onkeypress="javascript:document_onKeyPress()">
		<!-- 표준 Alert 페이지의 고정 DIV 시작 : 크기(폭:100%, 높이:100%) //-->
		<div id="divMainFix" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%"> 
			<table width="370" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td HEIGHT="23" align="left" background="../images/alert_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="19"><img src="../images/alert_tit_img.gif" width="19" height="23"></td>
								<td class="alert_default">
									<font id="txtTitle">UnTitle</font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td bgcolor="#CCCCCC">
						<table width="370" border="0" cellspacing="1" cellpadding="0">
							<tr> 
								<td align="center" bgcolor="#FFFFFF">
									<table width="370" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="8" bgcolor="ECECEC"></td>
										</tr>
										<tr> 
											<td align="center" bgcolor="ECECEC"> 
												<table width="350" height="100" border="0" cellpadding="0" cellspacing="0">
													<tr> 
														<td width="350" height="8" background="../images/alert_body_top.gif"></td>
													</tr>
													<tr>
														<td align="center" valign="middle" background="../images/alert_body_bg.gif">
															<!-- 프로그래머 디자인 시작 //-->
															<table width="330" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td align="center">
																		<div id="divMessage" style="OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100px">
																			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td id="txtMessage" align="center"></td>
																				</tr>
																			</table>
																		</div>
																	</td>
																</tr>
															</table>
															<!-- 프로그래머 디자인 종료 //-->
														</td>
													</tr>
													<tr>
														<td width="350" height="8" background="../images/alert_body_bottom.gif"></td>
													</tr>
												</table> 
											</td>
										</tr>
										<tr> 
											<td height="5" bgcolor="ECECEC"></td>
										</tr>
										<tr> 
											<td align="right" bgcolor="ECECEC">
											    <table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td align="right">
															<input id="btnOk" type="button" class="img_btnOk" value="확인" title="확인(O)" onclick="btnOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="12">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr> 
											<td height="5" bgcolor="ECECEC"></td>
										</tr>
									</table> </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<!-- 표준 페이지의 고정 DIV 종료 //-->
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
