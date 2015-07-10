<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
    String query = "  select to_char(a.approym,'YYYY.MM.DD') approym, " + 
                   "         a.approseq, " + 
                   "         a.chg_cnt ," + 
                   "         a.approtitle, " +
                   "         b.sbcr_code, " + 
                   "         c.sbcr_name " + 
						 "	  from m_approval a, " + 
						 "       m_approval_sbcr b, " + 
						 "       s_sbcr  c, " + 
						 "      (select max(a.dept_code) dept_code,max(a.approym) approym,max(a.approseq) approseq,max(a.chg_cnt) chg_cnt " + 
						 "	 		  from m_approval_detail a" + 
						 "		    where a.dept_code = '" + arg_dept + "'" + 
						 "          and a.noinput_qty <> 0 " + 
						 "	  group by a.dept_code, " + 
						 "				  a.approym, " + 
						 "				  a.approseq, " + 
						 "				  a.chg_cnt ) d " + 
						 " where b.sbcr_code = c.sbcr_code " + 
						 "   and a.dept_code = b.dept_code (+) " + 
						 "   and a.approym  = b.approym (+) " + 
						 "   and a.approseq = b.approseq (+) " + 
						 "   and a.chg_cnt  = b.chg_cnt (+) " + 
						 "   and a.dept_code = d.dept_code " + 
						 "   and a.approym = d.approym " + 
						 "   and a.approseq = d.approseq " + 
						 "   and a.chg_cnt = d.chg_cnt " + 
						 "   and a.app_tag = '3' " +
                   " order by c.sbcr_name " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>