<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-22)
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
			String strACCNO = CITCommon.toKOR(request.getParameter("ACCNO"));
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strMAKE_DT_F = CITCommon.toKOR(request.getParameter("MAKE_DT_F"));
			String strMAKE_DT_T = CITCommon.toKOR(request.getParameter("MAKE_DT_T"));
			
			if(CITCommon.isNull(strBANK_CODE))
			{
				strBANK_CODE = "%";
			}
			
			strSql  = " Select \n";
			strSql += " 	a.MAKE_COMPANY, \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	a.ACC_NAME, \n";
			strSql += " 	a.MNG_ITEM, \n";
			strSql += " 	a.BANK_CODE, \n";
			strSql += " 	a.DB_AMT, \n";
			strSql += " 	a.CR_AMT, \n";
			strSql += " 	a.MAKE_SLIPNO , \n";
			strSql += " 	a.KEEP_SLIPNO , \n";
			strSql += " 	a.SUMMARY1, \n";
			strSql += " 	a.SLIP_ID , \n";
			strSql += " 	a.SLIP_IDSEQ, \n";
			strSql += " 	a.MAKE_DEPT, \n";
			strSql += " 	a.MAKE_SEQ, \n";
			strSql += " 	a.MAKE_DT, \n";
			strSql += " 	a.TAG, \n";
			strSql += " 	a.POSS_DEPT_PROJ, \n";
			strSql += " 	b.BANK_NAME \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			c.MAKE_COMP_CODE MAKE_COMPANY, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.ACC_NAME, \n";
			strSql += " 			c.ACCNO MNG_ITEM, \n";
			strSql += " 			c.BANK_CODE, \n";
			strSql += " 			Sum(c.DB_AMT) DB_AMT, \n";
			strSql += " 			Sum(c.CR_AMT) CR_AMT, \n";
			strSql += " 			Null	MAKE_SLIPNO , \n";
			strSql += " 			Null	KEEP_SLIPNO , \n";
			strSql += " 			'전일에서.......'	SUMMARY1, \n";
			strSql += " 			Null	SLIP_ID , \n";
			strSql += " 			Null	SLIP_IDSEQ, \n";
			strSql += " 			''		MAKE_DEPT, \n";
			strSql += " 			Null	MAKE_SEQ, \n";
			strSql += " 			Null	MAKE_DT, \n";
			strSql += " 			''	POSS_DEPT_PROJ, \n";
			strSql += " 			'1' TAG \n";
			strSql += " 		From	T_ACC_CODE a, \n";
			strSql += " 				T_ACC_SLIP_BODY1 c \n";
			strSql += " 		Where	a.ACCNO_MNG = 'T' \n";
			strSql += " 		And		a.ACC_CODE = c.ACC_CODE \n";
			strSql += " 		And		c.ACCNO like   Nvl( ? ,'%')   \n";
			strSql += " 		And		c.MAKE_COMP_CODE =     ?  \n";
			strSql += " 		And		a.ACC_CODE like    ?   || '%' \n";
			strSql += " 		And		c.BANK_CODE Like     ?      \n";
			strSql += " 		And		c.DEPT_CODE Like     ?    || '%' \n";
			strSql += " 		And		c.MAKE_DT <     ?  \n";
			strSql += " 		And		c.KEEP_DT Is Not Null  \n";
			strSql += " 		And		c.TRANSFER_TAG = 'F' \n";
			strSql += " 		Group By \n";
			strSql += " 			c.MAKE_COMP_CODE, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.ACC_NAME, \n";
			strSql += " 			a.ACC_REMAIN_POSITION, \n";
			strSql += " 			c.ACCNO , \n";
			strSql += " 			c.BANK_CODE \n";
			strSql += " 		Union \n";
			strSql += " 		Select \n";
			strSql += " 			b.MAKE_COMP_CODE MAKE_COMPANY, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.ACC_NAME, \n";
			strSql += " 			c.ACCNO MNG_ITEM, \n";
			strSql += " 			c.BANK_CODE, \n";
			strSql += " 			c.DB_AMT, \n";
			strSql += " 			c.CR_AMT, \n";
			strSql += " 			b.MAKE_SLIPNO , \n";
			strSql += " 			b.KEEP_SLIPNO , \n";
			strSql += " 			c.SUMMARY1, \n";
			strSql += " 			To_Char(c.SLIP_ID) SLIP_ID , \n";
			strSql += " 			To_Char(c.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 			b.MAKE_DEPT_CODE, \n";
			strSql += " 			b.MAKE_SEQ, \n";
			strSql += " 			b.MAKE_DT, \n";
			strSql += " 			c.DEPT_CODE POSS_DEPT_PROJ, \n";
			strSql += " 			'2' TAG \n";
			strSql += " 		From	T_ACC_CODE a, \n";
			strSql += " 				T_ACC_SLIP_HEAD b, \n";
			strSql += " 				T_ACC_SLIP_BODY c \n";
			strSql += " 		Where	a.ACCNO_MNG = 'T' \n";
			strSql += " 		And		a.ACC_CODE = c.ACC_CODE \n";
			strSql += " 		And		c.SLIP_ID = b.SLIP_ID \n";
			strSql += " 		And		c.ACCNO like   Nvl( ? ,'%') \n";
			strSql += " 		And		b.MAKE_COMP_CODE =     ?  \n";
			strSql += " 		And		a.ACC_CODE like    ?   || '%' \n";
			strSql += " 		And		c.BANK_CODE Like     ?     \n";
			strSql += " 		And		c.DEPT_CODE Like     ?     || '%' \n";
			strSql += " 		And		b.MAKE_DT >=     ?  \n";
			strSql += " 		And		b.MAKE_DT <=     ?  \n";
			strSql += " 		And		b.KEEP_DT Is Not Null  \n";
			strSql += " 		And		c.TRANSFER_TAG = 'F' \n";
			strSql += " 	) a, \n";
			strSql += " 	T_BANK_CODE b \n";
			strSql += " Where	a.BANK_CODE = b.BANK_CODE \n";
			strSql += " Order By a.ACC_CODE,a.BANK_CODE,a.MNG_ITEM,a.TAG,a.SLIP_ID \n";
			strSql += "  ";
			
			lrArgData.addColumn("1ACCNO", CITData.VARCHAR2);
			lrArgData.addColumn("2MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("7ACCNO", CITData.VARCHAR2);
			lrArgData.addColumn("8MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("10BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("12MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("13MAKE_DT_T", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1ACCNO", strACCNO);
			lrArgData.setValue("2MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("3ACC_CODE", strACC_CODE);
			lrArgData.setValue("4BANK_CODE", strBANK_CODE);
			lrArgData.setValue("5DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("6MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("7ACCNO", strACCNO);
			lrArgData.setValue("8MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("9ACC_CODE", strACC_CODE);
			lrArgData.setValue("10BANK_CODE", strBANK_CODE);
			lrArgData.setValue("11DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("12MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("13MAKE_DT_T", strMAKE_DT_T);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SLIP_INFO"))
		{
			
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			strSql  = " Select MAKE_COMP_CODE,MAKE_DT_TRANS,MAKE_SEQ,SLIP_KIND_TAG from T_ACC_SLIP_HEAD Where SLIP_ID = ?  \n";
			
			lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("SLIP_ID", strSLIP_ID);
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
				GauceInfo.response.writeException("USER", "900001","SLIP_INFO Select 오류-> "+ ex.getMessage());
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