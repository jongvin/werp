<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WWorkCodeR.jsp(자동전표코드등록)
/* 2. 유형(시나리오) : 화면 디자인
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WTaxAccountTotalPrint";
	String strFileName01 = "t_WTaxAccountTotalPrint";
	String strReportName = "r_t_06000X";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02)";

	String strDate = CITDate.getNow("yyyy-MM-dd");

	String strOut = "";
	String strSql = "";
	String strAct = "";

	String strCOMP_CODE = "";
	String strCOMPANY_NAME = "";
	
	String cboTAX_YEAR = "";

	String cboRCPTBILL_CLS = "";

	try
	{
		CITCommon.initPage(request, response, session);
		
		CITData lrArgData = new CITData();		

		//세무신고기수 - 년도
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TAX_YEAR' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			cboTAX_YEAR = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//계산서구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where a.CODE_GROUP_ID = 'RCPTBILL_CLS' \n";
			strSql += "And	a.CODE_LIST_ID IN ('01','02') \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			cboRCPTBILL_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", CITCommon.NvlString(session.getAttribute("dept_code")));
				
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
var sSelectPageName = "<%=strFileName%>_q.jsp";
var sSelectPageName_c = "<%=strFileName%>_c.jsp";
var	sReportName = "<%=strReportName%>";
var	sCompCode = "<%=strCOMP_CODE%>";
var	sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
var	vDate = "<%=strDate%>";
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--세금계산서 합계표 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST02_1 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--세금계산서 합계표 매출 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST02_2 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--세금계산서 합계표 매출합계 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST02_3 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--세금계산서 합계표 매입 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST02_4 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--세금계산서 합계표 매입합계 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST02_5 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--계산서 합계표 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST03_1 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--계산서 합계표 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST03_2 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--계산서 합계표 매출합계 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST03_3 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--계산서 합계표 매출 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST03_4 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--계산서 합계표 매입합계 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST03_5 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--계산서 합계표 매입 Dataset-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLIST03_6 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" value="-1">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<param name="KeyValue" value="<%=strUpdateKeyValue%>">
	<param name="Action"    value="<%=strFileName%>_tr.jsp">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<form name="form1" target="hidden_frame_" method="post">
		</form>
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strFileName01%>">
			<input type='hidden' name='REQUEST_NAME' value="">
			<Input type='hidden' name='REPORT_NO' value="">
			<Input type='hidden' name='REPORT_FILE_NAME' value="">
			<Input type='hidden' name='PARAMETERS' value="">
		</form>
		<div id="divMainFix" class="main_div">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
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
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>세무사업장</td>
		<td width="62">
			<input id="txtCOMP_CODE" type="text" style="width:60px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="161">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="40">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="찾색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >작업일자</td>
		<td width="72"><input id="txtWRITE_DT" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnWRITE_DT" type="button" class="img_btnCalendar_S" onClick="btnWRITE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >연 도</td>
		<td width="80">
			<select id="cboTAX_YEAR" name="cboTAX_YEAR" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default" onchange="dsMAIN.ResetStatus();G_Load(dsMAIN);">
			<!--
			<option value='%'>전  체</option>
			-->
			<%=cboTAX_YEAR%>
			</select>
		</td>
		<td width="10">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >신고기수</td>
		<td width="118">
			<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id="cboTAX_WORK"  style="width:100" classid=clsid:60109D65-70C0-425c-B3A4-4CB001513C69 VIEWASTEXT >
				<PARAM NAME="ComboStyle" VALUE="5">
				<PARAM NAME="ComboDataID" VALUE="dsMAIN">
				<PARAM NAME="EditExprFormat" VALUE="%;WORK_NAME">
				<PARAM name="ListExprFormat" value="%;WORK_NAME">
				<PARAM NAME="Index" VALUE="0">
				<PARAM NAME="Sort" VALUE="0">
				<PARAM NAME="SearchColumn" VALUE="WORK_NO">
			</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		</td>
		<td width="10">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >계산서구분</td>
		<td width="130">
			<select id="cboRCPTBILL_CLS" style="WIDTH: 130px" tabindex="-1" class="input_listbox_default">			<%=cboRCPTBILL_CLS%>
			</select>
		</td>
		<td width="*">&nbsp;</td>
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
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top" height="*"> 
					<td width="100%" height="35%">
<div id="divMain01">
								<!-- 서브 타이틀 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<!-- 프로그래머 수정 시작 //-->
													<td width="15" height="20"><img src="../images/bullet1.gif"></td>
													<td class="font_green_bold">세금계산서 합계표</td>
													<td align="right">
&nbsp;
<input name="btnAllSelect" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전산매체생성" onclick="btnCrt2_onClick();"/>	
													</td>
													<!-- 프로그래머 수정 종료 //-->
												</tr>
											</table>
										</td>
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
																<td HEIGHT="100%">
																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST02_1 WIDTH="100%" HEIGHT="50" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<PARAM Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM NAME="Format" VALUE="
<C> Name=자료구분 ID=e1 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e2 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=상호 ID=e3 Align=Left HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=성명 ID=e4 Align=Left HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=사업장주소 ID=e5 Align=Left HeadAlign=Center  Width=250
	 Show=true Edit='none'
</C>
<C> Name=업태 ID=e6 Align=Left HeadAlign=Center  Width=80
	 Edit='none'
</C>
<C> Name=종목 ID=e7 Align=Left HeadAlign=Center  Width=80
	Edit='none'
</C>
<C> Name=거래기간 ID=e8 Align=Center HeadAlign=Center  Width=120
	Edit='none'
	Mask='XX.XX.XX~XX.XX.XX'
</C>
<C> Name=작성일자 ID=e9 Align=Center HeadAlign=Center  Width=80
	Edit='none'
	Mask='XX-XX-XX'
</C>
<C> Name=공란 ID=e10 Align=Right HeadAlign=Center  Width=40
	Edit='none'
</C>
																			">
																		<PARAM NAME="DataID" VALUE="dsLIST02_1">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																</td>
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
								<!-- 간격조정 테이블 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- 간격조정 테이블 종료 //-->
								<!-- 서브 타이틀 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr height="23">
										<!-- 프로그래머 수정 시작 //-->
										<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
										<td width="150" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab">
											<a href="javascript:selectTab(1, 4);" onfocus="this.blur()">
												매출자료
											</a>
										</td>
										<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
										<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
										<td width="150" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab">
											<a href="javascript:selectTab(2, 4);" onfocus="this.blur()">
												매입자료
											</a>
										</td>
										<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
										<td width="*" align="right">
											&nbsp;
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
																<td HEIGHT="100%">
																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST02_2 WIDTH="100%" HEIGHT="380" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=자료구분 ID=e1 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e2 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=일련번호 ID=e3 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=거래자등록번호 ID=e4 Align=Center HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>
<C> Name=거래자상호 ID=e5 Align=Left HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>
<C> Name=거래자업태 ID=e6 Align=Left HeadAlign=Center  Width=80
	 Edit='none'
</C>
<C> Name=거래자종목 ID=e7 Align=Left HeadAlign=Center  Width=80
	Edit='none'
</C>
<C> Name=세금계산서매수 ID=e8 Align=Right HeadAlign=Center  Width=100
	Edit='none'
</C>
<C> Name=공란수 ID=e9 Align=Right HeadAlign=Center  Width=80
	Edit='none'
</C>
<C> Name=공급가액 ID=e10 Align=Right HeadAlign=Center  Width=100
	Edit='none'
</C>

																			">
																		<PARAM NAME="DataID" VALUE="dsLIST02_2">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL 지우지마세요//-->


																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__18"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST02_4 WIDTH="100%" HEIGHT="380" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=자료구분 ID=e1 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e2 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=일련번호 ID=e3 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=거래자등록번호 ID=e4 Align=Center HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>
<C> Name=거래자상호 ID=e5 Align=Center HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>
<C> Name=거래자업태 ID=e6 Align=Left HeadAlign=Center  Width=80
	 Edit='none'
</C>
<C> Name=거래자종목 ID=e7 Align=Left HeadAlign=Center  Width=80
	Edit='none'
</C>
<C> Name=세금계산서매수 ID=e8 Align=Right HeadAlign=Center  Width=100
	Edit='none'
</C>
<C> Name=공란수 ID=e9 Align=Right HeadAlign=Center  Width=80
	Edit='none'
</C>
<C> Name=공급가액 ID=e10 Align=Right HeadAlign=Center  Width=100
	Edit='none'
</C>

																			">
																		<PARAM NAME="DataID" VALUE="dsLIST02_4">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__18); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																</td>
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

								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">

												<tr>
													<td bgcolor="#FFFFFF">
														<!-- 프로그래머 디자인 시작 //-->
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td HEIGHT="100%">
																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__19"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST02_3 WIDTH="100%" HEIGHT="80" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=자료구분 ID=e1 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e2 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<G>name={'합계분'} id=id000001
	<C> Name=거래처수 ID=e3 Align=Right HeadAlign=Center  Width=60
		 Show=true Edit='none'
	</C>
	<C> Name=매수 ID=e4 Align=Right HeadAlign=Center  Width=40
		 Show=true Edit='none'
	</C>
	<C> Name=공급가액 ID=e5 Align=Right HeadAlign=Center  Width=90
		 Show=true Edit='none'
	</C>
	<C> Name=세액 ID=e6 Align=Right HeadAlign=Center  Width=90
		 Edit='none'
	</C>
</G>
<G>name={'사업자번호 발행분'} id=id000002
	<C> Name=거래처수 ID=e7 Align=Right HeadAlign=Center  Width=60
		Edit='none'
	</C>
	<C> Name=매수 ID=e8 Align=Right HeadAlign=Center  Width=40
		Edit='none'
	</C>
	<C> Name=공급가액 ID=e9 Align=Right HeadAlign=Center  Width=90
		Edit='none'
	</C>
	<C> Name=세액 ID=e10 Align=Right HeadAlign=Center  Width=90
		Edit='none'
	</C>
</G>

<G>name={'주민번호 발행분'} id=id000003
	<C> Name=거래처수 ID=e11 Align=Right HeadAlign=Center  Width=60
		Edit='none'
	</C>
	<C> Name=매수 ID=e12 Align=Right HeadAlign=Center  Width=40
		Edit='none'
	</C>
	<C> Name=공급가액 ID=e13 Align=Right HeadAlign=Center  Width=90
		Edit='none'
	</C>
	<C> Name=세액 ID=e14 Align=Right HeadAlign=Center  Width=90
		Edit='none'
	</C>
</G>
																			">
																			<PARAM NAME="DataID" VALUE="dsLIST02_3">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__19); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__20"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST02_5 WIDTH="100%" HEIGHT="80" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=자료구분 ID=e1 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e2 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=거래처수 ID=e3 Align=Right HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=매수 ID=e4 Align=Right HeadAlign=Center  Width=40
	 Show=true Edit='none'
</C>
<C> Name=공급가액 ID=e5 Align=Right HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>
<C> Name=세액 ID=e6 Align=Right HeadAlign=Center  Width=100
	 Edit='none'
</C>

																			">
																		<PARAM NAME="DataID" VALUE="dsLIST02_5">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__20); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																</td>
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
</div>
<div id="divMain02">
								<!-- 서브 타이틀 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<!-- 프로그래머 수정 시작 //-->
													<td width="15" height="20"><img src="../images/bullet1.gif"></td>
													<td class="font_green_bold">계산서 합계표(제출자)</td>
													<td align="right">
&nbsp;
<input name="btnAllSelect" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전산매체생성" onclick="btnCrt2_onClick();"/>
													</td>
													<!-- 프로그래머 수정 종료 //-->
												</tr>
											</table>
										</td>
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
																<td HEIGHT="100%">
																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__21"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST03_1 WIDTH="100%" HEIGHT="50" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM NAME="Format" VALUE="
<C> Name=구분 ID=e1 Align=Center HeadAlign=Center  Width=30
	 Show=true Edit='none'
</C>
<C> Name=세무서 ID=e2 Align=Center HeadAlign=Center  Width=40
	 Show=true Edit='none'
</C>
<C> Name=제출년월일 ID=e3 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>
<C> Name=제출자구분 ID=e4 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e6 Align=Center HeadAlign=Center  Width=70
	 Edit='none'
</C>
<C> Name=법인명 ID=e7 Align=Left HeadAlign=Center  Width=80
	Edit='none'
</C>
<C> Name=법인번호 ID=e8 Align=Center HeadAlign=Center  Width=85
	Edit='none'
</C>
<C> Name=대표자 ID=e9 Align=Left HeadAlign=Center  Width=80
	Edit='none'
</C>
<C> Name=우편번호 ID=e10 Align=Center HeadAlign=Center  Width=60
	Edit='none'
</C>
<C> Name=소재지 ID=e11 Align=Left HeadAlign=Center  Width=60
	Edit='none'
</C>
<C> Name=전화번호 ID=e12 Align=Left HeadAlign=Center  Width=60
	Edit='none'
</C>
<C> Name=제출건수계 ID=e13 Align=Right HeadAlign=Center  Width=65
	Edit='none'
</C>
																			">
																		<PARAM NAME="DataID" VALUE="dsLIST03_1">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__21); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																</td>
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

								<!-- 간격조정 테이블 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- 간격조정 테이블 종료 //-->
								<!-- 서브 타이틀 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr height="23">
										<!-- 프로그래머 수정 시작 //-->
										<td width="6"><img id="imgTabLeft3" src="../images/Content_tab_after_r.gif"></td>
										<td width="150" id="tab3" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab">
											<a href="javascript:selectTab(3, 4);" onfocus="this.blur()">
												매출자료
											</a>
										</td>
										<td width="6"><img id="imgTabRight3" src="../images/Content_tab_back_r.gif"></td>
										<td width="6"><img id="imgTabLeft4" src="../images/Content_tab_after.gif"></td>
										<td width="150" id="tab4" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab">
											<a href="javascript:selectTab(4, 4);" onfocus="this.blur()">
												매입자료
											</a>
										</td>
										<td width="6"><img id="imgTabRight4" src="../images/Content_tab_back.gif"></td>
										<td width="*" align="right">
											&nbsp;
										</td>
										<!-- 프로그래머 수정 종료 //-->
									</tr>
								</table>
								<!-- 서브 타이틀 종료 //-->

								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">

												<tr>
													<td bgcolor="#FFFFFF">
														<!-- 프로그래머 디자인 시작 //-->
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td HEIGHT="100%">
																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__22"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST03_3 WIDTH="100%" HEIGHT="80" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=구분 ID=e1 Align=Center HeadAlign=Center  Width=30
	 Show=true Edit='none'
</C>
<C> Name=자료구분 ID=e2 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=기구분 ID=e3 Align=Center HeadAlign=Center  Width=50
	 Show=true Edit='none'
</C>
<C> Name=신고구분 ID=e4 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=세무서 ID=e5 Align=Center HeadAlign=Center  Width=40
	 Show=true Edit='none'
</C>
<C> Name=일련번호 ID=e6 Align=Right HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e7 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=귀속년도 ID=e8 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=거래시작일 ID=e9 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>
<C> Name=거래시작일 ID=e10 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>
<C> Name=작성일 ID=e11 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>

<G>name={'합계분'} id=id000004
	<C> Name=매출처수 ID=e12 Align=Center HeadAlign=Center  Width=60
		 Show=true Edit='none'
	</C>
	<C> Name=매수 ID=e13 Align=Center HeadAlign=Center  Width=60
		 Show=true Edit='none'
	</C>
	<C> Name=음수표시 ID=e14 Align=Right HeadAlign=Center  Width=80
		 Show=true Edit='none'
	</C>
	<C> Name=매출액 ID=e15 Align=Right HeadAlign=Center  Width=100
		 Edit='none'
	</C>
</G>
<G>name={'사업자번호 발행분'} id=id000005
	<C> Name=매출처수 ID=e16 Align=Left HeadAlign=Center  Width=60
		Edit='none'
	</C>
	<C> Name=매수 ID=e17 Align=Right HeadAlign=Center  Width=60
		Edit='none'
	</C>
	<C> Name=음수표시 ID=e18 Align=Right HeadAlign=Center  Width=80
		Edit='none'
	</C>
	<C> Name=매출액 ID=e19 Align=Right HeadAlign=Center  Width=100
		Edit='none'
	</C>
</G>

<G>name={'주민번호 발행분'} id=id000006
	<C> Name=거래처수 ID=e20 Align=Left HeadAlign=Center  Width=60
		Edit='none'
	</C>
	<C> Name=매수 ID=e21 Align=Right HeadAlign=Center  Width=60
		Edit='none'
	</C>
	<C> Name=음수표시 ID=e22 Align=Right HeadAlign=Center  Width=80
		Edit='none'
	</C>
	<C> Name=매출액 ID=e23 Align=Right HeadAlign=Center  Width=100
		Edit='none'
	</C>
</G>
																			">
																			<PARAM NAME="DataID" VALUE="dsLIST03_3">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__22); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__23"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST03_5 WIDTH="100%" HEIGHT="80" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=구분 ID=e1 Align=Center HeadAlign=Center  Width=30
	 Show=true Edit='none'
</C>
<C> Name=자료구분 ID=e2 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=기구분 ID=e3 Align=Center HeadAlign=Center  Width=50
	 Show=true Edit='none'
</C>
<C> Name=신고구분 ID=e4 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=세무서 ID=e5 Align=Center HeadAlign=Center  Width=40
	 Show=true Edit='none'
</C>
<C> Name=일련번호 ID=e6 Align=Right HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e7 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=귀속년도 ID=e8 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=거래시작일 ID=e9 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>
<C> Name=거래시작일 ID=e10 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>
<C> Name=작성일 ID=e11 Align=Center HeadAlign=Center  Width=70
	 Show=true Edit='none'
</C>

<C> Name=매입처수합계 ID=e12 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=매수 ID=e13 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=음수표시 ID=e14 Align=Right HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=매입액 ID=e15 Align=Right HeadAlign=Center  Width=100
	 Edit='none'
</C>

																			">
																		<PARAM NAME="DataID" VALUE="dsLIST03_5">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__23); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																</td>
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


								<!-- 서브 본문 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td bgcolor="#FFFFFF">
														<!-- 프로그래머 디자인 시작 //-->
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td HEIGHT="100%">
																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__24"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST03_4 WIDTH="100%" HEIGHT="380" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=구분 ID=e1 Align=Center HeadAlign=Center  Width=30
	 Show=true Edit='none'
</C>
<C> Name=자료구분 ID=e2 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=기구분 ID=e3 Align=Center HeadAlign=Center  Width=50
	 Show=true Edit='none'
</C>
<C> Name=신고구분 ID=e4 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=세무서 ID=e5 Align=Center HeadAlign=Center  Width=40
	 Show=true Edit='none'
</C>
<C> Name=일련번호 ID=e6 Align=Right HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e7 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=매출처사업자번호 ID=e8 Align=Center HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>
<C> Name=매출처 ID=e9 Align=Left HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>

<C> Name=매수 ID=e10 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=음수표시 ID=e11 Align=Right HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=매출액 ID=e12 Align=Right HeadAlign=Center  Width=100
	 Edit='none'
</C>
																			">
																		<PARAM NAME="DataID" VALUE="dsLIST03_4">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__24); </script> <!--CONVPAGE_TAIL 지우지마세요//-->


																	<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__25"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridLIST03_6 WIDTH="100%" HEIGHT="380" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																		<Param Name="SortView" VALUE="Left">
																		<PARAM NAME="Editable" VALUE="0">
																		<PARAM NAME="ColSelect" VALUE="0">
																		<PARAM NAME="ColSizing" VALUE="-1">
																		<PARAM name=UsingOneClick value=1>
																		<PARAM NAME="Format" VALUE="
<C> Name=구분 ID=e1 Align=Center HeadAlign=Center  Width=30
	 Show=true Edit='none'
</C>
<C> Name=자료구분 ID=e2 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=기구분 ID=e3 Align=Center HeadAlign=Center  Width=50
	 Show=true Edit='none'
</C>
<C> Name=신고구분 ID=e4 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=세무서 ID=e5 Align=Center HeadAlign=Center  Width=40
	 Show=true Edit='none'
</C>
<C> Name=일련번호 ID=e6 Align=Right HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=사업자번호 ID=e7 Align=Center HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=매입처사업자번호 ID=e8 Align=Center HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>
<C> Name=매입처사업자번호 ID=e9 Align=Center HeadAlign=Center  Width=100
	 Show=true Edit='none'
</C>

<C> Name=매수 ID=e10 Align=Center HeadAlign=Center  Width=60
	 Show=true Edit='none'
</C>
<C> Name=음수표시 ID=e11 Align=Right HeadAlign=Center  Width=80
	 Show=true Edit='none'
</C>
<C> Name=매입액 ID=e12 Align=Right HeadAlign=Center  Width=100
	 Edit='none'
</C>

																			">
																		<PARAM NAME="DataID" VALUE="dsLIST03_6">
																	</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__25); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																</td>
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

</div>
								<!-- 서브 본문 종료 //-->
								<!-- 서브 테이블 종료 //-->
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