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
			strSql  += "From T_COMPANY A ,\n";
			strSql  += "	   T_DEPT_CODE B \n";
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
	
		//전체
		else if (strAct.equals("LIST02")) // 수정본
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strMONTH = CITCommon.toKOR(request.getParameter("MONTH"));
			String strDEPT_FLAG = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
			
		       strSql  = " select \n";
			strSql += " 	  a.div, \n";
			strSql += " 	  decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', a.chk_dept_code, 'DEPT', a.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 	  d1.dept_name chk_dept_name, \n";
			strSql += " 	  decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, '') dept_code, \n";
			strSql += " 	  d2.dept_name, \n";
			strSql += " 	  a.p_budg_code_no, \n";
			strSql += " 	  b.budg_code_name p_acc_name, \n";
			strSql += " 	  a.budg_code_no, \n";
			strSql += " 	  a.acc_code, \n";
			strSql += " 	  decode(div, '12','소계', '13','총계', c.acc_name) acc_name,  \n";
			strSql += " 	  budg_assign_amt_sum, \n";
			strSql += " 	  chg_amt_sum, \n";
			strSql += " 	  sil_amt_sum, \n";
			strSql += " 	  no_sil_amt_sum, \n";
			strSql += " 	  budg_assign_amt_sum - (no_sil_amt_sum + sil_amt_sum) jan_sum, \n";
			strSql += " 	  budg_assign_amt, \n";
			strSql += " 	  chg_amt, \n";
			strSql += " 	  sil_amt, \n";
			strSql += " 	  no_sil_amt, \n";
			strSql += " 	  budg_assign_amt -(no_sil_amt + sil_amt) jan \n";
			strSql += " from \n";
			strSql += " ( \n";
			strSql += " 	select	'11' div, \n";
			strSql += " 			decode('" + strDEPT_FLAG + "' , 'CHK_DEPT', a3.chk_dept_code, 'DEPT', a3.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 			decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a3.dept_code, '') dept_code, \n";
			strSql += " 			a3.p_budg_code_no, \n";
			strSql += " 			a3.budg_code_no, \n";
			strSql += " 			a3.acc_code, \n";
			strSql += " 			nvl(a1.budg_assign_amt_sum,0) budg_assign_amt_sum, \n";
			strSql += " 			nvl(a1.chg_amt_sum,0) chg_amt_sum, \n";
			strSql += " 			nvl(a2.sil_amt_sum,0) sil_amt_sum, \n";
			strSql += " 			nvl(a2_1.no_sil_amt_sum,0) no_sil_amt_sum, \n";
			strSql += " 			nvl(a3.budg_month_assign_amt,0) budg_assign_amt, \n";
			strSql += " 			nvl(a3.chg_amt,0) chg_amt, \n";
			strSql += " 			nvl(a4.sil_amt,0) sil_amt, \n";
			strSql += " 			nvl(a4_1.no_sil_amt,0) no_sil_amt \n";
			strSql += " 	from \n";
			strSql += " 			--누적예산, 추가  \n";
			strSql += " 			(select  \n";
			strSql += " 					'11' div, \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, '') dept_code, \n";
			strSql += " 					b.p_budg_code_no, \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					b.acc_code, \n";
			strSql += " 					sum(nvl(a.budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT_SUM,  \n";
			strSql += " 			   		sum(nvl(a.chg_amt,0)) CHG_AMT_SUM	 \n";
			strSql += " 			from \n";
			strSql += " 				( \n";
			strSql += " 				select  \n";
			strSql += "						   a.comp_code, \n";
			strSql += "						   a.clse_acc_id, \n";
			strSql += "						   a.dept_code,\n";
			strSql += "						   a.budg_code_no,\n";
			strSql += "						   a.budg_ym,\n";
			strSql += "						   a.budg_month_assign_amt,\n";
			strSql += "						   (a.budg_month_assign_amt - b.budg_month_assign_amt) chg_amt \n";
			strSql += "					from   t_budg_month_amt a,\n";
			strSql += "						   t_budg_month_amt_h b \n";
			strSql += "					where  a.comp_code = b.comp_code \n";
			strSql += "					and	   a.clse_acc_id = b.clse_acc_id \n";
			strSql += "					and	   a.dept_code = b.dept_code \n";
			strSql += "					and	   a.budg_code_no = b.budg_code_no \n";
			strSql += "					and	   a.reserved_seq = b.reserved_seq \n";
			strSql += "					and	   b.chg_seq = 0 \n";
			strSql += "					and	   a.budg_ym = b.budg_ym \n";
			strSql += " 				) a,  \n";
			strSql += " 				t_budg_code b, \n";
			strSql += " 				t_budg_dept_map c \n";
			strSql += " 			where a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 			and   a.dept_code  	  = c.dept_code(+) \n";
			strSql += " 			and   a.comp_code     =  '" + strCOMP_CODE + "'  \n";
			strSql += " 			and	  a.clse_acc_id   = '" + strCLSE_ACC_ID + "'  \n";
			strSql += " 			and   a.budg_ym between  '" + strCLSE_ACC_ID + "'  || '01-01' and  '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  || '-01' \n";
			strSql += " 			group  by \n";
			strSql += " 				    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, ''), \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, ''),     \n";
			strSql += " 					b.p_budg_code_no, \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					b.acc_code \n";
			strSql += " 			) a1, \n";
			strSql += " 			--누적실적 - 전체부서 \n";
			strSql += " 			( \n";
			strSql += " 				 \n";
			strSql += " 			SELECT  \n";
			strSql += " 				   decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code, \n";
			strSql += " 				   b.ACC_CODE,  \n";
			strSql += " 				   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 		    FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 				   T_ACC_SLIP_BODY b,  \n";
			strSql += " 				   T_DEPT_CODE c                                        \n";
			strSql += " 			WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 			AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 			and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( '" + strCLSE_ACC_ID + "'  || '-' || '01' ,'-','')  and replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 			and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                      \n";
			strSql += " 			and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 			GROUP BY  decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 				  	  b.acc_code  \n";
			strSql += " 		   \n";
			strSql += " 			) a2, \n";
			strSql += " 			--누적실적_미확정 - 전체부서 \n";
			strSql += " 			( \n";
			strSql += " 				 \n";
			strSql += " 			SELECT  \n";
			strSql += " 				   decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code, \n";
			strSql += " 				   b.ACC_CODE,  \n";
			strSql += " 				   SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) no_SIL_AMT_SUM   \n";
			strSql += " 		    FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 				   T_ACC_SLIP_BODY b,  \n";
			strSql += " 				   T_DEPT_CODE c                                        \n";
			strSql += " 			WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 			AND    a.KEEP_SLIPNO is null                                                                     \n";
			strSql += " 			and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( '" + strCLSE_ACC_ID + "'  || '-' || '01' ,'-','')  and replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 			and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                      \n";
			strSql += " 			and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 			GROUP BY  decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 				  	  b.acc_code  \n";
			strSql += " 		   \n";
			strSql += " 			) a2_1, \n";
			strSql += " 			--당월 \n";
			strSql += " 			(select  \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, '') dept_code, \n";
			strSql += " 					b.p_budg_code_no, \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					b.acc_code, \n";
			strSql += " 					sum(nvl(a.budg_month_assign_amt, 0))  budg_month_assign_amt,  \n";
			strSql += " 			   		sum(nvl(a.chg_amt,0)) CHG_AMT	 \n";
			strSql += " 			from \n";
			strSql += " 				( \n";
			strSql += " 				select  \n";
			strSql += "						   a.comp_code, \n";
			strSql += "						   a.clse_acc_id, \n";
			strSql += "						   a.dept_code,\n";
			strSql += "						   a.budg_code_no,\n";
			strSql += "						   a.budg_ym,\n";
			strSql += "						   a.budg_month_assign_amt,\n";
			strSql += "						   (a.budg_month_assign_amt - b.budg_month_assign_amt) chg_amt \n";
			strSql += "					from   t_budg_month_amt a,\n";
			strSql += "						   t_budg_month_amt_h b \n";
			strSql += "					where  a.comp_code = b.comp_code \n";
			strSql += "					and	   a.clse_acc_id = b.clse_acc_id \n";
			strSql += "					and	   a.dept_code = b.dept_code \n";
			strSql += "					and	   a.budg_code_no = b.budg_code_no \n";
			strSql += "					and	   a.reserved_seq = b.reserved_seq \n";
			strSql += "					and	   b.chg_seq = 0 \n";
			strSql += "					and	   a.budg_ym = b.budg_ym \n";
			strSql += " 				) a,  \n";
			strSql += " 				t_budg_code b, \n";
			strSql += " 				t_budg_dept_map c \n";
			strSql += " 			where   a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 			and	  a.dept_code	  = c.dept_code(+) \n";
			strSql += " 			and   a.comp_code     =  '" + strCOMP_CODE + "'  \n";
			strSql += " 			and	  a.clse_acc_id   =  '" + strCLSE_ACC_ID + "'  \n";
			strSql += " 			and   a.budg_ym       = '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  || '-01' \n";
			strSql += " 			group  by \n";
			strSql += " 				    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, ''), \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, ''),     \n";
			strSql += " 					b.p_budg_code_no, \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					b.acc_code \n";
			strSql += " 			) a3, \n";
			strSql += " 			--당월- 전체부서 \n";
			strSql += " 			( \n";
			strSql += " 			 SELECT  \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 					b.ACC_CODE,  \n";
			strSql += " 					SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 			 FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 				    T_ACC_SLIP_BODY b,  \n";
			strSql += " 				    T_DEPT_CODE c                                              \n";
			strSql += " 			 WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 			 AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 			 and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 			 and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 			 and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 			 group by decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''),  \n";
			strSql += " 					  b.ACC_CODE   					   \n";
			strSql += " 			) a4, \n";
			strSql += " 			( \n";
			strSql += " 			 SELECT  \n";
			strSql += " 					decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 					b.ACC_CODE,  \n";
			strSql += " 					SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) no_SIL_AMT   \n";
			strSql += " 			 FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 				    T_ACC_SLIP_BODY b,  \n";
			strSql += " 				    T_DEPT_CODE c                                              \n";
			strSql += " 			 WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 			 AND    a.KEEP_SLIPNO is  null                                                                     \n";
			strSql += " 			 and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 			 and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 			 and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 			 group by decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''),  \n";
			strSql += " 					  b.ACC_CODE   					   \n";
			strSql += " 			) a4_1 \n";
			strSql += " 			 \n";
			strSql += " 	where a1.acc_code = a2.acc_code(+) \n";
			strSql += " 	and   a1.acc_code = a2_1.acc_code(+) \n";
			strSql += " 	and   a3.acc_code = a4.acc_code(+) \n";
			strSql += " 	and   a3.acc_code = a4_1.acc_code(+)			 \n";
			strSql += " 	and   a3.acc_code = a1.acc_code(+) \n";
			strSql += " 	and	  a3.p_budg_code_no = a1.p_budg_code_no(+) \n";
			strSql += " 	and	  a3.budg_code_no = a1.budg_code_no(+) \n";
			strSql += " 	 \n";
			strSql += " 	union \n";
			strSql += " 	 \n";
			strSql += " 	select \n";
			strSql += " 		  '12' div, \n";
			strSql += " 		  decode('" + strDEPT_FLAG + "' , 'CHK_DEPT', chk_dept_code, 'DEPT', chk_dept_code, '') chk_dept_code, \n";
			strSql += " 		  decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', dept_code, '') dept_code, \n";
			strSql += " 		  p_budg_code_no, \n";
			strSql += " 		  1000000000000 budg_code_no, \n";
			strSql += " 		  '1000000000000' acc_code, \n";
			strSql += " 		  sum(budg_assign_amt_sum) budg_assign_amt_sum, \n";
			strSql += " 		  sum(chg_amt_sum) chg_amt_sum, \n";
			strSql += " 		  sum(sil_amt_sum) sil_amt_sum, \n";
			strSql += " 		  sum(no_sil_amt_sum) no_sil_amt_sum, \n";
			strSql += " 		  sum(budg_assign_amt) budg_assign_amt, \n";
			strSql += " 		  sum(chg_amt) chg_amt, \n";
			strSql += " 		  sum(sil_amt) sil_amt, \n";
			strSql += " 		  sum(no_sil_amt) no_sil_amt \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select	 \n";
			strSql += " 				decode('" + strDEPT_FLAG + "' , 'CHK_DEPT', a3.chk_dept_code, 'DEPT', a3.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 				decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a3.dept_code, '') dept_code, \n";
			strSql += " 				a3.p_budg_code_no, \n";
			strSql += " 				a3.budg_code_no, \n";
			strSql += " 				a3.acc_code, \n";
			strSql += " 				nvl(a1.budg_assign_amt_sum,0) budg_assign_amt_sum, \n";
			strSql += " 				nvl(a1.chg_amt_sum,0) chg_amt_sum, \n";
			strSql += " 				nvl(a2.sil_amt_sum,0) sil_amt_sum, \n";
			strSql += " 				nvl(a2_1.no_sil_amt_sum,0) no_sil_amt_sum, \n";
			strSql += " 				nvl(a3.budg_assign_amt,0) budg_assign_amt, \n";
			strSql += " 				nvl(a3.chg_amt,0) chg_amt, \n";
			strSql += " 				nvl(a4.sil_amt,0) sil_amt, \n";
			strSql += " 				nvl(a4_1.no_sil_amt,0) no_sil_amt \n";
			strSql += " 		from \n";
			strSql += " 				--누적예산, 추가  \n";
			strSql += " 				(select  \n";
			strSql += " 						 \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, '') dept_code, \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code, \n";
			strSql += " 						sum(nvl(a.budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT_SUM,  \n";
			strSql += " 				   		sum(nvl(a.chg_amt,0)) CHG_AMT_SUM	 \n";
			strSql += " 				from \n";
			strSql += " 					( \n";
			strSql += " 					select  \n";
			strSql += "						   a.comp_code, \n";
			strSql += "						   a.clse_acc_id, \n";
			strSql += "						   a.dept_code,\n";
			strSql += "						   a.budg_code_no,\n";
			strSql += "						   a.budg_ym,\n";
			strSql += "						   a.budg_month_assign_amt,\n";
			strSql += "						   (a.budg_month_assign_amt - b.budg_month_assign_amt) chg_amt \n";
			strSql += "					from   t_budg_month_amt a,\n";
			strSql += "						   t_budg_month_amt_h b \n";
			strSql += "					where  a.comp_code = b.comp_code \n";
			strSql += "					and	   a.clse_acc_id = b.clse_acc_id \n";
			strSql += "					and	   a.dept_code = b.dept_code \n";
			strSql += "					and	   a.budg_code_no = b.budg_code_no \n";
			strSql += "					and	   a.reserved_seq = b.reserved_seq \n";
			strSql += "					and	   b.chg_seq = 0 \n";
			strSql += "					and	   a.budg_ym = b.budg_ym \n";
			strSql += " 					) a,  \n";
			strSql += " 					t_budg_code b, \n";
			strSql += " 					t_budg_dept_map c \n";
			strSql += " 				where a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 				and	  a.dept_code 	  = c.dept_code(+) \n";
			strSql += " 				and   a.comp_code     = '" + strCOMP_CODE + "'  \n";
			strSql += " 				and	  a.clse_acc_id   =  '" + strCLSE_ACC_ID + "'  \n";
			strSql += " 				and   a.budg_ym between  '" + strCLSE_ACC_ID + "'  || '01-01' and  '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'   || '-01' \n";
			strSql += " 				group  by \n";
			strSql += " 					    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, ''), \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, ''),     \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code \n";
			strSql += " 				) a1, \n";
			strSql += " 				--누적실적 - 전체부서 \n";
			strSql += " 				(		  \n";
			strSql += " 				SELECT  \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 						b.ACC_CODE,  \n";
			strSql += " 						SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 				FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					   T_ACC_SLIP_BODY b,  \n";
			strSql += " 					   T_DEPT_CODE c                                              \n";
			strSql += " 				WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 				and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( '" + strCLSE_ACC_ID + "'  || '-' || '01' ,'-','')  and replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 				and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 				and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 				group by	decode('" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 							b.ACC_CODE  				   \n";
			strSql += " 				) a2, \n";
			strSql += " 				--누적실적 - 미확정 \n";
			strSql += " 				(		  \n";
			strSql += " 				SELECT  \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 						b.ACC_CODE,  \n";
			strSql += " 						SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) no_SIL_AMT_SUM   \n";
			strSql += " 				FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					   T_ACC_SLIP_BODY b,  \n";
			strSql += " 					   T_DEPT_CODE c                                              \n";
			strSql += " 				WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				AND    a.KEEP_SLIPNO is null                                                                     \n";
			strSql += " 				and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( '" + strCLSE_ACC_ID + "'  || '-' || '01' ,'-','')  and replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 				and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 				and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 				group by	decode('" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 							b.ACC_CODE  				   \n";
			strSql += " 				) a2_1, \n";
			strSql += " 				(select  \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, '') dept_code, \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code, \n";
			strSql += " 						sum(nvl(a.budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT,  \n";
			strSql += " 				   		sum(nvl(a.chg_amt,0)) CHG_AMT \n";
			strSql += " 				from \n";
			strSql += " 					( \n";
			strSql += " 					select  \n";
			strSql += "						   a.comp_code, \n";
			strSql += "						   a.clse_acc_id, \n";
			strSql += "						   a.dept_code,\n";
			strSql += "						   a.budg_code_no,\n";
			strSql += "						   a.budg_ym,\n";
			strSql += "						   a.budg_month_assign_amt,\n";
			strSql += "						   (a.budg_month_assign_amt - b.budg_month_assign_amt) chg_amt \n";
			strSql += "					from   t_budg_month_amt a,\n";
			strSql += "						   t_budg_month_amt_h b \n";
			strSql += "					where  a.comp_code = b.comp_code \n";
			strSql += "					and	   a.clse_acc_id = b.clse_acc_id \n";
			strSql += "					and	   a.dept_code = b.dept_code \n";
			strSql += "					and	   a.budg_code_no = b.budg_code_no \n";
			strSql += "					and	   a.reserved_seq = b.reserved_seq \n";
			strSql += "					and	   b.chg_seq = 0 \n";
			strSql += "					and	   a.budg_ym = b.budg_ym \n";
			strSql += " 					) a,  \n";
			strSql += " 					t_budg_code b, \n";
			strSql += " 					t_budg_dept_map c \n";
			strSql += " 				where a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 				and	  a.dept_code     = c.dept_code(+) \n";
			strSql += " 				and   a.comp_code     =  '" + strCOMP_CODE + "'  \n";
			strSql += " 				and	  a.clse_acc_id   =  '" + strCLSE_ACC_ID + "'  \n";
			strSql += " 				and   a.budg_ym       = '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  || '-01' \n";
			strSql += " 				group  by   \n";
			strSql += " 					    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, ''), \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, ''),   \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code \n";
			strSql += " 				) a3, \n";
			strSql += " 				--누적실적 - 전체부서 \n";
			strSql += " 				( \n";
			strSql += " 					 \n";
			strSql += " 				SELECT   \n";
			strSql += " 					    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code, \n";
			strSql += " 						b.ACC_CODE,  \n";
			strSql += " 						SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 				FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					   T_ACC_SLIP_BODY b,  \n";
			strSql += " 					   T_DEPT_CODE c                                              \n";
			strSql += " 				WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 				and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 				and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 				and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 				GROUP BY decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''),  \n";
			strSql += " 						 b.ACC_CODE  				   \n";
			strSql += " 				) a4, \n";
			strSql += " 				--누적실적 - 전체부서 \n";
			strSql += " 				( \n";
			strSql += " 					 \n";
			strSql += " 				SELECT   \n";
			strSql += " 					    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code, \n";
			strSql += " 						b.ACC_CODE,  \n";
			strSql += " 						SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) no_SIL_AMT   \n";
			strSql += " 				FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					   T_ACC_SLIP_BODY b,  \n";
			strSql += " 					   T_DEPT_CODE c                                              \n";
			strSql += " 				WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				AND    a.KEEP_SLIPNO is null                                                                     \n";
			strSql += " 				and    SUBSTR(a.MAKE_DT_TRANS,1,6) = replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 				and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 				and    b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 				GROUP BY decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''),  \n";
			strSql += " 						 b.ACC_CODE  				   \n";
			strSql += " 				) a4_1 \n";
			strSql += " 				 \n";
			strSql += " 		where a1.acc_code = a2.acc_code(+) \n";
			strSql += " 		and   a1.acc_code = a2_1.acc_code(+) \n";
			strSql += " 		and   a3.acc_code = a4.acc_code(+) \n";
			strSql += " 		and   a3.acc_code = a4_1.acc_code(+)			 \n";
			strSql += " 		and   a3.acc_code = a1.acc_code(+) \n";
			strSql += " 		and	  a3.p_budg_code_no = a1.p_budg_code_no(+) \n";
			strSql += " 		and	  a3.budg_code_no = a1.budg_code_no(+) \n";
			strSql += " 	) a \n";
			strSql += " 	group by  \n";
			strSql += " 		  	 decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', a.chk_dept_code, 'DEPT', a.chk_dept_code, ''), \n";
			strSql += " 			 decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, ''), \n";
			strSql += " 		  	 a.p_budg_code_no \n";
			strSql += " 			  \n";
			strSql += " 	union \n";
			strSql += " 	 \n";
			strSql += " 	select \n";
			strSql += " 		  '13' div, \n";
			strSql += " 		  '' chk_dept_code, \n";
			strSql += " 		  '' dept_code, \n";
			strSql += " 		  1000000000000 p_budg_code_no, \n";
			strSql += " 		  1000000000000 budg_code_no, \n";
			strSql += " 		  '1000000000000' acc_code, \n";
			strSql += " 		  sum(budg_assign_amt_sum) budg_assign_amt_sum, \n";
			strSql += " 		  sum(chg_amt_sum) chg_amt_sum, \n";
			strSql += " 		  sum(sil_amt_sum) sil_amt_sum, \n";
			strSql += " 		  sum(no_sil_amt_sum) no_amt_sum, \n";
			strSql += " 		  sum(budg_assign_amt) budg_assign_amt, \n";
			strSql += " 		  sum(chg_amt) chg_amt, \n";
			strSql += " 		  sum(sil_amt) sil_amt, \n";
			strSql += " 		  sum(no_sil_amt) no_sil_amt \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select	 \n";
			strSql += " 				a3.p_budg_code_no, \n";
			strSql += " 				a3.budg_code_no, \n";
			strSql += " 				a3.acc_code, \n";
			strSql += " 				nvl(a1.budg_assign_amt_sum,0) budg_assign_amt_sum, \n";
			strSql += " 				nvl(a1.chg_amt_sum,0) chg_amt_sum, \n";
			strSql += " 				nvl(a2.sil_amt_sum,0) sil_amt_sum, \n";
			strSql += " 				nvl(a2_1.no_sil_amt_sum,0) no_sil_amt_sum, \n";
			strSql += " 				nvl(a3.budg_assign_amt,0) budg_assign_amt, \n";
			strSql += " 				nvl(a3.chg_amt,0) chg_amt, \n";
			strSql += " 				nvl(a4.sil_amt,0) sil_amt, \n";
			strSql += " 				nvl(a4_1.no_sil_amt,0) no_sil_amt \n";
			strSql += " 		from \n";
			strSql += " 				--누적예산, 추가  \n";
			strSql += " 				(select  \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, '') dept_code, \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code, \n";
			strSql += " 						sum(nvl(a.budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT_SUM,  \n";
			strSql += " 				   		sum(nvl(a.chg_amt,0)) CHG_AMT_SUM	 \n";
			strSql += " 				from \n";
			strSql += " 					( \n";
			strSql += " 					select  \n";
			strSql += "						   a.comp_code, \n";
			strSql += "						   a.clse_acc_id, \n";
			strSql += "						   a.dept_code,\n";
			strSql += "						   a.budg_code_no,\n";
			strSql += "						   a.budg_ym,\n";
			strSql += "						   a.budg_month_assign_amt,\n";
			strSql += "						   (a.budg_month_assign_amt - b.budg_month_assign_amt) chg_amt \n";
			strSql += "					from   t_budg_month_amt a,\n";
			strSql += "						   t_budg_month_amt_h b \n";
			strSql += "					where  a.comp_code = b.comp_code \n";
			strSql += "					and	   a.clse_acc_id = b.clse_acc_id \n";
			strSql += "					and	   a.dept_code = b.dept_code \n";
			strSql += "					and	   a.budg_code_no = b.budg_code_no \n";
			strSql += "					and	   a.reserved_seq = b.reserved_seq \n";
			strSql += "					and	   b.chg_seq = 0 \n";
			strSql += "					and	   a.budg_ym = b.budg_ym \n";
			strSql += " 					) a,  \n";
			strSql += " 					t_budg_code b, \n";
			strSql += " 					t_budg_dept_map c \n";
			strSql += " 				where a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 				and	  a.dept_code	  = c.dept_code(+) \n";
			strSql += " 				and   a.comp_code     =  '" + strCOMP_CODE + "'  \n";
			strSql += " 				and	  a.clse_acc_id   =  '" + strCLSE_ACC_ID + "'  \n";
			strSql += " 				and   a.budg_ym between  '" + strCLSE_ACC_ID + "'  || '01-01' and  '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  || '-01' \n";
			strSql += " 				group  by \n";
			strSql += " 					       decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, ''), \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, ''),     \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code \n";
			strSql += " 				) a1, \n";
			strSql += " 				--누적실적 - 전체부서 \n";
			strSql += " 				( \n";
			strSql += "  \n";
			strSql += " 				 SELECT  \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 					    b.ACC_CODE,  \n";
			strSql += " 					    SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT_SUM   \n";
			strSql += " 				 FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					    T_ACC_SLIP_BODY b,  \n";
			strSql += " 					    T_DEPT_CODE c                                              \n";
			strSql += " 				 WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				 AND    a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 				 and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( '" + strCLSE_ACC_ID + "'  || '-' || '01' ,'-','')  and replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 				 and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 				 and    b.DEPT_CODE = c.DEPT_CODE                                                                       \n";
			strSql += " 				 GROUP BY  decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 					       b.ACC_CODE  					   \n";
			strSql += " 				) a2, \n";
			strSql += " 				--누적실적 - 미확정 \n";
			strSql += " 				( \n";
			strSql += "  \n";
			strSql += " 				 SELECT  \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 					    b.ACC_CODE,  \n";
			strSql += " 					    SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) no_SIL_AMT_SUM   \n";
			strSql += " 				 FROM   T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					    T_ACC_SLIP_BODY b,  \n";
			strSql += " 					    T_DEPT_CODE c                                              \n";
			strSql += " 				 WHERE  a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				 AND    a.KEEP_SLIPNO is null                                                                     \n";
			strSql += " 				 and    SUBSTR(a.MAKE_DT_TRANS,1,6) between replace( '" + strCLSE_ACC_ID + "'  || '-' || '01' ,'-','')  and replace( '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  ,'-','') \n";
			strSql += " 				 and    c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                      \n";
			strSql += " 				 and    b.DEPT_CODE = c.DEPT_CODE                                                                       \n";
			strSql += " 				 GROUP BY  decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 					       b.ACC_CODE  					   \n";
			strSql += " 				) a2_1, \n";
			strSql += " 				(select  \n";
			strSql += "  \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, '') dept_code, \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code, \n";
			strSql += " 						sum(nvl(a.budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT,  \n";
			strSql += " 				   		sum(nvl(a.chg_amt,0)) CHG_AMT \n";
			strSql += " 				from \n";
			strSql += " 					( \n";
			strSql += " 				select  \n";
			strSql += "						   a.comp_code, \n";
			strSql += "						   a.clse_acc_id, \n";
			strSql += "						   a.dept_code,\n";
			strSql += "						   a.budg_code_no,\n";
			strSql += "						   a.budg_ym,\n";
			strSql += "						   a.budg_month_assign_amt,\n";
			strSql += "						   (a.budg_month_assign_amt - b.budg_month_assign_amt) chg_amt \n";
			strSql += "					from   t_budg_month_amt a,\n";
			strSql += "						   t_budg_month_amt_h b \n";
			strSql += "					where  a.comp_code = b.comp_code \n";
			strSql += "					and	   a.clse_acc_id = b.clse_acc_id \n";
			strSql += "					and	   a.dept_code = b.dept_code \n";
			strSql += "					and	   a.budg_code_no = b.budg_code_no \n";
			strSql += "					and	   a.reserved_seq = b.reserved_seq \n";
			strSql += "					and	   b.chg_seq = 0 \n";
			strSql += "					and	   a.budg_ym = b.budg_ym \n";
			strSql += " 					) a,  \n";
			strSql += " 					t_budg_code b, \n";
			strSql += " 					t_budg_dept_map c \n";
			strSql += " 				where a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 				and	  a.dept_code	  = c.dept_code(+) \n";
			strSql += " 				and   a.comp_code     =  '" + strCOMP_CODE + "'  \n";
			strSql += " 				and	  a.clse_acc_id   =  '" + strCLSE_ACC_ID + "'  \n";
			strSql += " 				and   a.budg_ym       = '" + strCLSE_ACC_ID + "'  || '-' ||  '" + strMONTH + "'  || '-01' \n";
			//strSql += " 				and   decode( '" + strDEPT_FLAG + "', 'CHK_DEPT', c.chk_dept_code, 'DEPT', a.dept_code, 'ALL', '') like '%' || '" + strDEPT_CODE + "' || '%' \n";
			strSql += " 				group  by \n";
			strSql += " 					    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', c.chk_dept_code, 'DEPT', c.chk_dept_code, ''), \n";
			strSql += " 					    decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', '', 'DEPT', a.dept_code, ''),     \n";
			strSql += " 						b.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						b.acc_code \n";
			strSql += " 				) a3, \n";
			strSql += " 				--누적실적 - 전체부서 \n";
			strSql += " 				( \n";
			strSql += " 				SELECT   \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "'  , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 						b.ACC_CODE,  \n";
			strSql += " 						SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) SIL_AMT   \n";
			strSql += " 				FROM    T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					    T_ACC_SLIP_BODY b,  \n";
			strSql += " 						T_DEPT_CODE c                                              \n";
			strSql += " 				WHERE   a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				AND     a.KEEP_SLIPNO is not null                                                                     \n";
			strSql += " 				and     SUBSTR(a.MAKE_DT_TRANS,1,6) = replace('" + strCLSE_ACC_ID + "'   || '-' ||  '" + strMONTH + "'   ,'-','') \n";
			strSql += " 				and     c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                       \n";
			strSql += " 				and     b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 				group by decode( '" + strDEPT_FLAG + "'  , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 					     b.ACC_CODE  					   \n";
			strSql += " 				) a4, \n";
			strSql += " 				--누적실적 - 미확정 \n";
			strSql += " 				( \n";
			strSql += " 				SELECT   \n";
			strSql += " 						decode( '" + strDEPT_FLAG + "'  , 'CHK_DEPT', '', 'DEPT', b.dept_code, '') dept_code,  \n";
			strSql += " 						b.ACC_CODE,  \n";
			strSql += " 						SUM(nvl(b.DB_AMT,0)+nvl(b.CR_AMT,0)) no_sil_amt   \n";
			strSql += " 				FROM    T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					    T_ACC_SLIP_BODY b,  \n";
			strSql += " 						T_DEPT_CODE c                                              \n";
			strSql += " 				WHERE   a.SLIP_ID=b.SLIP_ID                                                                               \n";
			strSql += " 				AND     a.KEEP_SLIPNO is null                                                                     \n";
			strSql += " 				and     SUBSTR(a.MAKE_DT_TRANS,1,6) = replace('" + strCLSE_ACC_ID + "'   || '-' ||  '" + strMONTH + "'   ,'-','') \n";
			strSql += " 				and     c.COMP_CODE =  '" + strCOMP_CODE + "'                                                                                                       \n";
			strSql += " 				and     b.DEPT_CODE=c.DEPT_CODE                                                                       \n";
			strSql += " 				group by decode( '" + strDEPT_FLAG + "'  , 'CHK_DEPT', '', 'DEPT', b.dept_code, ''), \n";
			strSql += " 					     b.ACC_CODE  					   \n";
			strSql += " 				) a4_1 \n";
			strSql += " 				 \n";
			strSql += " 		where a1.acc_code = a2.acc_code(+) \n";
			strSql += " 		and   a1.acc_code = a2_1.acc_code(+) \n";
			strSql += " 		and   a3.acc_code = a4.acc_code(+) \n";
			strSql += " 		and   a3.acc_code = a4_1.acc_code(+)		 \n";
			strSql += " 		and   a3.acc_code = a1.acc_code(+) \n";
			strSql += " 		and	  a3.p_budg_code_no = a1.p_budg_code_no(+) \n";
			strSql += " 		and	  a3.budg_code_no = a1.budg_code_no(+) \n";
			strSql += " 	) a \n";
			strSql += " 		  	 \n";
			strSql += " ) a, \n";
			strSql += " t_budg_code b, \n";
			strSql += " t_acc_code  c, \n";
			strSql += " t_dept_code d1, \n";
			strSql += " t_dept_code d2 \n";
			strSql += " where a.p_budg_code_no = b.budg_code_no(+) \n";
			strSql += " and	  a.acc_code = c.acc_code(+) \n";
			strSql += " and	  a.chk_dept_code = d1.dept_code(+) \n";
			strSql += " and	  a.dept_code     = d2.dept_code(+) \n";
			strSql += " --and	  c.budg_exec_cls = 'T' \n";
			strSql += " and (decode( '" + strDEPT_FLAG + "' , 'CHK_DEPT', a.chk_dept_code, 'DEPT', a.dept_code, 'ALL', '') like '%' || '" + strDEPT_CODE + "'  || '%' \n";
			strSql += " 	 or a.chk_dept_code is null) \n";
			strSql += " 	and a.budg_assign_amt_sum is not null \n";
			strSql += " order by  2, 4, 6,7,8, 1 \n";
			
			
			
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
