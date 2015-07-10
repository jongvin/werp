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

				/*
				strSql  = "select '"+vCompCode+"' COMP_CODE, '***' DEPT_CODE, '전  체' DEPT_NAME, '전  체' DEPT_SHORT_NAME \n";
				strSql += "from dual a \n";
				strSql += "union all \n";
				strSql += "select a.COMP_CODE, a.DEPT_CODE, a.DEPT_NAME, a.DEPT_SHORT_NAME \n";
				strSql += "from T_DEPT_CODE a, \n";
				strSql += "	 ( \n";
				strSql += "	  SELECT DEPT_CODE \n";
				strSql += "	  FROM T_BUDG_DEPT \n";
				strSql += "	  WHERE 						    \n";
				strSql += "		CLSE_ACC_ID = '"+vBudgYyyy+"' \n";
				strSql += "	  group by DEPT_CODE \n";
				strSql += "	 ) b \n";
				strSql  += "WHERE \n";
				strSql  += "     a.COMP_CODE = '"+vCompCode+"' \n";
				strSql += "	  and a.DEPT_CODE = b.DEPT_CODE \n";
				*/
				
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

		//전체
		else if (strAct.equals("LIST02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));
			String strCLSE_ACC_ID_B4 = CITCommon.toKOR(request.getParameter("BUDG_YYYY_B4"));
			String strDEPT_FLAG = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
			
			//strCOMP_CODE ="A0";
			//strCLSE_ACC_ID ="2006";
			//strCLSE_ACC_ID_B4="2005";
			
			strSql  = " select \n";
			strSql += " 	     a.div, \n";
			strSql += " 	     decode( '" +strDEPT_FLAG+"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 	 	 decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code, \n";
			strSql += " 		 e1.dept_name chk_dept_name, \n";
			strSql += " 		 e2.dept_name, \n";
			strSql += " 		 a.p_budg_code_no, \n";
			strSql += " 		 c.budg_code_name p_acc_name,							  	    \n";
			strSql += " 		 a.budg_code_no, \n";
			strSql += " 		 a.ACC_CODE, \n";
			strSql += " 		 decode(a.div, '12', '소계', d.acc_name) acc_name,                                 \n";
			strSql += " 	     a.cb0 	b_cb0 ,  \n";
			strSql += " 	     a.cb1 	b_cb1 ,  \n";
			strSql += " 	     a.cb2 	b_cb2 ,  \n";
			strSql += " 	     a.cb3 	b_cb3 ,  \n";
			strSql += " 	     a.cb4 	b_cb4 ,  \n";
			strSql += " 	     a.cb5 	b_cb5 ,  \n";
			strSql += " 	     a.cb6 	b_cb6 ,  \n";
			strSql += " 	     a.cb7 	b_cb7 ,  \n";
			strSql += " 	     a.cb8 	b_cb8 ,  \n";
			strSql += " 	     a.cb9 	b_cb9 ,  \n";
			strSql += " 	     a.cb10 b_cb10, \n";
			strSql += " 	     a.cb11 b_cb11, \n";
			strSql += " 	     a.cb12 b_cb12, \n";
			strSql += " 	     b.cb0,  \n";
			strSql += " 	     b.cb1,  \n";
			strSql += " 	     b.cb2,  \n";
			strSql += " 	     b.cb3,  \n";
			strSql += " 	     b.cb4,  \n";
			strSql += " 	     b.cb5,  \n";
			strSql += " 	     b.cb6,  \n";
			strSql += " 	     b.cb7,  \n";
			strSql += " 	     b.cb8,  \n";
			strSql += " 	     b.cb9,  \n";
			strSql += " 	     b.cb10, \n";
			strSql += " 	     b.cb11, \n";
			strSql += " 	     b.cb12, \n";
			strSql += " 	     b.cb0 - a.cb0  	sub_cb0 , \n";
			strSql += " 	     b.cb1 - a.cb1      sub_cb1 , \n";
			strSql += " 	     b.cb2 - a.cb2      sub_cb2 , \n";
			strSql += " 	     b.cb3 - a.cb3      sub_cb3 , \n";
			strSql += " 	     b.cb4 - a.cb4      sub_cb4 , \n";
			strSql += " 	     b.cb5 - a.cb5      sub_cb5 , \n";
			strSql += " 	     b.cb6 - a.cb6      sub_cb6 , \n";
			strSql += " 	     b.cb7 - a.cb7      sub_cb7 , \n";
			strSql += " 	     b.cb8 - a.cb8      sub_cb8 , \n";
			strSql += " 	     b.cb9 - a.cb9      sub_cb9 , \n";
			strSql += " 	     b.cb10- a.cb10     sub_cb10, \n";
			strSql += " 	     b.cb11- a.cb11     sub_cb11, \n";
			strSql += " 	     b.cb12- a.cb12     sub_cb12, \n";
			strSql += " 	     to_char(decode(b.cb0 , 0, 0, 100*(a.cb0 / b.cb0 )),'999.99') 	  r_cb0 , \n";
			strSql += " 	     to_char(decode(b.cb1 , 0, 0, 100*(a.cb1 / b.cb1 )),'999.99')     r_cb1 , \n";
			strSql += " 	     to_char(decode(b.cb2 , 0, 0, 100*(a.cb2 / b.cb2 )),'999.99')     r_cb2 , \n";
			strSql += " 	     to_char(decode(b.cb3 , 0, 0, 100*(a.cb3 / b.cb3 )),'999.99')     r_cb3 , \n";
			strSql += " 	     to_char(decode(b.cb4 , 0, 0, 100*(a.cb4 / b.cb4 )),'999.99')     r_cb4 , \n";
			strSql += " 	     to_char(decode(b.cb5 , 0, 0, 100*(a.cb5 / b.cb5 )),'999.99')     r_cb5 , \n";
			strSql += " 	     to_char(decode(b.cb6 , 0, 0, 100*(a.cb6 / b.cb6 )),'999.99')     r_cb6 , \n";
			strSql += " 	     to_char(decode(b.cb7 , 0, 0, 100*(a.cb7 / b.cb7 )),'999.99')     r_cb7 , \n";
			strSql += " 	     to_char(decode(b.cb8 , 0, 0, 100*(a.cb8 / b.cb8 )),'999.99')     r_cb8 , \n";
			strSql += " 	     to_char(decode(b.cb9 , 0, 0, 100*(a.cb9 / b.cb9 )),'999.99')     r_cb9 , \n";
			strSql += " 	     to_char(decode(b.cb10, 0, 0, 100*(a.cb10/ b.cb10)),'999.99')     r_cb10, \n";
			strSql += " 	     to_char(decode(b.cb11, 0, 0, 100*(a.cb11/ b.cb11)),'999.99')     r_cb11,        \n";
			strSql += " 	     to_char(decode(b.cb12, 0, 0, 100*(a.cb12/ b.cb12)),'999.99')     r_cb12        \n";
			strSql += " from	         \n";
			strSql += " 	(	         \n";
			strSql += " 	select		 			 \n";
			strSql += " 		'11' div, \n";
			strSql += " 		decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 		decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,'') dept_code, \n";
			strSql += " 		a.p_budg_code_no,							  	    \n";
			strSql += " 		a.budg_code_no, \n";
			strSql += " 		a.ACC_CODE,                                    \n";
			strSql += " 	    c_cb1 +  c_cb2 + c_cb3 + c_cb4 + c_cb5 + c_cb6 + c_cb7 + c_cb8 + c_cb9 + c_cb10 + c_cb11 + c_cb12 cb0,  \n";
			strSql += " 	    decode(  a.c_cb1,  0, 0, a.c_cb1) cb1,  \n";
			strSql += " 	    decode( a.c_cb2,  0, 0, a.c_cb2) cb2,  \n";
			strSql += " 	    decode( a.c_cb3,  0, 0, a.c_cb3) cb3,  \n";
			strSql += " 	    decode( a.c_cb4,  0, 0, a.c_cb4) cb4,  \n";
			strSql += " 	    decode( a.c_cb5,  0, 0, a.c_cb5) cb5,  \n";
			strSql += " 	    decode( a.c_cb6,  0, 0, a.c_cb6) cb6,  \n";
			strSql += " 	    decode( a.c_cb7,  0, 0, a.c_cb7) cb7,  \n";
			strSql += " 	    decode( a.c_cb8,  0, 0, a.c_cb8) cb8,  \n";
			strSql += " 	    decode( a.c_cb9,  0, 0, a.c_cb9) cb9,  \n";
			strSql += " 	    decode( a.c_cb10, 0, 0, a.c_cb1) cb10, \n";
			strSql += " 	    decode( a.c_cb11, 0, 0, a.c_cb1) cb11, \n";
			strSql += " 	    decode( a.c_cb12, 0, 0, a.c_cb1) cb12  \n";
			strSql += " 	from                        \n";
			strSql += " 		(                       \n";
			strSql += " 		select   \n";
			strSql += " 				decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 				decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code,                \n";
			strSql += " 			   	a.p_budg_code_no,							  	    \n";
			strSql += " 				a.budg_code_no, \n";
			strSql += " 				a.ACC_CODE,                                      			                                                       \n";
			strSql += " 		        sum( (CASE SUBSTR(a.BUDG_YM,1,4) WHEN  '" + strCLSE_ACC_ID_B4 +"'  THEN a.SIL_AMT ELSE 0 END) ) c_cb0, \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'01' THEN a.SIL_AMT ELSE 0 END) ) c_cb1,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'02' THEN a.SIL_AMT ELSE 0 END) ) c_cb2,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'03' THEN a.SIL_AMT ELSE 0 END) ) c_cb3,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'04' THEN a.SIL_AMT ELSE 0 END) ) c_cb4,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'05' THEN a.SIL_AMT ELSE 0 END) ) c_cb5,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'06' THEN a.SIL_AMT ELSE 0 END) ) c_cb6,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'07' THEN a.SIL_AMT ELSE 0 END) ) c_cb7,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'08' THEN a.SIL_AMT ELSE 0 END) ) c_cb8,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'09' THEN a.SIL_AMT ELSE 0 END) ) c_cb9,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'10' THEN a.SIL_AMT ELSE 0 END) ) c_cb10,      \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'11' THEN a.SIL_AMT ELSE 0 END) ) c_cb11,      \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'12' THEN a.SIL_AMT ELSE 0 END) ) c_cb12       \n";
			strSql += " 		from                                \n";
			strSql += " 			(                               \n";
			strSql += " 				select  decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 						decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code,                               				  \n";
			strSql += " 						a.p_budg_code_no,							  	    \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.ACC_CODE,                                     			  \n";
			strSql += " 			 	   		to_char(a.budg_ym,'YYYYMM') BUDG_YM,                     \n";
			strSql += " 				   		sum(nvl(SIL_AMT,0)) SIL_AMT \n";
			strSql += " 				from                               \n";
			strSql += " 					(	select                        \n";
			strSql += " 					  			a.comp_code,             \n";
			strSql += " 					  			a.clse_acc_id, \n";
			strSql += " 								decode( '" + strDEPT_FLAG +"' , 'ALL', '',d.chk_dept_code) chk_dept_code, \n";
			strSql += " 								decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code,             \n";
			strSql += " 					  			a.reserved_seq,          \n";
			strSql += " 					  			b.budg_ym, \n";
			strSql += " 								b.budg_code_no, \n";
			strSql += " 								c.p_budg_code_no,               \n";
			strSql += " 					  			b.budg_month_assign_amt, \n";
			strSql += " 					  			c.acc_code                       \n";
			strSql += " 						from  	t_budg_dept_item a,              \n";
			strSql += " 							  	t_budg_month_amt b,              \n";
			strSql += " 							  	t_budg_code      c, \n";
			strSql += " 								t_budg_dept_map  d               \n";
			strSql += " 						where 	a.comp_code = b.comp_code        \n";
			strSql += " 						and	  	a.clse_acc_id = b.clse_acc_id    \n";
			strSql += " 						and	  	a.dept_code = b.dept_code        \n";
			strSql += " 						and	  	a.budg_code_no = b.budg_code_no  \n";
			strSql += " 						and	  	a.reserved_seq = b.reserved_seq  \n";
			strSql += " 						and	  	a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += " 						and		a.dept_code	   = d.dept_code(+)  \n";
			strSql += " 				) a,                                                           \n";
			strSql += " 				(                                      \n";
			strSql += " 				SELECT decode( '" + strDEPT_FLAG +"' , 'DEPT', b.dept_code,'') dept_code,  \n";
			strSql += " 					   SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM, \n";
			strSql += " 					   b.ACC_CODE, SUM(b.DB_AMT+b.CR_AMT) SIL_AMT  \n";
			strSql += " 				FROM T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					 T_ACC_SLIP_BODY b,  \n";
			strSql += " 					 T_DEPT_CODE c \n";
			strSql += " 				WHERE a.SLIP_ID=b.SLIP_ID                                                   \n";
			strSql += " 				AND a.KEEP_SLIPNO is not null                        \n";
			strSql += " 				AND SUBSTR(a.MAKE_DT_TRANS,1,4) =  '" +strCLSE_ACC_ID_B4  +"'    \n";
			strSql += " 				and c.COMP_CODE =  '" + strCOMP_CODE +"'                                      \n";
			strSql += " 				and b.DEPT_CODE=c.DEPT_CODE                          \n";
			strSql += " 				GROUP BY decode( '" + strDEPT_FLAG +"' , 'DEPT', b.dept_code,''), \n";
			strSql += " 						    SUBSTR(a.MAKE_DT_TRANS,1,6), \n";
			strSql += " 					     b.ACC_CODE \n";
			strSql += " 				) b                                    \n";
			strSql += " 				where a.acc_code  = b.acc_code(+)                               \n";
			strSql += " 				and	  to_char(a.budg_ym,'YYYYMM') =  b.MAKE_YM(+)           \n";
			strSql += " 				and   a.comp_code =  '" +strCOMP_CODE  +"'                     \n";
			strSql += " 				and   a.clse_acc_id =  '" +strCLSE_ACC_ID_B4  +"'        \n";
			strSql += " 				group  by \n";
			strSql += " 					   	decode( '" + strDEPT_FLAG +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 						decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''),                                    \n";
			strSql += " 				   		a.p_budg_code_no,							  	    \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.ACC_CODE,                                  			  \n";
			strSql += " 				   		budg_ym       \n";
			strSql += " 			                     \n";
			strSql += " 		 	) a                  \n";
			strSql += " 		group by  \n";
			strSql += " 			   decode( '" +strDEPT_FLAG+"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 			   decode( '" +strDEPT_FLAG+"' , 'DEPT', a.dept_code,''),                \n";
			strSql += " 			   a.p_budg_code_no,							  	    \n";
			strSql += " 			   a.budg_code_no, \n";
			strSql += " 			   a.ACC_CODE                                                                         \n";
			strSql += " 		) a \n";
			strSql += " 	   \n";
			strSql += " 	  union  \n";
			strSql += " 	  select \n";
			strSql += " 		  	'12' div, \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code, \n";
			strSql += " 			a.p_budg_code_no,							  	    \n";
			strSql += " 			100000000000000 budg_code_no, \n";
			strSql += " 			'100000000000000' ACC_CODE,           \n";
			strSql += " 			sum(cb1 + cb2 + cb3 + cb4 + cb5 + cb6 + cb7 + cb8 + cb9 + cb10 + cb11 + cb12) cb0,                           \n";
			strSql += " 		    sum(cb1) cb1,  \n";
			strSql += " 		    sum(cb2) cb2, \n";
			strSql += " 		    sum(cb3) cb3 ,  \n";
			strSql += " 		    sum(cb4) cb4 ,  \n";
			strSql += " 		    sum(cb5) cb5,  \n";
			strSql += " 		    sum(cb6) cb6 ,  \n";
			strSql += " 		    sum(cb7) cb7 ,  \n";
			strSql += " 		    sum(cb8) cb8 ,  \n";
			strSql += " 		    sum(cb9) cb9 ,  \n";
			strSql += " 		    sum(cb10)cb10 , \n";
			strSql += " 		    sum(cb11)cb11 , \n";
			strSql += " 		    sum(cb12) cb12  \n";
			strSql += " 	from \n";
			strSql += " 		(	 \n";
			strSql += " 		select \n";
			strSql += " 			decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code, 					 \n";
			strSql += " 			a.p_budg_code_no,							  	    \n";
			strSql += " 			a.budg_code_no, \n";
			strSql += " 			a.ACC_CODE,                                 \n";
			strSql += " 		    decode( a.c_cb1,  0, 0, a.c_cb1) cb1,  \n";
			strSql += " 		    decode( a.c_cb2,  0, 0, a.c_cb2) cb2,  \n";
			strSql += " 		    decode( a.c_cb3,  0, 0, a.c_cb3) cb3,  \n";
			strSql += " 		    decode( a.c_cb4,  0, 0, a.c_cb4) cb4,  \n";
			strSql += " 		    decode( a.c_cb5,  0, 0, a.c_cb5) cb5,  \n";
			strSql += " 		    decode( a.c_cb6,  0, 0, a.c_cb6) cb6,  \n";
			strSql += " 		    decode( a.c_cb7,  0, 0, a.c_cb7) cb7,  \n";
			strSql += " 		    decode( a.c_cb8,  0, 0, a.c_cb8) cb8,  \n";
			strSql += " 		    decode( a.c_cb9,  0, 0, a.c_cb9) cb9,  \n";
			strSql += " 		    decode( a.c_cb10, 0, 0, a.c_cb1) cb10, \n";
			strSql += " 		    decode( a.c_cb11, 0, 0, a.c_cb1) cb11, \n";
			strSql += " 		    decode( a.c_cb12, 0, 0, a.c_cb1) cb12  \n";
			strSql += " 		from                        \n";
			strSql += " 			(                       \n";
			strSql += " 			select    \n";
			strSql += " 					decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 					decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,'') dept_code,               \n";
			strSql += " 				   	a.p_budg_code_no,							  	    \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					a.ACC_CODE,                                       			                                                       \n";
			strSql += " 			        sum( (CASE SUBSTR(a.BUDG_YM,1,4) WHEN  '" +strCLSE_ACC_ID_B4  +"'  THEN a.SIL_AMT ELSE 0 END) ) c_cb0, \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID_B4  +"' ||'01' THEN a.SIL_AMT ELSE 0 END) ) c_cb1,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'02' THEN a.SIL_AMT ELSE 0 END) ) c_cb2,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID_B4  +"' ||'03' THEN a.SIL_AMT ELSE 0 END) ) c_cb3,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID_B4  +"' ||'04' THEN a.SIL_AMT ELSE 0 END) ) c_cb4,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID_B4  +"' ||'05' THEN a.SIL_AMT ELSE 0 END) ) c_cb5,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'06' THEN a.SIL_AMT ELSE 0 END) ) c_cb6,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'07' THEN a.SIL_AMT ELSE 0 END) ) c_cb7,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'08' THEN a.SIL_AMT ELSE 0 END) ) c_cb8,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID_B4 +"' ||'09' THEN a.SIL_AMT ELSE 0 END) ) c_cb9,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID_B4  +"' ||'10' THEN a.SIL_AMT ELSE 0 END) ) c_cb10,      \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID_B4  +"' ||'11' THEN a.SIL_AMT ELSE 0 END) ) c_cb11,      \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID_B4  +"' ||'12' THEN a.SIL_AMT ELSE 0 END) ) c_cb12       \n";
			strSql += " 			from                                \n";
			strSql += " 				(                               \n";
			strSql += " 					select   \n";
			strSql += " 							decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 							decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code,                               \n";
			strSql += " 							a.p_budg_code_no,							  	    \n";
			strSql += " 							a.budg_code_no, \n";
			strSql += " 							a.ACC_CODE,                                      			  \n";
			strSql += " 				 	   		to_char(a.budg_ym,'YYYYMM') BUDG_YM,                     \n";
			strSql += " 					   		sum(nvl(SIL_AMT,0)) SIL_AMT \n";
			strSql += " 					from                               \n";
			strSql += " 						(	select                        \n";
			strSql += " 						  			a.comp_code,             \n";
			strSql += " 						  			a.clse_acc_id,           \n";
			strSql += " 						  			decode( '" +strDEPT_FLAG  +"' , 'ALL', '',d.chk_dept_code) chk_dept_code, \n";
			strSql += " 									decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,'') dept_code,             \n";
			strSql += " 						  			a.reserved_seq,          \n";
			strSql += " 						  			b.budg_ym, \n";
			strSql += " 									b.budg_code_no, \n";
			strSql += " 									c.p_budg_code_no,               \n";
			strSql += " 						  			b.budg_month_assign_amt, \n";
			strSql += " 						  			c.acc_code                       \n";
			strSql += " 							from  	t_budg_dept_item a,              \n";
			strSql += " 								  	t_budg_month_amt b,              \n";
			strSql += " 								  	t_budg_code      c, \n";
			strSql += " 									t_budg_dept_map  d             \n";
			strSql += " 							where 	a.comp_code = b.comp_code        \n";
			strSql += " 							and	  	a.clse_acc_id = b.clse_acc_id    \n";
			strSql += " 							and	  	a.dept_code = b.dept_code        \n";
			strSql += " 							and	  	a.budg_code_no = b.budg_code_no  \n";
			strSql += " 							and	  	a.reserved_seq = b.reserved_seq  \n";
			strSql += " 							and	  	a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += " 							and		a.dept_code	   = d.dept_code(+)  \n";
			strSql += " 					) a,                                                          \n";
			strSql += " 					(                                      \n";
			strSql += " 					SELECT decode( '" +strDEPT_FLAG  +"' , 'DEPT', b.dept_code,'') dept_code,  \n";
			strSql += " 						    SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM, \n";
			strSql += " 						   b.ACC_CODE, SUM(b.DB_AMT+b.CR_AMT) SIL_AMT  \n";
			strSql += " 					FROM T_ACC_SLIP_HEAD a, T_ACC_SLIP_BODY b, T_DEPT_CODE c \n";
			strSql += " 					WHERE a.SLIP_ID=b.SLIP_ID                                                   \n";
			strSql += " 					AND a.KEEP_SLIPNO is not null                        \n";
			strSql += " 					AND SUBSTR(a.MAKE_DT_TRANS,1,4) =  '" +strCLSE_ACC_ID_B4  +"'    \n";
			strSql += " 					and c.COMP_CODE =  '" +strCOMP_CODE  +"'                                      \n";
			strSql += " 					and b.DEPT_CODE=c.DEPT_CODE                          \n";
			strSql += " 					GROUP BY decode( '" + strDEPT_FLAG +"' , 'DEPT', b.dept_code,''),  \n";
			strSql += " 						        SUBSTR(a.MAKE_DT_TRANS,1,6), \n";
			strSql += " 						       b.ACC_CODE \n";
			strSql += " 					) b \n";
			strSql += " 					where a.acc_code  = b.acc_code(+)            \n";
			strSql += " 					and	  to_char(a.budg_ym,'YYYYMM') =  b.MAKE_YM(+)           \n";
			strSql += " 					and   a.comp_code =  '" +strCOMP_CODE  +"'                     \n";
			strSql += " 					and   a.clse_acc_id =  '" + strCLSE_ACC_ID_B4 +"'        \n";
			strSql += " 					group  by \n";
			strSql += " 						   	decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 							decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''),                                    \n";
			strSql += " 					   		a.p_budg_code_no,							  	    \n";
			strSql += " 							a.budg_code_no, \n";
			strSql += " 							a.ACC_CODE,                                 			  \n";
			strSql += " 					   		budg_ym       \n";
			strSql += " 				                     \n";
			strSql += " 			 	) a                  \n";
			strSql += " 			group by \n";
			strSql += " 				   decode( '" + strDEPT_FLAG +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 				   decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''),                 \n";
			strSql += " 				   a.p_budg_code_no,							  	    \n";
			strSql += " 				   a.budg_code_no, \n";
			strSql += " 				   a.ACC_CODE                                                                             \n";
			strSql += " 			) a \n";
			strSql += " 	) a \n";
			strSql += " 	group by decode( '" +  strDEPT_FLAG+"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 			 decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''), \n";
			strSql += " 		  	 a.p_budg_code_no \n";
			strSql += " 	 \n";
			strSql += " 	) a, --전년 \n";
			strSql += " 	( \n";
			strSql += " 	select					 \n";
			strSql += " 		'11' div, \n";
			strSql += " 		decode( '" + strDEPT_FLAG +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 		decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code, \n";
			strSql += " 		a.p_budg_code_no,							  	    \n";
			strSql += " 		a.budg_code_no, \n";
			strSql += " 		a.ACC_CODE,                                 \n";
			strSql += " 	    c_cb1 + c_cb2 + c_cb3 + c_cb4 + c_cb5 + c_cb6 + c_cb7 + c_cb8 + c_cb9 + c_cb10 + c_cb11 + c_cb12 cb0,  \n";
			strSql += " 	    decode( a.c_cb1,  0, 0, a.c_cb1) cb1,  \n";
			strSql += " 	    decode( a.c_cb2,  0, 0, a.c_cb2) cb2,  \n";
			strSql += " 	    decode( a.c_cb3,  0, 0, a.c_cb3) cb3,  \n";
			strSql += " 	    decode( a.c_cb4,  0, 0, a.c_cb4) cb4,  \n";
			strSql += " 	    decode( a.c_cb5,  0, 0, a.c_cb5) cb5,  \n";
			strSql += " 	    decode( a.c_cb6,  0, 0, a.c_cb6) cb6,  \n";
			strSql += " 	    decode( a.c_cb7,  0, 0, a.c_cb7) cb7,  \n";
			strSql += " 	    decode( a.c_cb8,  0, 0, a.c_cb8) cb8,  \n";
			strSql += " 	    decode( a.c_cb9,  0, 0, a.c_cb9) cb9,  \n";
			strSql += " 	    decode( a.c_cb10, 0, 0, a.c_cb1) cb10, \n";
			strSql += " 	    decode( a.c_cb11, 0, 0, a.c_cb1) cb11, \n";
			strSql += " 	    decode( a.c_cb12, 0, 0, a.c_cb1) cb12  \n";
			strSql += " 	from                        \n";
			strSql += " 		(                       \n";
			strSql += " 		select  decode( '" +  strDEPT_FLAG+"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 				decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,'') dept_code,                \n";
			strSql += " 			   	a.p_budg_code_no,							  	    \n";
			strSql += " 				a.budg_code_no, \n";
			strSql += " 				a.ACC_CODE,                                      			                                                       \n";
			strSql += " 		        sum( (CASE SUBSTR(a.BUDG_YM,1,4) WHEN  '" +strCLSE_ACC_ID  +"'  THEN a.SIL_AMT ELSE 0 END) ) c_cb0, \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID  +"' ||'01' THEN a.SIL_AMT ELSE 0 END) ) c_cb1,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'02' THEN a.SIL_AMT ELSE 0 END) ) c_cb2,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" +strCLSE_ACC_ID  +"' ||'03' THEN a.SIL_AMT ELSE 0 END) ) c_cb3,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'04' THEN a.SIL_AMT ELSE 0 END) ) c_cb4,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'05' THEN a.SIL_AMT ELSE 0 END) ) c_cb5,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID  +"' ||'06' THEN a.SIL_AMT ELSE 0 END) ) c_cb6,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'07' THEN a.SIL_AMT ELSE 0 END) ) c_cb7,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'08' THEN a.SIL_AMT ELSE 0 END) ) c_cb8,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'09' THEN a.SIL_AMT ELSE 0 END) ) c_cb9,       \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'10' THEN a.SIL_AMT ELSE 0 END) ) c_cb10,      \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'11' THEN a.SIL_AMT ELSE 0 END) ) c_cb11,      \n";
			strSql += " 		        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'12' THEN a.SIL_AMT ELSE 0 END) ) c_cb12       \n";
			strSql += " 		from                                \n";
			strSql += " 			(                               \n";
			strSql += " 				select   \n";
			strSql += " 						decode( '" +  strDEPT_FLAG+"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 						decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code,                               \n";
			strSql += " 						a.p_budg_code_no,							  	    \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.ACC_CODE,                                      			  \n";
			strSql += " 			 	   		to_char(a.budg_ym,'YYYYMM') BUDG_YM,                     \n";
			strSql += " 				   		sum(nvl(SIL_AMT,0)) SIL_AMT \n";
			strSql += " 				from                               \n";
			strSql += " 					(	select                        \n";
			strSql += " 					  			a.comp_code,             \n";
			strSql += " 					  			a.clse_acc_id,           \n";
			strSql += " 					  			decode( '" + strDEPT_FLAG +"' , 'ALL', '',d.chk_dept_code) chk_dept_code, \n";
			strSql += " 								decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code,             \n";
			strSql += " 					  			a.reserved_seq,          \n";
			strSql += " 					  			b.budg_ym, \n";
			strSql += " 								b.budg_code_no, \n";
			strSql += " 								c.p_budg_code_no,               \n";
			strSql += " 					  			b.budg_month_assign_amt, \n";
			strSql += " 					  			c.acc_code                       \n";
			strSql += " 						from  	t_budg_dept_item a,              \n";
			strSql += " 							  	t_budg_month_amt b,              \n";
			strSql += " 							  	t_budg_code      c, \n";
			strSql += " 								t_budg_dept_map  d               \n";
			strSql += " 						where 	a.comp_code = b.comp_code        \n";
			strSql += " 						and	  	a.clse_acc_id = b.clse_acc_id    \n";
			strSql += " 						and	  	a.dept_code = b.dept_code        \n";
			strSql += " 						and	  	a.budg_code_no = b.budg_code_no  \n";
			strSql += " 						and	  	a.reserved_seq = b.reserved_seq  \n";
			strSql += " 						and	  	a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += " 						and		a.dept_code	   = d.dept_code(+)  \n";
			strSql += " 				) a,                                                         \n";
			strSql += " 				(                                      \n";
			strSql += " 				SELECT decode( '" +  strDEPT_FLAG+"' , 'DEPT', b.dept_code,'') dept_code, \n";
			strSql += " 					    SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM, \n";
			strSql += " 				      	   b.ACC_CODE,  \n";
			strSql += " 					   SUM(b.DB_AMT+b.CR_AMT) SIL_AMT  \n";
			strSql += " 				FROM T_ACC_SLIP_HEAD a,  \n";
			strSql += " 					 T_ACC_SLIP_BODY b,  \n";
			strSql += " 					 T_DEPT_CODE c \n";
			strSql += " 				WHERE a.SLIP_ID=b.SLIP_ID                                                   \n";
			strSql += " 				AND a.KEEP_SLIPNO is not null                        \n";
			strSql += " 				AND SUBSTR(a.MAKE_DT_TRANS,1,4) =  '" +strCLSE_ACC_ID  +"'    \n";
			strSql += " 				and c.COMP_CODE =  '" +strCOMP_CODE  +"'                                      \n";
			strSql += " 				and b.DEPT_CODE=c.DEPT_CODE                          \n";
			strSql += " 				GROUP BY decode( '" +strDEPT_FLAG  +"' , 'DEPT', b.dept_code,''), \n";
			strSql += " 						  SUBSTR(a.MAKE_DT_TRANS,1,6), \n";
			strSql += " 						 b.ACC_CODE \n";
			strSql += " 				) b \n";
			strSql += " 				where a.acc_code  = b.acc_code(+)                             \n";
			strSql += " 				and	  to_char(a.budg_ym,'YYYYMM') =  b.MAKE_YM(+)           \n";
			strSql += " 				and   a.clse_acc_id =  '" +strCLSE_ACC_ID  +"'        \n";
			strSql += " 				group  by  \n";
			strSql += " 					   	decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 						decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''),                                   \n";
			strSql += " 				   		a.p_budg_code_no,							  	    \n";
			strSql += " 						a.budg_code_no, \n";
			strSql += " 						a.ACC_CODE,                                  			  \n";
			strSql += " 				   		budg_ym       \n";
			strSql += " 			                     \n";
			strSql += " 		 	) a                  \n";
			strSql += " 		group by  \n";
			strSql += " 			   decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 			   decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''),                \n";
			strSql += " 			   a.p_budg_code_no,							  	    \n";
			strSql += " 			   a.budg_code_no, \n";
			strSql += " 			   a.ACC_CODE                                                                             \n";
			strSql += " 		) a \n";
			strSql += " 	   \n";
			strSql += " 	  union  \n";
			strSql += " 	  select \n";
			strSql += " 		  	'12' div, \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code, \n";
			strSql += " 			a.p_budg_code_no,							  	    \n";
			strSql += " 			100000000000000 budg_code_no, \n";
			strSql += " 			'100000000000000' ACC_CODE,           \n";
			strSql += " 			sum(cb1 + cb2 + cb3 + cb4 + cb5 + cb6 + cb7 + cb8 + cb9 + cb10 + cb11 + cb12) cb0,                           \n";
			strSql += " 		    sum(cb1) cb1,  \n";
			strSql += " 		    sum(cb2) cb2, \n";
			strSql += " 		    sum(cb3) cb3 ,  \n";
			strSql += " 		    sum(cb4) cb4 ,  \n";
			strSql += " 		    sum(cb5) cb5,  \n";
			strSql += " 		    sum(cb6) cb6 ,  \n";
			strSql += " 		    sum(cb7) cb7 ,  \n";
			strSql += " 		    sum(cb8) cb8 ,  \n";
			strSql += " 		    sum(cb9) cb9 ,  \n";
			strSql += " 		    sum(cb10)cb10 , \n";
			strSql += " 		    sum(cb11)cb11 , \n";
			strSql += " 		    sum(cb12) cb12  \n";
			strSql += " 	from \n";
			strSql += " 		(	 \n";
			strSql += " 		select \n";
			strSql += " 			decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 			decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,'') dept_code,					 \n";
			strSql += " 			a.p_budg_code_no,							  	    \n";
			strSql += " 			a.budg_code_no, \n";
			strSql += " 			a.ACC_CODE,                                    \n";
			strSql += " 		    decode( a.c_cb1,  0, 0, a.c_cb1) cb1,  \n";
			strSql += " 		    decode( a.c_cb2,  0, 0, a.c_cb2) cb2,  \n";
			strSql += " 		    decode( a.c_cb3,  0, 0, a.c_cb3) cb3,  \n";
			strSql += " 		    decode( a.c_cb4,  0, 0, a.c_cb4) cb4,  \n";
			strSql += " 		    decode( a.c_cb5,  0, 0, a.c_cb5) cb5,  \n";
			strSql += " 		    decode( a.c_cb6,  0, 0, a.c_cb6) cb6,  \n";
			strSql += " 		    decode( a.c_cb7,  0, 0, a.c_cb7) cb7,  \n";
			strSql += " 		    decode( a.c_cb8,  0, 0, a.c_cb8) cb8,  \n";
			strSql += " 		    decode( a.c_cb9,  0, 0, a.c_cb9) cb9,  \n";
			strSql += " 		    decode( a.c_cb10, 0, 0, a.c_cb1) cb10, \n";
			strSql += " 		    decode( a.c_cb11, 0, 0, a.c_cb1) cb11, \n";
			strSql += " 		    decode( a.c_cb12, 0, 0, a.c_cb1) cb12  \n";
			strSql += " 		from                        \n";
			strSql += " 			(                       \n";
			strSql += " 			select  decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 					decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,'') dept_code,                \n";
			strSql += " 				   	a.p_budg_code_no,							  	    \n";
			strSql += " 					a.budg_code_no, \n";
			strSql += " 					a.ACC_CODE,                                       			                                                       \n";
			strSql += " 			        sum( (CASE SUBSTR(a.BUDG_YM,1,4) WHEN  '" + strCLSE_ACC_ID +"'  THEN a.SIL_AMT ELSE 0 END) ) c_cb0, \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'01' THEN a.SIL_AMT ELSE 0 END) ) c_cb1,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'02' THEN a.SIL_AMT ELSE 0 END) ) c_cb2,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'03' THEN a.SIL_AMT ELSE 0 END) ) c_cb3,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'04' THEN a.SIL_AMT ELSE 0 END) ) c_cb4,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'05' THEN a.SIL_AMT ELSE 0 END) ) c_cb5,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'06' THEN a.SIL_AMT ELSE 0 END) ) c_cb6,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'07' THEN a.SIL_AMT ELSE 0 END) ) c_cb7,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'08' THEN a.SIL_AMT ELSE 0 END) ) c_cb8,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'09' THEN a.SIL_AMT ELSE 0 END) ) c_cb9,       \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'10' THEN a.SIL_AMT ELSE 0 END) ) c_cb10,      \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'11' THEN a.SIL_AMT ELSE 0 END) ) c_cb11,      \n";
			strSql += " 			        sum( (CASE a.BUDG_YM WHEN  '" + strCLSE_ACC_ID +"' ||'12' THEN a.SIL_AMT ELSE 0 END) ) c_cb12       \n";
			strSql += " 			from                                \n";
			strSql += " 				(                               \n";
			strSql += " 					select  decode( '" + strDEPT_FLAG +"' , 'ALL', '',a.chk_dept_code) chk_dept_code, \n";
			strSql += " 							decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,'') dept_code,                               \n";
			strSql += " 							a.p_budg_code_no,							  	    \n";
			strSql += " 							a.budg_code_no, \n";
			strSql += " 							a.ACC_CODE,                                      			  \n";
			strSql += " 				 	   		to_char(a.budg_ym,'YYYYMM') BUDG_YM,                     \n";
			strSql += " 					   		sum(nvl(SIL_AMT,0)) SIL_AMT \n";
			strSql += " 					from                               \n";
			strSql += " 						(	select                        \n";
			strSql += " 						  			a.comp_code,             \n";
			strSql += " 						  			a.clse_acc_id,           \n";
			strSql += " 						  			decode( '" +strDEPT_FLAG  +"' , 'ALL', '',d.chk_dept_code) chk_dept_code, \n";
			strSql += " 									decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,'') dept_code,             \n";
			strSql += " 						  			a.reserved_seq,          \n";
			strSql += " 						  			b.budg_ym, \n";
			strSql += " 									b.budg_code_no, \n";
			strSql += " 									c.p_budg_code_no,               \n";
			strSql += " 						  			b.budg_month_assign_amt, \n";
			strSql += " 						  			c.acc_code                       \n";
			strSql += " 							from  	t_budg_dept_item a,              \n";
			strSql += " 								  	t_budg_month_amt b,              \n";
			strSql += " 								  	t_budg_code      c, \n";
			strSql += " 									t_budg_dept_map  d              \n";
			strSql += " 							where 	a.comp_code = b.comp_code        \n";
			strSql += " 							and	  	a.clse_acc_id = b.clse_acc_id    \n";
			strSql += " 							and	  	a.dept_code = b.dept_code        \n";
			strSql += " 							and	  	a.budg_code_no = b.budg_code_no  \n";
			strSql += " 							and	  	a.reserved_seq = b.reserved_seq  \n";
			strSql += " 							and	  	a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += " 							and		a.dept_code    = d.dept_code(+) \n";
			strSql += " 					) a,                                                          \n";
			strSql += " 					(                                      \n";
			strSql += " 					SELECT decode( '" + strDEPT_FLAG +"' , 'DEPT', b.dept_code,'') dept_code,  \n";
			strSql += " 								SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM, \n";
			strSql += " 						   b.ACC_CODE, SUM(b.DB_AMT+b.CR_AMT) SIL_AMT  \n";
			strSql += " 					FROM T_ACC_SLIP_HEAD a,  \n";
			strSql += " 						 T_ACC_SLIP_BODY b,  \n";
			strSql += " 						 T_DEPT_CODE c \n";
			strSql += " 					WHERE a.SLIP_ID=b.SLIP_ID                                                   \n";
			strSql += " 					AND a.KEEP_SLIPNO is not null                        \n";
			strSql += " 					AND SUBSTR(a.MAKE_DT_TRANS,1,4) =  '" +strCLSE_ACC_ID  +"'    \n";
			strSql += " 					and c.COMP_CODE =  '" + strCOMP_CODE +"'                                      \n";
			strSql += " 					and b.DEPT_CODE=c.DEPT_CODE                          \n";
			strSql += " 					GROUP BY decode( '" +strDEPT_FLAG  +"' , 'DEPT', b.dept_code,''), \n";
			strSql += " 						    SUBSTR(a.MAKE_DT_TRANS,1,6), \n";
			strSql += " 						    b.ACC_CODE \n";
			strSql += " 					) b                                   \n";
			strSql += " 					 \n";
			strSql += " 					where a.acc_code  = b.acc_code(+)            \n";
			strSql += " 					and	  to_char(a.budg_ym,'YYYYMM') =  b.MAKE_YM(+)           \n";
			strSql += " 					and   a.comp_code =  '" +strCOMP_CODE  +"'                     \n";
			strSql += " 					and   a.clse_acc_id =  '" +strCLSE_ACC_ID  +"'        \n";
			strSql += " 					group  by  \n";
			strSql += " 						   	decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 							decode( '" +strDEPT_FLAG  +"' , 'DEPT', a.dept_code,''),                                   \n";
			strSql += " 					   		a.p_budg_code_no,							  	    \n";
			strSql += " 							a.budg_code_no, \n";
			strSql += " 							a.ACC_CODE,                                   			  \n";
			strSql += " 					   		budg_ym       \n";
			strSql += " 				                     \n";
			strSql += " 			 	) a                  \n";
			strSql += " 			group by   \n";
			strSql += " 				   decode( '" + strDEPT_FLAG +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 				   decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''),               \n";
			strSql += " 				   a.p_budg_code_no,							  	    \n";
			strSql += " 				   a.budg_code_no, \n";
			strSql += " 				   a.ACC_CODE                                                                           \n";
			strSql += " 			) a \n";
			strSql += " 	) a \n";
			strSql += " 	group by \n";
			strSql += " 		  	decode( '" +strDEPT_FLAG  +"' , 'ALL', '',a.chk_dept_code), \n";
			strSql += " 			decode( '" + strDEPT_FLAG +"' , 'DEPT', a.dept_code,''),  \n";
			strSql += " 			a.p_budg_code_no \n";
			strSql += " 	 \n";
			strSql += " 	) b, \n";
			strSql += " 	t_budg_code c, \n";
			strSql += " 	t_acc_code  d, \n";
			strSql += " 	t_dept_code e1, \n";
			strSql += " 	t_dept_code e2 \n";
			strSql += " where a.p_budg_code_no = b.p_budg_code_no(+) \n";
			strSql += " and   a.budg_code_no = b.budg_code_no(+) \n";
			strSql += " and   a.acc_code=b.acc_code(+) \n";
			strSql += " and	  a.p_budg_code_no = c.budg_code_no(+) \n";
			strSql += " and	  a.acc_code = d.acc_code(+) \n";
			strSql += " and	  a.chk_dept_code = e1.dept_code(+) \n";
			strSql += " and	  a.dept_code = e2.dept_code(+) \n";
			strSql += " and	  (decode( '" + strDEPT_FLAG +"' , 'CHK_DEPT', a.chk_dept_code, 'DEPT', a.dept_code) like '%' ||  '" + strDEPT_CODE +"'  || '%'  \n";
			strSql += " 	  or a.chk_dept_code is null) \n";
			strSql += " order by 2, 3, 6, 1, 8 ";
                                                              
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
