<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원  작성(2006-03-31)
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
			String strWORK_DT_F = CITCommon.toKOR(request.getParameter("WORK_DT_F"));
			String strWORK_DT_T = CITCommon.toKOR(request.getParameter("WORK_DT_T"));
			
						
			strSql  = " SELECT  \n";
			strSql += " 		a.COMP_CODE, \n";
			strSql += " 		a.WORK_NO, \n";
			strSql += " 		a.CRTUSERNO, \n";
			strSql += " 		a.CRTDATE, \n";
			strSql += " 		a.MODUSERNO, \n";
			strSql += " 		a.MODDATE, \n";
			strSql += " 		TO_CHAR(a.WORK_DT,'YYYY-MM') WORK_DT, \n";
			strSql += " 		a.COST_MAIN_ACC_CODE, \n";
			strSql += " 		b.ACC_NAME COST_MAIN_ACC_NAME, \n";
			strSql += " 		a.OTHER_ACC_CODE, \n";
			strSql += " 		b2.ACC_NAME OTHER_ACC_NAME, \n";
			strSql += " 		To_Char(a.SLIP_ID) SLIP_ID ,  \n";
			strSql += " 		To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 		c.MAKE_SLIPNO, \n";
			strSql += " 		c.MAKE_COMP_CODE, \n";
			strSql += " 		c.MAKE_SEQ, \n";
			strSql += " 		c.SLIP_KIND_TAG, \n";
			strSql += " 		c.MAKE_DT_TRANS,  \n";
			strSql += " 		To_Char(a.R_SLIP_ID) R_SLIP_ID, \n";
			strSql += " 		To_Char(a.R_SLIP_IDSEQ) R_SLIP_IDSEQ, \n";
			strSql += " 		c2.MAKE_SLIPNO MAKE_SLIPNO2, \n";
			strSql += " 		c2.MAKE_COMP_CODE MAKE_COMP_CODE2, \n";
			strSql += " 		c2.MAKE_SEQ MAKE_SEQ2, \n";
			strSql += " 		c2.SLIP_KIND_TAG SLIP_KIND_TAG2, \n";
			strSql += " 		c2.MAKE_DT_TRANS MAKE_DT_TRANS2,  \n";
			strSql += " 		a.REMARKS \n";
			strSql += " FROM    T_SET_PREV_COST a, \n";
			strSql += " 	    T_ACC_CODE b, \n";
			strSql += " 	    T_ACC_CODE b2, \n";
			strSql += " 	    T_ACC_SLIP_HEAD c, \n";
			strSql += " 	    T_ACC_SLIP_HEAD c2 \n";
			strSql += " WHERE   a.COST_MAIN_ACC_CODE = b.ACC_CODE(+) \n";
			strSql += " AND	 a.OTHER_ACC_CODE = b2.ACC_CODE(+) \n";
			strSql += " AND    	 a.SLIP_ID = c.SLIP_ID(+) \n";
			strSql += " AND	 a.R_SLIP_ID = c2.SLIP_ID(+) \n";
			strSql += " AND	 a.COMP_CODE = ? \n";
			strSql += " AND	 (TO_CHAR(a.WORK_DT,'YYYY-MM') >= ?  And TO_CHAR(a.WORK_DT,'YYYY-MM') <= ? ) \n";
			strSql += " Order By  a.WORK_DT,a.WORK_NO \n";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("WORK_DT_F", strWORK_DT_F);
			lrArgData.setValue("WORK_DT_T", strWORK_DT_T);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setNotNull("WORK_DT", true);

				
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
		else if (strAct.equals("WORK_NO"))
		{
			
			strSql  = " Select SQ_T_SET_PREV_COST.NextVal WORK_NO From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","WORK_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("LIST_NO"))
		{
			
			strSql  = " Select SQ_T_SET_PREV_COST_LIST.NextVal LIST_NO From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","LIST_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_SLIP"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXX' COMP_CODE,'XXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE,0 WORK_NO From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","LIST_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE_SLIP"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXX' COMP_CODE,'XXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE,0 WORK_NO From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","LIST_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_NO = CITCommon.toKOR(request.getParameter("WORK_NO"));
			
			strSql  = " SELECT  \n";
			strSql += " 		a.COMP_CODE, \n";
			strSql += " 		a.WORK_NO, \n";
			strSql += " 		a.LIST_NO, \n";
			strSql += " 		a.CRTUSERNO, \n";
			strSql += " 		a.CRTDATE, \n";
			strSql += " 		a.MODUSERNO, \n";
			strSql += " 		a.MODDATE, \n";
			strSql += " 		a.EMP_NO, \n";
			strSql += " 		b.NAME, \n";
			strSql += " 		a.AMT, \n";
			strSql += " 		To_Char(a.SLIP_ID) SLIP_ID ,  \n";
			strSql += " 		To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 		c.MAKE_SLIPNO, \n";
			strSql += " 		c.MAKE_COMP_CODE, \n";
			strSql += " 		c.MAKE_SEQ, \n";
			strSql += " 		c.SLIP_KIND_TAG, \n";
			strSql += " 		c.MAKE_DT_TRANS,  \n";
			strSql += " 		a.REMARKS \n";
			strSql += " FROM 	T_SET_PREV_COST_LIST a, \n";
			strSql += " 		Z_AUTHORITY_USER b, \n";
			strSql += " 		T_ACC_SLIP_HEAD c \n";
			strSql += " WHERE   a.EMP_NO = b.EMPNO(+) \n";
			strSql += " AND	 a.SLIP_ID = c.SLIP_ID(+) \n";
			strSql += " AND	 a.COMP_CODE = ? \n";
			strSql += " AND	a.WORK_NO = ? \n";
			strSql += " ORDER BY WORK_NO, LIST_NO  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("WORK_NO", strWORK_NO);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setKey("LIST_NO", true);
				

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
