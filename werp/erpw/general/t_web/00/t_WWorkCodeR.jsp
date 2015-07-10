<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WWorkCodeR.jsp(자동전표코드등록)
/* 2. 유형(시나리오) : 화면 디자인
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WWorkCodeR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN,I:dsSUB01=dsSUB01,I:dsSUB02=dsSUB02,I:dsSUB03=dsSUB03)";
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCombo = "";
	
	String strCOST_DEPT_KND_TAG = "";
	String strCOST_DEPT_KND_TAG2 = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		CITData lrArgData = new CITData();		
		// 원가현장구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		'%' CODE, \n";
			strSql += "		'전 체  ' NAME, \n";
			strSql += "		0 PRT_SEQ \n";
			strSql += "From	DUAL a \n";
			strSql += "Union All \n";
			strSql += "Select \n";
			strSql += "		a.COST_DEPT_KND_TAG CODE, \n";
			strSql += "		a.COST_DEPT_KND_NAME NAME, \n";
			strSql += "		a.PRT_SEQ \n";
			strSql += "From	T_COST_DEPT_KIND a \n";
			strSql += "Order By PRT_SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCOST_DEPT_KND_TAG = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}
		// 원가현장구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.COST_DEPT_KND_TAG CODE, \n";
			strSql += "		a.COST_DEPT_KND_NAME NAME, \n";
			strSql += "		a.PRT_SEQ \n";
			strSql += "From	T_COST_DEPT_KIND a \n";
			strSql += "Order By PRT_SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCOST_DEPT_KND_TAG2 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}
 		try
		{
			strSql  = "Select \n";
			strSql += "		COMP_CODE CODE, \n";
			strSql += "		COMPANY_NAME NAME \n";
			strSql += "From	T_COMPANY_ORG \n";
			strSql += "Order By COMP_CODE ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCombo = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
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
			var sSelectPageName = "<%=strFileName%>_q.jsp";
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB02 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB03 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsWORK_SLIP_ID classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsWORK_SLIP_IDSEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB01COPY classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSUB02COPY classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
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
					<td width="100%" height="35%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 자동전표코드</td>
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
								<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="Format" VALUE="
<C> Name=코드 ID=WORK_CODE Align=Left Width=100
</C>
<C> Name=코드명 ID=WORK_NAME Align=Left  Width=350
</C>
<C> Name='수정가능여부' ID=SLIP_UPDATE_CLS  EditStyle=CheckBox Width=100
</C>
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="50%">
									<!-- 서브 테이블 시작 //-->
									<!-- 서브 타이틀 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr height="23">
												<!-- 프로그래머 수정 시작 //-->
											<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
											<td width="80" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a onclick="javascript:selectTab(1, 3);" onfocus="this.blur()">계정코드</a></td>
											<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
											<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
											<td width="100" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a onclick="javascript:selectTab(2, 3);" onfocus="this.blur()">부가세코드</a></td>
											<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
											<td width="6"><img id="imgTabLeft3" src="../images/Content_tab_after.gif"></td>
											<td width="100" id="tab3" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a onclick="javascript:selectTab(3, 3);" onfocus="this.blur()">관리담당자</a></td>
											<td width="6"><img id="imgTabRight3" src="../images/Content_tab_back.gif"></td>
											<td width="10" >&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90" class="font_green_bold" >원가현장구분</td>
											<td width="*" >
											<select id="cboCOST_DEPT_KND_TAG" onchange="cboCOST_DEPT_KND_TAG_onchange();"  style="WIDTH: 100px" tabindex="-1" class="input_listbox_default"><%=strCOST_DEPT_KND_TAG%></select>
												&nbsp;
											</td>
										</tr>
									</table>
									<!-- 서브 타이틀 종료 //-->
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
							<tr> 
								<td height="2"></td>
							</tr>
							<tr>
								<td width="100%" height="100%">
									<div id=divTabPage1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td>
												<select id="cboCOST_DEPT_KND_TAG2" style="WIDTH: 100px" tabindex="-1" class="input_listbox_default"><%=strCOST_DEPT_KND_TAG2%></select>
													에서 &nbsp;
												<input id="btnCopy1" type="button" class="img_btn2_1" value="복사"  onclick="btnCopy1_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												</td>
											</tr>
											<tr>
												<td width="100%" height="100%">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" VALUE="dsSUB01">
														<PARAM NAME="Editable" VALUE="-1">
														<PARAM NAME="ViewSummary" VALUE="1">
														<PARAM NAME="ColSelect" VALUE="-1">
														<PARAM NAME="ColSizing" VALUE="-1">
														<param name=UsingOneClick  value="1">
														<PARAM NAME="Format" VALUE=" 
<C> Name=자동전표_작업번호 ID=WORK_CODE Width=40 show=false
</C>
<C> Name=원가현장구분 ID=COST_DEPT_KND_TAG Width=40 align=center show=false
</C>
<C> Name=원가현장구분명 ID=COST_DEPT_KND_NAME Width=100 align=Left
</C>
<C> Name=계정코드 ID=ACC_CODE Width=75  align=center  EditStyle=Popup
</C>
<C> Name=계정명 ID=ACC_NAME Width=135 
</C> 
<C> Name=차대구분 ID=ACC_POSITION Width=60 align=center EditStyle=Combo Data='D:차변,C:대변'
</C> 
<C> Name=적요코드 ID=SUMMARY_CODE Width=60  align=center  EditStyle=Popup
</C>
<C> Name=적요1 ID=SUMMARY1 Width=200
</C> 
<C> Name=적요2 ID=SUMMARY2 Width=130
</C> 
<C> Name=정렬순번 ID=SEQ Width=60
</C>
<C> Name=사용구분 ID=USE_TAG Width=60 EditStyle=Checkbox
</C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
												</td>
											</tr>
										</table>
									</div>
									<div id=divTabPage2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td>
												<select id="cboCOST_DEPT_KND_TAG3" style="WIDTH: 100px" tabindex="-1" class="input_listbox_default"><%=strCOST_DEPT_KND_TAG2%></select>
													에서 &nbsp;
												<input id="btnCopy2" type="button" class="img_btn2_1" value="복사"  onclick="btnCopy2_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
												</td>
											</tr>
											<tr>
												<td width="100%" height="100%">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB02 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" VALUE="dsSUB02">
														<PARAM NAME="Editable" VALUE="-1">
														<PARAM NAME="ColSelect" VALUE="-1">
														<PARAM NAME="ColSizing" VALUE="-1">
														<param name=UsingOneClick  value="1">
														<PARAM NAME="Format" VALUE=" 
<C> Name=자동전표_작업번호 ID=WORK_CODE Width=40 show=false
</C>
<C> Name=원가현장구분 ID=COST_DEPT_KND_TAG Width=40 align=center show=false
</C>
<C> Name=원가현장구분명 ID=COST_DEPT_KND_NAME Width=100 align=Left
</C>
<C> Name=부가세코드 ID=VAT_CODE  Width=70  align=center  EditStyle=Popup
</C>
<C> Name=부가세명 ID=VAT_NAME  Width=160
</C>
<C> Name=정렬순번 ID=SEQ Width=60
</C>
<C> Name=사용구분 ID=USE_TAG Width=60 EditStyle=Checkbox
</C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
												</td>
											</tr>
										</table>
									</div>
									<div id=divTabPage3  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
										<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="100%" height="100%">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSUB03 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" VALUE="dsSUB03">
														<PARAM NAME="Editable" VALUE="-1">
														<PARAM NAME="ColSelect" VALUE="-1">
														<PARAM NAME="ColSizing" VALUE="-1">
														<param name=UsingOneClick  value="1">
														<PARAM NAME="Format" VALUE=" 
<C> Name=소속사업장 ID=COMP_CODE Width=160 EditStyle=Combo Data='<%=strCombo%>'
</C>
<C> Name=담당자사번 ID=CHARGE_PERS  Width=100  align=center  
</C>
<C> Name=담당자명 ID=CHARGE_PERS_NAME  Width=160
</C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
												</td>
											</tr>
										</table>
									</div>
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