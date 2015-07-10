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
	String	strUserNo = "";
	String      ssCompCode = "";
	String      ssDeptCode = "";
	String      ssDeptName = "";
	String     ssPrivLevel ="";
	String     ssDeptShortName ="";
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		ssCompCode = CITCommon.toKOR((String)session.getAttribute("comp_code"));
		ssDeptCode = CITCommon.toKOR((String)session.getAttribute("dept_code"));
		ssDeptName = CITCommon.toKOR((String)session.getAttribute("long_name"));

		CITData lrArgData = new CITData();

		strAct = CITCommon.toKOR(request.getParameter("ACT"));

		if (strAct.equals("MAIN"))
		{
			strSql   = "Select \n";
			strSql  += "	A.COMP_CODE , \n";
			strSql  += "	A.COMPANY_NAME , \n";
			strSql  += "	F_T_CUST_MASK(A.BIZNO) BIZNO, \n";
			strSql  += "	A.DEPT_CODE , \n";
			strSql  += "     B.DEPT_NAME \n";
			strSql  += "     From	T_COMPANY A ,\n";
			strSql  += "	T_DEPT_CODE B \n";
			strSql  += "Where	A.DEPT_CODE = B.DEPT_CODE(+) \n";
			strSql  += "And		A.COMP_CODE In \n";
			strSql  += "(  \n";
			strSql  += "					Select \n";
			strSql  += "							b.COMP_CODE \n";
			strSql  += "					From	T_EMPNO_AUTH_COMP b \n";
			strSql  += "					Where	b.EMPNO = ? \n";
			strSql  += ") \n";
			strSql  += "Order by	A.COMP_CODE \n";

			lrArgData.addColumn("EMPNO",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMPNO",strUserNo);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("COMPANY_CODE",true);

				lrReturnData.setColumnDisplaySize("COMPANY_NAME", 100);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("LIST00_1"))
		{

			strSql  = "SELECT \n";
			strSql  += "    "+strUserNo+" USER_NO, \n";
			strSql  += "    '"+ssCompCode+"' COMPANY_CODE, \n";
			strSql  += "    '"+ssDeptCode+"' DEPT_CODE, \n";
			strSql  += "    '"+ssDeptName+"' DEPT_NAME \n";
			strSql  += "FROM \n";
			strSql  += "    DUAL \n";
			strSql  += "UNION ALL \n";
			strSql  += "SELECT \n";
			strSql  += "    a.USER_NO, \n";
			strSql  += "    b.COMPANY_CODE, \n";
			strSql  += "    a.DEPT_CODE, \n";
			strSql  += "    b.DEPT_NAME \n";
			strSql  += "FROM \n";
			strSql  += "    TIA_BAMS_DEPT_CODE a, \n";
			strSql  += "    TIA_DEPT_CODE b \n";
			strSql  += "WHERE \n";
			strSql  += "    a.USER_NO =  ?  \n";
			strSql  += "    AND a.DEPT_CODE = b.DEPT_CODE";

			lrArgData.addColumn("USER_NO",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("USER_NO",strUserNo);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","MAIN01 Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:MAIN01 Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("LIST00"))
		{
			String vCompCode = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String vBudgYyyy = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));

				strSql  = "select '"+vCompCode+"' COMP_CODE, '%' DEPT_CODE, '전  체' DEPT_NAME, '전  체' DEPT_SHORT_NAME \n";
				strSql += "from dual a \n";
				strSql += "union all \n";
				strSql += "select a.COMP_CODE, a.DEPT_CODE, a.DEPT_NAME, a.DEPT_SHORT_NAME \n";
				strSql += "from T_DEPT_CODE a, \n";
				strSql += "	 ( \n";
				strSql += "	  SELECT DEPT_CODE \n";
				strSql += "	  FROM T_BUDG_DEPT \n";
				strSql += "	  group by DEPT_CODE \n";
				strSql += "	 ) b \n";
				strSql  += "WHERE \n";
				strSql  += "     a.COMP_CODE = '"+vCompCode+"' \n";
				strSql += "	  and a.DEPT_CODE = b.DEPT_CODE \n";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("COMP_CODE",true);
				lrReturnData.setKey("DEPT_CODE",true);

				lrReturnData.setColumnDisplaySize("DEPT_NAME", 100);
				lrReturnData.setColumnDisplaySize("DEPT_SHORT_NAME", 200);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}

		else if (strAct.equals("LIST02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strMONTH = CITCommon.toKOR(request.getParameter("MONTH"));
			String strDIV = CITCommon.toKOR(request.getParameter("DIV"));
			
			//strCOMP_CODE ="A0";
			//strCLSE_ACC_ID="2006";
			//strDEPT_CODE="%";
			

			strSql  = " select  a.dept_div, \n";
			strSql += " 		check_dept_code, \n";
			strSql += " 		check_dept_name, \n";
			strSql += " 		dept_code, \n";
			strSql += " 		dept_name, \n";
			strSql += " 		a.p_budg_code_no, \n";
			strSql += " 		a.budg_code_no, \n";
			strSql += " 		a.budg_code_name, \n";
			strSql += " 		a.acc_code, \n";
			strSql += " 		acc_name, \n";
			strSql += " 	      a.budg_amt, \n";
			strSql += " 		a.budg_amt_sum, \n";
			strSql += " 		a.sil_amt_sum, \n";
			strSql += " 	      a.sil_amt, \n";
			strSql += " 	      to_char(decode(a.budg_amt, 0, 0, 100*(a.sil_amt/a.budg_amt)),  '999.99')  r1,   \n";
			strSql += " 	      to_char(decode(a.budg_amt_sum, 0, 0, 100*(a.sil_amt_sum/a.budg_amt_sum)),  '999.99')  	r2   \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 		select  \n";
			strSql += " 			   a.dept_div, \n";
			strSql += " 			   '' check_dept_code, \n";
			strSql += " 			   '' check_dept_name, \n";
			strSql += " 			   '' dept_code, \n";
			strSql += " 			   '' dept_name, \n";
			strSql += " 			   a.p_budg_code_no, \n";
			strSql += " 			   a.budg_code_no, \n";
			strSql += " 			   c.budg_code_name, \n";
			strSql += " 			   a.acc_code, \n";
			strSql += " 			   decode(dept_div, '12', '소계', b.acc_name) acc_name, \n";
			strSql += " 			   a.budg_amt, \n";
			strSql += " 			   a.budg_amt_sum, \n";
			strSql += " 			   a.sil_amt_sum, \n";
			strSql += " 			   a.sil_amt    \n"; 
			
			strSql += " 		from \n";
			strSql += " 			( \n";
			strSql += " 			--전체부서 상위 계정별 집계 \n";
			strSql += " 			select  \n";
			strSql += " 				   a.dept_div, \n";
			strSql += " 				   a.p_budg_code_no, \n";
			strSql += " 				   a.budg_code_no, \n";
			strSql += " 				   a.acc_code, \n";
			strSql += " 				   --b.budg_ym, \n";
			strSql += " 				   b.budg_amt, \n";
			strSql += " 				   a.budg_amt_sum, \n";
			strSql += " 				   nvl(c.sil_amt_sum, 0) sil_amt_sum, \n";
			strSql += " 				   nvl(d.sil_amt, 0) sil_amt     \n";
			strSql += " 			from    \n";
			strSql += " 				 --누적 예산 - 전체부서용 \n";
			strSql += " 				  ( \n";
			strSql += " 				  select a.dept_div, \n";
			strSql += " 						 a.comp_code, \n";
			strSql += " 						 a.clse_acc_id, \n";
			strSql += " 						 a.chg_seq, \n";
			strSql += " 						 a.p_budg_code_no, \n";
			strSql += " 						 a.budg_code_no, \n";
			strSql += " 						 a.acc_code, \n";
			strSql += " 						 a.reserved_seq, \n";
			strSql += " 						 sum(a.budg_amt) budg_amt_sum \n";
			strSql += " 				  from 		 \n";
			strSql += " 				 \n";
			strSql += " 						(select \n";
			strSql += " 						 	   '11' dept_div, \n";
			strSql += " 						 	   a3.comp_code, \n";
			strSql += " 							   a3.clse_acc_id, \n";
			strSql += " 							   a3.chg_seq, \n";
			strSql += " 							   a2.p_budg_code_no, \n";
			strSql += " 							   a1.budg_code_no, \n";
			strSql += " 							   a2.acc_code, \n";
			strSql += " 							   a1.budg_ym, \n";
			strSql += " 							   a3.reserved_seq, \n";
			strSql += " 							   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 						 from  t_budg_month_amt_h a1, \n";
			strSql += " 						 	   t_budg_code a2, \n";
			strSql += " 						 	   t_budg_dept_item_h a3 \n";
			strSql += " 						 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 						 and   a1.comp_code = a3.comp_code \n";
			strSql += " 						 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 						 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 						 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 						 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 						 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 						 and   a3.comp_code = ?  \n"; //1
			strSql += " 						 and   a3.clse_acc_id= ?  \n"; //2
			strSql += " 						 and   a3.chg_seq=0 \n"; 
			strSql += " 						 and   a3.reserved_seq=1  \n";
			strSql += " 						 and   a1.budg_ym between  ?  || '-01-01' and  ?  || '-' ||  ?  || '-01' \n"; //5
			strSql += " 						 group by    \n";
			strSql += " 						 	   a3.comp_code, \n";
			strSql += " 							   a3.clse_acc_id, \n";
			strSql += " 							   a3.chg_seq, \n";
			strSql += " 							   a2.p_budg_code_no, \n";
			strSql += " 							   a1.budg_code_no, \n";
			strSql += " 							   a2.acc_code, \n";
			strSql += " 							   a1.budg_ym, \n";
			strSql += " 							   a3.reserved_seq ) a \n";
			strSql += " 					group by  \n";
			strSql += " 						  a.dept_div, \n";
			strSql += " 						  a.comp_code, \n";
			strSql += " 						  a.clse_acc_id, \n";
			strSql += " 						  a.chg_seq, \n";
			strSql += " 						  a.p_budg_code_no, \n";
			strSql += " 						  a.budg_code_no, \n";
			strSql += " 						  a.acc_code, \n";
			strSql += " 						  a.reserved_seq \n";
			strSql += " 				) a, \n";
			strSql += " 				--당월 예산 - 전체부서용 \n";
			strSql += " 				( select \n";
			strSql += " 				 	   '11' dept_div, \n";
			strSql += " 				 	   a3.comp_code, \n";
			strSql += " 					   a3.clse_acc_id, \n";
			strSql += " 					   a3.chg_seq, \n";
			strSql += " 					   a2.p_budg_code_no, \n";
			strSql += " 					   a1.budg_code_no, \n";
			strSql += " 					   a2.acc_code, \n";
			strSql += " 					   a1.budg_ym, \n";
			strSql += " 					   a3.reserved_seq, \n";
			strSql += " 					   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 				 from  t_budg_month_amt_h a1, \n";
			strSql += " 				 	   t_budg_code a2, \n";
			strSql += " 				 	   t_budg_dept_item_h a3 \n";
			strSql += " 				 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 				 and   a1.comp_code = a3.comp_code \n";
			strSql += " 				 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 				 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 				 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 				 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 				 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 				 and   a3.comp_code = ?  \n";
			strSql += " 				 and   a3.clse_acc_id= ?  \n";
			strSql += " 				 and   a3.chg_seq='0' \n";
			strSql += " 				 and   a3.reserved_seq=1 \n";
			strSql += " 				 and   a1.budg_ym = ?  || '-' ||  ?  || '-01' \n";  //9
			strSql += " 				 group by    \n";
			strSql += " 				 	   a3.comp_code, \n";
			strSql += " 					   a3.clse_acc_id, \n";
			strSql += " 					   a3.chg_seq, \n";
			strSql += " 					   a2.p_budg_code_no, \n";
			strSql += " 					   a1.budg_code_no, \n";
			strSql += " 					   a2.acc_code, \n";
			strSql += " 					   a1.budg_ym, \n";
			strSql += " 					   a3.reserved_seq \n";
			strSql += " 				) b, \n";
			strSql += " 				--누적실적 - 전체부서 \n";
			strSql += " 				( \n";
			strSql += " 				 SELECT	   '11' dept_div, \n";
			strSql += " 							a.ACC_CODE,  \n";
			strSql += " 							sum(SIL_AMT_SUM) SIL_AMT_SUM \n";
			strSql += " 				  \n";
			strSql += " 				 FROM  \n";
			strSql += " 				 	  (		 \n";
			strSql += " 						SELECT '11' dept_div, \n";
			strSql += " 							   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 							   b.ACC_CODE,  \n";
			strSql += " 							   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 						FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 							   T_ACC_SLIP_BODY b,  \n";
			strSql += " 							   T_DEPT_CODE c                                              \n";
			strSql += " 						WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 						AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 						and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( ?  || '-01' ,'-','')  and replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 						and    c.COMP_CODE =  ?                                                                                      \n"; //13
			strSql += " 						and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 						GROUP BY  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 							      b.ACC_CODE  ) a \n";
			strSql += " 				GROUP BY a.ACC_CODE  					   \n";
			strSql += " 				) c, \n";
			strSql += " 			    --당월실적 - 전체부서 \n";
			strSql += " 				( \n";
			strSql += " 				SELECT '11' dept_div, \n";
			strSql += " 					   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 					   b.ACC_CODE,  \n";
			strSql += " 					   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 				FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					   T_ACC_SLIP_BODY b,  \n";
			strSql += " 					   T_DEPT_CODE c                                              \n";
			strSql += " 				WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 				and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 				and    c.COMP_CODE =  ?                                                                                      \n";  //16
			strSql += " 				and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 				GROUP BY  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 					      b.ACC_CODE  ) d			   \n";
			strSql += " 				where a.comp_code = b.comp_code \n";
			strSql += " 				and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 				and	  a.chg_seq = b.chg_seq \n";
			strSql += " 				and	  a.acc_code = b.acc_code \n";
			strSql += " 				and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 				and	  a.acc_code = c.acc_code(+) \n";
			strSql += " 				and	  a.acc_code = d.acc_code(+) \n";
			strSql += " 		 \n";
			strSql += " 			 \n";
			strSql += " 				union \n";
			strSql += " 				 \n";
			strSql += " 				--상위 계정별 sum \n";
			strSql += " 				select a.dept_div, \n";
			strSql += " 						   a.p_budg_code_no, \n";
			strSql += " 						   to_number(a.dept_div || a.p_budg_code_no) budg_code_no, \n";
			strSql += " 						   '' acc_code, \n";
			strSql += " 						   sum(budg_amt), \n";
			strSql += " 						   sum(budg_amt_sum), \n";
			strSql += " 						   sum(sil_amt_sum), \n";
			strSql += " 						   sum(sil_amt) \n";
			strSql += " 				from   \n";
			strSql += " 					--전체부서 상위 계정별 집계 \n";
			strSql += " 				    (select --'상위계정' PARENT_NAME, \n";
			strSql += " 					       --'계정' ACC_NAME \n";
			strSql += " 						   a.dept_div, \n";
			strSql += " 						   a.p_budg_code_no, \n";
			strSql += " 						   a.budg_code_no, \n";
			strSql += " 						   a.acc_code, \n";
			strSql += " 						   b.budg_ym, \n";
			strSql += " 						   b.budg_amt, \n";
			strSql += " 						   a.budg_amt_sum, \n";
			strSql += " 						   nvl(c.sil_amt_sum, 0) sil_amt_sum, \n";
			strSql += " 						   nvl(d.sil_amt, 0) sil_amt     \n";
			strSql += " 					from    \n";
			strSql += " 						 --누적 예산 - 전체부서용 \n";
			strSql += " 						(  \n";
			strSql += " 						  select a.dept_div, \n";
			strSql += " 								 a.comp_code, \n";
			strSql += " 								 a.clse_acc_id, \n";
			strSql += " 								 a.chg_seq, \n";
			strSql += " 								 a.p_budg_code_no, \n";
			strSql += " 								 a.budg_code_no, \n";
			strSql += " 								 a.acc_code, \n";
			strSql += " 								 a.reserved_seq, \n";
			strSql += " 								 sum(a.budg_amt) budg_amt_sum \n";
			strSql += " 						   \n";
			strSql += " 						  from 		 \n";
			strSql += " 						 \n";
			strSql += " 								(select \n";
			strSql += " 								 	   '12' dept_div, \n";
			strSql += " 								 	   a3.comp_code, \n";
			strSql += " 									   a3.clse_acc_id, \n";
			strSql += " 									   a3.chg_seq, \n";
			strSql += " 									   a2.p_budg_code_no, \n";
			strSql += " 									   a1.budg_code_no, \n";
			strSql += " 									   a2.acc_code, \n";
			strSql += " 									   a1.budg_ym, \n";
			strSql += " 									   a3.reserved_seq, \n";
			strSql += " 									   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 								 from  t_budg_month_amt_h a1, \n";
			strSql += " 								 	   t_budg_code a2, \n";
			strSql += " 								 	   t_budg_dept_item_h a3 \n";
			strSql += " 								 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 								 and   a1.comp_code = a3.comp_code \n";
			strSql += " 								 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 								 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 								 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 								 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 								 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 								 and   a3.comp_code = ?  \n";//17
			strSql += " 								 and   a3.clse_acc_id= ?  \n";
			strSql += " 								 and   a3.chg_seq='0' \n";
			strSql += " 								 and   a3.reserved_seq=1 \n";
			strSql += " 								 and   a1.budg_ym between  ?  || '-01-01' and  ?  || '-' ||  ?  || '-01' \n"; //21
			strSql += " 								 group by    \n";
			strSql += " 								 	   a3.comp_code, \n";
			strSql += " 									   a3.clse_acc_id, \n";
			strSql += " 									   a3.chg_seq, \n";
			strSql += " 									   a2.p_budg_code_no, \n";
			strSql += " 									   a1.budg_code_no, \n";
			strSql += " 									   a2.acc_code, \n";
			strSql += " 									   a1.budg_ym, \n";
			strSql += " 									   a3.reserved_seq ) a \n";
			strSql += " 							group by  \n";
			strSql += " 								  a.dept_div, \n";
			strSql += " 								  a.comp_code, \n";
			strSql += " 								  a.clse_acc_id, \n";
			strSql += " 								  a.chg_seq, \n";
			strSql += " 								  a.p_budg_code_no, \n";
			strSql += " 								  a.budg_code_no, \n";
			strSql += " 								  a.acc_code, \n";
			strSql += " 								  a.reserved_seq \n";
			strSql += " 						) a, \n";
			strSql += " 						--당월 예산 - 전체부서용 \n";
			strSql += " 						( select \n";
			strSql += " 						 	   '12' dept_div, \n";
			strSql += " 						 	   a3.comp_code, \n";
			strSql += " 							   a3.clse_acc_id, \n";
			strSql += " 							   a3.chg_seq, \n";
			strSql += " 							   a2.p_budg_code_no, \n";
			strSql += " 							   a1.budg_code_no, \n";
			strSql += " 							   a2.acc_code, \n";
			strSql += " 							   a1.budg_ym, \n";
			strSql += " 							   a3.reserved_seq, \n";
			strSql += " 							   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 						 from  t_budg_month_amt_h a1, \n";
			strSql += " 						 	   t_budg_code a2, \n";
			strSql += " 						 	   t_budg_dept_item_h a3 \n";
			strSql += " 						 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 						 and   a1.comp_code = a3.comp_code \n";
			strSql += " 						 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 						 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 						 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 						 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 						 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 						 and   a3.comp_code = ?  \n";//22
			strSql += " 						 and   a3.clse_acc_id= ?  \n";
			strSql += " 						 and   a3.chg_seq='0' \n";
			strSql += " 						 and   a3.reserved_seq=1 \n";
			strSql += " 						 and   a1.budg_ym = ?  || '-' ||  ?  || '-01' \n"; //25
			strSql += " 						 group by    \n";
			strSql += " 						 	   a3.comp_code, \n";
			strSql += " 							   a3.clse_acc_id, \n";
			strSql += " 							   a3.chg_seq, \n";
			strSql += " 							   a2.p_budg_code_no, \n";
			strSql += " 							   a1.budg_code_no, \n";
			strSql += " 							   a2.acc_code, \n";
			strSql += " 							   a1.budg_ym, \n";
			strSql += " 							   a3.reserved_seq \n";
			strSql += " 						) b, \n";
			strSql += " 						--누적실적 - 전체부서 \n";
			strSql += " 						( \n";
			strSql += " 						 SELECT	   '12' dept_div, \n";
			strSql += " 									a.ACC_CODE,  \n";
			strSql += " 									sum(SIL_AMT_SUM) SIL_AMT_SUM \n";
			strSql += " 						  \n";
			strSql += " 						 FROM  \n";
			strSql += " 						 	  (		 \n";
			strSql += " 								SELECT '12' dept_div, \n";
			strSql += " 									   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 									   b.ACC_CODE,  \n";
			strSql += " 									   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 								FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 									   T_ACC_SLIP_BODY b,  \n";
			strSql += " 									   T_DEPT_CODE c                                              \n";
			strSql += " 								WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 								AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 								and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( ?  || '-01' ,'-','')  and replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 								and    c.COMP_CODE =  ?                                                                                                      \n";//28
			strSql += " 								and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 								GROUP BY  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 									      b.ACC_CODE  ) a \n";
			strSql += " 						GROUP BY a.ACC_CODE  					   \n";
			strSql += " 						) c, \n";
			strSql += " 					    --당월실적 - 전체부서 \n";
			strSql += " 						( \n";
			strSql += " 						SELECT '12' dept_div, \n";
			strSql += " 							   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 							   b.ACC_CODE,  \n";
			strSql += " 							   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 						FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 							   T_ACC_SLIP_BODY b,  \n";
			strSql += " 							   T_DEPT_CODE c                                              \n";
			strSql += " 						WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 						AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 						and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 						and    c.COMP_CODE =  ?                                                                                      \n"; //33
			strSql += " 						and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 						GROUP BY  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 							      b.ACC_CODE  ) d			   \n";
			strSql += " 					where a.comp_code = b.comp_code \n";
			strSql += " 					and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 					and	  a.chg_seq = b.chg_seq \n";
			strSql += " 					and	  a.acc_code = b.acc_code \n";
			strSql += " 					and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 					and	  a.acc_code = c.acc_code(+) \n";
			strSql += " 					and	  a.acc_code = d.acc_code(+) \n";
			strSql += " 					order by p_budg_code_no, budg_code_no \n";
			strSql += " 				) a \n";
			strSql += " 				group by a.dept_div, \n";
			strSql += " 					  	 a.p_budg_code_no \n";
			strSql += " 						 ) a, \n";
			strSql += " 				t_acc_code b, \n";
			strSql += " 				t_budg_code c \n";
			strSql += " 			where a.acc_code=b.acc_code(+) \n";
			strSql += " 			and	  a.p_budg_code_no = c.budg_code_no  \n";
			strSql += " 				 \n";
			strSql += " 			 \n";
			strSql += " 			 \n";
			strSql += " 			union  \n";
			strSql += " 			 \n";
			strSql += " 			 \n";
			strSql += " 			--부서별 \n";
			strSql += " 		select  a.dept_div, \n";
			strSql += " 				a.chk_dept_code, \n";
			strSql += " 				b.dept_name chk_dept_name, \n";
			strSql += " 				a.dept_code, \n";
			strSql += " 				a.dept_name, \n";
			strSql += " 				a.p_budg_code_no, \n";
			strSql += " 				a.budg_code_no, \n";
			strSql += " 				a.budg_code_name, \n";
			strSql += " 				a.acc_code, \n";
			strSql += " 				acc_name, \n";
			strSql += " 				a.budg_amt, \n";
			strSql += " 				a.budg_amt_sum, \n";
			strSql += " 				a.sil_amt_sum, \n";
			strSql += " 				a.sil_amt    \n";
			strSql += " 		from \n";
			strSql += " 				(select  \n";
			strSql += " 					   a.dept_div, \n";
			strSql += " 					   a.dept_code, \n";
			strSql += " 					   d.dept_name, \n";
			strSql += " 					   (select chk_dept_code from t_budg_dept_map where dept_code = a.dept_code) chk_dept_code, \n";
			strSql += " 					   a.p_budg_code_no, \n";
			strSql += " 					   a.budg_code_no, \n";
			strSql += " 					   c.budg_code_name, \n";
			strSql += " 					   a.acc_code, \n";
			strSql += " 					   decode(dept_div, '22', '소계', b.acc_name) acc_name, \n";
			strSql += " 					   a.budg_amt, \n";
			strSql += " 					   a.budg_amt_sum, \n";
			strSql += " 					   a.sil_amt_sum, \n";
			strSql += " 					   a.sil_amt    \n";
			strSql += " 				from \n";
			strSql += " 					( \n";
			strSql += " 					--전체부서 상위 계정별 집계 \n";
			strSql += " 					select --'상위계정' PARENT_NAME, \n";
			strSql += " 					       --'계정' ACC_NAME \n";
			strSql += " 						   a.dept_div, \n";
			strSql += " 						   a.dept_code, \n";
			strSql += " 						   a.p_budg_code_no, \n";
			strSql += " 						   a.budg_code_no, \n";
			strSql += " 						   a.acc_code, \n";
			strSql += " 						   b.budg_amt, \n";
			strSql += " 						   a.budg_amt_sum, \n";
			strSql += " 						   nvl(c.sil_amt_sum, 0) sil_amt_sum, \n";
			strSql += " 						   nvl(d.sil_amt, 0) sil_amt     \n";
			strSql += " 					from    \n";
			strSql += " 						 --누적 예산 - 부서별 \n";
			strSql += " 						  ( \n";
			strSql += " 						  select a.dept_div, \n";
			strSql += " 								 a.comp_code, \n";
			strSql += " 								 a.clse_acc_id, \n";
			strSql += " 								 a.dept_code, \n";
			strSql += " 								 a.chg_seq, \n";
			strSql += " 								 a.p_budg_code_no, \n";
			strSql += " 								 a.budg_code_no, \n";
			strSql += " 								 a.acc_code, \n";
			strSql += " 								 a.reserved_seq, \n";
			strSql += " 								 sum(a.budg_amt) budg_amt_sum \n";
			strSql += " 						  from 		 \n";
			strSql += " 						 \n";
			strSql += " 								(select \n";
			strSql += " 								 	   '21' dept_div, \n";
			strSql += " 								 	   a3.comp_code, \n";
			strSql += " 									   a3.clse_acc_id, \n";
			strSql += " 									   a3.dept_code, \n";
			strSql += " 									   a3.chg_seq, \n";
			strSql += " 									   a2.p_budg_code_no, \n";
			strSql += " 									   a1.budg_code_no, \n";
			strSql += " 									   a2.acc_code, \n";
			strSql += " 									   a1.budg_ym, \n";
			strSql += " 									   a3.reserved_seq, \n";
			strSql += " 									   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 								 from  t_budg_month_amt_h a1, \n";
			strSql += " 								 	   t_budg_code a2, \n";
			strSql += " 								 	   t_budg_dept_item_h a3 \n";
			strSql += " 								 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 								 and   a1.comp_code = a3.comp_code \n";
			strSql += " 								 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 								 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 								 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 								 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 								 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 								 and   a3.comp_code = ?  \n";
			strSql += " 								 and   a3.clse_acc_id= ?  \n";
			strSql += " 								 and   a3.chg_seq=0 \n";
			strSql += " 								 and   a3.reserved_seq=1 \n";
			strSql += " 								 and   a1.budg_ym between  ?  || '-01-01' and  ?  || '-' ||  ?  || '-01' \n"; //38
			strSql += " 								 group by    \n";
			strSql += " 								 	   a3.comp_code, \n";
			strSql += " 									   a3.clse_acc_id, \n";
			strSql += " 									   a3.dept_code, \n";
			strSql += " 									   a3.chg_seq, \n";
			strSql += " 									   a2.p_budg_code_no, \n";
			strSql += " 									   a1.budg_code_no, \n";
			strSql += " 									   a2.acc_code, \n";
			strSql += " 									   a1.budg_ym, \n";
			strSql += " 									   a3.reserved_seq ) a \n";
			strSql += " 							group by  \n";
			strSql += " 								  a.dept_div, \n";
			strSql += " 								  a.comp_code, \n";
			strSql += " 								  a.clse_acc_id, \n";
			strSql += " 								  a.dept_code, \n";
			strSql += " 								  a.chg_seq, \n";
			strSql += " 								  a.p_budg_code_no, \n";
			strSql += " 								  a.budg_code_no, \n";
			strSql += " 								  a.acc_code, \n";
			strSql += " 								  a.reserved_seq \n";
			strSql += " 						) a, \n";
			strSql += " 						--당월 예산 - 부서용 \n";
			strSql += " 						( select \n";
			strSql += " 						 	   '11' dept_div, \n";
			strSql += " 						 	   a3.comp_code, \n";
			strSql += " 							   a3.clse_acc_id, \n";
			strSql += " 							   a3.dept_code, \n";
			strSql += " 							   a3.chg_seq, \n";
			strSql += " 							   a2.p_budg_code_no, \n";
			strSql += " 							   a1.budg_code_no, \n";
			strSql += " 							   a2.acc_code, \n";
			strSql += " 							   a1.budg_ym, \n";
			strSql += " 							   a3.reserved_seq, \n";
			strSql += " 							   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 						 from  t_budg_month_amt_h a1, \n";
			strSql += " 						 	   t_budg_code a2, \n";
			strSql += " 						 	   t_budg_dept_item_h a3 \n";
			strSql += " 						 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 						 and   a1.comp_code = a3.comp_code \n";
			strSql += " 						 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 						 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 						 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 						 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 						 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 						 and   a3.comp_code = ?  \n";
			strSql += " 						 and   a3.clse_acc_id= ?  \n";
			strSql += " 						 and   a3.chg_seq=0 \n";
			strSql += " 						 and   a3.reserved_seq=1 \n";
			strSql += " 						 and   a1.budg_ym = ?  || '-' ||  ?  || '-01' \n";//42
			strSql += " 						 group by    \n";
			strSql += " 						 	   a3.comp_code, \n";
			strSql += " 							   a3.clse_acc_id, \n";
			strSql += " 							   a3.dept_code, \n";
			strSql += " 							   a3.chg_seq, \n";
			strSql += " 							   a2.p_budg_code_no, \n";
			strSql += " 							   a1.budg_code_no, \n";
			strSql += " 							   a2.acc_code, \n";
			strSql += " 							   a1.budg_ym, \n";
			strSql += " 							   a3.reserved_seq \n";
			strSql += " 						) b, \n";
			strSql += " 						--누적실적 - 부서용 \n";
			strSql += " 						( \n";
			strSql += " 						 SELECT	   '21' dept_div, \n";
			strSql += " 						 		    a.dept_code, \n";
			strSql += " 									a.ACC_CODE,  \n";
			strSql += " 									sum(SIL_AMT_SUM) SIL_AMT_SUM \n";
			strSql += " 						  \n";
			strSql += " 						 FROM  \n";
			strSql += " 						 	  (		 \n";
			strSql += " 								SELECT '21' dept_div, \n";
			strSql += " 									   c.dept_code, \n";
			strSql += " 									   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 									   b.ACC_CODE,  \n";
			strSql += " 									   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 								FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 									   T_ACC_SLIP_BODY b,  \n";
			strSql += " 									   T_DEPT_CODE c                                              \n";
			strSql += " 								WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 								AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 								and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( ?  || '-01' ,'-','')  and replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 								and    c.COMP_CODE =  ?                                                             \n"; //46
			strSql += " 								and    b.DEPT_CODE=c.DEPT_CODE                                              \n";
			strSql += " 								GROUP BY  c.dept_code, \n";
			strSql += " 									  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 									      b.ACC_CODE  ) a \n";
			strSql += " 						GROUP BY a.dept_code, \n";
			strSql += " 							  	 a.ACC_CODE  					   \n";
			strSql += " 						) c, \n";
			strSql += " 					    --당월실적 - 전체부서 \n";
			strSql += " 						( \n";
			strSql += " 						SELECT '21' dept_div, \n";
			strSql += " 							   c.dept_code, \n";
			strSql += " 							   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 							   b.ACC_CODE,  \n";
			strSql += " 							   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 						FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 							   T_ACC_SLIP_BODY b,  \n";
			strSql += " 							   T_DEPT_CODE c                                              \n";
			strSql += " 						WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 						AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 						and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 						and    c.COMP_CODE =  ?                                              \n"; //49
			strSql += " 						and    b.DEPT_CODE=c.DEPT_CODE                                 \n";
			strSql += " 						GROUP BY  c.dept_code, \n";
			strSql += " 							  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 							      b.ACC_CODE  ) d			   \n";
			strSql += " 					where a.comp_code = b.comp_code \n";
			strSql += " 					and	  a.dept_code = b.dept_code \n";
			strSql += " 					and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 					and	  a.chg_seq = b.chg_seq \n";
			strSql += " 					and	  a.acc_code = b.acc_code \n";
			strSql += " 					and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 					and	  a.acc_code = c.acc_code(+) \n";
			strSql += " 					and	  a.acc_code = d.acc_code(+) \n";
			strSql += " 					and	  a.dept_code = c.dept_code(+) \n";
			strSql += " 					and	  a.dept_code = d.dept_code(+) \n";
			strSql += " 					 \n";
			strSql += " 					union \n";
			strSql += " 					 \n";
			strSql += " 					--상위 계정별 sum \n";
			strSql += " 					select a.dept_div, \n";
			strSql += " 						   a.dept_code, \n";
			strSql += " 						   a.p_budg_code_no, \n";
			strSql += " 						   to_number(a.dept_div || a.p_budg_code_no) budg_code_no, \n";
			strSql += " 						   '' acc_code, \n";
			strSql += " 						   sum(budg_amt), \n";
			strSql += " 						   sum(budg_amt_sum), \n";
			strSql += " 						   sum(sil_amt_sum), \n";
			strSql += " 						   sum(sil_amt) \n";
			strSql += " 					from   \n";
			strSql += " 						--전체부서 상위 계정별 집계 \n";
			strSql += " 					    (select --'상위계정' PARENT_NAME, \n";
			strSql += " 						       --'계정' ACC_NAME \n";
			strSql += " 							   a.dept_div, \n";
			strSql += " 							   a.dept_code, \n";
			strSql += " 							   a.p_budg_code_no, \n";
			strSql += " 							   a.budg_code_no, \n";
			strSql += " 							   a.acc_code, \n";
			strSql += " 							   b.budg_ym, \n";
			strSql += " 							   b.budg_amt, \n";
			strSql += " 							   a.budg_amt_sum, \n";
			strSql += " 							   nvl(c.sil_amt_sum, 0) sil_amt_sum, \n";
			strSql += " 							   nvl(d.sil_amt, 0) sil_amt     \n";
			strSql += " 						from    \n";
			strSql += " 							 --누적 예산 - 전체부서용 \n";
			strSql += " 							(  \n";
			strSql += " 							  select a.dept_div, \n";
			strSql += " 									 a.comp_code, \n";
			strSql += " 									 a.clse_acc_id, \n";
			strSql += " 									 a.dept_code, \n";
			strSql += " 									 a.chg_seq, \n";
			strSql += " 									 a.p_budg_code_no, \n";
			strSql += " 									 a.budg_code_no, \n";
			strSql += " 									 a.acc_code, \n";
			strSql += " 									 a.reserved_seq, \n";
			strSql += " 									 sum(a.budg_amt) budg_amt_sum \n";
			strSql += " 							   \n";
			strSql += " 							  from 		 \n";
			strSql += " 							 \n";
			strSql += " 									(select \n";
			strSql += " 									 	   '22' dept_div, \n";
			strSql += " 									 	   a3.comp_code, \n";
			strSql += " 										   a3.clse_acc_id, \n";
			strSql += " 										   a3.dept_code, \n";
			strSql += " 										   a3.chg_seq, \n";
			strSql += " 										   a2.p_budg_code_no, \n";
			strSql += " 										   a1.budg_code_no, \n";
			strSql += " 										   a2.acc_code, \n";
			strSql += " 										   a1.budg_ym, \n";
			strSql += " 										   a3.reserved_seq, \n";
			strSql += " 										   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 									 from  t_budg_month_amt_h a1, \n";
			strSql += " 									 	   t_budg_code a2, \n";
			strSql += " 									 	   t_budg_dept_item_h a3 \n";
			strSql += " 									 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 									 and   a1.comp_code = a3.comp_code \n";
			strSql += " 									 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 									 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 									 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 									 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 									 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 									 and   a3.comp_code = ?  \n";
			strSql += " 									 and   a3.clse_acc_id= ?  \n";
			strSql += " 									 and   a3.chg_seq=0 \n";
			strSql += " 									 and   a3.reserved_seq=1 \n";
			strSql += " 									 and   a1.budg_ym between  ?  || '-01-01' and  ?  || '-' ||  ?  || '-01' \n"; //54
			strSql += " 									 group by    \n";
			strSql += " 									 	   a3.comp_code, \n";
			strSql += " 										   a3.clse_acc_id, \n";
			strSql += " 										   a3.dept_code, \n";
			strSql += " 										   a3.chg_seq, \n";
			strSql += " 										   a2.p_budg_code_no, \n";
			strSql += " 										   a1.budg_code_no, \n";
			strSql += " 										   a2.acc_code, \n";
			strSql += " 										   a1.budg_ym, \n";
			strSql += " 										   a3.reserved_seq ) a \n";
			strSql += " 								group by  \n";
			strSql += " 									  a.dept_div, \n";
			strSql += " 									  a.comp_code, \n";
			strSql += " 									  a.dept_code, \n";
			strSql += " 									  a.clse_acc_id, \n";
			strSql += " 									  a.chg_seq, \n";
			strSql += " 									  a.p_budg_code_no, \n";
			strSql += " 									  a.budg_code_no, \n";
			strSql += " 									  a.acc_code, \n";
			strSql += " 									  a.reserved_seq \n";
			strSql += " 							) a, \n";
			strSql += " 							--당월 예산 - 전체부서용 \n";
			strSql += " 							( select \n";
			strSql += " 							 	   '22' dept_div, \n";
			strSql += " 							 	   a3.comp_code, \n";
			strSql += " 								   a3.dept_code, \n";
			strSql += " 								   a3.clse_acc_id, \n";
			strSql += " 								   a3.chg_seq, \n";
			strSql += " 								   a2.p_budg_code_no, \n";
			strSql += " 								   a1.budg_code_no, \n";
			strSql += " 								   a2.acc_code, \n";
			strSql += " 								   a1.budg_ym, \n";
			strSql += " 								   a3.reserved_seq, \n";
			strSql += " 								   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 							 from  t_budg_month_amt_h a1, \n";
			strSql += " 							 	   t_budg_code a2, \n";
			strSql += " 							 	   t_budg_dept_item_h a3 \n";
			strSql += " 							 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 							 and   a1.comp_code = a3.comp_code \n";
			strSql += " 							 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 							 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 							 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 							 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 							 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 							 and   a3.comp_code = ?  \n";
			strSql += " 							 and   a3.clse_acc_id= ?  \n";
			strSql += " 							 and   a3.chg_seq=0 \n";
			strSql += " 							 and   a3.reserved_seq=1 \n";
			strSql += " 							 and   a1.budg_ym = ?  || '-' ||  ?  || '-01' \n"; //58
			strSql += " 							 group by    \n";
			strSql += " 							 	   a3.comp_code, \n";
			strSql += " 								   a3.clse_acc_id, \n";
			strSql += " 								   a3.dept_code, \n";
			strSql += " 								   a3.chg_seq, \n";
			strSql += " 								   a2.p_budg_code_no, \n";
			strSql += " 								   a1.budg_code_no, \n";
			strSql += " 								   a2.acc_code, \n";
			strSql += " 								   a1.budg_ym, \n";
			strSql += " 								   a3.reserved_seq \n";
			strSql += " 							) b, \n";
			strSql += " 							--누적실적 - 전체부서 \n";
			strSql += " 							( \n";
			strSql += " 							 SELECT	   '22' dept_div, \n";
			strSql += " 							 		   	a.dept_code, \n";
			strSql += " 										a.ACC_CODE,  \n";
			strSql += " 										sum(SIL_AMT_SUM) SIL_AMT_SUM \n";
			strSql += " 							  \n";
			strSql += " 							 FROM  \n";
			strSql += " 							 	  (		 \n";
			strSql += " 									SELECT '22' dept_div, \n";
			strSql += " 										   c.dept_code, \n";
			strSql += " 										   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 										   b.ACC_CODE,  \n";
			strSql += " 										   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 									FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 										   T_ACC_SLIP_BODY b,  \n";
			strSql += " 										   T_DEPT_CODE c                                              \n";
			strSql += " 									WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 									AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 									and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( ?  || '-01' ,'-','')  and replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 									and    c.COMP_CODE =  ?                                  \n"; //62
			strSql += " 									and    b.DEPT_CODE=c.DEPT_CODE                   \n";
			strSql += " 									GROUP BY  c.dept_code, \n";
			strSql += " 										  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 										      b.ACC_CODE  ) a \n";
			strSql += " 							GROUP BY a.dept_code, \n";
			strSql += " 								  	 a.ACC_CODE  					   \n";
			strSql += " 							) c, \n";
			strSql += " 						    --당월실적 - 전체부서 \n";
			strSql += " 							( \n";
			strSql += " 							SELECT '22' dept_div, \n";
			strSql += " 								   c.dept_code, \n";
			strSql += " 								   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 								   b.ACC_CODE,  \n";
			strSql += " 								   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 							FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 								   T_ACC_SLIP_BODY b,  \n";
			strSql += " 								   T_DEPT_CODE c                                              \n";
			strSql += " 							WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 							AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 							and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 							and    c.COMP_CODE =  ?                                           \n"; //65
			strSql += " 							and    b.DEPT_CODE=c.DEPT_CODE                            \n";
			strSql += " 							GROUP BY  c.dept_code, \n";
			strSql += " 								  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 								      b.ACC_CODE  ) d			   \n";
			strSql += " 						where a.comp_code = b.comp_code \n";
			strSql += " 						and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 						and	  a.dept_code = b.dept_code \n";
			strSql += " 						and	  a.chg_seq = b.chg_seq \n";
			strSql += " 						and	  a.acc_code = b.acc_code \n";
			strSql += " 						and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 						and	  a.acc_code = c.acc_code(+) \n";
			strSql += " 						and	  a.acc_code = d.acc_code(+) \n";
			strSql += " 						and	  a.dept_code = c.dept_code(+) \n";
			strSql += " 						and	  a.dept_code = d.dept_code(+) \n";
			strSql += " 						order by p_budg_code_no, budg_code_no \n";
			strSql += " 					) a \n";
			strSql += " 					group by a.dept_div, \n";
			strSql += " 						  	 a.dept_code, \n";
			strSql += " 						  	 a.p_budg_code_no ) a,  \n";
			strSql += " 					t_acc_code b, \n";
			strSql += " 					t_budg_code c, \n";
			strSql += " 					t_dept_code d \n";
			strSql += " 				where a.acc_code=b.acc_code(+) \n";
			strSql += " 				and	  a.p_budg_code_no = c.budg_code_no \n";
			strSql += " 				and	  a.dept_code = d.dept_code	 \n";
			strSql += " 			) a, \n";
			strSql += " 			t_dept_code b \n";
			strSql += " 		where  a.chk_dept_code = b.dept_code(+) \n";
			strSql += " 		and	   a.dept_code like '%' ||  ?  || '%' \n"; //66
			strSql += " 		 \n";
			strSql += " 		union \n";
			strSql += " 		 \n";
			strSql += " 		--팀별 \n";
			strSql += " 		select  \n";
			strSql += " 			   a.dept_div, \n";
			strSql += " 			   a.chk_dept_code, \n";
			strSql += " 			   a.chk_dept_name, \n";
			strSql += " 			   '' dept_code, \n";
			strSql += " 			   '' dept_name, \n";
			strSql += " 			   a.p_budg_code_no, \n";
			strSql += " 			   a.budg_code_no, \n";
			strSql += " 			   a.budg_code_name, \n";
			strSql += " 			   a.acc_code, \n";
			strSql += " 			   a.acc_name, \n";
			strSql += " 			   a.budg_amt, \n";
			strSql += " 			   a.budg_amt_sum, \n";
			strSql += " 			   a.sil_amt_sum, \n";
			strSql += " 			   a.sil_amt \n";
			strSql += " 		from  \n";
			strSql += " 			  ( select  a.dept_div, \n";
			strSql += " 						a.chk_dept_code, \n";
			strSql += " 						b.dept_name chk_dept_name, \n";
			strSql += " 						a.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.budg_code_name, \n";
			strSql += " 						a.acc_code, \n";
			strSql += " 						acc_name, \n";
			strSql += " 						sum(a.budg_amt)  budg_amt, \n";
			strSql += " 						sum(a.budg_amt_sum) budg_amt_sum, \n";
			strSql += " 						sum(a.sil_amt_sum) sil_amt_sum, \n";
			strSql += " 						sum(a.sil_amt)  sil_amt    \n";
			strSql += " 				from \n";
			strSql += " 						(select  \n";
			strSql += " 							   a.dept_div, \n";
			strSql += " 							   a.dept_code, \n";
			strSql += " 							   d.dept_name, \n";
			strSql += " 							   (select chk_dept_code from t_budg_dept_map where dept_code = a.dept_code) chk_dept_code, \n";
			strSql += " 							   a.p_budg_code_no, \n";
			strSql += " 							   a.budg_code_no, \n";
			strSql += " 							   c.budg_code_name, \n";
			strSql += " 							   a.acc_code, \n";
			strSql += " 							   decode(dept_div, '32', '소계', b.acc_name) acc_name, \n";
			strSql += " 							   a.budg_amt, \n";
			strSql += " 							   a.budg_amt_sum, \n";
			strSql += " 							   a.sil_amt_sum, \n";
			strSql += " 							   a.sil_amt    \n";
			strSql += " 						from \n";
			strSql += " 							( \n";
			strSql += " 							--전체부서 상위 계정별 집계 \n";
			strSql += " 							select --'상위계정' PARENT_NAME, \n";
			strSql += " 							       --'계정' ACC_NAME \n";
			strSql += " 								   a.dept_div, \n";
			strSql += " 								   a.dept_code, \n";
			strSql += " 								   a.p_budg_code_no, \n";
			strSql += " 								   a.budg_code_no, \n";
			strSql += " 								   a.acc_code, \n";
			strSql += " 								   b.budg_amt, \n";
			strSql += " 								   a.budg_amt_sum, \n";
			strSql += " 								   nvl(c.sil_amt_sum, 0) sil_amt_sum, \n";
			strSql += " 								   nvl(d.sil_amt, 0) sil_amt     \n";
			strSql += " 							from    \n";
			strSql += " 								 --누적 예산 - 부서별 \n";
			strSql += " 								  ( \n";
			strSql += " 								  select a.dept_div, \n";
			strSql += " 										 a.comp_code, \n";
			strSql += " 										 a.clse_acc_id, \n";
			strSql += " 										 a.dept_code, \n";
			strSql += " 										 a.chg_seq, \n";
			strSql += " 										 a.p_budg_code_no, \n";
			strSql += " 										 a.budg_code_no, \n";
			strSql += " 										 a.acc_code, \n";
			strSql += " 										 a.reserved_seq, \n";
			strSql += " 										 sum(a.budg_amt) budg_amt_sum \n";
			strSql += " 								  from 		 \n";
			strSql += " 								 \n";
			strSql += " 										(select \n";
			strSql += " 										 	   '31' dept_div, \n";
			strSql += " 										 	   a3.comp_code, \n";
			strSql += " 											   a3.clse_acc_id, \n";
			strSql += " 											   a3.dept_code, \n";
			strSql += " 											   a3.chg_seq, \n";
			strSql += " 											   a2.p_budg_code_no, \n";
			strSql += " 											   a1.budg_code_no, \n";
			strSql += " 											   a2.acc_code, \n";
			strSql += " 											   a1.budg_ym, \n";
			strSql += " 											   a3.reserved_seq, \n";
			strSql += " 											   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 										 from  t_budg_month_amt_h a1, \n";
			strSql += " 										 	   t_budg_code a2, \n";
			strSql += " 										 	   t_budg_dept_item_h a3 \n";
			strSql += " 										 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 										 and   a1.comp_code = a3.comp_code \n";
			strSql += " 										 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 										 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 										 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 										 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 										 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 										 and   a3.comp_code = ?  \n";
			strSql += " 										 and   a3.clse_acc_id= ?  \n";
			strSql += " 										 and   a3.chg_seq=0 \n";
			strSql += " 										 and   a3.reserved_seq=1 \n";
			strSql += " 										 and   a1.budg_ym between  ?  || '-01-01' and  ?  || '-' ||  ?  || '-01' \n"; //71
			strSql += " 										 group by    \n";
			strSql += " 										 	   a3.comp_code, \n";
			strSql += " 											   a3.clse_acc_id, \n";
			strSql += " 											   a3.dept_code, \n";
			strSql += " 											   a3.chg_seq, \n";
			strSql += " 											   a2.p_budg_code_no, \n";
			strSql += " 											   a1.budg_code_no, \n";
			strSql += " 											   a2.acc_code, \n";
			strSql += " 											   a1.budg_ym, \n";
			strSql += " 											   a3.reserved_seq ) a \n";
			strSql += " 									group by  \n";
			strSql += " 										  a.dept_div, \n";
			strSql += " 										  a.comp_code, \n";
			strSql += " 										  a.clse_acc_id, \n";
			strSql += " 										  a.dept_code, \n";
			strSql += " 										  a.chg_seq, \n";
			strSql += " 										  a.p_budg_code_no, \n";
			strSql += " 										  a.budg_code_no, \n";
			strSql += " 										  a.acc_code, \n";
			strSql += " 										  a.reserved_seq \n";
			strSql += " 								) a, \n";
			strSql += " 								--당월 예산 - 부서용 \n";
			strSql += " 								( select \n";
			strSql += " 								 	   '31' dept_div, \n";
			strSql += " 								 	   a3.comp_code, \n";
			strSql += " 									   a3.clse_acc_id, \n";
			strSql += " 									   a3.dept_code, \n";
			strSql += " 									   a3.chg_seq, \n";
			strSql += " 									   a2.p_budg_code_no, \n";
			strSql += " 									   a1.budg_code_no, \n";
			strSql += " 									   a2.acc_code, \n";
			strSql += " 									   a1.budg_ym, \n";
			strSql += " 									   a3.reserved_seq, \n";
			strSql += " 									   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 								 from  t_budg_month_amt_h a1, \n";
			strSql += " 								 	   t_budg_code a2, \n";
			strSql += " 								 	   t_budg_dept_item_h a3 \n";
			strSql += " 								 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 								 and   a1.comp_code = a3.comp_code \n";
			strSql += " 								 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 								 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 								 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 								 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 								 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 								 and   a3.comp_code = ?  \n";
			strSql += " 								 and   a3.clse_acc_id= ?  \n";
			strSql += " 								 and   a3.chg_seq=0 \n";
			strSql += " 								 and   a3.reserved_seq=1 \n";
			strSql += " 								 and   a1.budg_ym = ?  || '-' ||  ?  || '-01' \n";//75
			strSql += " 								 group by    \n";
			strSql += " 								 	   a3.comp_code, \n";
			strSql += " 									   a3.clse_acc_id, \n";
			strSql += " 									   a3.dept_code, \n";
			strSql += " 									   a3.chg_seq, \n";
			strSql += " 									   a2.p_budg_code_no, \n";
			strSql += " 									   a1.budg_code_no, \n";
			strSql += " 									   a2.acc_code, \n";
			strSql += " 									   a1.budg_ym, \n";
			strSql += " 									   a3.reserved_seq \n";
			strSql += " 								) b, \n";
			strSql += " 								--누적실적 - 부서용 \n";
			strSql += " 								( \n";
			strSql += " 								 SELECT	   '31' dept_div, \n";
			strSql += " 								 		    a.dept_code, \n";
			strSql += " 											a.ACC_CODE,  \n";
			strSql += " 											sum(SIL_AMT_SUM) SIL_AMT_SUM \n";
			strSql += " 								  \n";
			strSql += " 								 FROM  \n";
			strSql += " 								 	  (		 \n";
			strSql += " 										SELECT '31' dept_div, \n";
			strSql += " 											   c.dept_code, \n";
			strSql += " 											   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 											   b.ACC_CODE,  \n";
			strSql += " 											   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 										FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 											   T_ACC_SLIP_BODY b,  \n";
			strSql += " 											   T_DEPT_CODE c                                              \n";
			strSql += " 										WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 										AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 										and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( ?  || '-01' ,'-','')  and replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 										and    c.COMP_CODE =  ?                               \n"; //79
			strSql += " 										and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 										GROUP BY  c.dept_code, \n";
			strSql += " 											  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 											      b.ACC_CODE  ) a \n";
			strSql += " 								GROUP BY a.dept_code, \n";
			strSql += " 									  	 a.ACC_CODE  					   \n";
			strSql += " 								) c, \n";
			strSql += " 							    --당월실적 - 전체부서 \n";
			strSql += " 								( \n";
			strSql += " 								SELECT '31' dept_div, \n";
			strSql += " 									   c.dept_code, \n";
			strSql += " 									   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 									   b.ACC_CODE,  \n";
			strSql += " 									   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 								FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 									   T_ACC_SLIP_BODY b,  \n";
			strSql += " 									   T_DEPT_CODE c                                              \n";
			strSql += " 								WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 								AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 								and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 								and    c.COMP_CODE =  ?                               \n"; //82
			strSql += " 								and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 								GROUP BY  c.dept_code, \n";
			strSql += " 									  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 									      b.ACC_CODE  ) d			   \n";
			strSql += " 							where a.comp_code = b.comp_code \n";
			strSql += " 							and	  a.dept_code = b.dept_code \n";
			strSql += " 							and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 							and	  a.chg_seq = b.chg_seq \n";
			strSql += " 							and	  a.acc_code = b.acc_code \n";
			strSql += " 							and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 							and	  a.acc_code = c.acc_code(+) \n";
			strSql += " 							and	  a.acc_code = d.acc_code(+) \n";
			strSql += " 							and	  a.dept_code = c.dept_code(+) \n";
			strSql += " 							and	  a.dept_code = d.dept_code(+) \n";
			strSql += " 							 \n";
			strSql += " 							union \n";
			strSql += " 							 \n";
			strSql += " 							--상위 계정별 sum \n";
			strSql += " 							select a.dept_div, \n";
			strSql += " 								   a.dept_code, \n";
			strSql += " 								   a.p_budg_code_no, \n";
			strSql += " 								   to_number(a.dept_div || a.p_budg_code_no) budg_code_no, \n";
			strSql += " 								   '' acc_code, \n";
			strSql += " 								   sum(budg_amt), \n";
			strSql += " 								   sum(budg_amt_sum), \n";
			strSql += " 								   sum(sil_amt_sum), \n";
			strSql += " 								   sum(sil_amt) \n";
			strSql += " 							from   \n";
			strSql += " 								--전체부서 상위 계정별 집계 \n";
			strSql += " 							    (select --'상위계정' PARENT_NAME, \n";
			strSql += " 								       --'계정' ACC_NAME \n";
			strSql += " 									   a.dept_div, \n";
			strSql += " 									   a.dept_code, \n";
			strSql += " 									   a.p_budg_code_no, \n";
			strSql += " 									   a.budg_code_no, \n";
			strSql += " 									   a.acc_code, \n";
			strSql += " 									   b.budg_ym, \n";
			strSql += " 									   b.budg_amt, \n";
			strSql += " 									   a.budg_amt_sum, \n";
			strSql += " 									   nvl(c.sil_amt_sum, 0) sil_amt_sum, \n";
			strSql += " 									   nvl(d.sil_amt, 0) sil_amt     \n";
			strSql += " 								from    \n";
			strSql += " 									 --누적 예산 - 전체부서용 \n";
			strSql += " 									(  \n";
			strSql += " 									  select a.dept_div, \n";
			strSql += " 											 a.comp_code, \n";
			strSql += " 											 a.clse_acc_id, \n";
			strSql += " 											 a.dept_code, \n";
			strSql += " 											 a.chg_seq, \n";
			strSql += " 											 a.p_budg_code_no, \n";
			strSql += " 											 a.budg_code_no, \n";
			strSql += " 											 a.acc_code, \n";
			strSql += " 											 a.reserved_seq, \n";
			strSql += " 											 sum(a.budg_amt) budg_amt_sum \n";
			strSql += " 									   \n";
			strSql += " 									  from 		 \n";
			strSql += " 									 \n";
			strSql += " 											(select \n";
			strSql += " 											 	   '32' dept_div, \n";
			strSql += " 											 	   a3.comp_code, \n";
			strSql += " 												   a3.clse_acc_id, \n";
			strSql += " 												   a3.dept_code, \n";
			strSql += " 												   a3.chg_seq, \n";
			strSql += " 												   a2.p_budg_code_no, \n";
			strSql += " 												   a1.budg_code_no, \n";
			strSql += " 												   a2.acc_code, \n";
			strSql += " 												   a1.budg_ym, \n";
			strSql += " 												   a3.reserved_seq, \n";
			strSql += " 												   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 											 from  t_budg_month_amt_h a1, \n";
			strSql += " 											 	   t_budg_code a2, \n";
			strSql += " 											 	   t_budg_dept_item_h a3 \n";
			strSql += " 											 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 											 and   a1.comp_code = a3.comp_code \n";
			strSql += " 											 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 											 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 											 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 											 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 											 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 											 and   a3.comp_code = ?  \n";
			strSql += " 											 and   a3.clse_acc_id= ?  \n";
			strSql += " 											 and   a3.chg_seq=0 \n";
			strSql += " 											 and   a3.reserved_seq=1 \n";
			strSql += " 											 and   a1.budg_ym between  ?  || '-01-01' and  ?  || '-' ||  ?  || '-01' \n"; //87
			strSql += " 											 group by    \n";
			strSql += " 											 	   a3.comp_code, \n";
			strSql += " 												   a3.clse_acc_id, \n";
			strSql += " 												   a3.dept_code, \n";
			strSql += " 												   a3.chg_seq, \n";
			strSql += " 												   a2.p_budg_code_no, \n";
			strSql += " 												   a1.budg_code_no, \n";
			strSql += " 												   a2.acc_code, \n";
			strSql += " 												   a1.budg_ym, \n";
			strSql += " 												   a3.reserved_seq ) a \n";
			strSql += " 										group by  \n";
			strSql += " 											  a.dept_div, \n";
			strSql += " 											  a.comp_code, \n";
			strSql += " 											  a.dept_code, \n";
			strSql += " 											  a.clse_acc_id, \n";
			strSql += " 											  a.chg_seq, \n";
			strSql += " 											  a.p_budg_code_no, \n";
			strSql += " 											  a.budg_code_no, \n";
			strSql += " 											  a.acc_code, \n";
			strSql += " 											  a.reserved_seq \n";
			strSql += " 									) a, \n";
			strSql += " 									--당월 예산 - 전체부서용 \n";
			strSql += " 									( select \n";
			strSql += " 									 	   '32' dept_div, \n";
			strSql += " 									 	   a3.comp_code, \n";
			strSql += " 										   a3.dept_code, \n";
			strSql += " 										   a3.clse_acc_id, \n";
			strSql += " 										   a3.chg_seq, \n";
			strSql += " 										   a2.p_budg_code_no, \n";
			strSql += " 										   a1.budg_code_no, \n";
			strSql += " 										   a2.acc_code, \n";
			strSql += " 										   a1.budg_ym, \n";
			strSql += " 										   a3.reserved_seq, \n";
			strSql += " 										   sum(budg_month_assign_amt) budg_amt \n";
			strSql += " 									 from  t_budg_month_amt_h a1, \n";
			strSql += " 									 	   t_budg_code a2, \n";
			strSql += " 									 	   t_budg_dept_item_h a3 \n";
			strSql += " 									 where a2.budg_code_no=a3.budg_code_no \n";
			strSql += " 									 and   a1.comp_code = a3.comp_code \n";
			strSql += " 									 and   a1.clse_acc_id = a3.clse_acc_id \n";
			strSql += " 									 and   a1.chg_seq = a3.chg_seq \n";
			strSql += " 									 and   a1.budg_code_no = a3.budg_code_no \n";
			strSql += " 									 and   a1.dept_code	  = a3.dept_code \n";
			strSql += " 									 and   a1.reserved_seq	  = a3.reserved_seq  \n";
			strSql += " 									 and   a3.comp_code = ?  \n";
			strSql += " 									 and   a3.clse_acc_id= ?  \n";
			strSql += " 									 and   a3.chg_seq=0 \n";
			strSql += " 									 and   a3.reserved_seq=1 \n";
			strSql += " 									 and   a1.budg_ym = ?  || '-' ||  ?  || '-01' \n";//91
			strSql += " 									 group by    \n";
			strSql += " 									 	   a3.comp_code, \n";
			strSql += " 										   a3.clse_acc_id, \n";
			strSql += " 										   a3.dept_code, \n";
			strSql += " 										   a3.chg_seq, \n";
			strSql += " 										   a2.p_budg_code_no, \n";
			strSql += " 										   a1.budg_code_no, \n";
			strSql += " 										   a2.acc_code, \n";
			strSql += " 										   a1.budg_ym, \n";
			strSql += " 										   a3.reserved_seq \n";
			strSql += " 									) b, \n";
			strSql += " 									--누적실적 - 전체부서 \n";
			strSql += " 									( \n";
			strSql += " 									 SELECT	   '32' dept_div, \n";
			strSql += " 									 		   	a.dept_code, \n";
			strSql += " 												a.ACC_CODE,  \n";
			strSql += " 												sum(SIL_AMT_SUM) SIL_AMT_SUM \n";
			strSql += " 									  \n";
			strSql += " 									 FROM  \n";
			strSql += " 									 	  (		 \n";
			strSql += " 											SELECT '32' dept_div, \n";
			strSql += " 												   c.dept_code, \n";
			strSql += " 												   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 												   b.ACC_CODE,  \n";
			strSql += " 												   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 											FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 												   T_ACC_SLIP_BODY b,  \n";
			strSql += " 												   T_DEPT_CODE c                                              \n";
			strSql += " 											WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 											AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 											and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( ?  || '-01' ,'-','')  and replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 											and    c.COMP_CODE =  ?                          \n";//95
			strSql += " 											and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 											GROUP BY  c.dept_code, \n";
			strSql += " 												  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 												      b.ACC_CODE  ) a \n";
			strSql += " 									GROUP BY a.dept_code, \n";
			strSql += " 										  	 a.ACC_CODE  					   \n";
			strSql += " 									) c, \n";
			strSql += " 								    --당월실적 - 전체부서 \n";
			strSql += " 									( \n";
			strSql += " 									SELECT '32' dept_div, \n";
			strSql += " 										   c.dept_code, \n";
			strSql += " 										   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM,  \n";
			strSql += " 										   b.ACC_CODE,  \n";
			strSql += " 										   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 									FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 										   T_ACC_SLIP_BODY b,  \n";
			strSql += " 										   T_DEPT_CODE c                                              \n";
			strSql += " 									WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 									AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 									and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( ?  || '-' ||  ?  ,'-','') \n";
			strSql += " 									and    c.COMP_CODE =  ?                  \n";//98
			strSql += " 									and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 									GROUP BY  c.dept_code, \n";
			strSql += " 										  	  SUBSTR(a.MAKE_DT_TRANS,1,6),  \n";
			strSql += " 										      b.ACC_CODE  ) d			   \n";
			strSql += " 								where a.comp_code = b.comp_code \n";
			strSql += " 								and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 								and	  a.dept_code = b.dept_code \n";
			strSql += " 								and	  a.chg_seq = b.chg_seq \n";
			strSql += " 								and	  a.acc_code = b.acc_code \n";
			strSql += " 								and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 								and	  a.acc_code = c.acc_code(+) \n";
			strSql += " 								and	  a.acc_code = d.acc_code(+) \n";
			strSql += " 								and	  a.dept_code = c.dept_code(+) \n";
			strSql += " 								and	  a.dept_code = d.dept_code(+) \n";
			strSql += " 								order by p_budg_code_no, budg_code_no \n";
			strSql += " 							) a \n";
			strSql += " 							group by a.dept_div, \n";
			strSql += " 								  	 a.dept_code, \n";
			strSql += " 								  	 a.p_budg_code_no ) a,  \n";
			strSql += " 							t_acc_code b, \n";
			strSql += " 							t_budg_code c, \n";
			strSql += " 							t_dept_code d \n";
			strSql += " 						where a.acc_code=b.acc_code(+) \n";
			strSql += " 						and	  a.p_budg_code_no = c.budg_code_no \n";
			strSql += " 						and	  a.dept_code = d.dept_code	 \n";
			strSql += " 					) a, \n";
			strSql += " 					t_dept_code b \n";
			strSql += " 				where  a.chk_dept_code = b.dept_code(+) \n";
			strSql += " 				and	   a.dept_code like '%' ||  ?  || '%' \n";//99
			strSql += " 				group by  \n";
			strSql += " 					  	 a.dept_div, \n";
			strSql += " 						a.chk_dept_code, \n";
			strSql += " 						b.dept_name, \n";
			strSql += " 						a.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.budg_code_name, \n";
			strSql += " 						a.acc_code, \n";
			strSql += " 						acc_name \n";
			strSql += " 				) a	 \n";
			strSql += " 				 \n";
			strSql += " 		) a \n";
			strSql += " where  substr(dept_div, 1, 1) =  ?  \n";//100
			strSql += " order by 2, 3, 6, 1 \n";
			strSql += " 	 ";
	
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID3", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID4", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH5", CITData.VARCHAR2); //5
			lrArgData.addColumn("COMP_CODE6", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID7", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID8", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH9", CITData.VARCHAR2); //9
			lrArgData.addColumn("CLSE_ACC_ID10", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID11", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH12", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE13", CITData.VARCHAR2);//13
			lrArgData.addColumn("CLSE_ACC_ID14", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH15", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE16", CITData.VARCHAR2);//16
			lrArgData.addColumn("COMP_CODE17", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID18", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID19", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID20", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH21", CITData.VARCHAR2);//21
			lrArgData.addColumn("COMP_CODE22", CITData.VARCHAR2); //22
			lrArgData.addColumn("CLSE_ACC_ID23", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID24", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH25", CITData.VARCHAR2);//25
			lrArgData.addColumn("CLSE_ACC_ID26", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID27", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH28", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE29", CITData.VARCHAR2);//29
			lrArgData.addColumn("CLSE_ACC_ID30", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH31", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE32", CITData.VARCHAR2); //
			lrArgData.addColumn("COMP_CODE33", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID34", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID35", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID36", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH37", CITData.VARCHAR2); //
			lrArgData.addColumn("COMP_CODE38", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID39", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID40", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH41", CITData.VARCHAR2); //42
			lrArgData.addColumn("CLSE_ACC_ID42", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID43", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH44", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE45", CITData.VARCHAR2); //
			lrArgData.addColumn("CLSE_ACC_ID46", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH47", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE48", CITData.VARCHAR2); //49
			lrArgData.addColumn("COMP_CODE49", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID50", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID51", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID52", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH53", CITData.VARCHAR2); //54
			lrArgData.addColumn("COMP_CODE54", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID55", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID56", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH57", CITData.VARCHAR2); //58
			lrArgData.addColumn("CLSE_ACC_ID58", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID59", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH60", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE61", CITData.VARCHAR2); //62
			lrArgData.addColumn("CLSE_ACC_ID62", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH63", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE64", CITData.VARCHAR2);//65
			lrArgData.addColumn("DEPT_CODE65", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE66", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID67", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID68", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID69", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH70", CITData.VARCHAR2); //
			lrArgData.addColumn("COMP_CODE71", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID72", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID73", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH74", CITData.VARCHAR2); //
			lrArgData.addColumn("CLSE_ACC_ID75", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID76", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH77", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE78", CITData.VARCHAR2); //
			lrArgData.addColumn("CLSE_ACC_ID79", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH80", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE81", CITData.VARCHAR2); //82
			lrArgData.addColumn("COMP_CODE82", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID83", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID84", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID85", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH86", CITData.VARCHAR2); //87
			lrArgData.addColumn("COMP_CODE87", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID88", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID89", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH90", CITData.VARCHAR2); //91
			lrArgData.addColumn("CLSE_ACC_ID91", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID92", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH93", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE94", CITData.VARCHAR2);//95
			lrArgData.addColumn("CLSE_ACC_ID95", CITData.VARCHAR2);
			lrArgData.addColumn("MONTH96", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE97", CITData.VARCHAR2);//98
			lrArgData.addColumn("DEPT_CODE98", CITData.VARCHAR2);
			lrArgData.addColumn("DIV99", CITData.VARCHAR2);//100
			lrArgData.addRow();
			
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID2", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID3", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID4", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH5", strMONTH); //
			lrArgData.setValue("COMP_CODE6", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID7", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID8", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH9", strMONTH); //
			lrArgData.setValue("CLSE_ACC_ID10", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID11", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH12", strMONTH);
			lrArgData.setValue("COMP_CODE13", strCOMP_CODE);//
			lrArgData.setValue("CLSE_ACC_ID14", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH15", strMONTH);
			lrArgData.setValue("COMP_CODE16", strCOMP_CODE);//
			lrArgData.setValue("COMP_CODE17", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID18", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID19", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID20", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH21", strMONTH);//21
			lrArgData.setValue("COMP_CODE22", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID23", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID24", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH25", strMONTH);
			lrArgData.setValue("CLSE_ACC_ID26", strCLSE_ACC_ID);//26
			lrArgData.setValue("CLSE_ACC_ID27", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH28", strMONTH);
			lrArgData.setValue("COMP_CODE29", strCOMP_CODE);//29
			lrArgData.setValue("CLSE_ACC_ID30", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH31", strMONTH);
			lrArgData.setValue("COMP_CODE32", strCOMP_CODE); //
			lrArgData.setValue("COMP_CODE33", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID34", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID35", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID36", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH37", strMONTH); //
			lrArgData.setValue("COMP_CODE38", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID39", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID40", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH41", strMONTH); //42
			lrArgData.setValue("CLSE_ACC_ID42", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID43", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH44", strMONTH);
			lrArgData.setValue("COMP_CODE45", strCOMP_CODE); //
			lrArgData.setValue("CLSE_ACC_ID46", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH47", strMONTH);
			lrArgData.setValue("COMP_CODE48", strCOMP_CODE); //49
			lrArgData.setValue("COMP_CODE49", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID50", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID51", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID52", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH53", strMONTH); //53
			lrArgData.setValue("COMP_CODE54", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID55", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID56", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH57", strMONTH); //58
			lrArgData.setValue("CLSE_ACC_ID58", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID59", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH60", strMONTH);
			lrArgData.setValue("COMP_CODE61", strCOMP_CODE); //62
			lrArgData.setValue("CLSE_ACC_ID62", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH63", strMONTH);
			lrArgData.setValue("COMP_CODE64", strCOMP_CODE);//65
			lrArgData.setValue("DEPT_CODE65", strDEPT_CODE);
			lrArgData.setValue("COMP_CODE66", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID67", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID68", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID69", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH70", strMONTH); //
			lrArgData.setValue("COMP_CODE71", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID72", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID73", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH74", strMONTH); //
			lrArgData.setValue("CLSE_ACC_ID75", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID76", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH77", strMONTH);
			lrArgData.setValue("COMP_CODE78", strCOMP_CODE); //
			lrArgData.setValue("CLSE_ACC_ID79", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH80", strMONTH);
			lrArgData.setValue("COMP_CODE81", strCOMP_CODE); //82
			lrArgData.setValue("COMP_CODE82", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID83", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID84", strCLSE_ACC_ID);	
			lrArgData.setValue("CLSE_ACC_ID85", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH86", strMONTH); //87
			lrArgData.setValue("COMP_CODE87", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID88", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID89", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH90", strMONTH); //91
			lrArgData.setValue("CLSE_ACC_ID91", strCLSE_ACC_ID);
			lrArgData.setValue("CLSE_ACC_ID92", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH93", strMONTH);
			lrArgData.setValue("COMP_CODE94", strCOMP_CODE);//95
			lrArgData.setValue("CLSE_ACC_ID95", strCLSE_ACC_ID);
			lrArgData.setValue("MONTH96", strMONTH);
			lrArgData.setValue("COMP_CODE97", strCOMP_CODE);//98
			lrArgData.setValue("DEPT_CODE98", strDEPT_CODE);
			lrArgData.setValue("DIV99", strDIV);//99
			
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);



				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}

		else if (strAct.equals("CLOSE"))
		{
			String vDeptCode = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String VClseMonth = CITCommon.toKOR(request.getParameter("CLSE_MONTH"));

			strSql   = "\nSELECT b.REQ_CLSE_CLS, b.CONF_CLSE_CLS ";
			strSql  += "\nFROM T_DEPT_CODE a, TBA_MONTH_CLOSE b ";
			strSql  += "\nWHERE ";
			strSql  += "\n     a.DEPT_CODE = '"+vDeptCode+"' ";
			strSql  += "\n     AND a.COMP_CODE = b.COMP_CODE ";
			strSql  += "\n     AND b.CLSE_MONTH = '"+VClseMonth+"' ";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		
		else if (strAct.equals("DATE"))
		{
			
			strSql   = "\nSELECT to_char(sysdate, 'YYYY-MM') cdate ";
			strSql  += "\nFROM dual b ";
		

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}

	}
	catch (Exception ex)
	{
		if (GauceInfo != null)
		{
			GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		}
		else
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null)
			{
				GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
			}
			else
			{
				throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
			}
		}
	}
%>
