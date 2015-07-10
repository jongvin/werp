<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("detail_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("corp_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("zip_number1",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("address1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("tel_number1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("rep_name2",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  a.sbcr_code ," + 
     					 "          a.detail_unq_num ," + 
     					 "          to_char(a.chg_dt,'yyyy.mm.dd') chg_dt ," + 
     					 "          a.sbcr_name ," + 
     					 "          a.businessman_number ," + 
     					 "          a.corp_no ," + 
     					 "          a.zip_number1 ," + 
     					 "          a.address1 ," + 
     					 "          a.tel_number1 ," + 
     					 "          a.rep_name1 ," + 
     					 "          a.rep_name2     " +
     					 "     FROM s_sbcr_chg a " +
     					 "    WHERE a.SBCR_CODE = '" + arg_sbcr_code  + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>