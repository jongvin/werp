<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_date = req.getParameter("arg_date");
     String arg_seq  = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
    String query = "  select a.dept_code,a.requestseq,a.chg_cnt,a.approve_class " +
						 "    from (select b.dept_code,b.requestseq,b.chg_cnt " +
						 "            from m_est_detail a, " +
				       "                 m_request_detail b " +
			          "           where a.request_unq_num = b.request_unq_num " +
			          "             and a.chg_cnt = b.chg_cnt " +
			          "             and a.estimateyymm = '" + arg_date + "'" + 
			          "             and a.estimateseq = " + arg_seq +
			          "        group by b.dept_code,b.requestseq,b.chg_cnt) b, " +
		             "        m_request a " + 
                   "  where a.dept_code = b.dept_code " +
                   "    and a.requestseq = b.requestseq " +
                   "    and a.chg_cnt = b.chg_cnt " ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>