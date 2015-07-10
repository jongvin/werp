<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsSLIP_H = null;
	GauceDataSet dsSLIP_D = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if(strAct.equals("SLIP_H"))
		{
			dsSLIP_H = GauceInfo.request.getGauceDataSet("dsSLIP_H");
			
			if (dsSLIP_H == null) throw new Exception("dsSLIP_H이(가) 널(Null)입니다.");
			
			rows = dsSLIP_H.getDataRows();

			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_TB_WT_SALE_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";

						lrArgData.addColumn("DOC_NUMBER", 		CITData.VARCHAR2);
						lrArgData.addColumn("DOC_COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("DOC_YYMM", 			CITData.VARCHAR2);
						lrArgData.addColumn("MTSID", 					CITData.VARCHAR2);
						lrArgData.addColumn("STATUS", 				CITData.VARCHAR2);
						lrArgData.addColumn("TX_REQ", 				CITData.VARCHAR2);
						lrArgData.addColumn("DEL_STATUS", 		CITData.VARCHAR2);
						lrArgData.addColumn("SENDER", 				CITData.VARCHAR2);
						lrArgData.addColumn("RECEIVER",			  CITData.VARCHAR2);
						lrArgData.addColumn("REF_SERIAL",  	  CITData.VARCHAR2);
						lrArgData.addColumn("REF_TYPE",       CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TYPE",       CITData.VARCHAR2);
						lrArgData.addColumn("MSG_TYPE",       CITData.VARCHAR2);
						lrArgData.addColumn("RES_FLAG",       CITData.VARCHAR2);
						lrArgData.addColumn("SUP_ID",	        CITData.VARCHAR2);
						lrArgData.addColumn("SUP_REGNUM",     CITData.VARCHAR2);
						lrArgData.addColumn("SUP_COMPANY", 	  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPLOYER",	  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_ADDRESS",  	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_BIZCOND",  	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_BIZITEM",  	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_SECTOR",		  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPLOYEE",	  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPID", 		  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPEMAIL", 	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPMOBILE",	CITData.VARCHAR2);
						lrArgData.addColumn("BUY_COM_ID",  	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_ID",  			  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_REGNUM",     CITData.VARCHAR2);
						lrArgData.addColumn("BUY_COMPANY",		CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPLOYER",	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_ADDRESS", 	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_BIZCOND", 	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_BIZITEM",		CITData.VARCHAR2);
						lrArgData.addColumn("BUY_SECTOR",  	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPLOYEE",   CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPID", 		  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPEMAIL", 	CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPMOBILE",	CITData.VARCHAR2);
						lrArgData.addColumn("SBM_TM",  			  CITData.VARCHAR2);
						lrArgData.addColumn("GEN_TM",  			  CITData.VARCHAR2);
						lrArgData.addColumn("TAX_SUPPRICE",   CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TAXPRICE",   CITData.VARCHAR2);
						lrArgData.addColumn("PAY_TOTALPRICE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_BIGO",   		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NUM",			  CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("DOC_NUMBER", 		  rows[i].getString(dsSLIP_H.indexOfColumn("DOC_NUMBER")));
						lrArgData.setValue("DOC_COM_ID", 		  rows[i].getString(dsSLIP_H.indexOfColumn("DOC_COM_ID")));
						lrArgData.setValue("DOC_YYMM", 			  rows[i].getString(dsSLIP_H.indexOfColumn("DOC_YYMM")));
						lrArgData.setValue("MTSID", 					rows[i].getString(dsSLIP_H.indexOfColumn("MTSID")));
						lrArgData.setValue("STATUS", 				  rows[i].getString(dsSLIP_H.indexOfColumn("STATUS")));
						lrArgData.setValue("TX_REQ", 				  rows[i].getString(dsSLIP_H.indexOfColumn("TX_REQ")));
						lrArgData.setValue("DEL_STATUS", 		  rows[i].getString(dsSLIP_H.indexOfColumn("DEL_STATUS")));
						lrArgData.setValue("SENDER", 				  rows[i].getString(dsSLIP_H.indexOfColumn("SENDER")));
						lrArgData.setValue("RECEIVER",			  rows[i].getString(dsSLIP_H.indexOfColumn("RECEIVER")));
						lrArgData.setValue("REF_SERIAL",  	  rows[i].getString(dsSLIP_H.indexOfColumn("REF_SERIAL")));
						lrArgData.setValue("REF_TYPE",        rows[i].getString(dsSLIP_H.indexOfColumn("REF_TYPE")));
						lrArgData.setValue("TAX_TYPE",        rows[i].getString(dsSLIP_H.indexOfColumn("TAX_TYPE")));
						lrArgData.setValue("MSG_TYPE",        rows[i].getString(dsSLIP_H.indexOfColumn("MSG_TYPE")));
						lrArgData.setValue("RES_FLAG",        rows[i].getString(dsSLIP_H.indexOfColumn("RES_FLAG")));
						lrArgData.setValue("SUP_ID",	        rows[i].getString(dsSLIP_H.indexOfColumn("SUP_ID")));
						lrArgData.setValue("SUP_REGNUM",      rows[i].getString(dsSLIP_H.indexOfColumn("SUP_REGNUM")));
						lrArgData.setValue("SUP_COMPANY", 	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_COMPANY")));
						lrArgData.setValue("SUP_EMPLOYER",	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPLOYER")));
						lrArgData.setValue("SUP_ADDRESS",  	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_ADDRESS")));
						lrArgData.setValue("SUP_BIZCOND",  	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_BIZCOND")));
						lrArgData.setValue("SUP_BIZITEM",  	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_BIZITEM")));
						lrArgData.setValue("SUP_SECTOR",		  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_SECTOR")));
						lrArgData.setValue("SUP_EMPLOYEE",	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPLOYEE")));
						lrArgData.setValue("SUP_EMPID", 		  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPID")));
						lrArgData.setValue("SUP_EMPEMAIL", 	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPEMAIL")));
						lrArgData.setValue("SUP_EMPMOBILE",	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPMOBILE")));
						lrArgData.setValue("BUY_COM_ID",  	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_COM_ID")));
						lrArgData.setValue("BUY_ID",  			  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_ID")));
						lrArgData.setValue("BUY_REGNUM",      rows[i].getString(dsSLIP_H.indexOfColumn("BUY_REGNUM")));
						lrArgData.setValue("BUY_COMPANY",		  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_COMPANY")));
						lrArgData.setValue("BUY_EMPLOYER",	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPLOYER")));
						lrArgData.setValue("BUY_ADDRESS", 	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_ADDRESS")));
						lrArgData.setValue("BUY_BIZCOND", 	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_BIZCOND")));
						lrArgData.setValue("BUY_BIZITEM",		  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_BIZITEM")));
						lrArgData.setValue("BUY_SECTOR",  	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_SECTOR")));
						lrArgData.setValue("BUY_EMPLOYEE",    rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPLOYEE")));
						lrArgData.setValue("BUY_EMPID", 		  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPID")));
						lrArgData.setValue("BUY_EMPEMAIL", 	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPEMAIL")));
						lrArgData.setValue("BUY_EMPMOBILE",	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPMOBILE")));
						lrArgData.setValue("SBM_TM",  			  rows[i].getString(dsSLIP_H.indexOfColumn("SBM_TM")));
						lrArgData.setValue("GEN_TM",  			  rows[i].getString(dsSLIP_H.indexOfColumn("GEN_TM")));
						lrArgData.setValue("TAX_SUPPRICE",    rows[i].getString(dsSLIP_H.indexOfColumn("TAX_SUPPRICE")));
						lrArgData.setValue("TAX_TAXPRICE",    rows[i].getString(dsSLIP_H.indexOfColumn("TAX_TAXPRICE")));
						lrArgData.setValue("PAY_TOTALPRICE",  rows[i].getString(dsSLIP_H.indexOfColumn("PAY_TOTALPRICE")));
						lrArgData.setValue("TAX_BIGO",   		  rows[i].getString(dsSLIP_H.indexOfColumn("TAX_BIGO")));
						lrArgData.setValue("ITEM_NUM",			  rows[i].getString(dsSLIP_H.indexOfColumn("ITEM_NUM")));
						
						CITDatabase.executeProcedure(strSql, lrArgData, conn);
						
						lrArgData = new CITData();
						
						strSql = "{call SP_TB_WT_SALE_CAN_I(?,?)}";

						lrArgData.addColumn("DOC_NUMBER", 		CITData.VARCHAR2);
						lrArgData.addColumn("DOC_BEFORE", 		CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("DOC_NUMBER", 		  rows[i].getString(dsSLIP_H.indexOfColumn("DOC_NUMBER")));
						lrArgData.setValue("DOC_BEFORE", 		  rows[i].getString(dsSLIP_H.indexOfColumn("BEFORE_DOC")));												
					}                    
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{                    
						strSql = "{call SP_TB_WT_SALE_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DOC_NUMBER", 		CITData.VARCHAR2);
						lrArgData.addColumn("DOC_COM_ID", 		CITData.VARCHAR2);
						lrArgData.addColumn("DOC_YYMM", 			CITData.VARCHAR2);
						lrArgData.addColumn("MTSID", 					CITData.VARCHAR2);
						lrArgData.addColumn("STATUS", 				CITData.VARCHAR2);
						lrArgData.addColumn("TX_REQ", 				CITData.VARCHAR2);
						lrArgData.addColumn("DEL_STATUS", 		CITData.VARCHAR2);
						lrArgData.addColumn("SENDER", 				CITData.VARCHAR2);
						lrArgData.addColumn("RECEIVER",			  CITData.VARCHAR2);
						lrArgData.addColumn("REF_SERIAL",  	  CITData.VARCHAR2);
						lrArgData.addColumn("REF_TYPE",       CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TYPE",       CITData.VARCHAR2);
						lrArgData.addColumn("MSG_TYPE",       CITData.VARCHAR2);
						lrArgData.addColumn("RES_FLAG",       CITData.VARCHAR2);
						lrArgData.addColumn("SUP_ID",	        CITData.VARCHAR2);
						lrArgData.addColumn("SUP_REGNUM",     CITData.VARCHAR2);
						lrArgData.addColumn("SUP_COMPANY", 	  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPLOYER",	  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_ADDRESS",  	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_BIZCOND",  	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_BIZITEM",  	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_SECTOR",		  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPLOYEE",	  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPID", 		  CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPEMAIL", 	CITData.VARCHAR2);
						lrArgData.addColumn("SUP_EMPMOBILE",	CITData.VARCHAR2);
						lrArgData.addColumn("BUY_COM_ID",  	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_ID",  			  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_REGNUM",     CITData.VARCHAR2);
						lrArgData.addColumn("BUY_COMPANY",		CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPLOYER",	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_ADDRESS", 	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_BIZCOND", 	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_BIZITEM",		CITData.VARCHAR2);
						lrArgData.addColumn("BUY_SECTOR",  	  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPLOYEE",   CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPID", 		  CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPEMAIL", 	CITData.VARCHAR2);
						lrArgData.addColumn("BUY_EMPMOBILE",	CITData.VARCHAR2);
						lrArgData.addColumn("SBM_TM",  			  CITData.VARCHAR2);
						lrArgData.addColumn("GEN_TM",  			  CITData.VARCHAR2);
						lrArgData.addColumn("TAX_SUPPRICE",   CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TAXPRICE",   CITData.VARCHAR2);
						lrArgData.addColumn("PAY_TOTALPRICE", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_BIGO",   		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NUM",			  CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("DOC_NUMBER", 		  rows[i].getString(dsSLIP_H.indexOfColumn("DOC_NUMBER")));
						lrArgData.setValue("DOC_COM_ID", 		  rows[i].getString(dsSLIP_H.indexOfColumn("DOC_COM_ID")));
						lrArgData.setValue("DOC_YYMM", 			  rows[i].getString(dsSLIP_H.indexOfColumn("DOC_YYMM")));
						lrArgData.setValue("MTSID", 					rows[i].getString(dsSLIP_H.indexOfColumn("MTSID")));
						lrArgData.setValue("STATUS", 				  rows[i].getString(dsSLIP_H.indexOfColumn("STATUS")));
						lrArgData.setValue("TX_REQ", 				  rows[i].getString(dsSLIP_H.indexOfColumn("TX_REQ")));
						lrArgData.setValue("DEL_STATUS", 		  rows[i].getString(dsSLIP_H.indexOfColumn("DEL_STATUS")));
						lrArgData.setValue("SENDER", 				  rows[i].getString(dsSLIP_H.indexOfColumn("SENDER")));
						lrArgData.setValue("RECEIVER",			  rows[i].getString(dsSLIP_H.indexOfColumn("RECEIVER")));
						lrArgData.setValue("REF_SERIAL",  	  rows[i].getString(dsSLIP_H.indexOfColumn("REF_SERIAL")));
						lrArgData.setValue("REF_TYPE",        rows[i].getString(dsSLIP_H.indexOfColumn("REF_TYPE")));
						lrArgData.setValue("TAX_TYPE",        rows[i].getString(dsSLIP_H.indexOfColumn("TAX_TYPE")));
						lrArgData.setValue("MSG_TYPE",        rows[i].getString(dsSLIP_H.indexOfColumn("MSG_TYPE")));
						lrArgData.setValue("RES_FLAG",        rows[i].getString(dsSLIP_H.indexOfColumn("RES_FLAG")));
						lrArgData.setValue("SUP_ID",	        rows[i].getString(dsSLIP_H.indexOfColumn("SUP_ID")));
						lrArgData.setValue("SUP_REGNUM",      rows[i].getString(dsSLIP_H.indexOfColumn("SUP_REGNUM")));
						lrArgData.setValue("SUP_COMPANY", 	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_COMPANY")));
						lrArgData.setValue("SUP_EMPLOYER",	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPLOYER")));
						lrArgData.setValue("SUP_ADDRESS",  	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_ADDRESS")));
						lrArgData.setValue("SUP_BIZCOND",  	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_BIZCOND")));
						lrArgData.setValue("SUP_BIZITEM",  	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_BIZITEM")));
						lrArgData.setValue("SUP_SECTOR",		  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_SECTOR")));
						lrArgData.setValue("SUP_EMPLOYEE",	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPLOYEE")));
						lrArgData.setValue("SUP_EMPID", 		  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPID")));
						lrArgData.setValue("SUP_EMPEMAIL", 	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPEMAIL")));
						lrArgData.setValue("SUP_EMPMOBILE",	  rows[i].getString(dsSLIP_H.indexOfColumn("SUP_EMPMOBILE")));
						lrArgData.setValue("BUY_COM_ID",  	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_COM_ID")));
						lrArgData.setValue("BUY_ID",  			  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_ID")));
						lrArgData.setValue("BUY_REGNUM",      rows[i].getString(dsSLIP_H.indexOfColumn("BUY_REGNUM")));
						lrArgData.setValue("BUY_COMPANY",		  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_COMPANY")));
						lrArgData.setValue("BUY_EMPLOYER",	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPLOYER")));
						lrArgData.setValue("BUY_ADDRESS", 	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_ADDRESS")));
						lrArgData.setValue("BUY_BIZCOND", 	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_BIZCOND")));
						lrArgData.setValue("BUY_BIZITEM",		  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_BIZITEM")));
						lrArgData.setValue("BUY_SECTOR",  	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_SECTOR")));
						lrArgData.setValue("BUY_EMPLOYEE",    rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPLOYEE")));
						lrArgData.setValue("BUY_EMPID", 		  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPID")));
						lrArgData.setValue("BUY_EMPEMAIL", 	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPEMAIL")));
						lrArgData.setValue("BUY_EMPMOBILE",	  rows[i].getString(dsSLIP_H.indexOfColumn("BUY_EMPMOBILE")));
						lrArgData.setValue("SBM_TM",  			  rows[i].getString(dsSLIP_H.indexOfColumn("SBM_TM")));
						lrArgData.setValue("GEN_TM",  			  rows[i].getString(dsSLIP_H.indexOfColumn("GEN_TM")));
						lrArgData.setValue("TAX_SUPPRICE",    rows[i].getString(dsSLIP_H.indexOfColumn("TAX_SUPPRICE")));
						lrArgData.setValue("TAX_TAXPRICE",    rows[i].getString(dsSLIP_H.indexOfColumn("TAX_TAXPRICE")));
						lrArgData.setValue("PAY_TOTALPRICE",  rows[i].getString(dsSLIP_H.indexOfColumn("PAY_TOTALPRICE")));
						lrArgData.setValue("TAX_BIGO",   		  rows[i].getString(dsSLIP_H.indexOfColumn("TAX_BIGO")));
						lrArgData.setValue("ITEM_NUM",			  rows[i].getString(dsSLIP_H.indexOfColumn("ITEM_NUM")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						continue;
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "TB_WT_SALE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		//}
		//else if (strAct.equals("SLIP_D"))
		//{
			dsSLIP_D = GauceInfo.request.getGauceDataSet("dsSLIP_D");
			
			if (dsSLIP_D == null) throw new Exception("dsSLIP_D이(가) 널(Null)입니다.");
			
			rows = dsSLIP_D.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_TB_WT_SALE_ITEM_I(?,?,?,?,?,?,?,?,?,?,?,?,?)}";

						lrArgData.addColumn("DOC_NUMBER",   	CITData.VARCHAR2);
						lrArgData.addColumn("TAX_GENDATE",		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE",			CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", 	  	CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_UNIT", 	  	CITData.VARCHAR2);
						lrArgData.addColumn("IITEM_NUM",			CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_DANGA", 		CITData.VARCHAR2);
						lrArgData.addColumn("TAX_SUPPRICE", 	CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TAXPRICE",   CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_BIGO",		  CITData.VARCHAR2);
						lrArgData.addColumn("MTSID",          CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_SEQ",       CITData.VARCHAR2);
						lrArgData.addColumn("COM_ID",         CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("DOC_NUMBER",   	  rows[i].getString(dsSLIP_D.indexOfColumn("DOC_NUMBER")));
						lrArgData.setValue("TAX_GENDATE",	 	  rows[i].getString(dsSLIP_D.indexOfColumn("TAX_GENDATE")));
						lrArgData.setValue("ITEM_CODE",		 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NAME", 	 		rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("ITEM_UNIT", 	 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_UNIT")));
						lrArgData.setValue("IITEM_NUM",		 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_NUM")));
						lrArgData.setValue("ITEM_DANGA", 	 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_DANGA")));
						lrArgData.setValue("TAX_SUPPRICE", 	  rows[i].getString(dsSLIP_D.indexOfColumn("TAX_SUPPRICE")));
						lrArgData.setValue("TAX_TAXPRICE", 	  rows[i].getString(dsSLIP_D.indexOfColumn("TAX_TAXPRICE")));
						lrArgData.setValue("ITEM_BIGO",		 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_BIGO")));
						lrArgData.setValue("MTSID",           rows[i].getString(dsSLIP_D.indexOfColumn("MTSID")));
						lrArgData.setValue("ITEM_SEQ",        rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_SEQ")));
						lrArgData.setValue("COM_ID",          rows[i].getString(dsSLIP_D.indexOfColumn("COM_ID")));
					}                    
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{                    
						strSql = "{call SP_TB_WT_SALE_ITEM_U(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("DOC_NUMBER",   	CITData.VARCHAR2);
						lrArgData.addColumn("TAX_GENDATE",		CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE",			CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NAME", 	  	CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_UNIT", 	  	CITData.VARCHAR2);
						lrArgData.addColumn("IITEM_NUM",			CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_DANGA", 		CITData.VARCHAR2);
						lrArgData.addColumn("TAX_SUPPRICE", 	CITData.VARCHAR2);
						lrArgData.addColumn("TAX_TAXPRICE",   CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_BIGO",		  CITData.VARCHAR2);
						lrArgData.addColumn("MTSID",          CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_SEQ",       CITData.VARCHAR2);
						lrArgData.addColumn("COM_ID",         CITData.VARCHAR2);
						lrArgData.addRow();
						lrArgData.setValue("DOC_NUMBER",   	  rows[i].getString(dsSLIP_D.indexOfColumn("DOC_NUMBER")));
						lrArgData.setValue("TAX_GENDATE",	 	  rows[i].getString(dsSLIP_D.indexOfColumn("TAX_GENDATE")));
						lrArgData.setValue("ITEM_CODE",		 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NAME", 	 		rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_NAME")));
						lrArgData.setValue("ITEM_UNIT", 	 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_UNIT")));
						lrArgData.setValue("IITEM_NUM",		 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_NUM")));
						lrArgData.setValue("ITEM_DANGA", 	 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_DANGA")));
						lrArgData.setValue("TAX_SUPPRICE", 	  rows[i].getString(dsSLIP_D.indexOfColumn("TAX_SUPPRICE")));
						lrArgData.setValue("TAX_TAXPRICE", 	  rows[i].getString(dsSLIP_D.indexOfColumn("TAX_TAXPRICE")));
						lrArgData.setValue("ITEM_BIGO",		 	  rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_BIGO")));
						lrArgData.setValue("MTSID",           rows[i].getString(dsSLIP_D.indexOfColumn("MTSID")));
						lrArgData.setValue("ITEM_SEQ",        rows[i].getString(dsSLIP_D.indexOfColumn("ITEM_SEQ")));
						lrArgData.setValue("COM_ID",          rows[i].getString(dsSLIP_D.indexOfColumn("COM_ID")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						continue;
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "TB_WT_SALE_ITEM 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}			
		}	
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>
