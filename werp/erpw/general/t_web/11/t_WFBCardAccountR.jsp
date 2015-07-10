<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFBCardAccountR.jsp(법인카드정산등록)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 법인카드정산등록
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strFileName = "./t_WFBCardAccountR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCombo = "";
	String strDTF = "";

	String strCOMP_CODE = "";
	String strCOMP_NAME = "";
	String strDEPT_CODE = "";
	String strEMP_NO = "";
	String strNAME = "";
	String strDt_Trans = CITDate.getNow("yyyyMMdd");
	String strDate = CITDate.getNow("yyyy-MM-dd");

	String strDEPT_NAME = "";
	
	String strCHARGE_PERS = "";
	String strCHARGE_PERS_NAME = "";

	String strINOUT_DEPT_CODE = "";
	String strINOUT_DEPT_NAME = "";

	String strSLIP_TRANS_CLS = "";
	String strDEPT_CHG_CLS = "";

	String strWORK_CODE = "FBS_000002";


	//사용자
	strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
	strNAME = CITCommon.NvlString(session.getAttribute("name"));

	try
	{
		CITCommon.initPage(request, response, session);
		CITData	lrArgData = new CITData();
		try
		{
			lrArgData.addColumn("EMP_NO",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMP_NO", strEMP_NO);
		
			strSql =
				"Select Distinct"+"\n"+
				"	a.CARDNUMBER CODE,"+"\n"+
				"	a.CARDNUMBER||' '||b.NAME NAME"+"\n"+
				"From	T_CARD_MEMBER_HISTORY a ,"+"\n"+
				"     Z_AUTHORITY_USER      b  "+"\n"+
				"Where	a.CARDOWNEREMPNO  = b.EMPNO "+"\n"+
				"And    To_Char(Sysdate,'YYYYMMDD') Between a.USESTARTDATE And a.USEENDDATE"+"\n"+
				"And		? In ( a.CARDOWNEREMPNO,a.CARDSUBSTITUTEEMPNO)"+"\n";
				
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
				"Select"+"\n"+
				"	to_char(sysdate ,'yyyy')||'-'||to_char(sysdate ,'MM') DTF "+"\n"+
				"From	Dual "+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDTF = lrReturnData.toString(0,"DTF");
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

	//사업장 설정
	strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
	strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
	strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));
	
	//권한
	strSLIP_TRANS_CLS = CITCommon.NvlString(session.getAttribute("slip_trans_cls"));
	strDEPT_CHG_CLS = CITCommon.NvlString(session.getAttribute("dept_chg_cls"));
	try
	{
		CITData		lrArgData = new CITData();
		lrArgData.addColumn("WORK_CODE",CITData.VARCHAR2);
		lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
		lrArgData.addRow();
		lrArgData.setValue("WORK_CODE", strWORK_CODE);
		lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
		
		strSql  = " Select	a.COMP_CODE, \n";
		strSql += " 		b.COMPANY_NAME, \n";
		strSql += " 		b.DEPT_CODE INOUT_DEPT_CODE , \n";
		strSql += " 		c.DEPT_NAME INOUT_DEPT_NAME , \n";
		strSql += " 		a.TAX_COMP_CODE TAX_COMP_CODE, \n";
		strSql += " 		d.COMPANY_NAME TAX_COMP_NAME, \n";
		strSql += " 		e.CHARGE_PERS , \n";
		strSql += " 		e.CHARGE_PERS_NAME \n";
		strSql += " From	T_DEPT_CODE a, \n";
		strSql += " 		T_COMPANY b, \n";
		strSql += " 		T_DEPT_CODE c, \n";
		strSql += " 		T_COMPANY d, \n";
		strSql += " ( \n";
		strSql += " 	SELECT \n";
		strSql += " 		A.COMP_CODE, \n";
		strSql += " 		A.CHARGE_PERS, \n";
		strSql += " 		B.NAME CHARGE_PERS_NAME \n";
		strSql += " 	FROM \n";
		strSql += " 		T_WORK_CHARGE_PERS A, \n";
		strSql += " 		Z_AUTHORITY_USER B \n";
		strSql += " 	WHERE \n";
		strSql += " 		A.CHARGE_PERS = B.EMPNO \n";
		strSql += " 		AND A.WORK_CODE = :WORK_CODE \n";
		strSql += " ) e \n";
		strSql += " Where	a.DEPT_CODE =  ?   \n";
		strSql += " And		a.COMP_CODE = b.COMP_CODE(+) \n";
		strSql += " And		b.DEPT_CODE = c.DEPT_CODE(+) \n";
		strSql += " And		a.TAX_COMP_CODE = d.COMP_CODE(+) \n";
		strSql += " And		a.COMP_CODE = e.COMP_CODE(+) \n";



		lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		if(lrReturnData.getRowsCount() >= 1)
		{
			strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
			strCOMP_NAME = lrReturnData.toString(0,"COMPANY_NAME");
			strINOUT_DEPT_CODE = lrReturnData.toString(0,"INOUT_DEPT_CODE");
			strINOUT_DEPT_NAME = lrReturnData.toString(0,"INOUT_DEPT_NAME");
			strCHARGE_PERS = lrReturnData.toString(0,"CHARGE_PERS");
			strCHARGE_PERS_NAME = lrReturnData.toString(0,"CHARGE_PERS_NAME");

			session.setAttribute("comp_code", strCOMP_CODE);
			session.setAttribute("comp_name", strCOMP_NAME);
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
			var			sCompName = "<%=CITCommon.enSC(strCOMP_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDTF = "<%=strDTF%>";

			var			vWORK_CODE = "<%=strWORK_CODE%>";

			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sDt_Trans = "<%=strDt_Trans%>";
			var			sDate = "<%=strDate%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=strCOMP_NAME%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=strDEPT_NAME%>";
			var			sInout_DeptCode = "<%=strINOUT_DEPT_CODE%>";
			var			sInout_DeptName = "<%=strINOUT_DEPT_NAME%>";
			var			sEmpno = "<%=strEMP_NO%>";
			var			sName = "<%=strNAME%>";
			var			sSlip_Trans_Cls = "<%=strSLIP_TRANS_CLS%>";
			var			sDept_Chg_Cls = "<%=strDEPT_CHG_CLS%>";
			
			var			vWORK_CODE = "<%=strWORK_CODE%>";
			
			var			sCHARGE_PERS = "<%=strCHARGE_PERS%>";
			var			sCHARGE_PERS_NAME = "<%=strCHARGE_PERS_NAME%>";
			// 이벤트관련-------------------------------------------------------------------//

		//-->
		</script>

		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsDAY_CLOSE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsAUTO_FBS_CARD_ACNT_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsACCT_CHK classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	    <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
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
											<td width="70" class="font_green_bold" >카드번호</td>
											<td width="240" class="font_green_bold" align="left" >
												<select  name="cboCARDNUMBER"  style="WIDTH: 220px" >
													<%=strCombo%>
												</select>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="70" class="font_green_bold" >결제일자</td>
											<td width="72">
												<input id="txtDATE_FROM" type="hidden" style="width:70px" datatype="DATEYM" >
												<input id="txtDATE_DISPLAY" type="text" style="width:70px" datatype="date" onchange="txtDATE_DISPLAY_onChange()">
											</td>
											<td width=22>
												<input id="btnDATE_FROM" type="button" class="img_btnCalendar_S" title="달력" onclick="btnDATE_FROM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
                      <td>&nbsp; </td>
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
					<td width="100%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- 프로그래머 수정 시작 //-->
										<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
										<td class="font_green_bold"> 전표발행정보</td>
										<td align="right">
<input id="btnSlipCreate" type="button" class="img_btn6_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="자동전표생성" onclick="btnSlipCreate_onClick()"/>
<input id="btnSlipDelete" type="button" class="img_btn6_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="자동전표삭제" onclick="btnSlipDelete_onClick()"/>
										</td>

										<!-- 프로그래머 수정 종료 //-->
									</tr>
								</table>
								<!-- 서브 타이틀 종료 //-->
								<!-- 서브 본문 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
												<tr>
													<td bgcolor="#FFFFFF">
													<!-- 프로그래머 디자인 시작 //-->
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="70">전표일자</td>
																<td width="78">
																	<input id="txtSLIP_MAKE_DT_F"	type="hidden"/>
																	<input id="txtSLIP_MAKE_DT"	type="text" datatype="date" style="width:77px"/>
																</td>
																<td width="21">
																	<input id="btnSLIP_MAKE_DT" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnSLIP_MAKE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width=27">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >사 업 장</td>
																<td width="102">
																	<input id="txtSLIP_MAKE_COMP_CODE"	type="hidden"/>
																	<input id="txtSLIP_MAKE_COMP_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
																</td>
																<td width="38">
																	<input name="btnSLIP_MAKE_COMP_CODE"	type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_MAKE_COMP_CODE_onClick()" title="사업장찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >작성부서</td>
																<td width="122">
																	<input id="txtSLIP_MAKE_DEPT_CODE"	type="hidden"/>
																	<input id="txtSLIP_MAKE_DEPT_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:120px"/>
																</td>
																<td width="40">
																	<input name="btnSLIP_MAKE_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_MAKE_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="작성부서찾기" />
																</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="15">&nbsp;</td>
																<td width="70">&nbsp;</td>
																<td width="126">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >관리담당</td>
																<td width="102">
																	<input id="txtSLIP_CHARGE_PERS"		type="hidden"/>
																	<input id="txtSLIP_CHARGE_PERS_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
																</td>
																<td width="38">
																	<input name="btnCHARGE_PERS" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_CHARGE_PERS_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="관리담당찾기" />
																</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >출납부서</td>
																<td width="122">
																	<input id="txtSLIP_INOUT_DEPT_CODE"	type="hidden"/>
																	<input id="txtSLIP_INOUT_DEPT_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:120px"/>
																</td>
																<td width="40">
																	<input name="btnSLIP_INOUT_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_INOUT_DEPT_CODE_onClick()" title="출납부서찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="80">지급희망일</td>
																<td width="78">
																	<input id="txtPAYHOPEDATE_F"	type="hidden"/>
																	<input id="txtPAYHOPEDATE"		type="text" datatype="date" style="width:77px"/>
																</td>
																<td width="21">
																	<input id="btnPAYHOPEDATE" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnPAYHOPEDATE_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														<!-- 프로그래머 디자인 종료 //-->
													</td>
												</tr>
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>

					</td>
				</tr>

				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top">
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 법인카드청구내역</td>
														<td align="right" width="*">
<input id="btnBUDG"				type="button" tabindex="-1" class="img_btn6_1" onClick="btnBUDG_onClick()"			value="예산실적조회" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />														
<input name="btnSlipRetrieve" type="button" class="img_btn6_1" onclick="btnSlipRetrieve_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전 표 조 회" />
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="일 괄 선 택" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="일괄선택취소" />
<!--<input id="btnCARD_FINISH"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnCARD_FINISH_onClick()"value="정산완료" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />//-->
<!--												<input id="btnCARD_PRINT" 	type="button" tabindex="-1" class="img_btn4_1" onClick="btnCARD_PRINT_onClick()" 	value="출력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />//-->
														</td>
													</tr>
												</table>
									<!-- SUM 테이블 시작 //-->
									<!-- 간격조정 테이블 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="5"></td>
										</tr>
									</table>
									<!-- 간격조정 테이블 종료 //-->	
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line"> 
											<td width="*" height="1"></td>
										</tr>
										<tr> 
											<td width="100%"  style="background:#F6F6F6">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td >
															<!-- 프로그래머 디자인 시작 //-->
															<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="black">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >총금액</td>
																	<td width="165">
																	<input name="txtTOTAL_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>													
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="84" >미처리금액</td>
																	<td width="165">
																	<input name="txtNOUSE_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC"  ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >법인분</td>
																	<td width="165">
																	<input name="txtCOMPANY_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >개인분</td>
																	<td width="165">
																	<input name="txtPERSON_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>																	
																	<td>&nbsp; </td>			
																</tr>
															</table>
															<!-- 프로그래머 디자인 종료 //-->
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
									<!-- SUM 테이블 종료 //-->												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="100%">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
<FC> Name=선택	ID=SELECT_YN	Align=Center	EditStyle=CheckBox	Width=30	</FC>
<FC> Name=발행	ID=MAKE_CLS		Align=Center	EditStyle=CheckBox	Width=30	Edit='none'	</FC>
<FC> Name=확정	ID=KEEP_CLS		Align=Center	EditStyle=CheckBox	Width=30	Edit='none'	</FC>
<FC> Name=카드번호 		ID='CARDNUMBER'	Align=Center	Width=100 						</FC>
<FC> Name=정산년월 		ID='ADJUSTYEARMONTH'	Align=Center	Width=100  show=false	</FC>
<FC> Name=세부일련번호  ID='ACCTSUBSEQ'	Align=Center	Width=160 		 show=false		</FC>
<C> Name='승인일시' 	ID='USE_DATE_TIME'			Align=Center	 Width=120			</C>
<C> Name='청구금액' 	ID='AMT'			Width=80   									</C>
<C> Name='공급가액' 	ID='SUPPLYAmt'			Width=80   									</C>
<C> Name='부가세' 	  ID='VatAmt'			Width=80   									</C>
<C> Name='이용처' 		ID=MERCHANTNAME		Width=140 									</C>
<C> Name='지급희망일' ID='PAYHOPEDATE'	Align=Center	 Width=70			show=false </C>
<C> Name='처리기준' 	ID=USAGEGUBUN		Align=Center	 Width=70 EditStyle=Combo Data='P:개인분,C:법인분,1:미처리'	</C>
<C> Name='귀속부서' 	ID=DEPT_NAME			Width=160 </C>
<C> Name='비용계정' 	ID=ACC_NAME			Width=160 </C>
<C> Name='부가세계정'	ID=VAT_ACC_NAME		Width=160 </C>
<C> Name='승인번호' 	ID=APPROVALNumber	Width=100   </C>
<C> Name='업종' 	    ID=MCCName		Width=100         </C>
<C> Name='과세유형' 	ID=TAXGubun		Width=70 	</C>
<C> Name=전표번호 ID=MAKE_SLIPNO  Align=Center Edit='none'  Width=90</C>													
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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