<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFinSecurtyR.jsp(유가증권현황)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 유가증권현황조회
/* 4. 변  경  이  력 : 한재원 작성(2005-12-07)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
	String strDate = CITDate.getNow("yyyy-MM-dd");
//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strFileName = "./t_WFinSecurtyR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String	strCombo = "";
	String	strCombo2 = "";
	String	strDfltKindCode = "";
	String	strDTF = "";
	String	strDTT = "";
	String strUserNo = "";
	CITData		lrArgData = null;
	try
	{
		CITCommon.initPage(request, response, session);
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);

				strSql = " select a.COMP_CODE,b.COMPANY_NAME from t_dept_code a,t_company b where a.DEPT_CODE = ? and a.COMP_CODE = b.COMP_CODE (+) ";

				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
					strCOMPANY_NAME = lrReturnData.toString(0,"COMPANY_NAME");

					session.setAttribute("comp_code", strCOMP_CODE);
					session.setAttribute("comp_name", strCOMPANY_NAME);
				}

			}
			catch (Exception ex)
			{
				throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
			}
		}
		else
		{
			strCOMPANY_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
		}
		//사업장 설정 종료
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select "+"\n"+
				"	1 SEQ,"+"\n"+
				"	a.SEC_KIND_CODE CODE,"+"\n"+
				"	a.SEC_KIND_NAME NAME"+"\n"+
				"From	T_FIN_SEC_KIND a"+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	2 SEQ,"+"\n"+
				"	'%' CODE,"+"\n"+
				"	'전체' NAME"+"\n"+
				"From	Dual"+"\n"+
				"Order By 1,2";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select "+"\n"+
				"	1 SEQ,"+"\n"+
				"	a.SEC_KIND_CODE CODE,"+"\n"+
				"	a.SEC_KIND_NAME NAME"+"\n"+
				"From	T_FIN_SEC_KIND a"+"\n"+
				"Order By 1,2";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo2 = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			strDfltKindCode = lrReturnData.toString(0,"CODE");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select"+"\n"+
				"	F_T_DATETOSTRING(Add_Months(Sysdate,-1)) DTF,"+"\n"+
				"	F_T_DATETOSTRING(Sysdate) DTT"+"\n"+
				"From	Dual "+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDTF = lrReturnData.toString(0,"DTF");
			strDTT = lrReturnData.toString(0,"DTT");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
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
		<script language="javascript" src="../script/Gauce.js"></script>
		<script language="javascript" src="../script/DefaultActions.js"></script>
		<script language="javascript" src="<%=strFileName%>.js"></script>
		<script language="javascript">
		<!--
			var 		oldData1 = "";
			var			oldData2 = "";
			var			vDate = "<%=strDate%>";
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDfltCode = "<%=strDfltKindCode%>";
			var			sDTF = "<%=strDTF%>";
			var			sDTT = "<%=strDTT%>";
			var			sEmpNo = "<%=strUserNo%>";

			// 이벤트관련-------------------------------------------------------------------//

		//-->
		</script>

		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSECU_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsITR_CALC_NO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsITR_AMT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsREMOVE_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transREMOVE_SLIP"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsREMOVE_SLIP=dsREMOVE_SLIP)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=DVD">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<!-- 조건 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
							<tr>
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >사업장</td>
											<td width="72">
												<input id="txtCOMP_CODE" type="text" style="width:70px"  onfocus="txtCOMP_CODE_onfocus()"  onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="*">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>

										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >구분</td>
											<td width="290" class="font_green_bold" >
												<select  name="cboSECU_KIND_CODE"  style="WIDTH: 220px" onchange="cboSECU_KIND_CODE_onChange()">
													<%=strCombo%>
												</select>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="72" class="font_green_bold" >
												<select  name="cboDATE_CLS"  style="WIDTH: 70px" onchange="cboDATE_CLS_onChange()">
													<OPTION value="A" SELECTED> 발행일</OPTION>
													<OPTION value="B"> 만기일</OPTION>
												</select>
											</td>

											<td width="72">
												<input id="txtDATE_FROM" type="text" style="width:70px"  Datatype="date">
											</td>
											<td width=22>
												<input id="btnDATE_FROM" type="button" class="img_btnCalendar_S" title="달력" onclick="btnDATE_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="20">&nbsp;~&nbsp; </td>
											<td width="72">
												<input id="txtDATE_TO" type="text" style="width:70px"  Datatype="date">
											</td>
											<td width=*>
												<input id="btnDATE_TO" type="button" class="img_btnCalendar_S" title="달력" onclick="btnDATE_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>

										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line">
								<td width="*" height="1"></td>
							</tr>
						</table>
						<!-- 조건 테이블 종료 //-->
						<!-- 간격조정 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="5"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 종료 //-->
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top">
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20">&nbsp;</td>
														<td class="font_green_bold">&nbsp;</td>
														<td align="right" width="*">
															<input id="btnMakeInSlip" type="button" class="img_btn6_1" value="매입전표발행" title="" onclick="btnMakeInSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnShowInSlip" type="button" class="img_btn6_1" value="매입전표보기" onclick="btnShowInSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRemoveSlip" type="button" class="img_btn6_1" value="매입전표삭제" title="" onclick="btnRemoveSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnMakeInItrSlip" type="button" class="img_btn8_1" value="선취이자전표발행" title="" onclick="btnMakeInItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnShowInItrSlip" type="button" class="img_btn8_1" value="선취이자전표보기" onclick="btnShowInItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRemoveItrSlip" type="button" class="img_btn8_1" value="선취이자전표삭제" title="" onclick="btnRemoveItrSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 유가증권현황 내역</td>
														<td align="right" width="*">
															<input id="btnMakeReturnSlip" type="button" class="img_btn6_1" value="상환전표발행" title="" onclick="btnMakeReturnSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnMakeSaleSlip" type="button" class="img_btn6_1" value="매각전표발행" title="" onclick="btnMakeSaleSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnShowRetSlip" type="button" class="img_btn10_1" value="상환(매각)전표보기" onclick="btnShowRetSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRemoveReturnSlip" type="button" class="img_btn10_1" value="상환(매각)전표삭제" title="" onclick="btnRemoveReturnSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<FC> Name=유가증권구분 		ID=SEC_KIND_CODE	Width=120 EditStyle=Combo Data='<%=strCombo2%>'
														</FC>
														<FC> Name=증권번호 		ID=REAL_SECU_NO		Width=120
														</FC>
														<C> Name='수탁은행' 		ID='CONSIGN_BANK'			Align=Center	 Width=70
														</C>
														<C> Name='은행명' 		ID='BANK_NAME'			Width=160
														</C>
														<C> Name=발행일 		ID=PUBL_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=만기일 		ID=EXPR_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=증권금액 		ID=PERSTOCK_AMT		Width=95 SumText=@sum
														</C>
														<C> Name=취득일 		ID=GET_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=취득처 		ID=GET_PLACE			 Width=160
														</C>
														<C> Name=취득금액 		ID=INCOME_AMT		Width=95 SumText=@sum
														</C>
														<C> Name=선취이자 		ID=BF_GET_ITR_AMT	Width=95 SumText=@sum
														</C>
														<C> Name=선취이자법인세 		ID=BF_GET_ITR_TAX	Width=95 SumText=@sum
														</C>
														<C> Name=이율 			ID=INTR_RATE	    Width=80
														</C>
														<C> Name=상환일 		ID=RETURN_DT		Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=매각일 		ID=SALE_DT			Align=Center	 Width=70 EditStyle=Popup
														</C>
														<C> Name=매각금액 		ID=SALE_AMT			Width=95 SumText=@sum
														</C>
														<C> Name='상환/매각시이자' 		ID=SALE_ITR_AMT			Width=95 SumText=@sum
														</C>
														<C> Name=매각시미수이자 		ID=SALE_NP_ITR_AMT			Width=95 SumText=@sum
														</C>
														<C> Name='상환/매각법인세' 		ID=SALE_TAX			Width=95 SumText=@sum
														</C>
														<C> Name=처분손실 		ID=SALE_LOSS			Width=95 SumText=@sum
														</C>
														<C> Name=매입전표번호 	    ID=MAKE_SLIPNO		Width=120
														</C>
														<C> Name=선취이자전표번호 	    ID=PRE_ITR_SLIPNO		Width=120
														</C>
														<C> Name=상환전표번호 	    ID=RE_MAKE_SLIPNO		Width=120
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
											</td>
										</tr>
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="50%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 유가증권 (미수)이자 내역</td>
														<td align="right" width="*">
															&nbsp;
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB01">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ViewSummary" VALUE="1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<C> Name=이자구분 		ID=KIND_TAG	Width=120 EditStyle=Combo Data='1:미수이자,2:이자수익'
														</C>
														<C> Name=시작일 		ID=CALC_DT_FROM			Align=Center	 Width=90 EditStyle=Popup
														</C>
														<C> Name=계상일 		ID=CALC_DT_TO			Align=Center	 Width=90 EditStyle=Popup
														</C>
														<C> Name=미수이자금액 		ID=NP_ITR_AMT		Width=100 SumText=@sum
														</C>
														<C> Name=이자수익금액 		ID=ITR_AMT		Width=100 SumText=@sum
														</C>
														<C> Name=비고 		ID=REMARKS		Width=260
														</C>
														<C> Name=전표번호 		ID=MAKE_SLIPNO		Width=120
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
											</td>
										</tr>
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- 프로그래머 디자인 종료 //-->
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!-- 가우스 Bind 객체정의 종료 //-->
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