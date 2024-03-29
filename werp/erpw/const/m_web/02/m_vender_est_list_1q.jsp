<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_seq  = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("estimateyymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("estimateseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("choicetag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("est_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("estimatedate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("deliverymethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("deliverylimitdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("paymentmethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("quality",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("recommend",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("buytag",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("open_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("open_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("open_per",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("enddatetime",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("est_dt",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT b.sbcr_name," + 
     "         to_char(a.ESTIMATEYYMM,'YYYY.MM.DD') ESTIMATEYYMM,   " + 
     "         a.ESTIMATESEQ,   " + 
     "         a.sbcr_code,   " + 
     "         a.CHOICETAG,   " + 
     "         a.EST_YN,   " + 
     "         to_char(a.ESTIMATEDATE,'YYYY.MM.DD hh24:mi') ESTIMATEDATE,   " + 
     "         a.DELIVERYMETHOD,   " + 
     "         to_char(a.DELIVERYLIMITDATE,'YYYY.MM.DD') DELIVERYLIMITDATE,  " + 
     "         a.PAYMENTMETHOD,   " + 
     "         a.QUALITY,   " + 
     "         a.RECOMMEND,   " + 
     "         a.AMT,   " + 
     "         a.CHG_AMT,   " + 
     "         a.REMARK ,  " + 
     "         c.buytag ," +
     "         c.open_yn," +
     "         to_char(c.open_dt,'YYYY.MM.DD hh24:mi') open_dt," +
     "         c.open_per, " +
     "         to_char(c.ENDDATETIME,'YYYY.MM.DD') ENDDATETIME,   " +
     "         to_char(a.ESTIMATEDATE, 'yyyy.mm.dd hh24:mi') est_dt " +
     "    FROM M_VENDER_EST  a," + 
     "         s_sbcr b," + 
     "         m_estimation c " +
     "   WHERE a.sbcr_code = b.sbcr_code (+) and" + 
     "         a.estimateyymm = c.estimateyymm and " +
     "         a.estimateseq  = c.estimateseq and " +
     "   		a.ESTIMATEYYMM = " + "'" + arg_date + "'" + "    and" + 
     "			a.estimateseq  = " + arg_seq  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>