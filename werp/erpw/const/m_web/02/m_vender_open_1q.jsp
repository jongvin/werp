<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
     String arg_sbcr = req.getParameter("arg_sbcr");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("estimateyymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("estimateseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("chgprice",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("b_chgprice",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_qty",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "  SELECT  to_char(a.estimateyymm,'yyyy.mm.dd') estimateyymm ," + 
     					 "          a.estimateseq ," + 
     					 "          a.sbcr_code ," + 
     					 "          a.est_unq_num ," + 
     					 "          a.unitprice ," + 
     					 "          a.chgprice ," + 
     					 "          b.chgprice  b_chgprice," +
     					 "          b.qty b_qty " +
     					 "     FROM m_vender_est_detail a," + 
     					 "          m_vender_est_detail_web b " +
     					 "    WHERE a.estimateyymm = b.estimateyymm " +
     					 "      and a.estimateseq = b.estimateseq " +
     					 "      and a.sbcr_code = b.sbcr_code " +
     					 "      and a.est_unq_num = b.est_unq_num " +
     					 "      and a.ESTIMATEYYMM = '" + arg_date + "'" +
     					 "      And a.ESTIMATESEQ = " + arg_seq +
     					 "      and a.sbcr_code = '" + arg_sbcr + "'" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>