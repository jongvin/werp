<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*" isErrorPage="true" contentType="text/html;charset=euc-kr" %>
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
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
			}

			// 함수관련---------------------------------------------------------------------//
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyPress()
			{
				if (event.keyCode == 13 || event.keyCode == 27)
				{
					btnOk_onClick()
				}
			}
			
			function btnOk_onClick()
			{
				if (window.dialogTop == null)
				{
					window.history.back();
				}
				else
				{
					window.close();
				}
			}
			
		//-->
		</script>
	</head>
	<body onload="C_Initialize()" onkeypress="javascript:document_onKeyPress()">
		<table width="100%" height="100%" cellSpacing="0" cellPadding="0" border="1">
			<tr>
				<td align="center" valign="middle">
					<div id="divMainFix" style="OVERFLOW: hidden; WIDTH: 370px"> 
						<table width="370" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td HEIGHT="23" align="left" background="../images/alert_tit_bg.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="19"><img src="../images/alert_tit_img.gif" width="19" height="23"></td>
											<td class="alert_default">
												<font id="txtTitle">에러</font>
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
															<table width="350" border="0" cellpadding="0" cellspacing="0">
																<tr> 
																	<td>
																		<TEXTAREA style="WIDTH: 350px; HEIGHT: 110px" name="txtMessage" readOnly><%=exception.getMessage()%></TEXTAREA>
																	</td>
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
																		<input id="btnOk" type="button" class="img_btnOk" value="확인" onclick="btnOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																	</td>
																	<td width="12">&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr> 
														<td height="5" bgcolor="ECECEC"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
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
