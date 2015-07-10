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
			String strSTATUS 			= CITCommon.toKOR(request.getParameter("STATUS"));
			String strGEN_TM 			= CITCommon.toKOR(request.getParameter("GEN_TM"));
			String strDLV_TM 			= CITCommon.toKOR(request.getParameter("DLV_TM"));
			
			if ("T".equals(strGEN_TM))
			{
				strSql 	= " SELECT 	NULL																		STATUS,		 		\n";
				strSql += "					NULL																		GEN_TM,  			\n";
				strSql += "					'▶ 배달 : '||																  			\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'DLV',1,0)))	DOC_NUMBER,  	\n";				
				strSql += "					'▶ 수신 : '||													   						\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'RCV',1,0))) 	SUP_REGNUM,   \n";
				strSql += "					'▶ 승인 : '||													 							\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'ACK',1,0)))	SUP_COMPANY,  \n";
				strSql += "					'▶ 반려 : '||													      				\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'CAN',1,0)))	BUY_REGNUM,  	\n";				
				strSql += "					NULL																		DLV_TM,   		\n";
				strSql += "					NULL																		RCV_TM,     	\n";
				strSql += "					''																			BUY_EMPLOYEE, \n";
				strSql += "					''																			BUY_EMPID,    \n";
				strSql += "					SUM(TAX_SUPPRICE)												TAX_SUPPRICE, \n";
				strSql += "					SUM(TAX_TAXPRICE)												TAX_TAXPRICE, \n";
				strSql += "					SUM(PAY_TOTALPRICE)     								PAY_TOTALPRICE, \n";
				strSql += "					NULL																		DOC_COM_ID		\n";
				strSql += " FROM 		TB_WT_SALE				           							\n";
				strSql += " WHERE 	RTRIM(BUY_COM_ID) = ?	  									\n";				
				strSql += "	AND 		GEN_TM BETWEEN ? AND ?   									\n";
				if(!"".equals(strSUP_REGNUM)) strSql += " And	RTRIM(SUP_REGNUM) = ? \n";
				if(!"".equals(strDOC_NUMBER)) strSql += " And	RTRIM(DOC_NUMBER) = ? \n";
				if(!"".equals(strBUY_REGNUM)) strSql += " And	RTRIM(BUY_REGNUM) = ? \n";
				if(!"%".equals(strSTATUS)) 		strSql += " And	RTRIM(STATUS) = ? \n";
				strSql += "	AND 		RTRIM(STATUS)  IN ('DLV','RCV','ACK','CAN','EXT') \n";	
				strSql += "	HAVING count(*) > 0 \n";	
				strSql += "	GROUP BY BUY_COM_ID	\n";	
				strSql += " UNION ALL		 																			\n";
				strSql += " SELECT 	RTRIM(B.KN_CODE)			 STATUS,		 				\n";
				strSql += "					F_T_DATETOSTRING(RTRIM(GEN_TM))      	GEN_TM,          	\n";
				strSql += "					RTRIM(DOC_NUMBER)      DOC_NUMBER,        \n";
				strSql += "					F_T_Cust_Mask(RTRIM(SUP_REGNUM))      SUP_REGNUM,      	\n";
				strSql += "					RTRIM(SUP_COMPANY)     SUP_COMPANY,      	\n";
				strSql += "					F_T_Cust_Mask(RTRIM(BUY_REGNUM))      BUY_REGNUM,     	\n";
				strSql += "					F_T_DATETOSTRING(SUBSTR(RTRIM(DLV_TM),1,8)) || ' ' || F_T_StringToTimeFormat(SUBSTR(RTRIM(DLV_TM),9,6)) DLV_TM,\n";
				strSql += "					F_T_DATETOSTRING(RTRIM(RCV_TM))       CV_TM,						\n";				
				strSql += "					RTRIM(BUY_EMPLOYEE)    BUY_EMPLOYEE,      \n";
				strSql += "					RTRIM(BUY_EMPID)       BUY_EMPID,     		\n";
				strSql += "					NVL(TAX_SUPPRICE,0)    TAX_SUPPRICE,			\n";
				strSql += "					NVL(TAX_TAXPRICE,0)    TAX_TAXPRICE,			\n";
				strSql += "					NVL(PAY_TOTALPRICE,0)  PAY_TOTALPRICE,		\n";
				strSql += "					DOC_COM_ID						 										\n";
				strSql += " FROM 		TB_WT_SALE ,			           							\n";
				strSql += " 				( Select CD_CODE ,KN_CODE                 \n";
				strSql += " 					from TB_WT_COMMON_CODE                  \n";
				strSql += " 					Where	 CD_CLASS = 'TAX001' ) B          \n";
				strSql += " WHERE 	RTRIM(STATUS)		= B.CD_CODE(+)  				  \n";						
				strSql += "	AND 		RTRIM(BUY_COM_ID) = ?	   									\n";
				strSql += "	AND 		GEN_TM BETWEEN ? AND ?   									\n";
				if(!"".equals(strSUP_REGNUM)) strSql += " And	RTRIM(SUP_REGNUM) = ? \n";
				if(!"".equals(strDOC_NUMBER)) strSql += " And	RTRIM(DOC_NUMBER) = ? \n";
				if(!"".equals(strBUY_REGNUM)) strSql += " And	RTRIM(BUY_REGNUM) = ? \n";
				if(!"%".equals(strSTATUS)) 		strSql += " And	RTRIM(STATUS) = ? \n";
				strSql += "	AND 		RTRIM(STATUS)  IN ('DLV','RCV','ACK','CAN','EXT') \n";	

   		}
   		else
   		{
				strSql 	= " SELECT 	NULL																		STATUS,		 		\n";
				strSql += "					NULL																		GEN_TM,  			\n";
				strSql += "					'▶ 배달 : '||																  			\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'DLV',1,0)))	DOC_NUMBER,  	\n";				
				strSql += "					'▶ 수신 : '||													   						\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'RCV',1,0))) 	SUP_REGNUM,   \n";
				strSql += "					'▶ 승인 : '||													 							\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'ACK',1,0)))	SUP_COMPANY,  \n";
				strSql += "					'▶ 반려 : '||													      				\n";
				strSql += "					TO_CHAR(SUM(DECODE(RTRIM(STATUS) ,'CAN',1,0)))	BUY_REGNUM,  	\n";				
				strSql += "					NULL																		DLV_TM,   		\n";
				strSql += "					NULL																		RCV_TM,     	\n";
				strSql += "					''																			BUY_EMPLOYEE, \n";
				strSql += "					''																			BUY_EMPID,    \n";
				strSql += "					SUM(TAX_SUPPRICE)												TAX_SUPPRICE, \n";
				strSql += "					SUM(TAX_TAXPRICE)												TAX_TAXPRICE, \n";
				strSql += "					SUM(PAY_TOTALPRICE)     								PAY_TOTALPRICE, \n";
				strSql += "					NULL																		DOC_COM_ID		\n";
				strSql += " FROM 		TB_WT_SALE				           							\n";
				strSql += " WHERE 	RTRIM(BUY_COM_ID) = ?	  									\n";				
				strSql += "	AND 		DLV_TM BETWEEN ? AND ?   									\n";
				if(!"".equals(strSUP_REGNUM)) strSql += " And	RTRIM(SUP_REGNUM) = ? \n";
				if(!"".equals(strDOC_NUMBER)) strSql += " And	RTRIM(DOC_NUMBER) = ? \n";
				if(!"".equals(strBUY_REGNUM)) strSql += " And	RTRIM(BUY_REGNUM) = ? \n";
				if(!"%".equals(strSTATUS)) 		strSql += " And	RTRIM(STATUS) = ? \n";
				strSql += "	AND 		RTRIM(STATUS)  IN ('DLV','RCV','ACK','CAN','EXT') \n";	
				strSql += "	HAVING count(*) > 0 \n";	
				strSql += "	GROUP BY BUY_COM_ID	\n";	
				strSql += " UNION ALL		 																			\n";
				strSql += " SELECT 	RTRIM(B.KN_CODE)			 STATUS,		 				\n";
				strSql += "					F_T_DATETOSTRING(RTRIM(GEN_TM))      	GEN_TM,          	\n";
				strSql += "					RTRIM(DOC_NUMBER)      DOC_NUMBER,        \n";
				strSql += "					F_T_Cust_Mask(RTRIM(SUP_REGNUM))      SUP_REGNUM,      	\n";
				strSql += "					RTRIM(SUP_COMPANY)     SUP_COMPANY,      	\n";
				strSql += "					F_T_Cust_Mask(RTRIM(BUY_REGNUM))      BUY_REGNUM,     	\n";
				strSql += "					F_T_DATETOSTRING(SUBSTR(RTRIM(DLV_TM),1,8)) || ' ' || F_T_StringToTimeFormat(SUBSTR(RTRIM(DLV_TM),9,6)) DLV_TM,\n";
				strSql += "					F_T_DATETOSTRING(RTRIM(RCV_TM))       CV_TM,						\n";				
				strSql += "					RTRIM(BUY_EMPLOYEE)    BUY_EMPLOYEE,      \n";
				strSql += "					RTRIM(BUY_EMPID)       BUY_EMPID,     		\n";
				strSql += "					NVL(TAX_SUPPRICE,0)    TAX_SUPPRICE,			\n";
				strSql += "					NVL(TAX_TAXPRICE,0)    TAX_TAXPRICE,			\n";
				strSql += "					NVL(PAY_TOTALPRICE,0)  PAY_TOTALPRICE,		\n";
				strSql += "					DOC_COM_ID						 										\n";
				strSql += " FROM 		TB_WT_SALE ,			           							\n";
				strSql += " 				( Select CD_CODE ,KN_CODE                 \n";
				strSql += " 					from TB_WT_COMMON_CODE                  \n";
				strSql += " 					Where	 CD_CLASS = 'TAX001' ) B          \n";
				strSql += " WHERE 	RTRIM(STATUS)		= B.CD_CODE(+)  				  \n";						
				strSql += "	AND 		RTRIM(BUY_COM_ID) = ?	   									\n";
				strSql += "	AND 		DLV_TM BETWEEN ? AND ?   									\n";
				if(!"".equals(strSUP_REGNUM)) strSql += " And	RTRIM(SUP_REGNUM) = ? \n";
				if(!"".equals(strDOC_NUMBER)) strSql += " And	RTRIM(DOC_NUMBER) = ? \n";
				if(!"".equals(strBUY_REGNUM)) strSql += " And	RTRIM(BUY_REGNUM) = ? \n";
				if(!"%".equals(strSTATUS)) 		strSql += " And	RTRIM(STATUS) = ? \n";
				strSql += "	AND 		RTRIM(STATUS)  IN ('DLV','RCV','ACK','CAN','EXT') \n";	
			}
			
			lrArgData.addColumn("1DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("1SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("1DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("1BUY_REGNUM", CITData.VARCHAR2);
			if(!"%".equals(strSTATUS)) lrArgData.addColumn("1STATUS", CITData.VARCHAR2);
			lrArgData.addColumn("2DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("2GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("2GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("2SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("2DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("2BUY_REGNUM", CITData.VARCHAR2);
			if(!"%".equals(strSTATUS)) lrArgData.addColumn("2STATUS", CITData.VARCHAR2);			
			lrArgData.addRow();
			lrArgData.setValue("1DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("1GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("1GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("1SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("1DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("1BUY_REGNUM", strBUY_REGNUM);
			if(!"%".equals(strSTATUS)) lrArgData.setValue("1STATUS", strSTATUS);
			lrArgData.setValue("2DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("2GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("2GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("2SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("2DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("2BUY_REGNUM", strBUY_REGNUM);
			if(!"%".equals(strSTATUS)) lrArgData.setValue("2STATUS", strSTATUS);			
			
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