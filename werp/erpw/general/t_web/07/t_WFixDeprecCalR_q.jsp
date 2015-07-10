<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
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
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strWORK_DT_FROM = CITCommon.toKOR(request.getParameter("WORK_DT_FROM"));
			String	strWORK_DT_TO = CITCommon.toKOR(request.getParameter("WORK_DT_TO"));

			strSql  = "Select \n";
			strSql  += "	a.WORK_SEQ , \n";
			strSql  += "	a.CRTUSERNO , \n";
			strSql  += "	a.CRTDATE , \n";
			strSql  += "	a.MODUSERNO , \n";
			strSql  += "	a.MODDATE , \n";
			strSql  += "	a.COMP_CODE , \n";
			strSql  += "	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql  += "	a.WORK_NAME , \n";
			strSql  += "	a.TARGET_CLS , \n";
			//strSql  += "	a.WORK_USENO , \n";
			strSql  += "	to_char(a.WORK_USENO) WORK_USENO , \n";
			strSql  += "	F_T_DATETOSTRING(a.WORK_FROM_DT) WORK_FROM_DT , \n";
			strSql  += "	F_T_DATETOSTRING(a.WORK_TO_DT) WORK_TO_DT , \n";
			strSql  += "	a.TRANS_CLS , \n";
			strSql  += "	a.CAL_CLS , \n";
			strSql  += "	a.REMARK,  \n";
			strSql  += " 	to_char(b.SLIP_ID) SLIP_ID,				--전표ID  \n";
			strSql  += " 	to_char(b.SLIP_IDSEQ) SLIP_IDSEQ,		--전표ID순번 \n";
			strSql += " 	c.MAKE_SLIPNO, \n";
			strSql += " 	c.MAKE_COMP_CODE, \n";
			strSql += " 	c.MAKE_SEQ, \n";
			strSql += " 	c.SLIP_KIND_TAG, \n";
			strSql += " 	c.MAKE_DT_TRANS, \n";
			strSql += " 	c.MAKE_SLIPCLS, \n";
			strSql  += "	d.name   EMP_NM  \n";
			strSql  += "From	T_FIX_DEPREC_CAL a,  \n";
			strSql  += " 	     	(select work_seq, slip_id, \n";
			strSql  += " 	     	 	   count(dept_code) cnt, \n";
			strSql  += " 	     	 	   max(slip_idseq) slip_idseq \n";
			strSql  += " 	     	 from  t_fix_furni_sum  \n";  
			strSql  += " 	     	 group by work_seq, slip_id ) b, \n";
			strSql += " 		T_ACC_SLIP_HEAD c, \n";
			strSql += " 	     	Z_AUTHORITY_USER d  \n";
			strSql  += "Where	a.work_seq = b.work_seq(+)  \n";
			strSql += " and	b.slip_id = c.slip_id(+) \n";
			strSql  += "and	to_char(a.WORK_USENO) = d.empno(+)  \n";
			strSql  += "and	a.COMP_CODE =  ?  \n";
			strSql  += "And	a.WORK_DT Between  ?  And	 ?  ";
			strSql  += "Order By a.WORK_DT desc , a.WORK_SEQ desc ";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("WORK_DT_FROM",CITData.DATE);
			lrArgData.addColumn("WORK_DT_TO",CITData.DATE);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("WORK_DT_FROM",strWORK_DT_FROM);
			lrArgData.setValue("WORK_DT_TO",strWORK_DT_TO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("WORK_SEQ", true);
				lrReturnData.setNotNull("WORK_DT", true);
				lrReturnData.setNotNull("WORK_NAME", true);
				lrReturnData.setNotNull("TARGET_CLS", true);
				lrReturnData.setNotNull("WORK_USENO", true);
				lrReturnData.setNotNull("WORK_FROM_DT", true);
				lrReturnData.setNotNull("WORK_TO_DT", true);

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
		else	if (strAct.equals("MAIN2"))
		{

			String	strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));

			strSql  = "Select \n";
			strSql  += "	a.FIX_ASSET_SEQ , \n";
			strSql  += "	a.WORK_SEQ , \n";
			strSql  += "	a.CRTUSERNO , \n";
			strSql  += "	a.CRTDATE , \n";
			strSql  += "	a.MODUSERNO , \n";
			strSql  += "	a.MODDATE , \n";
			strSql  += "	a.SUM_CNT , \n";
			strSql  += "	a.START_ASSET_AMT , \n";
			strSql  += "	a.CURR_ASSET_INC_AMT , \n";
			strSql  += "	a.CURR_ASSET_SUB_AMT , \n";
			strSql  += "	a.START_APPROP_AMT , \n";
			strSql  += "	a.CURR_APPROP_SUB_AMT , \n";
			strSql  += "	a.CURR_DEPREC_AMT , \n";
			strSql  += "	a.DEPREC_RAT , \n";
			strSql  += "	a.BEFORE_WORK_SEQ , \n";
			strSql  += "	a.BEFORE_BASE_AMT , \n";
			strSql  += "	a.BEFORE_OLD_DEPREC_AMT , \n";
			strSql  += "	a.BEFORE_DEPREC_FINISH , \n";
			strSql  += "	a.BEFORE_INC_SUM_AMT , \n";
			strSql  += "	a.BEFORE_SUB_SUM_AMT , \n";
			strSql  += "	a.BASE_AMT , \n";
			strSql  += "	a.OLD_DEPREC_AMT , \n";
			strSql  += "	a.DEPREC_FINISH , \n";
			strSql  += "	a.INC_SUM_AMT , \n";
			strSql  += "	a.SUB_SUM_AMT , \n";
			strSql  += "	a.BEFORE_ASSET_CNT , \n";
			strSql  += "	b.ASSET_MNG_NO , \n";
			strSql  += "	b.ASSET_NAME \n";
			strSql  += "From	T_FIX_SUM a , \n";
			strSql  += "		T_FIX_SHEET b   \n";
			strSql  += "Where	a.WORK_SEQ = ? \n";
			strSql  += "And		a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ ";

			lrArgData.addColumn("WORK_SEQ",CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("WORK_SEQ",strWORK_SEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setScale("DEPREC_RAT",3);

				lrReturnData.setKey("WORK_SEQ" , true);
				lrReturnData.setKey("FIX_ASSET_SEQ" , true);
				lrReturnData.setNotNull("ASSET_MNG_NO",false);
				lrReturnData.setNotNull("ASSET_NAME",false);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","MAIN2 Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:MAIN2 Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("MAIN3"))
		{

			String	strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));
			String	strFIX_ASSET_SEQ = CITCommon.toKOR(request.getParameter("FIX_ASSET_SEQ"));
			String	strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String	strSUM_DT_FROM = CITCommon.toKOR(request.getParameter("SUM_DT_FROM"));
			String	strSUM_DT_TO = CITCommon.toKOR(request.getParameter("SUM_DT_TO"));
			
			strSql  = " select a.WORK_SEQ, \n";
			strSql += "        a.FIX_ASSET_SEQ, \n";
			strSql += "        b.DEPT_NAME, \n";
			strSql += "        F_T_DATETOSTRING(a.SUM_DT_FROM) SUM_DT_FROM, \n";
			strSql += "        F_T_DATETOSTRING(a.SUM_DT_TO) SUM_DT_TO, \n";
			strSql += "        a.DEPREC_AMT					  \n";
			strSql += " from   T_FIX_FURNI_SUM a,  \n";
			strSql += "        T_DEPT_CODE_ORG b \n";
			strSql += " where  a.dept_code = b.dept_code \n";
			strSql += " and    a.work_seq= ? \n";
			strSql += " and    a.fix_asset_seq = ? \n";
			strSql += " and    a.dept_code like '%' ||  ? || '%' \n";
			if ( !strSUM_DT_FROM.equals("") )
			{
				strSql += " and    a.sum_dt_from between ? and ? \n";
			}
			strSql += " order  by a.dept_code, \n";
			strSql += "           a.sum_dt_from ";
			
			lrArgData.addColumn("WORK_SEQ",CITData.NUMBER);
			lrArgData.addColumn("FIX_ASSET_SEQ",CITData.NUMBER);
			lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
			if ( !strSUM_DT_FROM.equals("") )
			{
				lrArgData.addColumn("SUM_DT_FROM", CITData.DATE);
				lrArgData.addColumn("SUM_DT_TO", CITData.DATE);
			}
			lrArgData.addRow();
			lrArgData.setValue("WORK_SEQ",strWORK_SEQ);
			lrArgData.setValue("FIX_ASSET_SEQ",strFIX_ASSET_SEQ);
			lrArgData.setValue("DEPT_CODE",strDEPT_CODE);
			if ( !strSUM_DT_FROM.equals("") )
			{
				lrArgData.setValue("SUM_DT_FROM", strSUM_DT_FROM);
				lrArgData.setValue("SUM_DT_TO", strSUM_DT_TO);
			}

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("FIX_ASSET_SEQ", true);
				lrReturnData.setKey("SUB_DT_FROM", true);
				lrReturnData.setNotNull("DEPREC_AMT", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN3 Select 오류-> "+ ex.getMessage());
			}
		}
		else	if (strAct.equals("WORK_SEQ"))
		{


			strSql  = "SELECT SQ_T_FIX_DEPREC_CAL.NEXTVAL WORK_SEQ FROM   DUAL \n";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","WORK_SEQ Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:WORK_SEQ Select 오류 -> " + ex.getMessage());
			}
		}
		else	if (strAct.equals("CALC"))
		{


			strSql  = "SELECT -1 WORK_SEQ FROM   DUAL where 1 = 0 \n";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","WORK_SEQ Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:WORK_SEQ Select 오류 -> " + ex.getMessage());
			}
		}
		else	if (strAct.equals("FIX_SHEET"))
		{
			strSql  = "SELECT -1 WORK_SEQ  , Null TRANS_CLS, '###' COMP_CODE, '#######' CLSE_ACC_ID, -1 FIX_ASSET_SEQ  FROM   DUAL where 1 = 0 \n";


			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","TIA_FIX_SHEET Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:TIA_FIX_SHEET Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE"))
		{

			
			strSql  = " Select -1 WORK_SEQ From Dual ";
			

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
				GauceInfo.response.writeException("USER", "900001","REMOVE Select 오류-> "+ ex.getMessage());
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