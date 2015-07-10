<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WETaxDeptR_q(�μ� ���)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-11)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
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
			String strDOC_NUMBER = CITCommon.toKOR(request.getParameter("DOC_NUMBER"));

			strSql  = " Select	A.DOC_NUMBER		, \n"; 
			strSql += "       	A.DOC_COM_ID		, \n"; 
			strSql += "       	A.DOC_YYMM 			, \n"; 
			strSql += "       	A.MTSID 				, \n"; 
			strSql += "       	A.STATUS				, \n"; 
			strSql += "       	A.TX_REQ 				, \n"; 
			strSql += "       	A.DEL_STATUS  	, \n"; 
			strSql += "       	A.SENDER   			, \n"; 
			strSql += "       	A.RECEIVER			, \n"; 
			strSql += "       	A.ERR_INDEX			, \n"; 
			strSql += "       	A.ERR_MSG 			, \n"; 
			strSql += "       	A.REF_VOLUME 		, \n"; 
			strSql += "       	A.REF_NUMBER		, \n"; 
			strSql += "       	A.REF_SERIAL  	, \n"; 
			strSql += "       	RTRIM(A.REF_TYPE) REF_TYPE   	, \n"; 
			strSql += "       	RTRIM(A.TAX_TYPE)	TAX_TYPE		, \n"; 
			strSql += "       	RTRIM(A.MSG_TYPE) MSG_TYPE		, \n"; 
			strSql += "       	A.RES_FLAG			, \n"; 
			strSql += "       	A.SUP_ID				, \n"; 
			strSql += "       	A.SUP_REGNUM    , \n"; 
			strSql += "       	A.SUP_COMPANY 	, \n"; 
			strSql += "       	A.SUP_EMPLOYER	, \n"; 
			strSql += "       	A.SUP_ADDRESS  	, \n"; 
			strSql += "       	A.SUP_BIZCOND  	, \n"; 
			strSql += "       	A.SUP_BIZITEM  	, \n"; 
			strSql += "       	A.SUP_SECTOR		, \n"; 
			strSql += "       	A.SUP_EMPLOYEE	, \n"; 
			strSql += "       	A.SUP_EMPID 		, \n"; 
			strSql += "       	A.SUP_EMPEMAIL 	, \n";
			strSql += "       	A.SUP_EMPMOBILE	, \n"; 
			strSql += "       	A.BUY_COM_ID  	, \n"; 
			strSql += "       	A.BUY_ID  			, \n"; 
			strSql += "       	A.BUY_REGNUM    , \n"; 			
			strSql += "       	A.BUY_COMPANY		, \n"; 
			strSql += "       	A.BUY_EMPLOYER	, \n"; 
			strSql += "       	A.BUY_ADDRESS 	, \n"; 
			strSql += "       	A.BUY_BIZCOND 	, \n"; 
			strSql += "       	A.BUY_BIZITEM		, \n"; 
			strSql += "       	A.BUY_SECTOR  	, \n"; 
			strSql += "       	A.BUY_EMPLOYEE  , \n"; 
			strSql += "       	A.BUY_EMPID 		, \n"; 
			strSql += "       	A.BUY_EMPEMAIL 	, \n"; 
			strSql += "       	A.BUY_EMPMOBILE	, \n"; 
			strSql += "       	A.SBM_TM  			, \n"; 
			strSql += "       	F_T_DATETOSTRING(A.GEN_TM) GEN_TM 				, \n"; 
			strSql += "       	A.DLV_TM   			, \n"; 
			strSql += "       	A.RCV_TM				, \n"; 
			strSql += "       	A.ACT_TM				, \n"; 
			strSql += "       	A.DEL_TM				, \n"; 
			strSql += "       	A.XMLFILE 			, \n"; 
			strSql += "       	A.ADDFILE 			, \n"; 
			strSql += "       	A.TAX_SUPPRICE	,	\n"; 
			strSql += "       	A.TAX_TAXPRICE	, \n"; 
			strSql += "       	A.PAY_TOTALPRICE, \n";
			strSql += "       	A.TAX_BIGO   		, \n";
			strSql += "       	A.ITEM_NUM				\n";
			strSql += " From	TB_WT_SALE A  			\n";
			strSql += " Where	A.DOC_NUMBER   = ?  \n";
			
			lrArgData.addColumn("DOC_NUMBER", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DOC_NUMBER", strDOC_NUMBER);

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
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strDOC_NUMBER = CITCommon.toKOR(request.getParameter("DOC_NUMBER"));

			strSql  = " Select	F_T_DATETOSTRING(A.TAX_GENDATE)	TAX_GENDATE	, \n";
			strSql += "       	A.ITEM_CODE			, \n";
			strSql += "       	A.ITEM_NAME 		, \n";
			strSql += "       	A.ITEM_UNIT 		, \n";
			strSql += "       	A.ITEM_NUM			, \n";
			strSql += "       	A.ITEM_DANGA  	, \n";
			strSql += "       	A.TAX_SUPPRICE  , \n";
			strSql += "       	A.TAX_TAXPRICE 	, \n";
			strSql += "       	A.ITEM_BIGO			, \n";
			strSql += "       	A.DOC_NUMBER		, \n";
			strSql += "       	A.MTSID 				, \n";
			strSql += "       	A.ITEM_SEQ 			, \n";
			strSql += "       	A.COM_ID				,	\n";
			strSql += "       	'XXXXXXXXXXXXXXXX'	BUY_REGNUM		\n";
			strSql += " From	TB_WT_SALE_ITEM A   \n";
			strSql += " Where	ltrim(rtrim(A.DOC_NUMBER))  = ?   \n";
			
			lrArgData.addColumn("DOC_NUMBER", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DOC_NUMBER", strDOC_NUMBER);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				/*lrReturnData.setKey("ITEM_SEQ", true);
				lrReturnData.setKey("DOC_NUMBER", true);
				lrReturnData.setNotNull("ITEM_SEQ", true);
				lrReturnData.setNotNull("DOC_NUMBER", true);*/
			
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}		
		else if (strAct.equals("SERIAL"))
		{
			String strDOC_COM_ID = CITCommon.toKOR(request.getParameter("DOC_COM_ID"));
			String strDOC_YYMM = CITCommon.toKOR(request.getParameter("DOC_YYMM"));

			strSql  = " Select	LPAD(TO_CHAR(NVL(MAX(TO_NUMBER(REF_SERIAL)),0) + 1),10,'0') REF_SERIAL 	 \n";
			strSql += " From		TB_WT_SALE 	  		 	\n";
			strSql += " Where		DOC_COM_ID  = ?   	\n";
			strSql += " AND 		DOC_YYMM    = ?   	\n";
			
			lrArgData.addColumn("DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DOC_YYMM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DOC_COM_ID", strDOC_COM_ID);
			lrArgData.setValue("DOC_YYMM", strDOC_YYMM);

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
				GauceInfo.response.writeException("USER", "900001","REF_SERIAL Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ITEM"))
		{
			strSql  = " Select	F_T_DATETOSTRING(TAX_GENDATE)	TAX_GENDATE , \n";
			strSql += " 				ITEM_CODE ,			 		\n";
			strSql += " 				ITEM_NAME ,			 		\n";
			strSql += " 				ITEM_UNIT ,			 		\n";
			strSql += " 				ITEM_NUM ,			 		\n";
			strSql += " 				ITEM_DANGA ,			 	\n";
			strSql += " 				TAX_SUPPRICE ,			\n";
			strSql += " 				TAX_TAXPRICE ,			\n";
			strSql += " 				ITEM_BIGO 	 ,	 		\n";
			strSql += " 				DOC_NUMBER ,			 	\n";
			strSql += " 				F_T_DATETOSTRING(GEN_TM) GEN_TM ,			 			\n";
			strSql += " 				BUY_REGNUM ,				\n";
			strSql += " 				BUY_EMPID ,					\n";
			strSql += " 				TAX_BIGO 	  	 			\n";
			strSql += " From		T_WT_SALE_ITEM		 	\n";
			
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
				GauceInfo.response.writeException("USER", "900001","ITEM Select ����-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REGNUM"))
		{
			String strREG_NUM = CITCommon.toKOR(request.getParameter("REG_NUM"));			
			
			strSql  = " Select	COM_ID , 				\n";
			strSql += " 				WEBTAX21_ID ,		\n";
			strSql += " 				COMPANY ,				\n";
			strSql += " 				EMPLOYER ,			\n";
			strSql += " 				ADDRESS ,			 	\n";
			strSql += " 				BIZ_COND ,			\n";
			strSql += " 				BIZ_ITEM 			 	\n";
			strSql += " From		TB_WT_PLANT		 	\n";
			strSql += " where  	ltrim(rtrim(REG_NUM)) = ? 		\n";

			lrArgData.addColumn("REG_NUM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("REG_NUM", strREG_NUM);
							
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
				GauceInfo.response.writeException("USER", "900001","REGNUM Select ����-> "+ ex.getMessage());
			}
		}		
		else if (strAct.equals("USER"))
		{
			String strCOM_ID = CITCommon.toKOR(request.getParameter("COM_ID"));
			String strUSER = CITCommon.toKOR(request.getParameter("USER"));
			
			strSql  = " Select	SECT_NAME , 		\n";
			strSql += " 				EMP_NAME ,			\n";
			strSql += " 				EMAIL ,					\n";
			strSql += " 				MOBILE 					\n";
			strSql += " From		TB_WT_USER		 	\n";
			strSql += " where  	COM_ID = ? 			\n";
			strSql += " And	  	EMP_NO = ? 			\n";

			lrArgData.addColumn("COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("USER", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COM_ID", strCOM_ID);
			lrArgData.setValue("USER", strUSER);
							
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
				GauceInfo.response.writeException("USER", "900001","USER Select ����-> "+ ex.getMessage());
			}
		}				
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>