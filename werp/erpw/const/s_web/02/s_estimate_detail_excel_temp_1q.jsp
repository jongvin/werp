<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("detail_unq_num",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("est_qty",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("emat_price",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("emat_amt",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("elab_price",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("elab_amt",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("eexp_price",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("eexp_amt",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("est_price",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("est_amt",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  dept_code ," + 
     					 "          detail_unq_num ," + 
     					 "          name ," + 
     					 "          ssize ," + 
     					 "          unit ," + 
     					 "          est_qty ," + 
     					 "          emat_price ," + 
     					 "          emat_amt ," + 
     					 "          elab_price ," + 
     					 "          elab_amt ," + 
     					 "          eexp_price ," + 
     					 "          eexp_amt ," + 
     					 "          est_price ," + 
     					 "          est_amt,  " +
     					 "          unq_num " + 
     					 "     FROM s_estimate_temp  " +
     					 "    WHERE DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      AND unq_num = " + arg_seq ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>