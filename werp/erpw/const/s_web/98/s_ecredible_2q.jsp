<%@ page contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_resno = req.getParameter("resno");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("기준년도",GauceDataColumn.TB_STRING,8,0));
	dSet.addDataColumn(new GauceDataColumn("면허종류",GauceDataColumn.TB_STRING,50,0));
	dSet.addDataColumn(new GauceDataColumn("면허번호",GauceDataColumn.TB_STRING,50,0));
	dSet.addDataColumn(new GauceDataColumn("시공능력평가액",GauceDataColumn.TB_DECIMAL,8,0));
	dSet.addDataColumn(new GauceDataColumn("지역순위",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("지역순위전체",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전국순위",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전국순위전체",GauceDataColumn.TB_DECIMAL,18,0));

    String query = " " +
					" SELECT" +
					" 	CONABYR 기준년도," +
					" 	CONUPJN 면허종류," +
					" 	CONUPNM 면허번호," +
					" 	CONABMN 시공능력평가액," +
					" 	CLCABRK 지역순위," +
					" 	CLCABST 지역순위전체," +
					" 	CWCABRK 전국순위," +
					" 	CWCABST 전국순위전체" +
					" FROM" +
					" 	CNT_PACKET03" +
					" WHERE" +
					" 	RESNO = '" + arg_resno + "'" +
					" ORDER BY" +
					" 	CONUPJN, CONABYR DESC";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>