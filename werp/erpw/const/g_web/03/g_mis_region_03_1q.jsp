<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
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
                   "         round(a.cnt / b.tot_cnt * 100,1)  per         " + 
                   "      from (  " + 
                   "          SELECT  trunc(a.receive_date,'mm') mm,nvl(b.sido,'00') gubun, nvl(b.sido,'00') detail_name,  count(nvl(b.sido,1)) cnt " + 
                   "             from r1_proj a,  " + 
                   "                 ( select distinct zipcode,sido from z_code_zip) b       " + 
                   "             where a.zip_number = b.zipcode (+)                                                                           " + 
                   "          and a.receive_date >= '" + arg_work_year + "'                                                                                     " + 
                   "          and a.receive_date < add_months('" + arg_work_year + "',12)      " + 
                   "             group by trunc(a.receive_date,'mm'),nvl(b.sido,'00'),nvl(b.sido,'00')                                              " + 
                   "            ) a,                                                                                                      " + 
                   "         (                                                                                                            " + 
                   "          SELECT  trunc(a.receive_date,'mm') mm,count(a.receive_date) tot_cnt                                         " + 
                   "             from r1_proj a                                                                                           " + 
                   "        where a.receive_date >= '" + arg_work_year + "'                                                                                     " + 
                   "          and a.receive_date < add_months('" + arg_work_year + "',12)                 " + 
                   "             group by trunc(a.receive_date,'mm')) b                                                                   " + 
                   "        where a.mm = b.mm                                                                                             " + 
                   "        order by a.gubun,a.mm ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>