<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("close_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_pay_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("previous_amt_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_kind",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_kind",GauceDataColumn.TB_STRING,30,0));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag2",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag3",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag4",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag5",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("insurance2_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("insurance2_name",GauceDataColumn.TB_STRING,20));
    String query = " " + 
       " select  a.dept_code, " + 
       "         a.order_number,  " + 
       "         b.const_no, " +
       "         c.sbcr_name,  " + 
       "         b.sbc_name,   " + 
       "         a.chg_degree, " + 
       "         a.approve_class, " + 
       "         to_char(b.start_dt,'yyyy.mm.dd') start_dt, " + 
       "         to_char(b.end_dt,'yyyy.mm.dd') end_dt, " + 
       "         b.sbc_amt,  " + 
       "         b.close_tag,  " + 
       "         b.previous_pay_tag, " + 
       "         b.previous_amt_rt, " + 
       "         b.previous_amt - nvl(b.previous_vat,0) previous_amt, " + 
       "         b.previous_vat, " + 
       "         b.sbc_guarantee_rt, " + 
       "         b.sbc_guarantee_amt, " + 
       "         b.sbc_guarantee_kind, " + 
       "         to_char(b.sbc_guarantee_start_dt,'yyyy.mm.dd') sbc_guarantee_start_dt, " + 
       "         to_char(b.sbc_guarantee_end_dt,'yyyy.mm.dd') sbc_guarantee_end_dt, " + 
       "         b.warrant_guarantee_rt, " + 
       "         b.warrant_guarantee_amt, " + 
       "         b.warrant_guarantee_kind, " + 
       "         to_char(b.warrant_guarantee_start_dt,'yyyy.mm.dd') warrant_guarantee_start_dt, " + 
       "         to_char(b.warrant_guarantee_end_dt,'yyyy.mm.dd') warrant_guarantee_end_dt ," + 
       "         b.guarantee_tag1,b.guarantee_tag2,b.guarantee_tag3,b.guarantee_tag4,b.guarantee_tag5,b.insurance2_amt1,b.insurance2_name" +
       "     from (  " + 
			         "  SELECT s_chg_cn_list.dept_code dept_code,   " + 
			         "         s_chg_cn_list.order_number order_number,   " + 
			         "         max(chg_degree) chg_degree,   " + 
			         "         min(approve_class) approve_class " + 
			         "    FROM s_chg_cn_list " + 
			         "    where    s_chg_cn_list.dept_code = '" + arg_dept_code + "' " + 
			         " GROUP BY s_chg_cn_list.dept_code,   " + 
			         "         s_chg_cn_list.order_number,   " + 
			         "         s_chg_cn_list.order_name ) a, s_chg_cn_list b, s_sbcr c " +
            " where a.dept_code = b.dept_code and  " + 
            "       a.order_number = b.order_number and " + 
            "       a.chg_degree = b.chg_degree  and " + 
            "       b.sbcr_code = c.sbcr_code " + 
            " order by a.order_number desc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>