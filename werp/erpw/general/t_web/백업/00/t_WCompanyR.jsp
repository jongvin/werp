<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompanyR(사업장 등록)
/* 2. 유형(시나리오) : 사업장의 조회 및 입력
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-11)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strFileName = "./t_WCompanyR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	/*
	String strPageURI = request.getRequestURI();
	StringTokenizer _st = new StringTokenizer(strPageURI,"/");
	String strTemp = "";
	while(_st.hasMoreTokens()){
	  strTemp = _st.nextToken();
	}

	strFileName = strTemp.replace(".jsp","");
	*/

	String strOut = "";
	String strSql = "";
	String strAct = "";
	PrintWriter	mmm;
	try
	{
		CITCommon.initPage(request, response, session);
		//out =  new MyJspWriter(out);
		//response.setWriter(mmm);
		
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
</script>
		
		<script language="javascript">
		<!--
			var	sSelectPageName = "<%=strFileName%>_q.jsp";
		//-->
		</script>

		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object>
		<object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object>
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
											<td width="55" class="font_green_bold" >사업장명</td>
											<td width="*"><input id="txtCOMPANY_NAME_S" type="text" style="width:150px"></td>
											<td width="*">&nbsp;</td>
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
											<td class="font_green_bold"> 사업장 목록</td>
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
											<td id="kkk" width="*" height="100%">
												<OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="Format" VALUE="
														<FC> Name=사업장코드 ID=COMP_CODE Align=Center Width=70 Edit=none
														</FC>
														<FC> Name=사업장명칭 ID=COMPANY_NAME Width=150 Edit=none
														</FC>
														<C> Name=사업자번호 ID=BIZNO Align=Center Width=100 Edit=none
														</C>
														<C> Name=법인번호 ID=BIZNO2 Align=Center Width=100 Edit=none
														</C>
														<C> Name=대표자 ID=BOSS Align=Center Width=60 Edit=none
														</C>
														">
												</OBJECT>
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
														<td width="100">사업장코드</td>
														<td width="*"><input id="txtCOMP_CODE" type="text" style="width:60px" datatype="N" MaxLength="10" notnull></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">사업장명칭</td>
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
														<td width="*"><input id="txtBOSS_NO" type="text" datatype="regno2" style="width:100px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">업태</td>
														<td width="*"><input id="txtBIZCOND" type="text" style="width:180px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">업종</td>
														<td width="*"><input id="txtBIZKND" type="text" style="width:180px"></td>
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
														<td width="52"><input id="txtBIZPLACE_ZIPCODE" type="text" style="width:50px" onblur="txtBIZPLACE_ZIPCODE_onblur()"></td>
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
														<td width="100">본사주소</td>
														<td width="52"><input id="txtHEADOFF_ZIPCODE" type="text" style="width:50px" onblur="txtHEADOFF_ZIPCODE_onblur()"></td>
														<td width="210"><input id="txtHEADOFF_ADDR1" type="text" class="ro" readonly style="width:208px" tabindex="-1"></td>
														<td width="*"><input id="btnHEADOFF_ZIPCODE" type="button" class="img_btnFind_S" title="우편번호찾기" onclick="btnHEADOFF_ZIPCODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="115">&nbsp;</td>
														<td width="*"><input id="txtHEADOFF_ADDR2" type="text" style="width:260px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">본지사구분</td>
														<td width="*">
															<select  id="cboHEAD_BRANCH_CLS"  style="WIDTH: 50px">
																<OPTION value='1' selected>본사</OPTION>
																<OPTION value='2'>지사</OPTION>
															</select>
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">본사코드</td>
														<td width="62"><input id="txtHEAD_COMP_CODE" type="text" style="width:60px" onblur="txtHEAD_COMP_CODE_onblur()"></td>
														<td width="150"><input id="txtHEAD_COMP_NAME" type="text" readOnly class="ro" style="width:148px"></td>
														<td width="*"><input id="btnHEAD_COMP_CODE" type="button" class="img_btnFind_S" title="본점찾기" onclick="btnHEAD_COMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">출납부서</td>
														<td width="62"><input id="txtDEPT_CODE" type="text" style="width:60px" onblur="txtDEPT_CODE_onblur()"></td>
														<td width="150"><input id="txtDEPT_NAME" type="text" readOnly class="ro" style="width:148px"></td>
														<td width="*"><input id="btnDEPT_CODE" type="button" class="img_btnFind_S" title="부서찾기" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">회계부서</td>
														<td width="62"><input id="txtACC_DEPT_CODE" type="text" style="width:60px" onblur="txtACC_DEPT_CODE_onblur()"></td>
														<td width="150"><input id="txtACC_DEPT_NAME" type="text" readOnly class="ro" style="width:148px"></td>
														<td width="*"><input id="btnACC_DEPT_CODE" type="button" class="img_btnFind_S" title="부서찾기" onclick="btnACC_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">자금부서</td>
														<td width="62"><input id="txtFIN_DEPT_CODE" type="text" style="width:60px" onblur="txtFIN_DEPT_CODE_onblur()"></td>
														<td width="150"><input id="txtFIN_DEPT_NAME" type="text" readOnly class="ro" style="width:148px"></td>
														<td width="*"><input id="btnFIN_DEPT_NAME" type="button" class="img_btnFind_S" title="부서찾기" onclick="btnFIN_DEPT_NAME_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">관할세무서명</td>
														<td width="*"><input id="txtTAX_OFFICE_NAME" type="text" style="width:120px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">당기회계기수</td>
														<td width="*"><input id="txtACCOUNT_CURR" Datatype="CURRENCY" notNull type="text" style="width:30px" MaxLength="2"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">회기시작일</td>
														<td width="72"><input id="txtACCOUNT_FDT" Datatype="date" notNull type="text" style="width:70px"></td>
														<td width="*"><input id="btnACCOUNT_FDT" type="button" class="img_btnCalendar_S" title="달력" onclick="btnACCOUNT_FDT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">회기종료일</td>
														<td width="72"><input id="txtACCOUNT_EDT" Datatype="date" notNull type="text" style="width:70px"></td>
														<td width="*"><input id="btnACCOUNT_EDT" type="button" class="img_btnCalendar_S" title="달력" onclick="btnACCOUNT_EDT_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
													</tr>
												</table>
												<!--<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">예산전용가능여부</td>
														<td width="*"><input id="chkBUDG_DIVERT_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'BUDG_DIVERT_CLS') = this.checked ? 'T' : 'F'"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">예산이월가능여부</td>
														<td width="*"><input id="chkBUDG_TRANS_CLS" type="checkbox" class="check" onclick="javascript:dsMAIN.NameValue(dsMAIN.RowPosition, 'BUDG_TRANS_CLS') = this.checked ? 'T' : 'F'"></td>
													</tr>
												</table>-->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">본지사계정</td>
														<td width="62"><input id="txtCOMPANY_ACC_CODE" type="text" style="width:60px" onblur="txtCOMPANY_ACC_CODE_onblur()"></td>
														<td width="150"><input id="txtCOMPANY_ACC_NAME" type="text" readOnly class="ro" style="width:148px"></td>
														<td width="*"><input id="btnCOMPANY_ACC_CODE" type="button" class="img_btnFind_S" title="계정찾기" onclick="btnCOMPANY_ACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
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
		<OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" VALUE="dsMAIN">
			<PARAM NAME="BindInfo" VALUE="
				<C> Col=COMP_CODE 				Ctrl=txtCOMP_CODE 				Param=value</C>
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
				<C> Col=HEADOFF_ZIPCODE 		Ctrl=txtHEADOFF_ZIPCODE 		Param=value</C>
				<C> Col=HEADOFF_ADDR1 			Ctrl=txtHEADOFF_ADDR1 			Param=value</C>
				<C> Col=HEADOFF_ADDR2 			Ctrl=txtHEADOFF_ADDR2 			Param=value</C>
				<C> Col=HEAD_BRANCH_CLS 		Ctrl=cboHEAD_BRANCH_CLS 		Param=value</C>
				<C> Col=HEAD_COMP_CODE 			Ctrl=txtHEAD_COMP_CODE 			Param=value</C>
				<C> Col=HEAD_COMP_NAME 			Ctrl=txtHEAD_COMP_NAME 			Param=value</C>
				<C> Col=DEPT_CODE 				Ctrl=txtDEPT_CODE 				Param=value</C>
				<C> Col=DEPT_NAME 				Ctrl=txtDEPT_NAME 				Param=value</C>
				<C> Col=FIN_DEPT_CODE 			Ctrl=txtFIN_DEPT_CODE 				Param=value</C>
				<C> Col=FIN_DEPT_NAME 			Ctrl=txtFIN_DEPT_NAME 				Param=value</C>
				<C> Col=ACC_DEPT_CODE 			Ctrl=txtACC_DEPT_CODE 				Param=value</C>
				<C> Col=ACC_DEPT_NAME 			Ctrl=txtACC_DEPT_NAME 				Param=value</C>
				<C> Col=TAX_OFFICE_NAME 		Ctrl=txtTAX_OFFICE_NAME 		Param=value</C>
				<C> Col=ACCOUNT_CURR 			Ctrl=txtACCOUNT_CURR 			Param=value</C>
				<C> Col=ACCOUNT_FDT 			Ctrl=txtACCOUNT_FDT 			Param=value</C>
				<C> Col=ACCOUNT_EDT 			Ctrl=txtACCOUNT_EDT 			Param=value</C>
				<C> Col=COMPANY_ACC_CODE 		Ctrl=txtCOMPANY_ACC_CODE 			Param=value</C>
				<C> Col=COMPANY_ACC_NAME 		Ctrl=txtCOMPANY_ACC_NAME 			Param=value</C>
			">
		</OBJECT>
		<!-- 가우스 Bind 객체정의 종료 //-->
				<!--
				<C> Col=BUDG_DIVERT_CLS 		Ctrl=chkBUDG_DIVERT_CLS 		Param=checked</C>
				<C> Col=BUDG_TRANS_CLS 			Ctrl=chkBUDG_TRANS_CLS 			Param=checked</C>
				-->
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
