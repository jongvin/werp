<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("reson",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("remark1",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("remark2",GauceDataColumn.TB_STRING,1000));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.yymmdd,'YYYY.MM.DD') yymmdd ," + 
     					 "          a.seq ," + 
     					 "          a.input_unq_num ," + 
     					 "          a.detailseq ," + 
     					 "          a.mtrcode ," + 
     					 "          a.name ," + 
     					 "          a.ssize ," + 
     					 "          a.unitcode ," + 
     					 "          a.ditag ," + 
     					 "          decode(sign(b.noout_qty - a.qty),1,a.qty,b.noout_qty) qty ," + 
     					 "          a.reson ," + 
     					 "          a.remark1 ," + 
     					 "          a.remark2 " +
     					 "     FROM m_remaind_mat a ," +
     					 "          m_input_detail b " +
     					 "    WHERE a.dept_code = b.dept_code " +
     					 "      and a.yymmdd = b.yymmdd " +
     					 "      and a.seq    = b.seq " +
     					 "      and a.input_unq_num = b.input_unq_num " +
     					 "      and b.noout_qty <>  0 " +
     					 "      and a.DEPT_CODE = '" + arg_dept_code + "'" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>