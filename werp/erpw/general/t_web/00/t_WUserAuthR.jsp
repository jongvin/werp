<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WUserAuthR.jsp(사용자별권한관리)
/* 2. 유형(시나리오) : Left-Right(Master-Detail)
/* 3. 기  능  정  의 : 사용자별권한관리
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-25)
/* 5. 관련  프로그램 : 없음
/* 6. 특  기  사  항 : 없음
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WUserAuthR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02,I:dsSUB03=dsSUB03,I:dsSUB04=dsSUB04)";
	
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsMAIN" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsSUB01" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsSUB02" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsSUB03" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsSUB04" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsCOPY" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsSET" classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="<%=strUpdateKeyValue%>">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transCopy"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="Service1(I:dsCOPY=dsCOPY)">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transSet"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	      <param name="KeyValue" value="Service1(I:dsSET=dsSET)">
		  <param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td width="120" class="font_green_bold" >성명 또는 사번</td>
											<td width="200"><input id="txtSEARCH_CONDITION" type="text" style="width:150px"></td>
											<td width="*" align="right">
												<select id='cbSETDEFAULT'>
													<option value='1'> 자기 사업장 자기 부서</option>
													<option value='2'> 자기 사업장 자기 팀</option>
													<option value='3'> 자기 사업장 전 부서</option>
													<option value='4'> 전 사업장 전 부서</option>
												</select>
												<input name="btnSetDefault" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="로 기본권한 설정" onclick="btnSetDefault_onClick()"/>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="btnCopyOther" type="button" class="img_btn12_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="다른 사원 권한에서 복사" onclick="btnCopyOther_onClick()"/>
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
				<tr>
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="280" height="100%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 사원목록</td>
														<td align="right" width="*">
															&nbsp;
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
										<tr>
											<td height="100%">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="Format" VALUE="
														<C> Name=사번 ID=EMPNO Align=Center  Width=70
														</C>
														<C> Name=성명 ID='NAME' Align=Left  Width=65
														</C>
														<C> Name=확정권한 ID='SLIP_TRANS_CLS' EditStyle='checkbox' Align=Center  Width=55
														</C>
														<C> Name=발의부서 ID='DEPT_CHG_CLS' EditStyle='checkbox' Align=Center  Width=55
														</C>
														<C> Name='전부서조회' ID='ALL_DEPT_CLS' EditStyle='checkbox' Align=Center  Width=65
														</C>
														">
													<PARAM NAME="DataID" VALUE="dsMAIN">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
											</td>
										</tr>
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10"></td>
								<td width="*">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="50%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="100%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> 사용가능 사업장</td>
																				<td align="right" width="*">
																					&nbsp;
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
																<tr>
																	<td height="100%" width="100%">
																		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=MultiRowSelect  value="true">
																			<PARAM NAME="Format" VALUE="
																				<C> Name=사업장코드 ID=COMP_CODE Align=Center  Width=100
																				</C>
																				<C> Name=사업장명 ID='COMPANY_NAME' Align=Left  Width=197
																				</C>
																				">
																			<PARAM NAME="DataID" VALUE="dsSUB01">
																		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
															</table>
														</td>
														<td width="40">
															<input name="btnGrantCompCode" type="button" class="btn" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="<<설정" onclick="btnGrantCompCode_onClick()"/>
															<br>
															<br>
															<br>
															<input name="btnRevokeCompCode" type="button" class="btn" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="해제>>" onclick="btnRevokeCompCode_onClick()"/>
														</td>
														<td width="50%" height="100%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> 사용불가능 사업장</td>
																				<td align="right" width="*">
																					&nbsp;
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
																<tr>
																	<td height="100%" width="100%">
																		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=MultiRowSelect  value="true">
																			<PARAM NAME="Format" VALUE="
																				<C> Name=사업장코드 ID=COMP_CODE Align=Center  Width=100
																				</C>
																				<C> Name=사업장명 ID='COMPANY_NAME' Align=Left  Width=197
																				</C>
																				">
																			<PARAM NAME="DataID" VALUE="dsSUB02">
																		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
										<tr>
											<td width="100%" height="50%">
												<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="50%" height="100%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> 사용가능 부서/현장</td>
																				<td align="right" width="*">
																					&nbsp;
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
																<tr>
																	<td height="100%" width="100%">
																		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB03 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=MultiRowSelect  value="true">
																			<PARAM NAME="Format" VALUE="
																				<C> Name='부서/현장코드' ID=DEPT_CODE Align=Center  Width=100
																				</C>
																				<C> Name='부서/현장명' ID='DEPT_NAME' Align=Left  Width=197
																				</C>
																				">
																			<PARAM NAME="DataID" VALUE="dsSUB03">
																		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
															</table>
														</td>
														<td width="40">
															<input name="btnGrantDeptCode" type="button" class="btn" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="<<설정" onclick="btnGrantDeptCode_onClick()"/>
															<br>
															<br>
															<br>
															<input name="btnRevokeDeptCode" type="button" class="btn" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="해제>>" onclick="btnRevokeDeptCode_onClick()"/>
														</td>
														<td width="50%" height="100%">
															<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td>
																		<table width="100%" border="0" cellspacing="0" cellpadding="0">
																			<tr>
																				<td width="15" height="20"><img src="../images/bullet1.gif"></td>
																				<td class="font_green_bold"> 사용불가능 부서/현장</td>
																				<td align="right" width="*">
																					&nbsp;
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr class="head_line">
																	<td width="*" height="3"></td>
																</tr>
																<tr>
																	<td height="100%" width="100%">
																		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB04 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
																			<PARAM NAME="Editable" VALUE="-1">
																			<PARAM NAME="ColSelect" VALUE="-1">
																			<PARAM NAME="ColSizing" VALUE="-1">
																			<param name=MultiRowSelect  value="true">
																			<PARAM NAME="Format" VALUE="
																				<C> Name='부서/현장코드' ID=DEPT_CODE Align=Center  Width=100
																				</C>
																				<C> Name='부서/현장명' ID='DEPT_NAME' Align=Left  Width=197
																				</C>
																				">
																			<PARAM NAME="DataID" VALUE="dsSUB04">
																		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
