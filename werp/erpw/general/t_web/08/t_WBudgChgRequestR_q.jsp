<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원  작성(2005-12-20)
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
			
			strSql  = " select a.comp_code,  \n";
			strSql += " 	   a.clse_acc_id,  \n";
			strSql += " 	   a.dept_code,  \n";
			strSql += " 	   b.dept_name,  \n";
			strSql += " 	   a.chg_seq,  \n";
			strSql += " 	   a.confirm_tag,  \n";
			strSql += " 	   to_char(a.budg_apply_ym, 'YYYY-MM') budg_apply_ym,  \n";
			strSql += " 	   to_char(a.budg_apply_ym, 'YYYY-MM-DD') budg_apply_ym2,  \n";
			strSql += " 	   nvl(a.request_tag,'F') request_tag, \n";
			strSql += " 	   decode((select dept_code \n";
			strSql += " 	    from t_budg_all_change_dept b \n";
			strSql += " 		where b.comp_code = a.comp_code \n";
			strSql += " 		and	  b.clse_acc_id = a.clse_acc_id \n";
			strSql += " 		and	  b.dept_code = a.dept_code \n";
			strSql += " 		and	  b.chg_seq = a.chg_seq), null, 'P', 'A') div, \n";
			strSql += " 		decode((select dept_code \n";
			strSql += " 	    from t_budg_all_change_dept b \n";
			strSql += " 		where b.comp_code = a.comp_code \n";
			strSql += " 		and	  b.clse_acc_id = a.clse_acc_id \n";
			strSql += " 		and	  b.dept_code = a.dept_code \n";
			strSql += " 		and	  b.chg_seq = a.chg_seq), null, '개별', '일괄변경분') div_name \n";
			strSql += " from     t_budg_dept_h a,	     \n";
			strSql += " 	      t_dept_code_org b \n";
			strSql += " where  a.chg_seq > 0  \n";
			strSql += " and      a.dept_code=b.dept_code \n";
			strSql += " and      a.comp_code= ? \n";
			strSql += " and      a.clse_acc_id= ? \n";
			strSql += " and      a.dept_code like '%' || ? || '%' \n";
			strSql += " order   by a.dept_code, chg_seq \n";

			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				

				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("CLSE_ACC_ID", true);
				lrReturnData.setNotNull("DEPT_CODE", true);
				lrReturnData.setNotNull("CHG_SEQ", true);
				lrReturnData.setNotNull("BUDG_CODE_NO", true);
				lrReturnData.setNotNull("RESERVED_SEQ", true);
				
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
			
			strSql  = " select a.comp_code, \n";
			strSql += " 	   a.clse_acc_id, \n";
			strSql += " 	   a.dept_code, \n";
			strSql += " 	   a.chg_seq, \n";
			strSql += " 	   a.budg_code_no, \n";
			strSql += " 	   a.reserved_seq, \n";
			strSql += " 	   a.seq, \n";
			strSql += " 	   to_char(a.budg_ym,'YYYY-MM') budg_ym, \n";
			strSql += " 	   a.reason_code, \n";
			strSql += " 	   a.budg_month_req_amt, \n";
			strSql += " 	   a.chg_amt, \n";
			strSql += " 	   a.confirm_kind, \n";
			strSql += " 	   a.budg_month_assign_amt, \n";
			strSql += " 	   b.budg_code_name, \n";
			strSql += " 	   '' tag, \n";
			strSql += " 	   b.full_path, \n";
			strSql += " 	   d.CODE_NAME as CONFIRM_KIND_NAME \n";
			strSql += " from   t_budg_month_req a, ";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				b.BUDG_CODE_NO , \n";
			strSql += " 				b.P_BUDG_CODE_NO , \n";
			strSql += " 				b.LEVEL_SEQ , \n";
			strSql += " 				b.LEGACY_BUDG_CODE , \n";
			strSql += " 				b.BUDG_CODE_NAME , \n";
			strSql += " 				Replace(Sys_Connect_By_Path(Replace(b.BUDG_CODE_NAME,'/','@#$%'),'/'),'@#$%','/') FULL_PATH, \n";
			strSql += " 				b.ACC_CODE , \n";
			strSql += " 				b.USE_CLS , \n";
			strSql += " 				b.CONTROL_LEVEL_TAG , \n";
			strSql += " 				b.BUDG_ITEM_CODE, 	  \n";
			strSql += " 				b.MAKE_DEPT, 		  \n";
			strSql += " 				RowNum Rn \n";
			strSql += " 			from	(select * from T_BUDG_CODE where comp_code = ? ) b \n";
			strSql += " 			Connect By \n";
			strSql += " 				Prior	b.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 			Start With \n";
			strSql += " 			b.P_BUDG_CODE_NO Not In  \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					x.BUDG_CODE_NO \n";
			strSql += " 				From	T_BUDG_CODE x \n";
			strSql += " 				Where	x.COMP_CODE =  ?  \n";
			strSql += " 			) \n";
			strSql += " 			Order Siblings By \n";
			strSql += " 				b.LEVEL_SEQ \n";
			strSql += " 		) b, \n";
			strSql += "            T_ACC_CODE c, \n";
			strSql += "	    (Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS CODE_NAME \n";
			strSql += "		From	V_T_CODE_LIST a \n";
			strSql += "		Where	a.CODE_GROUP_ID = 'CONFIRM_KIND' \n";
			strSql += "		And	a.USE_TAG = 'T' \n";
			strSql += "		Order by	a.SEQ) d \n";
			strSql += " Where	a.BUDG_CODE_NO = b.BUDG_CODE_NO(+) \n";
			strSql += " And	a.CONFIRM_KIND = d.CODE(+) \n";
			strSql += " And	b.ACC_CODE = c.ACC_CODE(+) \n";
			strSql += " And	a.COMP_CODE =  ?  \n";
			strSql += " And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " And		a.DEPT_CODE =  ?  \n";
			strSql += " And		a.CHG_SEQ =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.BUDG_YM \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("CHG_SEQ", strCHG_SEQ);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("CHG_SEQ", true);
				lrReturnData.setKey("BUDG_CODE_NO", true);
				lrReturnData.setKey("RESERVED_SEQ", true);
				lrReturnData.setKey("BUDG_YM", true);
				lrReturnData.setKey("SEQ", true);
				lrReturnData.setNotNull("REASON_CODE", true);

				
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
		else if (strAct.equals("SUB02"))
		{

			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCHG_SEQ = CITCommon.toKOR(request.getParameter("CHG_SEQ"));
			String strRESERVED_SEQ = CITCommon.toKOR(request.getParameter("RESERVED_SEQ"));
			String strBUDG_CODE_NO = CITCommon.toKOR(request.getParameter("BUDG_CODE_NO"));
			String strBUDG_YM = CITCommon.toKOR(request.getParameter("BUDG_YM"));
			String strSEQ = CITCommon.toKOR(request.getParameter("SEQ"));
		
			strSql  = " select 	a.COMP_CODE, \n";
			strSql += " 		a.CLSE_ACC_ID, \n";
			strSql += " 		a.DEPT_CODE, \n";
			strSql += " 		a.CHG_SEQ, \n";
			strSql += " 		a.BUDG_CODE_NO, \n";
			strSql += " 		a.RESERVED_SEQ, \n";
			strSql += " 	   	a.seq, \n";
			strSql += " 		to_char(a.BUDG_YM,'YYYY-MM') BUDG_YM , \n";
			strSql += " 		a.REASON_NO, \n";
			strSql += " 		a.CHG_AMT, \n";
			strSql += " 	(select BUDG_MONTH_REQ_AMT   \n";
			strSql += " 	 from t_budg_month_amt_h b  \n";
			strSql += " 	 where b.COMP_CODE =  ?  \n";
			strSql += " 	 and b.CLSE_ACC_ID =  ?  \n";
			strSql += " 	 and b.DEPT_CODE =  ?  \n";
			strSql += " 	 and b.BUDG_CODE_NO =  ?  \n";
			strSql += " 	 and b.reserved_seq= ?  \n";
			strSql += " 	 and b.BUDG_YM =  a.R_BUDG_YM  \n";
			strSql += " 	 and b.CHG_SEQ= \n";
			strSql += " 	 ( \n";
			strSql += " 	 	select max(x.chg_seq) \n";
			strSql += " 		from	t_budg_month_amt_h x \n";
			strSql += " 		where	b.COMP_CODE = x.COMP_CODE \n";
			strSql += " 		and		b.CLSE_ACC_ID = x.CLSE_ACC_ID \n";
			strSql += " 		and		b.DEPT_CODE = x.DEPT_CODE \n";
			strSql += " 		and		b.BUDG_CODE_NO = x.BUDG_CODE_NO \n";
			strSql += " 		and		b.BUDG_YM = x.BUDG_YM \n";
			strSql += " 		and		x.CHG_SEQ <  ?  \n";
			strSql += " 	 ) \n";
			strSql += " ) as BUDG_MONTH_REQ_AMT, \n";
			strSql += " 	(select BUDG_MONTH_ASSIGN_AMT   \n";
			strSql += " 	 from t_budg_month_amt_h b  \n";
			strSql += " 	 where b.COMP_CODE =  ?  \n";
			strSql += " 	 and b.CLSE_ACC_ID =  ?  \n";
			strSql += " 	 and b.DEPT_CODE =  ?  \n";
			strSql += " 	 and b.CHG_SEQ= ?  \n";
			strSql += " 	 and b.BUDG_CODE_NO =  ?  \n";
			strSql += " 	 and b.reserved_seq= ?  \n";
			strSql += " 	 and  b.BUDG_YM =  a.R_BUDG_YM  \n";
			strSql += " ) as BUDG_MONTH_ASSIGN_AMT, \n";
			strSql += " 		a.R_COMP_CODE, \n";
			strSql += " 		a.R_CLSE_ACC_ID, \n";
			strSql += " 		a.R_DEPT_CODE, \n";
			strSql += " 		To_Char(a.R_CHG_SEQ) R_CHG_SEQ, \n";
			strSql += " 		To_Char(a.R_BUDG_CODE_NO) R_BUDG_CODE_NO, \n";
			strSql += " 		To_Char(a.R_RESERVED_SEQ) R_RESERVED_SEQ, \n";
			strSql += " 		to_char(a.R_BUDG_YM,'YYYY-MM') R_BUDG_YM, \n";
			strSql += " 		a.REMARKS, \n";
			strSql += " 		'' tag \n";
			strSql += " from t_budg_month_req_detail a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And	a.CLSE_ACC_ID =  ?  \n";
			strSql += " And	a.DEPT_CODE =  ?  \n";
			strSql += " And	a.CHG_SEQ =  ?  \n";
			strSql += " And	a.BUDG_CODE_NO =  ?  \n";
			strSql += " And	a.RESERVED_SEQ =  ?  \n";
			strSql += " And	a.SEQ =  ?  \n";
			strSql += " And	a.BUDG_YM = To_Date( ? , 'YYYY-MM') \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4BUDG_CODE_NO", CITData.VARCHAR2);
			lrArgData.addColumn("5RESERVED_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("6CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("7COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("9DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("10CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("11BUDG_CODE_NO", CITData.VARCHAR2);
			lrArgData.addColumn("12RESERVED_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("13COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("15DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("16CHG_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("17BUDG_CODE_NO", CITData.VARCHAR2);
			lrArgData.addColumn("18RESERVED_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("19SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("20BUDG_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("4BUDG_CODE_NO", strBUDG_CODE_NO);
			lrArgData.setValue("5RESERVED_SEQ", strRESERVED_SEQ);
			lrArgData.setValue("6CHG_SEQ", strCHG_SEQ);
			lrArgData.setValue("7COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("9DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("10CHG_SEQ", strCHG_SEQ);
			lrArgData.setValue("11BUDG_CODE_NO", strBUDG_CODE_NO);
			lrArgData.setValue("12RESERVED_SEQ", strRESERVED_SEQ);
			lrArgData.setValue("13COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("15DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("16CHG_SEQ", strCHG_SEQ);
			lrArgData.setValue("17BUDG_CODE_NO", strBUDG_CODE_NO);
			lrArgData.setValue("18RESERVED_SEQ", strRESERVED_SEQ);
			lrArgData.setValue("19SEQ", strSEQ);
			lrArgData.setValue("20BUDG_YM", strBUDG_YM);
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("CHG_SEQ", true);
				lrReturnData.setKey("BUDG_CODE_NO", true);
				lrReturnData.setKey("RESERVED_SEQ", true);
				lrReturnData.setKey("BUDG_YM", true);
				lrReturnData.setKey("SEQ", true);
				lrReturnData.setKey("REASON_NO", true);
				
				lrReturnData.setNotNull("REASON_CODE", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB02 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CHG_SEQ"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  =  " select    nvl((max(chg_seq) + 1), '-1')  as chg_seq \n";
			strSql += " from t_budg_dept_h a \n";
			strSql += " where comp_code = ? \n";
			strSql += " and    clse_acc_id = ? \n";
			strSql += " and    dept_code = ? \n";
			strSql += " and a.CONFIRM_TAG ='T' \n";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);

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
		else if (strAct.equals("BUDG_ITEM"))
		{
			String strBUDG_CODE_NO = CITCommon.toKOR(request.getParameter("BUDG_CODE_NO"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCHG_SEQ = CITCommon.toKOR(request.getParameter("CHG_SEQ"));
			
			strSql  = " Select \n";
			strSql += " 	b.BUDG_CODE_NO , \n";
			strSql += " 	b.P_BUDG_CODE_NO , \n";
			strSql += " 	b.LEVEL_SEQ , \n";
			strSql += " 	b.LEGACY_BUDG_CODE , \n";
			strSql += " 	b.BUDG_ITEM_CODE, \n";
			strSql += " 	b.BUDG_CODE_NAME , \n";
			strSql += " 	b.LEVELED_BUDG_CODE_NAME, \n";
			strSql += " 	b.FULL_PATH, \n";
			strSql += " 	b.ACC_CODE , \n";
			strSql += " 	b.USE_CLS , \n";
			strSql += " 	b.CONTROL_LEVEL_TAG , \n";
			strSql += " 	b.Rn, \n";
			strSql += " 	b.IS_LEAF \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.BUDG_CODE_NO , \n";
			strSql += " 			b.P_BUDG_CODE_NO , \n";
			strSql += " 			b.LEVEL_SEQ , \n";
			strSql += " 			b.LEGACY_BUDG_CODE , \n";
			strSql += " 			b.BUDG_ITEM_CODE, \n";
			strSql += " 			b.BUDG_CODE_NAME , \n";
			strSql += " 			b.LEVELED_BUDG_CODE_NAME, \n";
			strSql += " 			b.FULL_PATH, \n";
			strSql += " 			b.ACC_CODE , \n";
			strSql += " 			b.USE_CLS , \n";
			strSql += " 			b.CONTROL_LEVEL_TAG , \n";
			strSql += " 			b.Rn, \n";
			strSql += " 			Decode(b.BUDG_CODE_NO,lead(b.P_BUDG_CODE_NO) Over ( Order By b.rn) ,'F','T') IS_LEAF \n";
			strSql += " 		From \n";
			strSql += " 			(	 \n";
			strSql += " 				Select \n";
			strSql += " 					b.BUDG_CODE_NO , \n";
			strSql += " 					b.P_BUDG_CODE_NO , \n";
			strSql += " 					b.LEVEL_SEQ , \n";
			strSql += " 					b.LEGACY_BUDG_CODE , \n";
			strSql += " 					b.BUDG_CODE_NAME , \n";
			strSql += " 					RPad(' ',level * 2 - 2) || b.BUDG_CODE_NAME LEVELED_BUDG_CODE_NAME, \n";
			strSql += " 					Replace(Sys_Connect_By_Path(Replace(b.BUDG_CODE_NAME,'/','@#$%'),'/'),'@#$%','/') FULL_PATH, \n";
			strSql += " 					b.ACC_CODE , \n";
			strSql += " 					b.USE_CLS , \n";
			strSql += " 					b.CONTROL_LEVEL_TAG , \n";
			strSql += " 					b.BUDG_ITEM_CODE, \n";
			strSql += " 					RowNum Rn, \n";
			strSql += " 					Level lv \n";
			strSql += " 				from	T_BUDG_CODE b \n";
			strSql += " 				Connect By \n";
			strSql += " 					Prior	b.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 				Start With	b.BUDG_CODE_NO =  ?  \n";
			strSql += " 				Order Siblings By \n";
			strSql += " 					b.LEVEL_SEQ \n";
			strSql += " 			) b \n";
			strSql += " 		Where	b.USE_CLS = 'T' \n";
			strSql += " 		Order By \n";
			strSql += " 			b.rn \n";
			strSql += " 	) b \n";
			strSql += " Where	b.IS_LEAF = 'T' \n";
			strSql += " And		Not Exists ( \n";
			strSql += " Select Null From T_BUDG_DEPT_ITEM_H a \n";
			strSql += " Where	a.COMP_CODE = ? \n";
			strSql += " And		a.CLSE_ACC_ID = ? \n";
			strSql += " And		a.DEPT_CODE = ? \n";
			strSql += " And		a.CHG_SEQ = ? \n";
			strSql += " And		a.BUDG_CODE_NO = b.BUDG_CODE_NO \n";
			strSql += " ) \n";
			strSql += "  ";
			
			lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("CHG_SEQ", strCHG_SEQ);
			lrArgData.setValue("BUDG_CODE_NO", strBUDG_CODE_NO);
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
				GauceInfo.response.writeException("USER", "900001","BUDG_ITEM Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SEQ"))
		{
			
			strSql  = " Select SQ_T_BUDG_MONTH_REQ.nextval SEQ from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CHANGE_CANCEL"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 'XXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE , 0 CHG_SEQ  from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REQUEST_FINISH"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 'XXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE , 0 CHG_SEQ,'XXXXXXXXXXXXXXXXXXXXXX' REQUEST_TAG  from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REQUEST_FINISH_CANCEL"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 'XXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE , 0 CHG_SEQ,'XXXXXXXXXXXXXXXXXXXXXX' REQUEST_TAG  from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		//사유순번
		else if (strAct.equals("REASON_NO"))
		{
			
			strSql  = " Select SQ_T_BUDG_CHG_REASON.nextval  as REASON_NO from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","DVD_MONTHS Select 오류-> "+ ex.getMessage());
			}
		}
		//확정
		else if (strAct.equals("CONFIRM"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 'XXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE , 0 CHG_SEQ,'XXXXXXXXXXXXXXXXXXXXXX' CONFIRM_TAG  from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("OLD_BUDG"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strBUDG_CODE_NO = CITCommon.toKOR(request.getParameter("BUDG_CODE_NO"));
			String strBUDG_YM = CITCommon.toKOR(request.getParameter("BUDG_YM"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CLSE_ACC_ID , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CHG_SEQ , \n";
			strSql += " 	a.BUDG_CODE_NO , \n";
			strSql += " 	a.RESERVED_SEQ , \n";
			strSql += " 	a.BUDG_YM , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.BUDG_MONTH_REQ_AMT , \n";
			strSql += " 	a.BUDG_MONTH_ASSIGN_AMT , \n";
			strSql += " 	a.REMARKS , \n";
			strSql += " 	a.BUDG_MONTH_REQ_AMT_A \n";
			strSql += " From	T_BUDG_MONTH_AMT_H a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " And		a.DEPT_CODE =  ?  \n";
			strSql += " And		a.BUDG_CODE_NO =  ?  \n";
			strSql += " And		a.BUDG_YM =  f_t_stringtodate(?)  \n";
			strSql += " And		a.CHG_SEQ =  \n";
			strSql += " ( \n";
			strSql += " 	Select \n";
			strSql += " 		Max(b.CHG_SEQ) \n";
			strSql += " 	From	T_BUDG_DEPT_H b, \n";
			strSql += " 			T_BUDG_MONTH_AMT_H c \n";
			strSql += " 	Where	b.COMP_CODE = c.COMP_CODE \n";
			strSql += " 	And		b.CLSE_ACC_ID = c.CLSE_ACC_ID \n";
			strSql += " 	And		b.DEPT_CODE = c.DEPT_CODE \n";
			strSql += " 	And		b.CHG_SEQ = c.CHG_SEQ \n";
			strSql += " 	And		a.COMP_CODE = c.COMP_CODE \n";
			strSql += " 	And		a.CLSE_ACC_ID = c.CLSE_ACC_ID \n";
			strSql += " 	And		a.DEPT_CODE = c.DEPT_CODE \n";
			strSql += " 	And		a.BUDG_CODE_NO = c.BUDG_CODE_NO \n";
			strSql += " 	And		a.BUDG_YM = c.BUDG_YM \n";
			strSql += " 	And		b.CONFIRM_TAG = 'T' \n";
			strSql += " ) \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4BUDG_CODE_NO", CITData.NUMBER);
			lrArgData.addColumn("5BUDG_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("4BUDG_CODE_NO", strBUDG_CODE_NO);
			lrArgData.setValue("5BUDG_YM", strBUDG_YM);
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
				GauceInfo.response.writeException("USER", "900001","OLD_BUDG Select 오류-> "+ ex.getMessage());
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