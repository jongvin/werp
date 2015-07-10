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

		if (strAct.equals("LIST00"))
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
			String vBudgYyyy = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));
			String vDeptFlag = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
			String vBudgFlag = CITCommon.toKOR(request.getParameter("BUDG_FLAG")); 
			String vBudgYyyyB4 = CITCommon.toKOR(request.getParameter("BUDG_YYYY_B4"));
			
			strSql  = "select					\n";
			strSql += "			a.COMP_CODE,    \n";
			strSql += "			a.COMPANY_NAME, \n";
			strSql += "			a.dept_code,    \n";
			strSql += " 			(                                                                      					\n";         
			strSql += " 			CASE '"+vDeptFlag+"' WHEN 'CHK_DEPT'	THEN a.CHK_DEPT_NAME      \n";               
	 		strSql += " 			WHEN 'DEPT'		THEN a.DEPT_NAME                           \n";         
			strSql += " 			ELSE '' END                                             				\n";
			strSql += " 			) DEPT_TITLE, \n";
			strSql += "			a.ACC_CODE,          \n";
			strSql += "			a.ACC_NAME,          \n";
			strSql += "			b.rn,                \n";
			strSql += "		    decode(b.rn, 1, '전년     ',  2, '금년     ',  3, '증감(%)') rn_name,   \n";                
			strSql += "		    decode(b.rn, 1, a.b_cb0,  2, a.c_cb0,  3, decode( a.b_cb0,  0, 0, 100*(a.c_cb0 -a.b_cb0 )/a.b_cb0  ), 0) cb0, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb1,  2, a.c_cb1,  3, decode( a.b_cb1,  0, 0, 100*(a.c_cb1 -a.b_cb1 )/a.b_cb1  ), 0) cb1, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb2,  2, a.c_cb2,  3, decode( a.b_cb2,  0, 0, 100*(a.c_cb2 -a.b_cb2 )/a.b_cb2  ), 0) cb2, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb3,  2, a.c_cb3,  3, decode( a.b_cb3,  0, 0, 100*(a.c_cb3 -a.b_cb3 )/a.b_cb3  ), 0) cb3, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb4,  2, a.c_cb4,  3, decode( a.b_cb4,  0, 0, 100*(a.c_cb4 -a.b_cb4 )/a.b_cb4  ), 0) cb4, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb5,  2, a.c_cb5,  3, decode( a.b_cb5,  0, 0, 100*(a.c_cb5 -a.b_cb5 )/a.b_cb5  ), 0) cb5, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb6,  2, a.c_cb6,  3, decode( a.b_cb6,  0, 0, 100*(a.c_cb6 -a.b_cb6 )/a.b_cb6  ), 0) cb6, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb7,  2, a.c_cb7,  3, decode( a.b_cb7,  0, 0, 100*(a.c_cb7 -a.b_cb7 )/a.b_cb7  ), 0) cb7, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb8,  2, a.c_cb8,  3, decode( a.b_cb8,  0, 0, 100*(a.c_cb8 -a.b_cb8 )/a.b_cb8  ), 0) cb8, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb9,  2, a.c_cb9,  3, decode( a.b_cb9,  0, 0, 100*(a.c_cb9 -a.b_cb9 )/a.b_cb9  ), 0) cb9, \n";
			strSql += "		    decode(b.rn, 1, a.b_cb10, 2, a.c_cb10, 3, decode( a.b_cb10, 0, 0, 100*(a.c_cb10-a.b_cb10)/a.b_cb10 ), 0) cb10,\n";
			strSql += "		    decode(b.rn, 1, a.b_cb11, 2, a.c_cb11, 3, decode( a.b_cb11, 0, 0, 100*(a.c_cb11-a.b_cb11)/a.b_cb11 ), 0) cb11,\n";
			strSql += "		    decode(b.rn, 1, a.b_cb12, 2, a.c_cb12, 3, decode( a.b_cb12, 0, 0, 100*(a.c_cb12-a.b_cb12)/a.b_cb12 ), 0) cb12 \n";
			strSql += "		from                       \n";
			strSql += "			(                      \n";
			strSql += "			select                 \n";
			strSql += "				   a.comp_code,    \n";
			strSql += "				   a.company_name, \n";
			strSql += " 		  			DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) CHK_DEPT_CODE,  \n";
		  	strSql += " 		  			DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) CHK_DEPT_NAME,  \n";
		  	strSql += " 		   			DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code, \n";
		   	strSql += " 		   			DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) dept_name, \n";
			strSql += "				   a.ACC_CODE,      \n";
			strSql += "				   a.ACC_NAME,      \n";                            			 
			strSql += "				sum( (CASE SUBSTR(a.BUDG_YM,1,4) WHEN '"+vBudgYyyyB4+"' THEN a.SIL_AMT ELSE 0 END) ) b_cb0,\n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'01' THEN a.SIL_AMT ELSE 0 END) ) b_cb1,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'02' THEN a.SIL_AMT ELSE 0 END) ) b_cb2,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'03' THEN a.SIL_AMT ELSE 0 END) ) b_cb3,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'04' THEN a.SIL_AMT ELSE 0 END) ) b_cb4,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'05' THEN a.SIL_AMT ELSE 0 END) ) b_cb5,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'06' THEN a.SIL_AMT ELSE 0 END) ) b_cb6,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'07' THEN a.SIL_AMT ELSE 0 END) ) b_cb7,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'08' THEN a.SIL_AMT ELSE 0 END) ) b_cb8,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'09' THEN a.SIL_AMT ELSE 0 END) ) b_cb9,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'10' THEN a.SIL_AMT ELSE 0 END) ) b_cb10,     \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'11' THEN a.SIL_AMT ELSE 0 END) ) b_cb11,     \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyyB4+"'||'12' THEN a.SIL_AMT ELSE 0 END) ) b_cb12,     \n";
			strSql += "		                                                                                        \n";
			strSql += "		        sum( (CASE SUBSTR(a.BUDG_YM,1,4) WHEN '"+vBudgYyyy+"' THEN a.SIL_AMT ELSE 0 END) ) c_cb0,\n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'01' THEN a.SIL_AMT ELSE 0 END) ) c_cb1,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'02' THEN a.SIL_AMT ELSE 0 END) ) c_cb2,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'03' THEN a.SIL_AMT ELSE 0 END) ) c_cb3,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'04' THEN a.SIL_AMT ELSE 0 END) ) c_cb4,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'05' THEN a.SIL_AMT ELSE 0 END) ) c_cb5,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'06' THEN a.SIL_AMT ELSE 0 END) ) c_cb6,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'07' THEN a.SIL_AMT ELSE 0 END) ) c_cb7,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'08' THEN a.SIL_AMT ELSE 0 END) ) c_cb8,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'09' THEN a.SIL_AMT ELSE 0 END) ) c_cb9,      \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'10' THEN a.SIL_AMT ELSE 0 END) ) c_cb10,     \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'11' THEN a.SIL_AMT ELSE 0 END) ) c_cb11,     \n";
			strSql += "		        sum( (CASE a.BUDG_YM WHEN '"+vBudgYyyy+"'||'12' THEN a.SIL_AMT ELSE 0 END) ) c_cb12      \n";
			strSql += "			from                               \n";
			strSql += "				(                              \n";
			strSql += "				select                         \n";
			strSql += "					   a.comp_code,            \n";
			strSql += "					   company_name,           \n";
			strSql += " 		   	  		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) CHK_DEPT_CODE, \n";
		   	strSql += " 		   	                 DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) CHK_DEPT_NAME, \n";
		   	strSql += " 		   	                 DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) dept_code,  \n";
		   	strSql += " 		   	                 DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) dept_name, \n";
			strSql += "					   a.ACC_CODE,    \n";
			strSql += "					   b.ACC_NAME,    \n";                                			 
			strSql += "				 	   to_char(a.budg_ym,'YYYYMM') BUDG_YM,                    \n";
			strSql += "					   sum(nvl(SIL_AMT,0)) SIL_AMT\n";
			strSql += "				from                              \n";
			strSql += "					(select                       \n";
			strSql += "						  a.comp_code,            \n";
			strSql += "						  a.clse_acc_id,          \n";
			strSql += "						  a.dept_code,            \n";
			strSql += "						  a.reserved_seq,         \n";
			strSql += "						  a.budg_item_req_amt,    \n";
			strSql += "						  a.budg_item_assign_amt, \n";
			strSql += "						  a.budg_item_req_amt_a,  \n";
			strSql += "						  b.budg_ym,              \n";
			strSql += "						  b.budg_month_req_amt,   \n";
			strSql += "						  b.budg_month_assign_amt,\n";
			strSql += "						  b.budg_month_req_amt_a,         \n";
			strSql += "						  c.acc_code                      \n";
			strSql += "					from  t_budg_dept_item a,             \n";
			strSql += "						  t_budg_month_amt b,             \n";
			strSql += "						  t_budg_code      c              \n";
			strSql += "					where a.comp_code = b.comp_code       \n";
			strSql += "					and	  a.clse_acc_id = b.clse_acc_id   \n";
			strSql += "					and	  a.dept_code = b.dept_code       \n";
			strSql += "					and	  a.budg_code_no = b.budg_code_no \n";
			strSql += "					and	  a.reserved_seq = b.reserved_seq \n";
			strSql += "					and	  a.BUDG_CODE_NO = c.budg_code_no \n";
			strSql += "					) a,                                  \n";
			strSql += "					t_acc_code b,                         \n";
			strSql += "					(                                     \n";
			strSql += "					SELECT c.DEPT_CODE, SUBSTR(a.MAKE_DT_TRANS,1,6) MAKE_YM, b.ACC_CODE, SUM(b.DB_AMT+b.CR_AMT) SIL_AMT \n";
			strSql += "					FROM T_ACC_SLIP_HEAD a, T_ACC_SLIP_BODY b, T_DEPT_CODE c\n";
			strSql += "					WHERE                                                   \n";
			strSql += "						a.SLIP_ID=b.SLIP_ID                                 \n";
			strSql += "						AND a.KEEP_SLIPNO is not null                       \n";
			strSql += "						AND SUBSTR(a.MAKE_DT_TRANS,1,4) in ('"+vBudgYyyyB4+"','"+vBudgYyyy+"')  \n";
			strSql += "						and c.COMP_CODE = '"+vCompCode+"'                              \n";
			strSql += "						AND   ('***'='"+vDeptCode+"' or c.DEPT_CODE='"+vDeptCode+"')         \n";
			strSql += "						and b.DEPT_CODE=c.DEPT_CODE                         \n";
			strSql += "					GROUP BY c.DEPT_CODE,  SUBSTR(a.MAKE_DT_TRANS,1,6), b.ACC_CODE\n";
			strSql += "					) c,                                    \n";
			strSql += "					(select a.comp_code,                    \n";
			strSql += "							a.company_name,                 \n";
			strSql += "							b.dept_code,                    \n";
			strSql += "							b.dept_name                     \n";
			strSql += "					 from t_company a,                      \n";
			strSql += "					  	  t_dept_code b                     \n";
			strSql += "					 where a.COMP_CODE = b.comp_code        \n";
			strSql += "					) d,                                     \n";
			strSql += " 				(select b.dept_code, \n";
			strSql += " 				   	chk_dept_code, \n";
			strSql += " 				   	dept_name chk_dept_name \n";	    
			strSql += " 				from  t_dept_code a, \n";
			strSql += " 				  	t_budg_dept_map b	\n";  
			strSql += " 				where a.dept_code = b.chk_dept_code \n";
			strSql += " 				and   budg_cls='T' \n";
			strSql += " 				) e \n";
			strSql += "				where a.acc_code  = b.acc_code(+)           \n";
			strSql += "				and   a.acc_code  = c.acc_code(+)           \n";
			strSql += "				and	  a.comp_code = d.comp_code             \n";
			strSql += "				and	  a.dept_code = d.dept_code             \n";
			strSql += " 				and	  a.dept_code = e.dept_code \n";
			strSql += "				and   a.comp_code = '"+vCompCode+"'                    \n";
			strSql += "				and   a.clse_acc_id in ('"+vBudgYyyyB4+"','"+vBudgYyyy+"')      \n";
			strSql += "				AND   ('***'='"+vDeptCode+"' or d.DEPT_CODE='"+vDeptCode+"') \n";
			strSql += "				group  by                                   \n";
			strSql += "				 	   a.comp_code,                         \n";
			strSql += "					   company_name,                        \n";
			strSql += " 		   	  		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_CODE, 'DEPT', e.CHK_DEPT_CODE) , \n";
		   	strSql += " 		   	   		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', e.CHK_DEPT_NAME, 'DEPT', e.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   	   		   DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   	   		  DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', d.dept_name) , \n";
			strSql += "					   a.ACC_CODE,  \n";
			strSql += "					   b.ACC_NAME,  \n";                                			 
			strSql += "					   budg_ym      \n";
			strSql += "				                    \n";
			strSql += "			 	) a                 \n";
			strSql += "			group by                \n";
			strSql += "				  	 a.comp_code,   \n";
			strSql += "				   	a.company_name,  \n";
			strSql += " 		   			DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_CODE, 'DEPT', a.CHK_DEPT_CODE) ,  \n";
		  	strSql += " 		  			 DECODE('"+vDeptFlag+"', 'CHK_DEPT', a.CHK_DEPT_NAME, 'DEPT', a.CHK_DEPT_NAME) , \n";
		   	strSql += " 		   			DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_code) ,  \n";
		   	strSql += " 		   			DECODE('"+vDeptFlag+"', 'CHK_DEPT', '', 'DEPT', a.dept_name) , \n";
			strSql += "				   a.ACC_CODE,                                       \n";
			strSql += "				   a.ACC_NAME                                        \n";
			strSql += "			) a, (SELECT rownum rn FROM all_objects b WHERE rownum<=3) b\n";
			strSql += "		 order by              \n";
			strSql += "		 	   	  comp_code,   \n";
			strSql += "				  dept_code,   \n";
			strSql += "				  acc_code,    \n";
			strSql += "				  rn	       \n";
                                                                                      
                                                                                      
                                                                                      
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
