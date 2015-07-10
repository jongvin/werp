<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date      = req.getParameter("arg_date");
     String arg_seq       = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("output_unq_num",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("detailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("out_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deliverytag",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("inouttypecode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approval_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("tmat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,2000));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.YYMMDD,'YYYY.MM.DD')   YYMMDD, " + 
     "         a.SEQ,   " + 
     "         a.OUTPUT_UNQ_NUM,   " + 
     "         a.DETAILSEQ,   " + 
     "         a.MTRCODE,   " + 
     "         a.NAME,   " + 
     "         a.SSIZE,   " + 
     "         a.UNITCODE,   " + 
     "         a.DITAG,   " + 
     "         a.QTY,   " + 
     "         a.UNITPRICE,   " + 
     "         a.AMT,   " + 
     "         decode(a.ditag,'1',a.amt,0) out_amt, " +
     "         a.DELIVERYTAG,   " + 
     "         a.INOUTTYPECODE,   " + 
     "         a.SPEC_NO_SEQ,   " + 
     "         a.SPEC_UNQ_NUM,   " + 
     "         a.REQUEST_UNQ_NUM,   " + 
     "         a.EST_UNQ_NUM,   " + 
     "	       a.INPUT_UNQ_NUM," + 
     "         a.APPROVAL_UNQ_NUM,   " + 
     "         F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name , " + 
     "         a.tmat_unq_num , a.vat_unq_num,a.vat_amt,a.remark" +
     "    FROM M_OUTPUT_DETAIL a" + 
     "   WHERE ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( a.YYMMDD = " + "'" + arg_date + "'" + " ) AND  " + 
     "         ( a.SEQ = " + "'" + arg_seq + "'" + " )   " + 
     "ORDER BY a.DETAILSEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>