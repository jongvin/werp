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
			String strTAX_TYPE	 	= CITCommon.toKOR(request.getParameter("TAX_TYPE"));
			String strSTATUS		 	= CITCommon.toKOR(request.getParameter("STATUS"));
strSql  = " SELECT  LINE_FLAG,		 \n";
strSql += "				STATUS,          \n";
strSql += "				GEN_TM,          \n";
strSql += "				DOC_COM_ID,      \n";
strSql += "				DOC_NUMBER,      \n";
strSql += "				SUP_REGNUM,      \n";
strSql += "				SUP_COMPANY,     \n";
strSql += "				BUY_REGNUM,      \n";
strSql += "				BUY_COMPANY,     \n";
strSql += "				TAX_NAME,        \n";
strSql += "				TAX_SUPPRICE,    \n";
strSql += "				TAX_TAXPRICE,    \n";
strSql += "				PAY_TOTALPRICE   \n";
strSql += "FROM (				           \n";
strSql += "Select	'type1' LINE_FLAG ,'' STATUS ,'' GEN_TM ,'' DOC_COM_ID,'      공급자     ' DOC_NUMBER,  \n";
strSql += "       	F_T_Cust_Mask(RTRIM(A.SUP_REGNUM))	SUP_REGNUM  				,  					 \n";
strSql += "       	RTRIM(A.SUP_COMPANY)	SUP_COMPANY  				, \n";
strSql += "       	F_T_Cust_Mask(RTRIM(A.SUP_REGNUM)) BUY_REGNUM, \n";
strSql += "       	RTRIM(A.SUP_COMPANY) BUY_COMPANY,  '' TAX_NAME, \n";
strSql += "       	null  TAX_SUPPRICE			, \n";
strSql += "       	null  TAX_TAXPRICE			, \n";
strSql += "       	null	PAY_TOTALPRICE			\n";
strSql += " From		TB_WT_SALE A					\n";
strSql += " Where		A.DOC_COM_ID			= ? 		\n";					
strSql += " And			A.GEN_TM   		 		between ? and ? \n";
if(!"".equals(strSUP_REGNUM)) strSql += " And			RTRIM(A.SUP_REGNUM) = ?         \n";
if(!"".equals(strDOC_NUMBER)) strSql += " And			RTRIM(A.DOC_NUMBER) = ?         \n";
if(!"".equals(strBUY_REGNUM)) strSql += " And			RTRIM(A.BUY_REGNUM) = ?         \n";
if(!"%".equals(strTAX_TYPE)) 	strSql += " And			RTRIM(A.TAX_TYPE) 	= ?         \n";
if(!"%".equals(strSTATUS)) 		strSql += " And			RTRIM(A.STATUS) 		= ?         \n";
strSql += " And			LOWER(A.DEL_STATUS) <> 'd'  		\n";
strSql += " GROUP BY A.SUP_REGNUM ,  A.SUP_COMPANY	\n";
strSql += " UNION ALL	 \n";	
strSql += "Select	'type2' LINE_FLAG ,																							\n";	
strSql += "        RTRIM(C.KN_CODE)	STATUS	,	                                    \n";
strSql += "       	F_T_DATETOSTRING(A.GEN_TM) GEN_TM		 			,                   \n";
strSql += "       	RTRIM(A.DOC_COM_ID)		DOC_COM_ID  				,                   \n";
strSql += "       	RTRIM(A.DOC_NUMBER)		DOC_NUMBER  				,                   \n";
strSql += "       	F_T_Cust_Mask(RTRIM(A.SUP_REGNUM))		SUP_REGNUM  				,   \n";
strSql += "       	RTRIM(A.SUP_COMPANY)	SUP_COMPANY  				,                   \n";
strSql += "       	F_T_Cust_Mask(RTRIM(A.BUY_REGNUM))		BUY_REGNUM  				,   \n";
strSql += "       	RTRIM(A.BUY_COMPANY)	BUY_COMPANY  				,                   \n";
strSql += "       	RTRIM(B.KN_CODE)			TAX_NAME  					,                   \n";
strSql += "       	NVL(A.TAX_SUPPRICE,0)	TAX_SUPPRICE  			,                   \n";
strSql += "       	NVL(A.TAX_TAXPRICE,0)	TAX_TAXPRICE  			,                   \n";
strSql += "       	NVL(A.PAY_TOTALPRICE,0)	PAY_TOTALPRICE			                  \n";
strSql += " From		TB_WT_SALE A , 					                                      \n";
strSql += " 				TB_WT_COMMON_CODE B,		                                      \n";
strSql += " 				( Select CD_CODE ,KN_CODE                                     \n";
strSql += " 					from TB_WT_COMMON_CODE                                      \n";
strSql += " 					Where	 CD_CLASS = 'TAX001' ) C                              \n";
strSql += " Where		RTRIM(A.TAX_TYPE)	= B.CD_CODE(+)		                          \n";
strSql += " And			RTRIM(A.STATUS)		= C.CD_CODE(+)		                          \n";
strSql += " And			A.DOC_COM_ID			= ? 							                      		\n";
strSql += " And			A.GEN_TM   		 		between ? and ?	          \n";
if(!"".equals(strSUP_REGNUM)) strSql += " And			RTRIM(A.SUP_REGNUM) = ?         \n";
if(!"".equals(strDOC_NUMBER)) strSql += " And			RTRIM(A.DOC_NUMBER) = ?         \n";
if(!"".equals(strBUY_REGNUM)) strSql += " And			RTRIM(A.BUY_REGNUM) = ?         \n";
if(!"%".equals(strTAX_TYPE)) 	strSql += " And			RTRIM(A.TAX_TYPE) 	= ?         \n";
if(!"%".equals(strSTATUS)) 		strSql += " And			RTRIM(A.STATUS) 		= ?         \n";
strSql += " And			LOWER(A.DEL_STATUS) <> 'd'			                              \n";
strSql += " And			RTRIM(B.CD_CLASS)  = 'TAX002' 	                              \n";
strSql += "  UNION ALL                                                            \n";
strSql += " Select	'type3' LINE_FLAG ,'','','','',                               \n";
strSql += "       	F_T_Cust_Mask(RTRIM(A.SUP_REGNUM))		SUP_REGNUM  				,   \n";
strSql += "       	RTRIM(A.SUP_COMPANY)	SUP_COMPANY  				,                   \n";
strSql += "       	'','공급자 소계','',                                          \n";
strSql += "       	SUM(A.TAX_SUPPRICE)	TAX_SUPPRICE  			,                     \n";
strSql += "       	SUM(A.TAX_TAXPRICE)	TAX_TAXPRICE  			,                     \n";
strSql += "       	SUM(A.PAY_TOTALPRICE)	PAY_TOTALPRICE			                    \n";
strSql += " From		TB_WT_SALE A                                                  \n";
strSql += " Where		A.DOC_COM_ID			= ? 							                      \n";
strSql += " And			A.GEN_TM   		 		between ? and ?           \n";
if(!"".equals(strSUP_REGNUM)) strSql += " And			RTRIM(A.SUP_REGNUM) = ?         \n";
if(!"".equals(strDOC_NUMBER)) strSql += " And			RTRIM(A.DOC_NUMBER) = ?         \n";
if(!"".equals(strBUY_REGNUM)) strSql += " And			RTRIM(A.BUY_REGNUM) = ?         \n";
if(!"%".equals(strTAX_TYPE)) 	strSql += " And			RTRIM(A.TAX_TYPE) 	= ?         \n";
if(!"%".equals(strSTATUS)) 		strSql += " And			RTRIM(A.STATUS) 		= ?         \n";
strSql += " And			LOWER(A.DEL_STATUS) <> 'd'  		                              \n";
strSql += " GROUP BY A.SUP_REGNUM ,  A.SUP_COMPANY                                \n";
strSql += "  UNION ALL                                                            \n";
strSql += " Select	'type4' LINE_FLAG ,'','','','',                               \n";
strSql += "       	'9'		SUP_REGNUM  				,   								\n";
strSql += "       	'' 	  SUP_COMPANY  				,                   \n";
strSql += "       	'','       총계','',                                          \n";
strSql += "       	SUM(A.TAX_SUPPRICE)	TAX_SUPPRICE  			,                     \n";
strSql += "       	SUM(A.TAX_TAXPRICE)	TAX_TAXPRICE  			,                     \n";
strSql += "       	SUM(A.PAY_TOTALPRICE)	PAY_TOTALPRICE			                    \n";
strSql += " From		TB_WT_SALE A                                                  \n";
strSql += " Where		A.DOC_COM_ID			= ? 							                      \n";
strSql += " And			A.GEN_TM   		 		between ? and ?           \n";
if(!"".equals(strSUP_REGNUM)) strSql += " And			RTRIM(A.SUP_REGNUM) = ?         \n";
if(!"".equals(strDOC_NUMBER)) strSql += " And			RTRIM(A.DOC_NUMBER) = ?         \n";
if(!"".equals(strBUY_REGNUM)) strSql += " And			RTRIM(A.BUY_REGNUM) = ?         \n";
if(!"%".equals(strTAX_TYPE)) 	strSql += " And			RTRIM(A.TAX_TYPE) 	= ?         \n";
if(!"%".equals(strSTATUS)) 		strSql += " And			RTRIM(A.STATUS) 		= ?         \n";
strSql += " And			LOWER(A.DEL_STATUS) <> 'd'  		                              \n";
strSql += " having	count(*) > 0           \n";
strSql += " group by	A.DOC_COM_ID         \n";
strSql += ")                                                                      \n";
strSql += "ORDER BY SUP_REGNUM	,LINE_FLAG		                                    \n";

   
			lrArgData.addColumn("1DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("1SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("1DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("1BUY_REGNUM", CITData.VARCHAR2);
			if(!"%".equals(strTAX_TYPE)) lrArgData.addColumn("1TAX_TYPE", CITData.VARCHAR2);
			if(!"%".equals(strSTATUS)) lrArgData.addColumn("1STATUS", CITData.VARCHAR2);			
			lrArgData.addColumn("2DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("2GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("2GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("2SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("2DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("2BUY_REGNUM", CITData.VARCHAR2);	
			if(!"%".equals(strTAX_TYPE)) lrArgData.addColumn("2TAX_TYPE", CITData.VARCHAR2);
			if(!"%".equals(strSTATUS)) lrArgData.addColumn("2STATUS", CITData.VARCHAR2);
			lrArgData.addColumn("3DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("3GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("3SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("3DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("3BUY_REGNUM", CITData.VARCHAR2);
			if(!"%".equals(strTAX_TYPE)) lrArgData.addColumn("3TAX_TYPE", CITData.VARCHAR2);
			if(!"%".equals(strSTATUS)) lrArgData.addColumn("3STATUS", CITData.VARCHAR2);
			lrArgData.addColumn("4DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("4GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("4SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("4DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("4BUY_REGNUM", CITData.VARCHAR2);	
			if(!"%".equals(strTAX_TYPE)) lrArgData.addColumn("4TAX_TYPE", CITData.VARCHAR2);
			if(!"%".equals(strSTATUS)) lrArgData.addColumn("4STATUS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("1GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("1GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("1SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("1DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("1BUY_REGNUM", strBUY_REGNUM);
			if(!"%".equals(strTAX_TYPE)) lrArgData.setValue("1TAX_TYPE", strTAX_TYPE);
			if(!"%".equals(strSTATUS)) lrArgData.setValue("1STATUS", strSTATUS);
			lrArgData.setValue("2DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("2GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("2GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("2SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("2DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("2BUY_REGNUM", strBUY_REGNUM);
			if(!"%".equals(strTAX_TYPE)) lrArgData.setValue("2TAX_TYPE", strTAX_TYPE);
			if(!"%".equals(strSTATUS)) lrArgData.setValue("2STATUS", strSTATUS);			
			lrArgData.setValue("3DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("3GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("3GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("3SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("3DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("3BUY_REGNUM", strBUY_REGNUM);
			if(!"%".equals(strTAX_TYPE)) lrArgData.setValue("3TAX_TYPE", strTAX_TYPE);
			if(!"%".equals(strSTATUS)) lrArgData.setValue("3STATUS", strSTATUS);			
			lrArgData.setValue("4DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("4GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("4GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("4SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("4DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("4BUY_REGNUM", strBUY_REGNUM);			
			if(!"%".equals(strTAX_TYPE)) lrArgData.setValue("4TAX_TYPE", strTAX_TYPE);
			if(!"%".equals(strSTATUS)) lrArgData.setValue("4STATUS", strSTATUS);			

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