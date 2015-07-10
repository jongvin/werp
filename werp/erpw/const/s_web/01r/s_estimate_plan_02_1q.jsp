<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,42));
     dSet.addDataColumn(new GauceDataColumn("register_chk",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cn_limit_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("est_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sel_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT 0 unq_num,   " + 
     "       0 no_seq,   " + 
     "       s.sbcr_name || '(' || nvl(s.rep_name1,' ') || ')' sbcr_name,   " + 
     "       e.register_chk," + 
     "       round(t.cn_limit_amt1 / 1000000, 0) cn_limit_amt1," + 
     "		 p.long_name," + 
     "       r.est_cnt," + 
     "       r.sel_cnt" + 
     "  FROM s_estimate_list e,   " + 
     "       s_sbcr s," + 
     "       s_license_status t," + 
     "       (SELECT A.SBCR_CODE,   " + 
     "					 SUM(A.EST_CNT) EST_CNT,   " + 
     "					 SUM(A.SEL_CNT) SEL_CNT    " + 
     "   			FROM (SELECT SBCR_CODE,   " + 
     "										DECODE(EST_YN, 'Y', 1, 0) EST_CNT,   " + 
     "										DECODE(SELECT_YN , 'Y', 1, 0) SEL_CNT   " + 
     "								 FROM S_ESTIMATE_LIST  " + 
     "								WHERE dept_code      = '" + arg_dept_code + "' " + 
     "   				   		  and	order_number   = " + arg_order_number + " ) A  " + 
     "  			GROUP BY A.SBCR_CODE  ) r," + 
     "			  (SELECT a.sbcr_code sbcr_code," + 
     "			          max(b.dept_code)," + 
     "			          max(c.long_name) long_name  " + 
     "					 FROM S_ESTIMATE_LIST a, s_order_list b, z_code_dept c  " + 
	  "			where a.sbcr_code      = b.sbcr_code		" +
		"			  and b.dept_code 	  = c.dept_code      " +
		"			  and a.dept_code 	  = b.dept_code      " +
		"			  and a.order_number   = b.order_number   " +
		"			  group by a.sbcr_code) p                 " +
     " WHERE e.sbcr_code      = s.sbcr_code      " + 
     "   and e.sbcr_code      = t.sbcr_code(+)      " + 
     "   and e.sbcr_code      = r.sbcr_code(+)      " + 
     "   and e.sbcr_code      = p.sbcr_code(+)      " + 
     "   and e.profession_wbs_code      = t.profession_wbs_code(+)      " + 
     "   and e.dept_code      = '" + arg_dept_code + "' " + 
     "   and e.order_number   = " + arg_order_number + "      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>