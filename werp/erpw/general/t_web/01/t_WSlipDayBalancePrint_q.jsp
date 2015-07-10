<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strMAKE_DEPT_CODE = CITCommon.toKOR(request.getParameter("MAKE_DEPT_CODE"));
			String strMAKE_DT = CITCommon.toKOR(request.getParameter("DT_F"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("CASH_ACC_CODE"));
			String strADJUST = CITCommon.toKOR(request.getParameter("ADJUST"));
			
			strSql  = " SELECT                                                                        \n";
			strSql += "       a.MAKE_COMP_CODE,                                                           \n";
			strSql += "       a.COMPANY_NAME,                                                           \n";
			strSql += "       a.MAKE_DT,                                                                \n";
			strSql += "       a.ACC_CODE,                                                               \n";
			strSql += "       a.ACC_NAME,                                                               \n";
			strSql += "       a.ACC_LVL, \n";
			strSql += " 	  a.PRINT_SHEET_TAG, \n";
			strSql += "       a.PREV_ACC_LVL,                                                           \n";
			strSql += "       a.REP_DB_AMT,                                                             \n";
			strSql += "       a.CUR_DB_AMT,                                                             \n";
			strSql += "       a.SUM_DB_AMT,                                                             \n";
			strSql += "       a.REP_CR_AMT,                                                             \n";
			strSql += "       a.CUR_CR_AMT,                                                             \n";
			strSql += "       a.SUM_CR_AMT,                                                             \n";
			strSql += "       a.LINE_FLAG   \n";
			strSql += "   FROM                                                                          \n";
			strSql += "   (                                                                             \n";
			strSql += "   SELECT                                                            \n";
			strSql += "   	a.MAKE_COMP_CODE,                                               \n";
			strSql += "   	b.COMPANY_NAME,                                               \n";
			strSql += "   	a.MAKE_DT,                                                    \n";
			strSql += "   	a.ACC_CODE,                                                   \n";
			strSql += "   	a.ACC_NAME,                                                   \n";
			strSql += "   	a.ACC_LVL, \n";
			strSql += " 	a.PRINT_SHEET_TAG, \n";
			strSql += "   	a.PREV_ACC_LVL,                                               \n";
			strSql += "   	a.REP_DB_AMT,                                          \n";
			strSql += "   	a.CUR_DB_AMT,                                          \n";
			strSql += "   	a.SUM_DB_AMT,                                          \n";
			strSql += "   	a.REP_CR_AMT,                                          \n";
			strSql += "   	a.CUR_CR_AMT,                                          \n";
			strSql += "   	a.SUM_CR_AMT,                                          \n";
			strSql += "       (                                                             \n";
			strSql += "       CASE                                                          \n";
			strSql += "           WHEN (a.ACC_LVL<>'5') OR (a.PREV_ACC_LVL<>'5') THEN 'type1'    \n";
			strSql += "           ELSE 'type2'                                                  \n";
			strSql += "       END                                                           \n";
			strSql += "       ) LINE_FLAG                                                   \n";
			strSql += "   FROM                                                              \n";
			strSql += "       (                                                             \n";
			strSql += "       SELECT                                                        \n";
			strSql += "   		b.MAKE_COMP_CODE,                                           \n";
			strSql += "   		b.MAKE_DT,                                                \n";
			strSql += "   		a.ACC_CODE,                                               \n";
			strSql += "   		LPAD(' ',(a.ACC_LVL-1))||a.ACC_NAME ACC_NAME,             \n";
			strSql += "   		a.ACC_LVL, \n";
			strSql += " 		a.PRINT_SHEET_TAG, \n";
			strSql += "   		SUM(b.REP_DB_AMT) REP_DB_AMT,                         \n";
			strSql += "   		SUM(b.CUR_DB_AMT) CUR_DB_AMT,                         \n";
			strSql += "   		SUM(b.SUM_DB_AMT) SUM_DB_AMT,                         \n";
			strSql += "   		SUM(b.REP_CR_AMT) REP_CR_AMT,                         \n";
			strSql += "   		SUM(b.CUR_CR_AMT) CUR_CR_AMT,                         \n";
			strSql += "   		SUM(b.SUM_CR_AMT) SUM_CR_AMT,                         \n";
			strSql += "   		lag(a.ACC_LVL)                                            \n";
			strSql += "   		over(                                                     \n";
			strSql += "   		    ORDER BY a.ACC_CODE                                   \n";
			strSql += "   		) PREV_ACC_LVL                                            \n";
			strSql += "       FROM                                                          \n";
			strSql += "           (                                                  \n";
			strSql += "           SELECT                                                    \n";
			strSql += "               a.ACC_CODE,                                           \n";
			strSql += "               a.ACC_NAME,                                           \n";
			strSql += "               a.ACC_LVL, \n";
			strSql += " 			  a.PRINT_SHEET_TAG                                        \n";
			strSql += "           FROM                                                      \n";
			strSql += "               T_ACC_CODE a,                                       \n";
			strSql += "               (                                                     \n";
			strSql += "   				SELECT   \n";
			strSql += "   				    B.PARENT_ACC_CODE ACC_CODE   \n";
			strSql += "   				FROM                                                                           \n";
			strSql += "   				    T_ACC_SLIP_BODY1 A,   \n";
			strSql += "   					T_ACC_CODE_CHILD B   \n";
			strSql += "   				WHERE                                                 \n";
			strSql += "   				    MAKE_COMP_CODE =   ?                 \n";
			strSql += "   				    AND MAKE_DEPT_CODE LIKE  ?   ||'%'               \n";
			strSql += "   				    AND MAKE_DT = TO_DATE(   ?   ,'YYYYMMDD')   \n";
			strSql += "   					AND A.ACC_CODE = B.CHILD_ACC_CODE   \n";
			strSql += "   					AND KEEP_DT IS NOT NULL   \n";
			strSql += "  					AND TRANSFER_TAG = 'F'  \n";
			strSql += "   					AND SLIP_KIND_TAG <> 'D'  \n";
			if("F".equals(strADJUST)) {
				strSql += "   					AND SLIP_KIND_TAG <> 'Z'  \n";
			}
			strSql += "   				GROUP BY                                              \n";
			strSql += "   				    B.PARENT_ACC_CODE   \n";
			strSql += "   				UNION ALL   \n";
			strSql += "   				SELECT   \n";
			strSql += "   				    A.ACC_CODE   \n";
			strSql += "   				FROM                                                                           \n";
			strSql += "   				    T_ACC_SLIP_BODY1 A   \n";
			strSql += "   				WHERE                                                 \n";
			strSql += "   				    MAKE_COMP_CODE =    ?                  \n";
			strSql += "   				    AND MAKE_DEPT_CODE LIKE    ?   ||'%'              \n";
			strSql += "   				    AND MAKE_DT = TO_DATE(   ?   ,'YYYYMMDD')   \n";
			strSql += "   					AND KEEP_DT IS NOT NULL   \n";
			strSql += "  					AND TRANSFER_TAG = 'F'  \n";
			strSql += "   					AND SLIP_KIND_TAG <> 'D'  \n";
			if("F".equals(strADJUST)) {
				strSql += "   					AND SLIP_KIND_TAG <> 'Z'  \n";
			}
			strSql += "   				GROUP BY                                              \n";
			strSql += "   				    A.ACC_CODE   \n";
			strSql += "               ) b                                                   \n";
			strSql += "           WHERE                                                     \n";
			strSql += "               a.ACC_CODE = b.ACC_CODE   \n";
			strSql += "           ) a,                                                      \n";
			strSql += "           (                                                         \n";
			strSql += "           SELECT                                                                                                         \n";
			strSql += "               b.SLIP_ID,                                                                                                 \n";
			strSql += "               b.SLIP_IDSEQ,                                                                                              \n";
			strSql += "               b.MAKE_COMP_CODE,                                                                                            \n";
			strSql += "               b.MAKE_DT,                                                                                                 \n";
			strSql += "               b.ACC_CODE,                                                                                                \n";
			strSql += "               d.ACC_NAME,                                                                                                \n";
			strSql += "               DECODE(b.DB_AMT,0,0,1)*(b.DB_AMT-NVL(c.RESET_AMT,0)) REP_DB_AMT,                                                  \n";
			strSql += "               DECODE(b.DB_AMT,0,0,1)*NVL(c.RESET_AMT,0) CUR_DB_AMT,                                                           \n";
			strSql += "               b.DB_AMT SUM_DB_AMT,                                                                                       \n";
			strSql += "               DECODE(b.CR_AMT,0,0,1)*(b.CR_AMT-NVL(c.RESET_AMT,0)) REP_CR_AMT,                                                  \n";
			strSql += "               DECODE(b.CR_AMT,0,0,1)*NVL(c.RESET_AMT,0) CUR_CR_AMT,                                                           \n";
			strSql += "               b.CR_AMT SUM_CR_AMT                                                                                        \n";
			strSql += "           FROM                                                                                                                                                                                             \n";
			strSql += "               T_ACC_SLIP_BODY1 b,                                                                                       \n";
			strSql += "               (                                                                                                          \n";
			strSql += "                   SELECT                                                                                                 \n";
			strSql += "                       b.SLIP_ID, b.SLIP_IDSEQ, NVL(SUM(c.RESET_AMT), 0) RESET_AMT   \n";
			strSql += "                   FROM                                                                                                                                                                              \n";
			strSql += "                       T_ACC_SLIP_BODY1 b,                                                                               \n";
			strSql += "                       T_ACC_SLIP_REMAIN_KEEP c,                                                                        \n";
			strSql += "                       T_ACC_SLIP_BODY1 r                    \n";
			strSql += "                   WHERE                                                                                                  \n";
			strSql += "   					b.MAKE_COMP_CODE =    ?                  \n";
			strSql += "   					AND b.MAKE_DEPT_CODE LIKE    ?   ||'%'               \n";
			strSql += "   				    AND b.MAKE_DT = TO_DATE(   ?   ,'YYYYMMDD')                                                                        \n";
			strSql += "   					AND B.SLIP_ID = C.SLIP_ID                                                                          \n";
			strSql += "   					AND B.SLIP_IDSEQ = C.SLIP_IDSEQ                                                                    \n";
			strSql += "   					AND C.SLIP_ID = R.SLIP_ID(+)                                                                          \n";
			strSql += "   					AND C.RESET_SLIP_IDSEQ = R.SLIP_IDSEQ(+)                                                              \n";
			strSql += "   					AND R.ACC_CODE =   ?          \n";
			strSql += "   					AND b.KEEP_DT IS NOT NULL      \n";
			strSql += "  					AND b.TRANSFER_TAG = 'F'                                                     \n";
			strSql += "                   GROUP BY b.SLIP_ID, b.SLIP_IDSEQ                                                                       \n";
			strSql += "               ) c,                                                                                                       \n";
			strSql += "               T_ACC_CODE d                         \n";
			strSql += "           WHERE                                                                                                          \n";
			strSql += "   			b.MAKE_COMP_CODE =    ?                 \n";
			strSql += "   			AND b.MAKE_DEPT_CODE LIKE    ?   ||'%'               \n";
			strSql += "   			AND b.MAKE_DT = TO_DATE(   ?   ,'YYYYMMDD')                                                                                 \n";
			strSql += "               AND c.SLIP_ID(+) = b.SLIP_ID                                                                                  \n";
			strSql += "               AND c.SLIP_IDSEQ(+) = b.SLIP_IDSEQ                                                                            \n";
			strSql += "               AND d.ACC_CODE = b.ACC_CODE                                                                                \n";
			strSql += "               AND b.ACC_CODE <>    ?      \n";
			strSql += "   			AND b.KEEP_DT IS NOT NULL      \n";
			strSql += "  			AND b.TRANSFER_TAG = 'F'           \n";
			strSql += "   			AND b.SLIP_KIND_TAG <> 'D'  \n";
			if("F".equals(strADJUST)) {
				strSql += "   			AND b.SLIP_KIND_TAG <> 'Z'  \n";
			}
			strSql += "           ORDER BY                                                                                                       \n";
			strSql += "               b.SLIP_ID,                                                                                                 \n";
			strSql += "               b.SLIP_IDSEQ                                                                                               \n";
			strSql += "           ) b                                                       \n";
			strSql += "       WHERE                                                         \n";
			strSql += "           --(b.CUR_DB_AMT<>0 or b.CUR_CR_AMT<>0)   \n";
			strSql += "   		a.ACC_CODE IN (   \n";
			strSql += "   			SELECT   \n";
			strSql += "   			    PARENT_ACC_CODE   \n";
			strSql += "   			FROM                                                                           \n";
			strSql += "   				T_ACC_CODE_CHILD   \n";
			strSql += "   			WHERE                                                 \n";
			strSql += "   				CHILD_ACC_CODE = b.ACC_CODE   \n";
			strSql += "   		)   \n";
			strSql += "   		OR a.ACC_CODE = b.ACC_CODE   \n";
			strSql += "       GROUP BY                                                      \n";
			strSql += "           b.MAKE_COMP_CODE,                                           \n";
			strSql += "           b.MAKE_DT,                                                \n";
			strSql += "           a.ACC_CODE,                                               \n";
			strSql += "           a.ACC_NAME,                                               \n";
			strSql += "           a.ACC_LVL, \n";
			strSql += " 		  a.PRINT_SHEET_TAG \n";
			strSql += "       ORDER BY                                                      \n";
			strSql += "           a.ACC_CODE                                                \n";
			strSql += "       ) a,                                                          \n";
			strSql += "       T_COMPANY b                                                 \n";
			strSql += "   WHERE                                                             \n";
			strSql += "       --(a.CUR_DB_AMT<>0 or a.CUR_CR_AMT<>0)                          \n";
			strSql += "       b.COMP_CODE = a.MAKE_COMP_CODE \n";
			strSql += " 	  AND a.PRINT_SHEET_TAG = 'T' \n";
			strSql += "   UNION ALL                                                         \n";
			strSql += "       SELECT                                                        \n";
			strSql += "           MAX(a.MAKE_COMP_CODE),                                      \n";
			strSql += "           '' COMPANY_NAME,                                          \n";
			strSql += "           MAX(a.MAKE_DT),                                           \n";
			strSql += "           '' ACC_CODE,                                              \n";
			strSql += "           '          소    계' ACC_NAME,                                              \n";
			strSql += "           '' ACC_LVL, \n";
			strSql += " 		  '' PRINT_SHEET_TAG,                                       \n";
			strSql += "           '' PREV_ACC_LVL,                                          \n";
			strSql += "            SUM(a.REP_DB_AMT) REP_DB_AMT,                            \n";
			strSql += "            SUM(a.CUR_DB_AMT) CUR_DB_AMT,                            \n";
			strSql += "            SUM(a.SUM_DB_AMT) SUM_DB_AMT,                            \n";
			strSql += "            SUM(a.REP_CR_AMT) REP_CR_AMT,                            \n";
			strSql += "            SUM(a.CUR_CR_AMT) CUR_CR_AMT,                            \n";
			strSql += "            SUM(a.SUM_CR_AMT) SUM_CR_AMT,                            \n";
			strSql += "           'type3' PREV_ACC_LVL                                      \n";
			strSql += "       FROM                                                          \n";
			strSql += "           (                                                         \n";
			strSql += "           SELECT                                                                                                         \n";
			strSql += "               b.SLIP_ID,                                                                                                 \n";
			strSql += "               b.SLIP_IDSEQ,                                                                                              \n";
			strSql += "               b.MAKE_COMP_CODE,                                                                                            \n";
			strSql += "               b.MAKE_DT,                                                                                                 \n";
			strSql += "               b.ACC_CODE,                                                                                                \n";
			strSql += "               d.ACC_NAME,                                                                                                \n";
			strSql += "               DECODE(b.DB_AMT,0,0,1)*(b.DB_AMT-NVL(c.RESET_AMT,0)) REP_DB_AMT,                                                  \n";
			strSql += "               DECODE(b.DB_AMT,0,0,1)*NVL(c.RESET_AMT,0) CUR_DB_AMT,                                                           \n";
			strSql += "               b.DB_AMT SUM_DB_AMT,                                                                                       \n";
			strSql += "               DECODE(b.CR_AMT,0,0,1)*(b.CR_AMT-NVL(c.RESET_AMT,0)) REP_CR_AMT,                                                  \n";
			strSql += "               DECODE(b.CR_AMT,0,0,1)*NVL(c.RESET_AMT,0) CUR_CR_AMT, \n";
			strSql += "               b.CR_AMT SUM_CR_AMT \n";
			strSql += "           FROM                                                                                                                                                                                              \n";
			strSql += "               T_ACC_SLIP_BODY1 b,                                                                                       \n";
			strSql += "               (                                                                                                          \n";
			strSql += "                   SELECT                                                                                                 \n";
			strSql += "                       a.SLIP_ID, b.SLIP_IDSEQ, NVL(SUM(c.RESET_AMT), 0) RESET_AMT   \n";
			strSql += "                   FROM                                                                                                   \n";
			strSql += "                       T_ACC_SLIP_HEAD a,                                                                               \n";
			strSql += "                       T_ACC_SLIP_BODY1 b,                                                                               \n";
			strSql += "                       T_ACC_SLIP_REMAIN_KEEP c,                                                                        \n";
			strSql += "                       T_ACC_SLIP_BODY1 r                                   \n";
			strSql += "                   WHERE                                                                                                  \n";
			strSql += "   	                a.MAKE_COMP_CODE =    ?                  \n";
			strSql += "   	                AND a.MAKE_DEPT_CODE LIKE    ?   ||'%'              \n";
			strSql += "   				    AND a.MAKE_DT = TO_DATE(   ?   ,'YYYYMMDD')    \n";
			strSql += "                       AND a.SLIP_ID = b.SLIP_ID                                                                          \n";
			strSql += "                       AND b.SLIP_ID = c.SLIP_ID                                                                          \n";
			strSql += "                       AND b.SLIP_IDSEQ = c.SLIP_IDSEQ                                                                    \n";
			strSql += "                       AND c.SLIP_ID = r.SLIP_ID(+)                                                                          \n";
			strSql += "                       AND c.RESET_SLIP_IDSEQ = r.SLIP_IDSEQ(+)                                                              \n";
			strSql += "                       AND r.ACC_CODE =    ?                                                                 \n";
			strSql += "                   GROUP BY a.SLIP_ID, b.SLIP_IDSEQ                                                                       \n";
			strSql += "               ) c,                                                                                                       \n";
			strSql += "               T_ACC_CODE d \n";
			strSql += "           WHERE                                                                                                          \n";
			strSql += "   			b.MAKE_COMP_CODE =    ?                  \n";
			strSql += "   			AND b.MAKE_DEPT_CODE LIKE    ?   ||'%'               \n";
			strSql += "   			AND b.MAKE_DT = TO_DATE(   ?   ,'YYYYMMDD')                                                                                 \n";
			strSql += "   			AND c.SLIP_ID(+) = b.SLIP_ID                                                                                  \n";
			strSql += "   			AND c.SLIP_IDSEQ(+) = b.SLIP_IDSEQ                                                                            \n";
			strSql += "   			AND d.ACC_CODE = b.ACC_CODE                                                                                \n";
			strSql += "   			AND b.ACC_CODE <>    ?      \n";
			strSql += "   			AND b.KEEP_DT IS NOT NULL  \n";
			strSql += "  			AND b.TRANSFER_TAG = 'F'    \n";
			strSql += "   			AND b.SLIP_KIND_TAG <> 'D'  \n";
			if("F".equals(strADJUST)) {
				strSql += "   			AND b.SLIP_KIND_TAG <> 'Z'  \n";
			}
			strSql += "           ORDER BY                                                                                                       \n";
			strSql += "               b.SLIP_ID,                                                                                                 \n";
			strSql += "               b.SLIP_IDSEQ                                                                                               \n";
			strSql += "           ) a                           \n";
			strSql += "       --WHERE                           \n";
			strSql += "           --a.CUR_DB_AMT<>0 or a.CUR_CR_AMT<>0     \n";
			strSql += "   UNION ALL   \n";
			strSql += "       SELECT   \n";
			strSql += "           '' MAKE_COMP_CODE,                                      \n";
			strSql += "           '' COMPANY_NAME,                                          \n";
			strSql += "           NULL MAKE_DT,                                           \n";
			strSql += "           '' ACC_CODE,                                              \n";
			strSql += "           '     당일잔액 | 전일잔액' ACC_NAME,                                              \n";
			strSql += "           '' ACC_LVL, \n";
			strSql += " 		  '' PRINT_SHEET_TAG, \n";
			strSql += "           '' PREV_ACC_LVL,                                          \n";
			strSql += "            0 REP_DB_AMT,                            \n";
			strSql += "           CUR_JAN_AMT, -- CUR_DB_AMT  \n";
			strSql += "   	    CUR_JAN_AMT, -- SUM_DB_AMT   \n";
			strSql += "            0 REP_CR_AMT,                            \n";
			strSql += "            PRE_CUR_JAN_AMT,-- CUR_CR_AMT                            \n";
			strSql += "   		PRE_CUR_JAN_AMT, -- SUM_CR_AMT                        \n";
			strSql += "           'type4' PREV_ACC_LVL                                                                                              \n";
			strSql += "       FROM (   \n";
			strSql += "       SELECT   \n";
			strSql += "   	    (                                                                         \n";
			strSql += "   		    SELECT                                                                    \n";
			strSql += "   		        NVL(SUM(DB_AMT-CR_AMT),0)                                         \n";
			strSql += "   		    FROM                                                                                                                    \n";
			strSql += "   		        T_ACC_SLIP_BODY1                                              \n";
			strSql += "   		    WHERE                                                                     \n";
			strSql += "   		        ACC_CODE =    ?                                          \n";
			strSql += "   		        AND MAKE_COMP_CODE =    ?                                               \n";
			strSql += "   		        AND MAKE_DEPT_CODE LIKE    ?   ||'%'              \n";
			strSql += "   				AND MAKE_DT >= TO_DATE(SUBSTR(   ?   ,1,4)||'0101','YYYYMMDD')   \n";
			strSql += "   		        AND ( MAKE_DT <= TO_DATE(   ?   ,'YYYYMMDD') OR TRANSFER_TAG = 'T' )   \n";
			strSql += "   				AND KEEP_DT IS NOT NULL                 \n";
			strSql += "   				AND SLIP_KIND_TAG <> 'D'  \n";
			if("F".equals(strADJUST)) {
				strSql += "   				AND SLIP_KIND_TAG <> 'Z'  \n";
			}
			strSql += "   	    ) CUR_JAN_AMT,   \n";
			strSql += "   		(                                                                         \n";
			strSql += "   		    SELECT                                                                    \n";
			strSql += "   		        NVL(SUM(DB_AMT-CR_AMT),0)                                         \n";
			strSql += "   		    FROM                                                                      \n";
			strSql += "   		        T_ACC_SLIP_BODY1                                                                  \n";
			strSql += "   		    WHERE                                                                     \n";
			strSql += "   		        ACC_CODE =    ?                                         \n";
			strSql += "   		        AND MAKE_COMP_CODE =    ?                                               \n";
			strSql += "   		        AND MAKE_DEPT_CODE LIKE    ?   ||'%'              \n";
			strSql += "   				AND MAKE_DT >= TO_DATE(SUBSTR(   ?   ,1,4)||'0101','YYYYMMDD')   \n";
			strSql += "   		        AND ( MAKE_DT < TO_DATE(   ?   ,'YYYYMMDD') OR TRANSFER_TAG = 'T' )   \n";
			strSql += "   				AND KEEP_DT IS NOT NULL  \n";
			strSql += "   				AND SLIP_KIND_TAG <> 'D'  \n";
			if("F".equals(strADJUST)) {
				strSql += "   				AND SLIP_KIND_TAG <> 'Z'  \n";
			}
			strSql += "   	    ) PRE_CUR_JAN_AMT                        \n";
			strSql += "       FROM DUAL                             \n";
			strSql += "       )   \n";
			strSql += "   ) a   ";
			
			lrArgData.addColumn("1MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("4MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("7MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("10ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("12MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("13MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("14ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("15MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("16MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("17MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("18ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("19MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("20MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("21MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("22ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("23ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("24MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("25MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("26MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("27MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("28ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("29MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("30MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("31MAKE_DT", CITData.VARCHAR2);
			lrArgData.addColumn("32MAKE_DT", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("2MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("3MAKE_DT", strMAKE_DT);
			lrArgData.setValue("4MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("5MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("6MAKE_DT", strMAKE_DT);
			lrArgData.setValue("7MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("8MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("9MAKE_DT", strMAKE_DT);
			lrArgData.setValue("10ACC_CODE", strACC_CODE);
			lrArgData.setValue("11MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("12MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("13MAKE_DT", strMAKE_DT);
			lrArgData.setValue("14ACC_CODE", strACC_CODE);
			lrArgData.setValue("15MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("16MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("17MAKE_DT", strMAKE_DT);
			lrArgData.setValue("18ACC_CODE", strACC_CODE);
			lrArgData.setValue("19MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("20MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("21MAKE_DT", strMAKE_DT);
			lrArgData.setValue("22ACC_CODE", strACC_CODE);
			lrArgData.setValue("23ACC_CODE", strACC_CODE);
			lrArgData.setValue("24MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("25MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("26MAKE_DT", strMAKE_DT);
			lrArgData.setValue("27MAKE_DT", strMAKE_DT);
			lrArgData.setValue("28ACC_CODE", strACC_CODE);
			lrArgData.setValue("29MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("30MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("31MAKE_DT", strMAKE_DT);
			lrArgData.setValue("32MAKE_DT", strMAKE_DT);

			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}

	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>