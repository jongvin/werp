<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_cont_no = req.getParameter("arg_cont_no");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
     String arg_extablish_time = req.getParameter("arg_extablish_time");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("extablish_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("collection_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("extablish_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("received_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prepay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exchange_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("reservation_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("bill_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("bill_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("delay_day",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("delay_interest_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("collection_cond",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("bankname",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,40));
    String query = "SELECT DEPT_CODE, 															" +
            "              CONT_NO, 															" +
            "              CHG_DEGREE,  														" +
            "              EXTABLISH_TIME, 													" +
            "              COLLECTION_TIME, 													" +
            "              EXTABLISH_TAG, 													" +
            "              to_char(RECEIVED_DATE,'yyyy.mm.dd')  RECEIVED_DATE, 	" +
            "              PREPAY_AMT, 														" +
				"	            EXCHANGE_TAG,					 									" +
            "              RESERVATION_AMT, 													" +
            "              SUPPLY_AMT, 														" +
            "              VAT_AMT,					  											" +
            "              SUM_AMT,     														" +
				"	 				CASH_AMT,															" +
				"	 				BILL_AMT,															" +
				"	 				to_char(BILL_DATE,'yyyy.mm.dd') BILL_DATE,				" +
				"	 				DELAY_DAY,															" +
				"	 				DELAY_INTEREST_AMT, 												" +
            " 					COLLECTION_COND, 													" +
            " 					BANKNAME, 															" +
            " 					DEPOSIT_NO, 														" +
            " 					REMARK  																" +
        		"			 FROM R_CONTRACT_TIME_COLLECTION       							" +
       		"        WHERE dept_code = '" + arg_dept_code + "' and  					" +
            "              cont_no   = '" + arg_cont_no   + "' and  					" +
            "              chg_degree = '" + arg_chg_degree + "' and  				" +
            "              extablish_time = '" + arg_extablish_time + "' 			" +
      		"     ORDER BY COLLECTION_TIME DESC      										";		
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>