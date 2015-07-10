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
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));

			String strBANK_CODE = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strMNG_ITEM_CHAR1 = CITCommon.toKOR(request.getParameter("MNG_ITEM_CHAR1"));
			String strMNG_ITEM_CHAR2 = CITCommon.toKOR(request.getParameter("MNG_ITEM_CHAR2"));
			String strMNG_ITEM_CHAR3 = CITCommon.toKOR(request.getParameter("MNG_ITEM_CHAR3"));
			String strMNG_ITEM_CHAR4 = CITCommon.toKOR(request.getParameter("MNG_ITEM_CHAR4"));
			String strMNG_ITEM_NUM1  = CITCommon.toKOR(request.getParameter("MNG_ITEM_NUM1"));
			String strMNG_ITEM_NUM2  = CITCommon.toKOR(request.getParameter("MNG_ITEM_NUM2"));
			String strMNG_ITEM_NUM3  = CITCommon.toKOR(request.getParameter("MNG_ITEM_NUM3"));
			String strMNG_ITEM_NUM4  = CITCommon.toKOR(request.getParameter("MNG_ITEM_NUM4"));
			String strMNG_ITEM_DT1   = CITCommon.toKOR(request.getParameter("MNG_ITEM_DT1"));
			String strMNG_ITEM_DT2   = CITCommon.toKOR(request.getParameter("MNG_ITEM_DT2"));
			String strMNG_ITEM_DT3   = CITCommon.toKOR(request.getParameter("MNG_ITEM_DT3"));
			String strMNG_ITEM_DT4   = CITCommon.toKOR(request.getParameter("MNG_ITEM_DT4"));
			
			strSql  = " SELECT  \n";
			strSql += " 	D.MAKE_COMP_CODE, \n";
			strSql += " 	D.MAKE_DT, \n";
			strSql += " 	D.MAKE_SEQ,  \n";
			strSql += " 	D.MAKE_SLIPNO||'-'||E.MAKE_SLIPLINE MAKE_SLIPNOLINE, \n";
			strSql += " 	D.SLIP_KIND_TAG, \n";
			strSql += "  	B.ACC_GRP,  \n";
			strSql += "  	C.CODE_LIST_NAME ACC_GRP_NAME,  \n";
			strSql += "  	A.ACC_CODE_P,  \n";
			strSql += "  	A.ROW_COLOR,  \n";
			strSql += "  	A.ROW_TYPE,  \n";
			strSql += "  	LPAD(' ',(B.ACC_LVL-1)*2)||B.ACC_NAME  ACC_NAME_P,  \n";
			strSql += " 	CASE  \n";
			strSql += " 		WHEN A.ROW_TYPE  = 'A' AND A.SLIP_ID = 0  THEN '<이전잔액>'  \n";
			strSql += " 		WHEN A.ROW_TYPE  = 'A' THEN F_T_Datetostring(D.MAKE_DT) \n";
			strSql += " 		ELSE '합  계'  \n";
			strSql += " 	END MAKE_DT_P, \n";
			strSql += " 	A.SLIP_ID,  \n";
			strSql += " 	A.SLIP_IDSEQ,  \n";
			strSql += " 	(A.DB_AMT) DB_AMT,  \n";
			strSql += " 	(A.CR_AMT) CR_AMT, \n";
			strSql += " 	H.DEPT_NAME \n";
			strSql += " FROM  \n";
			strSql += " (  \n";
			strSql += "  	SELECT  \n";
			strSql += "  		DISTINCT  \n";
			strSql += "  		A.ACC_CODE1,   \n";
			strSql += "  		A.ACC_CODE2,   \n";
			strSql += "  		A.ACC_CODE3,   \n";
			strSql += "  		A.ACC_CODE4,  \n";
			strSql += "  		A.ACC_CODE5,  \n";
			strSql += "  		A.ACC_CODE6,  \n";
			strSql += "  		CASE  \n";
			strSql += "  			WHEN A.ACC_CODE6  IS NOT NULL THEN A.ACC_CODE6  \n";
			strSql += " 			WHEN A.ACC_CODE5  IS NOT NULL THEN A.ACC_CODE5  \n";
			strSql += " 			WHEN A.ACC_CODE4  IS NOT NULL THEN A.ACC_CODE4  \n";
			strSql += "  			WHEN A.ACC_CODE3  IS NOT NULL THEN A.ACC_CODE3  \n";
			strSql += "  			WHEN A.ACC_CODE2  IS NOT NULL THEN A.ACC_CODE2  \n";
			strSql += "  			WHEN A.ACC_CODE1  IS NOT NULL THEN A.ACC_CODE1  \n";
			strSql += "  		END ACC_CODE_P,  \n";
			strSql += "  		CASE  \n";
			strSql += "  			WHEN B.SLIP_ID    IS NOT NULL THEN 'A'  \n";
			strSql += "  			WHEN A.ACC_CODE6  IS NOT NULL THEN 'B'  \n";
			strSql += " 			WHEN A.ACC_CODE5  IS NOT NULL THEN 'C'  \n";
			strSql += " 			WHEN A.ACC_CODE4  IS NOT NULL THEN 'D'  \n";
			strSql += "  			WHEN A.ACC_CODE3  IS NOT NULL THEN 'E'  \n";
			strSql += "  			WHEN A.ACC_CODE2  IS NOT NULL THEN 'F'  \n";
			strSql += "  			WHEN A.ACC_CODE1  IS NOT NULL THEN 'G'  \n";
			strSql += "  		END ROW_TYPE,  \n";
			strSql += "  		CASE  \n";
			strSql += "  			WHEN A.ACC_CODE6  IS NOT NULL THEN '#FFFFFF'  \n";
			strSql += "  			WHEN A.ACC_CODE5  IS NOT NULL THEN '#FFFFFF'  \n";
			strSql += "  			WHEN A.ACC_CODE4  IS NOT NULL THEN '#EFEEFF'  \n";
			strSql += "  			WHEN A.ACC_CODE3  IS NOT NULL THEN '#D1ECC8'  \n";
			strSql += "  			WHEN A.ACC_CODE2  IS NOT NULL THEN '#D3D3D3'  \n";
			strSql += "  			WHEN A.ACC_CODE1  IS NOT NULL THEN '#BFBEFF'  \n";
			strSql += "  		END ROW_COLOR,  \n";
			strSql += " 		B.MAKE_DT, \n";
			strSql += "  		B.SLIP_ID,  \n";
			strSql += "  		B.SLIP_IDSEQ,  \n";
			strSql += "  		SUM(B.DB_AMT) DB_AMT,  \n";
			strSql += "  		SUM(B.CR_AMT) CR_AMT \n";
			strSql += " 	FROM \n";
			strSql += " 	T_ACC_CODE_TREE A, \n";
			strSql += " 	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			d.ACC_GRP, \n";
			strSql += " 			d.ACC_CODE, \n";
			strSql += " 		 	d.ACC_NAME, \n";
			strSql += " 			A.MAKE_DT, \n";
			strSql += " 			A.SLIP_ID, \n";
			strSql += " 			A.SLIP_IDSEQ, \n";
			strSql += " 			NVL(a.DB_AMT,0) DB_AMT, \n";
			strSql += " 			NVL(a.CR_AMT,0) CR_AMT, \n";
			strSql += " 			CASE  \n";
			strSql += " 				WHEN d.ACC_REMAIN_POSITION = 'D' THEN NVL(a.DB_AMT,0)-NVL(a.CR_AMT,0)		  \n";
			strSql += " 				ELSE NVL(a.CR_AMT,0)-NVL(a.DB_AMT,0) \n";
			strSql += " 			END \n";
			strSql += " 			REMAIN_AMT \n";
			strSql += " 		FROM \n";
			strSql += " 			T_ACC_SLIP_BODY1 A,  \n";
			strSql += " 			T_ACC_SLIP_BODY2 A2,  \n";
			strSql += " 			( \n";
			strSql += " 				SELECT                        \n";
			strSql += " 					DISTINCT B.ACC_CODE \n";
			strSql += " 				FROM \n";
			strSql += " 					T_ACC_CODE_CHILD A, \n";
			strSql += " 					T_ACC_CODE B \n";
			strSql += " 				WHERE \n";
			strSql += " 					B.FUND_INPUT_CLS = 'T' \n";
			strSql += " 					AND A.CHILD_ACC_CODE = B.ACC_CODE \n";
			strSql += " 					AND A.PARENT_ACC_CODE LIKE  ?  || '%' \n";
			strSql += " 				UNION \n";
			strSql += " 				SELECT \n";
			strSql += " 					B.ACC_CODE \n";
			strSql += " 				FROM \n";
			strSql += " 					T_ACC_CODE B \n";
			strSql += " 				WHERE \n";
			strSql += " 					B.FUND_INPUT_CLS = 'T' \n";
			strSql += " 					AND B.ACC_CODE LIKE  ?  || '%' \n";
			strSql += " 			) B, \n";
			strSql += " 			T_CUST_CODE C,  \n";
			strSql += " 			T_ACC_CODE D  \n";
			strSql += " 		WHERE  \n";
			strSql += " 			A.SLIP_ID = A2.SLIP_ID  \n";
			strSql += " 			AND A.SLIP_IDSEQ = A2.SLIP_IDSEQ  \n";
			strSql += " 			AND A.ACC_CODE = B.ACC_CODE \n";
			strSql += " 			AND A.CUST_SEQ = C.CUST_SEQ (+) \n";
			strSql += " 			AND A.ACC_CODE = D.ACC_CODE  \n";
			strSql += " 			AND a.COMP_CODE LIKE  ? ||'%' \n";
			strSql += " 			AND a.DEPT_CODE LIKE  ? ||'%'   \n";
			strSql += " 			AND NVL(c.CUST_CODE,' ') LIKE  ? ||'%' \n";
			strSql += " 			AND  \n";
			strSql += " 			( \n";
			strSql += " 				( \n";
			strSql += " 				  	( A.MAKE_DT BETWEEN F_T_Stringtodate( ? ) AND F_T_Stringtodate( ? ) ) \n";
			strSql += " 				  	AND \n";
			strSql += " 					( A.TRANSFER_TAG = 'F' ) \n";
			strSql += " 				) \n";
			strSql += " 			) \n";
			strSql += " 			AND A.KEEP_DT IS NOT NULL \n";
			strSql += " 			--AND A.SLIP_KIND_TAG <> 'D' \n";
			if(!"".equals(strBANK_CODE))    strSql += " 	AND A.BANK_CODE = ?  \n";
			if(!"".equals(strMNG_ITEM_CHAR1)) strSql += " 	AND A2.MNG_ITEM_CHAR1 = ? \n";
			if(!"".equals(strMNG_ITEM_CHAR2)) strSql += " 	AND A2.MNG_ITEM_CHAR2 = ? \n";
			if(!"".equals(strMNG_ITEM_CHAR3)) strSql += " 	AND A2.MNG_ITEM_CHAR3 = ? \n";
			if(!"".equals(strMNG_ITEM_CHAR4)) strSql += " 	AND A2.MNG_ITEM_CHAR4 = ? \n";
			if(!"".equals(strMNG_ITEM_NUM1))  strSql += " 	AND A2.MNG_ITEM_NUM1 = ? \n";
			if(!"".equals(strMNG_ITEM_NUM2))  strSql += " 	AND A2.MNG_ITEM_NUM2 = ? \n";
			if(!"".equals(strMNG_ITEM_NUM3))  strSql += " 	AND A2.MNG_ITEM_NUM3 = ? \n";
			if(!"".equals(strMNG_ITEM_NUM4))  strSql += " 	AND A2.MNG_ITEM_NUM4 = ? \n";
			if(!"".equals(strMNG_ITEM_DT1))   strSql += " 	AND A2.MNG_ITEM_DT1 = ? \n";
			if(!"".equals(strMNG_ITEM_DT2))   strSql += " 	AND A2.MNG_ITEM_DT2 = ? \n";
			if(!"".equals(strMNG_ITEM_DT3))   strSql += " 	AND A2.MNG_ITEM_DT3 = ? \n";
			if(!"".equals(strMNG_ITEM_DT4))   strSql += " 	AND A2.MNG_ITEM_DT4 = ? \n";
			strSql += " 		ORDER BY \n";
			strSql += " 			ACC_GRP, \n";
			strSql += " 			ACC_CODE, \n";
			strSql += " 			SLIP_ID, \n";
			strSql += " 			SLIP_IDSEQ \n";
			strSql += " 	) B \n";
			strSql += " 	WHERE                                                        \n";
			strSql += " 		a.ACC_CODE = b.ACC_CODE \n";
			strSql += " 	GROUP BY GROUPING SETS \n";
			strSql += " 	( \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1,  \n";
			strSql += " 			A.ACC_CODE2,  \n";
			strSql += " 			A.ACC_CODE3,  \n";
			strSql += " 			A.ACC_CODE4,  \n";
			strSql += " 			A.ACC_CODE5,  \n";
			strSql += " 			A.ACC_CODE6, \n";
			strSql += " 			A.ACC_CODE, \n";
			strSql += " 			B.MAKE_DT, \n";
			strSql += " 			B.SLIP_ID, \n";
			strSql += " 			B.SLIP_IDSEQ \n";
			strSql += " 		), \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1,  \n";
			strSql += " 			A.ACC_CODE2,  \n";
			strSql += " 			A.ACC_CODE3,  \n";
			strSql += " 			A.ACC_CODE4,  \n";
			strSql += " 			A.ACC_CODE5,  \n";
			strSql += " 			A.ACC_CODE6, \n";
			strSql += " 			A.ACC_CODE \n";
			strSql += " 		), \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1,  \n";
			strSql += " 			A.ACC_CODE2,  \n";
			strSql += " 			A.ACC_CODE3,  \n";
			strSql += " 			A.ACC_CODE4,  \n";
			strSql += " 			A.ACC_CODE5,  \n";
			strSql += " 			A.ACC_CODE6 \n";
			strSql += " 		), \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1,  \n";
			strSql += " 			A.ACC_CODE2,  \n";
			strSql += " 			A.ACC_CODE3,  \n";
			strSql += " 			A.ACC_CODE4,  \n";
			strSql += " 			A.ACC_CODE5 \n";
			strSql += " 		), \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1,  \n";
			strSql += " 			A.ACC_CODE2,  \n";
			strSql += " 			A.ACC_CODE3,  \n";
			strSql += " 			A.ACC_CODE4 \n";
			strSql += " 		), \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1,  \n";
			strSql += " 			A.ACC_CODE2,  \n";
			strSql += " 			A.ACC_CODE3 \n";
			strSql += " 		), \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1,  \n";
			strSql += " 			A.ACC_CODE2 \n";
			strSql += " 		), \n";
			strSql += " 		( \n";
			strSql += " 			a.ACC_CODE1 \n";
			strSql += " 		) \n";
			strSql += " 	) \n";
			strSql += " ) A, \n";
			strSql += " T_ACC_CODE B, \n";
			strSql += " ( \n";
			strSql += " 	SELECT \n";
			strSql += " 		CODE_LIST_ID, \n";
			strSql += " 		CODE_LIST_NAME \n";
			strSql += " 	FROM \n";
			strSql += " 		V_T_CODE_LIST \n";
			strSql += " 	WHERE \n";
			strSql += " 		CODE_GROUP_ID = 'ACC_GRP' \n";
			strSql += " ) C, \n";
			strSql += " T_ACC_SLIP_HEAD D,  \n";
			strSql += " T_ACC_SLIP_BODY1 E,  \n";
			strSql += " --T_ACC_SLIP_BODY2 F,  \n";
			strSql += " --T_CUST_CODE G,  \n";
			strSql += " T_DEPT_CODE H --,  \n";
			strSql += " --T_BANK_CODE I  \n";
			strSql += " WHERE \n";
			strSql += " 	A.ACC_CODE_P = B.ACC_CODE \n";
			strSql += " 	AND B.ACC_GRP = C.CODE_LIST_ID \n";
			strSql += " 	AND A.SLIP_ID = D.SLIP_ID(+)  \n";
			strSql += " 	AND A.SLIP_ID = E.SLIP_ID(+)  \n";
			strSql += " 	AND A.SLIP_IDSEQ = E.SLIP_IDSEQ(+)  \n";
			strSql += " 	--AND A.SLIP_ID = F.SLIP_ID(+)  \n";
			strSql += " 	--AND A.SLIP_IDSEQ = F.SLIP_IDSEQ(+)  \n";
			strSql += " 	--AND E.CUST_SEQ=G.CUST_SEQ(+)  \n";
			strSql += " 	AND E.DEPT_CODE=H.DEPT_CODE (+) \n";
			strSql += " 	--AND E.BANK_CODE=I.BANK_CODE(+)  \n";
			strSql += " ORDER BY \n";
			strSql += " 	B.ACC_GRP, \n";
			strSql += " 	a.ACC_CODE1, \n";
			strSql += " 	A.ACC_CODE2, \n";
			strSql += " 	A.ACC_CODE3, \n";
			strSql += " 	A.ACC_CODE4, \n";
			strSql += " 	A.ACC_CODE5, \n";
			strSql += " 	A.ACC_CODE6, \n";
			strSql += " 	A.MAKE_DT, \n";
			strSql += " 	A.SLIP_ID, \n";
			strSql += " 	A.SLIP_IDSEQ ";
			
			lrArgData.addColumn("1ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5CUST_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("7DT_T", CITData.VARCHAR2);
			if(!"".equals(strBANK_CODE))    lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_CHAR1)) lrArgData.addColumn("MNG_ITEM_CHAR1", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_CHAR2)) lrArgData.addColumn("MNG_ITEM_CHAR2", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_CHAR3)) lrArgData.addColumn("MNG_ITEM_CHAR3", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_CHAR4)) lrArgData.addColumn("MNG_ITEM_CHAR4", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_NUM1))  lrArgData.addColumn("MNG_ITEM_NUM1", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_NUM2))  lrArgData.addColumn("MNG_ITEM_NUM2", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_NUM3))  lrArgData.addColumn("MNG_ITEM_NUM3", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_NUM4))  lrArgData.addColumn("MNG_ITEM_NUM4", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_DT1))   lrArgData.addColumn("MNG_ITEM_DT1", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_DT2))   lrArgData.addColumn("MNG_ITEM_DT2", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_DT3))   lrArgData.addColumn("MNG_ITEM_DT3", CITData.VARCHAR2);
			if(!"".equals(strMNG_ITEM_DT4))   lrArgData.addColumn("MNG_ITEM_DT4", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1ACC_CODE", strACC_CODE);
			lrArgData.setValue("2ACC_CODE", strACC_CODE);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("5CUST_CODE", strCUST_CODE);
			lrArgData.setValue("6DT_F", strDT_F);
			lrArgData.setValue("7DT_T", strDT_T);
			if(!"".equals(strBANK_CODE))    lrArgData.setValue("BANK_CODE", strBANK_CODE);
			if(!"".equals(strMNG_ITEM_CHAR1)) lrArgData.setValue("MNG_ITEM_CHAR1", strMNG_ITEM_CHAR1);
			if(!"".equals(strMNG_ITEM_CHAR2)) lrArgData.setValue("MNG_ITEM_CHAR2", strMNG_ITEM_CHAR2);
			if(!"".equals(strMNG_ITEM_CHAR3)) lrArgData.setValue("MNG_ITEM_CHAR3", strMNG_ITEM_CHAR3);
			if(!"".equals(strMNG_ITEM_CHAR4)) lrArgData.setValue("MNG_ITEM_CHAR4", strMNG_ITEM_CHAR4);
			if(!"".equals(strMNG_ITEM_NUM1))  lrArgData.setValue("MNG_ITEM_NUM1", strMNG_ITEM_NUM1);
			if(!"".equals(strMNG_ITEM_NUM2))  lrArgData.setValue("MNG_ITEM_NUM2", strMNG_ITEM_NUM2);
			if(!"".equals(strMNG_ITEM_NUM3))  lrArgData.setValue("MNG_ITEM_NUM3", strMNG_ITEM_NUM3);
			if(!"".equals(strMNG_ITEM_NUM4))  lrArgData.setValue("MNG_ITEM_NUM4", strMNG_ITEM_NUM4);
			if(!"".equals(strMNG_ITEM_DT1))   lrArgData.setValue("MNG_ITEM_DT1", strMNG_ITEM_DT1);
			if(!"".equals(strMNG_ITEM_DT2))   lrArgData.setValue("MNG_ITEM_DT2", strMNG_ITEM_DT2);
			if(!"".equals(strMNG_ITEM_DT3))   lrArgData.setValue("MNG_ITEM_DT3", strMNG_ITEM_DT3);
			if(!"".equals(strMNG_ITEM_DT4))   lrArgData.setValue("MNG_ITEM_DT4", strMNG_ITEM_DT4);

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