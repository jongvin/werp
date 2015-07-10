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
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strDEPREC_FINISH = CITCommon.toKOR(request.getParameter("DEPREC_FINISH"));
			String	strWORK_TO_DT = CITCommon.toKOR(request.getParameter("WORK_TO_DT"));
			String	strASSET_NAME = CITCommon.toKOR(request.getParameter("ASSET_NAME"));
			String	strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));

			strSql  = "Select   \n";
			strSql  += "	'F' CHKTAG ,   \n";
			strSql  += "	a.FIX_ASSET_SEQ ,   \n";
			strSql  += "	a.ASSET_MNG_NO ,   \n";
			strSql  += "	a.GET_DT ,   \n";
			strSql  += "	a.ASSET_NAME ,   \n";
			strSql  += "	a.ASSET_SIZE ,   \n";
			strSql  += "	a.DEPREC_CLS ,   \n";
			strSql  += "	a.SRVLIFE ,   \n";
			strSql  += "	a.ASSET_CNT ,   \n";
			strSql  += "	a.BASE_AMT ,   \n";
			strSql  += "	a.OLD_DEPREC_AMT ,   \n";
			strSql  += "	a.GET_COST_AMT ,   \n";
			strSql  += "	a.INC_SUM_AMT ,   \n";
			strSql  += "	a.SUB_SUM_AMT ,   \n";
			strSql  += "	a.NEW_OLD_ASSET ,   \n";
			strSql  += "	a.DISPOSE_YEAR ,   \n";
			strSql  += "	a.DEPREC_FINISH ,   \n";
			strSql  += "	a.CHG_GET_AMT ,   \n";
			strSql  += "	a.SALE_DT ,   \n";
			strSql  += "	a.DEPT_CODE ,   \n";
			strSql  += "	a.WORK_SEQ ,   \n";
			strSql  += "	Decode(a.DEPREC_CLS, '1', b.DEPREC_AMT, '2', b.DEPREC_RAT5) DEPREC_RAT , \n";
			strSql  += "	c.DEPT_NAME  \n";
			strSql  += "From	T_FIX_SHEET_TEMP a ,   \n";
			strSql  += "		T_FIX_DEPREC_RAT b ,  \n";
			strSql  += "		T_DEPT_CODE c  \n";
			strSql  += "Where	a.COMP_CODE =    ?  \n";
			strSql  += "And		a.DEPT_CODE = c.DEPT_CODE (+)  \n";
			strSql  += "And		a.SRVLIFE = b.SRVLIFE (+)   \n";
			strSql  += "And		a.DEPREC_CLS <> '3'   \n";
			//strSql  += "And		a.FIXED_CLS = 'T' \n";  //고정자산 or 무형자산
			strSql  += "And		a.ETC_ASSET_TAG = 'F' \n";
			strSql  += "And		a.DEPREC_FINISH = ? \n"; //완료구분
			strSql  += "And		a.GET_DT <=to_date(?) \n";
			strSql  += "And		a.ASSET_NAME like '%' ||    ?    || '%' \n";
			strSql  += "And		Not Exists \n";
			strSql  += "( \n";
			strSql  += "	Select \n";
			strSql  += "		Null \n";
			strSql  += "	From	T_FIX_SUM_TEMP c \n";
			strSql  += "	Where	c.WORK_SEQ =  ?  \n";
			strSql  += "	And		c.FIX_ASSET_SEQ = a.FIX_ASSET_SEQ \n";
			strSql  += ") \n";
			strSql  += "";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("DEPREC_FINISH",CITData.VARCHAR2);
			lrArgData.addColumn("WORK_TO_DT",CITData.DATE);
			lrArgData.addColumn("ASSET_NAME",CITData.VARCHAR2);
			lrArgData.addColumn("WORK_SEQ",CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("DEPREC_FINISH",strDEPREC_FINISH);
			lrArgData.setValue("WORK_TO_DT",strWORK_TO_DT);
			lrArgData.setValue("ASSET_NAME",strASSET_NAME);
			lrArgData.setValue("WORK_SEQ",strWORK_SEQ);
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