<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_cont_no = req.getParameter("arg_cont_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_year_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("completion_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("const_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_process_class",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("last_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("parent_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("ledger_no",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("membership_no",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("const_shortname",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("position",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("position2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("field_tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("charge_pm1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("charge_pm2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("constkind_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("const_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("receive_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("tender_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("order_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("contract_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("tax_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("change_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("up_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("change_kind",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("bid_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("design_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("survey_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("budget_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bid_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("change_supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("change_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("change_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cont_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_outline1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_outline2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("limit_contents1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("limit_contents2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("use_seal_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_charger",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_remark",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("demand_charger",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("demand_tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("demand_remark",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("master_dept",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("completion_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("completion_testdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("delay_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("reserve_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cont_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warranty_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warranty_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("warranty_start",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warranty_end",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("control_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bankname",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("constamt_paycond",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("extablish_paycond",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("completion_paycond",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deposit_paycond",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("etc_paycond",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("designer",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("administer",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("payment_condition",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("payment_method",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("change_status",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("operation_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("operation_supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("operation_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("operation_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("operation_tot_cont_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("proj_deputy",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("region_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("masterdept_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("exempt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("o_s_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("o_v_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("o_a_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.CONT_NO,   " + 
     "         a.CONTRACT_YEAR_TAG,   " + 
     "         a.COMPLETION_TAG,   " + 
     "         a.ORDER_NO,   " + 
     "         a.CONST_NAME,   " + 
     "         a.CONST_PROCESS_CLASS,   " + 
     "         a.CHG_DEGREE,   " + 
     "         a.LAST_TAG,   " + 
     "         a.RECEIVE_CODE,   " + 
     "         a.PARENT_DEPT_CODE,   " + 
     "         a.LEDGER_NO,   " + 
     "         a.MEMBERSHIP_NO,   " + 
     "         a.CONST_SHORTNAME,   " + 
     "         a.REGION_CODE,   " + 
     "         a.POSITION,   " + 
     "         a.POSITION2,   " + 
     "         a.FIELD_TEL,   " + 
     "         a.CHARGE_PM1,   " + 
     "         a.CHARGE_PM2,   " + 
     "         a.CONSTKIND_TAG,   " + 
     "         a.PQ_TAG,   " + 
     "         a.CONST_TAG,   " + 
     "         a.RECEIVE_TAG,   " + 
     "         a.TENDER_TAG,   " + 
     "         a.ORDER_TAG,   " + 
     "         a.CONTRACT_TAG,   " + 
     "         a.TAX_TAG,   " + 
     "         a.CHANGE_TAG,   " + 
     "         to_char(a.UP_DATE,'YYYY.MM.DD')  UP_DATE,  " + 
     "         a.CHANGE_KIND,   " + 
     "         to_char(a.BID_DATE,'YYYY.MM.DD') BID_DATE,   " + 
     "         to_char(a.CONT_DATE,'YYYY.MM.DD') CONT_DATE,   " + 
     "         nvl(a.DESIGN_AMT,0)  DESIGN_AMT,   " + 
     "         nvl(a.SURVEY_AMT,0)  SURVEY_AMT, " + 
     "         nvl(a.BUDGET_AMT,0)   BUDGET_AMT," + 
     "         nvl(a.BID_AMT,0)  BID_AMT, " + 
     "         nvl(a.CHANGE_SUPPLY_AMT,0) CHANGE_SUPPLY_AMT,  " + 
     "         nvl(a.CHANGE_VAT_AMT,0) CHANGE_VAT_AMT,  " + 
     "         (nvl(a.CHANGE_SUPPLY_AMT,0) + nvl(a.exempt_amt, 0) + nvl(a.CHANGE_VAT_AMT,0)) CHANGE_SUM_AMT,  " + 
     "         nvl(a.TOT_CONT_AMT,0)  TOT_CONT_AMT, " + 
     "         a.CONST_OUTLINE1,   " + 
     "         a.CONST_OUTLINE2,   " + 
     "         a.LIMIT_CONTENTS1,   " + 
     "         a.LIMIT_CONTENTS2,   " + 
     "         a.USE_SEAL_NO,   " + 
     "         a.ORDER_CHARGER,   " + 
     "         a.ORDER_TEL,   " + 
     "         a.ORDER_REMARK,   " + 
     "         a.DEMAND_CHARGER,   " + 
     "         a.DEMAND_TEL,   " + 
     "         a.DEMAND_REMARK,   " + 
     "         a.MASTER_DEPT,   " + 
     "         to_char(a.START_DATE,'YYYY.MM.DD')   START_DATE, " + 
     "         to_char(a.COMPLETION_DATE,'YYYY.MM.DD') COMPLETION_DATE,  " + 
     "         to_char(a.COMPLETION_TESTDATE,'YYYY.MM.DD')  COMPLETION_TESTDATE,  " + 
     "         nvl(a.DELAY_RATE,0)  DELAY_RATE, " + 
     "         nvl(a.RESERVE_RATE,0)  RESERVE_RATE, " + 
     "         nvl(a.CONT_RATE,0)  CONT_RATE, " + 
     "         nvl(a.WARRANTY_RATE,0) WARRANTY_RATE,  " + 
     "         nvl(a.WARRANTY_AMT,0)  WARRANTY_AMT, " + 
     "         to_char(a.WARRANTY_START,'YYYY.MM.DD')   WARRANTY_START, " + 
     "         to_char(a.WARRANTY_END,'YYYY.MM.DD') WARRANTY_END,  " + 
     "         a.CONTROL_TAG,   " + 
     "         a.BANKNAME,   " + 
     "         a.DEPOSIT_NO,   " + 
     "         a.CONSTAMT_PAYCOND,   " + 
     "         a.EXTABLISH_PAYCOND,   " + 
     "         a.COMPLETION_PAYCOND,   " + 
     "         a.DEPOSIT_PAYCOND,   " + 
     "         a.ETC_PAYCOND,   " + 
     "         a.DESIGNER,   " + 
     "         a.ADMINISTER,   " + 
     "         a.PAYMENT_CONDITION,   " + 
     "         a.PAYMENT_METHOD,   " + 
     "         a.CHANGE_STATUS,   " + 
     "         nvl(a.OPERATION_RATE,0)  OPERATION_RATE, " + 
     "         nvl(a.OPERATION_SUPPLY_AMT,0)  OPERATION_SUPPLY_AMT, " + 
     "         nvl(a.OPERATION_VAT_AMT,0)  OPERATION_VAT_AMT, " + 
     "         nvl(a.OPERATION_SUM_AMT,0)  OPERATION_SUM_AMT, " + 
     "         nvl(a.OPERATION_TOT_CONT_AMT,0) OPERATION_TOT_CONT_AMT, " +
	  "         a.proj_deputy, "+
	  "         a.masterdept_tag, " +
	  "         nvl(a.exempt_amt, 0) exempt_amt, " +
	  "         nvl(a.etc_amt, 0) etc_amt, " +
	  "         (nvl(a.CHANGE_SUPPLY_AMT,0) + nvl(a.exempt_amt, 0)) supply_amt, " +
	  "         decode(a.chg_degree, 1, 0, nvl(jj.o_s_amt, 0)) o_s_amt, " +
	  "         decode(a.chg_degree, 1, 0, nvl(jj.o_v_amt, 0)) o_v_amt, " +
	  "         decode(a.chg_degree, 1, 0, (nvl(jj.o_s_amt, 0) + nvl(jj.o_v_amt, 0))) o_a_amt, " +
     "			b.order_name," + 
     "			c.name region_name, " + 
     "         d.long_name " +
     "    FROM R_CONTRACT_REGISTER  a," + 
     "			r_code_order b," + 
     "			y_region_code c, " + 
     "                  z_code_dept d, " +
     "         (select a.dept_code, " +
     "  					  a.cont_no, " +
	  "		 			  a.chg_degree, " +
     "  					  ((nvl(a.change_supply_amt,0)+nvl(a.exempt_amt,0)) - (nvl(b.change_supply_amt,0)+nvl(b.exempt_amt,0))) o_s_amt, " +
     "  					  (nvl(a.change_vat_amt,0) - nvl(b.change_vat_amt,0)) o_v_amt " +
	  "				from (select rownum-1 no, " +
	  "	  			     			 dept_code, " +
	  "				 	  			 cont_no, " +
     "          		  			 chg_degree, " +
	  "				 	  			 change_supply_amt, " +
	  "				 	  			 exempt_amt, " +
	  "				 	  			 change_vat_amt " +
     "    					  from R_CONTRACT_REGISTER  " +
     "           			 where dept_code = '" + arg_dept_code + "' and " +
     "                         cont_no = '" + arg_cont_no  + "' ) a, " +
     " " +
     "  					  (select rownum no, " +
	  "	  			 	  			 dept_code, " +
	  "				 	  			 cont_no, " +
	  "	          	  			 chg_degree,  " +
	  "				 	  			 change_supply_amt, " +
	  "				 	  			 exempt_amt, " +
	  "				 	  			 change_vat_amt " +
     "    					  from R_CONTRACT_REGISTER  " +
     "    		  			 where dept_code = '" + arg_dept_code + "' and " +
     "                         cont_no = '" + arg_cont_no  + "' ) b	" +
     "    		  where a.no = b.no(+) " +
     "         ) jj " +
     "   WHERE a.order_no  = b.order_no (+) and " + 
     "         a.parent_dept_code = d.dept_code (+) and " +
     "			a.region_code = c.region_code (+) and " + 
 //    "         a.dept_code = jj.dept_code(+) and " +
//     "         a.dept_code = jj.cont_no(+) and " +
     "         a.chg_degree = jj.chg_degree(+) and " +
     "			a.DEPT_CODE =  " + "'" + arg_dept_code + "'" + "  AND  " + 
     "         a.CONT_NO = " + "'" + arg_cont_no  + "'" +
     " ORDER BY a.chg_degree desc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>