<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,62));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,24));
     dSet.addDataColumn(new GauceDataColumn("exe_qty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_qty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sysdate",GauceDataColumn.TB_STRING,18));
    String query = "SELECT        seq,    " + 
     "                   substr('           ',1,(llevel-1) *2) || name name,  " + 
     "                   unit, " + 
     "                   ssize, " + 
     "                   exe_qty, " + 
     "                   exe_price, " + 
     "                   exe_amt, " + 
     "                   ctrl_qty, " + 
     "                   ctrl_price, " + 
     "                   ctrl_amt, " + 
     "                   sbcr_code,    " + 
     "                   sbcr_name,  " + 
     "                   tag,   " + 
     "                   llevel, " + 
     "                   no_seq, " + 
     "                   sysdate  " + 
     "             FROM (       " + 
     "     					SELECT        s_order_parent.seq,    " + 
     "     					              s_order_parent.name,  " + 
     "     					              '                              ' unit, " + 
     "     					              '      ' ssize, " + 
     "     					              1 exe_qty,  " + 
     "     					              s_order_parent.exe_amt exe_price,  " + 
     "     					              s_order_parent.exe_amt exe_amt,  " + 
     "     					              1 ctrl_qty, " + 
     "     					              s_estimate_parent.ctrl_amt ctrl_price, " + 
     "     					              s_estimate_parent.ctrl_amt, " + 
     "     					              s_estimate_parent.sbcr_code,    " + 
     "     					              s_sbcr.sbcr_name,  " + 
     "     					              1 tag,   " + 
     "     					              to_number(s_order_parent.llevel) llevel, " + 
     "     					              s_order_parent.seq * 1000000  no_seq   " + 
     "     					         FROM s_order_parent,   " + 
     "     					              s_estimate_parent,    " + 
     "     					              s_sbcr    " + 
     "     					        WHERE ( s_estimate_parent.sbcr_code = s_sbcr.sbcr_code ) and   " + 
     "     					              ( s_order_parent.dept_code = s_estimate_parent.dept_code ) and   " + 
     "     					              ( s_order_parent.order_number = s_estimate_parent.order_number ) and   " + 
     "     					              ( s_order_parent.spec_no_seq = s_estimate_parent.spec_no_seq ) and   " + 
     "     					              ( ( s_order_parent.dept_code = '" + arg_dept_code + "' ) AND   " + 
     "     					              ( s_order_parent.order_number = " + arg_order_number + " ))   " + 
     "     					UNION ALL  " + 
     "     					 SELECT       s_order_detail.seq,  " + 
     "     					              s_order_detail.name,    " + 
     "     					              s_order_detail.unit,    " + 
     "     					              s_order_detail.ssize,      " + 
     "     					              s_order_detail.exe_qty exe_qty,  " + 
     "     					              s_order_detail.exe_price exe_price,  " + 
     "     					              s_order_detail.exe_amt exe_amt,  " + 
     "     					              s_estimate_detail.ctrl_qty,    " + 
     "     					              s_estimate_detail.ctrl_price,    " + 
     "     					              s_estimate_detail.ctrl_amt,    " + 
     "     					              s_estimate_detail.sbcr_code,    " + 
     "     					              s_sbcr.sbcr_name, " + 
     "     					              2 tag,    " + 
     "     					              to_number(s_order_parent.llevel) + 1 llevel,     " + 
     "     					              s_order_parent.seq  * 1000000 + s_order_detail.seq no_seq " + 
     "     					        FROM  s_order_parent,   " + 
     "     					              s_order_detail,   " + 
     "     					              s_estimate_detail,    " + 
     "     					              s_sbcr    " + 
     "     					        WHERE ( s_order_parent.dept_code = s_estimate_detail.dept_code ) and   " + 
     "     					              ( s_order_parent.order_number = s_estimate_detail.order_number ) and   " + 
     "     					              ( s_order_parent.spec_no_seq = s_estimate_detail.spec_no_seq ) and   " + 
     "     					                ( s_estimate_detail.sbcr_code = s_sbcr.sbcr_code ) and   " + 
     "     					                  ( s_order_detail.dept_code = s_estimate_detail.dept_code ) and   " + 
     "     					                  ( s_order_detail.order_number = s_estimate_detail.order_number ) and   " + 
     "     					                  ( s_order_detail.spec_no_seq = s_estimate_detail.spec_no_seq ) and   " + 
     "     					                  ( s_order_detail.detail_unq_num = s_estimate_detail.detail_unq_num ) and   " + 
     "     					              ( ( s_estimate_detail.dept_code = '" + arg_dept_code + "' ) AND   " + 
     "     					              ( s_estimate_detail.order_number = " + arg_order_number + "  )) )  " + 
     "      order by no_seq,sbcr_code 					                        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>