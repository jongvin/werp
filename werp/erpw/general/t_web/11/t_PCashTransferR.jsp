<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";
  String strDate = CITDate.getNow("yyyy-MM-dd");
  
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
		<title>������ü���</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/Popup.js"></script>
		<script language="javascript">
		<!--
			var lrArgs = Array(12);
		
			function Initialize()
			{
				document.body.topMargin = 0;
				document.body.leftMargin = 0;

				//������ڵ�
				lrArgs = window.dialogArguments;				
				txtCOMP_CODE.value = lrArgs[0] ;
				
				G_addDataSet(dsLOV, null, null, null, "LOV");
				
				txtREQUEST_YMD.value     = lrArgs[1] ;
				txtOUTACCOUNT_CODE.value = lrArgs[2] ;
				txtOUTBANK_CODE.value    = lrArgs[3] ;
				txtOUTBANK_NAME.value    = lrArgs[4] ;
				txtINACCOUNT_CODE.value  = lrArgs[5] ;
				txtINBANK_CODE.value     = lrArgs[6] ;
				txtINBANK_NAME.value     = lrArgs[7] ;
				txtREMAIN_AMT.value      = C_toNumberFormatString(lrArgs[8],false) ;
				if (!C_isNull(lrArgs[9])) txtSTD_YMD.value  = "������ȸ��:"+lrArgs[9] ;
				txtTRANSFER_AMT.value    = C_toNumberFormatString(lrArgs[10],false) ;
				txtDESCRIPTION.value     = lrArgs[11] ;
			}

			// �̺�Ʈ����-------------------------------------------------------------------//
			function	ConfirmSelected()
			{
				var arrRet = Array(8);
				arrRet[0] = "TRUE";
				arrRet[1] = txtREQUEST_YMD.value;
				arrRet[2] = txtOUTACCOUNT_CODE.value;
				arrRet[3] = txtOUTBANK_CODE.value;
				arrRet[4] = txtINACCOUNT_CODE.value;
				arrRet[5] = txtINBANK_CODE.value;
				arrRet[6] = txtTRANSFER_AMT.value;
				arrRet[7] = txtDESCRIPTION.value;
				
				window.returnValue = arrRet;
				window.close();
			}
			function imgOk_onClick()
			{
				var intTRANSFER_AMT = C_convSafeFloat(C_removeComma(txtTRANSFER_AMT.value,false),false);
				var intREMAIN_AMT = C_convSafeFloat(C_removeComma(txtREMAIN_AMT.value,false),false);
				
				if ( C_isNull(txtREQUEST_YMD.value) )
				{
					C_msgOk("��ü�������� �Է��ϼ���.","�˸�"); 
					return;
				}
				if ( C_isNull(txtOUTACCOUNT_CODE.value) )
				{
					C_msgOk("��ݰ��¸� �Է��ϼ���.","�˸�"); 
					return;
				}
				if ( C_isNull(txtINACCOUNT_CODE.value) )
				{
					C_msgOk("�Աݰ��¸� �Է��ϼ���.","�˸�"); 
					return;
				}
				if ( C_isNull(txtTRANSFER_AMT.value)||txtTRANSFER_AMT.value ==0 )
				{
					C_msgOk("��ü�ݾ׸� �Է��ϼ���","�˸�"); 
					return;
				}
			
				if ( intTRANSFER_AMT > intREMAIN_AMT )
				{
					C_msgOk("��ü�ݾ��� ����ܾ׺��� Ů�ϴ�.","�˸�"); 
					return;
				}

				ConfirmSelected();
				
			}
			function imgCancle_onClick()
			{
				window.returnValue = null;
				window.close();
			}
			function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
			{
				if (asCalendarID == "DT_F")
				{
					txtREQUEST_YMD.value = asDate;
				}
			}
			function btnDT_F_onClick()
			{
				C_Calendar("DT_F", "D", txtREQUEST_YMD.value);
			}	 
			//��ݰ���ã��
			function txtOUTACCOUNT_CODE_onblur()
			{
				if (C_isNull(txtOUTACCOUNT_CODE.value))
				{
					txtOUTACCOUNT_CODE.value = '';
					txtOUTBANK_NAME.value = '';
					txtOUTBANK_CODE.value = '';
					return;
				}
			
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				lrArgs.set("SEARCH_CONDITION", txtOUTACCOUNT_CODE.value);
				lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
			
				lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE3", lrArgs,"T");
			
				if (lrRet == null) return;
				
				txtOUTACCOUNT_CODE.value = lrRet.get("ACCNO");
				txtOUTBANK_NAME.value = lrRet.get("BANK_NAME");
				txtOUTBANK_CODE.value = lrRet.get("BANK_CODE");
				txtREMAIN_AMT.value = C_toNumberFormatString(lrRet.get("REMAIN_AMT"),false);
				txtSTD_YMD.value = "������ȸ��:"+lrRet.get("STD_YMD")
			}
			function btnOUTACCOUNT_CODE_onClick()
			{
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				lrArgs.set("SEARCH_CONDITION", txtOUTACCOUNT_CODE.value);
				lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
			
				lrRet = C_LOV("T_ACCNO_CODE3", lrArgs,"F");
			
				if (lrRet == null) return;
			
				txtOUTACCOUNT_CODE.value = lrRet.get("ACCNO");
				txtOUTBANK_NAME.value = lrRet.get("BANK_NAME");
				txtOUTBANK_CODE.value = lrRet.get("BANK_CODE");
				txtREMAIN_AMT.value = C_toNumberFormatString(lrRet.get("REMAIN_AMT"),false);
				txtSTD_YMD.value = "������ȸ��:"+lrRet.get("STD_YMD")
			}
			//�Աݰ���ã��
			function txtINACCOUNT_CODE_onblur()
			{
				if (C_isNull(txtINACCOUNT_CODE.value))
				{
					txtINACCOUNT_CODE.value = '';
					txtINBANK_NAME.value = '';
					txtINBANK_CODE.value = '';
					return;
				}
			
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				lrArgs.set("SEARCH_CONDITION", txtINACCOUNT_CODE.value);
				lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
				lrArgs.set("BANK_CODE", '%');
				lrArgs.set("ACCT_CLS", '%');
			
				lrRet = C_AutoLov(dsLOV,"T_ACCNO_CODE1", lrArgs,"T");
			
				if (lrRet == null) return;
				
				txtINACCOUNT_CODE.value = lrRet.get("ACCNO");
				txtINBANK_NAME.value = lrRet.get("BANK_NAME");
				txtINBANK_CODE.value = lrRet.get("BANK_CODE");
			}
			function btnINACCOUNT_CODE_onClick()
			{
				var lrArgs = new C_Dictionary();
				var lrRet = null;
			
				lrArgs.set("SEARCH_CONDITION", txtINACCOUNT_CODE.value);
				lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
				lrArgs.set("BANK_CODE", '%');
				lrArgs.set("ACCT_CLS", '%');
			
				lrRet = C_LOV("T_ACCNO_CODE1", lrArgs,"F");
			
				if (lrRet == null) return;
			
				txtINACCOUNT_CODE.value = lrRet.get("ACCNO");
				txtINBANK_NAME.value = lrRet.get("BANK_NAME");
				txtINBANK_CODE.value = lrRet.get("BANK_CODE");
			}
		//-->
		</script>
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
		<!--CONVPAGE_HEAD ������������//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL ������������//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD ������������//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL ������������//-->
		<!-- ���콺 Dataset �� Tranaction ��ü���� ���� //-->
	</head>
	<body onload="C_Initialize();">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="398" height="350" border="0">
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
											<td class="title_default">������ü���</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr >
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="80%" border="1" cellspacing="0" cellpadding="0">
										<tr  bgcolor="ECECEC">
											<td align="LEFT" bgcolor="ECECEC">
												<!-- ��� ���� //-->
												<TABLE width="365" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="90">��ü������</td>
														<td width="250">
															<input id="txtREQUEST_YMD" type="text" datatype="date" tabindex="100" style="width:70px" value = "<%=strDate%>">
														  <input id="btnDTS_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="�޷�" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
													</TR>
												</TABLE>
												<TABLE width="365" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="90" >��ݰ��¹�ȣ</td>
														<td width="250">
														<table width="250" border="0" cellspacing="0" cellpadding="0">
														<td width="130">
														<input name="txtOUTACCOUNT_CODE" type="text" datatype="han" tabindex="110" style="width:128px" VALUE="" onblur="txtOUTACCOUNT_CODE_onblur()"></td>
														<td width="80">
														<input name="txtOUTBANK_NAME" type="text" class="ro" readOnly style="width:78px" VALUE="" >
														<input name="txtOUTBANK_CODE" type="hidden" class="ro" style="width:30px" VALUE="" >
														<input name="txtCOMP_CODE" type="hidden" class="ro" style="width:30px" VALUE="" >
														</td>
													  <td width="40">
														<input name="btnOUTACCOUNT_CODE" type="button" tabindex="120" class="img_btnFind" onclick="btnOUTACCOUNT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
														</td>
														</table>
														</td>
													</TR>
												</TABLE>
												<TABLE width="365" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="90" >�Աݰ��¹�ȣ</td>
														<td width="250">
														<table width="250" border="0" cellspacing="0" cellpadding="0">
														<td width="130">
														<input name="txtINACCOUNT_CODE" type="text" datatype="han" tabindex="120" style="width:128px" VALUE="" onblur="txtINACCOUNT_CODE_onblur()" ></td>
														<td width="80">
														<input name="txtINBANK_NAME" type="text" class="ro" readOnly style="width:78px" VALUE="" >
														<input name="txtINBANK_CODE" type="hidden" class="ro" style="width:30px" VALUE="" >
														</td>	
														<td width="40">
														<input name="btnINACCOUNT_CODE" type="button" class="img_btnFind" onclick="btnINACCOUNT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="ã��" />
														</td>
														</table>
														</td>
													</TR>
												</TABLE>
												<TABLE width="365" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="90" >����ܾ�</td>
														<td width="130">
															<input id="txtREMAIN_AMT" type="text" right class="ro" readOnly  style="width:128px" value = "">
														</td>	
														<td width="122">	
															<input id="txtSTD_YMD" type="text"  class="ro" readOnly  style="width:122px" value = "">
														</td>
													</TR>
												</TABLE>												
												<TABLE width="365" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="90" >��ü�ݾ�</td>
														<td width="250">
															<input id="txtTRANSFER_AMT" type="text" datatype="currency" tabindex="130" style="width:128px" value = "">
														</td>
													</TR>
												</TABLE>
												<TABLE width="380" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="10"> &nbsp;</td>
														<td width="15"><img src="../images/bullet1.gif"></td>
														<td width="90" >����</td>
														<td width="265">
															<input id="txtDESCRIPTION" type="text" datatype="han" MaxLength="500" tabindex="140" style="width:265px" value = "">
														</td>
													</TR>
												</TABLE>												
												<!-- �˻��� ���� //-->
											</td>
										</tr>
									</table>
									<table width="100%" height="20%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="right" bgcolor="ECECEC">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<TR >
														<TD width="100%" align="right">
															<input id="imgOk" type="button" class="img_btnOk" tabindex="140"  value="����" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="imgCancle" type="button" class="img_btnClose" tabindex="150"  value="���" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
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
