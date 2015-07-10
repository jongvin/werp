<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WDeptR(부서코드)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명	
	String strFileName = "./t_PSlipCopyR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_CODE = "";
	String strDEPT_NAME = "";
	String strACC_GRP_CODE = "";

	String strEMP_NO = "";
	String strNAME = "";

	String strSLIP_TRANS_CLS = "";
	String strDEPT_CHG_CLS = "";
	String strSLIP_KIND_TAG = "";
	
	try
	{
		CITCommon.initPage(request, response, session);
		
		try
		{
			CITData lrArgData = new CITData();
			strSql += "SELECT \n";
			strSql += "	''||ACC_GRP_CODE CODE, \n";
			strSql += "	ACC_GRP_NAME NAME \n";
			strSql += "FROM \n";
			strSql += "	T_ACC_GRP \n";
			strSql += "WHERE \n";
			strSql += "	USE_TAG = 'T' \n";
			strSql += "ORDER BY \n";
			strSql += "	ACC_GRP_CODE \n";
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strACC_GRP_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 계정그룹코드1 Select 오류 -> " + ex.getMessage());
		}

		//사용자
		strEMP_NO = CITCommon.NvlString(session.getAttribute("emp_no"));
		strNAME = CITCommon.NvlString(session.getAttribute("name"));

		//권한
		strSLIP_TRANS_CLS = CITCommon.NvlString(session.getAttribute("slip_trans_cls"));
		strDEPT_CHG_CLS = CITCommon.NvlString(session.getAttribute("dept_chg_cls"));
		
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
		strDEPT_NAME = CITCommon.NvlString(session.getAttribute("long_name"));

		CITData	lrArgData = null;

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

		//회계전표분류구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_ID||':'||a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SLIP_KIND_TAG' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "And	( ( 'T'='"+strSLIP_TRANS_CLS+"' ) Or ( 'F'='"+strSLIP_TRANS_CLS+"' And a.CODE_LIST_ID IN ('%','A','B','C','E','F','N','W','G') ) )  \n";
			//strSql += "And	( ( 'T'='"+strSLIP_TRANS_CLS+"' ) Or  ( 'F'='"+strSLIP_TRANS_CLS+"' And a.CODE_LIST_ID IN ('G') ) )  \n";
			//strSql += "And	a.CODE_LIST_ID IN ('G') \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strSLIP_KIND_TAG = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
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
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=CITCommon.enSC(strCOMPANY_NAME)%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=strDEPT_NAME%>";
			var			sEmpno = "<%=strEMP_NO%>";
			var			sName = "<%=strNAME%>";
			var			sSlip_Trans_Cls = "<%=strSLIP_TRANS_CLS%>";
			var			sDept_Chg_Cls = "<%=strDEPT_CHG_CLS%>";

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
											<td class=td_green>
												<!-- 프로그래머 디자인 시작 //-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>사업장</td>
		<td width="112">
			<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="162">
			<input id="txtCOMPANY_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="50">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >작성부서</td>
		<td width="112"> <input name="txtMAKE_DEPT_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtMAKE_DEPT_CODE_onblur()"></td>
		<td width="161"> <input name="txtMAKE_DEPT_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="4">
			<input name="btnMAKE_DEPT" type="button" class="img_btnFind" onclick="btnMAKE_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70"  class="font_green_bold" >작성자</td>
		<td width="112">  <input name="txtMAKE_PERS" 	type="text" datatype="han" style="width:110px" 	VALUE="" onblur="txtMAKE_PERS_onblur()"></td>
		<td width="162"> <input name="txtMAKE_PERS_NAME"	type="text" class="ro" readOnly style="width:160px"	VALUE=""></td>
		<td width="40">
			<input id="btnMAKE_PERS" type="button" class="img_btnFind" onclick="btnMAKE_PERS_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >기준일</td>
		<td width="82">
			<select  name="cboDATE_CLS"  style="WIDTH: 80px">
				<OPTION value="M"> 전표일자</OPTION>
				<OPTION value="K"> 확정일자</OPTION>
			</select>
		</td>
		<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold >전표번호</td>
		<td width="112">
			<input id="txtMAKE_SLIPNO" type="text" tabindex="-1" Center style="width:110px"/>
		</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="60" class=font_green_bold >전표분류</td>
		<td width="136">
			<select id="cboSLIP_KIND_TAG" style="WIDTH: 85px" tabindex="-1" class="input_listbox_default">
				<%=strSLIP_KIND_TAG%>
			</select>
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >금액</td>
		<td width="70">
			<select  name="cboAMT_CLS"  style="WIDTH: 70px">
				<OPTION value="A"> 전&nbsp;&nbsp;체</OPTION>
				<OPTION value="D"> 차&nbsp;&nbsp;변</OPTION>
				<OPTION value="C"> 대&nbsp;&nbsp;변</OPTION>
			</select>
		</td>
		<td width="102"> <input name="txtDBCR_FAMT" type="text" datatype="currency" style="width:100px" VALUE=""></td>
		<td width="10">~</td>
		<td>
			<input name="txtDBCR_EAMT" type="text" datatype="currency" style="width:100px" VALUE="">
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >거래처</td>
		<td width="112"> <input name="txtCUST_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtCUST_CODE_onblur()"></td>
		<td width="161"> <input name="txtCUST_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnCUST_CODE" type="button" class="img_btnFind" onclick="btnCUST_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >확정구분</td>
		<td width="70">
			<select  name="cboKEEP_CLS"  style="WIDTH: 70px">
				<OPTION value="A"> 전&nbsp;&nbsp;체</OPTION>
				<OPTION value="M"> 미확정</OPTION>
				<OPTION value="K"> 확&nbsp;&nbsp;정</OPTION>
			</select>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >계정과목</td>
		<td width="112"> <input name="txtACC_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtACC_CODE_onblur()"></td>
		<td width="161"> <input name="txtACC_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnACC_CODE" type="button" class="img_btnFind" onclick="btnACC_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70"  class="font_green_bold" >증빙코드</td>
		<td width="112">  <input name="txtVAT_CODE" 	type="text" datatype="han" style="width:110px" 	VALUE="" onblur="txtVAT_CODE_onblur()"></td>
		<td width="162"> <input name="txtVAT_NAME"	type="text" class="ro" readOnly style="width:160px"	VALUE=""></td>
		<td>
			<input id="btnVAT_CODE" type="button" class="img_btnFind" onclick="btnVAT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="40">
			&nbsp;
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >귀속부서</td>

		<td width="112"><input id="txtDEPT_CODE" 	type="text" style="width:110px" onblur="txtDEPT_CODE_onblur()"></td>
		<td width="161">
			<input id="txtDEPT_NAME"		type="text" readOnly left class="ro" style="width:159px">
		</td>
		<td width="40">
			<input id="btnPOSS_DEPT_PROJ" type="button" class="img_btnFind" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >적요1</td>
		<td width="325"> <input id="txtSUMMARY1" type="text" datatype="han" style="width:325px" VALUE=""></td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >세무사업장</td>
		<td width="112"> <input name="txtTAX_COMP_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtTAX_COMP_CODE_onblur()"></td>
		<td width="161"> <input name="txtTAX_COMP_NAME" type="text" class="ro" readOnly style="width:159px" VALUE=""></td>
		<td width="40">
			<input name="btnTAX_COMP_CODE" type="button" class="img_btnFind" onclick="btnTAX_COMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="30">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70"  class="font_green_bold" >관리담당</td>
		<td width="112">  <input name="txtCHARGE_PERS" 	type="text" datatype="han" style="width:110px" 	VALUE="" onblur="txtCHARGE_PERS_onblur()"></td>
		<td width="162"> <input name="txtCHARGE_PERS_NAME"	type="text" class="ro" readOnly style="width:160px"	VALUE=""></td>
		<td>
			<input id="btnVAT_CODE" type="button" class="img_btnFind" onclick="btnCHARGE_PERS_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>
		<td width="*">&nbsp;</td>
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
				<tr valign="top"> 
					<td width="100%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 전표내역</td>
											<td align="right" width="*">
												<input id="btnDETAIL_COPY"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnDETAIL_COPY_onClick();"	value="라인복사" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
												<input id="btnRETRIEVE"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnquery_onclick();"	value="조 회" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
												<input id="btnCLOSE"	type="button" tabindex="-1" class="img_btn4_1" onClick="window.close();"	value="닫 기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
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
											<PARAM NAME="Editable"  	VALUE="false">
											<PARAM NAME="ColSelect" 	VALUE="true">
											<PARAM NAME="ColSizing" 	VALUE="true">
											<PARAM NAME="ViewSummary" 	VALUE=1>
											<PARAM NAME="MultiRowSelect"VALUE="true">
										<PARAM NAME="Format" VALUE="
<FC> Name=전표번호	ID=MAKE_SLIPNOLINE	Align=Left	 Width=110 Sort=true BgColor=#ECF5EB Edit='none'
</FC>
<C> Name=확정   		ID=KEEP_CLS 		Align=Center	 Width=50 Sort=true Edit='none' SumText=' 검색항목수 : '
</C>
<C> Name=계정코드 		ID=ACC_CODE 			Align=Center Width=80 Sort=true BgColor=#FFFCE0 Edit='none' SumText=@count
</C>
<C> Name=계정과목 		ID=ACC_NAME 			Align=Left	 Width=120 Sort=true BgColor=#FFFCE0 Edit='none'
</C>
<C> Name=증빙코드 		ID=VAT_NAME 			Align=Left Width=100 Sort=true Edit='none'
</C>
<C> Name=차변 			ID=DB_AMT 				Align=Right	 SumBgColor=#FFCCCC BgColor=#FFECEC Width=95 Edit='none' SumText=@sum
</C>
<C> Name=대변 			ID=CR_AMT 				Align=Right	 SumBgColor=#CEEEFF BgColor=#E0F4FF Width=95 Edit='none' SumText=@sum
</C>
<C> Name='적        요' ID=SUMMARY1 			Align=Left	 Width=170 Sort=true Edit='none'
</C>
<C> Name=거래처코드 	ID=CUST_CODE 			Align=Left	 Width=110 Sort=true Edit='none'
</C>
<C> Name=거래처명 		ID=CUST_NAME 			Align=Left	 Width=140 Sort=true Edit='none'
</C>
<C> Name=귀속부서 		ID=DEPT_NAME 			Align=Left	 Width=100 Sort=true Edit='none'
</C>
<C> Name=은행명 		ID=BANK_NAME 			Align=Left	 Width=100 Sort=true Edit='none'
</C>
<C> Name=사원번호 		ID=EMP_NO 			Align=Left	 Width=80 Sort=true Edit='none'
</C>
<C> Name=사원명    		ID=EMP_NAME 			Align=Left	 Width=80 Sort=true Edit='none'
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