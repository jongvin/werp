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
				var arrArgs = window.dialogArguments;
				var strCol = "";
				var strText = "";
				var bolUpper = false;
				
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				if (arrArgs == null || arrArgs.length < 2)
				{
					C_msgOk("인자가 올바르지 않습니다.", "에러");
					btnCancel_onClick();
				}
				
				if (arrArgs[0] == null)
				{
					C_msgOk("DataSet이 널(Null) 입니다.", "에러");
					btnCancel_onClick();
				}
				
				if (arrArgs[1] == null)
				{
					C_msgOk("Grid가 널(Null) 입니다.", "에러");
					btnCancel_onClick();
				}
				
				setCols(arrArgs[0], arrArgs[1], cboCols);
				
				cboCols.value = arrArgs[2];
				txtFindText.value = arrArgs[3];
				chkUpper.checked = arrArgs[4];
				
				txtFindText.focus();
			}

			// 함수관련---------------------------------------------------------------------//
			function setCols(dataset, grid, combo)
			{
				if (dataset == null) return;
				
				for (var i = 1; i <= dataset.CountColumn; i++)
				{
					if (grid.ColumnProp(dataset.ColumnID(i), 'Show') == "FALSE") continue;
					
					var lsTitle = grid.ColumnProp(dataset.ColumnID(i), 'Name');
					
					if (lsTitle == "undefined") continue;
					C_addComboItem(combo, dataset.ColumnID(i), lsTitle);
				}
			}
			
			// 이벤트관련-------------------------------------------------------------------//
			function document_onKeyPress()
			{
				if (event.keyCode == 13)
				{
					btnOk_onClick();
				}
				else if (event.keyCode == 27)
				{
					btnCancel_onClick();
				}
				else if (event.srcElement != txtFindText && (event.keyCode == 79 || event.keyCode == 111))
				{
					btnOk_onClick();
				}
				else if (event.srcElement != txtFindText && (event.keyCode == 67 || event.keyCode == 99))
				{
					btnCancel_onClick();
				}
			}
			
			function btnOk_onClick()
			{
				if (cboCols.selectedIndex < 0)
				{
					C_msgOk("검색컬럼을 선택하십시요.");
					return;
				}
				
				if (C_isNull(txtFindText.value))
				{
					C_msgOk("검색어를 입력하십시요.");
					return;
				}
				
				var arrRet = new Array();
				
				arrRet[0] = "O";
				arrRet[1] = cboCols.value;
				arrRet[2] = txtFindText.value;
				arrRet[3] = chkUpper.checked;
				
				window.returnValue = arrRet;
				window.close();
			}
			
			function btnCancel_onClick()
			{
				var arrRet = new Array();
				
				arrRet[0] = "C";
				
				window.returnValue = arrRet;
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
									<font id="txtTitle">찾기</font>
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
																		<div id="divMessage" style="OVERFLOW: auto; WIDTH: 250px; HEIGHT: 60px">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="15"><img src="../images/bullet3.gif"></td>
																					<td width="55">검색컬럼</td>
																					<td><select style="WIDTH: 150px" id="cboCols"></SELECT></td>
																				</tr>
																				<tr>
																					<td width="15"><img src="../images/bullet3.gif"></td>
																					<td width="55">검색어</td>
																					<td><input id="txtFindText" type="text" style="width:150px"></td>
																				</tr>
																			</table>
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="70">&nbsp;</td>
																					<td width="20"><input id="chkUpper" type="checkbox" class="check" onfocus="blur()"></td>
																					<td width="80">대소문자 일치</td>
																					<td>&nbsp;</td>
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
															<input id="btnCancel" type="button" class="img_btnCancel" value="취소" title="취소(C)" onclick="btnCancel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
