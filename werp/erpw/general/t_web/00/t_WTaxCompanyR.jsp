<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompanyR(세무사업장 등록)
/* 2. 유형(시나리오) : 세무사업장의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-11)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WTaxCompanyR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="45" class=font_green_bold>사업장</td>
											<td width="52">
												<input id="txtCOMP_CODE_S" type="text" style="width:50px" onblur="txtCOMP_CODE_S_onblur()">
											</td>
											<td width="150">
												<input id="txtCOMPANY_NAME_S" type="text" readOnly class="ro" style="width:148px">
											</td>
											<td width="*">
												<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
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
											<td class="font_green_bold"> 세무사업장 목록</td>
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
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="*" height="100%">
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="Format" VALUE=" 
														<FC> Name=세무사업장코드 ID=TAX_COMP_CODE Align=Center Width=95 Edit=none
														</FC> 
														<FC> Name=세무사업장명 ID=COMPANY_NAME Width=145 Edit=none
														</FC> 
														<C> Name=사업자번호 ID=BIZNO Align=Center Width=100 Edit=none
														</C> 
														<C> Name=소속사업장 ID=OVER_COMPANY_NAME  Width=140 Edit=none
														</C> 
														<C> Name=대표자 ID=BOSS Align=Center Width=60 Edit=none
														</C> 
														">
												</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
												&nbsp;
											</td>
											<td width="15">&nbsp;</td>
											<td width="400" height="100%" valign="top" onActivate="G_focusDataset(dsMAIN)">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15" height="30"><img src="../images/bullet2.gif"></td>
														<td class="font_green_bold"> 세부내역</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">세무사업장코드</td>
														<td width="*"><input id="txtTAX_COMP_CODE" type="text" style="width:60px" datatype="AN" MaxLength="10" notnull></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">세무사업장명</td>
														<td width="*"><input id="txtCOMPANY_NAME" type="text" notnull style="width:200px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">사업자번호</td>
														<td width="*"><input id="txtBIZNO" type="text" notnull datatype="CUSTNO" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">법인번호</td>
														<td width="*"><input id="txtBIZNO2" type="text" datatype="n" style="width:100px" onblur="txtBIZNO2_onblur()"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">대표자</td>
														<td width="*"><input id="txtBOSS" type="text" notnull style="width:60px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">대표자주민번호</td>
														<td width="*"><input id="txtBOSS_NO" type="text" datatype="regno" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">업태</td>
														<td width="*"><input id="txtBIZCOND" type="text" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">업종</td>
														<td width="*"><input id="txtBIZKND" type="text" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">개업일자</td>
														<td width="72"><input id="txtOPEN_DT" Datatype="date" type="text" style="width:70px"></td>
														<td width="*"><input id="btnOPEN_DT" type="button" class="img_btnCalendar_S" title="달력" onclick="btnOPEN_DT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">전화번호</td>
														<td width="*"><input id="txtTELNO" type="text" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">사업장주소</td>
														<td width="52"><input id="txtBIZPLACE_ZIPCODE" type="text" style="width:50px"  onblur="txtBIZPLACE_ZIPCODE_onBlur()"></td>
														<td width="210"><input id="txtBIZPLACE_ADDR1" type="text" class="ro" readonly style="width:208px" tabindex="-1"></td>
														<td width="*"><input id="btnBIZPLACE_ZIPCODE" type="button" class="img_btnFind_S" title="우편번호찾기" onclick="btnBIZPLACE_ZIPCODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="115">&nbsp;</td>
														<td width="*"><input id="txtBIZPLACE_ADDR2" type="text" style="width:260px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">관할세무서명</td>
														<td width="*"><input id="txtTAX_OFFICE_NAME" type="text" style="width:120px"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" VALUE="dsMAIN">
			<PARAM NAME="BindInfo" VALUE="
				<C> Col=TAX_COMP_CODE 			Ctrl=txtTAX_COMP_CODE 			Param=value</C>
				<C> Col=COMPANY_NAME 			Ctrl=txtCOMPANY_NAME 			Param=value</C>
				<C> Col=BIZNO 					Ctrl=txtBIZNO	 				Param=value</C>
				<C> Col=BIZNO2					Ctrl=txtBIZNO2					Param=value</C>
				<C> Col=BOSS					Ctrl=txtBOSS					Param=value</C>
				<C> Col=BOSS_NO 				Ctrl=txtBOSS_NO 				Param=value</C>
				<C> Col=BIZCOND	 				Ctrl=txtBIZCOND	 				Param=value</C>
				<C> Col=BIZKND	 				Ctrl=txtBIZKND	 				Param=value</C>
				<C> Col=OPEN_DT 				Ctrl=txtOPEN_DT 				Param=value</C>
				<C> Col=TELNO 					Ctrl=txtTELNO 					Param=value</C>
				<C> Col=BIZPLACE_ZIPCODE 		Ctrl=txtBIZPLACE_ZIPCODE 		Param=value</C>
				<C> Col=BIZPLACE_ADDR1 			Ctrl=txtBIZPLACE_ADDR1 			Param=value</C>
				<C> Col=BIZPLACE_ADDR2 			Ctrl=txtBIZPLACE_ADDR2 			Param=value</C>
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