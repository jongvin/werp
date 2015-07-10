<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_yymmseq = req.getParameter("arg_yymmseq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("c_bef_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("c_tm_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("c_tot_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT S_CN_LIST.DEPT_CODE dept_code,   " + 
     "         S_SBCR.SBCR_NAME sbcr_name,   " + 
     "         to_char(S_PAY.YYMM,'yyyy.mm') yymm,   " + 
     "         S_PAY.SEQ seq,   " + 
     "         S_PAY.PRGS_DEGREE prgs_degree,   " + 
     "         S_CN_LIST.SBC_NAME sbc_name,   " + 
     "         S_CN_LIST.SBC_AMT sbc_amt,   " + 
	 //부가세 제외금액 으로 수정
   //"         (s_pay.pre_prgs + s_pay.pre_prgs_notax + s_pay.pre_misctax_notax + s_pay.pre_purchase_vat) + s_pay.pre_vat C_BEF_PRGS,   " + 
   //"         (s_pay.tm_prgs + s_pay.tm_prgs_notax + s_pay.tm_purchase_vat)  + s_pay.tm_vat C_TM_PRGS,   " + 
   //"         (s_pay.pre_prgs + s_pay.pre_prgs_notax + s_pay.pre_misctax_notax + s_pay.pre_purchase_vat + " + 
   //"          s_pay.tm_prgs + s_pay.tm_prgs_notax + s_pay.tm_purchase_vat) +   (s_pay.pre_vat + s_pay.tm_vat) C_TOT_PRGS,   " + 
     "         (s_pay.pre_prgs + s_pay.pre_prgs_notax + s_pay.pre_misctax_notax + s_pay.pre_purchase_vat)  C_BEF_PRGS,   " + 
     "         (s_pay.tm_prgs + s_pay.tm_prgs_notax + s_pay.tm_purchase_vat)   C_TM_PRGS,   " + 
     "         (s_pay.pre_prgs + s_pay.pre_prgs_notax + s_pay.pre_misctax_notax + s_pay.pre_purchase_vat + " + 
     "          s_pay.tm_prgs + s_pay.tm_prgs_notax + s_pay.tm_purchase_vat)  C_TOT_PRGS,   " + 
     "         S_CN_LIST.SBC_DT sbc_dt,   " + 
     "         S_SBCR.REP_NAME1 rep_name1 " + 
     "    FROM S_CN_LIST,   " + 
     "         S_PAY,   " + 
     "         S_SBCR  " + 
     "   WHERE ( S_PAY.DEPT_CODE = S_CN_LIST.DEPT_CODE ) and  " + 
     "         ( S_PAY.ORDER_NUMBER = S_CN_LIST.ORDER_NUMBER ) and  " + 
     "         ( S_CN_LIST.SBCR_CODE = S_SBCR.SBCR_CODE ) and  " + 
     "         ( S_PAY.ORDER_NUMBER = " + arg_order_number + " ) and  " + 
     "         ( ( S_PAY.DEPT_CODE = '" + arg_dept_code + "' ) AND  " + 
     "           ( TO_CHAR(S_PAY.YYMM,'YYYY.MM.DD') || TO_CHAR(S_PAY.SEQ)   <= '" + arg_yymmseq  + "' ) " + 
     "         )    " + 
     "   ORDER BY S_PAY.YYMM DESC, S_PAY.SEQ DESC     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>