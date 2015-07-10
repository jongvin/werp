<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
    String query = "select c.dept_code dept_code," + 
     "       c.order_number order_number," + 
     "       d.long_name  long_name ," + 
     "       c.sbc_name sbc_name ," + 
     "       (c.sbc_amt - c.vat) sbc_amt," + 
     "       nvl(b.lst_prgs,0) bef_prgs, " + 
     "       nvl(a.cur_prgs,0) cur_prgs," + 
     "       nvl(b.lst_prgs,0) + nvl(a.cur_prgs,0)  tot_prgs," + 
     "       c.sbc_dt sbc_dt," + 
     "       e.rep_name1 rep_name1" + 
     "    from (" +   // 당월
     "		SELECT s_pay.dept_code," + 
     "				 s_pay.order_number," + 
     "				 s_cn_list.sbcr_code," + 
	 //부가세 제외금액 으로 수정
   //"				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0) + nvl(s_pay.tm_vat,0)) cur_prgs" + 
     "				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0) ) cur_prgs" + 
     "			 from s_pay,s_cn_list " + 
     "			 where (s_pay.DEPT_CODE  = s_cn_list.dept_code) AND  " + 
     "			       (s_pay.order_number = s_cn_list.order_number) AND  " + 
     "			       (s_cn_list.sbcr_code  = '" + arg_sbcr_code + "') AND  " + 
     "					 (s_pay.yymm = '" + arg_yymm + "' ) " + 
     "			 GROUP BY s_pay.dept_code,s_pay.order_number,s_cn_list.sbcr_code) a," + 
     "     (" +       // 전월 
     "		SELECT s_pay.dept_code," + 
     "				 s_pay.order_number," + 
     "				 s_cn_list.sbcr_code," + 
	 //부가세 제외금액 으로 수정
   //"				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0) + nvl(s_pay.tm_vat,0)) lst_prgs" + 
     "				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0) ) lst_prgs" + 
     "			 from s_pay,s_cn_list " + 
     "			 where (s_pay.DEPT_CODE = s_cn_list.dept_code) AND  " + 
     "			       (s_pay.order_number = s_cn_list.order_number) AND  " + 
     "			       (s_cn_list.sbcr_code  = '" + arg_sbcr_code + "') AND  " + 
     "					 (s_pay.yymm < '" + arg_yymm + "' ) " + 
     "			 GROUP BY s_pay.dept_code,s_pay.order_number,s_cn_list.sbcr_code) b," + 
     "            s_cn_list c , z_code_dept d, s_sbcr e " + 
     "     where a.dept_code (+) = c.dept_code  and" + 
     "           a.order_number (+) = c.order_number AND" + 
     "           b.dept_code (+) = c.dept_code  and" + 
     "           b.order_number (+) = c.order_number AND" + 
     "           c.sbcr_code = '" + arg_sbcr_code + "'  and " + 
     "           c.dept_code = d.dept_code  and      " + 
     "           c.sbcr_code = e.sbcr_code   " + 
     "     order by    d.long_name,c.sbc_name   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>