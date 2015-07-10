<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_PFLDeptExecR.jsp(자금수지실적집계내역)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-07)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_PFLDeptExecR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN, I:dsCUST_ACCNO=dsCUST_ACCNO, I:dsPAY_STOP=dsPAY_STOP)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
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
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
				<!-- 프로그래머 디자인 시작 //-->
				<tr>
					<td height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="Top">
								<td height="70%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td width="150" class="font_green_bold">관련전표목록</td>
														<td align="right" width="*">
															<input id="btnShowSlip" type="button" class="img_btn4_1" value="전표보기" onclick="btnShowSlip_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															&nbsp;
															<input id="btnRETRIEVE" type="button" class="img_btn2_1" value="조회" onclick="btnquery_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															<input id="btnCLOSE" type="button" class="img_btn2_1" value="닫기" onclick="window.close()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="100%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="*" height="100%">
															<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" height="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																<PARAM NAME="DataID" VALUE="dsMAIN">
																<PARAM NAME="Editable" VALUE="true">
																<PARAM NAME="ColSelect" VALUE="true">
																<PARAM NAME="ColSizing" VALUE="true">
																<PARAM NAME="ViewSummary" 	VALUE=1>
																<PARAM NAME="Format" VALUE=" 
																	<C> Name=전표번호	ID=MAKE_SLIPNO Width=120 Edit=none
																	</C> 
																	<C> Name=좌수	ID=MAKE_SLIPLINE Width=60 Edit=none
																	</C> 
																	<C> Name=계정 		ID=ACC_NAME Width=180 Edit=none
																	</C> 
																	<C> Name=적요 		ID=SUMMARY Width=280 Edit=none
																	</C> 
																	<C> Name=차변금액	ID=DB_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
																	</C>
																	<C> Name=대변금액	ID=CR_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
																	</C>
																	<C> Name=적용금액	ID=EXEC_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
																	</C>
																	">
															</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="30%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td width="300" class="font_green_bold">현금추적인 경우 현금화 전표내역</td>
														<td align="right" width="*">
															<input id="btnShowCashSlip" type="button" class="img_btn4_1" value="전표보기" onclick="btnShowCashSlip_onclick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
															&nbsp;
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr class="head_line">
														<td width="*" height="3"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="100%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="*" height="100%">
															<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" height="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
																<PARAM NAME="DataID" VALUE="dsSUB01">
																<PARAM NAME="Editable" VALUE="true">
																<PARAM NAME="ColSelect" VALUE="true">
																<PARAM NAME="ColSizing" VALUE="true">
																<PARAM NAME="Format" VALUE=" 
																	<C> Name=전표번호	ID=MAKE_SLIPNO Width=120 Edit=none
																	</C> 
																	<C> Name=좌수	ID=MAKE_SLIPLINE Width=60 Edit=none
																	</C> 
																	<C> Name=계정 		ID=ACC_NAME Width=180 Edit=none
																	</C> 
																	<C> Name=적요 		ID=SUMMARY Width=280 Edit=none
																	</C> 
																	<C> Name=차변금액	ID=DB_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
																	</C>
																	<C> Name=대변금액	ID=CR_AMT Width=90 Edit=none SumText=@sum SumBgColor=#FFCCCC
																	</C>
																	<C> Name=당월적용	ID=NOW_AMT_TAG_NAME Width=90 Edit=none
																	</C> 
																	">
															</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
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