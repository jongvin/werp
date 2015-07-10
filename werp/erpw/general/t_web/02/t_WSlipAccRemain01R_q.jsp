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
	String	strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
	
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strDT_F		= CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T		= CITCommon.toKOR(request.getParameter("DT_T"));
			String strCUST_CODE	= CITCommon.toKOR(request.getParameter("CUST_CODE"));
			String strACC_CODE	= CITCommon.toKOR(request.getParameter("ACC_CODE"));			
			String strRESET_GBN	= CITCommon.toKOR(request.getParameter("RESET_GBN"));			
			String strSS_SLIP_TRANS_CLS = CITCommon.toKOR(request.getParameter("SS_SLIP_TRANS_CLS"));
			String strSS_DEPT_CODE		= CITCommon.toKOR(request.getParameter("SS_DEPT_CODE"));

			strSql  = " SELECT  \n";
			strSql += "  	A.ACC_CODE1,  \n";
			strSql += "  	A.ACC_CODE2,  \n";
			strSql += "  	A.ACC_CODE3,  \n";
			strSql += "  	A.ACC_CODE4,  \n";
			strSql += "  	A.ACC_CODE5,  \n";
			strSql += "  	A.ACC_CODE6,      \n";
			strSql += "     	d.ACC_CODE ,      \n";
			strSql += "     	d.ACC_NAME ,      \n";
			strSql += "     	d.ACC_REMAIN_POSITION ,      \n";
			strSql += "     	C.NAME ACC_REMAIN_POSITION_NAME ,       \n";
			strSql += "     	e.COMP_CODE,     \n";
			strSql += "     	e.COMPANY_NAME COMP_NAME,     \n";
			strSql += "     	f.DEPT_CODE,     \n";
			strSql += "     	f.DEPT_NAME,     \n";
			strSql += "     	g.CUST_SEQ ,      \n";
			strSql += "     	g.CUST_CODE ,      \n";
			strSql += "     	g.CUST_NAME ,       \n";
			strSql += "     	a.SLIP_ID ,      \n";
			strSql += "     	a.SLIP_IDSEQ ,     \n";
			strSql += "     	A.SET_AMT,     \n";
			strSql += "     	A.RESET_AMT,      \n";
			strSql += "     	A.NOT_RESET_AMT,     \n";
			strSql += "     	A.SET_AMT - A.RESET_AMT REMAIN_AMT,     \n";
			strSql += "     	b1.MAKE_SLIPNO||'-'||b2.MAKE_SLIPLINE MAKE_SLIPNOLINE,     \n";
			strSql += "     	b3.SUMMARY1||' '||b3.SUMMARY2 SUMMARY,     \n";
			strSql += "     	b3.SUMMARY1,     \n";
			strSql += "     	b3.SUMMARY2,     \n";
			strSql += "    	CASE     \n";
			strSql += "    		WHEN A.SLIP_ID IS NOT NULL THEN F_T_Datetostring(b1.MAKE_DT)     \n";
			strSql += "    		WHEN A.ACC_CODE6  IS NOT NULL THEN '합 계'  \n";
			strSql += "    		WHEN A.ACC_CODE5  IS NOT NULL THEN '합 계'  \n";
			strSql += "    		WHEN A.ACC_CODE4  IS NOT NULL THEN '합 계'  \n";
			strSql += "    		WHEN A.ACC_CODE3  IS NOT NULL THEN '합 계'  \n";
			strSql += "    		WHEN A.ACC_CODE2  IS NOT NULL THEN '합 계'  \n";
			strSql += "    		WHEN A.ACC_CODE1  IS NOT NULL THEN '합 계'  \n";
			strSql += "    		ELSE '전체 합계'  \n";
			strSql += "    	END MAKE_DT_P,     \n";
			strSql += "     	-- 전표조회 인자     \n";
			strSql += "     	b1.MAKE_COMP_CODE ,      \n";
			strSql += "     	F_T_Datetostring(b1.MAKE_DT) MAKE_DT,      \n";
			strSql += "     	b1.MAKE_SEQ ,      \n";
			strSql += "     	b1.SLIP_KIND_TAG,    \n";
			strSql += "    	CASE     \n";
			strSql += "    		WHEN A.SLIP_ID IS NOT NULL THEN 'A'     \n";
			strSql += "    		WHEN A.ACC_CODE6  IS NOT NULL THEN 'B'     \n";
			strSql += "    		WHEN A.ACC_CODE5  IS NOT NULL THEN 'C'     \n";
			strSql += "    		WHEN A.ACC_CODE4  IS NOT NULL THEN 'D'     \n";
			strSql += "    		WHEN A.ACC_CODE3  IS NOT NULL THEN 'E'     \n";
			strSql += "    		WHEN A.ACC_CODE2  IS NOT NULL THEN 'F'     \n";
			strSql += "    		WHEN A.ACC_CODE1  IS NOT NULL THEN 'G'     \n";
			strSql += "    		ELSE 'H'     \n";
			strSql += "    	END ROW_TYPE,     \n";
			strSql += "    	CASE     \n";
			strSql += "    		WHEN A.SLIP_ID IS NOT NULL THEN '#FFFFFF'     \n";
			strSql += "    		WHEN A.ACC_CODE6  IS NOT NULL THEN '#EFEEFF'     \n";
			strSql += "    		WHEN A.ACC_CODE5  IS NOT NULL THEN '#E3EEFF'     \n";
			strSql += "    		WHEN A.ACC_CODE4  IS NOT NULL THEN '#DBECC8'     \n";
			strSql += "    		WHEN A.ACC_CODE3  IS NOT NULL THEN '#D3D3D3'     \n";
			strSql += "    		WHEN A.ACC_CODE2  IS NOT NULL THEN '#BBBEFF'     \n";
			strSql += "    		WHEN A.ACC_CODE1  IS NOT NULL THEN '#B3BEFF'     \n";
			strSql += "    		ELSE '#B3BEFF'    \n";
			strSql += "    	END ROW_COLOR    \n";
			strSql += "     FROM     \n";
			strSql += "     (     \n";
			strSql += "  	    SELECT  \n";
			strSql += "  			DISTINCT  \n";
			strSql += "  			A.ACC_CODE1,  \n";
			strSql += "  			A.ACC_CODE2,  \n";
			strSql += "  			A.ACC_CODE3,  \n";
			strSql += "  			A.ACC_CODE4,  \n";
			strSql += "  			A.ACC_CODE5,  \n";
			strSql += "  			A.ACC_CODE6,  \n";
			strSql += "  	  		X.ACC_CODE,    \n";
			strSql += "  			CASE   \n";
			strSql += "  				WHEN A.ACC_CODE6  IS NOT NULL THEN A.ACC_CODE6   \n";
			strSql += "  				WHEN A.ACC_CODE5  IS NOT NULL THEN A.ACC_CODE5   \n";
			strSql += "  				WHEN A.ACC_CODE4  IS NOT NULL THEN A.ACC_CODE4   \n";
			strSql += "  				WHEN A.ACC_CODE3  IS NOT NULL THEN A.ACC_CODE3   \n";
			strSql += "  				WHEN A.ACC_CODE2  IS NOT NULL THEN A.ACC_CODE2   \n";
			strSql += "  				WHEN A.ACC_CODE1  IS NOT NULL THEN A.ACC_CODE1   \n";
			strSql += "  			END ACC_CODE_P,   \n";
			strSql += "  	  		X.COMP_CODE,    \n";
			strSql += "  	  		X.DEPT_CODE,    \n";
			strSql += "  	  		X.CUST_SEQ,    \n";
			strSql += "  	   		X.SLIP_ID ,      \n";
			strSql += "  	   		X.SLIP_IDSEQ,    \n";
			strSql += "  	   		SUM(X.SET_AMT) SET_AMT,      \n";
			strSql += "  	   		SUM(X.RESET_AMT) RESET_AMT,      \n";
			strSql += "  	   		SUM(X.NOT_RESET_AMT) NOT_RESET_AMT     \n";
			strSql += "  	   	FROM    \n";
			strSql += "  			T_ACC_CODE_TREE A,   \n";
			strSql += "  	   		(    \n";
			strSql += "   	   			SELECT     \n";
			strSql += "  	  				A.ACC_CODE,    \n";
			strSql += "  	  				A.COMP_CODE,    \n";
			strSql += "  	  				A.DEPT_CODE,    \n";
			strSql += "  	  				A.CUST_SEQ,    \n";
			strSql += "  	   				A.SLIP_ID ,      \n";
			strSql += "  	   				A.SLIP_IDSEQ,    \n";
			strSql += "  	  				D.ACC_REMAIN_POSITION,    \n";
			strSql += "  	   				-- 설정     \n";
			strSql += "  	 				DECODE(D.ACC_REMAIN_POSITION, 'D', 1, -1)*NVL(A.DB_AMT,0)   \n";
			strSql += "  	 				+   \n";
			strSql += "  	 				DECODE(D.ACC_REMAIN_POSITION, 'C', 1, -1)*NVL(A.CR_AMT,0) SET_AMT,   \n";
			strSql += "  	 				-- 반제확정   \n";
			strSql += "  	 				DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B1.DB_AMT1,0)   \n";
			strSql += "  	 				+   \n";
			strSql += "  	 				DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B1.CR_AMT1,0) RESET_AMT,    \n";
			strSql += "  	 				-- 반제미확정   \n";
			strSql += "  	 				DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B1.DB_AMT2,0)   \n";
			strSql += "  	 				+   \n";
			strSql += "  	 				DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B1.CR_AMT2,0) NOT_RESET_AMT     \n";
			strSql += "  	   			FROM     \n";
			strSql += "  	   				( \n";
			strSql += " 		 	   			SELECT     \n";
			strSql += " 		 	  				A.ACC_CODE,    \n";
			strSql += " 		 	  				A.COMP_CODE,    \n";
			strSql += " 		 	  				A.DEPT_CODE,    \n";
			strSql += " 		 	  				A.CUST_SEQ,    \n";
			strSql += " 		 	   				A.SLIP_ID ,      \n";
			strSql += " 		 	   				A.SLIP_IDSEQ, \n";
			strSql += " 							A.DB_AMT, \n";
			strSql += " 							A.CR_AMT \n";
			strSql += " 		 	   			FROM     \n";
			strSql += " 		 	   				T_ACC_SLIP_REMAIN A      \n";
			strSql += " 		 	   				,T_CUST_CODE C \n";
			strSql += " 							,T_ACC_CODE D \n";
			if(!"".equals(strACC_CODE))
				strSql += " 		 	  				,T_ACC_CODE_CHILD2 E  \n";
			strSql += " 		 	   			WHERE     \n";
			strSql += " 		 	   				A.SLIP_ID = A.RESET_SLIP_ID      \n";
			strSql += " 		 	   				AND	A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ      \n";
			strSql += " 		 	   				AND	A.CUST_SEQ = C.CUST_SEQ      \n";
			strSql += " 		 	   				AND	A.ACC_CODE = D.ACC_CODE     \n";
			if(!"".equals(strACC_CODE))
				strSql += " 		 	   				AND	A.ACC_CODE = E.CHILD_ACC_CODE  \n";
			strSql += " 							AND A.KEEP_DT IS NOT NULL     \n";
			strSql += " 		 	   				AND	A.COMP_CODE LIKE  ?  || '%'     \n";
			strSql += " 		 	   				AND	A.DEPT_CODE LIKE  ?  || '%'     \n";
			strSql += " 		 	   				AND	A.MAKE_DT BETWEEN F_T_Stringtodate(  ?  ) AND F_T_Stringtodate(  ?  ) \n";
			if("1".equals(strRESET_GBN)){
			} else if("2".equals(strRESET_GBN)){
				strSql += " 							-- 반제 미완료 \n";
				strSql += " 		 	   				AND	A.COMPL_DT > F_T_Stringtodate(  ?  ) \n";
			} else if("3".equals(strRESET_GBN)){
				strSql += " 							-- 반제완료 \n";
				strSql += " 		 	   				AND	( A.COMPL_DT <= F_T_Stringtodate( ? ) ) \n";
			}
			if(!"".equals(strACC_CODE))
				strSql += " 		 	  				AND E.PARENT_ACC_CODE LIKE  ?  || '%' \n";
			strSql += " 		 	   				AND	NVL(C.CUST_CODE, ' ') LIKE  ?  || '%'     \n";
			// 이월
			strSql += " 	   						AND A.TRANSFER_TAG <> 'T'  \n";
			// 결산
			//strSql += " 	   						--AND A.SLIP_KIND_TAG <> 'D'  \n";
			// 조정 -- T_ACC_SLIP_REMAIN에는 없다.
			//strSql += " 	   						AND A.SLIP_KIND_TAG <> 'Z'  \n";
			strSql += " 							AND	D.ACC_REMAIN_MNG = 'T' \n";

			strSql += " 							AND ( \n";
			strSql += " 								'T' = ? \n";
			strSql += " 								OR \n";
			strSql += " 								A.DEPT_CODE IN ( \n";
			strSql += " 									SELECT \n";
			strSql += " 										DEPT_CODE \n";
			strSql += " 									FROM T_DEPT_CODE_ORG \n";
			strSql += " 									CONNECT BY P_DEPT_CODE=PRIOR DEPT_CODE \n";
			strSql += " 									START WITH DEPT_CODE=( \n";
			strSql += " 										SELECT \n";
			strSql += " 											DEPT_CODE \n";
			strSql += " 										FROM T_DEPT_CODE_ORG \n";
			strSql += " 										WHERE DEPT_KIND_TAG='0300' \n";
			strSql += " 										CONNECT BY DEPT_CODE=PRIOR P_DEPT_CODE \n";
			strSql += " 										START WITH DEPT_CODE=? \n";
			strSql += " 									) \n";
			strSql += " 									UNION \n";
			strSql += " 									SELECT ? DEPT_CODE FROM DUAL \n";
			strSql += " 								) \n";
			strSql += " 							) \n";

			strSql += " 					) A,      \n";
			strSql += "  	   				(  \n";
			strSql += "  	 					SELECT   \n";
			strSql += "  	 						A.RESET_SLIP_ID,   \n";
			strSql += "  	 						A.RESET_SLIP_IDSEQ,   \n";
			strSql += "  	 						NVL(SUM( DECODE( KEEP_DT, NULL, 0, A.DB_AMT ) ),0) DB_AMT1,   \n";
			strSql += "  	 						NVL(SUM( DECODE( KEEP_DT, NULL, 0, A.CR_AMT ) ),0) CR_AMT1, \n";
			strSql += " 							NVL(SUM( DECODE( KEEP_DT, NULL, A.DB_AMT, 0 ) ),0) DB_AMT2,   \n";
			strSql += "  	 						NVL(SUM( DECODE( KEEP_DT, NULL, A.CR_AMT, 0 ) ),0) CR_AMT2 \n";
			strSql += "  	 					FROM   \n";
			strSql += "  	 						T_ACC_SLIP_REMAIN A  \n";
			if(!"".equals(strACC_CODE))
				strSql += "  							,T_ACC_CODE_CHILD2 B  \n";
			strSql += "  	 					WHERE     \n";
			strSql += "  	 						--A.SLIP_ID <> A.RESET_SLIP_ID      \n";
			strSql += "  	 						--AND	      \n";
			strSql += "  	 						A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ  \n";
			if(!"".equals(strACC_CODE))
				strSql += "  	 						AND A.ACC_CODE = B.CHILD_ACC_CODE \n";
			strSql += "  	 						--AND A.KEEP_DT IS NOT NULL   \n";
			if(!"".equals(strACC_CODE))
				strSql += " 							AND B.PARENT_ACC_CODE LIKE  ?     || '%' \n";
			strSql += " 							AND	A.MAKE_DT <= F_T_Stringtodate(  ?  ) \n";
			// 이월
			strSql += " 	   						AND A.TRANSFER_TAG <> 'T'  \n";
			// 결산
			//strSql += " 	   						--AND A.SLIP_KIND_TAG <> 'D'  \n";
			// 조정 -- T_ACC_SLIP_REMAIN에는 없다.
			//strSql += " 	   						AND A.SLIP_KIND_TAG <> 'Z'  \n";
			strSql += "  	 					GROUP BY   \n";
			strSql += "  	 						A.RESET_SLIP_ID,   \n";
			strSql += "  	 						A.RESET_SLIP_IDSEQ \n";
			strSql += "  	 				) B1, \n";
			strSql += "  	   				T_ACC_CODE D \n";
			strSql += "  	   			WHERE     \n";
			strSql += "  	   				A.SLIP_ID = B1.RESET_SLIP_ID (+)   \n";
			strSql += "  	   				AND	A.SLIP_IDSEQ = B1.RESET_SLIP_IDSEQ (+)     \n";
			strSql += "  	   				AND	A.ACC_CODE = D.ACC_CODE  \n";
			strSql += " 					AND	D.ACC_REMAIN_MNG = 'T' \n";
			strSql += "  	   		) X  \n";
			strSql += " 		WHERE  \n";
			strSql += " 			A.ACC_CODE = X.ACC_CODE  \n";
			strSql += " 	 		-- 미반제   \n";
			strSql += "  			-- AND X.SET_AMT - X.RESET_AMT > 0     \n";
			strSql += "  	  	GROUP BY GROUPING SETS    \n";
			strSql += "  	  	(    \n";
			strSql += "  	  		(    \n";
			strSql += "  	  			A.ACC_CODE1,  \n";
			strSql += "  				A.ACC_CODE2,  \n";
			strSql += "  				A.ACC_CODE3,  \n";
			strSql += "  				A.ACC_CODE4,  \n";
			strSql += "  				A.ACC_CODE5,  \n";
			strSql += "  				A.ACC_CODE6,  \n";
			strSql += "  		  		X.ACC_CODE,    \n";
			strSql += "  	  			X.COMP_CODE,    \n";
			strSql += "  	  			X.DEPT_CODE,    \n";
			strSql += "  	  			X.CUST_SEQ,    \n";
			strSql += "  	  	 		X.SLIP_ID ,      \n";
			strSql += "  	  	 		X.SLIP_IDSEQ    \n";
			strSql += "  	  		),    \n";
			strSql += "  	  		(    \n";
			strSql += "  	  			A.ACC_CODE1,  \n";
			strSql += "  				A.ACC_CODE2,  \n";
			strSql += "  				A.ACC_CODE3,  \n";
			strSql += "  				A.ACC_CODE4,  \n";
			strSql += "  				A.ACC_CODE5,  \n";
			strSql += "  				A.ACC_CODE6   \n";
			strSql += "  	  		),    \n";
			strSql += "  	  		(    \n";
			strSql += "  	  			A.ACC_CODE1,  \n";
			strSql += "  				A.ACC_CODE2,  \n";
			strSql += "  				A.ACC_CODE3,  \n";
			strSql += "  				A.ACC_CODE4,  \n";
			strSql += "  				A.ACC_CODE5    \n";
			strSql += "  	  		),    \n";
			strSql += "  	  		(    \n";
			strSql += "  	  			A.ACC_CODE1,  \n";
			strSql += "  				A.ACC_CODE2,  \n";
			strSql += "  				A.ACC_CODE3,  \n";
			strSql += "  				A.ACC_CODE4   \n";
			strSql += "  	  		),    \n";
			strSql += "  	  		(    \n";
			strSql += "  	  			A.ACC_CODE1,  \n";
			strSql += "  				A.ACC_CODE2,  \n";
			strSql += "  				A.ACC_CODE3  \n";
			strSql += "  	  		),    \n";
			strSql += "  	  		(    \n";
			strSql += "  	  			A.ACC_CODE1,  \n";
			strSql += "  				A.ACC_CODE2  \n";
			strSql += "  	  		),    \n";
			strSql += "  	  		(    \n";
			strSql += "  	  			A.ACC_CODE1  \n";
			strSql += "  	  		)  \n";
			strSql += "  	  	)    \n";
			strSql += "     ) A,     \n";
			strSql += "  	T_ACC_SLIP_HEAD B1,      \n";
			strSql += "  	T_ACC_SLIP_BODY1 B2,      \n";
			strSql += "  	T_ACC_SLIP_BODY2 B3,      \n";
			strSql += "  	(      \n";
			strSql += "  	SELECT      \n";
			strSql += "  		a.CODE_LIST_ID AS CODE,      \n";
			strSql += "  		a.CODE_LIST_NAME AS NAME      \n";
			strSql += "  	FROM  				 		      \n";
			strSql += "  		V_T_CODE_LIST a      \n";
			strSql += "  	WHERE      \n";
			strSql += "  		a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION'      \n";
			strSql += "  	) C,    \n";
			strSql += "  	T_ACC_CODE D,      \n";
			strSql += "  	T_COMPANY E,     \n";
			strSql += "  	T_DEPT_CODE F,     \n";
			strSql += "  	T_CUST_CODE G    \n";
			strSql += " WHERE      \n";
			strSql += " 	A.SLIP_ID = B1.SLIP_ID(+)      \n";
			strSql += " 	AND	A.SLIP_ID = B2.SLIP_ID(+)      \n";
			strSql += " 	AND	A.SLIP_IDSEQ = B2.SLIP_IDSEQ(+)    \n";
			strSql += " 	AND	A.SLIP_ID = B3.SLIP_ID(+)      \n";
			strSql += " 	AND	A.SLIP_IDSEQ = B3.SLIP_IDSEQ(+)    \n";
			strSql += " 	AND	A.ACC_CODE_P = D.ACC_CODE(+)    \n";
			strSql += " 	AND	D.ACC_REMAIN_POSITION = C.CODE(+)    \n";
			strSql += " 	AND	A.COMP_CODE = E.COMP_CODE(+)    \n";
			strSql += " 	AND	A.DEPT_CODE = F.DEPT_CODE(+)    \n";
			strSql += " 	AND	A.CUST_SEQ = G.CUST_SEQ(+)    \n";
			strSql += " ORDER BY  \n";
			strSql += " 	A.ACC_CODE1,  \n";
			strSql += " 	A.ACC_CODE2,  \n";
			strSql += " 	A.ACC_CODE3,  \n";
			strSql += " 	A.ACC_CODE4,  \n";
			strSql += " 	A.ACC_CODE5,  \n";
			strSql += " 	A.ACC_CODE6,    \n";
			strSql += " 	A.ACC_CODE_P,  \n";
			strSql += " 	B2.MAKE_DT,  \n";
			strSql += " 	A.COMP_CODE,    \n";
			strSql += " 	A.DEPT_CODE,    \n";
			strSql += " 	A.CUST_SEQ,    \n";
			strSql += " 	A.SLIP_ID ,      \n";
			strSql += " 	A.SLIP_IDSEQ  \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("4DT_T", CITData.VARCHAR2);
			if("1".equals(strRESET_GBN)){
			} else if("2".equals(strRESET_GBN)){
				lrArgData.addColumn("5DT_T", CITData.VARCHAR2);
			} else if("3".equals(strRESET_GBN)){
				lrArgData.addColumn("5DT_T", CITData.VARCHAR2);
			}
			if(!"".equals(strACC_CODE)) lrArgData.addColumn("6ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("7CUST_CODE", CITData.VARCHAR2);
			
			lrArgData.addColumn("SS_SLIP_TRANS_CLS", CITData.VARCHAR2);
			lrArgData.addColumn("SS_DEPT_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("SS_DEPT_CODE2", CITData.VARCHAR2);


			if(!"".equals(strACC_CODE)) lrArgData.addColumn("8ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("3DT_F", strDT_F);
			lrArgData.setValue("4DT_T", strDT_T);
			if("1".equals(strRESET_GBN)){
			} else if("2".equals(strRESET_GBN)){
				lrArgData.setValue("5DT_T", strDT_T);
			} else if("3".equals(strRESET_GBN)){
				lrArgData.setValue("5DT_T", strDT_T);
			}
			if(!"".equals(strACC_CODE)) lrArgData.setValue("6ACC_CODE", strACC_CODE);
			lrArgData.setValue("7CUST_CODE", strCUST_CODE);

			lrArgData.setValue("SS_SLIP_TRANS_CLS", strSS_SLIP_TRANS_CLS);
			lrArgData.setValue("SS_DEPT_CODE1", strSS_DEPT_CODE);
			lrArgData.setValue("SS_DEPT_CODE2", strSS_DEPT_CODE);

			if(!"".equals(strACC_CODE)) lrArgData.setValue("8ACC_CODE", strACC_CODE);
			lrArgData.setValue("9DT_T", strDT_T);

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
		else if (strAct.equals("SUB01"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			String strSLIP_IDSEQ = CITCommon.toKOR(request.getParameter("SLIP_IDSEQ"));
			
			strSql  = " SELECT  \n";
			strSql += "  	'F' CHK_CLS,  \n";
			strSql += "   	DECODE(b.KEEP_DT,NULL,'F','T') KEEP_CLS,  \n";
			strSql += "   	b.SLIP_ID ,    \n";
			strSql += "   	b.SLIP_IDSEQ ,   \n";
			strSql += "   	b.ACC_CODE ,    \n";
			strSql += "   	d.ACC_NAME ,    \n";
			strSql += "   	d.ACC_REMAIN_POSITION ,    \n";
			strSql += "  	C.NAME ACC_REMAIN_POSITION_NAME ,     \n";
			strSql += "  	b.COMP_CODE,  \n";
			strSql += "  	b2.COMPANY_NAME COMP_NAME,  \n";
			strSql += "  	b.DEPT_CODE,  \n";
			strSql += "  	b3.DEPT_NAME,  \n";
			strSql += "   	b.CUST_SEQ ,  \n";
			strSql += "   	b4.CUST_CODE,  \n";
			strSql += "   	b4.CUST_NAME,  \n";
			strSql += "   	a.MAKE_SLIPNO||'-'||b.MAKE_SLIPLINE RESET_MAKE_SLIPNOLINE,   \n";
			strSql += "   	b1.SUMMARY1,   \n";
			strSql += "   	-- 전표조회 인자   \n";
			strSql += "   	b.MAKE_COMP_CODE ,    \n";
			strSql += "   	F_T_DateToString(b.MAKE_DT) MAKE_DT,    \n";
			strSql += "   	a.MAKE_SEQ ,    \n";
			strSql += "   	b.SLIP_KIND_TAG,  \n";
			strSql += "   	NVL(b.DB_AMT,0)+NVL(b.CR_AMT,0) RESET_AMT \n";
			strSql += "   FROM   \n";
			strSql += "   T_ACC_SLIP_HEAD A,    \n";
			strSql += "   T_ACC_SLIP_BODY1 B,    \n";
			strSql += "   T_ACC_SLIP_BODY2 B1, \n";
			strSql += " 	T_COMPANY b2,  \n";
			strSql += " 	T_DEPT_CODE b3,  \n";
			strSql += " 	T_CUST_CODE b4, \n";
			strSql += " 	T_ACC_SLIP_BODY1 b5, \n";
			strSql += "   (    \n";
			strSql += "  	SELECT    \n";
			strSql += "  		a.CODE_LIST_ID AS CODE,    \n";
			strSql += "  		a.CODE_LIST_NAME AS NAME    \n";
			strSql += "  	FROM    \n";
			strSql += "  		V_T_CODE_LIST a    \n";
			strSql += "  	WHERE    \n";
			strSql += "  	a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION'    \n";
			strSql += "  ) C ,  \n";
			strSql += "  T_ACC_CODE D \n";
			strSql += "  WHERE \n";
			strSql += "  	A.SLIP_ID = B.SLIP_ID \n";
			strSql += "  	AND	B.SLIP_ID = B1.SLIP_ID \n";
			strSql += " 	AND B.SLIP_IDSEQ = B1.SLIP_IDSEQ \n";
			strSql += " 	AND	b.COMP_CODE = b2.COMP_CODE(+) \n";
			strSql += " 	AND	b.DEPT_CODE = b3.DEPT_CODE(+) \n";
			strSql += " 	AND	b.CUST_SEQ = b4.CUST_SEQ(+) \n";
			strSql += "  	AND	b.ACC_CODE = D.ACC_CODE   \n";
			strSql += " 	AND	d.ACC_REMAIN_POSITION = C.CODE  \n";
			strSql += "  	--B.SLIP_ID <> B.RESET_SLIP_ID   \n";
			strSql += "  	--AND	 \n";
			strSql += " 	AND B.SLIP_IDSEQ <> B.RESET_SLIP_IDSEQ    \n";
			strSql += " 	AND B.RESET_SLIP_ID = B5.SLIP_ID   \n";
			strSql += "		AND B.RESET_SLIP_IDSEQ = B5.SLIP_IDSEQ    \n";
			strSql += "  	AND B.RESET_SLIP_ID =  ?    \n";
			strSql += "  	AND	B.RESET_SLIP_IDSEQ =  ?  \n";
			strSql += "  ORDER BY \n";
			strSql += "  	a.MAKE_SLIPNO, b.MAKE_SLIPLINE \n";

			lrArgData.addColumn("1SLIP_ID", CITData.VARCHAR2);
			lrArgData.addColumn("2SLIP_IDSEQ", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SLIP_ID", strSLIP_ID);
			lrArgData.setValue("2SLIP_IDSEQ", strSLIP_IDSEQ);

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
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
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