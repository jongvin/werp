<%@ page contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_year                = req.getParameter("arg_year");
	String arg_profession_wbs_code = req.getParameter("arg_profession_wbs_code");
	String arg_sbcr_name           = req.getParameter("arg_sbcr_name");
	String arg_pre_score_s         = req.getParameter("arg_pre_score_s");
	String arg_pre_score_s_con     = req.getParameter("arg_pre_score_s_con");
	String arg_pre_score_e         = req.getParameter("arg_pre_score_e");
	String arg_pre_score_e_con     = req.getParameter("arg_pre_score_e_con");
	String arg_score_s             = req.getParameter("arg_score_s");
	String arg_score_s_con         = req.getParameter("arg_score_s_con");
	String arg_score_e             = req.getParameter("arg_score_e"); 
	String arg_score_e_con         = req.getParameter("arg_score_e_con");
	String arg_FWATCHD             = req.getParameter("arg_FWATCHD");
	String arg_LASTGRD2_s          = req.getParameter("arg_LASTGRD2_s");
	String arg_LASTGRD2_s_con      = req.getParameter("arg_LASTGRD2_s_con");
	String arg_LASTGRD2_e          = req.getParameter("arg_LASTGRD2_e");
	String arg_LASTGRD2_e_con      = req.getParameter("arg_LASTGRD2_e_con");
	String arg_DECISION_s          = req.getParameter("arg_DECISION_s");
	String arg_DECISION_s_con      = req.getParameter("arg_DECISION_s_con");
	String arg_DECISION_e          = req.getParameter("arg_DECISION_e");
	String arg_DECISION_e_con      = req.getParameter("arg_DECISION_e_con"); 
	String arg_DECISION_NOTE       = req.getParameter("arg_DECISION_NOTE");

 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("SBCR_CODE",GauceDataColumn.TB_STRING,8));
	dSet.addDataColumn(new GauceDataColumn("PROFESSION_WBS_CODE",GauceDataColumn.TB_STRING,4));
	dSet.addDataColumn(new GauceDataColumn("PROFESSION_WBS_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("SBCR_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("REGISTER_NAME",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("EVA_SCORE_1",GauceDataColumn.TB_DECIMAL,18,2));
	dSet.addDataColumn(new GauceDataColumn("EVA_SCORE_2",GauceDataColumn.TB_DECIMAL,18,2));
	dSet.addDataColumn(new GauceDataColumn("EVA_SCORE_3",GauceDataColumn.TB_DECIMAL,18,2));
	dSet.addDataColumn(new GauceDataColumn("EVA_SCORE",GauceDataColumn.TB_DECIMAL,18,2));
	dSet.addDataColumn(new GauceDataColumn("LASTGRD2",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("LASTGRD2_DT",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("DECISION",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("DECISION_DT",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("FWATCHD",GauceDataColumn.TB_STRING,20));
	dSet.addDataColumn(new GauceDataColumn("FWATCHD_DT",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("WATCH_NOTE",GauceDataColumn.TB_STRING,100));
	dSet.addDataColumn(new GauceDataColumn("NOTE",GauceDataColumn.TB_STRING,100));
	dSet.addDataColumn(new GauceDataColumn("DECISION_NOTE",GauceDataColumn.TB_STRING,10));

String query = "" +
" SELECT" +
"	B.SBCR_CODE, B.PROFESSION_WBS_CODE," +
" 	D.PROFESSION_WBS_NAME, A.SBCR_NAME," +
" 	CASE WHEN B.REGISTER_CHK = '1' THEN '정규등록'" +
" 		 WHEN B.REGISTER_CHK = '2' THEN '예비등록'" +
" 		 WHEN B.REGISTER_CHK = '3' THEN '미등록'" +
" 		 WHEN B.REGISTER_CHK = '4' THEN '등록취소'" +
" 		 WHEN B.REGISTER_CHK = '5' THEN '기타등록'" +
" 		 WHEN B.REGISTER_CHK = '6' THEN '[자재]정규'" +
" 		 WHEN B.REGISTER_CHK = '7' THEN '[자재]미등록'" +
" 		 WHEN B.REGISTER_CHK = '8' THEN '지역등록'" +
" 		 WHEN B.REGISTER_CHK = '9' THEN '임시'" +
" 	END REGISTER_NAME," +
" 	nvl(C.EVA_SCORE_1,0) EVA_SCORE_1, nvl(C.EVA_SCORE_2,0) EVA_SCORE_2, nvl(EVA_SCORE_3,0) EVA_SCORE_3," +
" 	ROUND(CASE WHEN nvl(C.EVA_SCORE_1,0) = 0 AND nvl(C.EVA_SCORE_2,0) = 0 AND nvl(EVA_SCORE_3,0) = 0 THEN 0" +
" 		 ELSE" +
" 			(nvl(C.EVA_SCORE_1,0) + nvl(C.EVA_SCORE_2,0) + (nvl(EVA_SCORE_3,0) * 2)) /" +
" 			(" +
" 				(CASE WHEN nvl(C.EVA_SCORE_1,0) <> 0 THEN 1 ELSE 0 END) + " +
" 				(CASE WHEN nvl(C.EVA_SCORE_2,0) <> 0 THEN 1 ELSE 0 END) + " +
" 				(CASE WHEN nvl(C.EVA_SCORE_3,0) <> 0 THEN 2 ELSE 0 END)" +
" 			)" +
" 	END,2) EVA_SCORE," +
" 	G.LASTGRD2," +
" 	G.SUVDT LASTGRD2_DT," +
" 	H.DECISION," +
" 	H.SUVDT DECISION_DT," +
" 	F.FWATCHD," +
" 	F.FDGBYIL FWATCHD_DT," +
" 	K.WATCH_NOTE," +
" 	K.NOTE," +
" 	K.DECISION DECISION_NOTE" +
" FROM" +
" 	S_SBCR A," +
" 	S_WBS_REQUEST B," +
" 	(" +
" 	SELECT" +
"   	A.PROFESSION_WBS_CODE, A.SBCR_CODE," +
"     	SUM(CASE WHEN A.EVL_YEAR = ('" + arg_year + "' - 2) THEN nvl(A.EVA_SCORE,0) + nvl(A.ADD_SCORE_TOT,0) ELSE 0 END) EVA_SCORE_1," +
"     	SUM(CASE WHEN A.EVL_YEAR = ('" + arg_year + "' - 1) THEN nvl(A.EVA_SCORE,0) + nvl(A.ADD_SCORE_TOT,0) ELSE 0 END) EVA_SCORE_2," +
"     	SUM(CASE WHEN A.EVL_YEAR = '" + arg_year + "' THEN nvl(A.EVA_SCORE,0) + nvl(A.ADD_SCORE_TOT,0) ELSE 0 END) EVA_SCORE_3" +
"     FROM" +
"     	S_EVL_TOTEVL A" +
"     WHERE" +
"     	A.EVL_YEAR IN ('" + arg_year + "' - 2,'" + arg_year + "' - 1,'" + arg_year + "')" +
"     GROUP BY" +
"     	A.PROFESSION_WBS_CODE, A.SBCR_CODE" +
" 	) C," +
" 	S_PROFESSION_WBS D," +
" 	(" +
" 	SELECT A.RESNO, TO_DATE(A.FDGBYIL) FDGBYIL, A.FWATCHD FROM WATCH_GRADE A, (SELECT RESNO, MAX(FDGBYIL) FDGBYIL FROM WATCH_GRADE GROUP BY RESNO) B" +
" 	WHERE A.RESNO = B.RESNO AND A.FDGBYIL = B.FDGBYIL" +
" 	) F," +
" 	(" +
" 	SELECT A.RESNO,to_date(A.SUVDT) SUVDT, A.LASTGRD2 FROM DCC_PACKET01 A,(SELECT RESNO, MAX(SUVDT) SUVDT FROM DCC_PACKET01 GROUP BY RESNO) B" +
" 	WHERE A.RESNO = B.RESNO AND A.SUVDT = B.SUVDT" +
" 	) G," +
" 	(" +
" 	SELECT A.RESNO, to_date(A.SUVDT) SUVDT, A.DECISION FROM DCC_PACKET11 A,(SELECT RESNO, MAX(SUVDT) SUVDT FROM DCC_PACKET11 GROUP BY RESNO) B" +
" 	WHERE A.RESNO = B.RESNO AND A.SUVDT = B.SUVDT" +
" 	) H," +
" 	S_WBS_REQUEST_ETC K" +
" WHERE" +
" 	A.SBCR_CODE = B.SBCR_CODE(+)" +
" AND B.SBCR_CODE = C.SBCR_CODE(+) AND B.PROFESSION_WBS_CODE = C.PROFESSION_WBS_CODE(+)" +
" AND B.PROFESSION_WBS_CODE = D.PROFESSION_WBS_CODE(+)" +
" AND A.BUSINESSMAN_NUMBER = F.RESNO(+)" +
" AND A.BUSINESSMAN_NUMBER = G.RESNO(+)" +
" AND A.BUSINESSMAN_NUMBER = H.RESNO(+)" +
" AND B.SBCR_CODE = K.SBCR_CODE(+) AND B.PROFESSION_WBS_CODE = K.PROFESSION_WBS_CODE(+)" +
" AND B.PROFESSION_WBS_CODE IS NOT NULL";

if (!arg_profession_wbs_code.equals("")) {
	query = query + " AND B.PROFESSION_WBS_CODE = '" + arg_profession_wbs_code + "'";
}
if (!arg_sbcr_name.equals("")) {
	query = query + " AND A.SBCR_NAME LIKE '%" + arg_sbcr_name + "%'";
}
if (!arg_pre_score_s.equals("")) {
	query = query + " AND C.EVA_SCORE_3 " + arg_pre_score_s_con + " " + arg_pre_score_s;
}
if (!arg_pre_score_e.equals("")) {
	query = query + " AND C.EVA_SCORE_3 " + arg_pre_score_e_con + " " + arg_pre_score_e;
}
if (!arg_score_s.equals("")) {
	query = query + " AND " +
		" 	(ROUND(CASE WHEN nvl(C.EVA_SCORE_1,0) = 0 AND nvl(C.EVA_SCORE_2,0) = 0 AND nvl(EVA_SCORE_3,0) = 0 THEN 0" +
		" 		 ELSE" +
		" 			(nvl(C.EVA_SCORE_1,0) + nvl(C.EVA_SCORE_2,0) + (nvl(EVA_SCORE_3,0) * 2)) /" +
		" 			(" +
		" 				(CASE WHEN nvl(C.EVA_SCORE_1,0) <> 0 THEN 1 ELSE 0 END) + " +
		" 				(CASE WHEN nvl(C.EVA_SCORE_2,0) <> 0 THEN 1 ELSE 0 END) + " +
		" 				(CASE WHEN nvl(C.EVA_SCORE_3,0) <> 0 THEN 2 ELSE 0 END)" +
		" 			)" +
		" 	END,2)) " + arg_score_s_con + " " + arg_score_s;
}
if (!arg_score_e.equals("")) {
	query = query + " AND " +
		" 	(ROUND(CASE WHEN nvl(C.EVA_SCORE_1,0) = 0 AND nvl(C.EVA_SCORE_2,0) = 0 AND nvl(EVA_SCORE_3,0) = 0 THEN 0" +
		" 		 ELSE" +
		" 			(nvl(C.EVA_SCORE_1,0) + nvl(C.EVA_SCORE_2,0) + (nvl(EVA_SCORE_3,0) * 2)) /" +
		" 			(" +
		" 				(CASE WHEN nvl(C.EVA_SCORE_1,0) <> 0 THEN 1 ELSE 0 END) + " +
		" 				(CASE WHEN nvl(C.EVA_SCORE_2,0) <> 0 THEN 1 ELSE 0 END) + " +
		" 				(CASE WHEN nvl(C.EVA_SCORE_3,0) <> 0 THEN 2 ELSE 0 END)" +
		" 			)" +
		" 	END,2)) " + arg_score_e_con + " " + arg_score_e;
}
if (!arg_FWATCHD.equals("전체")) {
	query = query + " AND rtrim(F.FWATCHD) = '" + arg_FWATCHD + "'";
}
if (!arg_LASTGRD2_s.equals("전체")) {
	query = query + " AND F_CREDIT_GRADE_NUM(G.LASTGRD2) " + arg_LASTGRD2_s_con + " F_CREDIT_GRADE_NUM('" + arg_LASTGRD2_s + "')";
}
if (!arg_LASTGRD2_e.equals("전체")) {
	query = query + " AND F_CREDIT_GRADE_NUM(G.LASTGRD2) " + arg_LASTGRD2_e_con + " F_CREDIT_GRADE_NUM('" + arg_LASTGRD2_e + "')";
}
if (!arg_DECISION_s.equals("전체")) {
	query = query + " AND rtrim(H.DECISION) " + arg_DECISION_s_con + " '" + arg_DECISION_s + "'";
}
if (!arg_DECISION_e.equals("전체")) {
	query = query + " AND rtrim(H.DECISION) " + arg_DECISION_e_con + " '" + arg_DECISION_e + "'";
}
if (!arg_DECISION_NOTE.equals("전체")) {
	query = query + " AND K.DECISION = '" + arg_DECISION_NOTE + "'";
}

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>