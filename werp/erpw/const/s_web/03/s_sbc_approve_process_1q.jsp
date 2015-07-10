<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date = req.getParameter("arg_to_date");
     String arg_sbcr_name = '%' +  req.getParameter("arg_sbcr_name") + '%';
     String arg_sbcr_code =  req.getParameter("arg_sbcr_name") + '%';
     String arg_wbs_name  = '%' +  req.getParameter("arg_wbs_name") + '%';
     String arg_wbs_code =  req.getParameter("arg_wbs_name") + '%';
     arg_dept_name = '%' + arg_dept_name + '%';
     
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("chg_resign",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("plan_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("ebid_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sbc_dt",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         b.LONG_NAME,   " + 
     "         a.APPROVE_CLASS,   " + 
     "         to_char(a.REQUEST_DT,'yyyy.mm.dd') request_dt, " + 
     "         to_char(a.APPROVE_DT,'yyyy.mm.dd') APPROVE_DT, " + 
     "	       a.order_number," + 
     "	       a.chg_degree," + 
     "	       a.order_name," + 
     "	       a.sbc_name," + 
     "	       a.chg_resign," + 
     "	       to_char(a.plan_start_dt,'yyyy.mm.dd') plan_start_dt, " + 
     "	       to_char(a.plan_end_dt,'yyyy.mm.dd') plan_end_dt, " + 
     "	       a.sbc_amt," + 
     "	       a.vat," + 
     "	       c.sbcr_name," + 
     "          a.ebid_yn, " +
     "          a.order_class, " +
     "          e.profession_wbs_name,  " +
     "         to_char(a.sbc_dt,'yyyy.mm.dd') sbc_dt " + 
     "    FROM s_chg_cn_list a, " + 
     "         Z_CODE_DEPT b, " + 
     "	       s_sbcr c, " + 
     "	       s_order_list d, " + 
     "	       s_profession_wbs e " + 
     "   WHERE ( a.DEPT_CODE = b.DEPT_CODE ) and  " + 
     "         ( a.sbcr_code = c.sbcr_code ) and" + 
     "         ( a.dept_code = d.dept_code ) and" + 
     "         ( a.order_number = d.order_number ) and" + 
     "         ( d.profession_wbs_code = e.profession_wbs_code (+) ) and" + 
     "         ( a.APPROVE_CLASS = " + "'" + arg_class + "'" + " ) and " +
     "         ( b.long_name like '" + arg_dept_name + "' ) " + 
     "     AND (c.sbcr_name like " + "'" + arg_sbcr_name + "'" +
     "          or c.businessman_number  like " + "'" + arg_sbcr_code + "')" +
     "      AND (d.profession_wbs_code like " + "'" + arg_wbs_code + "'  " + 
     "          or e.profession_wbs_name  like " + "'" + arg_wbs_name + "')";
     if ( arg_class.equals("2") ) {   
     	    query = query + 
               "      AND to_char(a.REQUEST_DT,'YYYY.MM.DD') >= " + "'" + arg_from_date + "'" +
               "      AND to_char(a.REQUEST_DT,'YYYY.MM.DD') <= " + "'" + arg_to_date + "'";
     }
     else  {
     	    query = query + 
               "      AND to_char(a.APPROVE_DT,'YYYY.MM.DD') >= " + "'" + arg_from_date + "'" +
               "      AND to_char(a.APPROVE_DT,'YYYY.MM.DD') <= " + "'" + arg_to_date + "'";
     }
     query = query + " order by b.long_name ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>