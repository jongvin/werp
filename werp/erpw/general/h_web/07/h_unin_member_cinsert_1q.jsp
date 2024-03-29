<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("key_union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_union_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("res_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("change_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("change_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("compensation_quota",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("grnd_quota",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong_sellamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("collateral_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("move_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mortgage",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("contract_pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("draw_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prize_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("prize_pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("settlement_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("annul_reason",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("refund_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("penalty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("interest_remain_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("refund_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rebuild_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("loan_bank",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("loan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("loan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("loan_interest",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seizure_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seizure_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("union_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.UNION_CODE,   " + 
     "                       a.UNION_ID,   " + 
     "                       a.UNION_ID   key_union_id,   " + 
     "                       a.UNION_SEQ,   " + 
     "                       a.UNION_SEQ   key_union_seq,   " + 
     "                       a.CUST_CODE,   " + 
     "                       b.cust_name," + 
     "                       a.PYONG,   " + 
     "                       to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "                       a.RES_DONGHO,   " + 
     "                       a.CHANGE_DIV,   " + 
     "                       to_char(a.CHANGE_DATE,'YYYY.MM.DD') change_date,   " + 
     "                       to_char(a.LAST_CONTRACT_DATE,'YYYY.MM.DD') last_contract_date,   " + 
     "                       a.COMPENSATION_QUOTA,   " + 
     "                       a.GRND_QUOTA,   " + 
     "                       a.PYONG_SELLAMT,   " + 
     "                       a.COLLATERAL_AMT,   " + 
     "                       to_char(a.MOVE_DATE,'YYYY.MM.DD') move_date,   " + 
     "                       a.MORTGAGE,   " + 
     "                       a.CONTRACT_PYONG,   " + 
     "                       to_char(a.DRAW_DATE,'YYYY.MM.DD') draw_date,   " + 
     "                       a.PRIZE_DONGHO,   " + 
     "                       a.PRIZE_PYONG,   " + 
     "                       a.SETTLEMENT_AMT,   " + 
     "                       a.ANNUL_REASON,   " + 
     "                       to_char(a.REFUND_DATE,'YYYY.MM.DD') refund_date,   " + 
     "                       a.PENALTY,   " + 
     "                       a.INTEREST_REMAIN_AMT,   " + 
     "                       a.REFUND_AMT,   " + 
     "                       a.REBUILD_YN,   " + 
     "                       a.LOAN_BANK,   " + 
     "                       to_char(a.LOAN_DATE,'YYYY.MM.DD') loan_date,   " + 
     "                       a.LOAN_AMT,   " + 
     "                       a.LOAN_INTEREST,   " + 
     "                       a.SEIZURE_AMT,   " + 
     "                       to_char(a.SEIZURE_DATE,'YYYY.MM.DD') seizure_date,  " + 
     "                       c.union_name " +
     "                  FROM H_UNIN_MEMBER  a," + 
     "              			  h_code_cust b, " + 
     "                       h_unin_ledger c " +
     "                 WHERE a.dept_code = c.dept_code " +
     "                   AND a.sell_code = c.sell_code " +
     "                   AND a.union_code = c.union_code " +
     "                   AND a.cust_code = b.cust_code (+)" + 
     "                   AND a.change_div <> '03' " +
     "                   AND a.DEPT_CODE = " + "'" + arg_dept_code  + "'" + 
     "                   AND a.SELL_CODE = " + "'" + arg_sell_code  + "'" + 
     "              ORDER BY a.UNION_CODE ASC, " +
     "                       a.UNION_ID ASC,   " + 
     "                       a.UNION_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>