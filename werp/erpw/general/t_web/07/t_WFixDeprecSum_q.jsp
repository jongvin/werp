<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 한재원
/* 최초작성일 : 2006-01-20
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/

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
			String	strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strDEPREC_DIV = CITCommon.toKOR(request.getParameter("DEPREC_DIV"));
			if (strDEPREC_DIV.equals("S")) //실상각
			{
				strSql  = "Select \n";
				strSql  += "	k.WORK_SEQ , \n";
				strSql  += "	Sum(k.START_ASSET_AMT) START_ASSET_AMT , 		-- 기초자산가액 \n";
				strSql  += "	Sum(k.CURR_ASSET_INC_AMT) CURR_ASSET_INC_AMT ,		-- 당기자산증가 \n";
				strSql  += "	Sum(k.CURR_ASSET_SUB_AMT) CURR_ASSET_SUB_AMT ,		-- 당기자산감소 \n";
				strSql  += "	Sum(k.LAST_AMT) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "	Sum(k.BEFORE_OLD_DEPREC_AMT) BEFORE_OLD_DEPREC_AMT ,	-- 기초충당금 \n";
				strSql  += "	Sum(k.START_APPROP_AMT) START_APPROP_AMT , \n";
				strSql  += "	Sum(k.CURR_APPROP_SUB_AMT) CURR_APPROP_SUB_AMT ,		-- 충당금감소액 \n";
				strSql  += "	Sum(k.CURR_DEPREC_AMT) CURR_DEPREC_AMT ,			-- 당기상각액 \n";
				strSql  += "	Sum(k.DEPREC_RAT) DEPREC_RAT , \n";
				strSql  += "	Sum(k.BASE_AMT) BASE_AMT ,				-- 장부가액 \n";
				strSql  += "	Sum(k.OLD_DEPREC_AMT) OLD_DEPREC_AMT ,			-- 충당금누계액 \n";
				strSql  += "	Sum(k.GET_COST_AMT) GET_COST_AMT	,			-- 취득원가 \n";
				strSql  += "	k.COMP_CODE , \n";
				//strSql  += "	k.ACC_CODE , \n";
				strSql  += "	k.ASSET_CLS_NAME \n";
				strSql  += "From \n";
				strSql  += "	(Select \n";
				strSql  += "	a.WORK_SEQ , \n";
				strSql  += "	a.START_ASSET_AMT , 			-- 기초자산가액 \n";
				strSql  += "	a.CURR_ASSET_INC_AMT ,		-- 당기자산증가 \n";
				strSql  += "	a.CURR_ASSET_SUB_AMT ,		-- 당기자산감소 \n";
				strSql  += "	(a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "	a.BEFORE_OLD_DEPREC_AMT ,	-- 기초충당금 \n";
				strSql  += "	a.START_APPROP_AMT , \n";
				strSql  += "	a.CURR_APPROP_SUB_AMT ,		-- 충당금감소액 \n";
				strSql  += "	a.CURR_DEPREC_AMT ,			-- 당기상각액 \n";
				strSql  += "	a.DEPREC_RAT , \n";
				strSql  += "	a.BASE_AMT ,					-- 장부가액 \n";
				strSql  += "	a.OLD_DEPREC_AMT ,			-- 충당금누계액 \n";
				strSql  += "	b.GET_COST_AMT	,			-- 취득원가 \n";
				strSql  += "	b.COMP_CODE , \n";
				//strSql  += "	b.ACC_CODE , \n";
				strSql  += "	c.ASSET_CLS_NAME  \n";
				strSql  += "From	T_FIX_SUM a, \n";
				strSql  += "		T_FIX_SHEET b, \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE c \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = c.ASSET_CLS_CODE (+) \n";
				strSql  += "And	a.WORK_SEQ =  ?  \n";
				strSql  += "And	b.COMP_CODE =  ? ) k \n";
				strSql  += "	Group By \n";
				strSql  += "	k.WORK_SEQ , \n";
				strSql  += "	k.COMP_CODE , \n";
				//strSql  += "	k.ACC_CODE , \n";
				strSql  += "	k.ASSET_CLS_NAME \n";
				strSql  += "Order By \n";
				strSql  += "	k.COMP_CODE , \n";
				strSql  += "	k.ASSET_CLS_NAME  \n";
			}
			else
			{
				strSql  = "Select \n";
				strSql  += "	k.WORK_SEQ , \n";
				strSql  += "	Sum(k.START_ASSET_AMT) START_ASSET_AMT , 		-- 기초자산가액 \n";
				strSql  += "	Sum(k.CURR_ASSET_INC_AMT) CURR_ASSET_INC_AMT ,		-- 당기자산증가 \n";
				strSql  += "	Sum(k.CURR_ASSET_SUB_AMT) CURR_ASSET_SUB_AMT ,		-- 당기자산감소 \n";
				strSql  += "	Sum(k.LAST_AMT) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "	Sum(k.BEFORE_OLD_DEPREC_AMT) BEFORE_OLD_DEPREC_AMT ,	-- 기초충당금 \n";
				strSql  += "	Sum(k.START_APPROP_AMT) START_APPROP_AMT , \n";
				strSql  += "	Sum(k.CURR_APPROP_SUB_AMT) CURR_APPROP_SUB_AMT ,		-- 충당금감소액 \n";
				strSql  += "	Sum(k.CURR_DEPREC_AMT) CURR_DEPREC_AMT ,			-- 당기상각액 \n";
				strSql  += "	Sum(k.DEPREC_RAT) DEPREC_RAT , \n";
				strSql  += "	Sum(k.BASE_AMT) BASE_AMT ,				-- 장부가액 \n";
				strSql  += "	Sum(k.OLD_DEPREC_AMT) OLD_DEPREC_AMT ,			-- 충당금누계액 \n";
				strSql  += "	Sum(k.GET_COST_AMT) GET_COST_AMT	,			-- 취득원가 \n";
				strSql  += "	k.COMP_CODE , \n";
				//strSql  += "	k.ACC_CODE , \n";
				strSql  += "	k.ASSET_CLS_NAME \n";
				strSql  += "From \n";
				strSql  += "	(Select \n";
				strSql  += "	a.WORK_SEQ , \n";
				strSql  += "	a.START_ASSET_AMT , 			-- 기초자산가액 \n";
				strSql  += "	a.CURR_ASSET_INC_AMT ,		-- 당기자산증가 \n";
				strSql  += "	a.CURR_ASSET_SUB_AMT ,		-- 당기자산감소 \n";
				strSql  += "	(a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "	a.BEFORE_OLD_DEPREC_AMT ,	-- 기초충당금 \n";
				strSql  += "	a.START_APPROP_AMT , \n";
				strSql  += "	a.CURR_APPROP_SUB_AMT ,		-- 충당금감소액 \n";
				strSql  += "	a.CURR_DEPREC_AMT ,			-- 당기상각액 \n";
				strSql  += "	a.DEPREC_RAT , \n";
				strSql  += "	a.BASE_AMT ,					-- 장부가액 \n";
				strSql  += "	a.OLD_DEPREC_AMT ,			-- 충당금누계액 \n";
				strSql  += "	b.GET_COST_AMT	,			-- 취득원가 \n";
				strSql  += "	b.COMP_CODE , \n";
				//strSql  += "	b.ACC_CODE , \n";
				strSql  += "	c.ASSET_CLS_NAME  \n";
				strSql  += "From	T_FIX_SUM_TEMP a, \n";
				strSql  += "		T_FIX_SHEET_TEMP b, \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE c \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = c.ASSET_CLS_CODE (+) \n";
				strSql  += "And	a.WORK_SEQ =  ?  \n";
				strSql  += "And	b.COMP_CODE =  ? ) k \n";
				strSql  += "	Group By \n";
				strSql  += "	k.WORK_SEQ , \n";
				strSql  += "	k.COMP_CODE , \n";
				//strSql  += "	k.ACC_CODE , \n";
				strSql  += "	k.ASSET_CLS_NAME \n";
				strSql  += "Order By \n";
				strSql  += "	k.COMP_CODE , \n";
				strSql  += "	k.ASSET_CLS_NAME  \n";
			}

			lrArgData.addColumn("WORK_SEQ",CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("WORK_SEQ",strWORK_SEQ);
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setScale("DEPREC_RAT",3);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
			}
		}
		else	if (strAct.equals("DEPREC_FINISH"))
		{


			strSql  = "Select   \n";
			strSql  += "	a.CODE_LIST_ID,   \n";
			strSql  += "	a.CODE_LIST_NAME,   \n";
			strSql  += "	a.SEQ   \n";
			strSql  += "From	V_T_CODE_LIST a   \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'DEPREC_FINISH'   \n";
			strSql  += "And		a.USE_TAG = 'T'   \n";
			strSql  += "Union \n";
			strSql  += "Select \n";
			strSql  += "	'%' , \n";
			strSql  += "	'전체' , \n";
			strSql  += "	-1 \n";
			strSql  += "From	VCC_CODE_LIST a \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'DEPREC_FINISH'   \n";
			strSql  += "Order By   \n";
			strSql  += "	3";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","DEPREC_FINISH Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:DEPREC_FINISH Select 오류 -> " + ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
			 throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>