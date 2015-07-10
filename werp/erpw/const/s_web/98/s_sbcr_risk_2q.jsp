<%@ page contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_sbcr_code = req.getParameter("arg_sbcr_code");

 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,8));
	dSet.addDataColumn(new GauceDataColumn("SBCR_NAME",GauceDataColumn.TB_STRING,4));
	dSet.addDataColumn(new GauceDataColumn("SBC_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("SBCR_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("LONG_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("CONT_GUBN",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("START_DT",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("END_DT",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("CONST_AMT",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("CONST_VAT",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("PRE_AMT",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("PRE_VAT",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("PAY_AMT",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("PAY_VAT",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("PRE_PAY_AMT",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("PRE_PAY_VAT",GauceDataColumn.TB_DECIMAL,18,0));

String query = "" +
" SELECT" +
" 	A.DEPT_CODE," +
" 	B.SBCR_NAME, A.SBC_NAME, C.LONG_NAME," +
"	decode((nvl(A.SUPPLY_AMT_TAX,0) + nvl(A.SUPPLY_AMT_NOTAX,0) + nvl(A.PURCHASE_VAT,0)),nvl(F.PAY_AMT,0),decode(nvl(A.VAT,0),nvl(F.PAY_VAT,0),'정산완료','미정산'),'미정산') CONT_GUBN," +
" 	to_char(A.START_DT,'yyyy.dd.dd') START_DT, to_char(A.END_DT,'yyyy.mm.dd') END_DT," +
" 	nvl(A.SUPPLY_AMT_TAX,0) + nvl(A.SUPPLY_AMT_NOTAX,0) + nvl(A.PURCHASE_VAT,0) CONST_AMT," +
" 	nvl(A.VAT,0) CONST_VAT," +
" 	nvl(A.SAFETY_AMT1,0) + nvl(A.SAFETY_AMT2,0) PRE_AMT," +
" 	nvl(A.PREVIOUS_VAT,0) PRE_VAT," +
" 	nvl(F.PAY_AMT,0) PAY_AMT," +
" 	nvl(F.PAY_VAT,0) PAY_VAT," +
" 	nvl(F.PRE_PAY_AMT,0) PRE_PAY_AMT," +
" 	nvl(F.PRE_PAY_VAT,0) PRE_PAY_VAT" +
" FROM" +
" 	S_CN_LIST A," +
" 	S_SBCR B," +
" 	Z_CODE_DEPT C," +
" 	(" +
"     SELECT" +
"     	E.DEPT_CODE," +
"     	E.ORDER_NUMBER," +
"     	SUM(nvl(E.TM_PRGS,0) + nvl(E.TM_PRGS_NOTAX,0) + nvl(E.TM_PURCHASE_VAT,0)) PAY_AMT," +
"     	SUM(nvl(E.TM_VAT,0)) PAY_VAT," +
"     	SUM(nvl(E.TM_PRE_TAX,0) + nvl(E.TM_PRE_NOTAX,0)) PRE_PAY_AMT," +
"     	SUM(nvl(E.TM_PRE_VAT,0)) PRE_PAY_VAT" +
"     FROM" +
"     	S_PAY E" +
"     GROUP BY" +
"     	E.DEPT_CODE, E.ORDER_NUMBER" +
" 	) F" +
" WHERE" +
" 	A.SBCR_CODE = '" + arg_sbcr_code + "'" +
" AND A.SBCR_CODE = B.SBCR_CODE" +
" AND A.DEPT_CODE = C.DEPT_CODE" +
" AND A.DEPT_CODE = F.DEPT_CODE(+) AND A.ORDER_NUMBER = F.ORDER_NUMBER(+)" +
" ORDER BY " +
"	decode((nvl(A.SUPPLY_AMT_TAX,0) + nvl(A.SUPPLY_AMT_NOTAX,0) + nvl(A.PURCHASE_VAT,0)),nvl(F.PAY_AMT,0),decode(nvl(A.VAT,0),nvl(F.PAY_VAT,0),'1','0'),'0')";

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>