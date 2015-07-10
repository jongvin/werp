<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
     String as_yymm      = req.getParameter("as_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("det_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("acnt_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("det_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("all_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("request_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("adjust_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("decision_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("key_value1",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("key_value2",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("key_value3",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.dept_code,     		  " +
                   "       to_char(a.yymm, 'yyyy.mm.dd') yymm,         		  " +
	                "       a.code,          		  " +
	                "       a.det_code,      		  " +
	                "       c.name  acnt_name,     " +
	                "       d.name  det_name,      " +
	                "       a.code || a.det_code all_code, " +
	                "       a.seq,           		  " +
	                "       a.spec_no_seq,         " +
	                "       a.spec_unq_num,     	  " +
	                "       a.request_name,        " +
	                "       nvl(a.request_amt, 0) request_amt,         " +
	                "       nvl(a.adjust_amt, 0) adjust_amt,          " +
	                "       nvl(a.decision_amt, 0) decision_amt,        " +
	                "       a.note,                " +
	                "       a.code key_value1,      " +
	                "       a.det_code key_value2,  " +
	                "       a.seq key_value3        " +
                   "  from f_request_detail a,   " +
                   "       f_request_acnt   c,   " +
                   "       f_request_acnt_det d  " +
                   " where a.code         = c.code(+)         " +
                   "   and a.code         = d.code(+)         " +
                   "   and a.det_code     = d.det_code(+)     " +
                   "   and a.dept_code = '" + as_dept_code + "' " +
                   "   and a.yymm      = '" + as_yymm + "' " +
                   " order by a.code, a.det_code, a.seq ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>