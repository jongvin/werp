<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("detail_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("exe_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_DECIMAL,1,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,10,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "	select   a.dept_code,a.detail_unq_num, " +
         "                    a.seq,																							" +	
			"							substr('           ',1,(a.llevel-1) *2) || a.name name,                                 " +
			"							a.ssize,                                                                              " +
			"							a.unit,                                                                               " +
         "                    a.cnt_qty ," + 
         "                    a.cnt_price ," + 
         "                    a.cnt_amt ," + 
         "                    a.exe_qty ," + 
         "                    a.exe_price ," + 
         "                    a.exe_amt ," + 
         "                    a.sub_qty ," + 
         "                    a.sub_price ," + 
         "                    a.sub_amt ," + 
         "                    a.mat_price ," + 
         "                    a.mat_amt ," + 
         "                    a.lab_price ," + 
         "                    a.lab_amt ," + 
         "                    a.exp_price ," + 
         "                    a.exp_amt,   " + 
         "	                  a.tag,        " +
         "	                  a.llevel,          " +
         "	                  a.no_seq            " +
			"				from (                                                                                       " +
         "                 SELECT  a.dept_code,0 detail_unq_num, " +
         "                         a.seq ," + 
         "                         a.name ," + 
         "                         a.ssize ," + 
         "                         a.unit ," + 
         "                         0 cnt_qty ," + 
         "                         0 cnt_price ," + 
         "                         0 cnt_amt ," + 
         "                         0 exe_qty ," + 
         "                         0 exe_price ," + 
         "                         0 exe_amt ," + 
         "                         0 sub_qty ," + 
         "                         0 sub_price ," + 
         "                         0 sub_amt ," + 
         "                         0 mat_price ," + 
         "                         0 mat_amt ," + 
         "                         0 lab_price ," + 
         "                         0 lab_amt ," + 
         "                         0 exp_price ," + 
         "                         0 exp_amt,   " + 
         "	                       1 tag,        " +
         "	                       to_number(a.llevel) llevel,          " +
         "	                       a.seq * 1000000  no_seq             " +
         "                       FROM s_order_parent a   " + 
         "                       WHERE a.dept_code = '" + arg_dept_code + "'     " + 
         "                         and a.order_number = " + arg_order_number + "   " + 
         "               union all  " + 
         "                 SELECT  a.dept_code,a.detail_unq_num, " +
         "                         a.seq ," + 
         "                         a.name ," + 
         "                         a.ssize ," + 
         "                         a.unit ," + 
         "                         0 cnt_qty ," + 
         "                         0 cnt_price ," + 
         "                         0 cnt_amt ," + 
         "                         0 exe_qty ," + 
         "                         0 exe_price ," + 
         "                         0 exe_amt ," + 
         "                         a.sub_qty ," + 
         "                         0 sub_price ," + 
         "                         0 sub_amt ," + 
         "                         0 mat_price ," + 
         "                         0 mat_amt ," + 
         "                         0 lab_price ," + 
         "                         0 lab_amt ," + 
         "                         0 exp_price ," + 
         "                         0 exp_amt,   " + 
	      "	                      2 tag,                                                                     " +
	      "	                      to_number(b.llevel) + 1 llevel,                                            " +
	      "	                      b.seq  * 1000000 + a.seq no_seq                                            " +
         "                         FROM s_order_detail a,   " + 
         "                              s_order_parent b " + 
         "                         WHERE a.dept_code = b.dept_code " + 
         "                           and a.spec_no_seq = b.spec_no_seq " +  
         "                           and a.order_number = b.order_number " +
         "                           and a.dept_code = '" + arg_dept_code + "'     " + 
         "                           and a.order_number = " + arg_order_number + "   ) a" + 
         "          ORDER BY a.no_seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>