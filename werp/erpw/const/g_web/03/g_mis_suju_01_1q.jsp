<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("gubun",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("detail_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("mm",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("per",GauceDataColumn.TB_DECIMAL,18,1));
    String query = "  " + 
                   " select  a.gubun,                                      " + 
                   "         a.detail_name,                                " + 
                   "        to_char(a.mm,'mm') mm," + 
                   "         a.cnt,                                   " + 
                   "         b.tot_cnt,                                    " + 
                   "         trunc(a.cnt / b.tot_cnt * 100,1)  per         " + 
                   " from (                                                " + 
                   "     SELECT  trunc(a.recive_date,'mm') mm,nvl(a.cnd_propel_yn,'00') gubun, nvl(b.detail_name,' ') detail_name,  count(nvl(a.cnd_propel_yn,1)) cnt " + 
                   "        from r_proj a, r_code_etc_detail b,r_proj_view_business_form c   " + 
                   "        where b.class_tag(+) = '011'                                                                                                                " + 
                   "          and a.cnd_propel_yn = b.etc_code (+)                                                                                                     " + 
                   "          and a.proj_unq_key = c.proj_unq_key                                                                                                    " + 
                   "          and a.step = c.step                                                                                                   " + 
                   "          and a.recive_date >= '" + arg_work_year + "'                                                                                     " + 
                   "          and a.recive_date < add_months('" + arg_work_year + "',12)      " + 
                   "        group by trunc(a.recive_date,'mm'),nvl(a.cnd_propel_yn,'00'),nvl(b.detail_name,' ')                                         " + 
                   "       ) a,                                                                                                                                        " + 
                   "    (                                                                                                                                              " + 
                   "     SELECT  trunc(a.recive_date,'mm') mm,count(a.recive_date) tot_cnt                                                                           " + 
                   "        from r_proj a ,r_proj_view_business_form c                                                                                                                            " + 
                   "        where a.recive_date >= '" + arg_work_year + "'                                                                                     " + 
                   "          and a.recive_date < add_months('" + arg_work_year + "',12)                 " + 
                   "          and a.proj_unq_key = c.proj_unq_key                                                                                                    " + 
                   "          and a.step = c.step                                                                                                   " + 
                   "        group by trunc(a.recive_date,'mm')) b                                                                                                     " + 
                   "   where a.mm = b.mm " + 
                   "   order by a.gubun,a.detail_name,a.mm  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>