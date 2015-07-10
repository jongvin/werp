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
		throw new Exception("������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>���꺯���û</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/Popup.js"></script>
		<script language="javascript">
		<!--
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var 			sClseAccId	    ="";
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
				
				if(strMonth =="01") 
				{
					strMonth = '0' +'' + ( parseInt(strMonth.substr(1,1)) + 1);
					
				}
				txtBUDG_APPLY_YM.value = strYear + "-" + strMonth;
				txtALL_CHG_SEQ.value =  lrArgs[1];
				hiPRE_BUDG_APPLY_YM.value = lrArgs[2];
				sClseAccId = lrArgs[3]; 
			}
			

			// �̺�Ʈ����-------------------------------------------------------------------//
			function	ConfirmSelected()
			{
				var arrRet = Array(3);
				arrRet[0] = "TRUE";
				arrRet[1] = txtALL_CHG_SEQ.value;
				arrRet[2] = txtBUDG_APPLY_YM.value;
		
				window.returnValue = arrRet;
				window.close();
			}
			function imgOk_onClick()
			{
				if ( C_isNull(txtBUDG_APPLY_YM.value))
				{
					C_msgOk("�������� �Է��ϼ���");
					txtBUDG_APPLY_YM.focus();
					return false;	
				}
				
				if(!dateFormatCheck()) return;
				
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
					if (parseInt(lsUMask) < parseInt(strYearMonth))
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("�ش������ �������Դϴ�.");
						return;
					}
					if (!C_isNum(lsUMask))
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("���ڸ� �Է��ϼž� �մϴ�.");
						return;
					}
			
					if (lsUMask.length != 6)
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("����� 6�ڸ��� �Է��ϼž� �մϴ�.");
						return;
					}
			
					var year  = lsUMask.substr(0, 4);
					var month = lsUMask.substr(4, 2);
			
					if (parseInt(year) < 1900)
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("1900�� ������ �⵵�� �Է��ϼ���.");
						return;
					}
			
					if (!C_isValidMonth(month))
					{
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						C_msgOk("���� 1~12 ������ �Է��� �� �ֽ��ϴ�.");
						return;
					}
					strPRE_BUDG_APPLY_YM = hiPRE_BUDG_APPLY_YM.value;
					if(lsUMask== strPRE_BUDG_APPLY_YM.toString().replace(/-/g, ""))
					{
						C_msgOk("���������� ���� �������� �Է��� �� �����ϴ�.");
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						return false;
					}
					if(lsUMask.substr(0, 4) != sClseAccId)
					{
						alert(sClseAccId);
						C_msgOk("�ش�ȸ���� �⵵�� �Է��ؾ� �մϴ�.");
						txtBUDG_APPLY_YM.value="";
						txtBUDG_APPLY_YM.focus();
						return false;
					}
					
					txtBUDG_APPLY_YM.value =lsUMask.substr(0, 4) + "-" + lsUMask.substr(4, 2);
					
					return true;
				}	
			}
			function imgCancle_onClick()
			{
				window.returnValue = null;
				window.close();
			}

		//-->
		</script>
		
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize();">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="240" height="210" border="0">
			<TR >
				<TD align="center">
					<!-- ǥ�� �˾� �������� �ּ� DIV ũ��(��:250px �̻�, ����:400px ����) //-->
					<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left" background="../images/pop_tit_bg.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="23"><img src="../images/pop_tit_normal2.gif"></td>
											<td class="title_default">�����ϰ�������</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr >
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="80%" border="0" cellspacing="0" cellpadding="0">
										<tr  bgcolor="ECECEC">
											<td align="center" bgcolor="ECECEC">
												<!-- ��� ���� //-->
												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="120">�����ϰ���������</td>
														<td width="70">
															<input id=hiPRE_BUDG_APPLY_YM type="hidden">
															<input id="txtALL_CHG_SEQ" type="text" center class="ro" readOnly="true" style="width:68px" >
														</td>
														<td> &nbsp;</td>
													</TR>
												</TABLE>
												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="120">���꺯��������ۿ�</td>
														<td width="80">
															<input id="txtBUDG_APPLY_YM" type="text" center maxlength=7 style="width:80px" onBlur=dateFormatCheck(); >
														</td>
													<td> &nbsp;</td>
													</TR>
												</TABLE>
												
												<!-- �˻��� ���� //-->
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
															<input id="imgOk" type="button" class="img_btnOk" value="Ȯ��" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="imgCancle" type="button" class="img_btnClose" value="�ݱ�" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
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
