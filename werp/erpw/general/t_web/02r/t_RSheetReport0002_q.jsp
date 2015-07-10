<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-12)
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
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			
			strSql  = " SELECT   \n";
			strSql += " 	'F' CHK_CLS,   \n";
			strSql += " 	B.ACC_CODE,   \n";
			strSql += " 	LPAD(' ',(B.ACC_LVL-1)*2)||B.ACC_NAME ACC_NAME,   \n";
			strSql += " 	B.SHRT_CODE,   \n";
			strSql += " 	B.ACC_SHRT_NAME,   \n";
			strSql += " 	B.COMPUTER_ACC,   \n";
			strSql += " 	B.ACC_GRP,   \n";
			strSql += " 	C.ACC_GRP_NAME,   \n";
			strSql += " 	B.ACC_LVL,   \n";
			strSql += " 	D.ACC_LVL_NAME,   \n";
			strSql += " 	B.ACC_REMAIN_POSITION,   \n";
			strSql += " 	E.ACC_REMAIN_POSITION_NAME,   \n";
			strSql += " 	B.FUND_INPUT_CLS   \n";
			strSql += "   FROM   \n";
			strSql += "   (   \n";
			strSql += "   	SELECT   \n";
			strSql += "   		DISTINCT B.PARENT_ACC_CODE ACC_CODE   \n";
			strSql += "   	FROM   \n";
			strSql += "  		T_ACC_SLIP_BODY1 A,  \n";
			strSql += "   		T_ACC_CODE_CHILD2 B,   \n";
			strSql += "   		(  \n";
			strSql += "   			SELECT   \n";
			strSql += "   				DISTINCT CHILD_ACC_CODE ACC_CODE   \n";
			strSql += "   			FROM   \n";
			strSql += "   				T_ACC_CODE_CHILD2 A   \n";
			strSql += "   			WHERE   \n";
			strSql += "   				A.PARENT_ACC_CODE LIKE   ?    || '%'   \n";
			strSql += "   		) C   \n";
			strSql += "   	WHERE   \n";
			strSql += "  		A.ACC_CODE = B.CHILD_ACC_CODE   \n";
			strSql += "   		AND A.ACC_CODE = C.ACC_CODE   \n";
			strSql += "   		AND A.COMP_CODE LIKE   ?   || '%'   \n";
			strSql += "   		AND A.DEPT_CODE LIKE    ?    || '%'   \n";
			strSql += "   		AND   \n";
			strSql += "   		(   \n";
			strSql += "   			(   \n";
			strSql += "   			  	( A.MAKE_DT BETWEEN F_T_StringToDate(  ?  ) AND F_T_StringToDate(  ?  ) )  \n";
			strSql += "   			  	AND   \n";
			strSql += "   				( A.TRANSFER_TAG = 'F' )   \n";
			strSql += "   			)   \n";
			strSql += "   		)   \n";
			strSql += "   		AND A.KEEP_DT IS NOT NULL   \n";
			strSql += "  		AND A.SLIP_KIND_TAG <> 'D'  \n";
			strSql += "   	) A,   \n";
			strSql += "   	T_ACC_CODE B,   \n";
			strSql += "   	(   \n";
			strSql += "   		SELECT   \n";
			strSql += "   			CODE_LIST_ID ACC_GRP,   \n";
			strSql += "   			CODE_LIST_NAME ACC_GRP_NAME   \n";
			strSql += "   		FROM   \n";
			strSql += "   			V_T_CODE_LIST   \n";
			strSql += "   		WHERE   \n";
			strSql += "   			CODE_GROUP_ID = 'ACC_GRP'   \n";
			strSql += "   	) C,   \n";
			strSql += "   	(   \n";
			strSql += "   		SELECT   \n";
			strSql += "   			CODE_LIST_ID ACC_LVL,   \n";
			strSql += "   			CODE_LIST_NAME ACC_LVL_NAME   \n";
			strSql += "   		FROM   \n";
			strSql += "   			V_T_CODE_LIST   \n";
			strSql += "   		WHERE   \n";
			strSql += "   			CODE_GROUP_ID = 'ACC_LVL'   \n";
			strSql += "   	) D,   \n";
			strSql += "   	(   \n";
			strSql += "   		SELECT   \n";
			strSql += "   			CODE_LIST_ID ACC_REMAIN_POSITION,   \n";
			strSql += "   			CODE_LIST_NAME ACC_REMAIN_POSITION_NAME   \n";
			strSql += "   		FROM   \n";
			strSql += "   			V_T_CODE_LIST   \n";
			strSql += "   		WHERE   \n";
			strSql += "   			CODE_GROUP_ID = 'ACC_REMAIN_POSITION'   \n";
			strSql += "   	) E   \n";
			strSql += "   WHERE   \n";
			strSql += "   	A.ACC_CODE = B.ACC_CODE   \n";
			strSql += "   	AND B.ACC_GRP = C.ACC_GRP(+)   \n";
			strSql += "   	AND B.ACC_LVL = D.ACC_LVL(+)   \n";
			strSql += "   	AND B.ACC_REMAIN_POSITION = E.ACC_REMAIN_POSITION(+)   \n";
			strSql += "   ORDER BY   \n";
			strSql += "   	A.ACC_CODE ";
			
			lrArgData.addColumn("1ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("5DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1ACC_CODE", strACC_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("4DT_F", strDT_F);
			lrArgData.setValue("5DT_T", strDT_T);

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