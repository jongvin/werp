<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WDeptR(부서코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WSlipLogR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strACC_GRP_CODE = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		try
		{
			CITData lrArgData = new CITData();
			strSql += "SELECT \n";
			strSql += "	''||ACC_GRP_CODE CODE, \n";
			strSql += "	ACC_GRP_NAME NAME \n";
			strSql += "FROM \n";
			strSql += "	T_ACC_GRP \n";
			strSql += "WHERE \n";
			strSql += "	USE_TAG = 'T' \n";
			strSql += "ORDER BY \n";
			strSql += "	ACC_GRP_CODE \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_GRP_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 계정그룹코드1 Select 오류 -> " + ex.getMessage());
		}
		
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
			CITData		lrArgData = new CITData();
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>사업장</td>
		<td width="112">
			<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="161">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="30">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>		
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >전표일자</td>
		<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >작성부서</td>
		<td width="112"> <input name="txtMAKE_DEPT_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtMAKE_DEPT_CODE_onblur()"></td>
		<td width="161"> <input name="txtMAKE_DEPT_NAME" type="text" class="ro" readOnly style="width:160px" VALUE=""></td>
		<td width="40">
			<input name="btnMAKE_DEPT" type="button" class="img_btnFind" onclick="btnMAKE_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15">&nbsp;</td>
		<td width="70" class="font_green_bold" >&nbsp;</td>
		<td width="70">
			&nbsp;
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
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<!-- 서브 테이블 시작 //-->
									<!-- 서브 타이틀 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr height="23">
												<!-- 프로그래머 수정 시작 //-->
											<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
											<td width="80" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a href="javascript:selectTab(1, 2);" onfocus="this.blur()">백업전표목록</a></td>
											<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
											<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
											<td width="100" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(2, 2);" onfocus="this.blur()">전표별 백업목록</a></td>
											<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
											<!-- 프로그래머 수정 종료 //-->
											<td width=*>&nbsp;
											</td>
											<td>
												<div id=divInnerBox1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
											<td align="right" width="*">
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전 체 선 택" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전체선택취소" />
											</td>
														</tr>
													</table>
												</div>
												<div id=divInnerBox2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="*">
																&nbsp;
															</td>
														</tr>
													</table>
												</div>
											</td>

										</tr>
	
									</table>
									<!-- 서브 타이틀 종료 //-->
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
							<tr>
								<td width="100%" height="30%">
						<!-- 첫번째 탭 페이지 시작//-->
						<div id=divTabPage1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="ViewSummary" 	VALUE=0>
										<PARAM NAME="Format" VALUE="
<FC> Name=선택 		ID=CHK_CLS		EditStyle=CheckBox Width=40</FC>
<C> Name=작업일자 	ID=LOG_CRTDATE	Width=80 Align=Center Edit='none'</C>
<C> Name=작업자 	ID=LOG_CRTUSER_NAME Width=60 Align=Left Edit='none'</C>
<C> Name=상태		ID=UPDATE_CLS	Width=60 Align=Center Edit='none' EditStyle=Combo Data='1:수정,2:확정,3:확정취소,4:삭제'</C>
<C> Name=전표확정 	ID=KEEP_STATUS	Width=60 Align=Center Edit='none'</C>
<C> Name=전표번호 	ID=MAKE_SLIPNO		Width=120 Align=Center Edit='none' BgColor='#ECF5EB' SumText=' 검색항목수 : '</C>
<C> Name=작성부서 	ID=MAKE_DEPT_NAME	Width=100 Align=Left Edit='none'</C>
<C> Name=작성자 	ID=MAKE_NAME 	Width=60 Align=Left Edit='none'</C>
<C> Name=관리담당 	ID=CHARGE_PERS_NAME	Width=60 Align=Left Edit='none'</C>
<C> Name='적   요' 	ID=SUMMARY1 	Width=160 Edit='none'</C>
<C> Name=라인수 	ID=LINE_COUNT 	Width=40 Edit='none'</C>
<C> Name=차변계 	ID=DB_AMT  		Width=80 Edit='none'  SumBgColor=#FFCCCC BgColor=#FFECEC SumText=@sum</C>
<C> Name=대변계 	ID=CR_AMT  		Width=80 Edit='none'  SumBgColor=#CEEEFF BgColor=#E0F4FF SumText=@sum</C>
										">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
						</table>
						</div>
						<!-- 첫번째탭페이지 종료 //-->
						<!-- 두번째 탭 페이지 시작//-->
						<div id=divTabPage2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%; display=none ">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="70%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsSUB01">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="ViewSummary" 	VALUE=0>
										<PARAM NAME="Format" VALUE="
<C> Name=작업일자 	ID=LOG_CRTDATE	Width=80 Align=Center Edit='none'</C>
<C> Name=작업자 	ID=LOG_CRTUSER_NAME 	Width=60 Align=Left Edit='none'</C>
<C> Name=상태		ID=UPDATE_CLS	Width=60 Align=Center Edit='none' EditStyle=Combo Data='1:수정,2:확정,3:확정취소,4:삭제'</C>
<C> Name=전표확정 	ID=KEEP_STATUS	Width=60 Align=Center Edit='none'</C>
<C> Name=전표번호 	ID=MAKE_SLIPNO		Width=100 Align=Center Edit='none' BgColor='#ECF5EB' SumText=' 검색항목수 : '</C>
<C> Name=작성부서 	ID=MAKE_DEPT_NAME	Width=100 Align=Left Edit='none'</C>
<C> Name=작성자 	ID=MAKE_NAME 	Width=60 Align=Left Edit='none'</C>
<C> Name=관리담당 	ID=CHARGE_PERS_NAME	Width=60 Align=Left Edit='none'</C>
<C> Name='적   요' 	ID=SUMMARY1 	Width=160 Edit='none'</C>
<C> Name=라인수 	ID=LINE_COUNT 	Width=40 Edit='none'</C>
<C> Name=차변계 	ID=DB_AMT  		Width=80 Edit='none'  SumBgColor=#FFCCCC BgColor=#FFECEC SumText=@sum</C>
<C> Name=대변계 	ID=CR_AMT  		Width=80 Edit='none'  SumBgColor=#CEEEFF BgColor=#E0F4FF SumText=@sum</C>
										">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
						</table>
						</div>
						<!-- 두번째탭페이지 종료 //-->
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
							
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 세부내역</td>
											<td align="right" width="*">
<!--
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전 체 선 택" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전체선택취소" />
-->
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsSUB02">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="ViewSummary" 	VALUE=0>

										<PARAM NAME="Format" VALUE="
<FC> Name=전표번호	ID=MAKE_SLIPNO	Align=Left	 Width=110 Sort=true BgColor=#ECF5EB Edit='none' suppress='1'
</FC>
<FC> Name=라인	ID=MAKE_SLIPLINE	Align=Right	 Width=30 Sort=true BgColor=#ECF5EB Edit='none'
</FC>
<C> Name=계정코드 		ID=ACC_CODE 			Align=Left Width=80 Sort=true BgColor=#FFFCE0 Edit='none' SumText=@count
</C>
<C> Name=계정과목 		ID=ACC_NAME 			Align=Left	 Width=120 Sort=true BgColor=#FFFCE0 Edit='none'
</C>
<C> Name=차변 			ID=DB_AMT 				Align=Right	 SumBgColor=#FFCCCC BgColor=#FFECEC Width=95 Edit='none' SumText=@sum
</C>
<C> Name=대변 			ID=CR_AMT 				Align=Right	 SumBgColor=#CEEEFF BgColor=#E0F4FF Width=95 Edit='none' SumText=@sum
</C>
<C> Name='적        요' ID=SUMMARY1 			Align=Left	 Width=170 Sort=true Edit='none'
</C>
<C> Name=증빙코드 		ID=VAT_NAME 			Align=Left Width=100 Sort=true Edit='none'
</C>
<C> Name=거래처코드 	ID=CUST_CODE 			Align=Left	 Width=110 Sort=true Edit='none'
</C>
<C> Name=거래처명 		ID=CUST_NAME 			Align=Left	 Width=140 Sort=true Edit='none'
</C>
<C> Name=귀속부서 		ID=DEPT_NAME 			Align=Left	 Width=100 Sort=true Edit='none'
</C>
<C> Name=은행명 		ID=BANK_NAME 			Align=Left	 Width=100 Sort=true Edit='none'
</C>
<C> Name=사원번호 		ID=EMP_NO 			Align=Left	 Width=80 Sort=true Edit='none'
</C>
<C> Name=사원명    		ID=EMP_NAME 			Align=Left	 Width=80 Sort=true Edit='none'
</C>
										">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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