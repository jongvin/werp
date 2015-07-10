<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBankCodeR.jsp(은행코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-17)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFBRetriveAcctRemainR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strBANK_CODE = "";
	String strCOMP_CODE = "";
	String strCOMP_NAME = "";
	String strDEPT_CODE = "";	
	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strBeforeDate = "";

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
			"	2 GB,"+"\n"+
			"	a.BANK_MAIN_CODE  CODE, "+"\n"+
			"	a.BANK_MAIN_NAME NAME  "+"\n"+
			"from	VIEW_FBS_ACCOUNTS a "+"\n"+
			"where a.COMP_CODE = ? "+"\n"+
			"group by"+"\n"+
			"	a.BANK_MAIN_CODE , "+"\n"+ 
			"	a.BANK_MAIN_NAME "+"\n"+
			"Union All"+"\n"+
			"Select"+"\n"+
			"	1,"+"\n"+
			"	'%',"+"\n"+
			"	'전체'"+"\n"+
			"From	Dual"+"\n"+
			"order by"+"\n"+
			"	1,2"+"\n" ;
			
		lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		
		strBANK_CODE = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
	try
	{
		CITData lrArgData = new CITData();
			
		//전일조회
		strSql  = "select to_char(sysdate - 1,'yyyy-mm-dd') BEFORE_DATE From	Dual";
			
		lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

		if(lrReturnData.getRowsCount() >= 1)
		{
			strBeforeDate = lrReturnData.toString(0,"BEFORE_DATE");
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsCOPY" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	    <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"   value="<%=strFileName%>_tr.jsp">
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
														<td width="110" class=font_green_bold>사업장</td>
														<td width="219">
														<table width="219" border="0" cellspacing="0" cellpadding="0">
														<td width="31">
														<input name="txtCOMP_CODE" type="text" class="ro" readOnly style="width:30px" VALUE="<%=strCOMP_CODE%>" ></td>
														<td width="155">
														<input name="txtCOMP_NAME" type="text" class="ro" readOnly style="width:155px" VALUE="<%=strCOMP_NAME%>" ></td>
														<td>&nbsp; </td>
														</table>
														</td>													
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class=font_green_bold>은행</td>
														<td width="150">
														<table width="150" border="0" cellspacing="0" cellpadding="0">
														<td width="150">
															<select id="txtBANK_CODE" style="WIDTH: 148px " ;">
																<%=strBANK_CODE%>
															</select>
														</td>
														</table>
														</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
													<tr>													
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="110" class="font_green_bold" >전일잔액기준일자</td>													
														<td width="219">
															<table width="219" border="0" cellspacing="0" cellpadding="0">
																<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strBeforeDate%>"></td>
																<td width="30"><input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/></td>
																<td>&nbsp;</td>
															</table>	
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class=font_green_bold>계좌번호</td>
														<td width="150">
															<input id="txtBANK_CD" 	type="hidden"/>
															<input id="txtACCNO_CODE" type="text" style="width:148px" onblur="txtACCNO_CODE_onblur()" /></td>
														<td width="100">	
														  <input id="txtBANK_NAME" type="text" readOnly  tabindex="-1" class="ro" style="width:98px"/></td>
														<td width="40">
															<input id="btnACCNO_CODE" type="button" class="img_btnFind_S" onClick="btnACCNO_CODE_onClick()" title="계좌번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														<td>&nbsp;</td>
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
											<td class="font_green_bold">잔액명세표</td>
											<td align="right" width="*">
											<input id="btnSELECT_NEW"		type="button" tabindex="-1" class="img_btn6_1" onClick="btnSELECT_NEW_onClick()" 	value="신규잔액조회" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											<input id="btnSAVE_ORDER"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSAVE_ORDER_onClick()" 	value="순서저장" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											<input id="btnEXCEL_EXPORT"	type="hidden" tabindex="-1" class="img_btn7_1" onClick="btnEXCEL_EXPORT_onClick()"value="EXCEL로 EXPORT" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
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
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE="
											<C> Name=순서 ID=FBS_DISPLAY_ORDER  Align=Center Width=100  
											</C>
											<C> Name=은행 ID=BANK_CODE Align=Left  Edit='none' Width=150 show=false
											</C>
											<C> Name=은행 ID=BANK_MAIN_NAME Align=Left  Edit='none' Width=150 
											</C>
											<C> Name=계좌번호 ID=ACCOUNT_NO  Align=Left  Edit='none' Width=100
											</C>
											<C> Name=현재잔액 ID=REMAIN_AMT Align=Right  Edit='none' Width=150
											</C>
											<C> Name=가용자금 ID=ENABLE_AMT  Align=Right  Edit='none' Width=150
											</C>
											<C> Name=전일잔액 ID=REMAIN_AMT_B  Align=Right  Edit='none' Width=150 
											</C>
											<C> Name=최종잔액조회일시 ID=LAST_DATE Align=Center  Edit='none' Width=150
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