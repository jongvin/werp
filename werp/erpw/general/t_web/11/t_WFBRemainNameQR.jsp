<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFBRemainNameQR(잔액조회/수취인조회)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 배민정 작성(2006-02-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WFBRemainNameQR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strBANK_CODE = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strDate = CITDate.getNow("yyyy-MM-dd");
	
	try
	{
		CITCommon.initPage(request, response, session);
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
		
		//은행코드조회
		CITData lrArgData = new CITData();
			
		//은행리스트
		strSql  = 
			"select "+"\n"+
			"	a.BANK_MAIN_CODE  CODE, "+"\n"+
			"	a.BANK_MAIN_NAME NAME  "+"\n"+
			"from	T_BANK_MAIN a "+"\n"+
			"where a.BANK_CLS = '1' "+"\n"+
			"group by"+"\n"+
			"	a.BANK_MAIN_CODE , "+"\n"+ 
			"	a.BANK_MAIN_NAME ";
			
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
			var			sRetValue = "";
			var			sGubun = "";
 
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSTR classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->				
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"   value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">		  
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" align="center" >
									<table width="800" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line"> 
											<td width="*" height="2"></td>
										</tr>
										<tr><td>&nbsp;</td></tr>										
										<tr>
											<td width="800" height="*"  align="center" >	
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>										
														<td width="400" height="*"  align="center">	
											  			<table width="345" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15" align="left"><img src="../images/bullet3.gif"></td>
																	<td width="60" align="left" class=font_green_bold>사업장</td>
																	<td width="50" align="left" >
																		<input id="txtCOMP_CODE" type="text" readOnly class="ro" style="width:48px" ></td>
																	<td width="200" align="left">	
																		<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:200px">
																	</td>
																	<td>&nbsp;</td>	
																</tr>
															</table>
														</td>
														<td width="15" align="center"><img src="../images/bullet3.gif"></td>
														<td width="400" height="*"  align="center">	
											  			<table width="273" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="110" class=font_green_bold>은행</td>
																	<td width="148">
																		<select id="txtBANK_CD" style="WIDTH: 148px " ;">
																			<%=strBANK_CODE%>
																		</select>
																	</td>	
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="800" height="*"  align="center" >	
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>										
														<td width="400" height="*"  align="center">	
											  			<table width="345" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15" align="left"><img src="../images/bullet3.gif"></td>
																	<td width="60" align="left" class=font_green_bold>계좌번호</td>
																	<td width="130" align="left">
																		<input id="txtBANK_CODE" 	type="hidden"/>
																		<input id="txtACCNO_CODE" type="text" style="width:128px" onblur="txtACCNO_CODE_onblur()" /></td>
																	<td width="100" align="left">	
																	  <input id="txtBANK_NAME" type="text" readOnly  tabindex="-1" class="ro" style="width:98px"/></td>
																	<td width="40" align="left">
																		<input id="btnACCNO_CODE" type="button" class="img_btnFind_S" onClick="btnACCNO_CODE_onClick()" title="계좌번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																	</td>
																</tr>
															</table>
														</td>
														<td width="15" align="center"><img src="../images/bullet3.gif"></td>
														<td width="400" height="*"  align="center">	
											  			<table width="273" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="110" class=font_green_bold>계좌번호</td>
																	<td width="148">
																		<input id="txtACCNO_CD" left type="text" maxlength="15" style="width:148px" onchange="acctno_oncblur();">
																	</td>	
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>	
										<tr>
											<td width="800" height="*"  align="center" >	
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>										
														<td width="400" height="*"  align="center">
														</td>
														<td width="15" align="center"><img src="../images/bullet3.gif"></td>
														<td width="400" height="*"  align="center">	
											  			<table width="273" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15"><img src="../images/bullet3.gif"></td>
																	<td width="110" class=font_green_bold>주민/사업자번호</td>
																	<td width="148">
																		<input id="txtJUMIN_NO" type="text" maxlength="13" style="width:148px" onchange="juminchk_oncblur();">
																	</td>	
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr><td>&nbsp;</td></tr>
										<tr class="head_line"> 
											<td width="*" height="2"></td>
										</tr>	
										<tr><td>&nbsp;</td></tr>
										<tr>
											<td width="800" height="*"  align="center">	
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>										
														<td width="400" height="*"  align="center">	
											  			<table width="345" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15" align="left"><img src="../images/bullet3.gif"></td>
																	<td width="60" align="left">잔액</td>
																	<td width="175" align="left">
																		<input id="txtREMAIN_AMT" type="text" right readOnly style="width:175px" ></td>
																  <td>&nbsp;</td>
																</tr>
															</table>
														</td>
														<td width="15" align="center"><img src="../images/bullet3.gif"></td>
														<td width="400" height="*"  align="center">	
											  			<table width="273" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15" align="left"><img src="../images/bullet3.gif"></td>
																	<td width="60" align="left">예금주명</td>
																	<td width="175" align="left">
																	<input id="txtACCT_NAME" type="text" left readOnly style="width:175px" ></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>										
										<tr><td>&nbsp;</td></tr>										
										<tr>
											<td width="800" height="*"  align="center">	
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>										
														<td width="400" height="*"  align="center">	
											  			<table width="345" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15" align="left"><img src="../images/bullet3.gif"></td>
																	<td width="60" align="left">가용자금</td>
																	<td width="175" align="left">
																		<input id="txtENABLE_AMT" type="text" right readOnly style="width:175px" ></td>
																  <td>&nbsp;</td>
																</tr>
															</table>
														</td>
														<td width="15" align="center"><img src="../images/bullet3.gif"></td>
														<td width="400" height="*"  align="center">	
											  			<table width="273" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15" align="left"><img src="../images/bullet3.gif"></td>
																	<td width="60" align="left">응답결과</td>
																	<td width="175" align="left">
																	<input id="txtRESULT_TEXT1" type="text" left readOnly style="width:175px" ></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>										
										<tr><td>&nbsp;</td></tr>										
										<tr>
											<td width="800" height="*"  align="center">	
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>										
														<td width="400" height="*"  align="center">	
											  			<table width="345" border="0" cellspacing="0" cellpadding="0">
												  			<tr>
																	<td width="15" align="left"><img src="../images/bullet3.gif"></td>
																	<td width="60" align="left">응답결과</td>
																	<td width="175" align="left">
																		<input id="txtRESULT_TEXT2" type="text" left readOnly style="width:175px" ></td>
																  <td>&nbsp;</td>
																</tr>
															</table>
														</td>
														<td width="15" align="center"><img src="../images/bullet3.gif"></td>
														<td width="400" height="*"  align="center">	
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr><td>&nbsp;</td></tr>
										<tr class="head_line"> 
											<td width="*" height="1"></td>
										</tr>
										<tr><td>&nbsp;</td></tr>
										<tr>
											<td width="800" height="*"  align="center">	
											  <table width="800" border="0" cellspacing="0" cellpadding="0">
												  <tr>
														<TD width="400" align="center">
															<input id="btnGetData_Remain" type="button" class="img_btn6_1" value="잔액조회"  onclick="btnGetData_Remain_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</TD>
														<td width="15" align="center"><img src="../images/bullet3.gif"></td>
														<TD width="400" align="center">
															<input id="btnGetData_Name" type="button" class="img_btn6_1" value="예금주명조회"  onclick="btnGetData_Name_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</TD>
													</tr>
												</table>
											</td>		
										</tr>	
										<tr><td>&nbsp;</td></tr>
										<tr class="head_line"> 
											<td width="*" height="1"></td>
										</tr>
										<tr><td>&nbsp;</td></tr>	
										<tr>
											<TD width="*" align="center">
												최대 1분간 지연될 수 있습니다.
											</TD>
										</tr>
										<tr><td>&nbsp;</td></tr>	
										<tr><td>&nbsp;</td></tr>	
										<tr><td>&nbsp;</td></tr>	
										<tr><td>&nbsp;</td></tr>	
										<tr><td>&nbsp;</td></tr>	
										<tr><td>&nbsp;</td></tr>	
										<tr><td>&nbsp;</td></tr>	
										<tr><td>&nbsp;</td></tr>	
									</table>
								</td>
							</tr>
						</table>								
		</div>

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