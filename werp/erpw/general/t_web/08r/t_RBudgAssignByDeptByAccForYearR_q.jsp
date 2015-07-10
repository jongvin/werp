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
			strSql  += "     a.COMP_CODE = ? \n";
			strSql += "	  and a.DEPT_CODE = b.DEPT_CODE \n";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",vCompCode);

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
			String vBudgYyyy = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));
			String vDeptFlag = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
			//String vBudgFlag = CITCommon.toKOR(request.getParameter("BUDG_FLAG"));

			strSql  = " select \n";
			strSql += " 	a.COMP_CODE, \n";
			strSql += " 	a.COMPANY_NAME, \n";
			strSql += " 	(                                                                      					\n";         
			strSql += " 	CASE '"+vDeptFlag+"' WHEN 'CHK_DEPT'	THEN a.CHK_DEPT_NAME      \n";               
	 		strSql += " 	WHEN 'DEPT'		THEN a.DEPT_NAME                           \n";         
			strSql += " 	ELSE '' END                                             				\n";
			strSql += " 	) DEPT_TITLE, \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	a.ACC_NAME, \n";
			strSql += " 	a.BUDG_YYYY, \n";
			strSql += " 	 pb1, \n";
			strSql += " 	pb2, \n";
			strSql += " 	pb3, \n";
			strSql += " 	pb4, \n";
			strSql += " 	pb5, \n";
			strSql += " 	pb6, \n";
			strSql += " 	pb7, \n";
			strSql += " 	pb8, \n";
			strSql += " 	pb9, \n";
			strSql += " 	pb10, \n";
			strSql += " 	pb11, \n";
			strSql += " 	pb12, \n";
			strSql += " 	pb1+pb2+pb3 pb14, \n";
			strSql += " 	pb4+pb5+pb6 pb24, \n";
			strSql += " 	pb7+pb8+pb9 pb34, \n";
			strSql += " 	pb10+pb11+pb12 pb44, \n";
			strSql += " 	pb1+pb2+pb3+pb4+pb5+pb6 pb012, \n";
			strSql += " 	pb7+pb8+pb9+pb10+pb11+pb12 pb022, \n";
			strSql += "  \n";
			strSql += " 	s1, \n";
			strSql += " 	s2, \n";
			strSql += " 	s3, \n";
			strSql += " 	s4, \n";
			strSql += " 	s5, \n";
			strSql += " 	s6, \n";
			strSql += " 	s7, \n";
			strSql += " 	s8, \n";
			strSql += " 	s9, \n";
			strSql += " 	s10, \n";
			strSql += " 	s11, \n";
			strSql += " 	s12, \n";
			strSql += " 	s1 +s2 +s3  s14, \n";
			strSql += " 	s4 +s5 +s6  s24, \n";
			strSql += " 	s7 +s8 +s9  s34, \n";
			strSql += " 	s10+s11+s12 s44, \n";
			strSql += " 	s1+s2+s3+s4+s5+s6 s012, \n";
			strSql += " 	s7+s8+s9+s10+s11+s12 s022, \n";
			strSql += "  \n";
			strSql += " 	to_char(  r1, '999.99') r1, \n";
			strSql += " 	to_char(  r2, '999.99') r2, \n";
			strSql += " 	to_char(  r3, '999.99') r3, \n";
			strSql += " 	to_char(  r4, '999.99') r4, \n";
			strSql += " 	to_char(  r5, '999.99') r5, \n";
			strSql += " 	to_char(  r6, '999.99') r6, \n";
			strSql += " 	to_char(  r7, '999.99') r7, \n";
			strSql += " 	to_char(  r8, '999.99') r8, \n";
			strSql += " 	to_char(  r9, '999.99') r9, \n";
			strSql += " 	to_char( r10, '999.99') r10, \n";
			strSql += " 	to_char( r11, '999.99') r11, \n";
			strSql += " 	to_char( r12, '999.99') r12, \n";
			strSql += "  \n";
			strSql += " 	to_char( decode((pb1 +pb2 +pb3 ), 0, 0, 100*(s1 +s2 +s3 )/(pb1 +pb2 +pb3 )), '999.99') r14, \n";
			strSql += " 	to_char( decode((pb4 +pb5 +pb6 ), 0, 0, 100*(s4 +s5 +s6 )/(pb4 +pb5 +pb6 )), '999.99') r24, \n";
			strSql += " 	to_char( decode((pb7 +pb8 +pb9 ), 0, 0, 100*(s7 +s8 +s9 )/(pb7 +pb8 +pb9 )), '999.99') r34, \n";
			strSql += " 	to_char( decode((pb10+pb11+pb12), 0, 0, 100*(s10+s11+s12)/(pb10+pb11+pb12)), '999.99') r44, \n";
			strSql += " 	to_char( decode((pb1 +pb2 +pb3 +pb4 +pb5 +pb6 ), 0, 0, 100*(s1 +s2 +s3 + s4 + s5 +  s6)/(pb1 +pb2 +pb3 +pb4 +pb5 +pb6 )), '999.99') r012, \n";
			strSql += " 	to_char( decode((pb7 +pb8 +pb9 +pb10+pb11+pb12), 0, 0, 100*(s7 +s8 +s9 +s10+s11+s12)/(pb7 +pb8 +pb9 +pb10+pb11+pb12)), '999.99') r022	 \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select \n";
			strSql += " 		   a.comp_code, \n";
			strSql += " 		   a.company_name, \n";
			strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) CHK_DEPT_CODE,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) CHK_DEPT_NAME,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code, \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) dept_name, \n";
			strSql += " 		   a.ACC_CODE, \n";
			strSql += " 		   a.ACC_NAME,                                                                                                                                          			  \n";
			strSql += " 		   BUDG_YYYY, \n";
			strSql += " 		   sum( (CASE a.BUDG_MM WHEN '01' THEN a.BUDG_AMT ELSE 0 END) ) pb1,  \n";
			strSql += " 		   sum( (CASE a.BUDG_MM WHEN '02' THEN a.BUDG_AMT ELSE 0 END) ) pb2,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '03' THEN a.BUDG_AMT ELSE 0 END) ) pb3,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '04' THEN a.BUDG_AMT ELSE 0 END) ) pb4,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '05' THEN a.BUDG_AMT ELSE 0 END) ) pb5,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '06' THEN a.BUDG_AMT ELSE 0 END) ) pb6,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '07' THEN a.BUDG_AMT ELSE 0 END) ) pb7,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '08' THEN a.BUDG_AMT ELSE 0 END) ) pb8,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '09' THEN a.BUDG_AMT ELSE 0 END) ) pb9,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '10' THEN a.BUDG_AMT ELSE 0 END) ) pb10, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '11' THEN a.BUDG_AMT ELSE 0 END) ) pb11, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '12' THEN a.BUDG_AMT ELSE 0 END) ) pb12, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '01' THEN a.SIL_AMT ELSE 0 END) ) s1,  \n";
			strSql += " 		       sum( (CASE a.BUDG_MM WHEN '02' THEN a.SIL_AMT ELSE 0 END) ) s2,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '03' THEN a.SIL_AMT ELSE 0 END) ) s3,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '04' THEN a.SIL_AMT ELSE 0 END) ) s4,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '05' THEN a.SIL_AMT ELSE 0 END) ) s5,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '06' THEN a.SIL_AMT ELSE 0 END) ) s6,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '07' THEN a.SIL_AMT ELSE 0 END) ) s7,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '08' THEN a.SIL_AMT ELSE 0 END) ) s8,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '09' THEN a.SIL_AMT ELSE 0 END) ) s9,  \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '10' THEN a.SIL_AMT ELSE 0 END) ) s10, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '11' THEN a.SIL_AMT ELSE 0 END) ) s11, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '12' THEN a.SIL_AMT ELSE 0 END) ) s12,	 \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '01' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r1, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '02' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r2, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '03' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r3, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '04' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r4, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '05' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r5, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '06' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r6, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '07' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r7, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '08' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r8, \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '09' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r9, \n";
			strSql += " 		    sum( (CASE a.BUDG_MM WHEN '10' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r10,                                   \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '11' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r11,                                           \n";
			strSql += " 			sum( (CASE a.BUDG_MM WHEN '12' THEN decode(a.BUDG_AMT, 0, 0, (a.SIL_AMT/a.BUDG_AMT)*100) ELSE 0 END) ) r12 \n";
			strSql += " 	 \n";
			strSql += " 	from \n";
			strSql += " 		( \n";
			strSql += " 		select  \n";
			strSql += " 			   a.comp_code, \n";
			strSql += " 			   company_name, \n";
			strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) CHK_DEPT_CODE, \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) CHK_DEPT_NAME, \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code,  \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) dept_name, \n";
			strSql += " 			   a.ACC_CODE, \n";
			strSql += " 			   b.ACC_NAME,                                                                                                                                          			  \n";
			strSql += " 		 	    to_char(a.budg_ym,'YYYY') BUDG_YYYY,       \n";
			strSql += " 		 	   SUBSTR( to_char(a.budg_ym,'YYYYMM'), 5,2) BUDG_MM,  \n";
			strSql += " 			   sum(budg_month_assign_amt) BUDG_AMT, \n";
			strSql += " 			   sum(SIL_AMT) SIL_AMT \n";
			strSql += " 		from  \n";
			strSql += " 			(select \n";
			strSql += " 				  a.comp_code, \n";
			strSql += " 				  a.clse_acc_id, \n";
			strSql += " 				  a.dept_code, \n";
			strSql += " 				  a.reserved_seq, \n";
			strSql += " 				  a.budg_item_req_amt, \n";
			strSql += " 				  a.budg_item_assign_amt, \n";
			strSql += " 				  a.budg_item_req_amt_a, \n";
			strSql += " 				  b.budg_ym, \n";
			strSql += " 				  b.budg_month_req_amt, \n";
			strSql += " 				  b.budg_month_assign_amt, \n";
			strSql += " 				  b.budg_month_req_amt_a, \n";
			strSql += " 				  c.acc_code \n";
			strSql += " 			from  t_budg_dept_item a, \n";
			strSql += " 				  t_budg_month_amt b, \n";
			strSql += " 				  t_budg_code      c \n";
			strSql += " 			where a.comp_code = b.comp_code \n";
			strSql += " 			and	  a.clse_acc_id = b.clse_acc_id \n";
			strSql += " 			and	  a.dept_code = b.dept_code \n";
			strSql += " 			and	  a.budg_code_no = b.budg_code_no \n";
			strSql += " 			and	  a.reserved_seq = b.reserved_seq \n";
			strSql += " 			and	  a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += " 			) a, \n";
			strSql += "      		(select *  \n";
			strSql += "      		from t_acc_code a  \n";
			strSql += "      		where   a.BUDG_MNG = 'T') b,  \n";
			strSql += " 			( \n";
			strSql += " 			SELECT c.DEPT_CODE, SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM, b.ACC_CODE, SUM(b.DB_AMT+b.CR_AMT) SIL_AMT  \n";
			strSql += " 			FROM T_ACC_SLIP_HEAD a, T_ACC_SLIP_BODY b, T_DEPT_CODE c                                             \n";
			strSql += " 			WHERE                                                                                                \n";
			strSql += " 				a.SLIP_ID=b.SLIP_ID                                                                              \n";
			strSql += " 				AND a.KEEP_SLIPNO is not null                                                                    \n";
			strSql += " 				AND SUBSTR(a.MAKE_DT_TRANS,1,4)='"+vBudgYyyy+"'                                                  \n";
			strSql += " 				and c.COMP_CODE = '"+vCompCode+"'                                                                \n";
			strSql += " 				AND ('***'='"+vDeptCode+"' or b.DEPT_CODE='"+vDeptCode+"')                                       \n";
			strSql += " 				and b.DEPT_CODE=c.DEPT_CODE                                                                      \n";
			strSql += " 			GROUP BY c.DEPT_CODE,  SUBSTR(a.MAKE_DT_TRANS,1,6), b.ACC_CODE  \n";
			strSql += " 			) c, \n";
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
			strSql += " 		where ('***'='"+vDeptCode+"' or a.DEPT_CODE='"+vDeptCode+"')   \n";
			strSql += " 		and   a.clse_acc_id ='"+vBudgYyyy+"' \n";
			strSql += " 		and   a.acc_code  = b.acc_code(+) \n";
			strSql += " 		and   a.acc_code  = c.acc_code(+) \n";
			strSql += " 		and	  a.comp_code = d.comp_code \n";
			strSql += " 		and	  a.dept_code = d.dept_code \n";
			strSql += " 		and	  a.dept_code = e.dept_code \n";
			strSql += " 		group  by \n";
			strSql += " 		 	   a.comp_code, \n";
			strSql += " 			   company_name, \n";
			strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) , \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   	   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) , \n";
			strSql += " 			   a.ACC_CODE, \n";
			strSql += " 			   b.ACC_NAME,                                                                                                                                          			  \n";
			strSql += " 			   budg_ym \n";
			strSql += "	ORDER BY                                                                                                                                                  \n";
			strSql += "	COMP_CODE,                                                                                                                                      \n";
			strSql += "	DEPT_CODE,                                                                                                                                     \n";
			strSql += "	DEPT_NAME,                                                                                                                                       \n";

			strSql += "	ACC_NAME,                                                                                                                                          \n";
			strSql += "	BUDG_YYYY                                                                                                                                            \n";
//strSql += "	BUDG_MM                                                                                                                                            \n";


			strSql += " 	 	) a \n";
			strSql += " 	group by  \n";
			strSql += " 		  	 a.comp_code, \n";
			strSql += " 		   a.company_name, \n";
			strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) ,  \n";
		  	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) , \n";
			strSql += " 		   a.ACC_CODE, \n";
			strSql += " 		   a.ACC_NAME,                                                                                                                                          			  \n";
			strSql += " 		   BUDG_YYYY \n";
			strSql += " 	) a  	  \n";
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
