<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_no = req.getParameter("arg_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("division",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  y_wbs_detail.no ," + 
     "          y_wbs_detail.spec_no_seq ," + 
     "          y_wbs_detail.no_seq ," + 
     "          y_wbs_detail.direct_class ," + 
     "          y_wbs_detail.wbs_code ," + 
     "          y_wbs_detail.llevel ," + 
     "          y_wbs_detail.invest_class ," + 
     "          y_wbs_detail.name ," + 
     "          y_wbs_detail.ssize ," + 
     "          y_wbs_detail.unit ," + 
     "          y_wbs_detail.remark ," + 
     "          y_wbs_detail.input_dt ," + 
     "          y_wbs_detail.input_name, " + 
     "          y_wbs_detail.division " + 
     "       FROM y_wbs_detail  " + 
     "       WHERE ( Y_WBS_DETAIL.NO = " + arg_no + " ) " + 
     "       ORDER BY y_wbs_detail.no_seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>