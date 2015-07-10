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
			String strKEEP_DT_F = CITCommon.toKOR(request.getParameter("KEEP_DT_F"));
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strKEEP_DT_T = CITCommon.toKOR(request.getParameter("KEEP_DT_T"));
			
			strSql  = " Select  \n";
			strSql += " 	a.MAKE_COMP_CODE ,  \n";
			strSql += " 	a.ACC_CODE,  \n";
			strSql += " 	c.COMPANY_NAME,  \n";
			strSql += " 	a.ACC_NAME,  \n";
			strSql += " 	a.ACC_REMAIN_POSITION,  \n";
			strSql += " 	a.BANK_CODE,  \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0),  \n";
			strSql += " 			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) ) PRE_REMAIN_AMT,  \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT),0),  \n";
			strSql += " 			Nvl(Sum(a.CR_AMT),0)) SET_AMT,  \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.CR_AMT),0),  \n";
			strSql += " 			Nvl(Sum(a.DB_AMT),0)) RESET_AMT,  \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0) + Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) ,  \n";
			strSql += " 			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) +Nvl(Sum(a.CR_AMT),0) - Nvl(Sum(a.DB_AMT),0) ) REMAIN_AMT , \n";
			strSql += " 	b.BANK_NAME  \n";
			strSql += " From  \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			c.MAKE_COMP_CODE, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.ACC_NAME, \n";
			strSql += " 			a.ACC_REMAIN_POSITION, \n";
			strSql += " 			c.BANK_CODE, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT <  ?  Then \n";
			strSql += " 						c.DB_AMT \n";
			strSql += " 					Else \n";
			strSql += " 						0 \n";
			strSql += " 				End \n";
			strSql += " 			) DB_AMT_PRE, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT <  ?  Then \n";
			strSql += " 						c.CR_AMT \n";
			strSql += " 					Else \n";
			strSql += " 						0 \n";
			strSql += " 				End \n";
			strSql += " 			) CR_AMT_PRE, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT >=  ?  Then \n";
			strSql += " 						c.DB_AMT \n";
			strSql += " 					Else \n";
			strSql += " 						0 \n";
			strSql += " 				End \n";
			strSql += " 			) DB_AMT, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT >=  ?  Then \n";
			strSql += " 						c.CR_AMT \n";
			strSql += " 					Else \n";
			strSql += " 						0 \n";
			strSql += " 				End \n";
			strSql += " 			) CR_AMT \n";
			strSql += " 		From	T_ACC_CODE a, \n";
			strSql += " 				T_ACC_SLIP_BODY1 c \n";
			strSql += " 		Where	a.ACCNO_MNG = 'T' \n";
			strSql += " 		And		a.FUND_INPUT_CLS = 'T' \n";
			strSql += " 		And		a.ACC_CODE = c.ACC_CODE \n";
			strSql += " 		And		c.MAKE_COMP_CODE =   ?  \n";
			strSql += " 		And		a.ACC_CODE Like   ?   || '%' \n";
			strSql += " 		And		c.BANK_CODE Like   ?   || '%' \n";
			strSql += " 		And		c.MAKE_DT <=   ?  \n";
			strSql += " 		And		c.KEEP_DT Is Not Null  \n";
			strSql += " 		And		c.TRANSFER_TAG ='F' \n";
			strSql += " 		Group By \n";
			strSql += " 			c.MAKE_COMP_CODE, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.ACC_NAME, \n";
			strSql += " 			a.ACC_REMAIN_POSITION, \n";
			strSql += " 			c.BANK_CODE  \n";
			strSql += " 	) a, \n";
			strSql += " 	T_BANK_CODE b, \n";
			strSql += " 	t_company c \n";
			strSql += " Where	a.BANK_CODE = b.BANK_CODE \n";
			strSql += " And		a.MAKE_COMP_CODE = c.COMP_CODE \n";
			strSql += " Group By  \n";
			strSql += " 	a.MAKE_COMP_CODE,  \n";
			strSql += " 	a.ACC_CODE,  \n";
			strSql += " 	a.ACC_NAME,  \n";
			strSql += " 	a.ACC_REMAIN_POSITION,  \n";
			strSql += " 	c.COMPANY_NAME,  \n";
			strSql += " 	a.BANK_CODE, \n";
			strSql += " 	b.BANK_NAME  \n";
			strSql += "  ";
			
			lrArgData.addColumn("1KEEP_DT_F", CITData.DATE);
			lrArgData.addColumn("2KEEP_DT_F", CITData.DATE);
			lrArgData.addColumn("3KEEP_DT_F", CITData.DATE);
			lrArgData.addColumn("4KEEP_DT_F", CITData.DATE);
			lrArgData.addColumn("3MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6KEEP_DT_T", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1KEEP_DT_F", strKEEP_DT_F);
			lrArgData.setValue("2KEEP_DT_F", strKEEP_DT_F);
			lrArgData.setValue("3KEEP_DT_F", strKEEP_DT_F);
			lrArgData.setValue("4KEEP_DT_F", strKEEP_DT_F);
			lrArgData.setValue("3MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("4ACC_CODE", strACC_CODE);
			lrArgData.setValue("5BANK_CODE", strBANK_CODE);
			lrArgData.setValue("6KEEP_DT_T", strKEEP_DT_T);
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