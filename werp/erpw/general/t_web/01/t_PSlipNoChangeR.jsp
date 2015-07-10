<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
	CITData lrReturnData = null;
	String strOut = "";
	
	String strFileName = "./t_PSlipNoChangeR";
	//저장 액션
	String strUpdateKeyValue = "";
	strUpdateKeyValue  = "Service1(";
	strUpdateKeyValue += "I:dsEXEC_PROC=dsEXEC_PROC";
	strUpdateKeyValue += ")";

    try
    {
    	CITCommon.initPage(request, response, session);
	}
	catch (Exception ex)
	{
		throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	}

	String	strSLIP_ID 	   = CITCommon.toKOR(request.getParameter("SLIP_ID"));
	String	strMAKE_DT     = CITCommon.toKOR(request.getParameter("MAKE_DT"));
	String	strMAKE_SLIPNO = CITCommon.toKOR(request.getParameter("MAKE_SLIPNO"));
	
	//사용자
	String	strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
	String	strNAME = CITCommon.NvlString(session.getAttribute("name"));	
	//권한
	String	strSLIP_TRANS_CLS = CITCommon.NvlString(session.getAttribute("slip_trans_cls"));
	String	strDEPT_CHG_CLS = CITCommon.NvlString(session.getAttribute("dept_chg_cls"));
	//사업장 설정
	String	strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
	String	strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
	String	strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>전표일자변경</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		
<script language="javascript">
<!--
	var	sSelectPageName = "<%=strFileName%>_q.jsp";

	var lrArgs;
	
	// 배치처리 파라메터
	var vSlipId = "<%=strSLIP_ID%>";
	var vKeepDt = "";
	var vDeptCode = "<%=strDEPT_CODE%>";
	var vKeepKeeper = "<%=strEMP_NO%>";
	
	function Initialize()
	{
		document.body.topMargin = 0;
		document.body.leftMargin = 0;
		G_addDataSet(dsEXEC_PROC, trans, null, null, "배치처리용 데이터셑");
		G_addDataSet(dsMAIN, null, null, null, "목록");
	}

	// 이벤트관련-------------------------------------------------------------------//
	// 이벤트관련-------------------------------------------------------------------//
	function OnLoadBefore(dataset)
	{
		if(dataset == dsEXEC_PROC)
		{
			dataset.DataID = sSelectPageName	+ D_P1("ACT","EXEC_PROC");
		}
		else if(dataset == dsMAIN)
		{
			dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
												+ D_P2("SLIP_ID",vSlipId);
		}
	}

	function OnLoadCompleted(dataset, rowcnt)
	{
		if (dataset == dsEXEC_PROC) {
		}
	}

	function imgOk_onClick()
	{
		if( txtKEEP_DT.value=="" ) {
			C_msgOk("전표일자가 입력되지 않았습니다.", "확인");
			return;
		}

		if( "<%=strMAKE_DT%>".replace(/-/gi,"") == txtKEEP_DT.value.replace(/-/gi,"") ) {
			C_msgOk("일자가 변경되지 않았습니다.", "확인");
			return;
		}
		dsEXEC_PROC.ResetStatus();
		
		G_Load(dsEXEC_PROC, null);
		
		dsEXEC_PROC.NameString(dsEXEC_PROC.RowPosition, "CMD") = "MAKE_DT_CHG";
		dsEXEC_PROC.NameString(dsEXEC_PROC.RowPosition, "SLIP_ID") = vSlipId;
		dsEXEC_PROC.NameString(dsEXEC_PROC.RowPosition, "KEEP_SLIPNO") = txtMAKE_SLIPNO.value;
		dsEXEC_PROC.NameString(dsEXEC_PROC.RowPosition, "KEEP_DT") = txtKEEP_DT.value.replace(/-/gi,"");
		dsEXEC_PROC.NameString(dsEXEC_PROC.RowPosition, "DEPT_CODE") = vDeptCode;
		dsEXEC_PROC.NameString(dsEXEC_PROC.RowPosition, "KEEP_KEEPER") = vKeepKeeper;

		G_saveData(dsEXEC_PROC);
	}

	function imgCancle_onClick(){
		var myObject = new Object;
		myObject.RESULT = "작업취소";
		window.returnValue = myObject;
		window.close();
	}
	
	function OnSuccess(dataset, trans) {
		///alert("dsEXEC_PROC OnSuccess");
		//C_msgOk("전표확정 완료되었습니다.", "확인");
		G_Load(dsMAIN, null);
		var myObject = new Object;
		myObject.RESULT = "변경완료";
		myObject.MAKE_COMP_CODE = dsMAIN.NameString(1,"MAKE_COMP_CODE");
		myObject.MAKE_DT_TRANS = dsMAIN.NameString(1,"MAKE_DT_TRANS");
		myObject.MAKE_DT = dsMAIN.NameString(1,"MAKE_DT");
		myObject.MAKE_SEQ = dsMAIN.NameString(1,"MAKE_SEQ");
		myObject.SLIP_KIND_TAG = dsMAIN.NameString(1,"SLIP_KIND_TAG");
		window.returnValue = myObject;
		window.close();
	}

	function btnKEEP_DT_onClick()
	{
		C_Calendar("KEEP_DT", "D", txtKEEP_DT.value);
		S_nextFocus(btnKEEP_DT);
	}

	function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
	{
		if (asCalendarID == "KEEP_DT")
		{
			txtKEEP_DT.value = asDate;
		}
	}

//-->
</script>
		<!--사업장목록 Dataset-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsEXEC_PROC classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
		<param name="KeyValue" value="<%=strUpdateKeyValue%>">
		<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
	</head>
	<body onload="C_Initialize();">
		<TABLE id="tableMain" cellSpacing="0" cellPadding="0" width="398" height="180" border="0">
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
											<td class="title_default">전표일자변경</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr >
								<td height="100%" width="100%" bgcolor="#CCCCCC">
									<table width="100%" height="80%" border="1" cellspacing="0" cellpadding="0">
										<tr  bgcolor="ECECEC">
											<td align="center" bgcolor="ECECEC">
												<!-- 등록 시작 //-->
												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="50"> &nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">전표번호</td>
														<td width="160">
															<input id="txtMAKE_SLIPNO" type="text" left class="ro" readOnly="true" value='<%=strMAKE_SLIPNO%>' style="width:160px">
														</td>
														<td> &nbsp;</td>
													</TR>
												</TABLE>

												<TABLE width="100%" height="30" cellSpacing="0" cellPadding="0" border="0" >
													<TR>
														<td width="50"> &nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60">변경일자</td>
														<td width="80">
															<input id="txtKEEP_DT" type="text" center datatype="DATE" style="width:80px" value="<%=strMAKE_DT%>">
														</td>
														<!--
														<td width="*">
															<input id="btnKEEP_DT" type="button" class="img_btnCalendar_S" onClick="btnKEEP_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														-->
													<td> &nbsp;</td>
													</TR>
												</TABLE>
												<!-- 검색어 종료 //-->
											</td>
										</tr>
										<tr>
											<td height="5" bgcolor="ECECEC"></td>
										</tr>
									</table>
									<table width="100%" height="20%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="right" bgcolor="ECECEC">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<TR >
														<td align="right">
															<input name="btnSch2" 		  type="button" class="img_btn4_1" onclick="imgOk_onClick();" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="변경" />
															<input name="btnSch3" 		  type="button" class="img_btn4_1" onclick="imgCancle_onClick();" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="닫기" />
														</td>
														<td width="10"> &nbsp;</td>
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
