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
			String	strYEAR = CITCommon.toKOR(request.getParameter("YEAR"));
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String	strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String	strDEPREC_DIV = CITCommon.toKOR(request.getParameter("DEPREC_DIV"));
			
			if (strDEPREC_DIV.equals("S")) //실상각
			{
				strSql  = "Select      11 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) )  MM, \n";
				strSql  += "		b.ITEM_CODE, \n";
				strSql  += "		e.item_name, \n";
				strSql  += "		b.ASSET_MNG_NO , \n";
				strSql  += "		b.ASSET_NAME , \n";
				strSql  += "		a.FIX_ASSET_SEQ , \n";
				strSql  += "		a.START_ASSET_AMT , 			-- 기초자산가액 \n";
				strSql  += "		a.CURR_ASSET_INC_AMT ,		-- 당기자산증가 \n";
				strSql  += "		a.CURR_ASSET_SUB_AMT ,		-- 당기자산감소 \n";
				strSql  += "		(a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		a.BEFORE_OLD_DEPREC_AMT ,	-- 기초충당금    \n";
				strSql  += "		a.START_APPROP_AMT , 					 \n";
				strSql  += "		a.CURR_APPROP_SUB_AMT ,		-- 충당금감소액 \n";
				strSql  += "		a.CURR_DEPREC_AMT ,			-- 당기상각액 	 \n";
				strSql  += "		a.DEPREC_RAT , 							 \n";
				strSql  += "		a.BASE_AMT ,					-- 장부가액       \n";
				strSql  += "		a.OLD_DEPREC_AMT ,			-- 충당금누계액 \n";
				strSql  += "		b.GET_COST_AMT				-- 취득원가 	 \n";
				strSql  += "From	T_FIX_SUM a, \n";
				strSql  += "		T_FIX_SHEET b, \n";
				strSql  += "		T_FIX_DEPREC_CAL c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += " union \n";
				strSql  += "Select    12 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) )  MM, \n";
				strSql  += "		b.ITEM_CODE, \n";
				strSql  += "		'' item_name, \n";
				strSql  += "		'' ASSET_MNG_NO , \n";
				strSql  += "		'품목별 합계' ASSET_NAME , \n";
				strSql  += "		0 FIX_ASSET_SEQ , \n";
				strSql  += "		sum(a.START_ASSET_AMT) , 			-- 기초자산가액 \n";
				strSql  += "		sum(a.CURR_ASSET_INC_AMT) ,		-- 당기자산증가 \n";
				strSql  += "		sum(a.CURR_ASSET_SUB_AMT) ,		-- 당기자산감소 \n";
				strSql  += "		sum((a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT)) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		sum(a.BEFORE_OLD_DEPREC_AMT) ,	-- 기초충당금    \n";
				strSql  += "		sum(a.START_APPROP_AMT) , 					 \n";
				strSql  += "		sum(a.CURR_APPROP_SUB_AMT) ,		-- 충당금감소액 \n";
				strSql  += "		sum(a.CURR_DEPREC_AMT) ,			-- 당기상각액 	 \n";
				strSql  += "		sum(a.DEPREC_RAT) , 							 \n";
				strSql  += "		sum(a.BASE_AMT) ,					-- 장부가액       \n";
				strSql  += "		sum(a.OLD_DEPREC_AMT) ,			-- 충당금누계액 \n";
				strSql  += "		sum(b.GET_COST_AMT)			-- 취득원가 	 \n";
				strSql  += "From	T_FIX_SUM a, \n";
				strSql  += "		T_FIX_SHEET b, \n";
				strSql  += "		T_FIX_DEPREC_CAL c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += "group   by TO_CHAR(WORK_FROM_DT,'YYYY'), decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) ) , b.ITEM_CODE\n";
				strSql  += " union \n";
				strSql  += "Select    13 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) )  MM, \n";
				strSql  += "		'' ITEM_CODE, \n";
				strSql  += "		'' item_name, \n";
				strSql  += "		''  ASSET_MNG_NO , \n";
				strSql  += "		'월별 합계' ASSET_NAME , \n";
				strSql  += "		0 FIX_ASSET_SEQ , \n";
				strSql  += "		sum(a.START_ASSET_AMT) , 			-- 기초자산가액 \n";
				strSql  += "		sum(a.CURR_ASSET_INC_AMT) ,		-- 당기자산증가 \n";
				strSql  += "		sum(a.CURR_ASSET_SUB_AMT) ,		-- 당기자산감소 \n";
				strSql  += "		sum((a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT)) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		sum(a.BEFORE_OLD_DEPREC_AMT) ,	-- 기초충당금    \n";
				strSql  += "		sum(a.START_APPROP_AMT) , 					 \n";
				strSql  += "		sum(a.CURR_APPROP_SUB_AMT) ,		-- 충당금감소액 \n";
				strSql  += "		sum(a.CURR_DEPREC_AMT) ,			-- 당기상각액 	 \n";
				strSql  += "		sum(a.DEPREC_RAT) , 							 \n";
				strSql  += "		sum(a.BASE_AMT) ,					-- 장부가액       \n";
				strSql  += "		sum(a.OLD_DEPREC_AMT) ,			-- 충당금누계액 \n";
				strSql  += "		sum(b.GET_COST_AMT)			-- 취득원가 	        \n";
				strSql  += "From	T_FIX_SUM a, \n";
				strSql  += "		T_FIX_SHEET b, \n";
				strSql  += "		T_FIX_DEPREC_CAL c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += " Group  by TO_CHAR(WORK_FROM_DT,'YYYY'), decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) ) \n";
				strSql  += " union \n";
				strSql  += "Select    14 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		''  MM, \n";
				strSql  += "		'' ITEM_CODE, \n";
				strSql  += "		'' item_name, \n";
				strSql  += "		''  ASSET_MNG_NO , \n";
				strSql  += "		'합계' ASSET_NAME , \n";
				strSql  += "		0 FIX_ASSET_SEQ , \n";
				strSql  += "		sum(a.START_ASSET_AMT) , 			-- 기초자산가액 \n";
				strSql  += "		sum(a.CURR_ASSET_INC_AMT) ,		-- 당기자산증가 \n";
				strSql  += "		sum(a.CURR_ASSET_SUB_AMT) ,		-- 당기자산감소 \n";
				strSql  += "		sum((a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT)) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		sum(a.BEFORE_OLD_DEPREC_AMT) ,	-- 기초충당금    \n";
				strSql  += "		sum(a.START_APPROP_AMT) , 					 \n";
				strSql  += "		sum(a.CURR_APPROP_SUB_AMT) ,		-- 충당금감소액 \n";
				strSql  += "		sum(a.CURR_DEPREC_AMT) ,			-- 당기상각액 	 \n";
				strSql  += "		sum(a.DEPREC_RAT) , 							 \n";
				strSql  += "		sum(a.BASE_AMT) ,					-- 장부가액       \n";
				strSql  += "		sum(a.OLD_DEPREC_AMT) ,			-- 충당금누계액 \n";
				strSql  += "		sum(b.GET_COST_AMT)			-- 취득원가 	        \n";
				strSql  += "From	T_FIX_SUM a, \n";
				strSql  += "		T_FIX_SHEET b, \n";
				strSql  += "		T_FIX_DEPREC_CAL c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += " Group  by TO_CHAR(WORK_FROM_DT,'YYYY') \n";
				strSql  += "Order by 2, 3, 4, 1 \n";
			}
			else
			{
				strSql  = "Select      11 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) )  MM, \n";
				strSql  += "		b.ITEM_CODE, \n";
				strSql  += "		e.item_name, \n";
				strSql  += "		b.ASSET_MNG_NO , \n";
				strSql  += "		b.ASSET_NAME , \n";
				strSql  += "		a.FIX_ASSET_SEQ , \n";
				strSql  += "		a.START_ASSET_AMT , 			-- 기초자산가액 \n";
				strSql  += "		a.CURR_ASSET_INC_AMT ,		-- 당기자산증가 \n";
				strSql  += "		a.CURR_ASSET_SUB_AMT ,		-- 당기자산감소 \n";
				strSql  += "		(a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		a.BEFORE_OLD_DEPREC_AMT ,	-- 기초충당금    \n";
				strSql  += "		a.START_APPROP_AMT , 					 \n";
				strSql  += "		a.CURR_APPROP_SUB_AMT ,		-- 충당금감소액 \n";
				strSql  += "		a.CURR_DEPREC_AMT ,			-- 당기상각액 	 \n";
				strSql  += "		a.DEPREC_RAT , 							 \n";
				strSql  += "		a.BASE_AMT ,					-- 장부가액       \n";
				strSql  += "		a.OLD_DEPREC_AMT ,			-- 충당금누계액 \n";
				strSql  += "		b.GET_COST_AMT				-- 취득원가 	 \n";
				strSql  += "From	T_FIX_SUM_TEMP a, \n";
				strSql  += "		T_FIX_SHEET_TEMP b, \n";
				strSql  += "		T_FIX_DEPREC_CAL_TEMP c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL_TEMP  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += " union \n";
				strSql  += "Select    12 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) )  MM, \n";
				strSql  += "		b.ITEM_CODE, \n";
				strSql  += "		'' item_name, \n";
				strSql  += "		'' ASSET_MNG_NO , \n";
				strSql  += "		'품목별 합계' ASSET_NAME , \n";
				strSql  += "		0 FIX_ASSET_SEQ , \n";
				strSql  += "		sum(a.START_ASSET_AMT) , 			-- 기초자산가액 \n";
				strSql  += "		sum(a.CURR_ASSET_INC_AMT) ,		-- 당기자산증가 \n";
				strSql  += "		sum(a.CURR_ASSET_SUB_AMT) ,		-- 당기자산감소 \n";
				strSql  += "		sum((a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT)) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		sum(a.BEFORE_OLD_DEPREC_AMT) ,	-- 기초충당금    \n";
				strSql  += "		sum(a.START_APPROP_AMT) , 					 \n";
				strSql  += "		sum(a.CURR_APPROP_SUB_AMT) ,		-- 충당금감소액 \n";
				strSql  += "		sum(a.CURR_DEPREC_AMT) ,			-- 당기상각액 	 \n";
				strSql  += "		sum(a.DEPREC_RAT) , 							 \n";
				strSql  += "		sum(a.BASE_AMT) ,					-- 장부가액       \n";
				strSql  += "		sum(a.OLD_DEPREC_AMT) ,			-- 충당금누계액 \n";
				strSql  += "		sum(b.GET_COST_AMT)			-- 취득원가 	 \n";
				strSql  += "From	T_FIX_SUM_TEMP a, \n";
				strSql  += "		T_FIX_SHEET_TEMP b, \n";
				strSql  += "		T_FIX_DEPREC_CAL_TEMP c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL_TEMP  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += "group   by TO_CHAR(WORK_FROM_DT,'YYYY'), decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) ) , b.ITEM_CODE\n";
				strSql  += " union \n";
				strSql  += "Select    13 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) )  MM, \n";
				strSql  += "		'' ITEM_CODE, \n";
				strSql  += "		'' item_name, \n";
				strSql  += "		''  ASSET_MNG_NO , \n";
				strSql  += "		'월별 합계' ASSET_NAME , \n";
				strSql  += "		0 FIX_ASSET_SEQ , \n";
				strSql  += "		sum(a.START_ASSET_AMT) , 			-- 기초자산가액 \n";
				strSql  += "		sum(a.CURR_ASSET_INC_AMT) ,		-- 당기자산증가 \n";
				strSql  += "		sum(a.CURR_ASSET_SUB_AMT) ,		-- 당기자산감소 \n";
				strSql  += "		sum((a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT)) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		sum(a.BEFORE_OLD_DEPREC_AMT) ,	-- 기초충당금    \n";
				strSql  += "		sum(a.START_APPROP_AMT) , 					 \n";
				strSql  += "		sum(a.CURR_APPROP_SUB_AMT) ,		-- 충당금감소액 \n";
				strSql  += "		sum(a.CURR_DEPREC_AMT) ,			-- 당기상각액 	 \n";
				strSql  += "		sum(a.DEPREC_RAT) , 							 \n";
				strSql  += "		sum(a.BASE_AMT) ,					-- 장부가액       \n";
				strSql  += "		sum(a.OLD_DEPREC_AMT) ,			-- 충당금누계액 \n";
				strSql  += "		sum(b.GET_COST_AMT)			-- 취득원가 	        \n";
				strSql  += "From	T_FIX_SUM_TEMP a, \n";
				strSql  += "		T_FIX_SHEET_TEMP b, \n";
				strSql  += "		T_FIX_DEPREC_CAL_TEMP c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL_TEMP  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += " Group  by TO_CHAR(WORK_FROM_DT,'YYYY'), decode(TO_CHAR(WORK_FROM_DT,'MM'),'10', '10', '11', '11', '12', '12', substr((TO_CHAR(WORK_FROM_DT,'MM')),2,1) ) \n";
				strSql  += " union \n";
				strSql  += "Select    14 div,\n";
				strSql  += "		TO_CHAR(WORK_FROM_DT,'YYYY'), \n";
				strSql  += "		''  MM, \n";
				strSql  += "		'' ITEM_CODE, \n";
				strSql  += "		'' item_name, \n";
				strSql  += "		''  ASSET_MNG_NO , \n";
				strSql  += "		'합계' ASSET_NAME , \n";
				strSql  += "		0 FIX_ASSET_SEQ , \n";
				strSql  += "		sum(a.START_ASSET_AMT) , 			-- 기초자산가액 \n";
				strSql  += "		sum(a.CURR_ASSET_INC_AMT) ,		-- 당기자산증가 \n";
				strSql  += "		sum(a.CURR_ASSET_SUB_AMT) ,		-- 당기자산감소 \n";
				strSql  += "		sum((a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT)) LAST_AMT ,	-- 기말자산가액 \n";
				strSql  += "		sum(a.BEFORE_OLD_DEPREC_AMT) ,	-- 기초충당금    \n";
				strSql  += "		sum(a.START_APPROP_AMT) , 					 \n";
				strSql  += "		sum(a.CURR_APPROP_SUB_AMT) ,		-- 충당금감소액 \n";
				strSql  += "		sum(a.CURR_DEPREC_AMT) ,			-- 당기상각액 	 \n";
				strSql  += "		sum(a.DEPREC_RAT) , 							 \n";
				strSql  += "		sum(a.BASE_AMT) ,					-- 장부가액       \n";
				strSql  += "		sum(a.OLD_DEPREC_AMT) ,			-- 충당금누계액 \n";
				strSql  += "		sum(b.GET_COST_AMT)			-- 취득원가 	        \n";
				strSql  += "From	T_FIX_SUM_TEMP a, \n";
				strSql  += "		T_FIX_SHEET_TEMP b, \n";
				strSql  += "		T_FIX_DEPREC_CAL_TEMP c,  \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE d, \n";
				strSql  += "		T_FIX_ITEM_CODE e \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	d.ASSET_CLS_CODE = e.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = e.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ in (SELECT WORK_SEQ  \n";
				strSql  += "	   	   			  FROM T_FIX_DEPREC_CAL_TEMP  \n";
				strSql  += "		   			  WHERE TO_CHAR(WORK_FROM_DT,'YYYY') =?)  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like  '%' || ?  || '%' \n";
				strSql  += " Group  by TO_CHAR(WORK_FROM_DT,'YYYY') \n";
				strSql  += "Order by 2, 3, 4, 1 \n";
			}

			lrArgData.addColumn("YEAR",CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("YEAR2",CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE2",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE2",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE2",CITData.VARCHAR2);
			lrArgData.addColumn("YEAR3",CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE3",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE3",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE3",CITData.VARCHAR2);
			lrArgData.addColumn("YEAR4",CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE4",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE4",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE4",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("YEAR",strYEAR);
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("ASSET_CLS_CODE",strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE",strITEM_CODE);
			lrArgData.setValue("YEAR2",strYEAR);
			lrArgData.setValue("COMP_CODE2",strCOMP_CODE);
			lrArgData.setValue("ASSET_CLS_CODE2",strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE2",strITEM_CODE);
			lrArgData.setValue("YEAR3",strYEAR);
			lrArgData.setValue("COMP_CODE3",strCOMP_CODE);
			lrArgData.setValue("ASSET_CLS_CODE3",strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE3",strITEM_CODE);
			lrArgData.setValue("YEAR4",strYEAR);
			lrArgData.setValue("COMP_CODE4",strCOMP_CODE);
			lrArgData.setValue("ASSET_CLS_CODE4",strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE4",strITEM_CODE);
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
		else	if (strAct.equals("ASSET_CLS_CODE"))
		{


			strSql  = "Select  \n";
			strSql  += "	a.ASSET_CLS_CODE ,  \n";
			strSql  += "	a.ASSET_CLS_NAME  \n";
			strSql  += "From	T_FIX_ASSET_CLS_CODE a  \n";
			strSql  += "Order By  \n";
			strSql  += "	a.ASSET_CLS_CODE";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","ASSET_CLS_CODE Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:ASSET_CLS_CODE Select 오류 -> " + ex.getMessage());
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