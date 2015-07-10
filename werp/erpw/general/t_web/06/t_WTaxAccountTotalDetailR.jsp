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
	String strFileName = "./t_WTaxAccountTotalDetailR";
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN)";

	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strCOMP_CODE = "";
	String strDEPT_CODE = "";
	String strCOMPANY_NAME = "";
	String strACC_GRP_CODE = "";

	String strTAX_YEAR = "";
	String cboTAX_YEAR = "";
	String strTAX_GI = "";
	String strTAX_CONF = "";

	String strUDT_TAG = "";
	String strRCPTBILL_CLS = "";
	String cboRCPTBILL_CLS = "";
	String strSALEBUY_CLS = "";
	String cboSALEBUY_CLS = "";
	String strVAT_CODE = "";
	String cboSUBTR_CLS = "";
	try
	{
		CITCommon.initPage(request, response, session);
		CITData lrArgData = new CITData();

		//세무신고기수 - 년도
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TAX_YEAR' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTAX_YEAR = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			cboTAX_YEAR = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//세무신고기수 - 기수
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TAX_GI' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTAX_GI = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//세무신고기수 - 예정/확정
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'TAX_CONF' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strTAX_CONF = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//수정여부
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'UDT_TAG' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strUDT_TAG = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//계산서구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where a.CODE_GROUP_ID = 'RCPTBILL_CLS' \n";
			//strSql += "And	a.CODE_LIST_ID IN ('01','02') \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strRCPTBILL_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			cboRCPTBILL_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//매입/매출
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SALEBUY_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strSALEBUY_CLS = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
			cboSALEBUY_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//부가세코드
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.VAT_CODE AS CODE, \n";
			strSql += "		a.VAT_NAME AS NAME \n";
			strSql += "From	T_ACC_VAT_CODE a \n";
			strSql += "Where a.VAT_CODE IS NOT NULL \n";
			strSql += "--And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.VAT_CODE ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strVAT_CODE = CITCommon.toGauceComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SUBTR_CLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order by	a.SEQ \n";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			cboSUBTR_CLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 계좌구분코드 Select 오류 -> " + ex.getMessage());
		}

		try
		{
			lrArgData = new CITData();
			strSql  = "SELECT \n";
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
		
		//사업장 설정
		strCOMP_CODE = CITCommon.NvlString(session.getAttribute("comp_code"));
		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			strDEPT_CODE = CITCommon.NvlString(session.getAttribute("dept_code"));
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
<input id="txtCOMP_CODE"	type="hidden">
<input id="txtTAX_YEAR"		type="hidden">
<input id="txtTAX_GI"		type="hidden">
<input id="txtTAX_CONF"		type="hidden">
<input id="txtRCPTBILL_CLS"	type="hidden">
<input id="txtSALEBUY_CLS"	type="hidden">
<input id="txtCUST_CODE"	type="hidden">
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top"> 

					<td width="100%" height="100%">
						<iframe width="0" height="0" name="ifrmSession" src="../common/Session.jsp" frameborder="0" tabindex="-1"></iframe>
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="20"><img src="../images/bullet1.gif"></td>
											<td class="font_green_bold"> 세무신고합계표 세부내역<input id="txtDUMMY" 		type="text" style="width:0px;height:0px;border:none"></td>
											<td align="right" width="*">
<!--
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전 체 선 택" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전체선택취소" />
-->
<input id="btnSearch" type="button" tabindex="-1" class="img_btn4_1" onClick="btnquery_onclick()" 	value="조 회" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnClose" type="button" tabindex="-1" class="img_btn4_1" onClick="window.close()" 	value="닫 기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />

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
										<PARAM NAME="ViewSummary" 	VALUE=1>
										<PARAM NAME="SuppressOption" 	VALUE=1>
<%
String  strBgColor = "BgColor = {ROW_COLOR}";
String  strColor=    "Color   ={Decode(ACC_NAME,'  전 체 계   ','red',    '  전 표 계   ','green',  'black')}";
//BgColor={Decode(TG,'A','',(Decode(TG,'B','','#EBEBEB')))}
//Color={Decode(TG,'A','BLUE','D','RED','')}#E0FEFF
%>
										<PARAM NAME="Format" VALUE="
<C> Name=작업순번 			ID=WORK_NO			Align=Right	 	Width=60   	Edit='none' 	Show='false'  suppress=4
</C> 	
<G> Name=세무신고기수		ID=TAX
	<C> Name=년도 			ID=TAX_YEAR		Align=Center 	Width=50   Edit='none'   Show='true'		EditStyle='Combo' Data='<%=strTAX_YEAR%>' suppress=3
	</C>
	<C> Name=기수 			ID=TAX_GI		Align=Center	Width=40   Edit='none'   	Show='true'		EditStyle='Combo' Data='<%=strTAX_GI%>' suppress=2
	</C>
	<C> Name='예정/확정' 	ID=TAX_CONF		Align=Center	Width=60   Edit='none'   	Show='true'		EditStyle='Combo' Data='<%=strTAX_CONF%>' suppress=1
	</C>
</G>
<C> Name=수정	 			ID=UDT_TAG			Align=Center	Width=40   	Show='true'		Edit='None' EditStyle='Combo' Data='<%=strUDT_TAG%>'
</C>
<C> Name=세무사업장			ID=TAX_COMP_NAME	Align=Left		Width=80 Edit='none'   	Show='false'</C>
<C> Name=사업장				ID=COMP_NAME		Align=Left		Width=80 Edit='none'</C>
<C> Name=계정명 			ID=ACC_NAME			Align=left		Width=100   Show='true'		Edit='none'
</C>
<C> Name=계산서구분 		ID=RCPTBILL_CLS		Align=Center	Width=70 Edit='none' Show='true'		EditStyle='Combo' Data='<%=strRCPTBILL_CLS%>'
</C>
<C> Name='매입/매출' 		ID=SALEBUY_CLS		Align=Center	Width=60 Edit='none'   	Show='true'		EditStyle='Combo' Data='<%=strSALEBUY_CLS%>'
</C>
<C> Name=발행일 			ID=PUBL_DT			Align=Center	Width=70 Edit='none'   	Show='true'		
</C>
<C> Name=전표일자 			ID=MAKE_DT			Align=Center	Width=70   	Show='true'		Edit='None'		
</C>
<C> Name=부가세코드 		ID=VAT_CODE 		Align=left 	Width=70 Edit='none'   	Show='false'		EditStyle='Combo' Data='<%=strVAT_CODE%>'
</C>
<C> Name=공급가액 			ID=SUPAMT			Align=Right		Width=100 Edit='none'   	Show='true'	SumText=@sum SumBgColor=#FFCCCC	
</C>
<C> Name=부가세액 			ID=VATAMT			Align=Right		Width=90 Edit='none'   	Show='true'	SumText=@sum  SumBgColor=#CEEEFF
</C>
<C> Name=부서명 			ID=DEPT_NAME		Align=left		Width=120 Edit='none'   Show='true'	
</C>
<C> Name=거래처명 			ID=CUST_NAME		Align=left		Width=120 Edit='none'   Show='true'	
</C>
<C> Name=전기누락분			ID=MISSING_TAG		Align=Center	Width=80 Edit='none'   	Show='true' 	EditStyle=CheckBox	Edit='none'
</C>
<C> Name=전표번호 			ID=MAKE_SLIPNOLINE	Align=left		Width=120   Show='true'		Edit='none'
</C>
<C> Name=비고 				ID=REMARK			Align=Left		Width=200   Show='true'		Edit='none'
</C>
<C> Name=사업장 			ID=COMP_CODE		Align=Center	Width=100 	Show='false'	Edit='none' 	Show='false'
</C>
<C> Name=작업번호 			ID=WORK_NO			Align=Center	Width=60   	Show='false'	Edit='none'
</C>
<C> Name=순번 				ID=SEQ				Align=Center	Width=60   	Show='false'	Edit='none'
</C>
<C> Name=전표ID 			ID=SLIP_ID			Align=Right		Width=85   	Show='false'	Edit='none'
</C>
<C> Name=전표IDSEQ 			ID=SLIP_IDSEQ		Align=Right		Width=80   	Show='false'	Edit='none'
</C>
<C> Name=권번 				ID=BOOK_NO			Align=Right		Width=80   	Show='false'	Edit='none'
</C>
<C> Name=순번 				ID=BOOK_SEQ			Align=Right		Width=80   	Show='false'	Edit='none'
</C>
<C> Name=폐기일자 			ID=ANNULMENT_DT		Align=Center	Width=80   	Show='false'	Edit='none'
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