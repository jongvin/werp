<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cur_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
    String query = "select c.dept_code dept_code," + 
     "       c.order_number order_number," + 
     "       d.sbcr_code sbcr_code," + 
     "       d.sbcr_name sbcr_name," + 
     "       c.sbc_name sbc_name ," + 
//     "       nvl(c.sbc_amt,0)  sbc_amt," + 	�ΰ����� ������ ���ݾ��� �ʿ���.
	  "		 (nvl(c.sbc_amt,0) - nvl(c.vat, 0)) sbc_amt, " +
     "       nvl(b.lst_prgs,0) bef_prgs, " + 
     "       nvl(a.cur_prgs,0) cur_prgs," + 
     "       nvl(b.lst_prgs,0) + nvl(a.cur_prgs,0)  tot_prgs," + 
     "       c.sbc_dt sbc_dt," + 
     "       d.rep_name1 rep_name1" + 
     "    from (" + 
     "		SELECT s_pay.dept_code," + 
     "				 s_pay.order_number," + 
	 //�ΰ��� ���ܱݾ� ���� ����
   //"				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0) + nvl(s_pay.tm_vat,0)) cur_prgs" + 
     "				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0)) cur_prgs" + 
     "			 from s_pay" + 
     "			 where (s_pay.DEPT_CODE = '" + arg_dept_code + "') AND  " + 
     "					 (s_pay.yymm = '" + arg_yymm + "' ) " + 
     "			 GROUP BY s_pay.dept_code,s_pay.order_number) a," + 
     "     (" + 
     "		SELECT s_pay.dept_code," + 
     "				 s_pay.order_number," + 
	 //�ΰ��� ���ܱݾ� ���� ����
   //"				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0) + nvl(s_pay.tm_vat,0)) lst_prgs" + 
	 "				 sum(nvl(s_pay.tm_prgs,0) + nvl(s_pay.tm_prgs_notax,0) + nvl(s_pay.tm_purchase_vat,0) ) lst_prgs" + 
     "			 from s_pay" + 
     "			 where (s_pay.DEPT_CODE = '" + arg_dept_code + "') AND  " + 
     "					 (s_pay.yymm < '" + arg_yymm + "') " + 
     "			 GROUP BY s_pay.dept_code,s_pay.order_number) b," + 
     "            s_cn_list c , s_sbcr d" + 
     "     where a.dept_code (+) = c.dept_code  and" + 
     "           a.order_number (+)  = c.order_number AND" + 
     "           b.dept_code (+) = c.dept_code  and" + 
     "           b.order_number (+)  = c.order_number AND" + 
     "           c.dept_code = '" + arg_dept_code + "' AND  " + 
     "           c.sbcr_code = d.sbcr_code      " + 
     "      order by d.sbcr_name,c.sbc_name    ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>