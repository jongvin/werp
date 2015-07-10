<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-05-03)
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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " SELECT  \n";
			strSql += "  	a.COMP_CODE,  \n";
			strSql += "  	a.CLSE_ACC_ID,  \n";
			strSql += "  	a.BIZ_PLAN_ITEM_NO FLOW_CODE ,  \n";
			strSql += "  	a.P_NO ,  \n";
			strSql += " 	CASE \n";
			strSql += " 		WHEN a.MNG_CODE IN ('매출액','매출이익') AND NVL(b.SUB_SEQ, 0) = '0'  THEN a.LEVELED_FLOW_ITEM_NAME \n";
			strSql += " 		WHEN a.MNG_CODE IN ('매출액','매출이익') AND NVL(b.SUB_SEQ, 0) = '2'  THEN '     (그룹거래)' \n";
			strSql += " 		WHEN a.MNG_CODE IN ('매출액','매출이익') AND NVL(b.SUB_SEQ, 0) = '3'  THEN '     (외부거래)' \n";
			strSql += " 		WHEN NVL(b.SUB_SEQ, 0) = '1'  THEN '           (%)' \n";
			strSql += " 		ELSE a.LEVELED_FLOW_ITEM_NAME \n";
			strSql += " 	END BIZ_PLAN_ITEM_NAME,  \n";
			strSql += "  	a.IS_LEAF_TAG,  \n";
			strSql += "  	a.RN,  \n";
			strSql += " 	b.SUB_SEQ, \n";
			strSql += " 	''||ROUND(NVL(b.PRE_EXEC_AMT, 0)) B_Y_EXEC_AMT,  \n";
			strSql += " 	''||ROUND(NVL(b.CUR_PLAN_AMT, 0)) C_Y_PLAN_AMT,  \n";
			strSql += " 	''||ROUND((NVL(b.CUR_PLAN_AMT, 0)-NVL(b.PRE_EXEC_AMT, 0))) BC_Y_DIF_PLAN_AMT,  \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT01, 0)) PLAN_AMT01, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT02, 0)) PLAN_AMT02, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT03, 0)) PLAN_AMT03, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT04, 0)) PLAN_AMT04, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT05, 0)) PLAN_AMT05, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT06, 0)) PLAN_AMT06, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT121, 0)) PLAN_AMT121, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT07, 0)) PLAN_AMT07, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT08, 0)) PLAN_AMT08, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT09, 0)) PLAN_AMT09, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT10, 0)) PLAN_AMT10, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT11, 0)) PLAN_AMT11, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT12, 0)) PLAN_AMT12, \n";
			strSql += " 	''||ROUND(NVL(b.PLAN_AMT122, 0)) PLAN_AMT122 \n";
			strSql += "  FROM  \n";
			strSql += "  	(  \n";
			strSql += "  		SELECT  \n";
			strSql += "  			  ?    COMP_CODE,  \n";
			strSql += "  			  ?    CLSE_ACC_ID,  \n";
			strSql += "  			0 CHG_SEQ,  \n";
			strSql += "  			a.CRTUSERNO ,  \n";
			strSql += "  			a.CRTDATE ,  \n";
			strSql += "  			a.MODUSERNO ,  \n";
			strSql += "  			a.MODDATE ,  \n";
			strSql += "  			a.BIZ_PLAN_ITEM_NO ,  \n";
			strSql += "  			a.P_NO ,  \n";
			strSql += "  			RPAD(' ',(LEVEL - 1) * 5,' ') || a.BIZ_PLAN_ITEM_NAME LEVELED_FLOW_ITEM_NAME,  \n";
			strSql += "  			a.IS_LEAF_TAG,  \n";
			strSql += " 			a.MNG_CODE, \n";
			strSql += "  			ROWNUM RN  \n";
			strSql += "  		FROM \n";
			strSql += " 			T_PL_ITEM a  \n";
			strSql += " 		WHERE \n";
			strSql += " 			LEVEL<=2  \n";
			strSql += " 			AND NVL(a.MNG_CODE, ' ') NOT IN('매출원가') \n";
			strSql += "  		START WITH a.P_NO = 0  \n";
			strSql += "  		CONNECT BY  \n";
			strSql += "  			PRIOR	a.BIZ_PLAN_ITEM_NO = a.P_NO  \n";
			strSql += "  		ORDER Siblings BY  \n";
			strSql += "  			a.ITEM_LEVEL_SEQ  \n";
			strSql += "  	) a,  \n";
			strSql += "  	(  \n";
			strSql += "  		SELECT  \n";
			strSql += "  			b.COMP_CODE ,  \n";
			strSql += "  			 ?  CLSE_ACC_ID,--b.CLSE_ACC_ID ,  \n";
			strSql += " 			--b.CHG_SEQ,  \n";
			strSql += "  			--b.WORK_YM ,  \n";
			strSql += "  			b.BIZ_PLAN_ITEM_NO ,  \n";
			strSql += " 			--b.DEPT_CODE,  \n";
			strSql += " 			NVL(DECODE(d.CONST_TAG,'3','2','3'),'0') SUB_SEQ, \n";
			strSql += "  			SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 1)  THEN b.EXEC_AMT ELSE 0 END )/1000000 PRE_EXEC_AMT, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 0)  THEN b.PLAN_AMT ELSE 0 END )/1000000 CUR_PLAN_AMT, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '01' THEN b.PLAN_AMT END )/1000000 PLAN_AMT01, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '02' THEN b.PLAN_AMT END )/1000000 PLAN_AMT02, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '03' THEN b.PLAN_AMT END )/1000000 PLAN_AMT03, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '04' THEN b.PLAN_AMT END )/1000000 PLAN_AMT04, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '05' THEN b.PLAN_AMT END )/1000000 PLAN_AMT05, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT06, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '01' AND '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT121, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '07' THEN b.PLAN_AMT END )/1000000 PLAN_AMT07, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '08' THEN b.PLAN_AMT END )/1000000 PLAN_AMT08, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '09' THEN b.PLAN_AMT END )/1000000 PLAN_AMT09, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '10' THEN b.PLAN_AMT END )/1000000 PLAN_AMT10, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '11' THEN b.PLAN_AMT END )/1000000 PLAN_AMT11, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT12, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '07' AND '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT122 \n";
			strSql += "  		FROM \n";
			strSql += " 			T_PL_COMP_DEPT_PLAN_EXEC b, \n";
			strSql += " 			T_PL_ITEM C, \n";
			strSql += " 			Z_CODE_DEPT D \n";
			strSql += "  		WHERE \n";
			strSql += " 			b.BIZ_PLAN_ITEM_NO = C.BIZ_PLAN_ITEM_NO \n";
			strSql += " 			AND	b.DEPT_CODE = d.DEPT_CODE \n";
			strSql += " 			AND	b.COMP_CODE =   ?    \n";
			strSql += " 	 		AND	b.CLSE_ACC_ID IN (  ?   - 1,   ?  ) \n";
			strSql += " 	 		AND	NVL(c.MNG_CODE, ' ') IN ('매출액','매출이익') \n";
			strSql += " 	 		AND	b.CHG_SEQ = 0 \n";
			strSql += "  	  	GROUP BY GROUPING SETS \n";
			strSql += " 		( \n";
			strSql += " 	 	  	(  \n";
			strSql += " 		 		b.COMP_CODE ,  \n";
			strSql += " 	 			--b.CLSE_ACC_ID ,  \n";
			strSql += " 	 			b.CHG_SEQ,  \n";
			strSql += " 	 			--b.WORK_YM ,  \n";
			strSql += " 	 			b.BIZ_PLAN_ITEM_NO,  \n";
			strSql += " 				--b.DEPT_CODE, \n";
			strSql += " 				DECODE(d.CONST_TAG,'3','2','3') \n";
			strSql += " 			), \n";
			strSql += " 	 	  	(  \n";
			strSql += " 		 		b.COMP_CODE , \n";
			strSql += " 	 			b.BIZ_PLAN_ITEM_NO \n";
			strSql += " 			) \n";
			strSql += " 		) \n";
			strSql += " 		UNION ALL \n";
			strSql += "  		SELECT  \n";
			strSql += "  			b.COMP_CODE ,  \n";
			strSql += "  			 ?  CLSE_ACC_ID,--b.CLSE_ACC_ID ,  \n";
			strSql += " 			--b.CHG_SEQ,  \n";
			strSql += "  			--b.WORK_YM ,  \n";
			strSql += "  			b.BIZ_PLAN_ITEM_NO ,  \n";
			strSql += " 			--b.DEPT_CODE,  \n";
			strSql += " 			'0' SUB_SEQ, \n";
			strSql += "  			SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 1)  THEN b.EXEC_AMT ELSE 0 END )/1000000 PRE_EXEC_AMT, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 0)  THEN b.PLAN_AMT ELSE 0 END )/1000000 CUR_PLAN_AMT, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '01' THEN b.PLAN_AMT END )/1000000 PLAN_AMT01, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '02' THEN b.PLAN_AMT END )/1000000 PLAN_AMT02, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '03' THEN b.PLAN_AMT END )/1000000 PLAN_AMT03, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '04' THEN b.PLAN_AMT END )/1000000 PLAN_AMT04, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '05' THEN b.PLAN_AMT END )/1000000 PLAN_AMT05, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT06, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '01' AND '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT121, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '07' THEN b.PLAN_AMT END )/1000000 PLAN_AMT07, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '08' THEN b.PLAN_AMT END )/1000000 PLAN_AMT08, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '09' THEN b.PLAN_AMT END )/1000000 PLAN_AMT09, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '10' THEN b.PLAN_AMT END )/1000000 PLAN_AMT10, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '11' THEN b.PLAN_AMT END )/1000000 PLAN_AMT11, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT12, \n";
			strSql += " 			SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '07' AND '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT122 \n";
			strSql += "  		FROM \n";
			strSql += " 			T_PL_COMP_PLAN_EXEC b, \n";
			strSql += " 			T_PL_ITEM C \n";
			strSql += "  		WHERE \n";
			strSql += " 			b.BIZ_PLAN_ITEM_NO = C.BIZ_PLAN_ITEM_NO \n";
			strSql += " 			AND	b.COMP_CODE =   ?    \n";
			strSql += " 	 		AND	b.CLSE_ACC_ID IN (  ?   - 1,   ?  ) \n";
			strSql += " 	 		AND	NVL(c.MNG_CODE, ' ') NOT IN('매출액','매출이익') \n";
			strSql += " 	 		AND	b.CHG_SEQ = 0 \n";
			strSql += "  	  	GROUP BY GROUPING SETS \n";
			strSql += " 		( \n";
			strSql += " 	 	  	(  \n";
			strSql += " 		 		b.COMP_CODE , \n";
			strSql += " 	 			b.BIZ_PLAN_ITEM_NO \n";
			strSql += " 			) \n";
			strSql += " 		) \n";
			strSql += " 		UNION ALL \n";
			strSql += " 		SELECT  \n";
			strSql += " 				c.COMP_CODE ,  \n";
			strSql += " 				 ?  CLSE_ACC_ID,--b.CLSE_ACC_ID ,  \n";
			strSql += " 				--b.CHG_SEQ,  \n";
			strSql += " 				--b.WORK_YM ,  \n";
			strSql += " 				c.BIZ_PLAN_ITEM_NO ,  \n";
			strSql += " 				--b.DEPT_CODE,  \n";
			strSql += " 				c.SUB_SEQ, \n";
			strSql += " 				DECODE( NVL(b.PRE_EXEC_AMT, 0),	0, 0, NVL(c.PRE_EXEC_AMT, 0)/NVL(b.PRE_EXEC_AMT, 0) ) PRE_EXEC_AMT, \n";
			strSql += " 				DECODE( NVL(b.CUR_PLAN_AMT, 0),	0, 0, NVL(c.CUR_PLAN_AMT, 0)/NVL(b.CUR_PLAN_AMT, 0) ) CUR_PLAN_AMT, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT01, 0),	0, 0, NVL(c.PLAN_AMT01, 0) /NVL(b.PLAN_AMT01, 0) ) PLAN_AMT01, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT02, 0),	0, 0, NVL(c.PLAN_AMT02, 0) /NVL(b.PLAN_AMT02, 0) ) PLAN_AMT02, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT03, 0),	0, 0, NVL(c.PLAN_AMT03, 0) /NVL(b.PLAN_AMT03, 0) ) PLAN_AMT03, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT04, 0),	0, 0, NVL(c.PLAN_AMT04, 0) /NVL(b.PLAN_AMT04, 0) ) PLAN_AMT04, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT05, 0),	0, 0, NVL(c.PLAN_AMT05, 0) /NVL(b.PLAN_AMT05, 0) ) PLAN_AMT05, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT06, 0),	0, 0, NVL(c.PLAN_AMT06, 0) /NVL(b.PLAN_AMT06, 0) ) PLAN_AMT06, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT121, 0),	0, 0, NVL(c.PLAN_AMT121,0) /NVL(b.PLAN_AMT121,0) ) PLAN_AMT121, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT07, 0),	0, 0, NVL(c.PLAN_AMT07, 0) /NVL(b.PLAN_AMT07, 0) ) PLAN_AMT07, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT08, 0),	0, 0, NVL(c.PLAN_AMT08, 0) /NVL(b.PLAN_AMT08, 0) ) PLAN_AMT08, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT09, 0),	0, 0, NVL(c.PLAN_AMT09, 0) /NVL(b.PLAN_AMT09, 0) ) PLAN_AMT09, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT10, 0),	0, 0, NVL(c.PLAN_AMT10, 0) /NVL(b.PLAN_AMT10, 0) ) PLAN_AMT10, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT11, 0),	0, 0, NVL(c.PLAN_AMT11, 0) /NVL(b.PLAN_AMT11, 0) ) PLAN_AMT11, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT12, 0),	0, 0, NVL(c.PLAN_AMT12, 0) /NVL(b.PLAN_AMT12, 0) ) PLAN_AMT12, \n";
			strSql += " 				DECODE( NVL(b.PLAN_AMT122, 0),	0, 0, NVL(c.PLAN_AMT122,0) /NVL(b.PLAN_AMT122,0) ) PLAN_AMT122 \n";
			strSql += " 		FROM  \n";
			strSql += " 		( \n";
			strSql += " 			SELECT  \n";
			strSql += " 				b.COMP_CODE ,  \n";
			strSql += " 				 ?  CLSE_ACC_ID,--b.CLSE_ACC_ID ,  \n";
			strSql += " 				--b.CHG_SEQ,  \n";
			strSql += " 				--b.WORK_YM ,  \n";
			strSql += " 				b.BIZ_PLAN_ITEM_NO ,  \n";
			strSql += " 				--b.DEPT_CODE,  \n";
			strSql += " 				'1' SUB_SEQ, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 1)  THEN b.EXEC_AMT ELSE 0 END )/1000000 PRE_EXEC_AMT, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 0)  THEN b.PLAN_AMT ELSE 0 END )/1000000 CUR_PLAN_AMT, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '01' THEN b.PLAN_AMT END )/1000000 PLAN_AMT01, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '02' THEN b.PLAN_AMT END )/1000000 PLAN_AMT02, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '03' THEN b.PLAN_AMT END )/1000000 PLAN_AMT03, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '04' THEN b.PLAN_AMT END )/1000000 PLAN_AMT04, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '05' THEN b.PLAN_AMT END )/1000000 PLAN_AMT05, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT06, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '01' AND '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT121, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '07' THEN b.PLAN_AMT END )/1000000 PLAN_AMT07, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '08' THEN b.PLAN_AMT END )/1000000 PLAN_AMT08, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '09' THEN b.PLAN_AMT END )/1000000 PLAN_AMT09, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '10' THEN b.PLAN_AMT END )/1000000 PLAN_AMT10, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '11' THEN b.PLAN_AMT END )/1000000 PLAN_AMT11, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT12, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '07' AND '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT122 \n";
			strSql += " 			FROM \n";
			strSql += " 				T_PL_COMP_DEPT_PLAN_EXEC b, \n";
			strSql += " 				T_PL_ITEM C, \n";
			strSql += " 				Z_CODE_DEPT D \n";
			strSql += " 			WHERE \n";
			strSql += " 				b.BIZ_PLAN_ITEM_NO = C.BIZ_PLAN_ITEM_NO \n";
			strSql += " 				AND	b.DEPT_CODE = d.DEPT_CODE \n";
			strSql += " 				AND	b.COMP_CODE =   ?    \n";
			strSql += " 		 		AND	b.CLSE_ACC_ID IN (  ?   - 1,   ?  ) \n";
			strSql += " 		 		AND	NVL(c.MNG_CODE, ' ') IN ('매출액') \n";
			strSql += " 		 		AND	b.CHG_SEQ = 0 \n";
			strSql += " 		  	GROUP BY GROUPING SETS \n";
			strSql += " 			( \n";
			strSql += " 		 	  	(  \n";
			strSql += " 			 		b.COMP_CODE , \n";
			strSql += " 		 			b.BIZ_PLAN_ITEM_NO \n";
			strSql += " 				) \n";
			strSql += " 			) \n";
			strSql += " 		) B, \n";
			strSql += " 		(		 \n";
			strSql += " 			SELECT  \n";
			strSql += " 				b.COMP_CODE ,  \n";
			strSql += " 				 ?  CLSE_ACC_ID,--b.CLSE_ACC_ID ,  \n";
			strSql += " 				--b.CHG_SEQ,  \n";
			strSql += " 				--b.WORK_YM ,  \n";
			strSql += " 				b.BIZ_PLAN_ITEM_NO ,  \n";
			strSql += " 				--b.DEPT_CODE,  \n";
			strSql += " 				'1' SUB_SEQ, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 1)  THEN b.EXEC_AMT ELSE 0 END )/1000000 PRE_EXEC_AMT, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID = (  ?   - 0)  THEN b.PLAN_AMT ELSE 0 END )/1000000 CUR_PLAN_AMT, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '01' THEN b.PLAN_AMT END )/1000000 PLAN_AMT01, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '02' THEN b.PLAN_AMT END )/1000000 PLAN_AMT02, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '03' THEN b.PLAN_AMT END )/1000000 PLAN_AMT03, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '04' THEN b.PLAN_AMT END )/1000000 PLAN_AMT04, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '05' THEN b.PLAN_AMT END )/1000000 PLAN_AMT05, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT06, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '01' AND '06' THEN b.PLAN_AMT END )/1000000 PLAN_AMT121, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '07' THEN b.PLAN_AMT END )/1000000 PLAN_AMT07, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '08' THEN b.PLAN_AMT END )/1000000 PLAN_AMT08, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '09' THEN b.PLAN_AMT END )/1000000 PLAN_AMT09, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '10' THEN b.PLAN_AMT END )/1000000 PLAN_AMT10, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '11' THEN b.PLAN_AMT END )/1000000 PLAN_AMT11, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) = '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT12, \n";
			strSql += " 				SUM( CASE WHEN b.CLSE_ACC_ID =  ?  AND SUBSTR(b.WORK_YM, 5,6) BETWEEN '07' AND '12' THEN b.PLAN_AMT END )/1000000 PLAN_AMT122 \n";
			strSql += " 			FROM \n";
			strSql += " 				T_PL_COMP_PLAN_EXEC b, \n";
			strSql += " 				T_PL_ITEM C \n";
			strSql += " 			WHERE \n";
			strSql += " 				b.BIZ_PLAN_ITEM_NO = C.BIZ_PLAN_ITEM_NO \n";
			strSql += " 				AND	b.COMP_CODE =   ?    \n";
			strSql += " 		 		AND	b.CLSE_ACC_ID IN (  ?   - 1,   ?  ) \n";
			strSql += " 		 		AND	NVL(c.MNG_CODE, ' ') IN ('매출이익','영업이익','세전이익') \n";
			strSql += " 		 		AND	b.CHG_SEQ = 0 \n";
			strSql += " 		  	GROUP BY GROUPING SETS \n";
			strSql += " 			( \n";
			strSql += " 		 	  	(  \n";
			strSql += " 			 		b.COMP_CODE , \n";
			strSql += " 		 			b.BIZ_PLAN_ITEM_NO \n";
			strSql += " 				) \n";
			strSql += " 			) \n";
			strSql += " 		) C \n";
			strSql += " 		WHERE \n";
			strSql += " 			B.COMP_CODE(+) = C.COMP_CODE  \n";
			strSql += "  	) b  \n";
			strSql += " WHERE \n";
			strSql += " 	a.COMP_CODE = b.COMP_CODE (+)  \n";
			strSql += " 	AND		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)  \n";
			strSql += " 	AND		a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO (+)  \n";
			strSql += " 	--AND		a.CHG_SEQ = b.CHG_SEQ (+)  \n";
			strSql += " ORDER BY  \n";
			strSql += " 	a.RN, \n";
			strSql += " 	b.SUB_SEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("6CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("9CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("10CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("11CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("12CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("13CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("15CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("16CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("17CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("19CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("20COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("21CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("22CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("23CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("25CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("26CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("27CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("28CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("29CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("30CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("31CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("32CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("33CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("34CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("35CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("36CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("37CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("38CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("39CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("40COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("41CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("42CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("43CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("44CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("45CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("46CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("47CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("48CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("49CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("50CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("51CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("52CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("53CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("54CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("55CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("56CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("57CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("58CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("59CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("60CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("61COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("62CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("63CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("64CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("65CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("66CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("67CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("68CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("69CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("70CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("71CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("72CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("73CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("74CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("75CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("76CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("77CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("78CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("79CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("80CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("81COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("82CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("83CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("6CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("9CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("10CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("11CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("12CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("13CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("15CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("16CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("17CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("19CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("20COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("21CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("22CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("23CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("25CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("26CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("27CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("28CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("29CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("30CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("31CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("32CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("33CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("34CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("35CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("36CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("37CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("38CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("39CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("40COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("41CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("42CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("43CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("44CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("45CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("46CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("47CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("48CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("49CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("50CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("51CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("52CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("53CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("54CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("55CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("56CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("57CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("58CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("59CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("60CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("61COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("62CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("63CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("64CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("65CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("66CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("67CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("68CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("69CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("70CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("71CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("72CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("73CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("74CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("75CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("76CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("77CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("78CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("79CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("80CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("81COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("82CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("83CLSE_ACC_ID", strCLSE_ACC_ID);
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
		else if (strAct.equals("COPY"))
		{

			
			strSql  = " select '######' comp_code, \n";
			strSql += " 	   '######' clse_acc_id, \n";
			strSql += " 	   '######' dept_code, \n";
			strSql += " 	   '######' month, \n";
			strSql += " 	   '######' bungi, \n";
			strSql += " 	   '######' mon1, \n";
			strSql += " 	   '######' mon2, \n";
			strSql += " 	   '######' mon3, \n";
			strSql += " 	   '######' b_clse_acc_id, \n";
			strSql += " 	   '######' n_clse_acc_id, \n";
			strSql += " 	   '######' emp_no \n";
			strSql += " from dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
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