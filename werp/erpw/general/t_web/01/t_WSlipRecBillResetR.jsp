<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSlipRecBillResetR(받을어음반제전표자동생성)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strDt_Trans = CITDate.getNow("yyyyMMdd");
	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strFileName = "./t_WSlipRecBillResetR";
	
//저장 액션
	String strUpdateKeyValue = "Service1(I:dsMAIN=dsMAIN, I:dsMAIN01=dsMAIN01)";

	String strOut = "";
	String strSql = "";
	String strAct = "";
	String strMAKE_SLIPCLS = "";
	String strCOMP_CODE = "";
	String strCOMPANY_NAME = "";
	String strDEPT_CODE = "";
	String strDEPT_NAME = "";
	String strINOUT_DEPT_CODE = "";
	String strINOUT_DEPT_NAME = "";
	String strDEPT_COMP_CODE = "";
	String strDEPT_COMP_NAME = "";
	String strDEPT_TAX_COMP_CODE = "";
	String strDEPT_TAX_COMP_NAME = "";
	String strEMP_NO = "";
	String strNAME = "";
	String strSLIP_TRANS_CLS = "";
	String strDEPT_CHG_CLS = "";
	String strSLIP_KIND_TAG = "";
	
	String strCHARGE_PERS = "";
	String strCHARGE_PERS_NAME = "";
	
	String strCashAccCode = "111010100";
	
	String strWORK_CODE = "0000000003";
	
	try
	{
/*
out.println(""+(String)session.getAttribute("file_upload_dir"));
out.println(""+(String)session.getAttribute("emp_no"));
out.println(""+(String)session.getAttribute("name"));
out.println(""+(String)session.getAttribute("slip_trans_cls"));
out.println(""+(String)session.getAttribute("dept_chg_cls"));
out.println(""+(String)session.getAttribute("comp_code"));
out.println(""+(String)session.getAttribute("dept_code"));
out.println(""+(String)session.getAttribute("long_name"));
*/
			
		CITCommon.initPage(request, response, session, false);
		
		CITData lrArgData = new CITData();

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

		//회계전표분류구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'SLIP_KIND_TAG' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "And	( ( 'T'='"+strSLIP_TRANS_CLS+"' ) Or  ( 'F'='"+strSLIP_TRANS_CLS+"' And a.CODE_LIST_ID IN ('A','C') ) )  \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strSLIP_KIND_TAG = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//전표구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'MAKE_SLIPCLS' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strMAKE_SLIPCLS = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}
		
		try
		{
			lrArgData.addColumn("WORK_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("WORK_CODE", strWORK_CODE);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			
			strSql  = " Select	a.COMP_CODE, \n";
			strSql += " 		b.COMPANY_NAME, \n";
			strSql += " 		b.DEPT_CODE INOUT_DEPT_CODE , \n";
			strSql += " 		c.DEPT_NAME INOUT_DEPT_NAME , \n";
			strSql += " 		a.COMP_CODE DEPT_COMP_CODE , \n";
			strSql += " 		b.COMPANY_NAME DEPT_COMP_NAME , \n";
			strSql += " 		a.TAX_COMP_CODE DEPT_TAX_COMP_CODE, \n";
			strSql += " 		d.COMPANY_NAME DEPT_TAX_COMP_NAME, \n";
			strSql += " 		e.CHARGE_PERS , \n";
			strSql += " 		e.CHARGE_PERS_NAME \n";
			strSql += " From	T_DEPT_CODE a, \n";
			strSql += " 		T_COMPANY b, \n";
			strSql += " 		T_DEPT_CODE c, \n";
			strSql += " 		T_COMPANY d, \n";
			strSql += " ( \n";
			strSql += " 	SELECT \n";
			strSql += " 		A.COMP_CODE, \n";
			strSql += " 		A.CHARGE_PERS, \n";
			strSql += " 		B.NAME CHARGE_PERS_NAME \n";
			strSql += " 	FROM \n";
			strSql += " 		T_WORK_CHARGE_PERS A, \n";
			strSql += " 		Z_AUTHORITY_USER B \n";
			strSql += " 	WHERE \n";
			strSql += " 		A.CHARGE_PERS = B.EMPNO \n";
			strSql += " 		AND A.WORK_CODE = :WORK_CODE \n";
			strSql += " ) e \n";
			strSql += " Where	a.DEPT_CODE =  ?   \n";
			strSql += " And		a.COMP_CODE = b.COMP_CODE(+) \n";
			strSql += " And		b.DEPT_CODE = c.DEPT_CODE(+) \n";
			strSql += " And		a.TAX_COMP_CODE = d.COMP_CODE(+) \n";
			strSql += " And		a.COMP_CODE = e.COMP_CODE(+) \n";



			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			if(lrReturnData.getRowsCount() >= 1)
			{
				strCOMP_CODE = lrReturnData.toString(0,"COMP_CODE");
				strCOMPANY_NAME = lrReturnData.toString(0,"COMPANY_NAME");
				strINOUT_DEPT_CODE = lrReturnData.toString(0,"INOUT_DEPT_CODE");
				strINOUT_DEPT_NAME = lrReturnData.toString(0,"INOUT_DEPT_NAME");
				strDEPT_COMP_CODE = lrReturnData.toString(0,"DEPT_COMP_CODE");
				strDEPT_COMP_NAME = lrReturnData.toString(0,"DEPT_COMP_NAME");
				strDEPT_TAX_COMP_CODE = lrReturnData.toString(0,"DEPT_TAX_COMP_CODE");
				strDEPT_TAX_COMP_NAME = lrReturnData.toString(0,"DEPT_TAX_COMP_NAME");
				strCHARGE_PERS = lrReturnData.toString(0,"CHARGE_PERS");
				strCHARGE_PERS_NAME = lrReturnData.toString(0,"CHARGE_PERS_NAME");

				session.setAttribute("comp_code", strCOMP_CODE);
				session.setAttribute("comp_name", strCOMPANY_NAME);
			}
			
		}
		catch (Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
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
			
			var			sEmpno = "<%=strEMP_NO%>";
			var			sName = "<%=strNAME%>";
			
			var			sSelectPageName = "<%=strFileName%>_q.jsp";
			var			sDt_Trans = "<%=strDt_Trans%>";
			var			sDate = "<%=strDate%>";
			var			sCompCode = "<%=strCOMP_CODE%>";
			var			sCompName = "<%=strCOMPANY_NAME%>";
			var			sDeptCode = "<%=strDEPT_CODE%>";
			var			sDeptName = "<%=strDEPT_NAME%>";
			var			sInout_DeptCode = "<%=strINOUT_DEPT_CODE%>";
			var			sInout_DeptName = "<%=strINOUT_DEPT_NAME%>";
			var			sDept_CompCode = "<%=strDEPT_COMP_CODE%>";
			var			sDept_CompName = "<%=strDEPT_COMP_NAME%>";
			var			sDept_Tax_CompCode = "<%=strDEPT_TAX_COMP_CODE%>";
			var			sDept_Tax_CompName = "<%=strDEPT_TAX_COMP_NAME%>";
			var			sEmpno = "<%=strEMP_NO%>";
			var			sName = "<%=strNAME%>";
			var			sSlip_Trans_Cls = "<%=strSLIP_TRANS_CLS%>";
			var			sDept_Chg_Cls = "<%=strDEPT_CHG_CLS%>";
			
			var			vCashAccCode = "<%=strCashAccCode%>";
			var			vWORK_CODE = "<%=strWORK_CODE%>";
			
			var			sCHARGE_PERS = "<%=strCHARGE_PERS%>";
			var			sCHARGE_PERS_NAME = "<%=strCHARGE_PERS_NAME%>";
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//-->
<object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name=SubSumExpr value="1:EXPR_DT_GRP">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN01 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAKE_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsDAY_CLOSE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsWORK_SLIP_IDSEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsNEW_WORK_SLIP classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsAUTO_REC_BILL_RESET_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
			<param name="KeyValue" value="<%=strUpdateKeyValue%>">
			<param name="Action"    value="<%=strFileName%>_tr.jsp">
		</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()">
		<div id="divMainFix" class="main_div">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<td width="100%" colspan=2>
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
			<input id="txtMAKE_COMP_CODE" type="text" style="width:110px" onblur="txtMAKE_COMP_CODE_onblur()">
		</td>
		<td width="161">
			<input id="txtMAKE_COMP_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="60">
			<input id="btnMAKE_COMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnMAKE_COMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >작성부서</td>
		<td width="112"> <input name="txtMAKE_DEPT_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtMAKE_DEPT_CODE_onblur()"></td>
		<td width="161"> <input name="txtMAKE_DEPT_NAME" type="text" class="ro" readOnly style="width:160px" VALUE=""></td>
		<td width="40">
			<input name="btnMAKE_DEPT" type="button" class="img_btnFind" onclick="btnMAKE_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
		</td>		
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >전표일자</td>
		<td width="72"><input id="txtDT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate.substring(0,4)%>-01-01"/></td>
		<td width="30">
			<input id="btnDT_F" type="button" class="img_btnCalendar_S" onClick="btnDT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtDT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate%>"/></td>
		<td width="30">
			<input id="btnDT_T" type="button" class="img_btnCalendar_S" onClick="btnDT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="55">&nbsp;</td>
		<td width="60">&nbsp;</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >어음만기일</td>
		<td width="72"><input id="txtEXPR_DT_F" type="text" datatype="date" style="width:70px" value = "<%=strDate.substring(0,4)%>-01-01"/></td>
		<td width="30">
			<input id="btnEXPR_DT_F" type="button" class="img_btnCalendar_S" onClick="btnEXPR_DT_F_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="15">~</td>
		<td width="72"><input id="txtEXPR_DT_T" type="text" datatype="date" style="width:70px" value = "<%=strDate.substring(0,4)%>-12-31"/></td>
		<td width="30">
			<input id="btnEXPR_DT_T" type="button" class="img_btnCalendar_S" onClick="btnEXPR_DT_T_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
		</td>
		<td width="*">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class=font_green_bold>귀속사업장</td>
		<td width="112">
			<input id="txtCOMP_CODE" type="text" style="width:110px" onblur="txtCOMP_CODE_onblur()">
		</td>
		<td width="161">
			<input id="txtCOMP_NAME" type="text" readOnly class="ro" style="width:160px">
		</td>
		<td width="60">
			<input id="btnCOMP_CODE" type="button" class="img_btnFind" value="검색" onclick="btnCOMP_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;">
		</td>
		<td width="15"><img src="../images/bullet3.gif"></td>
		<td width="70" class="font_green_bold" >귀속부서</td>
		<td width="112"> <input name="txtDEPT_CODE" type="text" datatype="han" style="width:110px" VALUE="" onblur="txtDEPT_CODE_onblur()"></td>
		<td width="161"> <input name="txtDEPT_NAME" type="text" class="ro" readOnly style="width:160px" VALUE=""></td>
		<td width="60">
			<input name="btnDEPT" type="button" class="img_btnFind" onclick="btnDEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"value="찾기" />
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
								<!-- 간격조정 테이블 시작 //-->
								<table width="800" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10"></td>
									</tr>
								</table>
								<!-- 간격조정 테이블 종료 //-->
								<!-- 서브 테이블 시작 //-->
								<!-- 서브 타이틀 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!-- 프로그래머 수정 시작 //-->
										<td width="15" height="20"><img src="../images/bullet1.gif" width="9" height="9"></td>
										<td class="font_green_bold"> 받을어음 반제전표 생성</td>
										<td align="right">
<input id="btnSlipCreate" type="button" class="img_btn6_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="반제전표생성" onclick="btnSlipCreate_onClick()"/>
<input id="btnSlipDelete" type="button" class="img_btn6_1" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="반제전표삭제" onclick="btnSlipDelete_onClick()"/>
										</td>
										<!-- 프로그래머 수정 종료 //-->
									</tr>
								</table>
								<!-- 서브 타이틀 종료 //-->
								<!-- 서브 본문 시작 //-->
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="100%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
												<tr>
													<td bgcolor="#FFFFFF">
													<!-- 프로그래머 디자인 시작 //-->
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="5">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="60">전표번호</td>
																<td width="58">
																	<input id="txtSLIP_MAKE_DT_F"	type="hidden"/>
																	<input id="txtSLIP_MAKE_DT"	type="text" center datatype="n"  maxlength=8 style="width:57px" tabindex="2" onblur="txtSLIP_MAKE_DT_onblur()" onfocus="txtSLIP_MAKE_DT_F.value = txtSLIP_MAKE_DT.value"/>
																</td>
																<td width="21">
																	<input id="btnSLIP_MAKE_DT" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnSLIP_MAKE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>
																<td width="60">
																	<select id="cboSLIP_KIND_TAG" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default">
																		<%=strSLIP_KIND_TAG%>
																	</select>
																</td>
																<td width="9" class="font_green_bold" ></td>
																<td width="28">
																	<input id="txtSLIP_MAKE_COMP_CODE_F"	type="hidden"/>
																	<input id="txtSLIP_MAKE_COMP_CODE"	type="text" center datatype="an" maxlength=3 style="width:26px" tabindex="1" class="ro" readOnly="true"/>
																</td>
																<td width="9" class="font_green_bold" ></td>
																<td width="35">
																	<input id="txtSLIP_MAKE_SEQ_F"		type="hidden"/>
																	<input id="txtSLIP_MAKE_SEQ"		type="text" center style="width:33px" tabindex="4" class="ro" readOnly="true"/>
																</td>

																<td width=47">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" >사 업 장</td>
											<td width="102">
												<input id="txtSLIP_MAKE_COMP_NAME" 		type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
											</td>
											<td width="38">
												<input name="btnSLIP_MAKE_COMP_CODE"	type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_MAKE_COMP_CODE_onClick()" title="사업장찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" >작성부서</td>
											<td width="122">
												<input id="txtSLIP_MAKE_DEPT_CODE"	type="hidden"/>
												<input id="txtSLIP_MAKE_DEPT_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:120px"/>
											</td>
											<td width="40">
												<input name="btnSLIP_MAKE_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_MAKE_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="작성부서찾기" />
											</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="5">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="60">&nbsp;</td>
																<td width="90">&nbsp;</td>
																<td width="177">&nbsp;</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >관리담당</td>
																<td width="102">
																	<input id="txtSLIP_CHARGE_PERS"		type="hidden"/>
																	<input id="txtSLIP_CHARGE_PERS_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
																</td>
																<td width="38">
																	<input name="btnCHARGE_PERS" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_CHARGE_PERS_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="관리담당찾기" />
																</td>
																<td width="15"><img src="../images/bullet3.gif"></td>
																<td width="54" >출납부서</td>
																<td width="122">
																	<input id="txtSLIP_INOUT_DEPT_CODE"	type="hidden"/>
																	<input id="txtSLIP_INOUT_DEPT_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:120px"/>
																</td>
																<td width="40">
																	<input name="btnSLIP_INOUT_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnSLIP_INOUT_DEPT_CODE_onClick()" title="출납부서찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
																</td>

																<td>&nbsp;</td>
															</tr>
														</table>
														<!-- 프로그래머 디자인 종료 //-->
													</td>
												</tr>
												<tr class="head_line">
													<td width="*" height="3"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								<!-- 서브 본문 종료 //-->
								<!-- 서브 테이블 종료 //-->
					</td>
				</tr>
				<!-- 프로그래머 디자인 시작 //-->
				<tr valign="top"> 
					<td width="65%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr height="23">
												<!-- 프로그래머 수정 시작 //-->
											<td width="6"><img id="imgTabLeft1" src="../images/Content_tab_after_r.gif"></td>
											<td width="140" id="tab1" align="center" background="../images/Content_tab_bgimage_r.gif" class="font_tab"><a href="javascript:selectTab(1, 2);" onfocus="this.blur()">미반제 설정전표내역</a></td>
											<td width="6"><img id="imgTabRight1" src="../images/Content_tab_back_r.gif"></td>
											<td width="6"><img id="imgTabLeft2" src="../images/Content_tab_after.gif"></td>
											<td width="100" id="tab2" align="center" background="../images/Content_tab_bgimage.gif" class="font_tab"><a href="javascript:selectTab(2, 2);" onfocus="this.blur()">반제전표내역</a></td>
											<td width="6"><img id="imgTabRight2" src="../images/Content_tab_back.gif"></td>
											<td width="*" align="right" >
												&nbsp;
<input name="btnSubSelect" type="button" class="img_btn6_1" onclick="btnSubSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="만기일선택" />
<input name="btnAllSelect" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전 체 선 택" />
<input name="btnAllSelCancle" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="전체선택취소" />
<input name="btnAllSelect01" type="button" class="img_btn6_1" onclick="btnAllSelect_onClick01()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="일 괄 선 택" />
<input name="btnAllSelCancle01" type="button" class="img_btn6_1" onclick="btnAllSelCancle_onClick01()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="일괄선택취소" />
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
<div id=divTabPage1  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="ViewSummary" 	VALUE=1>
										<PARAM NAME="Format" VALUE="
<FC> Name=선택 ID=CHK_CLS Width=30 EditStyle=Checkbox
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFFFFF')}
</FC>
<FC> Name=만기일 ID=EXPR_DT Align=Center HeadAlign=Center  Width=70	Edit='none'
suppress=1
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFFFFF')}
</FC>
<FC> Name=작성전표번호 ID=MAKE_SLIPNOLINE Align=Left HeadAlign=Center  Width=110 	Edit='none'
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFFFFF')}
</FC>
<FC> Name=계정명 ID=ACC_NAME Align=Left HeadAlign=Center  Width=100 Show='false'	BgColor='#FFFCE0' 	Edit='none'
</FC>
<C> Name=잔액 ID=ACC_REMAIN_POSITION_NAME Align=Left HeadAlign=Center  Width=35 Show='false' 	Edit='none' 	SumTextAlign=Center
</C>
<C> Name=거래처명 ID=CUST_NAME Align=Left HeadAlign=Center  Width=100 Show='true' 	Edit='none' 	SumTextAlign=Center 	SumText='합        계 :'
Value = {Decode(CUST_NAME,'',EXPR_DT_GRP&' 계',CUST_NAME)}
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFFFFF')}
</C>
<C> Name=설정금액 ID=SET_AMT Align=Right HeadAlign=Center  Width=95 Show='true'	 	Edit='none'		SumText=@sum	BgColor='#FFECEC'	SumBgColor='#F2A6A6'
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFECEC')}
</C>
<C> Name=잔액 ID=REMAIN_AMT Align=Right HeadAlign=Center  Width=95 Show='true'	SumTextAlign=Right	 	Edit='none'	SumText=@sum	BgColor='#ECF5EB' SumBgColor='#B3D7B0'
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#ECF5EB')}
</C>
<C> Name=반제금액 ID=INPUT_AMT Align=Right HeadAlign=Center  Width=95 Show='true' 	SumText=@sum	SumBgColor='#FFE69D'	BgColor='#FFF5D9'
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFF5D9')}
</C>
<C> Name=총반제금액 ID=RESET_AMT Align=Right HeadAlign=Center  Width=95 Show='true'	SumText=@sum	Edit='none'  BgColor='#E0F4FF'	SumBgColor='#A8C9FF'
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#E0F4FF')}
</C>
<C> Name=미확정반제 ID=NOT_RESET_AMT Align=Right HeadAlign=Center  Width=95 Show='true' 	Edit='none'	SumText=@sum	BgColor='#FFECEC'	SumBgColor='#EFDCDC'
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFECEC')}
</C>
<C> Name=적요 ID=SUMMARY1 Align=Left HeadAlign=Center  Width=170 Show='true' 	Edit='none'
BgColor = {Decode(CUST_NAME,'','#EFEEFF', '#FFFFFF')}
</C>
<C> Name=전표번호 ID=SLIP_ID Align=Left  HeadAlign=Center  Width=130 Sort=true Show='false' 	Edit='none'
</C>
<C> Name=전표순번 ID=SLIP_IDSEQ Align=Left HeadAlign=Center  Width=150 Sort=true Show='false' 	Edit='none'
</C>
<C> Name=반제전표번호 ID=RESET_SLIP_ID Align=Left HeadAlign=Center  Width=120 Sort=true Show='false' 	Edit='none'
</C>
<C> Name=반제전표순번 ID=RESET_SLIP_IDSEQ Align=Right HeadAlign=Center  Width=120 Show='false' 	Edit='none'
</C>
<C> Name=이체일자 ID=KEEP_DT Align=Center  HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
<C> Name=이체순번 ID=KEEP_SEQ Align=Center HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
<C> Name=계정코드 ID=ACC_CODE Align=Center HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
<C> Name=거래처코드 ID=CUST_CODE Align=Center HeadAlign=Center  Width=120 Show='true' Show='false' 	Edit='none'
</C>
<C> Name=프로젝트코드 ID=PROJECT_CODE Align=Center HeadAlign=Center  Width=120 Show='true' Show='false' 	Edit='none'
</C>
<C> Name=사원번호 ID=EMP_NO Align=Center HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
										">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
			</td>
		</tr>
	</table>
</div>
<div id=divTabPage2  align="center" border="0" style="OVERFLOW: hidden; WIDTH: 100%; HEIGHT: 100%">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" height="100%">
									<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridMAIN01 WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
										<PARAM NAME="DataID" VALUE="dsMAIN01">
										<PARAM NAME="Editable" VALUE="-1">
										<PARAM NAME="ColSelect" VALUE="-1">
										<PARAM NAME="ColSizing" VALUE="-1">
										<PARAM NAME="ViewSummary" 	VALUE=1>
										<PARAM NAME="Format" VALUE="
<FC> Name=선택 ID=CHK_CLS Align=Center EditStyle=CheckBox Width=30
</FC>
<FC> Name=확정 ID=KEEP_CLS Align=Center EditStyle=CheckBox Width=30	Edit='none'
</FC>
<FC> Name=전표번호 ID=RESET_MAKE_SLIPNOLINE Align=Left HeadAlign=Center  Width=110 Show='true' 	Edit='none'
</FC>
<FC> Name=계정명 ID=ACC_NAME Align=Left HeadAlign=Center  Width=120	BgColor='#FFFCE0' 	Edit='none'
</FC>
<C> Name=잔액 ID=ACC_REMAIN_POSITION_NAME Align=Left HeadAlign=Center  Width=35 Show='true' 	Edit='none' 	SumTextAlign=Center
</C>
<C> Name=부서명 ID=DEPT_NAME Align=Left HeadAlign=Center  Width=110 Show='true' 	Edit='none' 	SumTextAlign=Center
</C>
<C> Name=거래처명 ID=CUST_NAME Align=Left HeadAlign=Center  Width=110 Show='true' 	Edit='none' 	SumTextAlign=Center 	SumText='합        계 :'
</C>
<C> Name=반제금액 ID=RESET_AMT Align=Right HeadAlign=Center  Width=95 Show='true'	SumText=@sum	Edit='none'  BgColor='#E0F4FF'	SumBgColor='#A8C9FF'
</C>
<C> Name=적요 ID=SUMMARY1 Align=Left HeadAlign=Center  Width=170 Show='true' 	Edit='none'
</C>
<G> Name='설정전표' ID=G1
	<C> Name=전표번호 ID=SET_MAKE_SLIPNOLINE Align=Left HeadAlign=Center  Width=110 Show='true' 	Edit='none'
	</C>
	<C> Name=설정금액 ID=SET_AMT Align=Right HeadAlign=Center  Width=95 Show='true'	 	Edit='none'		SumText=@sum	BgColor='#FFECEC'	SumBgColor='#F2A6A6'
	</C>
	<C> Name=잔액 ID=REMAIN_AMT Align=Right HeadAlign=Center  Width=95 Show='false'	SumTextAlign=Right	 	Edit='none'	SumText=@sum	BgColor='#ECF5EB' SumBgColor='#B3D7B0'
	</C>
	<C> Name=미확정반제 ID=NOT_RESET_AMT Align=Right HeadAlign=Center  Width=95 Show='false' 	Edit='none'	SumText=@sum	BgColor='#FFECEC'	SumBgColor='#EFDCDC'
	</C>
</G>
<C> Name=전표번호 ID=SLIP_ID Align=Left  HeadAlign=Center  Width=130 Sort=true Show='false' 	Edit='none'
</C>
<C> Name=전표순번 ID=SLIP_IDSEQ Align=Left HeadAlign=Center  Width=150 Sort=true Show='false' 	Edit='none'
</C>
<C> Name=반제전표번호 ID=RESET_SLIP_ID Align=Left HeadAlign=Center  Width=120 Sort=true Show='false' 	Edit='none'
</C>
<C> Name=반제전표순번 ID=RESET_SLIP_IDSEQ Align=Right HeadAlign=Center  Width=120 Show='false' 	Edit='none'
</C>
<C> Name=이체일자 ID=KEEP_DT Align=Center  HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
<C> Name=이체순번 ID=KEEP_SEQ Align=Center HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
<C> Name=계정코드 ID=ACC_CODE Align=Center HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
<C> Name=거래처코드 ID=CUST_CODE Align=Center HeadAlign=Center  Width=120 Show='true' Show='false' 	Edit='none'
</C>
<C> Name=프로젝트코드 ID=PROJECT_CODE Align=Center HeadAlign=Center  Width=120 Show='true' Show='false' 	Edit='none'
</C>
<C> Name=사원번호 ID=EMP_NO Align=Center HeadAlign=Center  Width=80 Show='false' 	Edit='none'
</C>
										">
									</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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
					<td width="35%" height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15" height="23">&nbsp;<img src="../images/bullet1.gif"></td>
											<td class="font_green_bold">상대계정</td>
											<td align="right" width="*">
<input id="btnOtherAccSearch"	type="button" class="img_btn4_1" onclick="AccSearch()"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="조 회" />
<input id="btnOtherAccSave"		type="button" class="img_btn4_1" onclick="ifrmOtherAccPage.AccSave()"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="저 장" />
											</td>
										</tr>
									</table>
									<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="head_line">
											<td width="*" height="3"></td>
										</tr>
										<tr>
											<td bgcolor="#FFFFFF">
												<!-- 프로그래머 디자인 시작 //-->
												<iframe width="100%" height="448" name="ifrmOtherAccPage" src="../01/t_ISlipR.jsp" frameborder="0" scrolling="no"></iframe>
												<!-- 프로그래머 디자인 종료 //-->
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