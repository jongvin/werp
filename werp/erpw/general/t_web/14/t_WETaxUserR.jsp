<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxDeptR(사용자 등록)
/* 2. 유형(시나리오) : 사업장의 조회 및 입력
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 배민정 작성(2006-05-11)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strFileName = "./t_WETaxUserR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strCombo = "";
	String strAdjust = "";
	String strPayStatus = "";
	String	strDTF = "";
	String	strUserNo = "";
	String	strDivGroup = "";
	CITData		lrArgData = null;	
	PrintWriter	mmm;
	/*
	String strPageURI = request.getRequestURI();
	StringTokenizer _st = new StringTokenizer(strPageURI,"/");
	String strTemp = "";
	while(_st.hasMoreTokens()){
	  strTemp = _st.nextToken();
	}

	strFileName = strTemp.replace(".jsp","");
	*/
	try
	{
		CITCommon.initPage(request, response, session);
		//사업장 설정
/*		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		if(CITCommon.isNull(strCOMP_CODE))
		{
			lrArgData = new CITData();
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
*/
		lrArgData = new CITData();
		try
		{
			strSql  = " Select \n";
			strSql += "     CD_CODE CODE, \n";
			strSql += "     KN_CODE NAME \n";
			strSql += " From	 TB_WT_COMMON_CODE  \n";
			strSql += " Where	 CD_CLASS = 'ELE001'  \n";
			strSql += " Union \n";
			strSql += " Select \n";
			strSql += "     '' CODE, \n";
			strSql += "     '' NAME \n";
			strSql += " From	 DUAL  \n";
				
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strDivGroup = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");

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
</script>
		
		<script language="javascript">
		<!--
			var	sSelectPageName = "<%=strFileName%>_q.jsp";
		//-->
		</script>

		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
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
											<td width="379">
											<table width="379" border="0" cellspacing="0" cellpadding="0">
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="80" class=font_green_bold>계열사코드</td>
											<td width="62">
											<input name="txtCOMP_CODE" type="text" class="han" style="width:60px" onblur="txtCOMP_CODE_onblur()"></td>
											<td width="152">
											<input name="txtCOMP_NAME" type="text" class="ro" readOnly style="width:150px" ></td>
											<td width="70">
											<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
											</td>
											<td>&nbsp; </td>
											</table>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="70" class=font_green_bold>사용자NO</td>
											<td width="100">
											<input name="txtHUSER_CODE" type="text" class="han" style="width:100px" VALUE="" ></td>
											<td>&nbsp; </td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90" class=font_green_bold>WEBTAX21 ID</td>
											<td width="100">
											<input name="txtHWEBTAX21_ID" type="text" class="han" style="width:100px" VALUE="" ></td>
											<td>&nbsp; </td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class=font_green_bold>사용자명</td>
											<td width="100">
											<input name="txtHUSER_NAME" type="text" class="han" style="width:100px" VALUE="" ></td>
											<td>&nbsp; </td>
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
											<td class="font_green_bold"> 사용자 목록</td>
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
												<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
													<PARAM NAME="DataID" VALUE="dsMAIN">
													<PARAM NAME="Editable" VALUE="true">
													<PARAM NAME="ColSelect" VALUE="true">
													<PARAM NAME="ColSizing" VALUE="true">
													<PARAM NAME="Format" VALUE="
														<FC> Name=사용자 NO ID=emp_no Align=Center Width=70 Edit=none
														</FC>
														<FC> Name=WEBTAX21 ID ID=EMP_ID Width=80 Edit=none
														</FC>
														<C> Name=사용자명 ID=EMP_NAME  Width=80 Edit=none
														</C>
														<C> Name=사업자번호 ID=REG_NUM Align=Center Width=90 Edit=none
														</C>
														<C> Name=전화번호 ID=TEL_NO Width=100 Edit=none
														</C>
														<C> Name=Email ID=EMAIL Width=100 Edit=none
														</C>
														<C> Name=퇴직여부 ID=RET_YN Align=Center Width=60 Edit=none EditStyle=CheckBox
														</C>
														<C> Name=사용자그룹 ID=DIV_NAME Width=120 Edit=none
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
														<td width="100">계열사코드</td>
														<td width="62">
														<input id="txtCOM_ID" type="text" notnull style="width:60px" onblur="txtCOM_ID_onblur()" ></td>
														<td width="152">
														<input id="txtCOM_NAME" type="text" notnull class="ro"  style="width:150px" ></td>
														<td width="*">
														<input id="btnCOM_ID" type="button" class="img_btnFind" value="검색" onclick="btnCOM_ID_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">사용자 NO</td>
														<td width="*"><input id="txtEMP_NO" type="text" notnull style="width:120px" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">WEBTAX21 ID</td>
														<td width="*"><input id="txtEMP_ID" type="text" notnull style="width:120px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">사용자명</td>
														<td width="*"><input id="txtEMP_NAME" notnull type="text" style="width:120" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">암호</td>
														<td width="*"><input id="txtPASSWORD" type="text" style="width:120px" ></td>
													</tr>
												</table>												
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">사업자번호</td>
														<td width="82">
														<input id="txtREG_NUM" type="text" notnull style="width:80px" onblur="txtREG_NUM_onblur()" ></td>
														<td width="132">
														<input id="txtCOMPANY" type="text" notnull class="ro"  style="width:130px" ></td>
														<td width="*">
														<input id="btnREG_NUM" type="button" class="img_btnFind" value="검색" onclick="btnREG_NUM_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">부서코드</td>
														<td width="82">
														<input id="txtSECT_CODE" type="text" notnull style="width:80px" onblur="txtSECT_CODE_onblur()" ></td>
														<td width="132">
														<input id="txtSECT_NAME" type="text" notnull class="ro"  style="width:130px" ></td>
														<td width="*">
														<input id="btnSECT_CODE" type="button" class="img_btnFind" value="검색" onclick="btnSECT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">직급</td>
														<td width="*"><input id="txtGRADE" type="text" style="width:150px" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">전화번호</td>
														<td width="*"><input id="txtTEL_NO" type="text" style="width:150px" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">주민등록번호</td>
														<td width="*"><input id="txtRES_NO" type="text" style="width:150px" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">사용자그룹</td>
														<td width="*">
															<select  id="cboDIV_GROUP"  style="WIDTH: 150px">
																<%=strDivGroup%>
															</select></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">모바일</td>
														<td width="*"><input id="txtMOBILE" type="text" style="width:150px" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">Email</td>
														<td width="*"><input id="txtEMAIL" type="text" style="width:150px" ></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">퇴직여부</td>
														<td width="*"><input id="txtRET_YN" type="checkbox" style="width:50px" ></td>
													</tr>
												</table>																								
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">입력일</td>
														<td width="*"><input id="txtINSERT_DATE" type="text" readonly class="ro" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">입력자</td>
														<td width="*"><input id="txtINSERT_EMP" type="text" readonly class="ro" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">최종수정일</td>
														<td width="*"><input id="txtUPDATE_DATE" type="text" readonly class="ro" style="width:150px"></td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="15"><img src="../images/bullet3.gif"></td>
														<td width="100">수정자</td>
														<td width="*"><input id="txtUPDATE_EMP" type="text" readonly class="ro" style="width:150px"></td>
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
			
				<C> Col=COM_ID 			Ctrl=txtCOM_ID 			Param=value</C>
				<C> Col=COM_NAME 		Ctrl=txtCOM_NAME 		Param=value</C>
				<C> Col=EMP_NO 			Ctrl=txtEMP_NO 			Param=value</C>
				<C> Col=EMP_ID			Ctrl=txtEMP_ID			Param=value</C>
				<C> Col=EMP_NAME 		Ctrl=txtEMP_NAME	 	Param=value</C>
				<C> Col=PASSWORD		Ctrl=txtPASSWORD		Param=value</C>
				<C> Col=REG_NUM 		Ctrl=txtREG_NUM 		Param=value</C>
				<C> Col=COMPANY 		Ctrl=txtCOMPANY 		Param=value</C>
				<C> Col=SECT_CODE 	Ctrl=txtSECT_CODE 	Param=value</C>
				<C> Col=SECT_NAME 	Ctrl=txtSECT_NAME 	Param=value</C>
				<C> Col=GRADE  			Ctrl=txtGRADE 			Param=value</C>
				<C> Col=TEL_NO  		Ctrl=txtTEL_NO 			Param=value</C>
				<C> Col=RES_NO  		Ctrl=txtRES_NO 			Param=value</C>
				<C> Col=RET_YN  		Ctrl=txtRET_YN 			Param=checked</C>
				<C> Col=EMAIL  			Ctrl=txtEMAIL 			Param=value</C>
				<C> Col=MOBILE  		Ctrl=txtMOBILE 			Param=value</C>
				<C> Col=DIV_GROUP  	Ctrl=cboDIV_GROUP 	Param=value</C>
				<C> Col=INPUT_DATE  Ctrl=txtINSERT_DATE	Param=value</C>
				<C> Col=UPDATE_DATE Ctrl=txtUPDATE_DATE Param=value</C>
				<C> Col=INPUT_EMP  	Ctrl=txtINSERT_EMP 	Param=value</C>
				<C> Col=UPDATE_EMP  Ctrl=txtUPDATE_EMP 	Param=value</C>
			">
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
