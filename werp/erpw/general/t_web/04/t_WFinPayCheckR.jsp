<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WProvBillR.jsp(지급수표관리)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05) 
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFinPayCheckR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN01=dsMAIN01,I:dsMAIN03=dsMAIN03)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDATE  = CITDate.getNow("yyyyMMdd");
	String	strDTF = "";
	String	strDTT = "";
	
	CITData		lrArgData = new CITData();
	try
	{
		CITCommon.initPage(request, response, session);
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
			
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
			var sTab ="1";
			var vDATE 			 = '<%=strDATE%>';
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=CITCommon.enSC(strDEPT_CODE)%>";
			var			sDTF = "<%=strDTF%>";
			var			sDTT = "<%=strDTT%>";
			// 이벤트관련-------------------------------------------------------------------//
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN03 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
								<td width="*" height="0"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class="font_green_bold" >사업장</td>
											<td width="52">
												<input id="hiCHK_BILL_CLS" type="Hidden" VALUE="C">
												<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="60">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="55" class="font_green_bold" >은행코드</td>
											<td width="52">
												<input id="txtBANK_CODE" type="text" style="width:50px" onblur="txtBANK_CODE_onblur()">
											</td>
											<td width="150">
												<input id="txtBANK_NAME" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="60">
												<input id="btnBANK_CODE" type="button" class="img_btnFind" value="검색" onclick="btnBANK_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td width=310>
	 											
												<div id=divSBox3  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%; display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15" height="20"><img src="../images/bullet3.gif"></td>
															<td width="42" class="font_green_bold" >발행일</td>
															<td width="82">
																<input id="txtF_PUBL_DT" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnF_PUBL_DT" type="button" class="img_btnCalendar_S" title="달력" onclick="btnF_PUBL_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td width="10">
																~
															</td>
															<td width="82">
																<input id="txtE_PUBL_DT" type="text" datatype="DATE" style="width:80px">
															</td>
															<td width=22>
																<input id="btnE_PUBL_DT" type="button" class="img_btnCalendar_S" title="달력" onclick="btnE_PUBL_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
															<td align="right" width="*">
																&nbsp;
															</td>
														</tr>
													</table>
												</div>
											</td>
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
							<tr>
								<td>
									<!-- 서브 테이블 시작 //-->
									<!-- 서브 타이틀 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr height="23">
												<!-- 프로그래머 수정 시작 //-->
											<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
											<td width="70" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a href="javascript:selectTab(1, 3);" onfocus="this.blur()">미발행</a></td>
											<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
											<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
											<td width="70" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(2, 3);" onfocus="this.blur()">발행</a></td>
											<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
											<td width="6"><img id="imgTabLeft3" src="../images/Content_tab_after.gif"></td>
											<td width="70" id="tab3" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(3, 3);" onfocus="this.blur()">견질수표</a></td>
											<td width="6"><img id="imgTabRight3" src="../images/Content_tab_back.gif"></td>
											<td width="*" >
												&nbsp;
											</td>
											<!-- 프로그래머 수정 종료 //-->
											<td width="*" align="right">
												<div id=divInnerBox1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td align="right" width="*">
																<input id="btnInsertPopup" type="button" class="img_btn6_1" value="수표일괄등록" onclick="btnInsertPopup_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
																<input id="btnMultiDel" type="button" class="img_btn6_1" value="수표일괄삭제" onclick="btnMultiDel_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															</td>
														</tr>
													</table>	
												</div>
												<div id=divInnerBox2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%;display=none">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="100%">
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
						</table>
						<!-- 조건 테이블 종료 //-->
						<!-- 간격조정 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="2"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 종료 //-->
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top"> 
					<td width="100%" height="100%">
						<!-- 첫번째 탭 페이지 시작//-->
						<div id=divTabPage1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN01">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="SortView" VALUE="Left">
										<param name="MultiRowSelect"   value=true>
										<param name=UsingOneClick  value="1">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name='수표번호' ID=CHK_BILL_NO Align=Center Width=100  
											</FC> 
											<FC> Name=은행명 ID=BANK_NAME Width=140
											</FC>
											<FC> Name=상태구분 ID=STAT_CLS  EditStyle=Combo Data='1:미발행,2:발행,3:폐기,4:분실,9:은행반환,0:견질발행' Width=70
											</FC>
											<FC> Name=은행코드 ID=BANK_CODE Width=180  Show=false edit=none
											</FC>
											<FC> Name=구분 ID=CHK_BILL_CLS Width=180  show=false edit=none
											</FC>
											<FC> Name=사업자코드  ID=COMP_CODE Width=180  show=false edit=none
											</FC>
											<C> Name=수령일 ID=ACPT_DT Width=70 EditStyle=Popup
											</C>
											<C> Name=발행일 ID=PUBL_DT Width=70 EditStyle=Popup
											</C>
											<C> Name=발행금액 ID=PUBL_AMT Width=93
											</C>
											<C> Name=거래처코드 ID=CUST_CODE Width=90 editStyle=Popup
											</C>
											<C> Name=거래처명 ID=CUST_NAME Width=160
											</C>
											<C> Name=업체불출일 ID=CUST_DOUT_DT Width=70 EditStyle=Popup
											</C>
											<C> Name=만기일 ID=EXPR_DT Width=70 EditStyle=Popup
											</C>
											<C> Name='폐기/분실일' ID=DUSE_DT Width=90 EditStyle=Popup
											</C>
											<C> Name='은행반환일' ID=RETURN_DT Width=90 EditStyle=Popup
											</C>
											<C> Name=비고 ID=REMARKS Width=200
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
						</div>
						<!-- 첫번째탭페이지 종료 //-->
						<!-- 두번째 탭 페이지 시작//-->
						<div id=divTabPage2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%; display=none ">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN02">
										<PARAM NAME="Editable" VALUE="0">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="SortView" VALUE="Left">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name='수표번호' ID=CHK_BILL_NO Align=Center Width=100  
											</FC>
											<FC> Name=은행명 ID=BANK_NAME Width=140
											</FC>
											<FC> Name=거래처코드 ID=CUST_CODE Width=90 
											</FC>
											<FC> Name=거래처명 ID=CUST_NAME Width=160
											</FC>
											<FC> Name=발행일 ID=PUBL_DT Align=Center Width=70
											</FC>
											<FC> Name=발행금액 ID=PUBL_AMT Width=100
											</FC>
											<C> Name=만기일 ID=EXPR_DT Width=70
											</C>
											<C> Name=변경만기일 ID=CHG_EXPR_DT Width=70
											</C>
											<C> Name=업체불출일 ID=CUST_DOUT_DT Width=70
											</C>
											<C> Name=회수일 ID=COLL_DT Width=70
											</C>
											<C> Name=할인율 ID=DISC_RAT Width=80
											</C>
											<C> Name=할인액 ID=DISC_AMT Width=90
											</C>
											<C> Name=전표번호 ID=MAKE_SLIPNO Width=120
											</C>
											<C> Name=비고 ID=REMARKS Width=200
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
						</table>
						</div>
						<!-- 두번째탭페이지 종료 //-->
						<!-- 세번째 탭 페이지 시작//-->
						<div id=divTabPage3  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100% ; display=none">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							
							<tr>
								
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN03 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN03">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="SortView" VALUE="Left">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name='수표번호'  ID=CHK_BILL_NO Align=Center Width=100  
											</FC>
											<FC> Name=은행명  ID=BANK_NAME Width=180 Edit=None
											</FC>
											<C> Name=거래처코드  ID=CUST_CODE Width=90  
											</C>
											<C> Name=거래처명   ID=CUST_NAME  Width=160  
											</C>
											<C> Name=발행일     ID=PUBL_DT   Width=70 editStyle=Popup
											</C>
											<C> Name=발행금액   ID=PUBL_AMT Width=100
											</C>
											<C> Name=만기일     ID=EXPR_DT Width=70 editStyle=Popup
											</C>
											<C> Name=변경만기일 ID=CHG_EXPR_DT Width=70 Edit=None
											</C>
											<C> Name=업체불출일  ID=CUST_DOUT_DT Width=70 editStyle=Popup
											</C>
											<C> Name=회수일  ID=COLL_DT Width=70 editStyle=Popup
											</C>
											<C> Name=할인율  ID=DISC_RAT Width=70
											</C>
											<C> Name=할인액  ID=DISC_AMT Width=90
											</C>
											<C> Name=비고  ID=REMARKS Width=200
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
						</div>
						<!-- 세번째탭페이지 종료 //-->
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