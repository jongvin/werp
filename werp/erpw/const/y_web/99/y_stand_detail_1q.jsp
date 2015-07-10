<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_high_detail_code = req.getParameter("arg_high_detail_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("high_detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("equ_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("name_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("old_detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
	 dSet.addDataColumn(new GauceDataColumn("limit_budget_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT y_stand_detail.high_detail_code,   " + 
     "         y_stand_detail.detail_code,   " + 
     "         y_stand_detail.res_class,   " + 
     "         y_stand_detail.mat_code,   " + 
     "         y_stand_detail.name,   " + 
     "         y_stand_detail.ssize,   " + 
     "         y_stand_detail.unit,   " + 
     "         y_stand_detail.mat_price,   " + 
     "         y_stand_detail.lab_price,   " + 
     "         y_stand_detail.exp_price,   " + 
     "         y_stand_detail.equ_price,   " + 
     "         y_stand_detail.sub_price,   " + 
     "         y_stand_detail.name_key,   " + 
     "         y_stand_detail.remark,   " + 
     "         y_stand_detail.detail_code old_detail_code,  " + 
     "         0 qty,  " + 
	 "         nvl(y_stand_detail.limit_budget_yn, 'F') limit_budget_yn  "+
     "    FROM y_stand_detail  " + 
     "   WHERE y_stand_detail.high_detail_code = " + "'" + arg_high_detail_code + "'" + "   " + 
     "           " + 
     "ORDER BY y_stand_detail.detail_code ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>