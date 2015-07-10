<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-18)
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
		if (strAct.equals("MASTER"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strCHG_SEQ = CITCommon.toKOR(request.getParameter("CHG_SEQ"));
			String strMAKE_DEPT = CITCommon.toKOR(request.getParameter("MAKE_DEPT"));
			
			strSql  = "  select a.COMP_CODE ,  \n";
			strSql += " 	 	a.CLSE_ACC_ID ,  \n";
			strSql += " 	 	a.DEPT_CODE ,  \n";
			strSql += " 	 	a.CHG_SEQ ,  \n";
			strSql += " 	 	nvl(a.CONFIRM_TAG,'F') CONFIRM_TAG ,  \n";
			strSql += " 	 	a.BUDG_APPLY_YM,  \n";
			strSql += " 	 	a.REQUEST_TAG, \n";
			strSql += " 		a.dept_name, \n";
			strSql += "  		budg_item_req_amt_sum, \n";
			strSql += " 		budg_item_assign_amt_sum \n";
			strSql += "  from \n";
			strSql += "  ( \n";
			strSql += "  Select  \n";
			strSql += " 	 	a.COMP_CODE ,  \n";
			strSql += " 	 	a.CLSE_ACC_ID ,  \n";
			strSql += " 	 	a.DEPT_CODE ,  \n";
			strSql += " 	 	a.CHG_SEQ ,  \n";
			strSql += " 	 	nvl(a.CONFIRM_TAG,'F') CONFIRM_TAG ,  \n";
			strSql += " 	 	a.BUDG_APPLY_YM,  \n";
			strSql += " 	 	a.REQUEST_TAG,  \n";
			strSql += " 	 	b.DEPT_NAME  \n";
			strSql += " 	 From	T_BUDG_DEPT_H a,  \n";
			strSql += " 	 		T_DEPT_CODE_ORG b  \n";
			strSql += " 	 Where	a.DEPT_CODE = b.DEPT_CODE  \n";
			strSql += " 	 and		a.comp_code = ? \n";
			strSql += " 	 and   	a.clse_acc_id = ?\n";
			strSql += " 	 and   	a.chg_seq = ?) a, \n";
			strSql += " ( \n";
			strSql += "  select		a.comp_code, \n";
			strSql += " 	 		a.clse_acc_id, \n";
			strSql += " 			a.dept_code, \n";
			strSql += " 			a.chg_seq,		 \n";
			strSql += " 			sum(budg_item_req_amt) budg_item_req_amt_sum,  \n";
			strSql += " 			sum(budg_item_assign_amt) budg_item_assign_amt_sum			  \n";
			strSql += " 	 from  t_budg_dept_item_h a, \n";
			strSql += " 	        (select *  \n";
			strSql += " 	         from  t_budg_code  \n";
			strSql += " 	         where comp_code = ? \n";
			strSql += " 	         and     make_dept = ? ) b\n";
			strSql += " 	 where a.budg_code_no     = b.budg_code_no \n";
			strSql += " 	 and   a.comp_code     = ? \n";
			strSql += " 	 and   a.clse_acc_id   = ? \n";
			strSql += " 	 and   a.chg_seq 	   = ? \n";
			//strSql += " 	 and   a.dept_code 	   = ? \n";
			strSql += " 	 and   a.reserved_seq  = 1 \n";
			strSql += " 	 group by a.comp_code, \n";
			strSql += " 	 	   	  a.clse_acc_id, \n";
			strSql += " 	 	   	  a.dept_code, \n";
			strSql += " 			  a.chg_seq \n";
			strSql += " 	) b, \n";
			strSql += " 	t_dept_code_org c \n";
			strSql += " Where  	   a.comp_code    = b.comp_code(+) \n";
			strSql += " and	   a.clse_acc_id  = b.clse_acc_id(+) \n";
			strSql += " and	   a.dept_code	  = b.dept_code(+) \n";
			strSql += " and	   a.chg_seq	  = b.chg_seq(+) \n";
			strSql += " and	   a.dept_code	  = c.dept_code \n";
			strSql += " and          c. budg_cls='T' \n";
			strSql += " order by a.dept_code \n";
			strSql += " 	 \n";
			
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID1", CITData.VARCHAR2);
			lrArgData.addColumn("CHG_SEQ1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DEPT", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE3", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addColumn("CHG_SEQ2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID1", strCLSE_ACC_ID);
			lrArgData.setValue("CHG_SEQ1", strCHG_SEQ);
			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("MAKE_DEPT", strMAKE_DEPT);
			lrArgData.setValue("COMP_CODE3", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID2", strCLSE_ACC_ID);
			lrArgData.setValue("CHG_SEQ2", strCHG_SEQ);
				
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("CLSE_ACC_ID", true);
				lrReturnData.setKey("DEPT_CODE", true);
				lrReturnData.setKey("CHG_SEQ", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MASTER Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCHG_SEQ = CITCommon.toKOR(request.getParameter("CHG_SEQ"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CLSE_ACC_ID , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.CHG_SEQ , \n";
			strSql += " 	a.BUDG_CODE_NO , \n";
			strSql += " 	a.RESERVED_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.TARGET_DEPT_CODE , \n";
			strSql += " 	a.BUDG_ADD_AMT , \n";
			strSql += " 	a.BUDG_ITEM_REQ_AMT , \n";
			strSql += " 	a.BUDG_ITEM_ASSIGN_AMT , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	b.BUDG_ITEM_CODE, \n";
			strSql += " 	b.BUDG_CODE_NAME, \n";
			strSql += " 	b.FULL_PATH, \n";
			strSql += " 	c.item_no \n";
			strSql += " From	T_BUDG_DEPT_ITEM_H a, \n";
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
			strSql += " 				b.BUDG_ITEM_CODE, \n";
			strSql += " 				Decode(nvl(b.MAKE_DEPT,1), '1', 'F','T')  MAKE_DEPT_CLS,  \n";
			strSql += " 				RowNum Rn \n";
			strSql += " 			from	T_BUDG_CODE b \n";
			strSql += " 	              where comp_code = ? \n";
			strSql += " 			Connect By \n";
			strSql += " 					Prior b.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
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
			strSql += " 		)b, \n";
			strSql += "    		( select comp_code, \n";
			strSql += "    			    clse_acc_id, \n";
			strSql += "    			    budg_code_no,\n";
			strSql += "    			    count(item_no)  item_no \n";
			strSql += "    		  from  t_budg_item_cost \n";
			strSql += "    		  group by comp_code, \n";
			strSql += "    				 clse_acc_id, \n";
			strSql += "    				 budg_code_no) c \n";
			strSql += " Where	a.COMP_CODE =  c.COMP_CODE(+)  \n";
			strSql += " And	a.CLSE_ACC_ID =  c.CLSE_ACC_ID(+)  \n";
			strSql += " And	a.BUDG_CODE_NO = c.BUDG_CODE_NO(+) \n";
			strSql += " And	a.BUDG_CODE_NO = b.BUDG_CODE_NO(+) \n";
			strSql += " and	b.MAKE_DEPT_CLS ='T' \n";
			strSql += " And	a.COMP_CODE =  ?  \n";
			strSql += " And	a.CLSE_ACC_ID =  ?  \n";
			strSql += " And	a.DEPT_CODE =  ?  \n";
			strSql += " And	a.CHG_SEQ =  ?  \n";
			strSql += " And	a.RESERVED_SEQ =  1  \n";
			strSql += " Order By \n";
			strSql += " 	b.Rn \n";
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
			strSql += " 	a.CHG_SEQ , \n";
			strSql += " 	a.BUDG_CODE_NO , \n";
			strSql += " 	a.RESERVED_SEQ , \n";
			strSql += " 	To_Char(a.BUDG_YM,'YYYY-MM') BUDG_YM, \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.BUDG_MONTH_REQ_AMT , \n";
			strSql += " 	a.BUDG_MONTH_ASSIGN_AMT , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	b.item_no \n";
			strSql += " From	T_BUDG_MONTH_AMT_H a, \n";
			strSql += "    		( select comp_code, \n";
			strSql += "    			    clse_acc_id, \n";
			strSql += "    			    budg_code_no,\n";
			strSql += "    			    count(item_no)  item_no \n";
			strSql += "    		  from  t_budg_item_cost \n";
			strSql += "    		  group by comp_code, \n";
			strSql += "    				 clse_acc_id, \n";
			strSql += "    				 budg_code_no) b \n";
			strSql += " Where	a.COMP_CODE =  b.COMP_CODE(+)  \n";
			strSql += " And	a.CLSE_ACC_ID =  b.CLSE_ACC_ID(+)  \n";
			strSql += " And	a.BUDG_CODE_NO = b.BUDG_CODE_NO(+) \n";
			strSql += " And	a.COMP_CODE =  ?  \n";
			strSql += " And	a.CLSE_ACC_ID =  ?  \n";
			strSql += " And	a.DEPT_CODE =  ?  \n";
			strSql += " And	a.CHG_SEQ =  ?  \n";
			strSql += " And	a.BUDG_CODE_NO =  ?  \n";
			strSql += " And	a.RESERVED_SEQ =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.BUDG_YM \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CHG_SEQ", CITData.NUMBER);
			lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
			lrArgData.addColumn("RESERVED_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("CHG_SEQ", strCHG_SEQ);
			lrArgData.setValue("BUDG_CODE_NO", strBUDG_CODE_NO);
			lrArgData.setValue("RESERVED_SEQ", strRESERVED_SEQ);
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
		else if (strAct.equals("COPY"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 'XXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE from dual \n";
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
		else if (strAct.equals("DVD_MONTHS"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID ,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE , 0 CHG_SEQ from dual \n";
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
		else if (strAct.equals("CONFIRM"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID ,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE , 0 CHG_SEQ,'X' CONFIRM_TAG from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","CONFIRM Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CONFIRM_ALL"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 0 CHG_SEQ,'X' CONFIRM_TAG from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","CONFIRM_ALL Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DEPT_ALL"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXXXXXX' CLSE_ACC_ID , 0 CHG_SEQ from dual \n";
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
		else if (strAct.equals("BUDG_ITEM_ALL"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXX' CLSE_ACC_ID , 0 CHG_SEQ, 'XXXXXXXXXX' DEPT_CODE, 'XXXXXXXXXX' MAKE_DEPT from dual \n";
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
		else if (strAct.equals("ITEM_COST"))
		{
			
		
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE, 'XXXXXX' CLSE_ACC_ID , 0 CHG_SEQ, 'XXXXXXXXXX' DEPT_CODE from dual \n";
			
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
		else if (strAct.equals("DEPT_COPY"))
		{
			
			strSql  = " Select 'XXXXXXXXXX' COMP_CODE from dual \n";
			
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