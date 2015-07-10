<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_wbs_code = req.getParameter("arg_wbs_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("persion_qty",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("month_qty",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("day_qty",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT DEPT_CODE,   " + 
     "         WBS_CODE,   " + 
     "         DETAIL_CODE,   " + 
     "         nvl(SPEC_UNQ_NUM,0) spec_unq_num,   " + 
     "         decode(SPEC_UNQ_NUM,0,'F','T') comp_chk,   " + 
     "         NAME,   " + 
     "         SSIZE,   " + 
     "         UNIT,   " + 
     "         QTY,   " + 
     "         PERSION_QTY,   " + 
     "         MONTH_QTY,   " + 
     "         DAY_QTY,   " + 
     "         PRICE,   " + 
     "         AMT,   " + 
     "         ACNTCODE,   " + 
     "         REMARK,   " + 
     "         to_char(INPUT_DT,'YYYY.MM.DD') input_dt,   " + 
     "         INPUT_NAME  " + 
     "    FROM Y_PROJMNG_AMT  " + 
     "   WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( WBS_CODE = " + "'" + arg_wbs_code + "'" + " )   " + 
     "ORDER BY DEPT_CODE ASC,   " + 
     "         WBS_CODE ASC,   " + 
     "         DETAIL_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>