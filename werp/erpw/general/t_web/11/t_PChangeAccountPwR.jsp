<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_PChangeAccountPwR.jsp(계좌암호변경)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
//파일명	
	String strFileName = "./t_PChangeAccountPwR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	try
	{
		CITCommon.initPage(request, response, session);
	}
	catch (Exception ex)
	{
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>계좌암호변경</title>
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
			
			// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
			// 조회
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
	</head>
	<body onload="C_Initialize()">
		<iframe width="0" height="0" name="ifrmLovSession" src="../common/LovSession.jsp" frameborder="0" tabindex="-1"></iframe>
		<DIV id="divPopMain" style="WIDTH: 100%; HEIGHT: 100%;">
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td align="left" background="../images/pop_tit_bg.gif">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="52"><img src="../images/pop_tit_normal1.gif"></td>
								<td class="title_default">계좌암호변경</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td height="100%" width="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%" height="*">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											
											<td width="100%" height="*">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">기존암호</td>
														<td width="*">
															<input id="txtOLD_PASSWORD" type="password" datatype="hna"   style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">신규암호</td>
														<td width="*">
															<input id="txtNEW_PASSWORD" type="password" datatype="hna"   style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="100%" height="*">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5">&nbsp;</td>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="90">암호재입력</td>
														<td width="*">
															<input id="txtNEW_PASSWORD_CONFIRM" type="password" datatype="hna"   style="width:120px">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="*">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td width="100%" height="30" bgcolor="#ECECEC">
									<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<TD width="*">
												&nbsp;
											</TD>
											<TD width="120" align="right">
												<input id="imgOk" type="button" class="img_btnOk" value="확인" onclick="imgOk_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												<input id="imgCancle" type="button" class="img_btnClose" value="닫기" onclick="imgCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">&nbsp;
											</TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</DIV>
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