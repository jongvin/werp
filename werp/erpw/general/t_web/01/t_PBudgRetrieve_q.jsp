<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
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
			String strBUDG_YM = CITCommon.toKOR(request.getParameter("BUDG_YM"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			
			strSql  = " SELECT  \n";
			strSql += " 	A.COMP_CODE,  \n";
			strSql += " 	A.CLSE_ACC_ID,  \n";
			strSql += " 	A.CHK_DEPT_CODE,  \n";
			strSql += " 	D.DEPT_NAME CHK_DEPT_NAME,  \n";
			strSql += " 	A.CTL_BUDG_CODE_NO,  \n";
			strSql += " 	B.BUDG_CODE_NAME CTL_BUDG_CODE_NAME,  \n";
			strSql += " 	A.BUDG_CODE_NO,  \n";
			strSql += " 	C.BUDG_CODE_NAME,  \n";
			strSql += " 	C.ACC_CODE,  \n";
			strSql += " 	--A.ACC_NAME,  \n";
			strSql += " 	A.BUDG_YM,  \n";
			strSql += " 	(NVL(A.PRE_REQ_AMT,0)) PRE_REQ_AMT,  \n";
			strSql += " 	(NVL(A.PRE_ASSIGN_AMT,0)) PRE_ASSIGN_AMT,  \n";
			strSql += " 	(NVL(A.PRE_NOT_SIL_AMT,0)) PRE_NOT_SIL_AMT,  \n";
			strSql += " 	(NVL(A.PRE_SIL_AMT,0)) PRE_SIL_AMT,  \n";
			strSql += " 	(NVL(A.PRE_ASSIGN_AMT,0) - NVL(A.PRE_SIL_AMT,0)) PRE_JAN_AMT,  \n";
			strSql += " 	(NVL(A.REQ_AMT,0)) REQ_AMT,  \n";
			strSql += " 	(NVL(A.ASSIGN_AMT,0)) ASSIGN_AMT,  \n";
			strSql += " 	(NVL(A.NOT_SIL_AMT,0)) NOT_SIL_AMT,  \n";
			strSql += " 	(NVL(A.SIL_AMT,0)) SIL_AMT,  \n";
			strSql += " 	(NVL(A.PRE_ASSIGN_AMT,0) - NVL(A.PRE_SIL_AMT,0) + NVL(A.ASSIGN_AMT,0) - NVL(A.SIL_AMT,0)) JAN_AMT \n";
			strSql += " FROM  \n";
			strSql += " (  \n";
			strSql += "   	 SELECT  \n";
			strSql += "  		A.COMP_CODE,  \n";
			strSql += "  		A.CLSE_ACC_ID,  \n";
			strSql += "  		A.CHK_DEPT_CODE,  \n";
			strSql += "  		--A.DEPT_CODE,  \n";
			strSql += "  		A.CTL_BUDG_CODE_NO,  \n";
			strSql += "  		A.BUDG_CODE_NO,  \n";
			strSql += "  		--A.ACC_CODE,  \n";
			strSql += "  		  ?   BUDG_YM,  \n";
			strSql += "  		SUM(  \n";
			strSql += "  			CASE  \n";
			strSql += "  				WHEN (A.BUDG_YM < F_T_StringToDate(  ?  )) THEN BUDG_MONTH_REQ_AMT  \n";
			strSql += "  			END  \n";
			strSql += "  		) PRE_REQ_AMT,  \n";
			strSql += "  		SUM(  \n";
			strSql += "  			CASE  \n";
			strSql += "  				WHEN (A.BUDG_YM < F_T_StringToDate(  ?  )) THEN BUDG_MONTH_ASSIGN_AMT  \n";
			strSql += "  			END  \n";
			strSql += "  		) PRE_ASSIGN_AMT,  \n";
			strSql += "  		SUM(  \n";
			strSql += "  			CASE  \n";
			strSql += "  				WHEN (A.BUDG_YM < F_T_StringToDate(  ?  )) THEN NVL(A.NOT_SIL_AMT,0)  \n";
			strSql += "  			END  \n";
			strSql += "  		) PRE_NOT_SIL_AMT,  \n";
			strSql += "  		SUM(  \n";
			strSql += "  			CASE  \n";
			strSql += "  				WHEN (A.BUDG_YM < F_T_StringToDate(  ?  )) THEN NVL(A.SIL_AMT,0)  \n";
			strSql += "  			END  \n";
			strSql += "  		) PRE_SIL_AMT,  \n";
			strSql += "  		SUM(  \n";
			strSql += "  			CASE  \n";
			strSql += "  				WHEN (A.BUDG_YM = F_T_StringToDate(  ?  )) THEN A.BUDG_MONTH_REQ_AMT  \n";
			strSql += "  			END  \n";
			strSql += "  		) REQ_AMT,  \n";
			strSql += "  		SUM(  \n";
			strSql += "  			CASE  \n";
			strSql += "  				WHEN (A.BUDG_YM = F_T_StringToDate(  ?  )) THEN A.BUDG_MONTH_ASSIGN_AMT  \n";
			strSql += "  			END  \n";
			strSql += "  		) ASSIGN_AMT,  \n";
			strSql += "  		SUM( \n";
			strSql += "  			CASE  \n";
			strSql += "  				WHEN (A.BUDG_YM = F_T_StringToDate(  ?  )) THEN NVL(A.NOT_SIL_AMT,0)  \n";
			strSql += "  			END \n";
			strSql += "  		) NOT_SIL_AMT, \n";
			strSql += "  		SUM( \n";
			strSql += "  			CASE \n";
			strSql += "  				WHEN (A.BUDG_YM = F_T_StringToDate(  ?  )) THEN NVL(A.SIL_AMT,0) \n";
			strSql += "  			END \n";
			strSql += "  		) SIL_AMT \n";
			strSql += "  	FROM  \n";
			strSql += "  	(  \n";
			strSql += "  	 	SELECT  \n";
			strSql += "  			A.COMP_CODE,  \n";
			strSql += "  			A.CLSE_ACC_ID,  \n";
			strSql += "  			A.CHK_DEPT_CODE,  \n";
			strSql += "  			--A.DEPT_CODE,  \n";
			strSql += "  			A.CTL_BUDG_CODE_NO,  \n";
			strSql += "  			A.BUDG_CODE_NO,  \n";
			strSql += "  			--A.ACC_CODE,  \n";
			strSql += "  			A.BUDG_YM,  \n";
			strSql += "  			A.BUDG_MONTH_REQ_AMT,  \n";
			strSql += "  			A.BUDG_MONTH_ASSIGN_AMT,  \n";
			strSql += "  			SUM(DECODE(A.KEEP_DT,NULL,A.SIL_AMT,0)) NOT_SIL_AMT,  \n";
			strSql += "  			SUM(DECODE(A.KEEP_DT,NULL,0,A.SIL_AMT)) SIL_AMT  \n";
			strSql += "  		FROM  \n";
			strSql += "  		(  \n";
			strSql += "  			SELECT  \n";
			strSql += "  				A.COMP_CODE,  \n";
			strSql += "  				A.CLSE_ACC_ID,  \n";
			strSql += "  				A.CHK_DEPT_CODE,  \n";
			strSql += "  				--A.DEPT_CODE,  \n";
			strSql += "  				A.CTL_BUDG_CODE_NO,  \n";
			strSql += "  				A.BUDG_CODE_NO,  \n";
			strSql += "  				B.ACC_CODE,  \n";
			strSql += "  				A.BUDG_YM,  \n";
			strSql += "  				A.BUDG_MONTH_REQ_AMT,  \n";
			strSql += "  				A.BUDG_MONTH_ASSIGN_AMT,  \n";
			strSql += "  				B.KEEP_DT,  \n";
			strSql += "  				NVL(B.DB_AMT,0)+NVL(B.CR_AMT,0) SIL_AMT  \n";
			strSql += "  			FROM  \n";
			strSql += "  				(  \n";
			strSql += " 		 			SELECT  \n";
			strSql += " 		 				B.COMP_CODE,  \n";
			strSql += " 		 				B.CLSE_ACC_ID,  \n";
			strSql += " 		 				A.CHK_DEPT_CODE,  \n";
			strSql += " 		 				--B.DEPT_CODE,  \n";
			strSql += " 		 				(  \n";
			strSql += " 		 					SELECT  \n";
			strSql += " 		 						Min(BUDG_CODE_NO)  \n";
			strSql += " 		 					FROM  \n";
			strSql += " 		 						(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' )  \n";
			strSql += " 		 					WHERE  \n";
			strSql += " 		 						CONTROL_LEVEL_TAG = 'T'  \n";
			strSql += " 		 					START WITH BUDG_CODE_NO = B.BUDG_CODE_NO  \n";
			strSql += " 		 					CONNECT BY  \n";
			strSql += " 		 					PRIOR P_BUDG_CODE_NO = BUDG_CODE_NO  \n";
			strSql += " 		 				) CTL_BUDG_CODE_NO,  \n";
			strSql += " 		 				B.BUDG_CODE_NO,  \n";
			strSql += " 		 				B.BUDG_YM,  \n";
			strSql += " 		 				SUM(B.BUDG_MONTH_REQ_AMT) BUDG_MONTH_REQ_AMT,  \n";
			strSql += " 		 				SUM(B.BUDG_MONTH_ASSIGN_AMT) BUDG_MONTH_ASSIGN_AMT \n";
			strSql += " 		 			FROM  \n";
			strSql += " 		 				T_BUDG_DEPT_MAP A,  \n";
			strSql += " 		 				T_BUDG_MONTH_AMT B  \n";
			strSql += " 		 			WHERE  \n";
			strSql += " 		 				A.DEPT_CODE = B.DEPT_CODE  \n";
			strSql += " 		 				AND B.COMP_CODE =   ?   \n";
			strSql += " 		 				AND A.CHK_DEPT_CODE = (  \n";
			strSql += " 		 					SELECT  \n";
			strSql += " 		 					  CHK_DEPT_CODE  \n";
			strSql += " 		 					FROM  \n";
			strSql += " 		 						T_BUDG_DEPT_MAP  \n";
			strSql += " 		 					WHERE  \n";
			strSql += " 		 						DEPT_CODE =   ?   \n";
			strSql += " 		 				)  \n";
			strSql += " 		 				AND B.BUDG_CODE_NO IN (  \n";
			strSql += " 		 					SELECT  \n";
			strSql += " 		 						A.BUDG_CODE_NO  \n";
			strSql += " 		 					FROM  \n";
			strSql += " 		 						(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) A  \n";
			strSql += " 		 					START WITH BUDG_CODE_NO = (  \n";
			strSql += " 		 						SELECT  \n";
			strSql += " 		 							A.BUDG_CODE_NO  \n";
			strSql += " 		 						FROM  \n";
			strSql += " 		 							(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) A  \n";
			strSql += " 		 						WHERE  \n";
			strSql += " 		 							A.CONTROL_LEVEL_TAG = 'T'  \n";
			strSql += " 										AND A.COMP_CODE =  ?   \n";
			strSql += " 		 						START WITH A.ACC_CODE =   ?   \n";
			strSql += " 		 						CONNECT BY  \n";
			strSql += " 		 						PRIOR A.P_BUDG_CODE_NO = A.BUDG_CODE_NO  \n";
			strSql += " 		 					)  \n";
			strSql += " 		 					CONNECT BY  \n";
			strSql += " 		 					PRIOR A.BUDG_CODE_NO = A.P_BUDG_CODE_NO  \n";
			strSql += " 		 				)  \n";
			strSql += " 		 				AND B.BUDG_YM BETWEEN F_T_StringToDate(SUBSTR(  ?  ,1,4)||'0101') AND F_T_StringToDate(  ?  ) \n";
			strSql += " 					GROUP BY  \n";
			strSql += " 		 				B.COMP_CODE,  \n";
			strSql += " 		 				B.CLSE_ACC_ID,  \n";
			strSql += " 		 				A.CHK_DEPT_CODE,  \n";
			strSql += " 		 				--B.DEPT_CODE,  \n";
			strSql += " 		 				B.BUDG_CODE_NO,  \n";
			strSql += " 		 				B.BUDG_YM \n";
			strSql += "   				) A,  \n";
			strSql += "  				(  \n";
			strSql += "  					SELECT  \n";
			strSql += "  						SLIP_ID,  \n";
			strSql += "  						SLIP_IDSEQ,  \n";
			strSql += "  						MAKE_SLIPLINE,  \n";
			strSql += "  						B.BUDG_CODE_NO,  \n";
			strSql += " 		 				(  \n";
			strSql += " 		 					SELECT  \n";
			strSql += " 		 						Min(BUDG_CODE_NO)  \n";
			strSql += " 		 					FROM  \n";
			strSql += " 		 						(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' )  \n";
			strSql += " 		 					WHERE  \n";
			strSql += " 		 						CONTROL_LEVEL_TAG = 'T'  \n";
			strSql += " 		 					START WITH BUDG_CODE_NO = B.BUDG_CODE_NO  \n";
			strSql += " 		 					CONNECT BY  \n";
			strSql += " 		 					PRIOR P_BUDG_CODE_NO = BUDG_CODE_NO  \n";
			strSql += " 		 				) CTL_BUDG_CODE_NO,  \n";
			strSql += "  						A.ACC_CODE,  \n";
			strSql += "  						DB_AMT,  \n";
			strSql += "  						CR_AMT,  \n";
			strSql += "  						SUMMARY_CODE,  \n";
			strSql += "  						TAX_COMP_CODE,  \n";
			strSql += "  						A.COMP_CODE,  \n";
			strSql += "  						DEPT_CODE,  \n";
			strSql += " 						(  \n";
			strSql += " 							SELECT  \n";
			strSql += " 							  CHK_DEPT_CODE  \n";
			strSql += " 							FROM  \n";
			strSql += " 								T_BUDG_DEPT_MAP  \n";
			strSql += " 							WHERE  \n";
			strSql += " 								DEPT_CODE =  A.DEPT_CODE  \n";
			strSql += " 						) CHK_DEPT_CODE,  \n";
			strSql += "  						CLASS_CODE,  \n";
			strSql += "  						VAT_CODE,  \n";
			strSql += "  						VAT_DT,  \n";
			strSql += "  						SUPAMT,  \n";
			strSql += "  						VATAMT,  \n";
			strSql += "  						CUST_SEQ,  \n";
			strSql += "  						CUST_NAME,  \n";
			strSql += "  						BANK_CODE,  \n";
			strSql += "  						ACCNO,  \n";
			strSql += "  						RESET_SLIP_ID,  \n";
			strSql += "  						RESET_SLIP_IDSEQ,  \n";
			strSql += "  						MAKE_COMP_CODE,  \n";
			strSql += "  						MAKE_DEPT_CODE,  \n";
			strSql += "  						F_T_StringToDate(TO_CHAR(MAKE_DT, 'YYYYMM')||'01') MAKE_DT01,  \n";
			strSql += "  						MAKE_DT,  \n";
			strSql += "  						SLIP_KIND_TAG,  \n";
			strSql += "  						TRANSFER_TAG,  \n";
			strSql += "  						IGNORE_SET_RESET_TAG,  \n";
			strSql += "  						KEEP_DT  \n";
			strSql += "  					FROM  \n";
			strSql += "  					 	T_ACC_SLIP_BODY1 A,  \n";
			strSql += " 						(  \n";
			strSql += " 							SELECT  \n";
			strSql += " 								ACC_CODE, BUDG_CODE_NO  \n";
			strSql += " 							FROM  \n";
			strSql += " 								(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' )  \n";
			strSql += " 							WHERE  \n";
			strSql += " 								COMP_CODE =  ?   \n";
			strSql += "  								AND BUDG_CODE_NO IN (  \n";
			strSql += " 									SELECT  \n";
			strSql += " 										A.BUDG_CODE_NO  \n";
			strSql += " 									FROM  \n";
			strSql += " 										(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) A  \n";
			strSql += " 									START WITH BUDG_CODE_NO = (  \n";
			strSql += " 										SELECT  \n";
			strSql += " 											A.BUDG_CODE_NO  \n";
			strSql += " 										FROM  \n";
			strSql += " 											(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) A  \n";
			strSql += " 										WHERE  \n";
			strSql += " 											A.CONTROL_LEVEL_TAG = 'T'  \n";
			strSql += " 											AND A.COMP_CODE =  ?   \n";
			strSql += " 										START WITH A.ACC_CODE =   ?   \n";
			strSql += " 										CONNECT BY  \n";
			strSql += " 										PRIOR A.P_BUDG_CODE_NO = A.BUDG_CODE_NO  \n";
			strSql += " 									)  \n";
			strSql += " 									CONNECT BY  \n";
			strSql += " 									PRIOR A.BUDG_CODE_NO = A.P_BUDG_CODE_NO  \n";
			strSql += " 								)  \n";
			strSql += " 						) B  \n";
			strSql += "  					WHERE  \n";
			strSql += "  						A.ACC_CODE = B.ACC_CODE  \n";
			strSql += "  						AND TO_CHAR(MAKE_DT, 'YYYYMM') BETWEEN SUBSTR(  ?  ,1,4)||'01' AND SUBSTR(  ?  ,1,6)  \n";
			strSql += "   				) B  \n";
			strSql += "  			WHERE  \n";
			strSql += "  				A.COMP_CODE = B.COMP_CODE(+)  \n";
			strSql += "  				AND A.CHK_DEPT_CODE = B.CHK_DEPT_CODE(+)  \n";
			strSql += "  				AND A.BUDG_CODE_NO = B.BUDG_CODE_NO(+)  \n";
			strSql += "  				AND A.BUDG_YM = B.MAKE_DT01(+)  \n";
			strSql += "  		) A  \n";
			strSql += "  		GROUP BY  \n";
			strSql += "  			A.COMP_CODE,  \n";
			strSql += "  			A.CLSE_ACC_ID,  \n";
			strSql += "  			A.CHK_DEPT_CODE,  \n";
			strSql += "  			--A.DEPT_CODE,  \n";
			strSql += "  			A.CTL_BUDG_CODE_NO,  \n";
			strSql += "  			A.BUDG_CODE_NO,  \n";
			strSql += "  			--A.ACC_CODE,  \n";
			strSql += "  			A.BUDG_YM,  \n";
			strSql += "  			A.BUDG_MONTH_REQ_AMT,  \n";
			strSql += "  			A.BUDG_MONTH_ASSIGN_AMT  \n";
			strSql += "  	) A  \n";
			strSql += "  	GROUP BY  \n";
			strSql += "  		A.COMP_CODE,  \n";
			strSql += "  		A.CLSE_ACC_ID,  \n";
			strSql += "  		A.CHK_DEPT_CODE,  \n";
			strSql += "  		--A.DEPT_CODE,  \n";
			strSql += "  		A.CTL_BUDG_CODE_NO,  \n";
			strSql += "  		A.BUDG_CODE_NO  \n";
			strSql += " ) A,  \n";
			strSql += " (Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) B,  \n";
			strSql += " (Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) C,  \n";
			strSql += " T_DEPT_CODE D  \n";
			strSql += " WHERE  \n";
			strSql += " 	A.CTL_BUDG_CODE_NO = B.BUDG_CODE_NO  \n";
			strSql += " 	AND A.BUDG_CODE_NO = C.BUDG_CODE_NO  \n";
			strSql += " 	AND A.CHK_DEPT_CODE = D.DEPT_CODE ";
			
			lrArgData.addColumn("1BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("2BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("3BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("4BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("5BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("6BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("7BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("8BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("9BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("10COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("12COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("13ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("14BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("15BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("16COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("17COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("18ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("19BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("20BUDG_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1BUDG_YM", strBUDG_YM);
			lrArgData.setValue("2BUDG_YM", strBUDG_YM);
			lrArgData.setValue("3BUDG_YM", strBUDG_YM);
			lrArgData.setValue("4BUDG_YM", strBUDG_YM);
			lrArgData.setValue("5BUDG_YM", strBUDG_YM);
			lrArgData.setValue("6BUDG_YM", strBUDG_YM);
			lrArgData.setValue("7BUDG_YM", strBUDG_YM);
			lrArgData.setValue("8BUDG_YM", strBUDG_YM);
			lrArgData.setValue("9BUDG_YM", strBUDG_YM);
			lrArgData.setValue("10COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("11DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("12COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("13ACC_CODE", strACC_CODE);
			lrArgData.setValue("14BUDG_YM", strBUDG_YM);
			lrArgData.setValue("15BUDG_YM", strBUDG_YM);
			lrArgData.setValue("16COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("17COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("18ACC_CODE", strACC_CODE);
			lrArgData.setValue("19BUDG_YM", strBUDG_YM);
			lrArgData.setValue("20BUDG_YM", strBUDG_YM);



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
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strBUDG_YM = CITCommon.toKOR(request.getParameter("BUDG_YM"));
			
			strSql  = " SELECT  \n";
			strSql += " 	SLIP_ID, SLIP_IDSEQ, MAKE_SLIPLINE, MAKE_SLIPCLS, MAKE_SLIPCLS_NAME,  \n";
			strSql += " 	MAKE_SLIPNO, MAKE_COMP_CODE, MAKE_COMP_NAME, MAKE_DEPT_CODE, MAKE_DEPT_NAME,  \n";
			strSql += " 	MAKE_DT, MAKE_DT_TRANS, MAKE_SEQ, INOUT_DEPT_CODE, INOUT_DEPT_NAME,  \n";
			strSql += " 	MAKE_PERS, MAKE_NAME, GROUPWARE_SLIPSTATUS, KEEP_CLS, KEEP_SLIPNO,  \n";
			strSql += " 	KEEP_DT, KEEP_DT_TRANS, KEEP_SEQ, KEEP_DEPT_CODE, KEEP_DEPT_NAME,  \n";
			strSql += " 	KEEP_KEEPER, WORK_CODE, WORK_NAME, CHARGE_PERS, CHARGE_PERS_NAME,  \n";
			strSql += " 	SLIP_KIND_TAG, SLIP_KIND_NAME, TRANSFER_TAG, IGNORE_SET_RESET_TAG, SLIP_UPDATE_CLS,  \n";
			strSql += " 	A.ACC_CODE, ACC_NAME, ACC_REMAIN_POSITION, ACC_GRP, DB_AMT,  \n";
			strSql += " 	CR_AMT, SUMMARY_CODE, TAX_COMP_CODE, TAX_COMP_NAME, COMP_CODE,  \n";
			strSql += " 	COMP_NAME, A.DEPT_CODE, DEPT_NAME, CLASS_CODE, CLASS_CODE_NAME,  \n";
			strSql += " 	VAT_CODE, VAT_NAME, VAT_DT, SUPAMT, VATAMT,  \n";
			strSql += " 	CUST_SEQ, CUST_CODE, CUST_NAME, BANK_CODE, BANK_NAME,  \n";
			strSql += " 	ACCNO, RESET_SLIP_ID, RESET_SLIP_IDSEQ, SUMMARY1, SUMMARY2,  \n";
			strSql += " 	MAKE_SLIPNO||'-'||MAKE_SLIPLINE MAKE_SLIPNOLINE,  \n";
			strSql += " 	DECODE(KEEP_DT,NULL,NULL,'확정  ') CONF_YN  \n";
			strSql += " FROM  \n";
			strSql += " 	T_ACC_SLIP_VIEW A \n";
			strSql += " WHERE \n";
			strSql += " 	( SLIP_ID, SLIP_IDSEQ ) IN \n";
			strSql += " 	( \n";
			strSql += " 		SELECT  \n";
			strSql += " 		 	A.SLIP_ID, A.SLIP_IDSEQ \n";
			strSql += " 		FROM  \n";
			strSql += " 		T_ACC_SLIP_BODY1 A,  \n";
			strSql += " 		(  \n";
			strSql += " 			SELECT  \n";
			strSql += " 				DEPT_CODE, rownum  \n";
			strSql += " 			FROM  \n";
			strSql += " 				T_BUDG_DEPT_MAP  \n";
			strSql += " 			WHERE  \n";
			strSql += " 				CHK_DEPT_CODE = ?   \n";
			strSql += " 		) B,  \n";
			strSql += " 		(  \n";
			strSql += " 			SELECT  \n";
			strSql += " 				ACC_CODE, BUDG_CODE_NO  \n";
			strSql += " 			FROM  \n";
			strSql += " 				(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' )  \n";
			strSql += " 			WHERE  \n";
			strSql += " 				COMP_CODE =  ?   \n";
			strSql += " 					AND BUDG_CODE_NO IN (  \n";
			strSql += " 					SELECT  \n";
			strSql += " 						A.BUDG_CODE_NO  \n";
			strSql += " 					FROM  \n";
			strSql += " 						(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) A  \n";
			strSql += " 					START WITH BUDG_CODE_NO = (  \n";
			strSql += " 						SELECT  \n";
			strSql += " 							A.BUDG_CODE_NO  \n";
			strSql += " 						FROM  \n";
			strSql += " 							(Select * From T_BUDG_CODE Where COMP_CODE =  '"+strCOMP_CODE+"' ) A  \n";
			strSql += " 						WHERE  \n";
			strSql += " 							A.CONTROL_LEVEL_TAG = 'T'  \n";
			strSql += " 							AND A.COMP_CODE =  ?   \n";
			strSql += " 						START WITH A.ACC_CODE =   ?   \n";
			strSql += " 						CONNECT BY  \n";
			strSql += " 						PRIOR A.P_BUDG_CODE_NO = A.BUDG_CODE_NO  \n";
			strSql += " 					)  \n";
			strSql += " 					CONNECT BY  \n";
			strSql += " 					PRIOR A.BUDG_CODE_NO = A.P_BUDG_CODE_NO  \n";
			strSql += " 				)  \n";
			strSql += " 		) C  \n";
			strSql += " 		WHERE  \n";
			strSql += " 			A.COMP_CODE =   ?   \n";
			strSql += " 			AND A.DEPT_CODE = b.DEPT_CODE  \n";
			strSql += " 			AND A.ACC_CODE = c.ACC_CODE  \n";
			strSql += " 			--AND TO_CHAR(A.MAKE_DT, 'YYYYMM') = SUBSTR( BUDG_YM ,1,6)  \n";
			strSql += " 			AND A.MAKE_DT >= F_T_STRINGTODATE( ? ) \n";
			strSql += " 			AND A.MAKE_DT < ADD_MONTHS(F_T_STRINGTODATE( ? ),1) \n";
			strSql += " 	) \n";
			strSql += " ORDER BY \n";
			strSql += " 	A.MAKE_SLIPNO, \n";
			strSql += " 	A.MAKE_SLIPLINE ";
			
			lrArgData.addColumn("1DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("7BUDG_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4ACC_CODE", strACC_CODE);
			lrArgData.setValue("5COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("6BUDG_YM", strBUDG_YM);
			lrArgData.setValue("7BUDG_YM", strBUDG_YM);

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