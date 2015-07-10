<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date_seq = req.getParameter("arg_date_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("temp_chk",GauceDataColumn.TB_STRING,1));
    String query = "    select a.order_number order_number,  " + 
     "            NVL(to_char(b.yymm,'yyyy.mm'),SUBSTR('" + arg_date_seq + "'  ,1,4) || '.' || SUBSTR('" + arg_date_seq + "' ,5,2)) yymm,  " + 
     "            nvl(b.seq,1) seq,   " + 
     "            a.sbc_name , " + 
     "            a.order_class ," +
     "            a.guarantee_yn, " +
     "            'N'   temp_chk " +
     "       from s_cn_list a,  " + 
     "            (  SELECT max(i.dept_code) dept_code, " + 
     "                      max(i.order_number) order_number,  " + 
     "                      max(i.yymm) yymm,  " + 
     "                      max(i.seq) seq   " + 
     "                 FROM s_pay i  " + 
     "                where i.dept_code =  '" + arg_dept_code + "'    " + 
     "                  and substr(to_char(i.yymm,'yyyymmdd'),1,6) || to_char(i.seq) <  '" + arg_date_seq + "'    " + 
     "                  and i.yymm = ( select max(j.yymm)  " + 
     "                                 from s_pay j  " + 
     "                                where j.dept_code = i.dept_code  " + 
     "                                  and j.order_number = i.order_number  " + 
     "                                  and substr(to_char(j.yymm,'yyyymmdd'),1,6) || to_char(j.seq) <  '" + arg_date_seq + "'  ) " + 
     "             group by i.dept_code,  " + 
     "                      i.order_number,  " + 
     "                      i.yymm ) b  " + 
     "      where a.order_number  = b.order_number (+)  " + 
     "       and a.dept_code =  '" + arg_dept_code + "'   " + 
     "       and (a.ta_tag is null or a.ta_tag = 'N')  " + 
     "       and a.close_tag = 'N' " +
     "       and a.order_number not in (select order_number " + 
     "                                    from s_pay  " + 
     "     							         where dept_code =  '" + arg_dept_code + "'   " + 
     "     							           and substr(to_char(yymm,'yyyymmdd'),1,6) || to_char(seq) =  '" + arg_date_seq + "'  )      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>