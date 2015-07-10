<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFBBillRealR.jsp(전자어음실시간송신)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-02-08)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFBBillRealR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strPAY_KIND = "";
	String strCOMP_MAIN = "";
	String strCOMP_CODE = "";
	String strCOMP_NAME = "";
	String strDEPT_CODE = "";
	String strEMP_NO = "";
	String strBANK_CODE = "";
	String strDate = CITDate.getNow("yyyy-MM-dd");

	try
	{
		CITCommon.initPage(request, response, session);
		CITData lrArgData = new CITData();
		
		try
		{	//지급구분
			strSql  = 
				"select "+"\n"+
				"	2 GB,"+"\n"+
				"	a.LOOKUP_CODE  CODE, "+"\n"+
				"	a.LOOKUP_VALUE NAME  "+"\n"+
				"from	T_FB_LOOKUP_VALUES a "+"\n"+
				"where lookup_type = upper('pay_kind_gubun')"+"\n"+
				"and   use_yn      = 'Y'"+"\n"+
				"Union All"+"\n"+
				"Select"+"\n"+
				"	1,"+"\n"+
				"	'%',"+"\n"+
				"	'전체'"+"\n"+
				"From	Dual"+"\n"+
				"order by"+"\n"+
				"	1,2"+"\n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strPAY_KIND = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
			
			//처리상태
			strSql  = 
				"select "+"\n"+
				"	2 GB,"+"\n"+
				"	a.LOOKUP_CODE  CODE, "+"\n"+
				"	a.LOOKUP_VALUE NAME  "+"\n"+
				"from	T_FB_LOOKUP_VALUES a "+"\n"+
				"where lookup_type = upper('bill_pay_status')"+"\n"+
				"and   use_yn      = 'Y'"+"\n"+
				"and   lookup_code NOT IN ('0','1','3','8')"+"\n"+
				"order by"+"\n"+
				"	1,2"+"\n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			
			strCOMP_MAIN = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");			

		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 직간구분 Select 오류 -> " + ex.getMessage());
		}
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
	
	//사업장 설정
	strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
	strEMP_NO = CITCommon.toKOR((String)session.getAttribute("emp_no"));
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
				strCOMP_NAME = lrReturnData.toString(0,"COMPANY_NAME");
	
				session.setAttribute("comp_code", strCOMP_CODE);
				session.setAttribute("comp_name", strCOMP_NAME);
			}				
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
	}
	else
	{
		strCOMP_NAME = CITCommon.NvlString(session.getAttribute("comp_name"));
	}
	try
	{
		CITData lrArgData = new CITData();
		
		lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
		lrArgData.addRow();
		lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			
		//은행리스트
		strSql  = 
			"select "+"\n"+
			"	a.BANK_MAIN_CODE  CODE, "+"\n"+
			"	a.BANK_MAIN_NAME NAME  "+"\n"+
			"from	VIEW_FBS_ACCOUNTS a "+"\n"+
			"where a.COMP_CODE = ? "+"\n"+
			"and   a.BANK_MAIN_CODE = '03' "+"\n"+
			"and   a.FBS_TRANSFER_CLS = 'T' "+"\n"+
			"group by"+"\n"+
			"	a.BANK_MAIN_CODE , "+"\n"+ 
			"	a.BANK_MAIN_NAME "+"\n";
			
		lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
		strBANK_CODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}			
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>FBS관리</title>
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

		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsPASS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->	
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBANK classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsACCOUNT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->					
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMSG classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->					
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	    <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"   value="<%=strFileName%>_tr.jsp">
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
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90" class=font_green_bold>사업장</td>
														<td width="219">
														<table width="219" border="0" cellspacing="0" cellpadding="0">
														<td width="31">
														<input name="txtCOMP_CODE" type="text" class="ro" readOnly style="width:30px" VALUE="<%=strCOMP_CODE%>" ></td>
														<td width="155">
														<input name="txtCOMP_NAME" type="text" class="ro" readOnly style="width:155px" VALUE="<%=strCOMP_NAME%>" >
														<input name="txtEMP_NO" type="hidden" class="ro" style="width:30px" VALUE="<%=strEMP_NO%>" >
														<input name="txtMANAGER_PASS1" type="hidden" class="ro" style="width:30px" >
														<input name="txtMANAGER_PASS2" type="hidden" class="ro" style="width:30px" ></td>
														<input name="txtPAY_SEQ" type="hidden" class="ro" style="width:30px" ></td>
														</td>														
														<td>&nbsp; </td>
														</table>
														</td>													
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>지급구분</td>
														<td width="220">
														<table width="200" border="0" cellspacing="0" cellpadding="0">
														<td width="200">
															<select id="txtPAY_GUBUN" style="WIDTH: 200px " ;">
																<%=strPAY_KIND%>
															</select>
														</td>
														</table>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90" class="font_green_bold" >발행예정일자</td>													
														<td width="200">
														<table width="102" border="0" cellspacing="0" cellpadding="0">
														<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"></td>
														<td width="30"><input id="btnDTS_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
														<td>&nbsp; </td>
														</table>	
														</td>
														<td>&nbsp; </td>			
													</tr>
													<tr>													
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class="font_green_bold" >은행</td>
														<td width="219">
															<table width="219" border="0" cellspacing="0" cellpadding="0">
																<td width="150">
																	<select id="txtBANK_CODE" style="WIDTH: 150px " ;">
																		<%=strBANK_CODE%>
																	</select>
																</td>
																<td>&nbsp; </td>
															</table>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90" class=font_green_bold>지급처리상태</td>
														<td width="200">
															<select id="txtPAY_STATUS" style="WIDTH: 200px " onchange="btnquery_onclick();">
																<%=strCOMP_MAIN%>
															</select>
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
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 전자어음실시간송신</td>
											<td align="right" width="*">
											<input id="btnSELECT_ALL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSELECT_ALL_onClick()" 	value="전체선택" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											<input id="btnCANCEL_ALL"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnCANCEL_ALL_onClick()" 	value="선택취소" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											<input id="btnRealTime_Send"	type="button" tabindex="-1" class="img_btn6_1" onClick="btnRealTime_Send_onClick()"value="발행송신" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
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
											<td width="100%" style="background:#F6F6F6">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td >
															<!-- 프로그래머 디자인 시작 //-->
															<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="black">
																<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >총금액</td>
																	<td width="160">
																	<input name="txtTOTAL_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="45" >총건수</td>
																	<td width="160">
																	<input name="txtTOTAL_CNT" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>	
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60" >선택금액</td>
																	<td width="160">
																	<input name="txtSELECT_SUM" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
																	</td>	
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="60" >선택건수</td>
																	<td width="160">
																	<input name="txtSELECT_CNT" type="text" class="ro" readOnly right style="width:155px;background:#FFECEC" ></td>
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE="
											<C> Name=seq ID=PAY_SEQ  Align=Center   Edit='none' Width=40  show=false
											</C>
											<C> Name=선택 ID=SELECT_YN  Align=Center   Width=40  EditStyle=CheckBox
											</C>
											<C> Name=지급금액 ID=PAY_AMT Align=Right  Edit='none' Width=70
											</C>
											<C> Name=지급구분 ID=PAY_KIND_GUBUN_NAME Align=Left  Edit='none' Width=100 
											</C>
											<C> Name=발행예정일 ID=PAY_DUE_YMD Align=Center  Edit='none' Width=70
											</C>
											<C> Name=채권번호 ID=CHECK_NO  Align=Left  Edit='none' Width=70
											</C>
											<C> Name=만기일 ID=FUTURE_YMD  Align=Left Edit='none'  Width=70
											</C>
											<C> Name=지급처리상태 ID=PAY_STATUS_NAME  Align=Left  Edit='none' Width=100
											</C>
											<C> Name=지급처리상태 ID=PAY_STATUS  Align=Left  Edit='none' Width=70 show=false
											</C>
											<C> Name=사업자번호 ID=REGIST_NUM  Align=Center   Width=120 Edit='none'
											</C>
											<C> Name=거래처은행코드 ID=BANK_CODE  Align=Left  Edit='none' Width=70 show=false
											</C>
											<C> Name=입금계좌번호 ID=ACCOUNT_NO  Align=Center  Edit='none' Width=100 
											</C>
											<C> Name=가맹점번호 ID=FRANCHISE_NO  Align=Left  Edit='none' Width=70 show=false
											</C>
											<C> Name=지급처명 ID=CUST_NAME  Align=Left  Edit='none' Width=70
											</C>
											<C> Name=적요사항 ID=DESCRIPTION  Align=Left  Edit='none' Width=100
											</C>
											<C> Name=은행코드 ID=OUT_BANK_CODE  Align=Left  Edit='none' Width=70 show=false
											</C>
											<C> Name=은행명 ID=OUT_BANK_CODE_NAME  Align=Left  Edit='none' Width=70 show=false
											</C>
											<C> Name=출금계좌번호 ID=OUT_ACCOUNT_NO  Align=Center Edit='none'  Width=100
											</C>
											<C> Name=출금계좌번호 ID=NAIVE_OUT_ACCOUNT_NO  Align=Left  Edit='none' Width=70 show=false
											</C>
											<C> Name=카드승인번호 ID=APPROVAL_NO Align=Left Edit='none'  Width=100 show=false
											</C>
											<C> Name=처리결과메세지 ID=RESULT_TEXT  Align=Left Edit='none'  Width=100
											</C>
											<C> Name=사업장 ID=COMPANY_NAME Align=Left Edit='none'  Width=100
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