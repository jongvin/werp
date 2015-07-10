<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFNpItrAmtWorkR.jsp(유가증권미수이자전표발행)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-26)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFNpItrAmtWorkR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	CITData		lrArgData = null;
	String		strCombo = "";
	String		strCombo2 = "";
	String		strYM_F = "";
	String		strYM_T = "";
	String		strCOMP_CODE = "";
	String		strDEPT_CODE = "";
	String		strCOMPANY_NAME = "";
	String		strUserNo = "";
	String		strNAME = "";

	try
	{
		CITCommon.initPage(request, response, session);

		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strNAME = CITCommon.NvlString(session.getAttribute("name"));

		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));

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

		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select"+"\n"+
				"	a.COMP_CODE CODE,"+"\n"+
				"	a.COMPANY_NAME NAME,"+"\n"+
				"	2 SEQ"+"\n"+
				"From	T_COMPANY_ORG a"+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	'%',"+"\n"+
				"	'전체',"+"\n"+
				"	1"+"\n"+
				"From	Dual"+"\n"+
				"Order By"+"\n"+
				"	3,1";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
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
				"	a.COST_DEPT_KND_TAG CODE,"+"\n"+
				"	a.COST_DEPT_KND_NAME NAME,"+"\n"+
				"	a.PRT_SEQ"+"\n"+
				"From	T_COST_DEPT_KIND a"+"\n"+
				"Order By"+"\n"+
				"	a.PRT_SEQ"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo2 = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select To_Char(Trunc(Sysdate,'YYYY'),'YYYY-MM') YM_F, To_Char(Trunc(Sysdate,'MM'),'YYYY-MM') YM_T From Dual ";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strYM_F = lrReturnData.toString(0,"YM_F");
			strYM_T = lrReturnData.toString(0,"YM_T");
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
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsWORK_NO" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsDATE" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsMAKE" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transMAKE"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsMAKE=dsMAKE)">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
			<param name=Parameter  value="ACT=MAKE">
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
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line"> 
								<td width="*" height="0"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="58" class=font_green_bold>작업년월</td>
											<td width="52">
												<input id="txtYM_F" type="text" DATATYPE="DATEYM"  style="width:50px" value="<%=strYM_F%>">
											</td>
											<td width="20"><input id="btnBUDG_YYYY_MM_FR" type="button" class="img_btnCalendar_S" title="달력" onclick="btnBUDG_YYYY_MM_FR_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width="5">
												~&nbsp;
											</td>
											<td width="52">
												<input id="txtYM_T" type="text" DATATYPE="DATEYM"   style="width:50px" value="<%=strYM_T%>">
											</td>
											<td width="20"><input id="btnBUDG_YYYY_MM_TO" type="button" class="img_btnCalendar_S" title="달력" onclick="btnBUDG_YYYY_MM_TO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
											<td width=*>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="*" height="3"></td>
							</tr>
						</table>
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
				<tr> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="30%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 전표발행작업 목록</td>
														<td align="right" width="*">
															<input id="btnShowSlip" type="button" class="img_btn6_1" value="전표보기" title="" onclick="btnShowSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															&nbsp;&nbsp;
															<input id="btnMakeSlip" type="button" class="img_btn6_1" value="전표발행" title="" onclick="btnMakeSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnRemoveSlip" type="button" class="img_btn6_1" value="전표삭제" title="" onclick="btnRemoveSlip_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<C> Name=발행일 ID=WORK_DT Align=Center Width=90 EditStyle=Popup
														</C>
														<C> Name=작업내용 ID=DESCRIPTION Align=Left  Width=260
														</C>
														<G> Name='이자계산기간' ID=G1
														<C> Name=시작일 ID=CALC_DT_FROM Align=Center Width=90 EditStyle=Popup
														</C>
														<C> Name=종료일 ID=CALC_DT_TO Align=Center Width=90 EditStyle=Popup
														</C>
														</G>
														<C> Name='작업대상사업장' ID=TARGET_COMP_CODE	 EditStyle=Combo Data='<%=strCombo%>' Align=Left Width=160
														</C>
														<C> Name=미수이자금액 ID=NP_ITR_AMT Width=100
														</C>
														<C> Name=전표번호 ID=MAKE_SLIPNO Width=120
														</C>
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
							<tr>
								<td width="100%" height="70%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 집계대상 유가증권 목록</td>
														<td align="right" width="*">
															<input id="btnMakeData" type="button" class="img_btn6_1" value="대상선정" title="" onclick="btnMakeData_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnCalcItr" type="button" class="img_btn6_1" value="이자 재계산" title="" onclick="btnCalcItr_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsSUB01">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="ViewSummary" VALUE="1">
													<PARAM NAME="Format" VALUE="
														<C> Name='사업장' ID=COMPANY_NAME Width=120
														</C>
														<C> Name=증권번호 ID=REAL_SECU_NO Align=Center Width=120
														</C>
														<C> Name='유가증권구분' ID=SEC_KIND_NAME Align=Left  Width=100
														</C>
														<C> Name='발행일' ID=PUBL_DT Align=Center  Width=100
														</C>
														<C> Name='만기일' ID=EXPR_DT Align=Center  Width=100
														</C>
														<C> Name='취득일' ID=GET_DT Align=Center  Width=100
														</C>
														<C> Name='증권금액' ID=PERSTOCK_AMT   Width=100 SumText=@Sum
														</C>
														<C> Name='이율' ID=INTR_RATE   Width=90
														</C>
														<C> Name='미수이자금액' ID=NP_ITR_AMT   Width=100 SumText=@Sum
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