<%@ page contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_resno = req.getParameter("resno");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("기업신용등급",GauceDataColumn.TB_STRING,10,0));
	dSet.addDataColumn(new GauceDataColumn("현금흐름등급",GauceDataColumn.TB_STRING,10,0));
	dSet.addDataColumn(new GauceDataColumn("WATCH등급",GauceDataColumn.TB_STRING,10,0));
	dSet.addDataColumn(new GauceDataColumn("WATCH변경일",GauceDataColumn.TB_STRING,8,0));
	dSet.addDataColumn(new GauceDataColumn("기준년월일",GauceDataColumn.TB_STRING,8,0));
	dSet.addDataColumn(new GauceDataColumn("당기자본금",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("당기유동자산",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("당기유동부채",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("당기자본총계",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전기자본금",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전기유동자산",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전기유동부채",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전기자본총계",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전전기자본금",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전전기유동자산",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전전기유동부채",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전전기자본총계",GauceDataColumn.TB_DECIMAL,18,0));

	dSet.addDataColumn(new GauceDataColumn("당기매출액",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전기매출액",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전전기매출액",GauceDataColumn.TB_DECIMAL,18,0));

	dSet.addDataColumn(new GauceDataColumn("당기순이익",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전기순이익",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("전전기순이익",GauceDataColumn.TB_DECIMAL,18,0));

	dSet.addDataColumn(new GauceDataColumn("전전기부채비율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("전기부채비율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("당기부채비율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("전전기매출액증가율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("전기매출액증가율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("당기매출액증가율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("전전기순이익증가율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("전기순이익증가율",GauceDataColumn.TB_DECIMAL,18,1));
	dSet.addDataColumn(new GauceDataColumn("당기순이익증가율",GauceDataColumn.TB_DECIMAL,18,1));

    String query = " " +
			" SELECT" +
			" 	CC.LASTGRD2 기업신용등급," +
			" 	DD.DECISION 현금흐름등급," +
			" 	EE.FWATCHD WATCH등급," +
			" 	EE.FDGBYIL WATCH변경일," +

			" 	'20' || AA.기준년월일 기준년월일," +

			" 	AA.당기자본금," +
			"	AA.당기유동자산," +
			"	AA.당기유동부채," +
			"	AA.당기자본총계," +
			 
			"	AA.전기자본금," +
			"	AA.전기유동자산," +
			"	AA.전기유동부채," +
			"	AA.전기자본총계," +
			 
			"	AA.전전기자본금," +
			"	AA.전전기유동자산," +
			"	AA.전전기유동부채," +
			"	AA.전전기자본총계," +

			"	FF.당기매출액," +
			"	FF.전기매출액," +
			"	FF.전전기매출액," +

			"	FF.당기순이익," +
			"	FF.전기순이익," +
			"	FF.전전기순이익," +

			" 	BB.TR0051 전전기부채비율," +
			" 	BB.TR0052 전기부채비율," +
			" 	BB.TR0053 당기부채비율," +

			" 	BB.TR0221 전전기매출액증가율," +
			" 	BB.TR0222 전기매출액증가율," +
			" 	BB.TR0223 당기매출액증가율," +

			" 	BB.TR0231 전전기순이익증가율," +
			" 	BB.TR0232 전기순이익증가율," +
			" 	BB.TR0233 당기순이익증가율" +
			" FROM" +
			"	(" +
			"	 SELECT" +
			"     	B.SUVDT," +
			"     	B.RESNO," +
			"     	MAX(A.BS_ESETDT) 기준년월일," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0092 ELSE 0 END) 당기자본금," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0001 ELSE 0 END) 당기유동자산," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0060 ELSE 0 END) 당기유동부채," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.BS0113 ELSE 0 END) 당기자본총계," +

			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0092 ELSE 0 END) 전기자본금," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0001 ELSE 0 END) 전기유동자산," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0060 ELSE 0 END) 전기유동부채," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.BS0113 ELSE 0 END) 전기자본총계," +

			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0092 ELSE 0 END) 전전기자본금," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0001 ELSE 0 END) 전전기유동자산," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0060 ELSE 0 END) 전전기유동부채," +
			"     	SUM(CASE WHEN A.TRANSEQ = '0002' THEN A.BS0113 ELSE 0 END) 전전기자본총계" +
			"     FROM" +
			"     	(SELECT MAX(SUVDT) SUVDT, RESNO FROM DCC_PACKET01 GROUP BY RESNO) B," +
			"     	DCC_PACKET06 A" +
			"     WHERE" +
			"     	A.SUVDT(+) = B.SUVDT AND A.RESNO(+) = B.RESNO" +
			"     AND A.RESNO = '" + arg_resno + "'" +
			"     GROUP BY" +
			"     	B.SUVDT, B.RESNO" +
			" 	) AA," +
			" 	DCC_PACKET10 BB," +
			" 	DCC_PACKET01 CC," +
			" 	DCC_PACKET11 DD," +
			" 	(" +
			" 	SELECT A.* FROM WATCH_GRADE A, (SELECT RESNO,MAX(FDGBYIL) FDGBYIL FROM WATCH_GRADE GROUP BY RESNO) B WHERE A.RESNO = B.RESNO AND A.FDGBYIL = B.FDGBYIL" +
			" 	) EE," +
			"	(" +
			"	SELECT" +
			" 		A.SUVDT," +
			" 		A.RESNO," +

			" 		SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.PL0001 ELSE 0 END) 당기매출액," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.PL0001 ELSE 0 END) 전기매출액," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0003' THEN A.PL0001 ELSE 0 END) 전전기매출액," +

			" 		SUM(CASE WHEN A.TRANSEQ = '0000' THEN A.PL0071 ELSE 0 END) 당기순이익," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0001' THEN A.PL0071 ELSE 0 END) 전기순이익," +
			" 		SUM(CASE WHEN A.TRANSEQ = '0003' THEN A.PL0071 ELSE 0 END) 전전기순이익" +
			"	FROM" +
			" 		DCC_PACKET07 A" +
			"	GROUP BY" +
			" 		A.SUVDT," +
			" 		A.RESNO" +
			"	) FF" +
	
			" WHERE" +
			" 	AA.SUVDT = BB.SUVDT(+) AND AA.RESNO = BB.RESNO(+)" +
			" AND AA.SUVDT = CC.SUVDT(+) AND AA.RESNO = CC.RESNO(+)" +
			" AND AA.SUVDT = DD.SUVDT(+) AND AA.RESNO = DD.RESNO(+)" +
			" AND AA.RESNO = EE.RESNO(+)" +
			" AND AA.SUVDT = FF.SUVDT(+) AND AA.RESNO = FF.RESNO(+)" ;


%><%@ include file="../../../comm_function/conn_q_end.jsp"%>