<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WReqPaySummationR(이체집계)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WReqPaySummationR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBATCH classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSEND classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transBatch"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsBATCH=dsBATCH)">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transSEND"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="Service1(I:dsSEND=dsSEND)">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr  valign="center"> 
					<td height="100%" width="100%" align="center">
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
														<td width="45" class=font_green_bold>사업장</td>
														<td width="52">
															<input id="txtCOMP_CODE" type="text" style="width:50px" onblur="txtCOMP_CODE_onblur()">
														</td>
														<td width="150">
															<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:148px">
														</td>
														<td width="70">
															<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="60" class=font_green_bold>계좌번호</td>
														<td width="181">
															<input id="txtBANK_CODE" 	type="hidden"/>
															<input id="txtACCNO_CODE" 		type="text" style="width:179px" onblur="txtACCNO_CODE_onblur()" />
														</td>
														<td width="124"><input id="txtBANK_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:179px"/></td>
														<td width="*">
															<input id="btnACCNO_CODE" type="button" class="img_btnFind_S" onClick="btnACCNO_CODE_onClick()" title="계좌번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
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
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center">
									<table width="400" height="300" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">당행의뢰총건수</td>
														<td width="150">
															<input id="txtP_DA_REQ_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">타행행의뢰총건수</td>
														<td width="150">
															<input id="txtP_TA_REQ_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">당행의뢰총금액</td>
														<td width="150">
															<input id="txtP_DA_REQ_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">타행의뢰총금액</td>
														<td width="150">
															<input id="txtP_TA_REQ_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">당행정상건수</td>
														<td width="150">
															<input id="txtP_DA_SUCCESS_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">타행정상건수</td>
														<td width="150">
															<input id="txtP_TA_SUCCESS_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">당행정상금액</td>
														<td width="150">
															<input id="txtP_DA_SUCCESS_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">타행정상금액</td>
														<td width="150">
															<input id="txtP_TA_SUCCESS_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">당행불능건수</td>
														<td width="150">
															<input id="txtP_DA_FAIL_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">타행불능건수</td>
														<td width="150">
															<input id="txtP_TA_FAIL_CNT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">당행불능금액</td>
														<td width="150">
															<input id="txtP_DA_FAIL_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">타행불능금액</td>
														<td width="150">
															<input id="txtP_TA_FAIL_AMT" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="center">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">당행수수료</td>
														<td width="150">
															<input id="txtP_DA_COMMISSION" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">타행수수료</td>
														<td width="150">
															<input id="txtP_TA_COMMISSION" type="text" datatype="CURRENCY"  readonly style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*"  align="left">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="120">응답결과</td>
														<td width="150">
															<input id="txtP_RESP_MSG" type="text" datatype="HNC"  readonly style="width:412px">
														</td>
														<td width="*">
															&nbsp;
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<TD width="*" align="center">
												<input id="btnGetData" type="button" class="img_btn6_1" value="이체집계"  onclick="btnGetData_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</TD>
										</tr>
										<tr>
											<TD width="*" align="center">
												최대 1분간 지연될 수 있습니다.
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" 		VALUE="dsMAIN">
			<PARAM NAME="BindInfo"	VALUE="
				<C> Col=P_DA_REQ_CNT 				Ctrl=txtP_DA_REQ_CNT 				Param=value</C>
				<C> Col=P_DA_REQ_AMT 				Ctrl=txtP_DA_REQ_AMT 				Param=value</C>
				<C> Col=P_DA_SUCCESS_CNT 			Ctrl=txtP_DA_SUCCESS_CNT 				Param=value</C>
				<C> Col=P_DA_SUCCESS_AMT 			Ctrl=txtP_DA_SUCCESS_AMT 				Param=value</C>
				<C> Col=P_DA_FAIL_CNT 				Ctrl=txtP_DA_FAIL_CNT 				Param=value</C>
				<C> Col=P_DA_FAIL_AMT 				Ctrl=txtP_DA_FAIL_AMT 				Param=value</C>
				<C> Col=P_DA_COMMISSION 			Ctrl=txtP_DA_COMMISSION 				Param=value</C>
				<C> Col=P_TA_REQ_CNT 				Ctrl=txtP_TA_REQ_CNT 				Param=value</C>
				<C> Col=P_TA_REQ_AMT 				Ctrl=txtP_TA_REQ_AMT 				Param=value</C>
				<C> Col=P_TA_SUCCESS_CNT 			Ctrl=txtP_TA_SUCCESS_CNT 				Param=value</C>
				<C> Col=P_TA_SUCCESS_AMT 			Ctrl=txtP_TA_SUCCESS_AMT 				Param=value</C>
				<C> Col=P_TA_FAIL_CNT 				Ctrl=txtP_TA_FAIL_CNT 				Param=value</C>
				<C> Col=P_TA_FAIL_AMT 				Ctrl=txtP_TA_FAIL_AMT 				Param=value</C>
				<C> Col=P_TA_COMMISSION 			Ctrl=txtP_TA_COMMISSION 				Param=value</C>
				<C> Col=P_RESP_MSG 					Ctrl=txtP_RESP_MSG 				Param=value</C>
			">
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
