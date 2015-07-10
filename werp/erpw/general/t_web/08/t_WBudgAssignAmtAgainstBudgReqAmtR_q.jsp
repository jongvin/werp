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
				strSql += "	and a.DEPT_CODE = b.DEPT_CODE \n";

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
			String vCompCode = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String vDeptCode = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String vBudgYyyyMmFr = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_FR"));
			String vBudgYyyyMmTo = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_TO"));
			String vDeptFlag = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
	
			
			strSql  = " select \n";
			strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) CHK_DEPT_CODE,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code, \n";
			strSql += " 		(                                                                      					\n";         
			strSql += " 		CASE '"+vDeptFlag+"' WHEN 'CHK_DEPT'	THEN a.CHK_DEPT_NAME      \n";               
	 		strSql += " 		WHEN 'DEPT'		THEN a.CHK_DEPT_NAME                           \n";         
			strSql += " 		ELSE '' END                                             				\n";
			strSql += " 		) CHK_DEPT_NAME, \n";
			strSql += " 		(                                                                      					\n";         
			strSql += " 		CASE '"+vDeptFlag+"' WHEN 'CHK_DEPT'	THEN ''      \n";               
	 		strSql += " 		WHEN 'DEPT'		THEN a.DEPT_NAME                           \n";         
			strSql += " 		ELSE '' END                                             				\n";
			strSql += " 		) DEPT_NAME, \n";
			strSql += " 		a.p_budg_code_no, \n";
			strSql += " 		b.budg_code_name p_acc_name, \n";
			strSql += " 		a.ACC_CODE, \n";
			strSql += " 		a.ACC_NAME, \n";
			strSql += " 		re1, \n";
			strSql += " 		as1, \n";
			strSql += " 		to_char(  (nvl(as1,0)/ decode( nvl(re1,0),'0',1, re1) )*100, '999.99') r1 \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select \n";
			strSql += " 		   '11' div, \n";
			strSql += " 		   a.comp_code, \n";
			strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) CHK_DEPT_CODE,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) CHK_DEPT_NAME,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code, \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) dept_name, \n";
		   	strSql += " 		   a.p_budg_code_no, \n";
			strSql += " 		   a.ACC_CODE, \n";
			strSql += " 		   a.ACC_NAME,                                                                                                                                          			  \n";
			strSql += " 		   sum(  nvl(a.BUDG_REQ_AMT,0)   ) re1,  \n";
			strSql += " 		   sum(  nvl(a.BUDG_ASSIGN_AMT,0)    ) as1 \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select  \n";
			strSql += " 			   a.comp_code, \n";
			strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) CHK_DEPT_CODE, \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) CHK_DEPT_NAME, \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code,  \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) dept_name, \n";
			strSql += " 		          a.p_budg_code_no, \n";
			strSql += " 			   a.ACC_CODE, \n";
			strSql += " 			   b.ACC_NAME,  \n";
			strSql += " 			   sum(budg_month_req_amt) BUDG_REQ_AMT, \n";
			strSql += " 			   sum(budg_month_assign_amt) BUDG_ASSIGN_AMT \n";
			strSql += " 		from  \n";
			strSql += " 			(select \n";
			strSql += " 				  a.comp_code, \n";
			strSql += " 				  a.clse_acc_id, \n";
			strSql += " 				  a.dept_code, \n";
			strSql += " 				  a.reserved_seq, \n";
			strSql += " 				  c.p_budg_code_no, \n";
			strSql += " 				  nvl(a.budg_item_req_amt,0) budg_item_req_amt, \n";
			strSql += " 				  nvl(a.budg_item_assign_amt,0) budg_item_assign_amt, \n";
			strSql += " 				  nvl(a.budg_item_req_amt_a,0) budg_item_req_amt_a, \n";
			strSql += " 				  b.budg_ym, \n";
			strSql += " 				  nvl(b.budg_month_req_amt,0) budg_month_req_amt, \n";
			strSql += " 				  nvl(b.budg_month_assign_amt,0) budg_month_assign_amt, \n";
			strSql += " 				  nvl(b.budg_month_req_amt_a,0) budg_month_req_amt_a, \n";
			strSql += " 				  c.acc_code \n";
			strSql += " 			from  t_budg_dept_item a, \n";
			strSql += " 				  t_budg_month_amt b, \n";
			strSql += " 				  (select * from t_budg_code where comp_code = '" +vCompCode  +"') c \n";
			strSql += " 			where a.comp_code = b.comp_code \n";
			strSql += " 			and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 			and	  a.dept_code = b.dept_code \n";
			strSql += " 			and	  a.budg_code_no = b.budg_code_no \n";
			strSql += " 			and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 			and	  a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += " 			) a, \n";
			strSql += " 			t_acc_code b, \n";
			strSql += " 			(select a.comp_code, \n";
			strSql += " 					a.company_name, \n";
			strSql += " 					b.dept_code, \n";
			strSql += " 					b.dept_name \n";
			strSql += " 			 from t_company a, \n";
			strSql += " 			  	  t_dept_code b \n";
			strSql += " 			 where a.COMP_CODE = b.comp_code \n";
			strSql += " 			 and   a.comp_code = '"+vCompCode+"' \n";
			strSql += " 			) d, \n";
			strSql += " 			( \n";
			strSql += " 			select b.dept_code, \n";
			strSql += " 				   chk_dept_code, \n";
			strSql += " 				   dept_name chk_dept_name \n";	    
			strSql += " 			from  t_dept_code a, \n";
			strSql += " 				  t_budg_dept_map b	\n";  
			strSql += " 			where a.dept_code = b.chk_dept_code \n";
			strSql += " 			and   budg_cls='T' \n";
			strSql += " 			) e \n";
			strSql += " 		where a.acc_code  = b.acc_code(+) \n";
			strSql += " 		and	  a.comp_code = d.comp_code(+)  \n";
			strSql += " 		and	  a.dept_code = d.dept_code(+)  \n";
			strSql += " 		and	  a.dept_code = e.dept_code(+) \n";
			strSql += " 		and to_char(a.budg_ym,'yyyy-mm') between '"+vBudgYyyyMmFr+"' and '"+vBudgYyyyMmTo+"'\n";
			strSql += " 		group  by \n";
			strSql += " 		 	   a.comp_code, \n";
			strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) , \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) , \n";
			strSql += " 			   a.p_budg_code_no, \n";
			strSql += " 			   a.ACC_CODE, \n";
			strSql += " 			   b.ACC_NAME \n";
			strSql += " 	 	) a \n";
			strSql += " 	group by  \n";
			strSql += " 		  	 a.comp_code, \n";
			strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) ,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) , \n";
		   	strSql += " 	          a.p_budg_code_no, \n";
			strSql += " 		   a.ACC_CODE, \n";
			strSql += " 		   a.ACC_NAME                                                                                                                                          			  \n";
			strSql += " 	union  \n";
			strSql += " 	select \n";
			strSql += " 		   '12' div, \n";
			strSql += " 		   a.comp_code, \n";
			strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) CHK_DEPT_CODE,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) CHK_DEPT_NAME,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code, \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) dept_name, \n";
		   	strSql += " 		   a.p_budg_code_no, \n";
			strSql += " 		   ''  ACC_CODE, \n";
			strSql += " 		   '소계'  ACC_NAME,                                                                                                                                          			  \n";
			strSql += " 		   sum(  nvl(a.BUDG_REQ_AMT,0)   ) re1,  \n";
			strSql += " 		   sum(  nvl(a.BUDG_ASSIGN_AMT,0)    ) as1 \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select  \n";
			strSql += " 			   a.comp_code, \n";
			strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) CHK_DEPT_CODE, \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) CHK_DEPT_NAME, \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code,  \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) dept_name, \n";
			strSql += " 		          a.p_budg_code_no, \n";
			strSql += " 			   a.ACC_CODE, \n";
			strSql += " 			   b.ACC_NAME,  \n";
			strSql += " 			   sum(budg_month_req_amt) BUDG_REQ_AMT, \n";
			strSql += " 			   sum(budg_month_assign_amt) BUDG_ASSIGN_AMT \n";
			strSql += " 		from  \n";
			strSql += " 			(select \n";
			strSql += " 				  a.comp_code, \n";
			strSql += " 				  a.clse_acc_id, \n";
			strSql += " 				  a.dept_code, \n";
			strSql += " 				  a.reserved_seq, \n";
			strSql += " 				  c.p_budg_code_no, \n";
			strSql += " 				  nvl(a.budg_item_req_amt,0) budg_item_req_amt, \n";
			strSql += " 				  nvl(a.budg_item_assign_amt,0) budg_item_assign_amt, \n";
			strSql += " 				  nvl(a.budg_item_req_amt_a,0) budg_item_req_amt_a, \n";
			strSql += " 				  b.budg_ym, \n";
			strSql += " 				  nvl(b.budg_month_req_amt,0) budg_month_req_amt, \n";
			strSql += " 				  nvl(b.budg_month_assign_amt,0) budg_month_assign_amt, \n";
			strSql += " 				  nvl(b.budg_month_req_amt_a,0) budg_month_req_amt_a, \n";
			strSql += " 				  c.acc_code \n";
			strSql += " 			from  t_budg_dept_item a, \n";
			strSql += " 				  t_budg_month_amt b, \n";
			strSql += " 				  (select * from t_budg_code where comp_code = '" +vCompCode  +"') c \n";
			strSql += " 			where a.comp_code = b.comp_code \n";
			strSql += " 			and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 			and	  a.dept_code = b.dept_code \n";
			strSql += " 			and	  a.budg_code_no = b.budg_code_no \n";
			strSql += " 			and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 			and	  a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += " 			) a, \n";
			strSql += " 			t_acc_code b, \n";
			strSql += " 			(select a.comp_code, \n";
			strSql += " 					a.company_name, \n";
			strSql += " 					b.dept_code, \n";
			strSql += " 					b.dept_name \n";
			strSql += " 			 from t_company a, \n";
			strSql += " 			  	  t_dept_code b \n";
			strSql += " 			 where a.COMP_CODE = b.comp_code \n";
			strSql += " 			 and   a.comp_code = '"+vCompCode+"' \n";
			strSql += " 			) d, \n";
			strSql += " 			( \n";
			strSql += " 			select b.dept_code, \n";
			strSql += " 				   chk_dept_code, \n";
			strSql += " 				   dept_name chk_dept_name \n";	    
			strSql += " 			from  t_dept_code a, \n";
			strSql += " 				  t_budg_dept_map b	\n";  
			strSql += " 			where a.dept_code = b.chk_dept_code \n";
			strSql += " 			and   budg_cls='T' \n";
			strSql += " 			) e \n";
			strSql += " 		where a.acc_code  = b.acc_code(+) \n";
			strSql += " 		and	  a.comp_code = d.comp_code(+)  \n";
			strSql += " 		and	  a.dept_code = d.dept_code(+)  \n";
			strSql += " 		and	  a.dept_code = e.dept_code(+) \n";
			strSql += " 		and to_char(a.budg_ym,'yyyy-mm') between '"+vBudgYyyyMmFr+"' and '"+vBudgYyyyMmTo+"'\n";
			strSql += " 		group  by \n";
			strSql += " 		 	   a.comp_code, \n";
			strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) , \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) , \n";
			strSql += " 			   a.p_budg_code_no, \n";
			strSql += " 			   a.ACC_CODE, \n";
			strSql += " 			   b.ACC_NAME \n";
			strSql += " 	 	) a \n";
			strSql += " 	group by  \n";
			strSql += " 		  	 a.comp_code, \n";
			strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) ,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) , \n";
		   	strSql += " 	          a.p_budg_code_no \n";
			strSql += " 	) a,  	  \n";
			strSql += " 	 (select * from t_budg_code where comp_code = '" +vCompCode  +"') b  	  \n";
			strSql += " 	where a.p_budg_code_no = b.budg_code_no(+)  \n";
			//if (vDeptFlag.equals("ALL"))
			//{
				//strSql += " 	and a.dept_code is null  				\n";
			//}
			///else
			//{
				strSql += " 	and (decode('"+vDeptFlag+"', 'CHK_DEPT', a.chk_dept_code, 'DEPT', a.dept_code, a.dept_code) like '%' ||  '"+vDeptCode+"' || '%' or a.chk_dept_code is null )   \n";
			//}
			strSql += " 		order by  				\n";
			strSql += " 			     dept_code,  	\n";
			strSql += " 	                   a.p_budg_code_no, \n";
			strSql += " 	                   a.div, \n";
			strSql += " 			     acc_code  \n";
			strSql += "  	 ";



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
