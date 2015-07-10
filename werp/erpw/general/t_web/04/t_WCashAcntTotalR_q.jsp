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
			String strMAKE_DT_F = CITCommon.toKOR(request.getParameter("MAKE_DT_F"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strMAKE_DT_T = CITCommon.toKOR(request.getParameter("MAKE_DT_T"));
			
			strSql  = " Select \n";
			strSql += " 	1 SEQ, \n";
			strSql += " 	a.COMP_CODE MAKE_COMP_CODE, \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	'현      금'ACC_NAME, \n";
			strSql += " 	'' ACC_REMAIN_POSITION, \n";
			strSql += " 	'' MNG_ITEM, \n";
			strSql += " 	'' BANK_CODE, \n";
			strSql += " 	'현      금' ACCT_NAME, \n";
			strSql += " 	Sum( \n";
			strSql += " 		Case \n";
			strSql += " 			When a.MAKE_DT <   ?   Then \n";
			strSql += " 				Nvl(a.DB_AMT,0) - Nvl(a.CR_AMT,0) \n";
			strSql += " 			Else \n";
			strSql += " 				0 \n";
			strSql += " 		End \n";
			strSql += " 	) PRE_REMAIN_AMT, \n";
			strSql += " 	Sum( \n";
			strSql += " 		Case \n";
			strSql += " 			When a.MAKE_DT >=   ?   Then \n";
			strSql += " 				Nvl(a.DB_AMT,0) \n";
			strSql += " 			Else \n";
			strSql += " 				0 \n";
			strSql += " 		End \n";
			strSql += " 	) SET_AMT, \n";
			strSql += " 	Sum( \n";
			strSql += " 		Case \n";
			strSql += " 			When a.MAKE_DT >=   ?   Then \n";
			strSql += " 				Nvl(a.CR_AMT,0) \n";
			strSql += " 			Else \n";
			strSql += " 				0 \n";
			strSql += " 		End \n";
			strSql += " 	) RESET_AMT, \n";
			strSql += " 	Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) REMAIN_AMT, \n";
			strSql += " 	''  BANK_NAME \n";
			strSql += " From	T_ACC_SLIP_BODY1 a \n";
			strSql += " Where	a.COMP_CODE = 	 ?  \n";
			strSql += " And		a.MAKE_DT <=    ?  \n";
			strSql += " And		a.KEEP_DT Is Not Null  \n";
			strSql += " And		a.TRANSFER_TAG ='F' \n";
			strSql += " And		a.ACC_CODE In ( Select	b.CODE_LIST_ID	From	V_T_CODE_LIST b	Where	b.CODE_GROUP_ID = 'CASH_ACC_CODE') \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.ACC_CODE \n";
			strSql += " Union All \n";
			strSql += " Select \n";
			strSql += " 	2 SEQ, \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	a.ACC_NAME, \n";
			strSql += " 	a.ACC_REMAIN_POSITION, \n";
			strSql += " 	a.MNG_ITEM, \n";
			strSql += " 	a.BANK_CODE, \n";
			strSql += " 	b1.ACCT_NAME, \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0), \n";
			strSql += " 			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) ) PRE_REMAIN_AMT, \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT),0), \n";
			strSql += " 			Nvl(Sum(a.CR_AMT),0)) SET_AMT, \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.CR_AMT),0), \n";
			strSql += " 			Nvl(Sum(a.DB_AMT),0)) RESET_AMT, \n";
			strSql += " 	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0) + Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) , \n";
			strSql += " 			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) +Nvl(Sum(a.CR_AMT),0) - Nvl(Sum(a.DB_AMT),0) ) REMAIN_AMT , \n";
			strSql += " 	b.BANK_NAME \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			c.COMP_CODE, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.ACC_NAME, \n";
			strSql += " 			a.ACC_REMAIN_POSITION, \n";
			strSql += " 			c.ACCNO MNG_ITEM, \n";
			strSql += " 			c.BANK_CODE, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT <   ?   Then \n";
			strSql += " 						c.DB_AMT \n";
			strSql += " 					Else \n";
			strSql += " 						0 \n";
			strSql += " 				End \n";
			strSql += " 			) DB_AMT_PRE, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT <   ?   Then \n";
			strSql += " 						c.CR_AMT \n";
			strSql += " 					Else \n";
			strSql += " 						0 \n";
			strSql += " 				End \n";
			strSql += " 			) CR_AMT_PRE, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT >=   ?   Then \n";
			strSql += " 						c.DB_AMT \n";
			strSql += " 					Else \n";
			strSql += " 						0 \n";
			strSql += " 				End \n";
			strSql += " 			) DB_AMT, \n";
			strSql += " 			Sum( \n";
			strSql += " 				Case When c.MAKE_DT >=   ?   Then \n";
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
			strSql += " 		And		c.COMP_CODE =    ?  \n";
			strSql += " 		And		c.KEEP_DT Is Not Null  \n";
			strSql += " 		And		c.MAKE_DT <=    ?  \n";
			strSql += " 		And		a.ACC_CODE In ( Select	b.CODE_LIST_ID	From	V_T_CODE_LIST b	Where	b.CODE_GROUP_ID = 'SAVING_ACC_CODE') \n";
			strSql += " 		And		c.TRANSFER_TAG ='F' \n";
			strSql += " 		Group By \n";
			strSql += " 			c.COMP_CODE, \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.ACC_NAME, \n";
			strSql += " 			a.ACC_REMAIN_POSITION, \n";
			strSql += " 			c.BANK_CODE , \n";
			strSql += " 			c.ACCNO \n";
			strSql += " 	) a, \n";
			strSql += " 	T_BANK_CODE b, \n";
			strSql += " 	T_ACCNO_CODE b1, \n";
			strSql += " 	t_company_org c \n";
			strSql += " Where	a.COMP_CODE = c.COMP_CODE \n";
			strSql += " And		a.MNG_ITEM = b1.ACCNO \n";
			strSql += " And		b1.BANK_CODE = b.BANK_CODE \n";
			strSql += " Having	Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0), \n";
			strSql += " 			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) ) <> 0 \n";
			strSql += " Or		Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT),0), \n";
			strSql += " 			Nvl(Sum(a.CR_AMT),0)) <> 0 \n";
			strSql += " Or		Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.CR_AMT),0), \n";
			strSql += " 			Nvl(Sum(a.DB_AMT),0)) <> 0 \n";
			strSql += " Or		Decode(a.ACC_REMAIN_POSITION,'D',Nvl(Sum(a.DB_AMT_PRE),0) - Nvl(Sum(a.CR_AMT_PRE),0) + Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) , \n";
			strSql += " 			Nvl(Sum(a.CR_AMT_PRE),0) - Nvl(Sum(a.DB_AMT_PRE),0) +Nvl(Sum(a.CR_AMT),0) - Nvl(Sum(a.DB_AMT),0) ) <> 0 \n";
			strSql += " Group By \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	a.ACC_NAME, \n";
			strSql += " 	a.ACC_REMAIN_POSITION, \n";
			strSql += " 	a.MNG_ITEM, \n";
			strSql += " 	a.BANK_CODE, \n";
			strSql += " 	b1.ACCT_NAME, \n";
			strSql += " 	b.BANK_NAME \n";
			strSql += " Order By \n";
			strSql += " 	1, \n";
			strSql += " 	2 , \n";
			strSql += " 	3 , \n";
			strSql += " 	7, \n";
			strSql += " 	6 \n";
			strSql += "  ";
			
			lrArgData.addColumn("1MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("2MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("3MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("4COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5MAKE_DT_T", CITData.DATE);
			lrArgData.addColumn("6MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("7MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("8MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("9MAKE_DT_F", CITData.DATE);
			lrArgData.addColumn("10COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11MAKE_DT_T", CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("1MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("2MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("3MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("4COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("5MAKE_DT_T", strMAKE_DT_T);
			lrArgData.setValue("6MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("7MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("8MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("9MAKE_DT_F", strMAKE_DT_F);
			lrArgData.setValue("10COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("11MAKE_DT_T", strMAKE_DT_T);
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
		else if (strAct.equals("CASH"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			
			strSql  = " Select \n";
			strSql += " 	 ?  COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(F_T_STRINGTODATE( ? )) WORK_DT , \n";
			strSql += " 	a.CASH_CODE , \n";
			strSql += " 	a.CASH_NAME, \n";
			strSql += " 	b.CRTUSERNO , \n";
			strSql += " 	b.CRTDATE , \n";
			strSql += " 	b.MODUSERNO , \n";
			strSql += " 	b.MODDATE , \n";
			strSql += " 	a.UNIT_COST , \n";
			strSql += " 	b.QTY , \n";
			strSql += " 	b.AMT \n";
			strSql += " From	T_FIN_CASH_CODE a, \n";
			strSql += " 		T_FIN_CASH_REMAIN b \n";
			strSql += " Where	a.CASH_CODE = b.CASH_CODE (+) \n";
			strSql += " And		b.COMP_CODE (+) =  ?  \n";
			strSql += " And		b.WORK_DT (+) = F_T_STRINGTODATE( ? ) \n";
			strSql += " Order By \n";
			strSql += " 	a.UNIT_COST Desc ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4WORK_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4WORK_DT", strWORK_DT);
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
				GauceInfo.response.writeException("USER", "900001","CASH Select 오류-> "+ ex.getMessage());
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