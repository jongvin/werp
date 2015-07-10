<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCardCodeR_q.jsp(신용카드관리)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCARD_CLS = CITCommon.toKOR(request.getParameter("CARD_CLS"));
			String strCODE_CLASS = CITCommon.toKOR(request.getParameter("CODE_CLASS"));
			String strSEARCH_CONDITION = CITCommon.toKOR(request.getParameter("SEARCH_CONDITION"));
			
			if(strCODE_CLASS.equals("1"))
			{
				strSql  = " Select \n";
				strSql += " 	a.CARD_SEQ , \n";
				strSql += " 	a.CARDNO , \n";
				strSql += " 	a.COMP_CODE , \n";
				strSql += " 	a.CARD_NAME , \n";
				strSql += " 	a.CARD_CLS , \n";
				strSql += " 	a.CARD_OWNER , \n";
				strSql += " 	a.BANK_MAIN_CODE , \n";
				strSql += " 	b.BANK_MAIN_NAME , \n";
				strSql += " 	a.BANK_CODE , \n";
				strSql += " 	c.BANK_NAME , \n";
				strSql += " 	a.ACCNO , \n";
				strSql += " 	a.PAY_DATE, \n";
				strSql += " 	F_T_StringToYmFormat(a.EXPR_MONTH) EXPR_MONTH  , \n";
				strSql += " 	f_t_datetostring(a.UNUSED_DT) UNUSED_DT , \n";
				strSql += " 	a.LIMIT_AMT , \n";
				strSql += " 	a.USE_TG \n";
				strSql += " From	T_ACC_CREDCARD a, \n";
				strSql += " 		T_BANK_MAIN b, \n";
				strSql += " 		T_BANK_CODE c \n";
				strSql += " Where	a.BANK_MAIN_CODE = b.BANK_MAIN_CODE(+) \n";
				strSql += " And		a.BANK_CODE = c.BANK_CODE(+) \n";
				strSql += " And		a.COMP_CODE Like   '%'||?||'%'  \n";
				strSql += " And		a.CARD_CLS Like  '%'||?||'%'  \n";
				strSql += " And		a.CARDNO Like '%'|| ? ||'%' \n";
				strSql += " Order By \n";
				strSql += " 	a.CARD_CLS, \n";
				strSql += " 	a.COMP_CODE, \n";
				strSql += " 	a.CARDNO ";
			}
			else if (strCODE_CLASS.equals("2"))
			{
				strSql  = " Select \n";
				strSql += " 	a.CARD_SEQ , \n";
				strSql += " 	a.CARDNO , \n";
				strSql += " 	a.COMP_CODE , \n";
				strSql += " 	a.CARD_NAME , \n";
				strSql += " 	a.CARD_CLS , \n";
				strSql += " 	a.CARD_OWNER , \n";
				strSql += " 	a.BANK_MAIN_CODE , \n";
				strSql += " 	b.BANK_MAIN_NAME , \n";
				strSql += " 	a.BANK_CODE , \n";
				strSql += " 	c.BANK_NAME , \n";
				strSql += " 	a.ACCNO , \n";
				strSql += " 	a.PAY_DATE, \n";
				strSql += " 	F_T_StringToYmFormat(a.EXPR_MONTH) EXPR_MONTH  , \n";
				strSql += " 	a.LIMIT_AMT , \n";
				strSql += " 	a.USE_TG \n";
				strSql += " From	T_ACC_CREDCARD a, \n";
				strSql += " 		T_BANK_MAIN b, \n";
				strSql += " 		T_BANK_CODE c \n";
				strSql += " Where	a.BANK_MAIN_CODE = b.BANK_MAIN_CODE(+) \n";
				strSql += " And		a.BANK_CODE = c.BANK_CODE(+) \n";
				strSql += " And		a.COMP_CODE Like   '%'||?||'%'  \n";
				strSql += " And		a.CARD_CLS Like  '%'||?||'%'  \n";
				strSql += " And		a.CARD_NAME Like '%'|| ? ||'%' \n";
				strSql += " Order By \n";
				strSql += " 	a.CARD_CLS, \n";
				strSql += " 	a.COMP_CODE, \n";
				strSql += " 	a.CARDNO ";
			}
			else if (strCODE_CLASS.equals("3"))
			{
				strSql  = " Select \n";
				strSql += " 	a.CARD_SEQ , \n";
				strSql += " 	a.CARDNO , \n";
				strSql += " 	a.COMP_CODE , \n";
				strSql += " 	a.CARD_NAME , \n";
				strSql += " 	a.CARD_CLS , \n";
				strSql += " 	a.CARD_OWNER , \n";
				strSql += " 	a.BANK_MAIN_CODE , \n";
				strSql += " 	b.BANK_MAIN_NAME , \n";
				strSql += " 	a.BANK_CODE , \n";
				strSql += " 	c.BANK_NAME , \n";
				strSql += " 	a.ACCNO , \n";
				strSql += " 	a.PAY_DATE, \n";
				strSql += " 	F_T_StringToYmFormat(a.EXPR_MONTH) EXPR_MONTH  , \n";
				strSql += " 	a.LIMIT_AMT , \n";
				strSql += " 	a.USE_TG \n";
				strSql += " From	T_ACC_CREDCARD a, \n";
				strSql += " 		T_BANK_MAIN b, \n";
				strSql += " 		T_BANK_CODE c \n";
				strSql += " Where	a.BANK_MAIN_CODE = b.BANK_MAIN_CODE(+) \n";
				strSql += " And		a.BANK_CODE = c.BANK_CODE(+) \n";
				strSql += " And		a.COMP_CODE Like   '%'||?||'%'  \n";
				strSql += " And		a.CARD_CLS Like  '%'||?||'%'  \n";
				strSql += " And		a.CARD_OWNER Like '%'|| ? ||'%' \n";
				strSql += " Order By \n";
				strSql += " 	a.CARD_CLS, \n";
				strSql += " 	a.COMP_CODE, \n";
				strSql += " 	a.CARDNO ";
			}
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CARD_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("SEARCH_CONDITION", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CARD_CLS", strCARD_CLS);
			lrArgData.setValue("SEARCH_CONDITION", strSEARCH_CONDITION);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CARD_SEQ", true);
				lrReturnData.setNotNull("CARDNO", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("CARD_CLS", true);
				lrReturnData.setNotNull("CARD_OWNER", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if( strAct.equals("CARD_SEQ"))
		{
			
			strSql  = " Select SQ_T_CARD_SEQ.NextVal CARD_SEQ From Dual ";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","CARD_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strCARD_SEQ = CITCommon.toKOR(request.getParameter("CARD_SEQ"));
			
			strSql  = " Select \n";
			strSql += " 	a.CARD_SEQ , \n";
			strSql += " 	F_T_StringToYMDFormat(a.USESTARTDATE) USESTARTDATE , \n";
			strSql += " 	F_T_StringToYMDFormat(a.USEENDDATE) USEENDDATE, \n";
			strSql += " 	a.CARDNUMBER , \n";
			strSql += " 	a.CARDOWNEREMPNO , \n";
			strSql += " 	a.CARDSUBSTITUTEEMPNO , \n";
			strSql += " 	a.CHANGEREASON , \n";
			strSql += " 	a.FIRSTREGISTEREMPNO , \n";
			strSql += " 	a.FIRSTREGISTERDATE , \n";
			strSql += " 	a.LASTMODIFYEMPNO , \n";
			strSql += " 	a.LASTMODIFYDATE, \n";
			strSql += " 	a.BANK_MAIN_CODE, \n";
			strSql += " 	a.ACCNO, \n";
			strSql += " 	a.ACCNO_OWNER, \n";
			strSql += " 	a.ATTRIBUTE1, \n";
			strSql += " 	a.ATTRIBUTE2, \n";
			strSql += " 	a.ATTRIBUTE3, \n";
			strSql += " 	b.NAME CARDOWNEREMPNAME, \n";
			strSql += " 	c.NAME CARDSUBSTITUTEEMPNAME \n";
			strSql += " from	T_CARD_MEMBER_HISTORY a, \n";
			strSql += " 		Z_AUTHORITY_USER b, \n";
			strSql += " 		Z_AUTHORITY_USER c \n";
			strSql += " Where	a.CARDOWNEREMPNO = b.EMPNO (+) \n";
			strSql += " And		a.CARDSUBSTITUTEEMPNO = c.EMPNO (+) \n";
			strSql += " And		a.CARD_SEQ =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.USESTARTDATE ";
			
			lrArgData.addColumn("1CARD_SEQ", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1CARD_SEQ", strCARD_SEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CARD_SEQ", true);
				lrReturnData.setKey("USESTARTDATE", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>