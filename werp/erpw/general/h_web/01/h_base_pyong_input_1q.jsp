<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_spec_unq_num = req.getParameter("arg_spec_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("vat_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("private_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("common_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("etc_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("parking_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("service_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("grand_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("represent_pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       SPEC_UNQ_NUM,   " + 
     "                       PYONG,   " + 
     "                       STYLE,   " + 
     "                       CLASS,   " + 
     "                       OPTION_CODE,   " + 
     "                       VAT_YN,   " + 
     "                       PRIVATE_SQUARE,   " + 
     "                       COMMON_SQUARE,   " + 
     "                       ETC_SQUARE,   " + 
     "                       PARKING_SQUARE,   " + 
     "                       SERVICE_SQUARE,   " + 
     "                       GRAND_SQUARE,   " + 
     "                       REPRESENT_PYONG,   " + 
     "                       LAND_AMT,   " + 
     "                       BUILD_AMT,   " + 
     "                       VAT_AMT,   " + 
     "                       SELL_AMT  " + 
     "                  FROM H_BASE_PYONG_MASTER  " + 
     "                 WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( SELL_CODE = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( spec_unq_num = '" + arg_spec_unq_num + "')" +
     "              ORDER BY PYONG ASC,   " + 
     "                       STYLE ASC,   " + 
     "                       CLASS ASC,   " + 
     "                       OPTION_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>