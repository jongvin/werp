<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCustCodeR.jsp(고객코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-15)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_WCustCodeR";
	String strPageName = "t_WCustCodeR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN, I:dsCUST_ACCNO=dsCUST_ACCNO, I:dsPAY_STOP=dsPAY_STOP)";
	
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strTRADE_CLS = "";
	String strCUST_ACCNO_CLS = "";
	String strGROUP_COMP_CLS = "";
	String strPAY_STOP_CLS = "";
	String strTRADE_CLS_COMBO = "";
	String strCOMP_CODE = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		if(session.getAttribute("emp_no") == null)
		{
			CITDebug.PrintMessages("emp_no session is null");
		}
		CITData lrArgData = new CITData();

 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME, \n";
			strSql += "		a.SEQ \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TRADE_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Union \n";
			strSql += "Select \n";
			strSql += "		'%', \n";
			strSql += "		'전체', \n";
			strSql += "		-1  \n";
			strSql += "from dual \n";
			strSql += "Order By \n";
			strSql += "	3, 1 \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTRADE_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 거래처구분코드 Select 오류 -> " + ex.getMessage());
		}

 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME, \n";
			strSql += "		a.SEQ \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TRADE_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Union \n";
			strSql += "Select \n";
			strSql += "		'', \n";
			strSql += "		'', \n";
			strSql += "		-1  \n";
			strSql += "from dual \n";
			strSql += "Order By \n";
			strSql += "	3, 1 \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTRADE_CLS_COMBO = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 거래처구분코드 Select 오류 -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select 										\n";
			strSql += "		a.CODE_LIST_ID AS CODE, 				\n";
			strSql += "		a.CODE_LIST_NAME AS NAME 				\n";
			strSql += "From	V_T_CODE_LIST a 					   	\n";
			strSql += "Where	a.CODE_GROUP_ID = 'CUST_ACCNO_CLS' 	\n";
			strSql += "And	a.USE_TAG = 'T' 							\n";
			strSql += "Order by	a.SEQ 								\n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCUST_ACCNO_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 계좌구분코드 Select 오류 -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'GROUP_COMP_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strGROUP_COMP_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 계좌구분코드 Select 오류 -> " + ex.getMessage());
		}
		
		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'PAY_STOP_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strPAY_STOP_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 지불정지구분 Select 오류 -> " + ex.getMessage());
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
			var			sCompCode = "<%=strCOMP_CODE%>";
			
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//-->
		<object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
			<param name="CacheLoad" value=true>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCUST_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCUST_CODE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCUST_ACCNO classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsPAY_STOP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCUST_PAYSTOP_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsLOV" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__S7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsACCT" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__S7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__S8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="dsBILL_VENDOR" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" >
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__S8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="<%=strPageName%>">
			<input type='hidden' name='REQUEST_NAME' value="">
			<Input type='hidden' name='REPORT_NO' value="">
			<Input type='hidden' name='REPORT_FILE_NAME' value="">
			<Input type='hidden' name='PARAMETERS' value="">
		</form>
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
								<td class="td_green">
									<!-- 프로그래머 디자인 시작 //-->
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >출력구분</td>
											<td width="135">
												<SELECT id="cboExportTag" style="WIDTH: 60px">
													<OPTION VALUE='P' selected>PDF
													<OPTION VALUE='E'>EXCEL
													<OPTION VALUE='W'>WORD
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="60" class="font_green_bold" >실행구분</td>
											<td width="100">
												<SELECT id="cboRunTag" style="WIDTH: 80px">
													<OPTION VALUE='1' selected>바로실행
													<OPTION VALUE='2'>요청
												</SELECT>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="50" class="font_green_bold" >요청명</td>
											<td width="150"><input id="txtRequestName" type="text" style="width:150px"></td>
											<td  width="*"  align=right><input id="btnPreView" type="button" class="img_btn2_1" value="출력" onclick="btnPreView_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"></td>
										</tr>
									</table>
									<!-- 프로그래머 디자인 종료 //-->
								</td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td height="5"></td>
							</tr>
							<tr class="head_line"> 
								<td width="*" height="1"></td>
							</tr>
							<tr> 
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="75" class="font_green_bold" >거래처구분</td>
											<td width="118"><select name="cboTRADE_CLS" style="WIDTH: 80px" class="input_listbox_default"><%=strTRADE_CLS%></select></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="100" class="font_green_bold" >거래처코드(명)</td>
											<td width="*"><input id="txtSEARCH_CONDITION" type="text" style="width:250px">(코드 검색시 하이픈(-)없이 입력하세요)</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="75" class="font_green_bold" >계좌조회</td>
											<td width="*"><input id="txtACCNO" type="text" style="width:250px">(코드 검색시 하이픈(-)없이 입력하세요)</td>
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
					<td width="100%">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="15" height="20"><img src="../images/bullet1.gif"></td>
								<td width="90" class="font_green_bold">거래처목록</td>
								<td  width="*"  align=right>&nbsp;</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="*" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE=" 
											<C> Name=거래처코드 ID=CUST_CODE Width=120 Edit=none
											</C> 
											<C> Name=거래처명 ID=CUST_NAME Width=240 Edit=none
											</C>
											<C> Name=대표자명 ID=BOSS_NAME Width=90 Edit=none
											</C>
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
									&nbsp;
								</td>
								<td width="515" height="100%" onActivate="G_focusDataset(dsMAIN)">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="10">&nbsp;</td>
											<td width="15"><img src="../images/bullet2.gif"></td>
											<td width="*" height="30" class="font_green_bold">기본사항</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">거래처코드</td>
											<td width="120">
												<input id="txtTRADE_CLS" 	type="hidden">
												<input id="txtCUST_SEQ" 	type="hidden">
												<input id="txtCUST_CODE_F" 	type="hidden">
												<input id="txtCUST_CODE" type="text" datatype="na" notnull style="width:95px" MaxLength="20" onblur="txtCUST_CODE_onBlur()" onfocus="txtCUST_CODE_F.value = txtCUST_CODE.value">
											</td>
											<td width="*">
												&nbsp;
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">거래처명</td>
											<td width="*">
												<input id="txtCUST_NAME_F" 	type="hidden">
												<input id="txtCUST_NAME" type="text" datatype="hna" notnull style="width:160px" onblur="txtCUST_NAME_onBlur()" onfocus="txtCUST_NAME_F.value = txtCUST_NAME.value">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">대표자명</td>
											<td width="*">
												<input id="txtBOSS_NAME" type="text" datatype="hna"   style="width:90px">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">업태</td>
											<td width="*">
												<input id="txtBIZCOND" type="text" datatype="hna"   style="width:120px">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">업종</td>
											<td width="*">
												<input id="txtBIZKND" type="text" datatype="hna"   style="width:120px">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">우편번호</td>
											<td width="52">
												<input id="txtZIPCODE_F" 	type="hidden">
												<input id="txtZIPCODE" type="text" center style="width:50px" onblur="txtZIPCODE_onBlur()" onfocus="txtZIPCODE_F.value = txtZIPCODE.value">
											</td>
											<td width="*">
												<input id="btnZIPCODE" 	type="button" class="img_btnfind_s" onclick="btnZIPCODE_onClick()" title="우편번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">주소1</td>
											<td width="*">
												<input id="txtADDR1" type="text" left  datatype="hna" class = "ro" readonly style="width:250px">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">주소2</td>
											<td width="*">
												<input id="txtADDR2" type="text" left  datatype="hna"  style="width:250px">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">전화번호</td>
											<td width="*">
												<input id="txtTELNO" type="text"   style="width:90px">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">대표거래처코드</td>
											<td width="97">
												<input id="txtREPRESENT_CUST_SEQ" 		type="hidden">
												<input id="txtREPRESENT_CUST_CODE" type="text" class="ro" readonly style="width:95px">
											</td>
											<td width="*">
												<input id="btnREPRESENT_CUST_CODE" 	type="button" class="img_btnfind_s" onclick="btnREPRESENT_CUST_CODE_onClick()" title="대표거래처찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">대표거래처명</td>
											<td width="*">
												<input id="txtREPRESENT_CUST_NAME" type="text" class = "ro" readonly style="width:160px">
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">계열사여부</td>
											<td width="*">
												<select id="cboGROUP_COMP_CLS" style="WIDTH: 100px" class="input_listbox_default"><%=strGROUP_COMP_CLS%>
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="90">회계사용여부</td>
											<td width="*">
												<select  id="cboUSE_CLS"  style="WIDTH: 100px">
													<OPTION value="T" selected>회계사용</OPTION>
													<OPTION value="F">회계미사용</OPTION>
												</select>
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="*" height="5"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="head_line">
								<td width="*" height="3"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 시작 //-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td height="5"></td>
							</tr>
						</table>
						<!-- 간격조정 테이블 종료 //-->
					</td>
				</tr>
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="*">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td width="*" class="font_green_bold"> 거래처지급계좌</td>
											<td align="right">
												<input name="btnSearchCashAccNo" type="button" class="img_btn5_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="수취인조회" onclick="btnSearchCashAccNo_onClick()"/>
												<input name="btnSearchBillAccNo" type="button" class="img_btn8_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT "value="전자어음업체조회" onclick="btnSearchBillAccNo_onClick()"/>
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10"></td>
								<td width="*">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td width="*" class="font_green_bold"> 지불/거래정지사유</td>
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
								<td width="*" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridACCNO WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsCUST_ACCNO">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=계좌번호 ID=ACCNO Width=130 
											</FC> 
											<C> Name=은행명 ID=BANK_MAIN_NAME Width=130 EditStyle=Popup
											</C> 
											<C> Name=예금주 ID=ACCNO_OWNER Width=70
											</C> 
											<C> Name=계좌구분 ID=ACCNO_CLS EditStyle=Combo Data='<%=strCUST_ACCNO_CLS%>' Width=65
											</C> 
											<C> Name=당사인출계좌 ID=OUT_ACCNO  Width=160
											</C> 
											<C> Name=폐기일 ID=CLOSE_DT Width=90
											</C> 
											<C> Name=사용구분 ID=USE_TG Width=55 EditStyle=CheckBox
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
								<td width="10"></td>
								<td width="500">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridPAY_STOP WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsPAY_STOP">
										<PARAM NAME="Editable" VALUE="true">
										<PARAM NAME="ColSelect" VALUE="true">
										<PARAM NAME="ColSizing" VALUE="true">
										<PARAM NAME="Format" VALUE=" 
											<FC> Name=구분 ID=PAY_STOP_CLS  Align=Center EditStyle=Combo Data='<%=strPAY_STOP_CLS%>' Width=75 
											</FC> 
											<FC> Name=시작일 ID=PAY_STOPSTR_DT Align=Center Width=85 EditStyle=popup
											</FC> 
											<FC> Name=종료일 ID=PAY_STOPEND_DT Align=Center Width=85 EditStyle=popup
											</FC> 
											<C> Name=정지사유 ID=PAY_STOPSTR_MEMO Width=170 
											</C> 
											<C> Name=해제사유 ID=PAY_STOPEND_MEMO Width=170
											</C> 
											<C> Name=지불정지현장 ID=DEPT_NAME Width=170 EditStyle=popup
											</C> 
											">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
								</td>
							</tr>
							<tr>
								<td width="*">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
									</table>
								</td>
								<td width="10"></td>
								<td width="500">
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
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=ADE_Bind_1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT >
			<PARAM NAME="DataID" VALUE="dsMAIN">
			<PARAM NAME="BindInfo" VALUE="
				<C>Col=CUST_SEQ Ctrl=txtCUST_SEQ Param=value
				</C>
				<C>Col=CUST_CODE Ctrl=txtCUST_CODE Param=value
				</C>
				<C>Col=TRADE_CLS Ctrl=txtTRADE_CLS Param=value
				</C>
				<C>Col=CUST_NAME Ctrl=txtCUST_NAME Param=value
				</C>
				<C>Col=BOSS_NAME Ctrl=txtBOSS_NAME Param=value
				</C>
				<C>Col=BIZCOND Ctrl=txtBIZCOND Param=value
				</C>
				<C>Col=BIZKND Ctrl=txtBIZKND Param=value
				</C>
				<C>Col=ZIPCODE Ctrl=txtZIPCODE Param=value
				</C>
				<C>Col=ADDR1 Ctrl=txtADDR1 Param=value
				</C>
				<C>Col=ADDR2 Ctrl=txtADDR2 Param=value
				</C>
				<C>Col=TELNO Ctrl=txtTELNO Param=value
				</C>
				<C>Col=REPRESENT_CUST_SEQ Ctrl=txtREPRESENT_CUST_SEQ Param=value
				</C>
				<C>Col=REPRESENT_CUST_CODE Ctrl=txtREPRESENT_CUST_CODE Param=value
				</C>
				<C>Col=REPRESENT_CUST_NAME Ctrl=txtREPRESENT_CUST_NAME Param=value
				</C>
				<C>Col=GROUP_COMP_CLS Ctrl=cboGROUP_COMP_CLS Param=value
				</C>
				<C>Col=USE_CLS Ctrl=cboUSE_CLS Param=value
				</C>
				">
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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