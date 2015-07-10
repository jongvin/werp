<%@ page language="java" import="com.cj.common.*, com.cj.util.*, com.cj.database.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSlipR.jsp(전표등록)
/* 2. 유형(시나리오) : 화면디자인
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-09)
/* 5. 관련  프로그램 : 발의전표를 등록 및 조회
/* 6. 특  기  사  항 :
/**************************************************************************/
	
	CITData lrReturnData = null;
//디자인 외 부분은 여기만 손대자!!!!!
//파일명
	String strDt_Trans = CITDate.getNow("yyyyMMdd");
	String strDate = CITDate.getNow("yyyy-MM-dd");
	String strFileName = "./t_WSlipStdR";
	
//저장 액션
	String strUpdateKeyValue = "";
	strUpdateKeyValue  = "Service1(";
	strUpdateKeyValue += "I:dsSLIP_H=dsSLIP_H, ";
	strUpdateKeyValue += "I:dsSLIP_D=dsSLIP_D";
	strUpdateKeyValue += ")";

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
	String strCombo1 = "";
	String strCombo2 = "";
	String strCombo3 = "";

	String strCHARGE_PERS = "";
	String strCHARGE_PERS_NAME = "";
	
	String strCashAccCode = "111010100";
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
			//strSql += "And	( ( 'T'='"+strSLIP_TRANS_CLS+"' ) Or  ( 'F'='"+strSLIP_TRANS_CLS+"' And a.CODE_LIST_ID IN ('A','C','E','F','N','W','G') ) )  \n";
			//strSql += "And	( ( 'T'='"+strSLIP_TRANS_CLS+"' ) Or  ( 'F'='"+strSLIP_TRANS_CLS+"' And a.CODE_LIST_ID IN ('G') ) )  \n";
			strSql += "And	a.CODE_LIST_ID IN ('G') \n";
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
		
		//유가증권 종류구분
		lrArgData = new CITData();
		try
		{
			strSql =
				"Select "+"\n"+
				"	1 SEQ,"+"\n"+
				"	a.SEC_KIND_CODE CODE,"+"\n"+
				"	a.SEC_KIND_NAME NAME"+"\n"+
				"From	T_FIN_SEC_KIND a"+"\n"+
				"Order By 1,2";
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			strCombo1 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch(Exception ex)
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
		
		//단복리구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'ITR_TAG' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCombo2 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}

		//단복리구분
		lrArgData = new CITData();
 		try
		{
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'ITR_TAG' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By a.SEQ ";

			strSql  = "SELECT \n";
			strSql += "	LOAN_KIND_CODE CODE, \n";
			strSql += "	LOAN_KIND_NAME NAME \n";
			strSql += "FROM \n";
			strSql += "	T_FIN_LOAN_KIND \n";
			strSql += "Order By LOAN_KIND_CODE ";

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

			strCombo3 = CITCommon.toHtmlComboString(lrReturnData, "CODE", "NAME");
		}
		catch (Exception ex)
		{
			throw new Exception("USER-900001:공통코드의 전표구분코드 Select 오류 -> " + ex.getMessage());
		}
		
		lrArgData = new CITData();		
		if(CITCommon.isNull(strCOMP_CODE))
		{
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				strSql  = " Select	a.COMP_CODE, \n";
				strSql += " 		b.COMPANY_NAME, \n";
				strSql += " 		b.DEPT_CODE INOUT_DEPT_CODE , \n";
				strSql += " 		c.DEPT_NAME INOUT_DEPT_NAME , \n";
				strSql += " 		a.COMP_CODE DEPT_COMP_CODE , \n";
				strSql += " 		b.COMPANY_NAME DEPT_COMP_NAME , \n";
				strSql += " 		a.TAX_COMP_CODE DEPT_TAX_COMP_CODE, \n";
				strSql += " 		d.COMPANY_NAME DEPT_TAX_COMP_NAME \n";

				strSql += " From	T_DEPT_CODE a, \n";
				strSql += " 		T_COMPANY b, \n";
				strSql += " 		T_DEPT_CODE c, \n";
				strSql += " 		T_COMPANY d \n";
				strSql += " Where	a.DEPT_CODE =  ?   \n";
				strSql += " And		a.COMP_CODE = b.COMP_CODE(+) \n";
				strSql += " And		b.DEPT_CODE = c.DEPT_CODE(+) \n";
				strSql += " And		a.TAX_COMP_CODE = d.COMP_CODE(+) \n";


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
			
			try
			{
				lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				strSql  = " Select	b.DEPT_CODE INOUT_DEPT_CODE , \n";
				strSql += " 		c.DEPT_NAME INOUT_DEPT_NAME , \n";
				strSql += " 		a.COMP_CODE DEPT_COMP_CODE , \n";
				strSql += " 		b.COMPANY_NAME DEPT_COMP_NAME , \n";
				strSql += " 		a.TAX_COMP_CODE DEPT_TAX_COMP_CODE, \n";
				strSql += " 		d.COMPANY_NAME DEPT_TAX_COMP_NAME \n";
				strSql += " From	T_DEPT_CODE a, \n";
				strSql += " 		T_COMPANY b, \n";
				strSql += " 		T_DEPT_CODE c, \n";
				strSql += " 		T_COMPANY d \n";
				strSql += " Where	a.DEPT_CODE =  ?   \n";
				strSql += " And		a.COMP_CODE = b.COMP_CODE(+) \n";
				strSql += " And		b.DEPT_CODE = c.DEPT_CODE(+) \n";
				strSql += " And		a.TAX_COMP_CODE = d.COMP_CODE(+) \n";

				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				if(lrReturnData.getRowsCount() >= 1)
				{
					strINOUT_DEPT_CODE = lrReturnData.toString(0,"INOUT_DEPT_CODE");
					strINOUT_DEPT_NAME = lrReturnData.toString(0,"INOUT_DEPT_NAME");
					strDEPT_COMP_CODE = lrReturnData.toString(0,"DEPT_COMP_CODE");
					strDEPT_COMP_NAME = lrReturnData.toString(0,"DEPT_COMP_NAME");
					strDEPT_TAX_COMP_CODE = lrReturnData.toString(0,"DEPT_TAX_COMP_CODE");
					strDEPT_TAX_COMP_NAME = lrReturnData.toString(0,"DEPT_TAX_COMP_NAME");
				}
				
			}
			catch (Exception ex)
			{
				throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
			}
				
		}
		//사업장 설정 종료
		// 관리담당
		lrArgData = new CITData();
		try
		{
			strSql  = " Select	B.EMPNO CHARGE_PERS, \n";
			strSql += " 		B.NAME CHARGE_PERS_NAME \n";
			strSql += " From	T_DEPT_CODE a, \n";
			strSql += " 		Z_AUTHORITY_USER b \n";
			strSql += " Where	a.DEPT_CODE =  ?   \n";
			strSql += " And		a.CHARGE_PERS = b.EMPNO(+) \n";

			lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);

			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			if(lrReturnData.getRowsCount() >= 1)
			{
				strCHARGE_PERS = lrReturnData.toString(0,"CHARGE_PERS");
				strCHARGE_PERS_NAME = lrReturnData.toString(0,"CHARGE_PERS_NAME");
			}
			
		}
		catch (Exception ex)
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
		<script language="javascript">
		<!--
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
			var			sCHARGE_PERS = "<%=strCHARGE_PERS%>";
			var			sCHARGE_PERS_NAME = "<%=strCHARGE_PERS_NAME%>";
			var			vCashAccCode = "<%=strCashAccCode%>";
		//-->
		</script>
		
		<!-- 가우스 Dataset 및 Tranaction 객체정의 시작 //-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAIN classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__2"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSLIP_H classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__2); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__3"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSLIP_D classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__3); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__4"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsRESET_CNT classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__4); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__5"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSLIP_ID classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__5); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__6"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsSLIP_IDSEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__6); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__7"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsMAKE_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__7); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__8"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCLASS_CODE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__8); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__9"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsDAY_CLOSE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__9); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__10"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsLOV classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__10); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__11"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsDEPT_ACC_CHK classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__11); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__12"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCUST_CODE classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__12); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__13"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBRAIN_SLIP_SEQ1 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__13); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__14"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBRAIN_SLIP_SEQ2 classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__14); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__15"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBRAIN_GRP_SEQ classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__15); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__16"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsBRAIN_SLIP_BODY classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__16); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__16_1"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=dsCOST_DEPT_KND_ACC classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49></object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__16_1); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__17"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="trans"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
<param name="KeyValue" value="<%=strUpdateKeyValue%>">
<param name="Action"    value="<%=strFileName%>_tr.jsp">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__17); </script> <!--CONVPAGE_TAIL 지우지마세요//-->

<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__18"> <!--CONVPAGE_TAIL 지우지마세요//--><object id="transMAIN"  classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<param name="KeyValue" value="Service1(I:dsMAIN=dsMAIN)">
	<param name="Action"    value="./t_WSlipSelPrintR_tr.jsp">
</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__18); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
		<!-- 가우스 Dataset 및 Tranaction 객체정의 종료 //-->
	</head>
	<body onload="C_Initialize()" tabindex="-1">
		<form name="frmList" action="../common/t_WCcReportRequestProcess.jsp" target="_blank" method="post">
			<input type='hidden' name='ACT' value="REQUEST">
			<Input type='hidden' name='KEY' value="">
			<input type='hidden' name='EXPORT_TAG' value="">
			<input type='hidden' name='RUN_TAG' value="">
			<input type='hidden' name='CONDITION_PAGE' value="t_WSlipSelPrintR">
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
								<td width="100%" class="td_green">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class="font_green_bold" >전표일자</td>
											<td width="58">
												<input id="txtMAKE_DT"			type="hidden"/>
												<input id="txtMAKE_DT_TRANS_F"	type="hidden"/>
												<input id="txtMAKE_DT_TRANS"	type="text" center datatype="n"  maxlength=8 style="width:57px" tabindex="2" onblur="txtMAKE_DT_TRANS_onblur()" onfocus="txtMAKE_DT_TRANS_F.value = txtMAKE_DT_TRANS.value"/>
											</td>
											<td width="21">
												<input id="btnMAKE_DT" type="button" tabindex="3" class="img_btnCalendar_S" onClick="btnMAKE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
											</td>
											<td width="74">
												<select id="cboSLIP_KIND_TAG" style="WIDTH: 74px" tabindex="-1" class="input_listbox_default" onChange="cboSLIP_KIND_TAG_onChange()">
													<%=strSLIP_KIND_TAG%>
												</select>
          									</td>
											<td width="2" class="font_green_bold" ></td>
											<td width="28">
												<input id="txtMAKE_COMP_CODE_F"	type="hidden"/>
												<input id="txtMAKE_COMP_CODE"	type="text" center datatype="an" maxlength=3 style="width:26px" tabindex="1" onblur="txtMAKE_COMP_CODE_onblur()" onfocus="txtMAKE_COMP_CODE_F.value = txtMAKE_COMP_CODE.value"/>
											</td>
											<td width="2" class="font_green_bold" ></td>
											<td width="35">
												<input id="txtMAKE_SEQ_F"		type="hidden"/>
												<input id="txtMAKE_SEQ"			type="text" center datatype="n"  style="width:33px" tabindex="4" onblur="txtMAKE_SEQ_onblur()" onfocus="txtMAKE_SEQ_F.value = txtMAKE_SEQ.value"/>
											</td>
											
											<td width="55">
												<input name="btnMAKE_SLIPNO" type="button" class="img_btnFind" tabindex="5" onClick="btnMAKE_SLIPNO_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" value="검색" />
											</td>
											
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class="font_green_bold" >전표구분</td>
											<td width="144">
												<select id="cboMAKE_SLIPCLS" style="WIDTH: 60px" tabindex="-1" class="input_listbox_default" onChange="cboMAKE_SLIPCLS_onChange()"><%=strMAKE_SLIPCLS%></select>
          									</td>

											<td width="15">&nbsp;</td>
											<td width="54" class="font_green_bold" >&nbsp;</td>
											<td width="122">&nbsp;</td>
											<td width="40">&nbsp;</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class="font_green_bold" >업무구분</td>
											<td width="*"> <input id="txtWORK_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/></td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class=font_green_bold >전표번호</td>
											<td width="275">
												<input id="txtMAKE_SLIPNO" 		type="text" tabindex="-1" Center style="width:100px"/>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class=font_green_bold >사 업 장</td>
											<td width="102">
												<input id="txtCOMPANY_NAME" 		type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
											</td>
											<td width="38">
												<input name="btnMAKE_COMP_CODE"	type="button" tabindex="-1" class="img_btnFind_S" onClick="btnMAKE_COMP_CODE_onClick()" title="사업장찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
											</td>
											<td width="4"></td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class=font_green_bold >작성부서</td>
											<td width="122">
												<input id="txtMAKE_DEPT_CODE"	type="hidden"/>
												<input id="txtMAKE_DEPT_NAME" 	type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:120px"/>
											</td>
											<td width="40">
												<input name="btnMAKE_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnMAKE_DEPT_CODE_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="작성부서찾기" />
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class=font_green_bold >작 성 자</td>
											<td width="*">
												<input id="txtMAKE_PERS"		type="hidden"/>
												<input id="txtMAKE_NAME" 		type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:100px"/>
											</td>
										</tr>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class=font_green_bold >확정여부</td>
											<td width="275">
												<input id="txtKEEP_CLS" 		type="text" readOnly adsreadonly tabindex="-1" class="ro" Center style="width:40px"/>
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class=font_green_bold >관리담당</td>
											<td width="102">
												<input id="txtCHARGE_PERS"		type="hidden"/>
												<input id="txtCHARGE_PERS_NAME_F" type="hidden"/>
												<input id="txtCHARGE_PERS_NAME" type="text" tabindex="-1" onblur="txtCHARGE_PERS_NAME_onblur()" style="width:100px"  onfocus="txtCHARGE_PERS_NAME_F.value = txtCHARGE_PERS_NAME.value"/>
											</td>
											<td width="42">
												<input name="btnCHARGE_PERS" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnCHARGE_PERS_onClick()" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" title="관리담당찾기" />
											</td>
											<td width="15"><img src="../images/bullet3.gif"></td>
											<td width="54" class="font_green_bold" >출납부서</td>
											<td width="122">
												<input id="txtINOUT_DEPT_CODE"	type="hidden"/>
												<input id="txtINOUT_DEPT_NAME_F" type="hidden"/>
												<input id="txtINOUT_DEPT_NAME" 	type="text" tabindex="-1" onblur="txtINOUT_DEPT_NAME_onblur()" style="width:120px" onfocus="txtINOUT_DEPT_NAME_F.value = txtINOUT_DEPT_NAME.value"/>
											</td>
											<td width="42">
												<input name="btnINOUT_DEPT_CODE" type="button" tabindex="-1" class="img_btnFind_S" onClick="btnINOUT_DEPT_CODE_onClick()" title="출납부서찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
											</td>
											<td width="15">&nbsp;</td>
											<td width="54" class=font_green_bold >&nbsp;</td>
											<td width="65">
												&nbsp;
											</td>
											<td width="*">
												&nbsp;
											</td>
										</tr>
									</table>
									<div id="divSLIP_H"  style="display:none">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="*">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__19"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSLIP_H WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" 		VALUE="dsSLIP_H">
														<PARAM NAME="Editable"  	VALUE="true">
														<PARAM NAME="ColSelect" 	VALUE="true">
														<PARAM NAME="ColSizing" 	VALUE="true">
														<PARAM NAME="ViewSummary" 	VALUE=1>
														<PARAM NAME="Format" 		VALUE="
															<C> Name=전표구분 		ID=MAKE_SLIPCLS		Width=100
															</C>
															<C> Name=작성사업장 	ID=MAKE_COMP_CODE	Width=100
															</C>
															<C> Name=작성부서 		ID=MAKE_DEPT_CODE 	Width=100
															</C>
															<C> Name=작성일자 		ID=MAKE_DT			Width=100
															</C>
															<C> Name=작성일자 		ID=MAKE_DT_TRANS	Width=100
															</C>
															<C> Name=전표순번		ID=MAKE_SEQ 		Width=100
															</C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__19); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
													
												</td>
											</tr>
										</table>
									</div>
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
<input id="btnSLIP_SEARCH"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnquery_onclick();"	value="전표조회"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" style="display:none"/>
<input id="btnSLIP_NEW"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnadd_onclick();"		value="새전표"		onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" style="display:none"/>
<input id="btnSLIP_DELETE"	type="button" tabindex="-1" class="img_btn4_1" onClick="btndelete_onclick();"	value="전표삭제"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" style="display:none"/>
<input id="btnSLIP_SAVE"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnsave_onclick();"		value="전표저장"	onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" style="display:none"/>&nbsp;

<input id="btnBUDG"				type="button" tabindex="-1" class="img_btn6_1" onClick="btnBUDG_onClick()"			value="예산실적조회" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnRESET_SLIP"		type="button" tabindex="-1" class="img_btn6_1" onClick="btnRESET_SLIP_onClick()" 	value="설정반제내역" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />&nbsp;

<input id="btnSLIP_PRINT"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSLIP_PRINT_onClick()" 	value="전표출력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />&nbsp;

<input id="btnSLIP_CONFIRM"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSLIP_CONFIRM_onClick()" 	value="전표확정" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnSLIP_CANCEL" 		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSLIP_CANCEL_onClick()" 	value="확정취소" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" style="display:none"/>&nbsp;

<input id="btnSLIP_COPY" 		type="button" tabindex="-1" class="img_btn4_1" onClick="btnSLIP_COPY_onClick()" 	value="전표복사" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnDETAIL_INSERT"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnDETAIL_INSERT_onClick()" value="라인삽입" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnDETAIL_ADD"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnDETAIL_ADD_onClick()"	value="라인추가" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnDETAIL_COPY"		type="button" tabindex="-1" class="img_btn4_1" onClick="btnDETAIL_COPY_onClick()"	value="라인복사" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
<input id="btnDETAIL_DELETE"	type="button" tabindex="-1" class="img_btn4_1" onClick="btnDETAIL_DELETE_onClick()"	value="라인삭제" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="100%" height="100%" onActivate="G_focusDataset(dsSLIP_D)">
									<div id="divSLIP_D">
										<table width="100%" height="100%" border="1" bordercolor="black" cellspacing="0" cellpadding="2">
											<tr>
												<td colspan="2" style="background:#F6F6F6">
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="55">표준적요</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65">대 분 류</td>
															<td width="208">
																<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__20"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=cboBRAIN_SLIP_SEQ1 width=186 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
																	<PARAM NAME="ComboStyle" VALUE="5">
																	<param name=ComboDataID		value=dsBRAIN_SLIP_SEQ1>
																	<PARAM NAME="EditExprFormat" VALUE="%;BRAIN_SLIP_NAME1">
																	<PARAM name="ListExprFormat" value="%;BRAIN_SLIP_NAME1">			
																	<param name=SearchColumn	value="BRAIN_SLIP_SEQ1">
																	<param name=BindColumn		value="BRAIN_SLIP_SEQ1">			
																</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__20); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
															</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">중 분 류</td>
															<td width="270">
																<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__21"> <!--CONVPAGE_TAIL 지우지마세요//--><object id=cboBRAIN_SLIP_SEQ2 width=186 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
																	<PARAM NAME="ComboStyle" VALUE="5">
																	<param name=ComboDataID		value=dsBRAIN_SLIP_SEQ2>
																	<PARAM NAME="EditExprFormat" VALUE="%;BRAIN_SLIP_NAME2">
																	<PARAM name="ListExprFormat" value="%;BRAIN_SLIP_NAME2">			
																	<param name=SearchColumn	value="BRAIN_SLIP_SEQ2">
																	<param name=BindColumn		value="BRAIN_SLIP_SEQ2">	
																</object><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__21); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
															</td>
															<td width="22">&nbsp;</td>

															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">증빙코드</td>
															<td width="42">
																<input id="txtVAT_CODE_F" 	type="hidden"/>
												   				<input id="txtVAT_CODE" type="text" tabindex="120" style="width:40px" onblur="txtVAT_CODE_onblur()" onfocus="txtVAT_CODE_F.value = txtVAT_CODE.value"/>
															</td>
															<td width="114">
																<input id="txtVAT_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:112px"/>
															</td>
															<td width="22">
																<input id="btnVAT_CODE" type="button" tabindex="121" class="img_btnFind_S" onClick="btnVAT_CODE_onClick()" title="증빙코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>

															<td width="*">&nbsp;</td>
														</tr>
													</table>

													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="25">순번</td>
															<td width="30"><input id="txtMAKE_SLIPLINE" type="text" Datatype="N" right readOnly adsreadonly tabindex="-1" style="width:24px;background:#ECF5EB"/></td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65">귀속사업장</td>
															<td width="52">
															   	<input id="txtCOMP_CODE_F" 	   	type="hidden"/>
																<input id="txtCOMP_CODE" 	   	type="text"  tabindex="101" style="width:50px" onblur="txtCOMP_CODE_onblur()" onfocus="txtCOMP_CODE_F.value = txtCOMP_CODE.value"/>
															</td>
															<td width="134">
																<input id="txtCOMP_NAME"		type="text" readOnly adsreadonly tabindex="-1" class="ro" left style="width:132px"/>
															</td>
															<td width="22">
																<input name="btnCOMP_CODE" type="button" tabindex="102" class="img_btnFind_S" onClick="btnCOMP_CODE_onClick()" title="귀속사업장찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">계정과목</td>
															<td width="68">
																<input id="txtACC_CODE_F" type="hidden"/>
												   				<input id="txtACC_CODE" type="text" tabindex="111" style="width:66px;background:#FFFCE0" onblur="txtACC_CODE_onblur()" onfocus="txtACC_CODE_F.value = txtACC_CODE.value"/>
															</td>
															<td width="202">
												   				<input id="txtACC_NAME" type="text" readOnly adsreadonly class="ro" tabindex="-1" style="width:200px"/>
															</td>
															<td width="22">
												   				<input id="btnACC_CODE" type="button" tabindex="112" class="img_btnFind_S" onClick="btnACC_CODE_onClick()" title="계정과목찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>

														</tr>
													</table>
													
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="70">&nbsp;</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65">귀속부서</td>
															<td width="52">
															   	<input id="txtDEPT_CODE_F" 	   	type="hidden"/>
																<input id="txtDEPT_CODE" 	   	type="text"  tabindex="101" style="width:50px" onblur="txtDEPT_CODE_onblur()" onfocus="txtDEPT_CODE_F.value = txtDEPT_CODE.value"/>
															</td>
															<td width="134">
																<input id="txtDEPT_NAME"		type="text" readOnly adsreadonly tabindex="-1" class="ro" left style="width:132px"/>
															</td>
															<td width="22">
																<input name="btnDEPT_CODE" type="button" tabindex="102" class="img_btnFind_S" onClick="btnDEPT_CODE_onClick()" title="귀속부서찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">차변금액</td>
															<td width="103">
																<input id="txtDB_AMT_F" type="hidden"/>
																<input id="txtDB_AMT" 	type="hidden"/>
																<input id="txtDB_AMT_D" type="text" datatype="currency" tabindex="113" right style="width:100px;background:#FFECEC" onblur = "dsSLIP_D.NameString(dsSLIP_D.RowPosition,'DB_AMT') = C_removeComma(this.value);this.value = C_toNumberFormatString(C_removeComma(this.value));"/>
															</td>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">대변금액</td>
															<td width="124">
																<input id="txtCR_AMT_F" type="hidden"/>
																<input id="txtCR_AMT" 	type="hidden"/>
																<input id="txtCR_AMT_D" type="text" datatype="currency" tabindex="114" right style="width:100px;background:#E0F4FF" onblur = "dsSLIP_D.NameString(dsSLIP_D.RowPosition,'CR_AMT') = C_removeComma(this.value);this.value = C_toNumberFormatString(C_removeComma(this.value));"/>
															</td>
															<td width="*">&nbsp;</td>
														</tr>
													</table>
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="70">&nbsp;</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65">부문코드</td>
															<td width="52">
																<input id="txtCLASS_CODE_F" 	type="hidden"/>
																<input id="txtCLASS_CODE" 	   	type="text"  tabindex="103" style="width:50px" onblur="txtCLASS_CODE_onblur()" onfocus="txtCLASS_CODE_F.value = txtCLASS_CODE.value"/>
															</td>
															<td width="134">
												   				<input id="txtCLASS_CODE_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" left style="width:132px"/>
															</td>
															<td width="22">
																<input name="btnCLASS_CODE" type="button" tabindex="104" class="img_btnFind_S" onClick="btnCLASS_CODE_onClick()" title="부문코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">적&nbsp;&nbsp;요 1</td>
															<td width="68">
												   				<input id="txtSUMMARY_CODE_F" type="hidden"/>
												   				<input id="txtSUMMARY_CODE"   type="text" datatype="an" tabindex="115" style="width:66px"  onblur="txtSUMMARY_CODE_onblur()" onfocus="txtSUMMARY_CODE_F.value = txtSUMMARY_CODE.value"/>
															</td>
															<td width="202">
												   				<input id="txtSUMMARY1" type="text" datatype="han" tabindex="116" style="width:200px" onchange="txtSUMMARY1_onchange()"/>
															</td>
															<td width="22">
												   				<input name="btnSUMMARY_CODE" type="button" tabindex="117" class="img_btnFind_S" onClick="btnSUMMARY_CODE_onClick()" title="적요코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">증빙일자</td>
															<td width="67">
																<input id="txtVAT_DT" type="text" tabindex="122" datatype="date" style="width:65px"/>
															</td>
															<td width="*">
																<input id="btnVAT_DT" type="button" tabindex="123" class="img_btnCalendar_S" onClick="btnVAT_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>
														</tr>
													</table>
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="70">&nbsp;</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65">세무사업장</td>
															<td width="52">
															   	<input id="txtTAX_COMP_CODE_F" 	   	type="hidden"/>
																<input id="txtTAX_COMP_CODE" 	   	type="text"  tabindex="109" style="width:50px" onblur="txtTAX_COMP_CODE_onblur()" onfocus="txtTAX_COMP_CODE_F.value = txtTAX_COMP_CODE.value"/>
															</td>
															<td width="134">
																<input id="txtTAX_COMP_NAME"		type="text" readOnly adsreadonly tabindex="-1" class="ro" left style="width:132px"/>
															</td>
															<td width="22">
																<input name="btnTAX_COMP_CODE" type="button" tabindex="110" class="img_btnFind_S" onClick="btnTAX_COMP_CODE_onClick()" title="세무사업장찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
															</td>
															
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="50">적&nbsp;&nbsp;요 2</td>
															<td width="292">
												   				<input id="txtSUMMARY2" type="text" datatype="han" tabindex="118" style="width:268px"/>
															</td>
															
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td width="690" height="100%">
													<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__22"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=gridSLIP_D WIDTH="100%" HEIGHT="100%" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
														<PARAM NAME="DataID" 		VALUE="dsSLIP_D">
														<PARAM NAME="Editable"  	VALUE="true">
														<PARAM NAME="ColSelect" 	VALUE="true">
														<PARAM NAME="ColSizing" 	VALUE="true">
														<PARAM NAME="ViewSummary" 	VALUE=1>
														<PARAM NAME="MultiRowSelect"VALUE="true">
														<PARAM NAME="Format" 		VALUE="
<FC> Name=순번 			ID=MAKE_SLIPLINE	BgColor=#ECF5EB Width=34 Edit='none'</FC>
<FC> Name=그룹 			ID=BRAIN_GRP_SEQ 	BgColor=#FFFCE0 width=30	Edit='none' suppress=2 Show='false'</FC>
<FC> Name=표준적요분류 	ID=BRAIN_SLIP_NAME 	BgColor=#FFFCE0 width=130	Edit='none' suppress=1</FC>
<FC> Name=SEQ			ID=BRAIN_SORT_SEQ 	BgColor=#FFFCE0 width=30	Edit='none' Show='false' Align=Right</FC>
<FC> Name=적요반복		ID=BRAIN_REPEAT_CLS	BgColor=#FFFCE0 width=55	Edit='none' Show='true' Align=Center EditStyle=Checkbox</FC>
<FC> Name=삭제가능		ID=BRAIN_DEL_CLS 	BgColor=#FFFCE0 width=55	Edit='none' Show='true' Align=Center EditStyle=Checkbox</FC>
<FC> Name=계정코드 		ID=ACC_CODE			BgColor=#FFFCE0 Align=Center width=75 Edit='none'</FC>
<FC> Name=계정과목 		ID=ACC_NAME 		BgColor=#FFFCE0 width=140 SumText='            합  계  : ' Edit='none'</FC>
<C> Name=차변금액 	ID=DB_AMT			BgColor=#FFECEC SumBgColor=#FFCCCC width=90 SumText=@sum Edit='none'</C>
<C> Name=대변금액 	ID=CR_AMT			BgColor=#E0F4FF SumBgColor=#CEEEFF width=90 SumText=@sum Edit='none'</C>
<C> Name='적    요' 	ID=SUMMARY1 		Width=100 Edit='none'</C>
<C> Name=귀속부서	ID=DEPT_CODE		width=100 Edit='none' Show='false'</C>
<C> Name=귀속부서	ID=DEPT_NAME		width=100 Edit='none'</C>
<C> Name=부문코드	ID=CLASS_CODE		width=100 Edit='none' Show='false'</C>
<C> Name='부    문'	ID=CLASS_CODE_NAME	width=100 Edit='none'</C>
<C> Name=거래처코드	ID=CUST_CODE 		width=100 Edit='none'</C>
<C> Name=거래처명 	ID=CUST_NAME 		width=100 Edit='none'</C>
<C> Name=부가세 		ID=VAT_NAME 		width=100 Edit='none'</C>
															">
													</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__22); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
													<script> __ws__(gridSLIP_D); </script>
												</td>
												<td width="*" height="100%" valign="top">
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65" id="titSUPAMT"><font color="#888888">공급가</font></td>
															<td width="201"><input id="txtSUPAMT" type="text" datatype="currency" right style="width:100px" onchange="calcVATAMT();"/></td>
															<td width="*">&nbsp;</td>
														</tr>
													</table>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="15"><img src="../images/bullet3.gif"></td>
															<td width="65" id="titVATAMT"><font color="#888888">부가세</font></td>
															<td width="*"> <input id="txtVATAMT" type="text" datatype="currency" right style="width:100px"/></td>
														</tr>
													</table>
<div id="divCUST_CODE" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCUST_CODE"><font color="black">거래처코드</font></td>
			<td width="181">
				<input id="txtCUST_SEQ" 	type="hidden"/>
				<input id="txtCUST_CODE_F" 	type="hidden"/>
				<input id="txtCUST_CODE" type="text" style="width:179px" onblur="txtCUST_CODE_onblur()" onfocus="txtCUST_CODE_F.value = txtCUST_CODE.value"/>
			</td>
			<td width="*">
				<input id="btnCUST_CODE" type="button" class="img_btnFind_S" onClick="btnCUST_CODE_onClick()" title="거래처코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<div id="divCUST_NAME"  style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCUST_NAME"><font color="black">거래처명</font></td>
			<td width="*"><input id="txtCUST_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:179px"/></td>
		</tr>
	</table>
</div>
<div id="divBANK_CODE" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBANK_CODE"><font color="black">은행코드</font></td>
			<td width="57">
				<input id="txtBANK_CODE_F" 	type="hidden"/>
				<input id="txtBANK_CODE" type="text" style="width:55px" onblur="txtBANK_CODE_onblur()" onfocus="txtBANK_CODE_F.value = txtBANK_CODE.value"/>
			</td>
			<td width="124"><input id="txtBANK_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:122px"/></td>
			<td width="*">
				<input id="btnBANK_CODE" type="button" class="img_btnFind_S" onClick="btnBANK_CODE_onClick()" title="은행코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"  onfocus="txtBANK_CODE_F.value = txtBANK_CODE.value"/>
			</td>
		</tr>
	</table>
</div>
<div id="divACCNO_CODE" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titACCNO_CODE"><font color="black">계좌번호</font></td>
			<td width="181">
				<input id="txtACCNO_CODE_F" 	type="hidden"/>
				<input id="txtACCNO_CODE" 		type="text" style="width:179px" onblur="txtACCNO_CODE_onblur()"  onfocus="txtACCNO_CODE_F.value = txtACCNO_CODE.value"/></td>
			<td width="*">
				<input id="btnACCNO_CODE" type="button" class="img_btnFind_S" onClick="btnACCNO_CODE_onClick()" title="계좌번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--카드번호//-->
<div id="divCARD_SEQ" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<input id="txtCARD_SEQ_B" type="hidden"/>
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCARD_NO"><font color="black">카드번호</font></td>
			<td width="181">
				<input id="txtCARD_NO_F"	type="hidden"/>
				<input id="txtCARD_NO" 	type="text" style="width:179px" onblur="txtCARD_NO_onblur()"  onfocus="txtCARD_NO_F.value = txtCARD_NO.value"/>
			</td>
			<td width="*">
				<input id="btnCARD_NO" type="button" class="img_btnFind_S" onClick="btnCARD_NO_onClick()" title="카드번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<!--
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">소지자</td>
			<td width="*"><input id="txtHAVE_PERS" type="text" tabindex="-1" class="ro" readOnly adsreadonly style="width:179px"/></td>
		</tr>
	</table>
	-->
</div>
<!--당좌수표지급//-->
<div id="divCHK_NO" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCHK_NO"><font color="black">수표번호</font></td>
			<td width="181">
				<input id="txtCHK_NO_F" type="hidden"/>
				<input id="txtCHK_NO"	type="text" style="width:179px" onblur="txtCHK_NO_onblur()"  onfocus="txtCHK_NO_F.value = txtCHK_NO.value"/>
			</td>
			<td width="*">
				<input id="btnCHK_NO" type="button" class="img_btnFind_S" onClick="btnCHK_NO_onClick()" title="수표번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCHK_PUBL_DT"><font color="black">발행일</font></td>
			<td width="181"><input id="txtCHK_PUBL_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnCHK_PUBL_DT" type="button" class="img_btnCalendar_S" onClick="btnCHK_PUBL_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCHK_COLL_DT"><font color="black">회수일</font></td>
			<td width="181"><input id="txtCHK_COLL_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnCHK_COLL_DT" type="button" class="img_btnCalendar_S" onClick="btnCHK_COLL_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--지급어음설정//-->
<div id="divBILL_NO" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_NO"><font color="black">어음번호</font></td>
			<td width="181">
				<input id="txtBILL_NO_S_F"	type="hidden"/>
				<input id="txtBILL_NO_S"		type="text" style="width:179px"  onblur="txtBILL_NO_S_onblur()"  onfocus="txtBILL_NO_S_F.value = txtBILL_NO_S.value"/>
			</td>
			<td width="*">
				<input id="btnBILL_NO" type="button" class="img_btnFind_S" onClick="btnBILL_NO_onClick()" title="어음번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_PUBL_DT"><font color="black">발행일</font></td>
			<td width="181"><input id="txtBILL_PUBL_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnBILL_PUBL_DT" type="button" class="img_btnCalendar_S" onClick="btnBILL_PUBL_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_EXPR_DT"><font color="black">만기일</font></td>
			<td width="181"><input id="txtBILL_EXPR_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnBILL_EXPR_DT" type="button" class="img_btnCalendar_S" onClick="btnBILL_EXPR_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--지급어음반제//-->
<div id="divBILL_NO_R" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_NO_R"><font color="black">어음번호</font></td>
			<td width="181">
				<input id="txtBILL_NO_R_F"	type="hidden"/>
				<input id="txtBILL_NO_R" 	type="text" style="width:179px" onblur="txtBILL_NO_R_onblur()"  onfocus="txtBILL_NO_R_F.value = txtBILL_NO_R.value"/>
			</td>
			<td width="*">
				<input id="btnBILL_NO_R" type="button" class="img_btnFind_S" onClick="btnBILL_NO_R_onClick()" title="어음번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_PUBL_DT_R"><font color="#888888">발행일</font></td>
			<td width="*"><input id="txtBILL_PUBL_DT_R" class="ro" tabindex="-1" readOnly adsreadonly datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_EXPR_DT_R"><font color="#888888">만기일</font></td>
			<td width="*"><input id="txtBILL_EXPR_DT_R" class="ro" tabindex="-1" readOnly adsreadonly datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_CHG_EXPR_DT_R"><font color="#888888">변경만기일</font></td>
			<td width="*"><input id="txtBILL_CHG_EXPR_DT_R" class="ro" tabindex="-1" readOnly adsreadonly datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titBILL_COLL_DT_R"><font color="black">회수일</font></td>
			<td width="181"><input id="txtBILL_COLL_DT_R" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnBILL_COLL_DT_R" type="button" class="img_btnCalendar_S" onClick="btnBILL_COLL_DT_R_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--받을어음설정//-->
<div id="divREC_BILL_NO" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_NO"><font color="black">어음번호</font></td>
			<td width="*"><input id="txtREC_BILL_NO_S" type="text" onblur="txtREC_BILL_NO_S_onblur()" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_PUBL_DT"><font color="black">발행일</font></td>
			<td width="181"><input id="txtREC_BILL_PUBL_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnREC_BILL_PUBL_DT" type="button" class="img_btnCalendar_S" onClick="btnREC_BILL_PUBL_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_EXPR_DT"><font color="black">만기일</font></td>
			<td width="181"><input id="txtREC_BILL_EXPR_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnREC_BILL_EXPR_DT" type="button" class="img_btnCalendar_S" onClick="btnREC_BILL_EXPR_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--받을어음반제//-->
<div id="divREC_BILL_NO_R" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_NO_R"><font color="black">어음번호</font></td>
			<td width="181">
				<input id="txtREC_BILL_NO_R_F"	type="hidden"/>
				<input id="txtREC_BILL_NO_R" 	type="text" style="width:179px" onblur="txtREC_BILL_NO_R_onblur()"  onfocus="txtREC_BILL_NO_R_F.value = txtREC_BILL_NO_R.value"/>
			</td>
			<td width="*">
				<input id="btnREC_BILL_NO_R" type="button" class="img_btnFind_S" onClick="btnREC_BILL_NO_R_onClick()" title="어음번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_PUBL_DT_R"><font color="#888888">발행일</font></td>
			<td width="*"><input id="txtREC_BILL_PUBL_DT_R"  class="ro" tabindex="-1" readOnly adsreadonly datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_EXPR_DT_R"><font color="#888888">만기일</font></td>
			<td width="*"><input id="txtREC_BILL_EXPR_DT_R"  class="ro" tabindex="-1" readOnly adsreadonly datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_PUBL_AMT_R"><font color="#888888">발행금액</font></td>
			<td width="*"><input id="txtREC_BILL_PUBL_AMT_R" class="ro" tabindex="-1" readOnly adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_DISH_DT_R"><font color="black">부도일</font></td>
			<td width="181"><input id="txtREC_BILL_DISH_DT_R" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnREC_BILL_DISH_DT_R" type="button" class="img_btnCalendar_S" onClick="btnREC_BILL_DISH_DT_R_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_TRUST_DT_R"><font color="black">수탁일</font></td>
			<td width="181"><input id="txtREC_BILL_TRUST_DT_R" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnREC_BILL_TRUST_DT_R" type="button" class="img_btnCalendar_S" onClick="btnREC_BILL_TRUST_DT_R_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_TRUST_BANK_CODE_R"><font color="black">수탁은행</font></td>
			<td width="57">
				<input id="txtREC_BILL_TRUST_BANK_CODE_R_F" 	type="hidden"/>
				<input id="txtREC_BILL_TRUST_BANK_CODE_R" type="text" style="width:55px" onblur="txtREC_BILL_TRUST_BANK_CODE_R_onblur()" onfocus="txtREC_BILL_TRUST_BANK_CODE_R_F.value = txtREC_BILL_TRUST_BANK_CODE_R.value"/>
			</td>
			<td width="124"><input id="txtREC_BILL_TRUST_BANK_NAME_R" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:122px"/></td>
			<td width="*">
				<input id="btnREC_BILL_TRUST_BANK_CODE_R" type="button" class="img_btnFind_S" onClick="btnREC_BILL_TRUST_BANK_CODE_R_onClick()" title="은행코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"  onfocus="txtREC_BILL_TRUST_BANK_CODE_R_F.value = txtREC_BILL_TRUST_BANK_CODE_R.value"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_DISC_DT_R"><font color="black">할인일</font></td>
			<td width="181"><input id="txtREC_BILL_DISC_DT_R" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnREC_BILL_DISC_DT_R" type="button" class="img_btnCalendar_S" onClick="btnREC_BILL_DISC_DT_R_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titREC_BILL_DISC_BANK_CODE_R"><font color="black">할인은행</font></td>
			<td width="57">
				<input id="txtREC_BILL_DISC_BANK_CODE_R_F" 	type="hidden"/>
				<input id="txtREC_BILL_DISC_BANK_CODE_R" type="text" style="width:55px" onblur="txtREC_BILL_DISC_BANK_CODE_R_onblur()" onfocus="txtREC_BILL_DISC_BANK_CODE_R_F.value = txtREC_BILL_DISC_BANK_CODE_R.value"/>
			</td>
			<td width="124"><input id="txtREC_BILL_DISC_BANK_NAME_R" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:122px"/></td>
			<td width="*">
				<input id="btnREC_BILL_DISC_BANK_CODE_R" type="button" class="img_btnFind_S" onClick="btnREC_BILL_DISC_BANK_CODE_R_onClick()" title="할인은행코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"  onfocus="txtREC_BILL_DISC_BANK_CODE_R_F.value = txtREC_BILL_DISC_BANK_CODE_R.value"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">할인율</td>
			<td width="*"><input id="txtREC_BILL_DISC_RAT_R" datatype="dotcurrency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">할인금액</td>
			<td width="*"><input id="txtREC_BILL_DISC_AMT_R" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--CP매입설정//-->
<div id="divCP_NO" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">CP번호</td>
			<td width="*"><input id="txtCP_NO_S" type="text" style="width:179px"onblur="txtCP_NO_S_onblur()"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_DT"><font color="black">발행일</font></td>
			<td width="181"><input id="txtCP_BUY_PUBL_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnCP_BUY_PUBL_DT" type="button" class="img_btnCalendar_S" onClick="btnCP_BUY_PUBL_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_EXPR_DT"><font color="black">만기일</font></td>
			<td width="181"><input id="txtCP_BUY_EXPR_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnCP_BUY_EXPR_DT" type="button" class="img_btnCalendar_S" onClick="btnCP_BUY_EXPR_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_DUSE_DT"><font color="black">폐기일</font></td>
			<td width="181"><input id="txtCP_BUY_DUSE_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnCP_BUY_DUSE_DT" type="button" class="img_btnCalendar_S" onClick="btnCP_BUY_DUSE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>  
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_AMT"><font color="black">발행금액</font></td>
			<td width="*"><input id="txtCP_BUY_PUBL_AMT" adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_INCOME_AMT"><font color="black">매입금액</font></td>
			<td width="*"><input id="txtCP_BUY_INCOME_AMT" adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_PLACE"><font color="black">발행처</font></td>
			<td width="*"><input id="txtCP_BUY_PUBL_PLACE" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_NAME"><font color="black">발행자</font></td>
			<td width="*"><input id="txtCP_BUY_PUBL_NAME" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_INTR_RAT"><font color="black">이자율</font></td>
			<td width="*"><input id="txtCP_BUY_INTR_RAT" adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_CUST_CODE"><font color="black">주관사코드</font></td>
			<td width="181">
				<input id="txtCP_BUY_CUST_SEQ" 	type="hidden"/>
				<input id="txtCP_BUY_CUST_CODE_F" 	type="hidden"/>
				<input id="txtCP_BUY_CUST_CODE" type="text" style="width:179px" onblur="txtCP_BUY_CUST_CODE_onblur()" onfocus="txtCP_BUY_CUST_CODE_F.value = txtCP_BUY_CUST_CODE.value"/>
			</td>
			<td width="*">
				<input id="btnCP_BUY_CUST_CODE" type="button" class="img_btnFind_S" onClick="btnCP_BUY_CUST_CODE_onClick()" title="주관사코드찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
		<tr>
			<td width="15">&nbsp;</td>
			<td width="65">&nbsp;</td>
			<td width="181">
				<input id="txtCP_BUY_CUST_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:179px"/>
			</td>
			<td width="*">&nbsp;</td>
		</tr>
	</table>
</div>

<!--CP매입반제//-->
<div id="divCP_NO_R" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">CP번호</td>
			<td width="181">
				<input id="txtCP_NO_R_F"	type="hidden"/>
				<input id="txtCP_NO_R" type="text" style="width:179px"  onblur="txtCP_NO_R_onblur()"  onfocus="txtCP_NO_R_F.value = txtCP_NO_R.value"/>
			</td>
			<td width="*">
				<input id="btnCP_NO_R" type="button" class="img_btnFind_S" onClick="btnCP_NO_R_onClick()" title="CP번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_DT_R"><font color="#888888">발행일</font></td>
			<td width="*"><input id="txtCP_BUY_PUBL_DT_R" readOnly adsreadonly tabindex="-1" type="text" style="width:179px" class="ro"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_EXPR_DT_R"><font color="#888888">만기일</font></td>
			<td width="*"><input id="txtCP_BUY_EXPR_DT_R" readOnly adsreadonly tabindex="-1" type="text" style="width:179px" class="ro"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_DUSE_DT_R"><font color="#888888">폐기일</font></td>
			<td width="*"><input id="txtCP_BUY_DUSE_DT_R" readOnly adsreadonly tabindex="-1" type="text" style="width:179px" class="ro"/></td>
		</tr>
	</table>  
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_AMT_R"><font color="#888888">발행금액</font></td>
			<td width="*"><input id="txtCP_BUY_PUBL_AMT_R" RIGHT readOnly adsreadonly tabindex="-1" type="text" style="width:179px" class="ro"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_INCOME_AMT_R"><font color="#888888">매입금액</font></td>
			<td width="*"><input id="txtCP_BUY_INCOME_AMT_R" RIGHT  readOnly adsreadonly tabindex="-1" type="text" style="width:179px" class="ro"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_PLACE_R"><font color="#888888">발행처</font></td>
			<td width="*"><input id="txtCP_BUY_PUBL_PLACE_R" type="text" style="width:179px" readOnly adsreadonly tabindex="-1" class="ro"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_PUBL_NAME_R"><font color="#888888">발행자</font></td>
			<td width="*"><input id="txtCP_BUY_PUBL_NAME_R" type="text" style="width:179px" readOnly adsreadonly tabindex="-1" class="ro"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_INTR_RAT_R"><font color="#888888">이자율</font></td>
			<td width="*"><input id="txtCP_BUY_INTR_RAT_R" RIGHT readOnly adsreadonly tabindex="-1" type="text" style="width:179px" class="ro"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_CUST_CODE_R"><font color="#888888">주관사코드</font></td>
			<td width="*">
				<input id="txtCP_BUY_CUST_SEQ_R" 	type="hidden"/>
				<input id="txtCP_BUY_CUST_CODE_R_F" 	type="hidden"/>
				<input id="txtCP_BUY_CUST_CODE_R" type="text" style="width:179px"  readOnly adsreadonly tabindex="-1" class="ro"/>
			</td>
		</tr>
		<tr>
			<td width="15">&nbsp;</td>
			<td width="65">&nbsp;</td>
			<td width="181">
				<input id="txtCP_BUY_CUST_NAME_R" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:179px"/>
			</td>
			<td width="*">&nbsp;</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCP_BUY_RESET_AMT_R"><font color="black">반제금액</font></td>
			<td width="*"><input id="txtCP_BUY_RESET_AMT_R" adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>

<!--유가증권설정//-->
<div id="divSECU_NO" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">증권번호</td>
			<td width="*"><input id="txtSECU_REAL_SECU_NO_S" type="text" style="width:179px"onblur="txtSECU_REAL_SECU_NO_S_onblur()"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">종류구분</td>
			<td width="*">
				<select  id="txtSECU_SEC_KIND_CODE"  style="WIDTH:179px">
					<%=strCombo1%>
				</select>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">취득일</td>
			<td width="181"><input id="txtSECU_GET_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnSECU_GET_DT" type="button" class="img_btnCalendar_S" onClick="btnSECU_GET_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">취득처</td>
			<td width="*"><input id="txtSECU_GET_PLACE" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">증권금액</td>
			<td width="*"><input id="txtSECU_PERSTOCK_AMT" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">매입금액</td>
			<td width="*"><input id="txtSECU_INCOME_AMT" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">선취이자금액</td>
			<td width="*"><input id="txtSECU_BF_GET_ITR_AMT" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">취득시경과이자</td>
			<td width="*"><input id="txtSECU_GET_ITR_AMT" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">발행일</td>
			<td width="181"><input id="txtSECU_PUBL_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnSECU_PUBL_DT" type="button" class="img_btnCalendar_S" onClick="btnSECU_PUBL_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">단복리구분</td>
			<td width="*">
				<select  id="txtSECU_ITR_TAG"  style="WIDTH:179px">
					<%=strCombo2%>
				</select>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">만기일</td>
			<td width="181"><input id="txtSECU_EXPR_DT" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnSECU_EXPR_DT" type="button" class="img_btnCalendar_S" onClick="btnSECU_EXPR_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">이율</td>
			<td width="*"><input id="txtSECU_INTR_RATE" datatype="dotcurrency" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--유가증권반제//-->
<div id="divSECU_NO_R" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">증권번호</td>
			<td width="181">
				<input id="txtSECU_REAL_SECU_NO_R_F"	type="hidden"/>
				<input id="txtSECU_REAL_SECU_NO_R" type="text" style="width:179px"  onblur="txtSECU_REAL_SECU_NO_R_onblur()"  onfocus="txtSECU_REAL_SECU_NO_R_F.value = txtSECU_REAL_SECU_NO_R.value"/>
			</td>
			<td width="*">
				<input id="btnSECU_REAL_SECU_NO_R" type="button" class="img_btnFind_S" onClick="btnSECU_REAL_SECU_NO_R_onClick()" title="증권번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">증권금액</td>
			<td width="*"><input id="txtSECU_PERSTOCK_AMT_R"  tabindex="-1" class="ro" readOnly adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">발행일</td>
			<td width="*"><input id="txtSECU_PUBL_DT_R"  tabindex="-1" class="ro" readOnly adsreadonly datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">만기일</td>
			<td width="*"><input id="txtSECU_EXPR_DT_R"  tabindex="-1" class="ro" readOnly adsreadonly  datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">이율</td>
			<td width="*"><input id="txtSECU_INTR_RATE_R" tabindex="-1" class="ro" readOnly adsreadonly datatype="dotcurrency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">매각금액</td>
			<td width="*"><input id="txtSECU_SALE_AMT_R" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">매각일자</td>
			<td width="*"><input id="txtSECU_SALE_DT_R" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnSECU_SALE_DT_R" type="button" class="img_btnCalendar_S" onClick="btnSECU_SALE_DT_R_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">상환일자</td>
			<td width="*"><input id="txtSECU_RETURN_DT_R" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnSECU_RETURN_DT_R" type="button" class="img_btnCalendar_S" onClick="btnSECU_RETURN_DT_R_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titSECU_CONSIGN_BANK_R"><font color="black">수탁은행</font></td>
			<td width="57">
			   <input id="txtSECU_CONSIGN_BANK_R_F" 	type="hidden"/>
			   <input id="txtSECU_CONSIGN_BANK_R" type="text" style="width:55px" onblur="txtSECU_CONSIGN_BANK_R_onblur()" onfocus="txtSECU_CONSIGN_BANK_R_F.value = txtSECU_CONSIGN_BANK_R.value"/>
			</td>
			<td width="124"> <input id="txtSECU_CONSIGN_BANK_NAME_R" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:122px"/></td>
			<td width="*">
				<input id="btnSECU_CONSIGN_BANK_R" type="button" class="img_btnFind_S" onClick="btnSECU_CONSIGN_BANK_R_onClick()" title="수탁은행찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">매각이자</td>
			<td width="*"><input id="txtSECU_SALE_ITR_AMT_R" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">매각법인세</td>
			<td width="*"><input id="txtSECU_SALE_TAX_R" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">매각처분손실</td>
			<td width="*"><input id="txtSECU_SALE_LOSS_R" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">매각시미수이자</td>
			<td width="*"><input id="txtSECU_SALE_NP_ITR_AMT_R" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--차입//-->
<div id="divLOAN_NO_S" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입계좌</td>
			<td width="181">
				<input id="txtLOAN_NO_S" type="hidden"/>
				<input id="txtLOAN_REAL_LOAN_NO" class="ro" readOnly adsreadonly tabindex="-1" datatype="han" type="text" style="width:179px"/>
			</td>
			<td width="*">
				<input id="btnLOAN_REAL_LOAN_NO" type="button" class="img_btnFind_S" onClick="btnLOAN_REAL_LOAN_NO_onClick()" title="차입번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입명</td>
			<td width="*"><input id="txtLOAN_NAME" class="ro" readOnly adsreadonly tabindex="-1" datatype="han" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입종류</td>
			<td width="*">
				<select id="txtLOAN_KIND_CODE"  style="WIDTH:179px" disabled>
					<%=strCombo3%>
				</select>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입시작일</td>
			<td width="*"><input id="txtLOAN_FDT" class="ro" readOnly adsreadonly tabindex="-1" datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입만기일</td>
			<td width="*"><input id="txtLOAN_EXPR_DT" class="ro" readOnly adsreadonly tabindex="-1" datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--차입상환//-->
<div id="divLOAN_NO_R" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입계좌</td>
			<td width="181">
				<input id="txtLOAN_NO_R" type="hidden"/>
				<input id="txtLOAN_REAL_LOAN_NO_R" class="ro" readOnly adsreadonly tabindex="-1" datatype="han" type="text" style="width:179px"/>
			</td>
			<td width="*">
				<input id="btnLOAN_REAL_LOAN_NO_R" type="button" class="img_btnFind_S" onClick="btnLOAN_REAL_LOAN_NO_R_onClick()" title="차입번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입명</td>
			<td width="*"><input id="txtLOAN_NAME_R" class="ro" readOnly adsreadonly tabindex="-1" datatype="han" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입종류</td>
			<td width="*">
				<select  id="txtLOAN_KIND_CODE_R"  style="WIDTH:179px" disabled>
					<%=strCombo3%>
				</select>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입시작일</td>
			<td width="*"><input id="txtLOAN_FDT_R" class="ro" readOnly adsreadonly tabindex="-1" datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입만기일</td>
			<td width="*"><input id="txtLOAN_EXPR_DT_R" class="ro" readOnly adsreadonly tabindex="-1" datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--차입이자//-->
<div id="divLOAN_NO_I" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입계좌</td>
			<td width="181">
				<input id="txtLOAN_NO_I" type="hidden"/>
				<input id="txtLOAN_REAL_LOAN_NO_I" class="ro" readOnly adsreadonly tabindex="-1" datatype="han" type="text" style="width:179px"/>
			</td>
			<td width="*">
				&nbsp;
				<!--
				<input id="btnLOAN_REAL_LOAN_NO_I" type="button" class="img_btnFind_S" onClick="btnLOAN_REAL_LOAN_NO_I_onClick()" title="차입번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
				-->
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입명</td>
			<td width="*"><input id="txtLOAN_NAME_I" class="ro" readOnly adsreadonly tabindex="-1" datatype="han" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입종류</td>
			<td width="*">
				<select  id="txtLOAN_KIND_CODE_I"  style="WIDTH:179px" disabled>
					<%=strCombo3%>
				</select>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입시작일</td>
			<td width="*"><input id="txtLOAN_FDT_I" class="ro" readOnly adsreadonly tabindex="-1" datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">차입만기일</td>
			<td width="*"><input id="txtLOAN_EXPR_DT_I" class="ro" readOnly adsreadonly tabindex="-1" datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--적금//-->
<div id="divDEPOSIT_PAYMENT" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">불입회차</td>
			<td width="181">
				<input id="txtDEPOSIT_ACCNO" type="hidden"/>
				<input id="txtPAYMENT_SEQ_F" 	type="hidden"/>
				<input id="txtPAYMENT_SEQ" tabindex="-1" class="ro" readOnly adsreadonly datatype="currency" type="text" style="width:179px"/>
			</td>
			<td width="*">
				<input id="btnPAYMENT_SEQ" type="button" class="img_btnFind_S" onClick="btnPAYMENT_SEQ_onClick()"  title="적금예정회차찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">불입예정일</td>
			<td width="*"><input id="txtPAYMENT_SCH_DT" tabindex="-1" class="ro" readOnly adsreadonly  datatype="date" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">불입예정액</td>
			<td width="*"><input id="txtPAYMENT_SCH_AMT" tabindex="-1" class="ro" readOnly adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">불입일자</td>
			<td width="181"><input id="txtPAYMENT_DT" tabindex="-1" datatype="date" type="text" style="width:179px"/></td>
			<td width="*">
				<input id="btnPAYMENT_DT" type="button" class="img_btnCalendar_S" onClick="btnPAYMENT_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">불입금액</td>
			<td width="*"><input id="txtPAYMENT_AMT" datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--고정자산//-->
<div id="divFIX" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCUST_CODE"><font color="black">고정자산</font></td>
			<td width="181">
				<input id="txtFIX_ASSET_SEQ" 	type="hidden"/>
				<input id="txtFIX_ASSET_MNG_NO_F" 	type="hidden"/>
				<input id="txtFIX_ASSET_MNG_NO" type="text" style="width:179px" onblur="txtFIX_ASSET_MNG_NO_onblur()" onfocus="txtFIX_ASSET_MNG_NO_F.value = txtFIX_ASSET_MNG_NO.value"/>
			</td>
			<td width="*">
				<input id="btnFIX_ASSET_MNG_NO" type="button" class="img_btnFind_S" onClick="btnFIX_ASSET_MNG_NOE_onClick()" title="고정자산찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titFIX_ASSET_NAME"><font color="black">자산명칭</font></td>
			<td width="*"><input id="txtFIX_ASSET_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">취득일</td>
			<td width="*"><input id="txtFIX_GET_DT" tabindex="-1" class="ro" readOnly adsreadonly type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">제작회사</td>
			<td width="*"><input id="txtFIX_PRODUCTION" tabindex="-1" class="ro" readOnly adsreadonly type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">관리부서</td>
			<td width="*"><input id="txtFIX_MNG_DEPT_NAME" tabindex="-1" class="ro" readOnly adsreadonly type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">배치부서</td>
			<td width="*"><input id="txtFIX_DEPT_NAME" type="text" class="ro" readOnly adsreadonly style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">거래처</td>
			<td width="*"><input id="txtFIX_CUST_NAME" type="text" class="ro" readOnly adsreadonly style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--대금지불조건//-->
<div id="divPAY_CON" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="80">대금지불현금</td>
			<td width="*"><input id="txtPAY_CON_CASH" datatype="currency" type="text" style="width:164px" onblur="txtPAY_CON_CASH_onblur()"/> %</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="80">대금지불어음</td>
			<td width="*"><input id="txtPAY_CON_BILL" datatype="currency" type="text" style="width:164px" onblur="txtPAY_CON_BILL_onblur()"/> %</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="80">어음만기일수</td>
			<td width="*"><input id="txtPAY_CON_BILL_DAYS" datatype="currency" type="text" style="width:164px"/></td>
		</tr>
	</table>
</div>
<!--대금지불어음만기일//-->
<div id="divPAY_CON_BILL_DT" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="80">만기일</td>
			<td width="165"><input id="txtPAY_CON_BILL_DT" tabindex="-1" datatype="date" type="text" style="width:164px"/></td>
			<td width="*">
				<input id="btnPAY_CON_BILL_DT" type="button" class="img_btnCalendar_S" onClick="btnPAY_CON_BILL_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--사원번호//-->
<div id="divEMP_NO" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titEMP_NO"><font color="black">사원번호</font></td>
			<td width="57">
			   <input id="txtEMP_NO_F" 	type="hidden"/>
			   <input id="txtEMP_NO" type="text" style="width:55px" onblur="txtEMP_NO_onblur()" onfocus="txtEMP_NO_F.value = txtEMP_NO.value"/>
			</td>
			<td width="124"> <input id="txtEMP_NAME" type="text" readOnly adsreadonly tabindex="-1" class="ro" style="width:122px"/></td>
			<td width="*">
				<input id="btnEMP_NO" type="button" class="img_btnFind_S" onClick="btnEMP_NO_onClick()" title="사원번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--지급희망일//-->
<div id="divANTICIPATION_DATE" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="80" id="titANTICIPATION_DT"><font color="black">지급희망일</font></td>
			<td width="165"><input id="txtANTICIPATION_DT" type="text" datatype="date" style="width:164px"/></td>
			<td width="*">
				<input id="btnANTICIPATION_DT" type="button" class="img_btnCalendar_S" onClick="btnANTICIPATION_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<!--현금영수증//-->
<div id="divCASH" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<input id="txtCASH_SEQ" type="hidden"/>
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">승인번호</td>
			<td width="*"><input id="txtCASH_CASHNO" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCASH_USE_DT"><font color="black">사용일</font></td>
			<td width="181"><input id="txtCASH_USE_DT" type="text" datatype="date" style="width:179px"/></td>
			<td width="*">
				<input id="btnCASH_USE_DT" type="button" class="img_btnCalendar_S" onClick="btnCASH_USE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCASH_TRADE_AMT"><font color="black">거래금액</font></td>
			<td width="*"><input id="txtCASH_TRADE_AMT" adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">청구여부</td>
			<td width="*"><input id="txtCASH_REQ_TG" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--신용카드//-->
<div id="divCARD" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<input id="txtCARD_SEQ" type="hidden"/>
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCARD_CARDNO"><font color="black">카드번호</font></td>
			<td width="181">
				<input id="txtCARD_CARDNO_F"	type="hidden"/>
				<input id="txtCARD_CARDNO" 	type="text" style="width:179px" onblur="txtCARD_CARDNO_onblur()"  onfocus="txtCARD_CARDNO_F.value = txtCARD_CARDNO.value"/>
			</td>
			<td width="*">
				<input id="btnCARD_CARDNO" type="button" class="img_btnFind_S" onClick="btnCARD_CARDNO_onClick()" title="어음번호찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">소지자</td>
			<td width="*"><input id="txtCARD_HAVE_PERS" type="text" tabindex="-1" class="ro" readOnly adsreadonly style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCARD_USE_DT"><font color="black">사용일</font></td>
			<td width="181"><input id="txtCARD_USE_DT" type="text" datatype="date" style="width:179px"/></td>
			<td width="*">
				<input id="btnCARD_USE_DT" type="button" class="img_btnCalendar_S" onClick="btnCARD_USE_DT_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65" id="titCARD_TRADE_AMT"><font color="black">거래금액</font></td>
			<td width="*"><input id="txtCARD_TRADE_AMT" adsreadonly datatype="currency" type="text" style="width:179px"/></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">청구여부</td>
			<td width="*"><input id="txtCARD_REQ_TG" type="text" style="width:179px"/></td>
		</tr>
	</table>
</div>
<!--관리항목//-->
<div id="divMNG_ITEM_CHAR1" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_CHAR1" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_CHAR1" 	type="text" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_CHAR2" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_CHAR2" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_CHAR2" 	type="text" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_CHAR3" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_CHAR3" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_CHAR3" 	type="text" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_CHAR4" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_CHAR4" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_CHAR4" 	type="text" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_NUM1" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_NUM1" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_NUM1" 	type="text" datatype="dotcurrency" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_NUM2" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_NUM2" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_NUM2" 	type="text" datatype="dotcurrency" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_NUM3" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_NUM3" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_NUM3" 	type="text" datatype="dotcurrency" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_NUM4" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_NUM4" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="*">
				<input id="txtMNG_ITEM_NUM4" 	type="text" datatype="dotcurrency" style="width:179px"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_DT1" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_DT1" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="181">
				<input id="txtMNG_ITEM_DT1" 	type="text" datatype="date" style="width:179px"/>
			</td>
			<td width="*">
				<input id="btnMNG_ITEM_DT1" type="button" class="img_btnCalendar_S" onClick="btnMNG_ITEM_DT1_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_DT2" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_DT2" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="181">
				<input id="txtMNG_ITEM_DT2" 	type="text" datatype="date" style="width:179px"/>
			</td>
			<td width="*">
				<input id="btnMNG_ITEM_DT2" type="button" class="img_btnCalendar_S" onClick="btnMNG_ITEM_DT2_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_DT3" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_DT3" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="181">
				<input id="txtMNG_ITEM_DT3" 	type="text" datatype="date" style="width:179px"/>
			</td>
			<td width="*">
				<input id="btnMNG_ITEM_DT3" type="button" class="img_btnCalendar_S" onClick="btnMNG_ITEM_DT3_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<div id="divMNG_ITEM_DT4" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65">
				<input id="txtMNG_NAME_DT4" 	type="text" tabindex="-1" readOnly adsreadonly style="width:65px;border:none" />
			</td>
			<td width="181">
				<input id="txtMNG_ITEM_DT4" 	type="text" datatype="date" style="width:179px"/>
			</td>
			<td width="*">
				<input id="btnMNG_ITEM_DT4" type="button" class="img_btnCalendar_S" onClick="btnMNG_ITEM_DT4_onClick()" title="달력" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
		</tr>
	</table>
</div>
<div id="divRESET_SLIPNO" style="display:none">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../images/bullet3.gif"></td>
			<td width="65"><font color="#888888">설정전표</font></td>
			<td width="181">
				<input id="txtRESET_SLIPNO" type="text" tabindex="-1" class="ro" adsreadonly style="width:179px" maxlength=0 onblur="txtRESET_SLIPNO_onblur()" onfocus="this.select();"/>
			</td>
			<td width="26">
				<input id="btnRESET_SLIPNO" type="button" class="img_btnFind_S" onClick="btnRESET_SLIPNO_onClick()" title="설정전표찾기" onmouseover="this.style.color=MOUSE_OVER;" onmouseout="this.style.color=MOUSE_OUT;"/>
			</td>
			<td width="*">
			</td>
		</tr>
	</table>
</div>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- 프로그래머 디자인 종료 //-->
			</table>
		</div>
		<!-- 가우스 Bind 객체정의 시작 //-->
		<!--CONVPAGE_HEAD 지우지마세요//--> <comment id="__NSID__23"> <!--CONVPAGE_TAIL 지우지마세요//--><OBJECT id=ADE_Bind_1 style="Z-INDEX: 107; LEFT: 335px; POSITION: absolute; TOP: 158px" classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT codebase="../../../cabfiles/toinbbind.cab#version=1,1,0,13">
			<PARAM NAME="DataID" 		VALUE="dsSLIP_D">
			<PARAM NAME="BindInfo"	VALUE="
				<C> Col=MAKE_SLIPLINE 				Ctrl=txtMAKE_SLIPLINE 				Param=value</C>
				<C> Col=ACC_CODE 					Ctrl=txtACC_CODE 					Param=value</C>
				<C> Col=ACC_NAME 					Ctrl=txtACC_NAME 					Param=value</C>
				<C> Col=DB_AMT 						Ctrl=txtDB_AMT 						Param=value</C>
				<C> Col=DB_AMT_D 					Ctrl=txtDB_AMT_D					Param=value</C>
				<C> Col=CR_AMT						Ctrl=txtCR_AMT						Param=value</C>
				<C> Col=CR_AMT_D					Ctrl=txtCR_AMT_D					Param=value</C>
				<C> Col=SUMMARY_CODE				Ctrl=txtSUMMARY_CODE	 			Param=value</C>
				<C> Col=SUMMARY1 					Ctrl=txtSUMMARY1 					Param=value</C>
				<C> Col=SUMMARY2 					Ctrl=txtSUMMARY2 					Param=value</C>
				<C> Col=TAX_COMP_CODE	 			Ctrl=txtTAX_COMP_CODE		 		Param=value</C>
				<C> Col=TAX_COMP_NAME	 			Ctrl=txtTAX_COMP_NAME	 			Param=value</C>
				<C> Col=COMP_CODE	 				Ctrl=txtCOMP_CODE		 			Param=value</C>
				<C> Col=COMP_NAME	 				Ctrl=txtCOMP_NAME	 				Param=value</C>
				<C> Col=DEPT_CODE	 				Ctrl=txtDEPT_CODE		 			Param=value</C>
				<C> Col=DEPT_NAME	 				Ctrl=txtDEPT_NAME	 				Param=value</C>
				<C> Col=CLASS_CODE					Ctrl=txtCLASS_CODE 					Param=value</C>
				<C> Col=CLASS_CODE_NAME				Ctrl=txtCLASS_CODE_NAME 			Param=value</C>
				<C> Col=VAT_CODE					Ctrl=txtVAT_CODE					Param=value</C>
				<C> Col=VAT_NAME					Ctrl=txtVAT_NAME					Param=value</C>
				<C> Col=VAT_DT						Ctrl=txtVAT_DT						Param=value</C>
				<C> Col=SUPAMT						Ctrl=txtSUPAMT						Param=value</C>
				<C> Col=VATAMT						Ctrl=txtVATAMT						Param=value</C>
				<C> Col=CUST_SEQ					Ctrl=txtCUST_SEQ					Param=value</C>
				<C> Col=CUST_CODE					Ctrl=txtCUST_CODE					Param=value</C>
				<C> Col=CUST_NAME					Ctrl=txtCUST_NAME					Param=value</C>
				<C> Col=ANTICIPATION_DT				Ctrl=txtANTICIPATION_DT				Param=value</C>
				<C> Col=EMP_NO						Ctrl=txtEMP_NO						Param=value</C>
				<C> Col=EMP_NAME					Ctrl=txtEMP_NAME					Param=value</C>
				<C> Col=BANK_CODE					Ctrl=txtBANK_CODE					Param=value</C>
				<C> Col=BANK_NAME					Ctrl=txtBANK_NAME					Param=value</C>
				<C> Col=ACCNO						Ctrl=txtACCNO_CODE					Param=value</C>

				<C> Col=BRAIN_SLIP_SEQ1				Ctrl=cboBRAIN_SLIP_SEQ1				Param=BindColVal</C>
				<C> Col=BRAIN_SLIP_SEQ2				Ctrl=cboBRAIN_SLIP_SEQ2				Param=BindColVal</C>
				<C> Col=CARD_SEQ_B					Ctrl=txtCARD_SEQ_B					Param=value</C> 
				<C> Col=CARD_NO						Ctrl=txtCARD_NO						Param=value</C> 

				<C> Col=CHK_NO						Ctrl=txtCHK_NO						Param=value</C>
				<C> Col=CHK_PUBL_DT					Ctrl=txtCHK_PUBL_DT					Param=value</C>
				<C> Col=CHK_COLL_DT					Ctrl=txtCHK_COLL_DT					Param=value</C>
				<C> Col=BILL_NO_S					Ctrl=txtBILL_NO_S					Param=value</C>
				<C> Col=BILL_PUBL_DT				Ctrl=txtBILL_PUBL_DT				Param=value</C>
				<C> Col=BILL_EXPR_DT				Ctrl=txtBILL_EXPR_DT				Param=value</C>
				<C> Col=BILL_NO_R					Ctrl=txtBILL_NO_R					Param=value</C>
				<C> Col=BILL_PUBL_DT_R				Ctrl=txtBILL_PUBL_DT_R				Param=value</C>
				<C> Col=BILL_EXPR_DT_R				Ctrl=txtBILL_EXPR_DT_R				Param=value</C>
				<C> Col=BILL_CHG_EXPR_DT_R			Ctrl=txtBILL_CHG_EXPR_DT_R			Param=value</C>
				<C> Col=BILL_COLL_DT_R				Ctrl=txtBILL_COLL_DT_R				Param=value</C>
				<C> Col=REC_BILL_NO_S				Ctrl=txtREC_BILL_NO_S				Param=value</C>
				<C> Col=REC_BILL_PUBL_DT			Ctrl=txtREC_BILL_PUBL_DT			Param=value</C>
				<C> Col=REC_BILL_EXPR_DT			Ctrl=txtREC_BILL_EXPR_DT			Param=value</C>
				<C> Col=REC_BILL_NO_R				Ctrl=txtREC_BILL_NO_R				Param=value</C>
				<C> Col=REC_BILL_PUBL_DT_R			Ctrl=txtREC_BILL_PUBL_DT_R			Param=value</C>
				<C> Col=REC_BILL_EXPR_DT_R			Ctrl=txtREC_BILL_EXPR_DT_R			Param=value</C>
				<C> Col=REC_BILL_PUBL_AMT_R			Ctrl=txtREC_BILL_PUBL_AMT_R			Param=value</C>

				<C> Col=REC_BILL_DISH_DT_R          Ctrl=txtREC_BILL_DISH_DT_R         Param=value</C>
				<C> Col=REC_BILL_TRUST_DT_R         Ctrl=txtREC_BILL_TRUST_DT_R        Param=value</C>
				<C> Col=REC_BILL_TRUST_BANK_CODE_R  Ctrl=txtREC_BILL_TRUST_BANK_CODE_R Param=value</C>
				<C> Col=REC_BILL_TRUST_BANK_NAME_R  Ctrl=txtREC_BILL_TRUST_BANK_NAME_R Param=value</C>
				<C> Col=REC_BILL_DISC_DT_R          Ctrl=txtREC_BILL_DISC_DT_R         Param=value</C>
				<C> Col=REC_BILL_DISC_BANK_CODE_R   Ctrl=txtREC_BILL_DISC_BANK_CODE_R  Param=value</C>
				<C> Col=REC_BILL_DISC_BANK_NAME_R   Ctrl=txtREC_BILL_DISC_BANK_NAME_R  Param=value</C>
				<C> Col=REC_BILL_DISC_RAT_R         Ctrl=txtREC_BILL_DISC_RAT_R        Param=value</C>
				<C> Col=REC_BILL_DISC_AMT_R         Ctrl=txtREC_BILL_DISC_AMT_R        Param=value</C>

				<C> Col=CP_NO_S						Ctrl=txtCP_NO_S						Param=value</C>
				<C> Col=CP_BUY_PUBL_DT      		Ctrl=txtCP_BUY_PUBL_DT      		Param=value</C>   
				<C> Col=CP_BUY_EXPR_DT      		Ctrl=txtCP_BUY_EXPR_DT      		Param=value</C>
				<C> Col=CP_BUY_DUSE_DT      		Ctrl=txtCP_BUY_DUSE_DT      		Param=value</C>
				<C> Col=CP_BUY_PUBL_AMT     		Ctrl=txtCP_BUY_PUBL_AMT     		Param=value</C>
				<C> Col=CP_BUY_INCOME_AMT   		Ctrl=txtCP_BUY_INCOME_AMT   		Param=value</C>
				<C> Col=CP_BUY_PUBL_PLACE   		Ctrl=txtCP_BUY_PUBL_PLACE   		Param=value</C>
				<C> Col=CP_BUY_PUBL_NAME    		Ctrl=txtCP_BUY_PUBL_NAME    		Param=value</C>
				<C> Col=CP_BUY_INTR_RAT     		Ctrl=txtCP_BUY_INTR_RAT     		Param=value</C>
				<C> Col=CP_BUY_CUST_SEQ     		Ctrl=txtCP_BUY_CUST_SEQ     		Param=value</C>
				<C> Col=CP_BUY_CUST_CODE     		Ctrl=txtCP_BUY_CUST_CODE     		Param=value</C>
				<C> Col=CP_BUY_CUST_NAME     		Ctrl=txtCP_BUY_CUST_NAME     		Param=value</C>

				<C> Col=CP_NO_R						Ctrl=txtCP_NO_R						Param=value</C>
				<C> Col=CP_BUY_PUBL_DT_R     		Ctrl=txtCP_BUY_PUBL_DT_R        	Param=value</C>   
				<C> Col=CP_BUY_EXPR_DT_R     		Ctrl=txtCP_BUY_EXPR_DT_R        	Param=value</C>
				<C> Col=CP_BUY_DUSE_DT_R     		Ctrl=txtCP_BUY_DUSE_DT_R        	Param=value</C>
				<C> Col=CP_BUY_PUBL_AMT_R    		Ctrl=txtCP_BUY_PUBL_AMT_R       	Param=value</C>
				<C> Col=CP_BUY_INCOME_AMT_R  		Ctrl=txtCP_BUY_INCOME_AMT_R     	Param=value</C>
				<C> Col=CP_BUY_PUBL_PLACE_R  		Ctrl=txtCP_BUY_PUBL_PLACE_R     	Param=value</C>
				<C> Col=CP_BUY_PUBL_NAME_R   		Ctrl=txtCP_BUY_PUBL_NAME_R      	Param=value</C>
				<C> Col=CP_BUY_INTR_RAT_R    		Ctrl=txtCP_BUY_INTR_RAT_R       	Param=value</C>
				<C> Col=CP_BUY_CUST_SEQ_R    		Ctrl=txtCP_BUY_CUST_SEQ_R       	Param=value</C>
				<C> Col=CP_BUY_RESET_AMT_R   		Ctrl=txtCP_BUY_RESET_AMT_R      	Param=value</C>
				<C> Col=CP_BUY_CUST_CODE_R     		Ctrl=txtCP_BUY_CUST_CODE_R     		Param=value</C>
				<C> Col=CP_BUY_CUST_NAME_R     		Ctrl=txtCP_BUY_CUST_NAME_R     		Param=value</C>
				
				<C> Col=SECU_REAL_SECU_NO_S			Ctrl=txtSECU_REAL_SECU_NO_S			Param=value</C>
				<C> Col=SECU_SEC_KIND_CODE			Ctrl=txtSECU_SEC_KIND_CODE			Param=value</C>
				<C> Col=SECU_GET_DT					Ctrl=txtSECU_GET_DT					Param=value</C>
				<C> Col=SECU_GET_PLACE				Ctrl=txtSECU_GET_PLACE				Param=value</C>
				<C> Col=SECU_PERSTOCK_AMT			Ctrl=txtSECU_PERSTOCK_AMT			Param=value</C>
				<C> Col=SECU_INCOME_AMT				Ctrl=txtSECU_INCOME_AMT				Param=value</C>
				<C> Col=SECU_BF_GET_ITR_AMT			Ctrl=txtSECU_BF_GET_ITR_AMT			Param=value</C>
				<C> Col=SECU_GET_ITR_AMT			Ctrl=txtSECU_GET_ITR_AMT			Param=value</C>
				<C> Col=SECU_PUBL_DT				Ctrl=txtSECU_PUBL_DT				Param=value</C>
				<C> Col=SECU_ITR_TAG				Ctrl=txtSECU_ITR_TAG				Param=value</C>
				<C> Col=SECU_EXPR_DT				Ctrl=txtSECU_EXPR_DT				Param=value</C>
				<C> Col=SECU_INTR_RATE				Ctrl=txtSECU_INTR_RATE				Param=value</C>
				<C> Col=SECU_REAL_SECU_NO_R			Ctrl=txtSECU_REAL_SECU_NO_R			Param=value</C>
				<C> Col=SECU_PERSTOCK_AMT_R			Ctrl=txtSECU_PERSTOCK_AMT_R			Param=value</C>
				<C> Col=SECU_PUBL_DT_R				Ctrl=txtSECU_PUBL_DT_R				Param=value</C>
				<C> Col=SECU_EXPR_DT_R				Ctrl=txtSECU_EXPR_DT_R				Param=value</C>
				<C> Col=SECU_INTR_RATE_R			Ctrl=txtSECU_INTR_RATE_R			Param=value</C>
				<C> Col=SECU_SALE_AMT_R				Ctrl=txtSECU_SALE_AMT_R				Param=value</C>
				<C> Col=SECU_SALE_DT_R				Ctrl=txtSECU_SALE_DT_R				Param=value</C>

				<C> Col=SECU_RETURN_DT_R			Ctrl=txtSECU_RETURN_DT_R			Param=value</C>
				<C> Col=SECU_CONSIGN_BANK_R			Ctrl=txtSECU_CONSIGN_BANK_R			Param=value</C>
				<C> Col=SECU_CONSIGN_BANK_NAME_R	Ctrl=txtSECU_CONSIGN_BANK_NAME_R	Param=value</C>
				<C> Col=SECU_SALE_ITR_AMT_R			Ctrl=txtSECU_SALE_ITR_AMT_R			Param=value</C>
				<C> Col=SECU_SALE_TAX_R				Ctrl=txtSECU_SALE_TAX_R				Param=value</C>
				<C> Col=SECU_SALE_LOSS_R			Ctrl=txtSECU_SALE_LOSS_R			Param=value</C>
				<C> Col=SECU_SALE_NP_ITR_AMT_R		Ctrl=txtSECU_SALE_NP_ITR_AMT_R		Param=value</C>

				<C> Col=LOAN_REFUND_NO_S	Ctrl=txtLOAN_NO_S			Param=value</C>
				<C> Col=LOAN_REAL_LOAN_NO	Ctrl=txtLOAN_REAL_LOAN_NO	Param=value</C>
				<C> Col=LOAN_NAME			Ctrl=txtLOAN_NAME			Param=value</C>
				<C> Col=LOAN_KIND_CODE		Ctrl=txtLOAN_KIND_CODE		Param=value</C>
				<C> Col=LOAN_EXPR_DT		Ctrl=txtLOAN_EXPR_DT		Param=value</C>
				<C> Col=LOAN_FDT			Ctrl=txtLOAN_FDT			Param=value</C>

				<C> Col=LOAN_REFUND_NO_R	Ctrl=txtLOAN_NO_R			Param=value</C>
				<C> Col=LOAN_REAL_LOAN_NO_R	Ctrl=txtLOAN_REAL_LOAN_NO_R	Param=value</C>
				<C> Col=LOAN_NAME_R			Ctrl=txtLOAN_NAME_R			Param=value</C>
				<C> Col=LOAN_KIND_CODE_R	Ctrl=txtLOAN_KIND_CODE_R	Param=value</C>
				<C> Col=LOAN_EXPR_DT_R		Ctrl=txtLOAN_EXPR_DT_R		Param=value</C>
				<C> Col=LOAN_FDT_R			Ctrl=txtLOAN_FDT_R			Param=value</C>

				<C> Col=LOAN_REFUND_NO_I	Ctrl=txtLOAN_NO_I			Param=value</C>
				<C> Col=LOAN_REAL_LOAN_NO_I	Ctrl=txtLOAN_REAL_LOAN_NO_I	Param=value</C>
				<C> Col=LOAN_NAME_I			Ctrl=txtLOAN_NAME_I			Param=value</C>
				<C> Col=LOAN_KIND_CODE_I	Ctrl=txtLOAN_KIND_CODE_I	Param=value</C>
				<C> Col=LOAN_EXPR_DT_I		Ctrl=txtLOAN_EXPR_DT_I		Param=value</C>
				<C> Col=LOAN_FDT_I			Ctrl=txtLOAN_FDT_I			Param=value</C>

				<C> Col=DEPOSIT_ACCNO				Ctrl=txtDEPOSIT_ACCNO				Param=value</C>
				<C> Col=PAYMENT_SEQ					Ctrl=txtPAYMENT_SEQ					Param=value</C>
				<C> Col=PAYMENT_SCH_DT				Ctrl=txtPAYMENT_SCH_DT				Param=value</C>
				<C> Col=PAYMENT_SCH_AMT				Ctrl=txtPAYMENT_SCH_AMT				Param=value</C>
				<C> Col=PAYMENT_DT					Ctrl=txtPAYMENT_DT					Param=value</C>
				<C> Col=PAYMENT_AMT					Ctrl=txtPAYMENT_AMT					Param=value</C>
				<C> Col=FIX_ASSET_SEQ				Ctrl=txtFIX_ASSET_SEQ				Param=value</C>
				<C> Col=FIX_ASSET_MNG_NO  			Ctrl=txtFIX_ASSET_MNG_NO			Param=value</C>
				<C> Col=FIX_ASSET_NAME    			Ctrl=txtFIX_ASSET_NAME				Param=value</C>
				<C> Col=FIX_GET_DT        			Ctrl=txtFIX_GET_DT					Param=value</C>
				<C> Col=FIX_PRODUCTION    			Ctrl=txtFIX_PRODUCTION				Param=value</C>
				<C> Col=FIX_MNG_DEPT_NAME 			Ctrl=txtFIX_MNG_DEPT_NAME			Param=value</C>
				<C> Col=FIX_DEPT_NAME     			Ctrl=txtFIX_DEPT_NAME				Param=value</C>
				<C> Col=FIX_CUST_NAME    			Ctrl=txtFIX_CUST_NAME				Param=value</C>
				<C> Col=PAY_CON_CASH				Ctrl=txtPAY_CON_CASH				Param=value</C>
				<C> Col=PAY_CON_BILL				Ctrl=txtPAY_CON_BILL				Param=value</C>
				<C> Col=PAY_CON_BILL_DT				Ctrl=txtPAY_CON_BILL_DT				Param=value</C>
				<C> Col=PAY_CON_BILL_DAYS			Ctrl=txtPAY_CON_BILL_DAYS			Param=value</C>
				<C> Col=CASH_SEQ					Ctrl=txtCASH_SEQ					Param=value</C> 
				<C> Col=CASH_CASHNO					Ctrl=txtCASH_CASHNO					Param=value</C> 
				<C> Col=CASH_USE_DT					Ctrl=txtCASH_USE_DT					Param=value</C> 
				<C> Col=CASH_TRADE_AMT				Ctrl=txtCASH_TRADE_AMT				Param=value</C> 
				<C> Col=CASH_REQ_TG					Ctrl=txtCASH_REQ_TG					Param=value</C> 
				<C> Col=CARD_SEQ					Ctrl=txtCARD_SEQ					Param=value</C> 
				<C> Col=CARD_CARDNO					Ctrl=txtCARD_CARDNO					Param=value</C> 
				<C> Col=CARD_USE_DT					Ctrl=txtCARD_USE_DT					Param=value</C> 
				<C> Col=CARD_HAVE_PERS				Ctrl=txtCARD_HAVE_PERS				Param=value</C> 
				<C> Col=CARD_TRADE_AMT				Ctrl=txtCARD_TRADE_AMT				Param=value</C> 
				<C> Col=CARD_REQ_TG					Ctrl=txtCARD_REQ_TG					Param=value</C> 
				<C> Col=MNG_NAME_CHAR1				Ctrl=txtMNG_NAME_CHAR1				Param=value</C>
				<C> Col=MNG_ITEM_CHAR1				Ctrl=txtMNG_ITEM_CHAR1				Param=value</C>
				<C> Col=MNG_NAME_CHAR2				Ctrl=txtMNG_NAME_CHAR2				Param=value</C>
				<C> Col=MNG_ITEM_CHAR2				Ctrl=txtMNG_ITEM_CHAR2				Param=value</C>
				<C> Col=MNG_NAME_CHAR3				Ctrl=txtMNG_NAME_CHAR3				Param=value</C>
				<C> Col=MNG_ITEM_CHAR3				Ctrl=txtMNG_ITEM_CHAR3				Param=value</C>
				<C> Col=MNG_NAME_CHAR4				Ctrl=txtMNG_NAME_CHAR4				Param=value</C>
				<C> Col=MNG_ITEM_CHAR4				Ctrl=txtMNG_ITEM_CHAR4				Param=value</C>
				<C> Col=MNG_NAME_NUM1				Ctrl=txtMNG_NAME_NUM1				Param=value</C>
				<C> Col=MNG_ITEM_NUM1				Ctrl=txtMNG_ITEM_NUM1				Param=value</C>
				<C> Col=MNG_NAME_NUM2				Ctrl=txtMNG_NAME_NUM2				Param=value</C>
				<C> Col=MNG_ITEM_NUM2				Ctrl=txtMNG_ITEM_NUM2				Param=value</C>
				<C> Col=MNG_NAME_NUM3				Ctrl=txtMNG_NAME_NUM3				Param=value</C>
				<C> Col=MNG_ITEM_NUM3				Ctrl=txtMNG_ITEM_NUM3				Param=value</C>
				<C> Col=MNG_NAME_NUM4				Ctrl=txtMNG_NAME_NUM4				Param=value</C>
				<C> Col=MNG_ITEM_NUM4				Ctrl=txtMNG_ITEM_NUM4				Param=value</C>
				<C> Col=MNG_NAME_DT1				Ctrl=txtMNG_NAME_DT1				Param=value</C>
				<C> Col=MNG_ITEM_DT1				Ctrl=txtMNG_ITEM_DT1				Param=value</C>
				<C> Col=MNG_NAME_DT2				Ctrl=txtMNG_NAME_DT2				Param=value</C>
				<C> Col=MNG_ITEM_DT2				Ctrl=txtMNG_ITEM_DT2				Param=value</C>
				<C> Col=MNG_NAME_DT3				Ctrl=txtMNG_NAME_DT3				Param=value</C>
				<C> Col=MNG_ITEM_DT3				Ctrl=txtMNG_ITEM_DT3				Param=value</C>
				<C> Col=MNG_NAME_DT4				Ctrl=txtMNG_NAME_DT4				Param=value</C>
				<C> Col=MNG_ITEM_DT4				Ctrl=txtMNG_ITEM_DT4				Param=value</C>
				<C> Col=RESET_SLIPNO				Ctrl=txtRESET_SLIPNO				Param=value</C>
			">
		</OBJECT><!--CONVPAGE_HEAD 지우지마세요//--></comment> <script> __WS__(__NSID__23); </script> <!--CONVPAGE_TAIL 지우지마세요//-->
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