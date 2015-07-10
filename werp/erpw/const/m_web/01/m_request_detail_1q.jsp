<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_requestseq = req.getParameter("arg_requestseq");
     String arg_chg_cnt = req.getParameter("arg_chg_cnt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("pre_chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("requestdetailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("requiredtime",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ho_buy_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("site_buy_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("trans_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("trans_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("usage",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("request_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("nappr_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("remark1",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("bud_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("bud_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_request_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("remaind_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("rk",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
    					 "         a.REQUESTSEQ,   " + 
    					 "         a.chg_cnt, " +
     					 "         a.pre_chg_cnt, " +
    					 "         a.REQUESTDETAILSEQ,   " + 
    					 "         a.MTRCODE,   " + 
    					 "         a.NAME,   " + 
    					 "         a.SSIZE,   " + 
    					 "         a.UNITCODE,   " + 
    					 "         a.QTY,   " + 
    					 "         a.UNITPRICE,   " + 
    					 "         a.AMT,   " + 
    					 "         to_char(a.REQUIREDTIME,'YYYY.MM.DD')  REQUIREDTIME,   " + 
    					 "         a.HO_BUY_QTY,   " + 
    					 "         a.SITE_BUY_QTY,   " + 
    					 "         a.TRANS_QTY,   " + 
    					 "         a.TRANS_DEPT_CODE,   " + 
    					 "         b.long_name,  " +
    					 "         a.USAGE,   " + 
    					 "         a.SPEC_NO_SEQ,   " + 
    					 "         a.SPEC_UNQ_NUM,   " + 
    					 "         F_PARENT_DETAIL_SIZE(a.dept_code,a.spec_unq_num) spec_name,  " + 
    					 "         a.REQUEST_UNQ_NUM,   " + 
    					 "         a.NAPPR_QTY,  " + 
    					 "         a.remark1," +
    					 "         a.bud_qty," +
    					 "         a.bud_price," +
    					 "         a.bud_amt," +
    					 "         a.pre_request_qty, " +
    					 "         nvl(a.bud_qty,0) - nvl(a.pre_request_qty,0) remaind_qty, " +
    					 "         nvl(c.qty,0) input_qty, " +
    					 "         RANK() OVER (PARTITION by a.spec_unq_num ORDER BY a.spec_unq_num asc, a.requestdetailseq asc) rk " + 
    					 "    FROM M_REQUEST_DETAIL a, " + 
    					 "         Z_CODE_DEPT b ," +
    					 "         ( select nvl(sum(qty),0) qty,max(request_unq_num) request_unq_num " +
    					 "             from m_input_detail " +
    					 "            where dept_code = '" + arg_dept_code + "'" +
    					 "          group by request_unq_num ) c " +
    					 "   WHERE ( a.request_unq_num = c.request_unq_num (+)) and " +
    					 "         ( a.trans_dept_code = b.dept_code (+) ) AND " +
    					 "         ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + ") AND  " + 
    					 "         ( a.REQUESTSEQ = " + "'" + arg_requestseq + "'" + " ) AND  " + 
    					 "         ( a.chg_cnt = " + arg_chg_cnt + " ) " +
    					 " ORDER BY a.DEPT_CODE ASC,   " + 
    					 "          a.REQUESTSEQ ASC,   " + 
    					 "          a.REQUESTDETAILSEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>