<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-16)
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
			String strYEAR_BF 	= CITCommon.toKOR(request.getParameter("CLSE_ACC_ID_BF"));
			String strYEAR_NW 	= CITCommon.toKOR(request.getParameter("CLSE_ACC_ID_NW"));
			String strYEAR_AF 	= CITCommon.toKOR(request.getParameter("CLSE_ACC_ID_AF"));
			String strMIN_MM 		= CITCommon.toKOR(request.getParameter("START_MM_MIN"));
			String strMID_MM 		= CITCommon.toKOR(request.getParameter("START_MM_MID"));
			String strMAX_MM		= CITCommon.toKOR(request.getParameter("START_MM_MAX"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strBASE_AMT	= CITCommon.toKOR(request.getParameter("BASE_AMT"));

strSql  = "	Select                                                                                                      \n"; 
strSql += "		y.RN,									--항목상의 분류번호                                                                 \n"; 
strSql += "		y.BIZ_PLAN_ITEM_NO ,	--실제 키                                                                           \n"; 
strSql += "		y.LEVELED_NAME,				--인덴트된 항목명                                                                   \n"; 
strSql += "		SUBSTR(y.LEVELED_NAME,1,2) LEVELED,			--바탕색 구분                                                     \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? Then                                                                    				\n"; 
strSql += "					x.EXEC_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) BF_EXEC_AMT,	--전년실적                                                                                \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.WORK_YM >= ? || '01' And x.WORK_YM < ? || ? Then                           										\n"; 
strSql += "					x.EXEC_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) NW_BM_EXEC_AMT,	--당년 전월까지의 실적                                                                  \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.WORK_YM = ? || ? Then                                                             							\n"; 
strSql += "					x.FORECAST_AMT                                                                                      \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) NW_MIN_FORE_AMT,		--분기 첫 달 예상                                                                   \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.WORK_YM = ? || ? Then                                                             							\n"; 
strSql += "					x.FORECAST_AMT                                                                                      \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) NW_MID_FORE_AMT,		--분기 두번째 달 예상                                                               \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.WORK_YM = ? || ? Then                                                             							\n"; 
strSql += "					x.FORECAST_AMT                                                                                      \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) NW_MAX_FORE_AMT,		--분기 마지막 달 예상                                                               \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? Then                                                                    				\n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) NW_PLAN_AMT,			--당년 계획                                                                           \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM < ? || ? Then                               										\n"; 
strSql += "					x.EXEC_AMT                                                                                          \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM Between ? || ? And ? || ? Then 																	\n"; 
strSql += "					x.FORECAST_AMT                                                                                      \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM > ? || ? Then                               										\n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) NW_FORE_AMT,			--당년 예상                                                                           \n"; 
strSql += "		Nvl(Sum(                                                                                                  \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM < ? || ? Then                               										\n"; 
strSql += "					x.EXEC_AMT                                                                                          \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM Between ? || ? And ? || ? Then 																	\n"; 
strSql += "					x.FORECAST_AMT                                                                                      \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM > ? || ? Then                               										\n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		),0) -                                                                                                    \n"; 
strSql += "		Nvl(Sum(                                                                                                  \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? Then                                                                    \n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		),0) NW_GAP_PLAN_AMT,		--당년 계획비                                                                     \n"; 
strSql += "		Nvl(Sum(                                                                                                  \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM < ? || ? Then                               \n"; 
strSql += "					x.EXEC_AMT                                                                                          \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM Between ? || ? And ? || ? Then \n"; 
strSql += "					x.FORECAST_AMT                                                                                      \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM > ? || ? Then                               \n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		),0) -                                                                                                    \n"; 
strSql += "		Nvl(Sum(                                                                                                  \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? Then                                                                    \n"; 
strSql += "					x.EXEC_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		),0) NW_GAP_BYEAR_AMT,		--당년 전년비                                                                   \n"; 
strSql += "		Sum(                                                                                                      \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? Then                                                                    \n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		) AF_PLAN_AMT,				--후년 계획                                                                         \n"; 
strSql += "		Nvl(Sum(                                                                                                  \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? Then                                                                    \n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		),0) -                                                                                                    \n"; 
strSql += "		Nvl(Sum(                                                                                                  \n"; 
strSql += "			Case                                                                                                    \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM < ? || ? Then                               \n"; 
strSql += "					x.EXEC_AMT                                                                                          \n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM Between ? || ? And ? || ? Then \n"; 
strSql += "					x.FORECAST_AMT																																											\n"; 
strSql += "				When x.CLSE_ACC_ID = ? And  x.WORK_YM > ? || ? Then                               \n"; 
strSql += "					x.PLAN_AMT                                                                                          \n"; 
strSql += "				Else                                                                                                  \n"; 
strSql += "					Null                                                                                                \n"; 
strSql += "			End                                                                                                     \n"; 
strSql += "		),0) AF_GAP_BYEAR_AMT		--후년 계획비                                                                     \n"; 
strSql += "	From	                                                                                                      \n"; 
strSql += "			(                                                                                                       \n"; 
strSql += "				Select                                                                                                \n"; 
strSql += "					x.COMP_CODE ,                                                                                       \n"; 
strSql += "					x.CLSE_ACC_ID ,                                                                                     \n"; 
strSql += "					0 CHG_SEQ ,                                                                                         \n"; 
strSql += "					x.WORK_YM ,                                                                                         \n"; 
strSql += "					x.FLOW_CODE_B BIZ_PLAN_ITEM_NO ,                                                                    \n"; 
strSql += "					x.PLAN_AMT /? PLAN_AMT,                                                                     \n"; 
strSql += "					x.FORECAST_AMT /?  FORECAST_AMT,                                                            \n"; 
strSql += "					x.EXEC_AMT /? EXEC_AMT                                                                      \n"; 
strSql += "				From	T_FL_MONTH_PLAN_EXEC_B x                                                                        \n"; 
strSql += "				Where	x.CLSE_ACC_ID In (?, ?,?)                                                  \n"; 
strSql += "				And		x.COMP_CODE Like ? || '%'                                                              \n"; 
strSql += "			) x,                                                                                                    \n"; 
strSql += "			(                                                                                                       \n"; 
strSql += "				Select                                                                                                \n"; 
strSql += "					a.FLOW_CODE_B BIZ_PLAN_ITEM_NO ,                                                                    \n"; 
strSql += "					a.P_NO ,                                                                                            \n"; 
strSql += "					a.FLOW_ITEM_NAME BIZ_PLAN_ITEM_NAME ,                                                               \n"; 
strSql += "					RPad(' ',(Level - 1)*2)|| a.FLOW_ITEM_NAME LEVELED_NAME,                                            \n"; 
strSql += "					a.MNG_CODE MNG_CODE,                                                                                \n"; 
strSql += "					a.LEVEL_SEQ ITEM_LEVEL_SEQ ,                                                                        \n"; 
strSql += "					RowNum RN                                                                                           \n"; 
strSql += "				From	T_FL_FLOW_CODE_B a                                                                              \n"; 
strSql += "				Connect By                                                                                            \n"; 
strSql += "					Prior	a.FLOW_CODE_B = a.P_NO                                                                        \n"; 
strSql += "				Start With                                                                                            \n"; 
strSql += "					a.P_NO = 0                                                                                          \n"; 
strSql += "				Order Siblings By                                                                                     \n"; 
strSql += "					a.LEVEL_SEQ                                                                                         \n"; 
strSql += "			) y                                                                                                     \n"; 
strSql += "	Where	x.BIZ_PLAN_ITEM_NO (+) = y.BIZ_PLAN_ITEM_NO                                                           \n"; 
strSql += "	Group By                                                                                                    \n"; 
strSql += "		y.RN,                                                                                                     \n"; 
strSql += "		y.BIZ_PLAN_ITEM_NO ,                                                                                      \n"; 
strSql += "		y.LEVELED_NAME,                                                                                           \n"; 
strSql += "		y.BIZ_PLAN_ITEM_NAME                                                                                      \n"; 

lrArgData.addColumn("1YEAR_BF"	, CITData.VARCHAR2);
lrArgData.addColumn("1YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("2YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("1MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("3YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("2MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("4YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("1MID_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("5YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("1MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("6YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("7YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("8YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("3MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("9YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("10YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("4MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("11YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("2MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("12YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("13YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("3MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("14YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("15YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("5MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("16YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("17YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("6MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("18YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("4MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("19YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("20YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("5MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("21YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("22YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("23YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("7MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("24YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("25YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("8MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("26YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("6MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("27YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("28YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("7MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("2YEAR_BF"	, CITData.VARCHAR2);
lrArgData.addColumn("1YEAR_AF"	, CITData.VARCHAR2);
lrArgData.addColumn("2YEAR_AF"	, CITData.VARCHAR2);
lrArgData.addColumn("29YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("30YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("9MIN_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("31YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("32YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("10MIN_MM"	, CITData.VARCHAR2);
lrArgData.addColumn("33YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("8MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("34YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("35YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("9MAX_MM"		, CITData.VARCHAR2);
lrArgData.addColumn("1BASE_AMT"	, CITData.NUMBER);
lrArgData.addColumn("2BASE_AMT"	, CITData.NUMBER);
lrArgData.addColumn("3BASE_AMT"	, CITData.NUMBER);
lrArgData.addColumn("3YEAR_BF"	, CITData.VARCHAR2);
lrArgData.addColumn("36YEAR_NW"	, CITData.VARCHAR2);
lrArgData.addColumn("3YEAR_AF"	, CITData.VARCHAR2);
lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
lrArgData.addRow();
lrArgData.setValue("1YEAR_BF"	, strYEAR_BF);
lrArgData.setValue("1YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("2YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("1MIN_MM"	, strMIN_MM);
lrArgData.setValue("3YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("2MIN_MM"	, strMIN_MM);
lrArgData.setValue("4YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("1MID_MM"	, strMID_MM);
lrArgData.setValue("5YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("1MAX_MM"	, strMAX_MM);
lrArgData.setValue("6YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("7YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("8YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("3MIN_MM"	, strMIN_MM);
lrArgData.setValue("9YEAR_NW"	, strYEAR_NW);
lrArgData.setValue("10YEAR_NW", strYEAR_NW);
lrArgData.setValue("4MIN_MM"	, strMIN_MM);
lrArgData.setValue("11YEAR_NW", strYEAR_NW);
lrArgData.setValue("2MAX_MM"	, strMAX_MM);
lrArgData.setValue("12YEAR_NW", strYEAR_NW);
lrArgData.setValue("13YEAR_NW", strYEAR_NW);
lrArgData.setValue("3MAX_MM"	, strMAX_MM);
lrArgData.setValue("14YEAR_NW", strYEAR_NW);
lrArgData.setValue("15YEAR_NW", strYEAR_NW);
lrArgData.setValue("5MIN_MM"	, strMIN_MM);
lrArgData.setValue("16YEAR_NW", strYEAR_NW);
lrArgData.setValue("17YEAR_NW", strYEAR_NW);
lrArgData.setValue("6MIN_MM"	, strMIN_MM);
lrArgData.setValue("18YEAR_NW", strYEAR_NW);
lrArgData.setValue("4MAX_MM"	, strMAX_MM);
lrArgData.setValue("19YEAR_NW", strYEAR_NW);
lrArgData.setValue("20YEAR_NW", strYEAR_NW);
lrArgData.setValue("5MAX_MM"	, strMAX_MM);
lrArgData.setValue("21YEAR_NW", strYEAR_NW);
lrArgData.setValue("22YEAR_NW", strYEAR_NW);
lrArgData.setValue("23YEAR_NW", strYEAR_NW);
lrArgData.setValue("7MIN_MM"	, strMIN_MM);
lrArgData.setValue("24YEAR_NW", strYEAR_NW);
lrArgData.setValue("25YEAR_NW", strYEAR_NW);
lrArgData.setValue("8MIN_MM"	, strMIN_MM);
lrArgData.setValue("26YEAR_NW", strYEAR_NW);
lrArgData.setValue("6MAX_MM"	, strMAX_MM);
lrArgData.setValue("27YEAR_NW", strYEAR_NW);
lrArgData.setValue("28YEAR_NW", strYEAR_NW);
lrArgData.setValue("7MAX_MM"	, strMAX_MM);
lrArgData.setValue("2YEAR_BF"	, strYEAR_BF);
lrArgData.setValue("1YEAR_AF"	, strYEAR_AF);
lrArgData.setValue("2YEAR_AF"	, strYEAR_AF);
lrArgData.setValue("29YEAR_NW", strYEAR_NW);
lrArgData.setValue("30YEAR_NW", strYEAR_NW);
lrArgData.setValue("9MIN_MM"	, strMIN_MM);
lrArgData.setValue("31YEAR_NW", strYEAR_NW);
lrArgData.setValue("32YEAR_NW", strYEAR_NW);
lrArgData.setValue("10MIN_MM"	, strMIN_MM);
lrArgData.setValue("33YEAR_NW", strYEAR_NW);
lrArgData.setValue("8MAX_MM"	, strMAX_MM);
lrArgData.setValue("34YEAR_NW", strYEAR_NW);
lrArgData.setValue("35YEAR_NW", strYEAR_NW);
lrArgData.setValue("9MAX_MM"	, strMAX_MM);
lrArgData.setValue("1BASE_AMT", strBASE_AMT);
lrArgData.setValue("2BASE_AMT", strBASE_AMT);
lrArgData.setValue("3BASE_AMT", strBASE_AMT);
lrArgData.setValue("3YEAR_BF"	, strYEAR_BF);
lrArgData.setValue("36YEAR_NW", strYEAR_NW);
lrArgData.setValue("3YEAR_AF"	, strYEAR_AF);
lrArgData.setValue("1COMP_CODE",strCOMP_CODE);
			
			try
			{				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setScale("BF_EXEC_AMT" 	  , 4);
				lrReturnData.setScale("BF_BM_EXEC_AMT"	, 4);
				lrReturnData.setScale("NW_BM_PLAN_AMT"	, 4);
				lrReturnData.setScale("NW_BM_EXEC_AMT"	, 4);
				lrReturnData.setScale("NW_BM_GAP_PLAN"	, 4);
				lrReturnData.setScale("NW_BM_GAP_BYEAR"	, 4);
				lrReturnData.setScale("NW_MIN_PLAN_AMT"	, 4);
				lrReturnData.setScale("NW_MIN_FORE_AMT"	, 4);
				lrReturnData.setScale("NW_MID_PLAN_AMT"	, 4);
				lrReturnData.setScale("NW_MID_FORE_AMT"	, 4);
				lrReturnData.setScale("NW_MAX_PLAN_AMT"	, 4);
				lrReturnData.setScale("NW_MAX_FORE_AMT"	, 4);
				lrReturnData.setScale("NW_PLAN_AMT"			, 4);
				lrReturnData.setScale("NW_FORE_AMT"			, 4);
				lrReturnData.setScale("NW_GAP_PLAN_AMT"	, 4);
				lrReturnData.setScale("NW_GAP_BYEAR_AMT", 4);
				lrReturnData.setScale("AF_PLAN_AMT"			, 4);
				lrReturnData.setScale("AF_GAP_BYEAR_AMT", 4);

				
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