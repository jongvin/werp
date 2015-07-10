<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxDeptR_q(부서 등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-05-11)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	String	strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strDOC_COM_ID 	= CITCommon.toKOR(request.getParameter("DOC_COM_ID"));
			String strGEN_TM_S 		= CITCommon.toKOR(request.getParameter("GEN_TM_S"));
			String strGEN_TM_E 		= CITCommon.toKOR(request.getParameter("GEN_TM_E"));
			String strSUP_REGNUM 	= CITCommon.toKOR(request.getParameter("SUP_REGNUM"));
			String strDOC_NUMBER 	= CITCommon.toKOR(request.getParameter("DOC_NUMBER"));
			String strBUY_REGNUM 	= CITCommon.toKOR(request.getParameter("BUY_REGNUM"));
			
			strSql  = "  SELECT DISTINCT RTRIM(A.DOC_COM_ID)          DOC_COM_ID			, \n"; 
			strSql += "       	RTRIM(A.DOC_NUMBER)                   DOC_NUMBER		 	, \n"; 
			strSql += "       	''                                    BEF_DOC_NUMBER  , \n"; 
			strSql += "       	RTRIM(A.GEN_TM)                       GEN_TM  				, \n"; 
			strSql += "       	RTRIM(A.STATUS)                       STATUS  				, \n"; 
			strSql += "       	RTRIM(A.DEL_STATUS)                   DEL_STATUS  		, \n"; 
			strSql += "       	F_T_Cust_Mask(RTRIM(A.SUP_REGNUM))    SUP_REGNUM  		, \n"; 
			strSql += "       	F_T_Cust_Mask(RTRIM(A.BUY_REGNUM))    BUY_REGNUM 			, \n"; 
			strSql += "       	NVL(A.TAX_SUPPRICE,0)                 TAX_SUPPRICE  	, \n"; 
			strSql += "       	NVL(A.TAX_TAXPRICE,0)                 TAX_TAXPRICE  	, \n"; 
			strSql += "       	NVL(A.PAY_TOTALPRICE,0)               PAY_TOTALPRICE  , \n"; 
			strSql += "       	RTRIM(B.DOC_NUMBER)                   SORT_DOC  			, \n"; 
			strSql += "       	DECODE(RTRIM(A.STATUS),'CAN','1','0') SORT_CAN		 			\n"; 
			strSql += " From		TB_WT_SALE A , 											\n";
			strSql += " 				TB_WT_SALE_CAN B										\n";
			strSql += " Where		A.DOC_NUMBER        = B.DOC_NUMBER	\n";
			strSql += " And			RTRIM(A.DOC_COM_ID) = ?							\n";
			strSql += " And			A.GEN_TM      BETWEEN ? AND ?				\n";			
			if(!"".equals(strSUP_REGNUM)) strSql += " And			RTRIM(A.SUP_REGNUM)   = ?  \n";
			if(!"".equals(strDOC_NUMBER)) strSql += " And			RTRIM(A.DOC_NUMBER)   = ?  \n";
			if(!"".equals(strBUY_REGNUM)) strSql += " And			RTRIM(A.BUY_REGNUM)   = ?  \n";
			strSql += " And			NVL(B.CD_DEL,' ')  	<> 'D'  		\n";
			strSql += " UNION ALL  		\n";
			strSql += "  SELECT DISTINCT RTRIM(A.DOC_COM_ID)          DOC_COM_ID			, \n"; 
			strSql += "       	''                                    DOC_NUMBER		 	, \n"; 
			strSql += "       	RTRIM(A.DOC_NUMBER)                   BEF_DOC_NUMBER  , \n"; 
			strSql += "       	RTRIM(A.GEN_TM)                       GEN_TM  				, \n"; 
			strSql += "       	RTRIM(A.STATUS)                       STATUS  				, \n"; 
			strSql += "       	RTRIM(A.DEL_STATUS)                   DEL_STATUS  		, \n"; 
			strSql += "       	F_T_Cust_Mask(RTRIM(A.SUP_REGNUM))    SUP_REGNUM  		, \n"; 
			strSql += "       	F_T_Cust_Mask(RTRIM(A.BUY_REGNUM))    BUY_REGNUM 			, \n"; 
			strSql += "       	NVL(A.TAX_SUPPRICE,0)                 TAX_SUPPRICE  	, \n"; 
			strSql += "       	NVL(A.TAX_TAXPRICE,0)                 TAX_TAXPRICE  	, \n"; 
			strSql += "       	NVL(A.PAY_TOTALPRICE,0)               PAY_TOTALPRICE  , \n"; 
			strSql += "       	RTRIM(B.DOC_NUMBER)                   SORT_DOC  			, \n"; 
			strSql += "       	DECODE(RTRIM(A.STATUS),'CAN','1','0') SORT_CAN		 			\n"; 
			strSql += " From		TB_WT_SALE A , 											\n";
			strSql += " 				TB_WT_SALE_CAN B										\n";
			strSql += " Where		A.DOC_NUMBER        = B.DOC_NUMBER	\n";
			strSql += " And			RTRIM(A.DOC_COM_ID) = ?							\n";
			strSql += " And			A.GEN_TM      BETWEEN ? AND ?				\n";			
			if(!"".equals(strSUP_REGNUM)) strSql += " And			RTRIM(A.SUP_REGNUM)   = ?  \n";
			if(!"".equals(strDOC_NUMBER)) strSql += " And			RTRIM(A.DOC_NUMBER)   = ?  \n";
			if(!"".equals(strBUY_REGNUM)) strSql += " And			RTRIM(A.BUY_REGNUM)   = ?  \n";
			strSql += " And			RTRIM(A.STATUS)    = 'CAN' 			\n";
			strSql += " And			NVL(B.CD_DEL,' ')  	<> 'D'  		\n";			
			strSql += " ORDER BY DOC_COM_ID, SUP_REGNUM, SORT_DOC DESC, SORT_CAN, DOC_NUMBER, BEF_DOC_NUMBER DESC \n";
   
			lrArgData.addColumn("1DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("1SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("1DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("1BUY_REGNUM", CITData.VARCHAR2);
			lrArgData.addColumn("2DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("2GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("2GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("2SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("2DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("2BUY_REGNUM", CITData.VARCHAR2);			
			lrArgData.addRow();
			lrArgData.setValue("1DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("1GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("1GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("1SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("1DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("1BUY_REGNUM", strBUY_REGNUM);
			lrArgData.setValue("2DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("2GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("2GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("2SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("2DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("2BUY_REGNUM", strBUY_REGNUM);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				/*lrReturnData.setKey("DOC_COM_ID", true);
				lrReturnData.setKey("DOC_NUMBER", true);
				lrReturnData.setNotNull("DOC_COM_ID", true);
				lrReturnData.setNotNull("DOC_NUMBER", true);*/
			
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