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
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("org_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deliverytag",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("inouttypecode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("vat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approval_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("noout_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("tmat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.YYMMDD,'YYYY.MM.DD') YYMMDD,  " + 
     "         a.SEQ,   " + 
     "         a.INPUT_UNQ_NUM,   " + 
     "         a.DETAILSEQ,   " + 
     "         a.MTRCODE,   " + 
     "         a.NAME,   " + 
     "         a.SSIZE,   " + 
     "         a.UNITCODE,   " + 
     "         a.DITAG,   " + 
     "         a.QTY,   " + 
     "         a.QTY   org_qty,   " + 
     "         a.UNITPRICE,   " + 
     "         a.AMT,   " + 
     "         a.VATAMT,   " + 
     "         a.DELIVERYTAG,   " + 
     "         a.INOUTTYPECODE,   " + 
     "         a.sbcr_code,   " + 
     "         a.VATTAG,   " + 
     "         a.vat_unq_num,   " + 
     "         a.SPEC_NO_SEQ,   " + 
     "         a.SPEC_UNQ_NUM,   " + 
     "         a.REQUEST_UNQ_NUM,   " + 
     "         a.EST_UNQ_NUM,   " + 
     "         a.APPROVAL_UNQ_NUM,   " + 
     "         a.BIGO," + 
     "         F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name , " + 
     "         a.noout_qty, " +
     "         a.tmat_unq_num ," +
     "         a.item_code "  +
     "    FROM M_INPUT_DETAIL a" + 
     "   WHERE a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "     and ( a.ditag = '2' OR a.ditag = '5' ) " + 
     "ORDER BY a.YYMMDD desc        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>