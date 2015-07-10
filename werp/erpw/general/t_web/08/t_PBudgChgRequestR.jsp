<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";
	String strFileName = "./t_PBudgChgRequestR";
    	try
    	{
    		CITCommon.initPage(request, response, session);
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>예산변경신청</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/Popup.js"></script>
		<script language="javascript">
		<!--
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			
		//-->
		</script>
		<script language="javascript">
		<!--
			//var lrArgs = null;
			function Initialize()
			{
				
				document.body.topMargin = 0;
				document.body.leftMargin = 0;
				
				
				lrArgs = window.dialogArguments;
				
				var strYear = C_getYear();
				var strMonth = C_getMonth();
				
				if ( strMonth =="12")
				{
					strYear = parseInt(strYear) + 1;
					strMonth="01";	
				}
				else 
				{
					if(strMonth=="10" || strMonth=="11" )
					{
						strMonth=parseInt(strMonth) +1;
					}
					else if(strMonth =="09")
					{
						strMonth="10";
					}
					else 
					{
						strMonth = '0' +'' + ( parseInt(strMonth.substr(1,1)) + 1);
					}
				}
				txtBUDG_APPLY_YM.value = strYear + "-" + strMonth;
				txtCHG_SEQ.value =  lrArgs[1]; 
			}
			

			// 이벤트관련-------------------------------------------------------------------//
			function	ConfirmSelected()
			{
				var arrRet = Array(3);
				arrRet[0] = "TRUE";
				arrRet[1] = txtCHG_SEQ.value;
				arrRet[2] = txtBUDG_APPLY_YM.value;
		
				window.returnValue = arrRet;
				window.close();
			}
			function imgOk_onClick()
			{
				if ( C_isNull(txtBUDG_APPLY_YM.value))
				{
					C_msgOk("적용년월을 입력하세요");
					txtBUDG_APPLY_YM.focus();
					return false;	
				}
				
				dateFormatCheck();
				
				ConfirmSelected();
			}
			function dateFormatCheck()
			{
				var COL_DATA = txtBUDG_APPLY_YM.value;
				if(C_isNull(COL_DATA))
				{
					return ;
				}
				else
				{
					var	lsUMask = COL_DATA.toString().replace(/-/g, "");
					
					var strYear = C_getYear();
					var strMonth = C_getMonth();
					var strYearMonth = strYear + strMonth;
/*
					if (parseInt(lsUMask) < parseInt(strYearMonth))
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("해당월보다 이전달입니다.");
						return;
					}
*/
					if (!C_isNum(lsUMask))
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("숫자를 입력하셔야 합니다.");
						return;
					}
			
					if (lsUMask.length != 6)
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("년월은 6자리를 입력하셔야 합니다.");
						return;
					}
			
					var year  = lsUMask.substr(0, 4);
					var month = lsUMask.substr(4, 2);
			
					if (parseInt(year) < 1900)
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("1900년 이후의 년도를 입력하세요.");
						return;
					}
			
					if (!C_isValidMonth(month))
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("월은 1~12 까지만 입력할 수 있습니다.");
						return;
					}
					txtBUDG_APPLY_YM.value =lsUMask.substr(0, 4) + "-" + lsUMask.substr(4, 2);
				}	
			}
			function imgCancle_onClick()
			{
				window.returnValue = null;
				window.close();
			}

		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize();">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="240" height="210" border="0">
			<TR >
				<TD align="center">
					<!-- 표준 팝업 페이지의 최소 DIV 크기(폭:250px 이상, 높이:400px 고정) //-->
					<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left" background="../images/pop_tit_bg.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="23"><img src="../images/pop_tit_normal2.gif"></td>
											<td class="title_default">예산변경신청등록</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr >
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="80%" border="0" cellspacing="0" cellpadding="0">
										<tr  bgcolor="ECECEC">
											<td align="center" bgcolor="ECECEC">
												<!-- 등록 시작 //-->
												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="120">예산변경차수</td>
														<td width="70">
															<input id="txtCHG_SEQ" type="text" center class="ro" readOnly="true" style="width:68px" >
														</td>
														<td> &nbsp;</td>
													</TR>
												</TABLE>
												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="120">예산변경적용시작월</td>
														<td width="80">
															<input id="txtBUDG_APPLY_YM" type="text" center maxlength=7 style="width:80px" onBlur=dateFormatCheck(); >
														</td>
													<td> &nbsp;</td>
													</TR>
												</TABLE>
												
												<!-- 검색어 종료 //-->
											</td>
										</tr>
										<tr>
											<td height="2" bgcolor="ECECEC"></td>
										</tr>
									</table>
									<table width="100%" height="20%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="right" bgcolor="ECECEC">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<TR >
														<TD width="100%" align="center">
															<input id="imgOk" type="button" class="img_btnOk" value="확인" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="imgCancle" type="button" class="img_btnClose" value="닫기" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
														</TD>
													</TR>
												</TABLE>
											</td>
										</tr>
										<tr>
											<td height="8" bgcolor="ECECEC"></td>
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
