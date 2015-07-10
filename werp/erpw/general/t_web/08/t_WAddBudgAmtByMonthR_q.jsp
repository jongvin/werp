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
			strSql  += "From	T_COMPANY A ,\n";
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
				strSql += "from T_DEPT_CODE_ORG a, \n";
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

		else if (strAct.equals("LIST01"))
		{
			String vCompCode = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String DEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			strSql  = "select \n";
			strSql += "	'"+vCompCode+"' COMP_CODE, \n";
			strSql += "	'***' DEPT_CODE, \n";
			strSql += "	'***' PROJECT_CODE, \n";
			strSql += "	'전  체' PROJECT_NAME \n";
			strSql += "from dual a \n";
			strSql += "union all \n";
			strSql += "SELECT         \n";
			strSql += "	'"+vCompCode+"' COMP_CODE, \n";
			strSql += "	DEPT_CODE,    \n";
			strSql += "	PROJECT_CODE, \n";
			strSql += "	PROJECT_NAME  \n";
			strSql += "FROM TBA_PROJECT_CODE \n";
			strSql += "WHERE \n";
			strSql += "     DEPT_CODE = ? \n";
			strSql += "     AND DEL_CLS = 'T' \n";

			lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("DEPT_CODE",DEPT_CODE);
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

		
		//전체
		else if (strAct.equals("LIST02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE  = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strDEPT_FLAG  = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
			String strBUDG_YYYY_MM_FR  = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_FR"));
			String strBUDG_YYYY_MM_TO = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_TO"));
			
			String strCLSE_ACC_ID = strBUDG_YYYY_MM_FR.substring(0,4);
			
			strSql  = " select	 \n";
			strSql += " 		div, \n";
			strSql += " 		decode( '" +strDEPT_FLAG  +"' , 'CHK_DEPT',a.chk_dept_code,'DEPT', a.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 		d1.dept_name chk_dept_name, \n";
			strSql += " 		decode( '" + strDEPT_FLAG +"' , 'DEPT',a.dept_code, '') dept_code, \n";
			strSql += " 		d2.dept_name, \n";
			strSql += " 		a.p_budg_code_no, \n";
			strSql += " 		b.budg_code_name p_acc_name, \n";
			strSql += " 		a.budg_code_no, \n";
			strSql += " 		a.acc_code, \n";
			strSql += " 		decode(div, '12', '소계', c.acc_name) acc_name, \n";
			strSql += " 		first_budg_amt, \n";
			strSql += " 		add_budg_amt, \n";
			strSql += " 		a.budg_amt \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select  \n";
			strSql += " 		   '11' div, \n";
			strSql += " 		   a.comp_code, \n";
			strSql += " 		   a.clse_acc_id, \n";
			strSql += " 		   decode( '" +strDEPT_FLAG  +"' , 'CHK_DEPT',d.chk_dept_code,'DEPT', d.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 		   decode( '" +strDEPT_FLAG  +"' , 'DEPT',a.dept_code, '') dept_code, \n";
			strSql += " 		   c.p_budg_code_no, \n";
			strSql += " 		   a.budg_code_no, \n";
			strSql += " 		   c.acc_code, \n";
			strSql += " 		   sum(nvl(b.budg_month_assign_amt,0) ) first_budg_amt, \n";
			strSql += " 		   sum(nvl(b2.chg_amt,0) ) 		        add_budg_amt, \n";
			strSql += " 		   sum(nvl(b.budg_month_assign_amt,0) + nvl(b2.chg_amt,0) ) budg_amt \n";
			strSql += " 	from  t_budg_dept_item_h a, \n";
			strSql += " 		  t_budg_month_amt_h b, \n";
			strSql += " 		  t_budg_chg_reason b2, \n";
			strSql += " 		  (select * from t_budg_code where comp_code = '" +strCOMP_CODE  +"' \n";
			strSql += " 		   and acc_code in ( select acc_code from t_acc_code where budg_exec_cls='T')) c, \n";
			strSql += " 		  t_budg_dept_map d \n";
			strSql += " 	where a.comp_code    = b.comp_code \n";
			strSql += " 	and	  a.clse_acc_id  = b.clse_acc_id \n";
			strSql += " 	and	  a.dept_code    = b.dept_code \n";
			strSql += " 	and	  a.chg_seq 	 = b.chg_seq \n";
			strSql += " 	and	  a.budg_code_no = b.budg_code_no \n";
			strSql += " 	and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 	and   b.comp_code    = b2.comp_code(+) \n";
			strSql += " 	and	  b.clse_acc_id  = b2.clse_acc_id(+) \n";
			strSql += " 	and	  b.dept_code    = b2.dept_code(+) \n";
			strSql += " 	and	  b.budg_code_no = b2.budg_code_no(+) \n";
			strSql += " 	and	  b.reserved_seq = b2.reserved_seq(+) \n";
			strSql += " 	and	  b.budg_ym 	 = b2.budg_ym(+) \n";
			strSql += " 	and	  a.budg_code_no = c.budg_code_no \n";
			strSql += " 	and	  a.dept_code	 = d.dept_code \n";
			strSql += " 	and	  a.chg_seq		 = 0 \n";
			strSql += " 	and	  a.comp_code	 =  '" +strCOMP_CODE  +"'  \n";
			strSql += " 	and	  a.clse_acc_id	 =  '" + strCLSE_ACC_ID +"'  \n";
			strSql += " 	and   to_char(b.budg_ym,'yyyy-mm') between  '" + strBUDG_YYYY_MM_FR +"'  and  '" +strBUDG_YYYY_MM_TO  +"'  \n";
			strSql += " 	group by \n";
			strSql += " 		  	a.comp_code, \n";
			strSql += " 		    a.clse_acc_id, \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'CHK_DEPT',d.chk_dept_code,'DEPT', d.chk_dept_code, ''), \n";
			strSql += " 		   	decode( '" + strDEPT_FLAG +"' , 'DEPT',a.dept_code, ''), \n";
			strSql += " 		    c.p_budg_code_no, \n";
			strSql += " 			a.budg_code_no, \n";
			strSql += " 			c.acc_code \n";
			strSql += " 			 \n";
			strSql += " 	union \n";
			strSql += " 	 \n";
			strSql += " 	--소계 \n";
			strSql += " 	 \n";
			strSql += " 	select  \n";
			strSql += " 		   '12' div, \n";
			strSql += " 		   a.comp_code, \n";
			strSql += " 		   a.clse_acc_id, \n";
			strSql += " 		   decode( '" + strDEPT_FLAG +"' , 'CHK_DEPT',d.chk_dept_code,'DEPT', d.chk_dept_code, '') chk_dept_code, \n";
			strSql += " 		   decode( '" + strDEPT_FLAG +"' , 'DEPT',a.dept_code, '') dept_code, \n";
			strSql += " 		   c.p_budg_code_no, \n";
			strSql += " 		   100000000000 budg_code_no, \n";
			strSql += " 		   '100000000000' acc_code, \n";
			strSql += " 		   sum(nvl(b.budg_month_assign_amt,0) ) first_budg_amt, \n";
			strSql += " 		   sum(nvl(b2.chg_amt,0) ) 		     add_budg_amt, \n";
			strSql += " 		   sum(nvl(b.budg_month_assign_amt,0) + nvl(b2.chg_amt,0) ) budg_amt \n";
			strSql += " 	from  t_budg_dept_item_h a, \n";
			strSql += " 		  t_budg_month_amt_h b, \n";
			strSql += " 		  t_budg_chg_reason b2, \n";
			strSql += " 		  (select * from t_budg_code where comp_code = '" +strCOMP_CODE  +"' \n";
			strSql += " 		   and acc_code in ( select acc_code from t_acc_code where budg_exec_cls='T')) c, \n";
			strSql += " 		  t_budg_dept_map d \n";
			strSql += " 	where a.comp_code    = b.comp_code \n";
			strSql += " 	and	  a.clse_acc_id  = b.clse_acc_id \n";
			strSql += " 	and	  a.dept_code    = b.dept_code \n";
			strSql += " 	and	  a.chg_seq 	 = b.chg_seq \n";
			strSql += " 	and	  a.budg_code_no = b.budg_code_no \n";
			strSql += " 	and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 	and   b.comp_code    = b2.comp_code(+) \n";
			strSql += " 	and	  b.clse_acc_id  = b2.clse_acc_id(+) \n";
			strSql += " 	and	  b.dept_code    = b2.dept_code(+) \n";
			strSql += " 	and	  b.budg_code_no = b2.budg_code_no(+) \n";
			strSql += " 	and	  b.reserved_seq = b2.reserved_seq(+) \n";
			strSql += " 	and	  b.budg_ym 	 = b2.budg_ym(+) \n";
			strSql += " 	and	  a.budg_code_no = c.budg_code_no \n";
			strSql += " 	and	  a.dept_code	 = d.dept_code \n";
			strSql += " 	and	  a.chg_seq		 = 0 \n";
			strSql += " 	and	  a.comp_code	 =  '" + strCOMP_CODE +"'  \n";
			strSql += " 	and	  a.clse_acc_id	 =  '" + strCLSE_ACC_ID +"'  \n";
			strSql += " 	and   to_char(b.budg_ym,'yyyy-mm') between  '" +strBUDG_YYYY_MM_FR  +"'  and  '" + strBUDG_YYYY_MM_TO +"'  \n";
			strSql += " 	 \n";
			strSql += " 	group by \n";
			strSql += " 		  	a.comp_code, \n";
			strSql += " 		    a.clse_acc_id, \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'CHK_DEPT',d.chk_dept_code,'DEPT', d.chk_dept_code, ''), \n";
			strSql += " 		   	decode( '" + strDEPT_FLAG +"' , 'DEPT',a.dept_code, ''), \n";
			strSql += " 		    c.p_budg_code_no \n";
			strSql += " 	) a, \n";
			strSql += " 	(select * from t_budg_code where comp_code = '" +strCOMP_CODE  +"') b, \n";
			strSql += " 	t_acc_code c, \n";
			strSql += " 	t_dept_code d1, \n";
			strSql += " 	t_dept_code d2 \n";
			strSql += " where a.p_budg_code_no = b.budg_code_no(+) \n";
			strSql += " and	  a.acc_code	= c.acc_code(+) \n";
			strSql += " and	  a.chk_dept_code = d1.dept_code(+) \n";
			strSql += " and	  a.dept_code = d2.dept_code(+) \n";
			strSql += " and	  (decode( '" + strDEPT_FLAG +"' , 'CHK_DEPT',a.chk_dept_code,'DEPT', a.dept_code, '') like '%' ||  '" +strDEPT_CODE  +"'  || '%' \n";
			strSql += " 		  or a.chk_dept_code is null) \n";
			strSql += " order by 2, 4, 6, 1, 8 ";
			
			
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
		
		//팀별
		else if (strAct.equals("LIST02_1"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE  = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strBUDG_YYYY_MM_FR  = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_FR"));
			String strBUDG_YYYY_MM_TO = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_TO"));
			String strCLSE_ACC_ID = strBUDG_YYYY_MM_FR.substring(0,4);
			
			strSql  = " --팀별 \n";
			strSql += " select \n";
			strSql += " 	  div,  \n";
			strSql += " 	  a3.chk_dept_code, \n";
			strSql += " 	  d1.dept_name chk_dept_name, \n";
			strSql += " 	  a3.p_budg_code_no, \n";
			strSql += " 	  b.budg_code_name p_acc_name, \n";
			strSql += " 	  a3.budg_code_no, \n";
			strSql += " 	  a3.ACC_CODE, \n";
			strSql += " 	  decode(div,'12','소계', c.acc_name) acc_name, \n";
			strSql += " 	  a3.BUDG_ASSIGN_AMT,  \n";
			strSql += " 	  a3.CHG_AMT \n";
			strSql += " 	   \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select \n";
			strSql += " 		  '11' div,  \n";
			strSql += " 		  a2.chk_dept_code, \n";
			strSql += " 		  a2.p_budg_code_no, \n";
			strSql += " 		  a2.budg_code_no, \n";
			strSql += " 		  a2.ACC_CODE, \n";
			strSql += " 		  sum(a2.BUDG_ASSIGN_AMT) budg_assign_amt,  \n";
			strSql += " 		  sum(a2.CHG_AMT) chg_amt \n";
			strSql += " 		   \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select	 \n";
			strSql += " 				(select chk_dept_code from t_budg_dept_map where dept_code = a.dept_code) chk_dept_code, \n";
			strSql += " 				a.dept_code, \n";
			strSql += " 				p_budg_code_no, \n";
			strSql += " 				budg_code_no, \n";
			strSql += " 				ACC_CODE, \n";
			strSql += " 				BUDG_ASSIGN_AMT,  \n";
			strSql += " 				CHG_AMT \n";
			strSql += " 		from \n";
			strSql += " 			( \n";
			strSql += " 			select  \n";
			strSql += " 				   a.comp_code, \n";
			strSql += " 				   a.clse_acc_id, \n";
			strSql += " 				   a.dept_code, \n";
			strSql += " 				   a.p_budg_code_no, \n";
			strSql += " 				   a.budg_code_no, \n";
			strSql += " 				   a.ACC_CODE, \n";
			strSql += " 				   sum(nvl(budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT,  \n";
			strSql += " 				   sum(nvl(chg_amt,0)) CHG_AMT  \n";
			strSql += " 			from   \n";
			strSql += " 				(select  \n";
			strSql += " 						a.comp_code, \n";
			strSql += " 						a.clse_acc_id, \n";
			strSql += " 						a.dept_code, \n";
			strSql += " 						c.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.budg_ym, \n";
			strSql += " 						a.budg_month_assign_amt, \n";
			strSql += " 						b.chg_amt, \n";
			strSql += " 						c.acc_code \n";
			strSql += " 				from \n";
			strSql += " 					( \n";
			strSql += " 					select  \n";
			strSql += " 						   a.comp_code, \n";
			strSql += " 						   a.clse_acc_id, \n";
			strSql += " 						   a.dept_code, \n";
			strSql += " 						   a.budg_code_no, \n";
			strSql += " 						   a.budg_ym, \n";
			strSql += " 						   a.budg_month_assign_amt \n";
			strSql += " 					from   t_budg_month_amt_h a \n";
			strSql += " 					where  chg_seq=0 \n";
			strSql += " 					) a,  \n";
			strSql += " 					( \n";
			strSql += " 					select  \n";
			strSql += " 					   	   a.comp_code, \n";
			strSql += " 					   	   a.clse_acc_id, \n";
			strSql += " 					   	   a.dept_code, \n";
			strSql += " 					   	   a.budg_code_no, \n";
			strSql += " 					   	   a.budg_ym, \n";
			strSql += " 					   	   sum(nvl(a.chg_amt,0)) chg_amt \n";
			strSql += " 					from   t_budg_chg_reason a \n";
			strSql += " 					where  reason_code='1' \n";
			strSql += " 					group  by a.comp_code, \n";
			strSql += " 					   	   	  a.clse_acc_id, \n";
			strSql += " 					   	  	  a.dept_code, \n";
			strSql += " 					   	  	  a.budg_code_no, \n";
			strSql += " 					   	  	  a.budg_ym \n";
			strSql += " 					) b, \n";
			strSql += " 					(select * from t_budg_code where comp_code = ? ) c \n";
			strSql += " 					where a.comp_code     = b.comp_code(+)  \n";
			strSql += " 					and	  a.clse_acc_id   = b.clse_acc_id(+)  \n";
			strSql += " 					and	  a.dept_code 	  = b.dept_code(+) \n";
			strSql += " 					and	  a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 					and	  a.budg_ym 	  = b.budg_ym(+) \n";
			strSql += " 					and   a.budg_code_no  = c.budg_code_no 		 \n";
			strSql += " 				) a --본예산과 변경금액  \n";
			strSql += " 				where a.comp_code =  ?  \n";
			strSql += " 				and	  a.clse_acc_id =  ?  \n";
			strSql += " 				and   to_char(a.budg_ym,'yyyy-mm') between  ?  and  ?  \n";
			strSql += " 				group  by  \n";
			strSql += " 				   	  a.comp_code, \n";
			strSql += " 				   	  a.clse_acc_id, \n";
			strSql += " 					  a.dept_code, \n";
			strSql += " 				   	  a.p_budg_code_no, \n";
			strSql += " 				   	  a.budg_code_no, \n";
			strSql += " 				   	  a.ACC_CODE \n";
			strSql += " 			 \n";
			strSql += " 			 \n";
			strSql += " 			) a \n";
			strSql += " 		) a2 \n";
			strSql += " 	group by \n";
			strSql += " 		  	a2.chk_dept_code, \n";
			strSql += " 		  	a2.p_budg_code_no, \n";
			strSql += " 		  	a2.budg_code_no, \n";
			strSql += " 		  	a2.ACC_CODE \n";
			strSql += " 			 \n";
			strSql += " 	union \n";
			strSql += " 	 \n";
			strSql += " 	select \n";
			strSql += " 		  '12' div,  \n";
			strSql += " 		  a2.chk_dept_code, \n";
			strSql += " 		  a2.p_budg_code_no, \n";
			strSql += " 		  1000000000 budg_code_no, \n";
			strSql += " 		  '' ACC_CODE, \n";
			strSql += " 		  sum(a2.BUDG_ASSIGN_AMT) budg_assign_amt,  \n";
			strSql += " 		  sum(a2.CHG_AMT) chg_amt \n";
			strSql += " 		   \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select	 \n";
			strSql += " 				(select chk_dept_code from t_budg_dept_map where dept_code = a.dept_code) chk_dept_code, \n";
			strSql += " 				a.dept_code, \n";
			strSql += " 				p_budg_code_no, \n";
			strSql += " 				budg_code_no, \n";
			strSql += " 				ACC_CODE, \n";
			strSql += " 				BUDG_ASSIGN_AMT,  \n";
			strSql += " 				CHG_AMT \n";
			strSql += " 		from \n";
			strSql += " 			( \n";
			strSql += " 			select  \n";
			strSql += " 				   a.comp_code, \n";
			strSql += " 				   a.clse_acc_id, \n";
			strSql += " 				   a.dept_code, \n";
			strSql += " 				   a.p_budg_code_no, \n";
			strSql += " 				   a.budg_code_no, \n";
			strSql += " 				   a.ACC_CODE, \n";
			strSql += " 				   sum(nvl(budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT,  \n";
			strSql += " 				   sum(nvl(chg_amt,0)) CHG_AMT  \n";
			strSql += " 			from   \n";
			strSql += " 				(select  \n";
			strSql += " 						a.comp_code, \n";
			strSql += " 						a.clse_acc_id, \n";
			strSql += " 						a.dept_code, \n";
			strSql += " 						c.p_budg_code_no, \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.budg_ym, \n";
			strSql += " 						a.budg_month_assign_amt, \n";
			strSql += " 						b.chg_amt, \n";
			strSql += " 						c.acc_code \n";
			strSql += " 				from \n";
			strSql += " 					( \n";
			strSql += " 					select  \n";
			strSql += " 						   a.comp_code, \n";
			strSql += " 						   a.clse_acc_id, \n";
			strSql += " 						   a.dept_code, \n";
			strSql += " 						   a.budg_code_no, \n";
			strSql += " 						   a.budg_ym, \n";
			strSql += " 						   a.budg_month_assign_amt \n";
			strSql += " 					from   t_budg_month_amt_h a \n";
			strSql += " 					where  chg_seq=0 \n";
			strSql += " 					) a,  \n";
			strSql += " 					( \n";
			strSql += " 					select  \n";
			strSql += " 					   	   a.comp_code, \n";
			strSql += " 					   	   a.clse_acc_id, \n";
			strSql += " 					   	   a.dept_code, \n";
			strSql += " 					   	   a.budg_code_no, \n";
			strSql += " 					   	   a.budg_ym, \n";
			strSql += " 					   	   sum(nvl(a.chg_amt,0)) chg_amt \n";
			strSql += " 					from   t_budg_chg_reason a \n";
			strSql += " 					where  reason_code='1' \n";
			strSql += " 					group  by a.comp_code, \n";
			strSql += " 					   	   	  a.clse_acc_id, \n";
			strSql += " 					   	  	  a.dept_code, \n";
			strSql += " 					   	  	  a.budg_code_no, \n";
			strSql += " 					   	  	  a.budg_ym \n";
			strSql += " 					) b, \n";
			strSql += " 					(select * from t_budg_code where comp_code = ? ) c \n";
			strSql += " 					where a.comp_code     = b.comp_code(+)  \n";
			strSql += " 					and	  a.clse_acc_id   = b.clse_acc_id(+)  \n";
			strSql += " 					and	  a.dept_code 	  = b.dept_code(+) \n";
			strSql += " 					and	  a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 					and	  a.budg_ym 	  = b.budg_ym(+) \n";
			strSql += " 					and   a.budg_code_no  = c.budg_code_no 		 \n";
			strSql += " 				) a --본예산과 변경금액  \n";
			strSql += " 				where a.comp_code =  ?  \n";
			strSql += " 				and	  a.clse_acc_id =  ?  \n";
			strSql += " 				and   to_char(a.budg_ym,'yyyy-mm') between  ?  and  ?  \n";
			strSql += " 				group  by  \n";
			strSql += " 				   	  a.comp_code, \n";
			strSql += " 				   	  a.clse_acc_id, \n";
			strSql += " 					  a.dept_code, \n";
			strSql += " 				   	  a.p_budg_code_no, \n";
			strSql += " 				   	  a.budg_code_no, \n";
			strSql += " 				   	  a.ACC_CODE \n";
			strSql += " 			 \n";
			strSql += " 			 \n";
			strSql += " 			) a \n";
			strSql += " 		) a2 \n";
			strSql += " 	group by \n";
			strSql += " 		  	a2.chk_dept_code, \n";
			strSql += " 		  	a2.p_budg_code_no \n";
			strSql += " 		  	 \n";
			strSql += " 	) a3, \n";
			strSql += " 	(select * from t_budg_code where comp_code = ? ) b, \n";
			strSql += " 	t_acc_code  c, \n";
			strSql += " 	t_dept_code d1 \n";
			strSql += " where a3.p_budg_code_no = b.budg_code_no(+) \n";
			strSql += " and	  a3.acc_code = c.acc_code(+) \n";
			strSql += " and	  a3.chk_dept_code = d1.dept_code \n";
			strSql += " and	  a3.chk_dept_code  like '%' ||  ?  || '%' \n";
			strSql += " order by 2, 4, 1, 6 \n";
			
			lrArgData.addColumn("COMP_CODE102", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_FR3", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_TO4", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE101", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE5", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID6", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_FR7", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_TO8", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE100", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE9", CITData.VARCHAR2);
			
			lrArgData.addRow();
			
			lrArgData.setValue("COMP_CODE102", strCOMP_CODE);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID2", strCLSE_ACC_ID);
			lrArgData.setValue("YYYY_MM_FR3", strBUDG_YYYY_MM_FR);
			lrArgData.setValue("YYYY_MM_TO4", strBUDG_YYYY_MM_TO);
			lrArgData.setValue("COMP_CODE101", strCOMP_CODE);
			lrArgData.setValue("COMP_CODE5", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID6", strCLSE_ACC_ID);
			lrArgData.setValue("YYYY_MM_FR7", strBUDG_YYYY_MM_FR);
			lrArgData.setValue("YYYY_MM_TO8", strBUDG_YYYY_MM_TO);
			lrArgData.setValue("COMP_CODE100", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE9", strDEPT_CODE);
			
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
		//부서별
		else if (strAct.equals("LIST02_2"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE  = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strBUDG_YYYY_MM_FR  = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_FR"));
			String strBUDG_YYYY_MM_TO = CITCommon.toKOR(request.getParameter("BUDG_YYYY_MM_TO"));
			String strCLSE_ACC_ID = strBUDG_YYYY_MM_FR.substring(0,4);
			
			strSql  = " --부서별 \n";
			strSql += " select \n";
			strSql += " 	  div,  \n";
			strSql += " 	  chk_dept_code, \n";
			strSql += " 	  d1.dept_name chk_dept_name, \n";
			strSql += " 	  a2.dept_code, \n";
			strSql += " 	  d2.dept_name, \n";
			strSql += " 	  a2.p_budg_code_no, \n";
			strSql += " 	  b.budg_code_name p_acc_name, \n";
			strSql += " 	  a2.budg_code_no, \n";
			strSql += " 	  a2.ACC_CODE, \n";
			strSql += " 	  decode(div,'12','소계', c.acc_name) acc_name, \n";
			strSql += " 	  a2.BUDG_ASSIGN_AMT,  \n";
			strSql += " 	  a2.CHG_AMT \n";
			strSql += " 	   \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select	div,  \n";
			strSql += " 			(select chk_dept_code from t_budg_dept_map where dept_code = a.dept_code) chk_dept_code, \n";
			strSql += " 			a.dept_code, \n";
			strSql += " 			p_budg_code_no, \n";
			strSql += " 			budg_code_no, \n";
			strSql += " 			ACC_CODE, \n";
			strSql += " 			BUDG_ASSIGN_AMT,  \n";
			strSql += " 			CHG_AMT \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select '11' div,  \n";
			strSql += " 			   a.comp_code, \n";
			strSql += " 			   a.clse_acc_id, \n";
			strSql += " 			   a.dept_code, \n";
			strSql += " 			   a.p_budg_code_no, \n";
			strSql += " 			   a.budg_code_no, \n";
			strSql += " 			   a.ACC_CODE, \n";
			strSql += " 			   sum(nvl(budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT,  \n";
			strSql += " 			   sum(nvl(chg_amt,0)) CHG_AMT  \n";
			strSql += " 		from   \n";
			strSql += " 			(select  \n";
			strSql += " 					a.comp_code, \n";
			strSql += " 					a.clse_acc_id, \n";
			strSql += " 					a.dept_code, \n";
			strSql += " 					c.p_budg_code_no, \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					a.budg_ym, \n";
			strSql += " 					a.budg_month_assign_amt, \n";
			strSql += " 					b.chg_amt, \n";
			strSql += " 					c.acc_code \n";
			strSql += " 			from \n";
			strSql += " 				( \n";
			strSql += " 				select  \n";
			strSql += " 					   a.comp_code, \n";
			strSql += " 					   a.clse_acc_id, \n";
			strSql += " 					   a.dept_code, \n";
			strSql += " 					   a.budg_code_no, \n";
			strSql += " 					   a.budg_ym, \n";
			strSql += " 					   a.budg_month_assign_amt \n";
			strSql += " 				from   t_budg_month_amt_h a \n";
			strSql += " 				where  chg_seq=0 \n";
			strSql += " 				) a,  \n";
			strSql += " 				( \n";
			strSql += " 				select  \n";
			strSql += " 				   	   a.comp_code, \n";
			strSql += " 				   	   a.clse_acc_id, \n";
			strSql += " 				   	   a.dept_code, \n";
			strSql += " 				   	   a.budg_code_no, \n";
			strSql += " 				   	   a.budg_ym, \n";
			strSql += " 				   	   sum(nvl(a.chg_amt,0)) chg_amt \n";
			strSql += " 				from   t_budg_chg_reason a \n";
			strSql += " 				where  reason_code='1' \n";
			strSql += " 				group  by a.comp_code, \n";
			strSql += " 				   	   	  a.clse_acc_id, \n";
			strSql += " 				   	  	  a.dept_code, \n";
			strSql += " 				   	  	  a.budg_code_no, \n";
			strSql += " 				   	  	  a.budg_ym \n";
			strSql += " 				) b, \n";
			strSql += " 				(select * from t_budg_code where comp_code = ? ) c  \n";
			strSql += " 				where a.comp_code     = b.comp_code(+)  \n";
			strSql += " 				and	  a.clse_acc_id   = b.clse_acc_id(+)  \n";
			strSql += " 				and	  a.dept_code 	  = b.dept_code(+) \n";
			strSql += " 				and	  a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 				and	  a.budg_ym 	  = b.budg_ym(+) \n";
			strSql += " 				and   a.budg_code_no  = c.budg_code_no 		 \n";
			strSql += " 			) a --본예산과 변경금액  \n";
			strSql += " 			where a.comp_code =  ?  \n";
			strSql += " 			and	  a.clse_acc_id =  ?  \n";
			strSql += " 			and   to_char(a.budg_ym,'yyyy-mm') between  ?  and  ?  \n";
			strSql += " 			group  by  \n";
			strSql += " 			   	  a.comp_code, \n";
			strSql += " 			   	  a.clse_acc_id, \n";
			strSql += " 				  a.dept_code, \n";
			strSql += " 			   	  a.p_budg_code_no, \n";
			strSql += " 			   	  a.budg_code_no, \n";
			strSql += " 			   	  a.ACC_CODE \n";
			strSql += " 		 \n";
			strSql += " 		union \n";
			strSql += " 		 \n";
			strSql += " 			--전체 \n";
			strSql += " 		select '12' div,  \n";
			strSql += " 			   a.comp_code, \n";
			strSql += " 			   a.clse_acc_id, \n";
			strSql += " 			   a.dept_code, \n";
			strSql += " 			   a.p_budg_code_no, \n";
			strSql += " 			   100000000 budg_code_no, \n";
			strSql += " 			   '1000000000' ACC_CODE, \n";
			strSql += " 			   sum(nvl(budg_month_assign_amt, 0))    BUDG_ASSIGN_AMT,  \n";
			strSql += " 			   sum(nvl(chg_amt,0)) CHG_AMT  \n";
			strSql += " 		from   \n";
			strSql += " 			(select  \n";
			strSql += " 					a.comp_code, \n";
			strSql += " 					a.clse_acc_id, \n";
			strSql += " 					a.dept_code, \n";
			strSql += " 					c.p_budg_code_no, \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					a.budg_ym, \n";
			strSql += " 					a.budg_month_assign_amt, \n";
			strSql += " 					b.chg_amt, \n";
			strSql += " 					c.acc_code \n";
			strSql += " 			from \n";
			strSql += " 				( \n";
			strSql += " 				select  \n";
			strSql += " 					   a.comp_code, \n";
			strSql += " 					   a.clse_acc_id, \n";
			strSql += " 					   a.dept_code, \n";
			strSql += " 					   a.budg_code_no, \n";
			strSql += " 					   a.budg_ym, \n";
			strSql += " 					   a.budg_month_assign_amt \n";
			strSql += " 				from   t_budg_month_amt_h a \n";
			strSql += " 				where  chg_seq=0 \n";
			strSql += " 				) a,  \n";
			strSql += " 				( \n";
			strSql += " 				select  \n";
			strSql += " 				   	   a.comp_code, \n";
			strSql += " 				   	   a.clse_acc_id, \n";
			strSql += " 				   	   a.dept_code, \n";
			strSql += " 				   	   a.budg_code_no, \n";
			strSql += " 				   	   a.budg_ym, \n";
			strSql += " 				   	   sum(nvl(a.chg_amt,0)) chg_amt \n";
			strSql += " 				from   t_budg_chg_reason a \n";
			strSql += " 				where  reason_code='1' \n";
			strSql += " 				group  by a.comp_code, \n";
			strSql += " 				   	   	  a.clse_acc_id, \n";
			strSql += " 				   	  	  a.dept_code, \n";
			strSql += " 				   	  	  a.budg_code_no, \n";
			strSql += " 				   	  	  a.budg_ym \n";
			strSql += " 				) b, \n";
			strSql += " 				(select * from t_budg_code where comp_code = ? ) c  \n";
			strSql += " 				where a.comp_code     = b.comp_code(+)   \n";
			strSql += " 				and	  a.clse_acc_id   = b.clse_acc_id(+)  \n";
			strSql += " 				and	  a.dept_code 	  = b.dept_code(+) \n";
			strSql += " 				and	  a.budg_code_no  = b.budg_code_no(+) \n";
			strSql += " 				and	  a.budg_ym 	  = b.budg_ym(+) \n";
			strSql += " 				and    a.budg_code_no = c.budg_code_no 		 \n";
			strSql += " 				) a --본예산과 변경금액  \n";
			strSql += " 		where a.comp_code =  ?  \n";
			strSql += " 		and	  a.clse_acc_id =  ?  \n";
			strSql += " 		and to_char(a.budg_ym,'yyyy-mm') between  ?  and  ?  \n";
			strSql += " 		group  by  \n";
			strSql += " 			   	  a.comp_code, \n";
			strSql += " 			   	  a.clse_acc_id, \n";
			strSql += " 				  a.dept_code, \n";
			strSql += " 			   	  a.p_budg_code_no \n";
			strSql += " 		) a \n";
			strSql += " 	) a2, \n";
			strSql += " 	(select * from t_budg_code where comp_code = ? ) b, \n";
			strSql += " 	t_acc_code  c, \n";
			strSql += " 	t_dept_code d1, \n";
			strSql += " 	t_dept_code d2 \n";
			strSql += " where a2.p_budg_code_no = b.budg_code_no(+) \n";
			strSql += " and	  a2.acc_code = c.acc_code(+) \n";
			strSql += " and	  a2.chk_dept_code = d1.dept_code \n";
			strSql += " and	  a2.dept_code = d2.dept_code \n";
			strSql += " and	  a2.dept_code like '%' ||  ?  || '%' \n";
			strSql += " order by 2, 4, 6, 1, 8 ";
		
			lrArgData.addColumn("COMP_CODE100", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_FR3", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_TO4", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE101", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE5", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID6", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_FR7", CITData.VARCHAR2);
			lrArgData.addColumn("YYYY_MM_TO8", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE102", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE9", CITData.VARCHAR2);
			
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE100", strCOMP_CODE);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID2", strCLSE_ACC_ID);
			lrArgData.setValue("YYYY_MM_FR3", strBUDG_YYYY_MM_FR);
			lrArgData.setValue("YYYY_MM_TO4", strBUDG_YYYY_MM_TO);
			lrArgData.setValue("COMP_CODE101", strCOMP_CODE);
			lrArgData.setValue("COMP_CODE5", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID6", strCLSE_ACC_ID);
			lrArgData.setValue("YYYY_MM_FR7", strBUDG_YYYY_MM_FR);
			lrArgData.setValue("YYYY_MM_TO8", strBUDG_YYYY_MM_TO);
			lrArgData.setValue("COMP_CODE102", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE9", strDEPT_CODE);
			
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
