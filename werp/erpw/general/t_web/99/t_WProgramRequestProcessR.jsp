<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WProgramRequestProcessR.jsp(프로그램진행상태등록)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WProgramRequestProcessR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	CITData		lrArgData = null;
	String	strNow = "";
	String	strNAME = "";
	String	strDT_T = "";
	String	strDT_F = "";
	try
	{
		CITCommon.initPage(request, response, session);
		strNAME = CITCommon.NvlString(session.getAttribute("name"));
		lrArgData = new CITData();
		try
		{
			strSql = 
				"Select F_T_DATETOSTRING(Trunc(Sysdate,'DD')) NOW_DATE,F_T_DATETOSTRING(Trunc(Sysdate,'DD')) DT_T,F_T_DATETOSTRING(Trunc(Add_Months(Sysdate,-1),'DD')) DT_F From Dual"+"\n";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strNow = lrReturnData.toString(0,"NOW_DATE");
			strDT_F = lrReturnData.toString(0,"DT_F");
			strDT_T = lrReturnData.toString(0,"DT_T");
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
			var			sNow = "<%=strNow%>";
			var			sName = "<%=strNAME%>";
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
														<td width="70" class=font_green_bold>메뉴명 :</td>
														<td width="152">
															<input id="txtMENU_NAME" type="text" style="width:150px" >
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100" class=font_green_bold>프로그램명 :</td>
														<td width="152">
															<input id="txtPROGRAM_NAME" type="text" style="width:150px" >
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>작성자 :</td>
														<td width="102">
															<input id="txtMAKE_PROGRAMMER" type="text" style="width:100px" >
														</td>
														<td>&nbsp; </td>
													</tr>
												</table>
												<!-- 프로그래머 디자인 종료 //-->
											</td>
										</tr>
										<tr>
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="70" class=font_green_bold>요청일 :</td>
														<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDT_F%>"/></td>
														<td width="30">
															<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														<td width="15">~</td>
														<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDT_T%>"/></td>
														<td width="30">
															<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" class=font_green_bold>처리상태 :</td>
														<td width="102">
															<select  id="cboPROCESS_TAG"  style="WIDTH: 100px">
																<OPTION value='F' selected> 미처리</OPTION>
																<OPTION value='T'> 처리</OPTION>
																<OPTION value='A'> 전체</OPTION>
															</select>
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="80" class=font_green_bold>확인상태 :</td>
														<td width="102">
															<select  id="cboCONFIRM_TAG"  style="WIDTH: 100px">
																<OPTION value='F'> 미확인</OPTION>
																<OPTION value='T'> 확인</OPTION>
																<OPTION value='A' selected> 전체</OPTION>
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
				<tr> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="60%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 프로그램 수정 요청 목록</td>
														<td align="right" width="*">
															※타이틀을 Double-Click하시면 원하는 순으로 조회됩니다.
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="-1">
													<PARAM NAME="ColSelect" VALUE="-1">
													<PARAM NAME="ColSizing" VALUE="-1">
													<PARAM NAME="UsingOneClick" VALUE="1">
													<param name=SuppressOption value="1">
													<PARAM NAME="Format" VALUE="
														<FC> Name=메뉴명 ID=MENU_NAME  Width=120 Suppress=1
														</FC>
														<FC> Name=프로그램명 ID=PROGRAM_NAME  Width=200  Suppress=2
														</FC>
														<C> Name=작성자 ID=MAKE_PROGRAMMER Align=Center Width=80
														</C>
														<C> Name=요청일 ID=REQ_DT Align=Center Width=80 EditStyle=Popup
														</C>
														<C> Name=요청자 ID=REQ_USER_NAME Align=Center Width=80
														</C>
														<C> Name=처리여부 ID=PROCESS_TAG Align=Center Width=80 EditStyle=CheckBox
														</C>
														<C> Name=처리일 ID=PROCESS_DT Align=Center Width=80 EditStyle=Popup
														</C>
														<C> Name=최종수정자 ID=CHANGE_PROGRAMMER Align=Center Width=80
														</C>
														<C> Name=확인여부 ID=CONFIRM_TAG Align=Center Width=80 EditStyle=CheckBox
														</C>
														<C> Name=확인일 ID=CONFIRM_DT Align=Center Width=80 EditStyle=Popup
														</C>
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
								<td width="100%" height="40%">
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="20"><img src="../images/bullet1.gif"></td>
														<td class="font_green_bold"> 수정요청사항</td>
														<td align="right" width="*">
															&nbsp;
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
											<td bgcolor="#FFFFFF" height="100%">
												<textarea id="txtREQ_CONTENTS" readonly style="width:100% ; height:100% " wrap="off" tabindex="-1"></textarea>
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=bindSUB01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
			<PARAM NAME="DataID" 		VALUE="dsMAIN">
			<PARAM NAME="BindInfo"	VALUE="
				<C> Col=REQ_CONTENTS 				Ctrl=txtREQ_CONTENTS 				Param=Value</C>
				
			">
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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