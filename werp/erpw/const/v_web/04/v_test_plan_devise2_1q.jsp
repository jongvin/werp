<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_search = req.getParameter("arg_search");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comm_wbs_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("comm_wbs_code_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("branch_class",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("branch_class_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("test_item",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("test_method",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("test_amt",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("test_frequency",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("test_times",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));

 String query = "  SELECT   " +
                "       a.dept_code, " +
                "       a.seq, " +
                "       a.d_seq, " +
					 "  b.confirm_section, " +
					 "  b.order_dt,  " +
                "       a.comm_wbs_code,  " +
                "       (select comm_name from v_comm_code where section='1' and comm_code=a.comm_wbs_code) comm_wbs_code_name,  " +
                "       a.branch_class,  " +
                "       a.test_item,  " +
                "       (select comm_name from v_comm_code where section='2' and comm_code=a.branch_class) branch_class_name,  " +
                "       a.test_method,  " +
                "       a.test_amt,  " +
                "       a.test_frequency, " +
                "       a.test_times,  " +
                "       a.remark,   " +
                "       a.seq key_seq   " +
                "  FROM v_test_plan a,   " +
				    "(select * from				   " +	   
				    "( select dept_code , seq , confirm_section , order_dt , confirm_dt , yymm   " +
				    "from v_test_plan_master where dept_code = '"+arg_search+"'   " +
				    " order by order_dt desc ) where rownum = 1 )	b  " +
					 " WHERE a.dept_code = b.dept_code and  " +
                "       a.seq = b.seq and  " +
					 "  decode(b.order_dt,null,to_char(sysdate,'yyyymm'),to_char(b.order_dt,'yyyymm')) not in (select to_char(yymm,'yyyymm') from v_test_result_master where status = '2') and  " +
					 "  a.dept_code = '"+arg_search+"'  " +
                "ORDER BY a.comm_wbs_code  ,  " +
					 "			  a.branch_class  asc ";
 /*               "       a.dept_code ASC,  " +
                "       comm_wbs_code_name ASC,  " +
                "       branch_class_name ASC,  " +
                "       a.seq ASC  " ;


    String query = "  SELECT				                                                   " +  
     "                       a.dept_code,																	" + 
     "                       a.seq,																			" + 
     "                       a.d_seq,																		" + 
     "                       a.comm_wbs_code,															" + 
     "                       (select comm_name from v_comm_code where section='1' and comm_code=a.comm_wbs_code) comm_wbs_code_name, " +
     "                       a.branch_class,																" + 
     "                       a.test_item,																	" + 
     "                       (select comm_name from v_comm_code where section='2' and comm_code=a.test_item) test_item_name, " +
     "                       a.test_method,																" + 
     "                       a.test_amt,																	" + 
     "                       a.test_frequency,															" + 
     "                       a.test_times,																" + 
     "                       a.remark,        															" +
     "                       a.seq key_seq																" + 
     "                  FROM v_test_plan a,																" +
     "                       v_test_plan_master b														" +
     "					  WHERE a.dept_code = b.dept_code and											" +
     "                       a.seq = b.seq and															" +
                             arg_search +
     "              ORDER BY b.confirm_section ASC,													" + 
     "                       a.dept_code ASC,															" + 
     "                       comm_wbs_code_name ASC,														" +
     "                       test_item_name ASC,															" +
     "                       a.seq ASC         															";  */
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>