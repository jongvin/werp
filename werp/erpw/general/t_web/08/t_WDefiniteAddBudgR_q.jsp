<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
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
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCHG_SEQ = CITCommon.toKOR(request.getParameter("CHG_SEQ"));
			
			strSql  = " select a1.COMP_CODE,			 \n";
			strSql += " 	   a1.CLSE_ACC_ID,	 \n";
			strSql += " 	   a1.DEPT_CODE,			 \n";
			strSql += " 	   a1.CHG_SEQ,		 \n";
			strSql += " 	   a1.BUDG_CODE_NO, \n";
			strSql += " 	   b1.budg_code_name, \n";
			strSql += " 	   b1.full_path,				 \n";
			strSql += " 	   a1.RESERVED_SEQ,		 \n";
			strSql += " 	   to_char(a1.BUDG_YM,'YYYY-MM') budg_ym, \n";
			strSql += " 	   a1.chg_amt_sum \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select  \n";
			strSql += " 			a.COMP_CODE,			 \n";
			strSql += " 			a.CLSE_ACC_ID,	 \n";
			strSql += " 			a.DEPT_CODE,			 \n";
			strSql += " 			a.CHG_SEQ,		 \n";
			strSql += " 			a.BUDG_CODE_NO,		 \n";
			strSql += " 			a.RESERVED_SEQ,		 \n";
			strSql += " 			a.BUDG_YM,		 \n";
			strSql += " 			SUM(CHG_AMT) chg_amt_sum		 \n";
			strSql += " 	from t_budg_chg_reason a \n";
		      //strSql += " 	where a.chg_seq=1 \n";
			strSql += " 	group by a.COMP_CODE,			 \n";
			strSql += " 			 a.CLSE_ACC_ID,	 \n";
			strSql += " 			 a.DEPT_CODE,			 \n";
			strSql += " 			 a.CHG_SEQ,		 \n";
			strSql += " 			 a.BUDG_CODE_NO,		 \n";
			strSql += " 			 a.RESERVED_SEQ,		 \n";
			strSql += " 			 a.BUDG_YM \n";
			strSql += " 	) a1, \n";
			strSql += " 	( \n";
			strSql += " 	Select  \n";
			strSql += " 		b.BUDG_CODE_NO ,  \n";
			strSql += " 		b.P_BUDG_CODE_NO ,  \n";
			strSql += " 		b.LEVEL_SEQ ,  \n";
			strSql += " 		b.LEGACY_BUDG_CODE ,  \n";
			strSql += " 		b.BUDG_CODE_NAME ,  \n";
			strSql += " 		Replace(Sys_Connect_By_Path(Replace(b.BUDG_CODE_NAME,'/','@#$%'),'/'),'@#$%','/') FULL_PATH,  \n";
			strSql += " 		b.ACC_CODE ,  \n";
			strSql += " 		b.USE_CLS ,  \n";
			strSql += " 		b.CONTROL_LEVEL_TAG ,  \n";
			strSql += " 		b.BUDG_ITEM_CODE, 	   \n";
			strSql += " 		b.MAKE_DEPT, \n";
			strSql += " 		RowNum Rn  \n";
			strSql += " 	from	(select * from T_BUDG_CODE where comp_code =  ? ) b\n";
			strSql += " 	Connect By  \n";
			strSql += " 		Prior	b.BUDG_CODE_NO = b.P_BUDG_CODE_NO  \n";
			strSql += " 			Start With \n";
			strSql += " 			b.P_BUDG_CODE_NO Not In  \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					x.BUDG_CODE_NO \n";
			strSql += " 				From	T_BUDG_CODE x \n";
			strSql += " 				Where	x.COMP_CODE =  ?  \n";
			strSql += " 			) \n";
			strSql += " 	Order Siblings By  \n";
			strSql += " 		b.LEVEL_SEQ \n";
			strSql += " 	) b1 \n";
			strSql += " where a1.budg_code_no = b1.budg_code_no \n";
			strSql += " and	  a1.comp_code =  ?  \n";
			strSql += " and	  a1.clse_acc_id =  ?  \n";
			strSql += " and	  a1.dept_code =  ?  \n";
			strSql += " and	  a1.chg_seq like '%' ||  ?  || '%'  \n";
			strSql += " order by budg_code_no, chg_seq desc, budg_ym ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("5CHG_SEQ", strCHG_SEQ);

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
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCHG_SEQ = CITCommon.toKOR(request.getParameter("CHG_SEQ"));
			String strRESERVED_SEQ = CITCommon.toKOR(request.getParameter("RESERVED_SEQ"));
			String strBUDG_CODE_NO = CITCommon.toKOR(request.getParameter("BUDG_CODE_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CLSE_ACC_ID , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.BUDG_CODE_NO , \n";
			strSql += " 	a.RESERVED_SEQ , \n";
			strSql += " 	To_Char(a.BUDG_YM,'YYYY-MM') BUDG_YM, \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.BUDG_MONTH_REQ_AMT , \n";
			strSql += " 	a.BUDG_MONTH_ASSIGN_AMT  \n";
			strSql += " From	T_BUDG_MONTH_AMT a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And	a.CLSE_ACC_ID =  ?  \n";
			strSql += " And	a.DEPT_CODE =  ?  \n";
			strSql += " And	a.BUDG_CODE_NO =  ?  \n";
			strSql += " And	a.RESERVED_SEQ =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.BUDG_YM \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
			lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);

			lrArgData.setValue("BUDG_CODE_NO", strBUDG_CODE_NO);
			lrArgData.setValue("RESERVED_SEQ", strRESERVED_SEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("BUDG_CODE_NO", true);
				lrReturnData.setKey("RESERVED_SEQ", true);
				lrReturnData.setKey("BUDG_YM", true);
				
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
		if (strAct.equals("CHG_SEQ"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql   = " select chg_seq chg_seq1, to_char(chg_seq) chg_seq, chg_seq || '차' chg_seq_name \n";
			strSql += " from t_budg_dept_h \n";
			strSql += " where comp_code =  ?  \n";
			strSql += " and	  clse_acc_id =  ?  \n";
			strSql += " and	  dept_code =  ?  \n";
			strSql += " and   chg_seq <>0 \n";
			strSql += " and   confirm_tag ='T' \n";
			strSql += " union \n";
			strSql += " select 100000000000, '%' chg_seq, '전체' chg_seq_name \n";
			strSql += " from dual \n";
			strSql += " order by 1 desc ";
			
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
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
				GauceInfo.response.writeException("USER", "900001","CHG_SEQ Select 오류-> "+ ex.getMessage());
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