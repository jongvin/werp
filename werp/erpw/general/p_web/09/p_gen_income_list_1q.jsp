<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("appl_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("in_co_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("gen_income_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("cont",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("in_amt",GauceDataColumn.TB_NUMBER,12));
     dSet.addDataColumn(new GauceDataColumn("co_amt",GauceDataColumn.TB_DECIMAL,12,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
    String query = " " + 
      " SELECT        a.comp_code ,          " + 
      "              a.spec_no_seq ,         " + 
      "              a.seq ,                 " + 
      "              a.appl_date,            " + 
      "              a.in_co_div ,           " + 
      "              a.gen_income_code ,     " + 
      "              a.cont ,                " + 
      "              a.in_amt ,              " + 
      "              a.co_amt ,              " + 
      "              a.remark                " + 
      "  FROM (                              " + 
      "                                      " + 
      "       SELECT        a.comp_code ,    " + 
      "                     a.spec_no_seq ,                               " + 
      "                     a.seq ,                                       " + 
      "                     to_char(a.appl_date,'YYYY.MM.DD') appl_date,  " + 
      "                     a.in_co_div ,                                 " + 
      "                     a.gen_income_code ,                           " + 
      "                     a.cont ,                                      " + 
      "                     a.in_amt ,                                    " + 
      "                     a.co_amt ,                                    " + 
      "                     a.remark     FROM p_gen_income_list a         " + 
      "              where trunc(a.appl_date,'mm') = '" + arg_date + "'               " + 
      "                and a.comp_code like '" + arg_comp_code + "'       " + 
      "         union all                                                 " + 
      "              select '',                                           " + 
      "                      0,                                           " + 
      "                      0,                                           " + 
      "                     to_char(to_date('" + arg_date + "') - 1,'yyyy.mm.dd') ,  " + 
      "                     '',                                           " + 
      "                     '',                                           " + 
      "                     '전월까지',                                           " + 
      "                     sum(a.in_amt),                                " + 
      "                     sum(a.co_amt),                                " + 
      "                     ''                                            " + 
      "                from p_gen_income_list a                           " + 
      "                where a.appl_date < '" + arg_date + "'             " + 
      "                 and a.comp_code like  '" + arg_comp_code + "' ) a " + 
      "      ORDER BY a.appl_date, a.seq          ASC ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>