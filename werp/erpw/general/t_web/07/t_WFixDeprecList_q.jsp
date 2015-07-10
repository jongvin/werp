<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : �����
/* �����ۼ��� : 2006-01-20
/* ���������� :
/* ���������� :
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
			String	strWORK_SEQ 	         = CITCommon.toKOR(request.getParameter("WORK_SEQ"));
			String	strCOMP_CODE 	  = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String	strITEM_CODE 	  = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String	strDEPREC_DIV 	  = CITCommon.toKOR(request.getParameter("DEPREC_DIV"));
			
			if (strDEPREC_DIV.equals("S")) //�ǻ�
			{
				strSql  =   "Select 										\n";
				strSql  += "	a.FIX_ASSET_SEQ , 						\n";
				strSql  += "	d.ITEM_NAME, 							\n";
				strSql  += "	a.WORK_SEQ , 							 \n";
				strSql  += "	a.START_ASSET_AMT , 			-- �����ڻ갡�� \n";
				strSql  += "	a.CURR_ASSET_INC_AMT ,		-- ����ڻ����� \n";
				strSql  += "	a.CURR_ASSET_SUB_AMT ,		-- ����ڻ갨�� \n";
				strSql  += "	(a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT) LAST_AMT ,	-- �⸻�ڻ갡�� \n";
				strSql  += "	a.BEFORE_OLD_DEPREC_AMT ,	-- ��������    \n";
				strSql  += "	a.START_APPROP_AMT , 					 \n";
				strSql  += "	a.CURR_APPROP_SUB_AMT ,		-- ���ݰ��Ҿ� \n";
				strSql  += "	a.CURR_DEPREC_AMT ,			-- ���󰢾� 	 \n";
				strSql  += "	a.DEPREC_RAT , 							 \n";
				strSql  += "	a.BASE_AMT ,					-- ��ΰ���       \n";
				strSql  += "	a.OLD_DEPREC_AMT ,			-- ���ݴ���� \n";
				strSql  += "	b.GET_COST_AMT	,			-- ������ 	 \n";
				strSql  += "	b.ASSET_MNG_NO , \n";
				strSql  += "	b.ASSET_NAME , \n";
				strSql  += "	b.COMP_CODE , \n";
				strSql  += "	b.ASSET_CLS_CODE , \n";
				strSql  += "	b.ITEM_CODE , \n";
				strSql  += "	b.ITEM_NM_CODE \n";
				strSql  += "From	T_FIX_SUM a, \n";
				strSql  += "		T_FIX_SHEET b, \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE c, \n";
				strSql  += "		T_FIX_ITEM_CODE d \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				//strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	c.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = d.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ =  ?  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like '%' || ?  || '%' \n";
				strSql  += "Order by 2, 1 ";
			}
			else
			{
				strSql  = "Select \n";
				strSql  += "	a.FIX_ASSET_SEQ , \n";
				strSql  += "	d.ITEM_NAME, \n";
				strSql  += "	a.WORK_SEQ , \n";
				strSql  += "	a.START_ASSET_AMT , 			-- �����ڻ갡�� \n";
				strSql  += "	a.CURR_ASSET_INC_AMT ,		-- ����ڻ����� \n";
				strSql  += "	a.CURR_ASSET_SUB_AMT ,		-- ����ڻ갨�� \n";
				strSql  += "	(a.START_ASSET_AMT + a.CURR_ASSET_INC_AMT - a.CURR_ASSET_SUB_AMT) LAST_AMT ,	-- �⸻�ڻ갡�� \n";
				strSql  += "	a.BEFORE_OLD_DEPREC_AMT ,	-- ��������    \n";
				strSql  += "	a.START_APPROP_AMT , 					 \n";
				strSql  += "	a.CURR_APPROP_SUB_AMT ,		-- ���ݰ��Ҿ� \n";
				strSql  += "	a.CURR_DEPREC_AMT ,			-- ���󰢾� 	 \n";
				strSql  += "	a.DEPREC_RAT , 							 \n";
				strSql  += "	a.BASE_AMT ,					-- ��ΰ���       \n";
				strSql  += "	a.OLD_DEPREC_AMT ,			-- ���ݴ���� \n";
				strSql  += "	b.GET_COST_AMT	,			-- ������ 	 \n";
				strSql  += "	b.ASSET_MNG_NO , \n";
				strSql  += "	b.ASSET_NAME , \n";
				strSql  += "	b.COMP_CODE , \n";
				strSql  += "	b.ASSET_CLS_CODE , \n";
				strSql  += "	b.ITEM_CODE , \n";
				strSql  += "	b.ITEM_NM_CODE \n";
				strSql  += "From	T_FIX_SUM_TEMP a, \n";
				strSql  += "		T_FIX_SHEET_TEMP b, \n";
				strSql  += "		T_FIX_ASSET_CLS_CODE c, \n";
				strSql  += "		T_FIX_ITEM_CODE d \n";
				strSql  += "Where	a.FIX_ASSET_SEQ = b.FIX_ASSET_SEQ \n";
				//strSql  += "And	c.WORK_SEQ = a.WORK_SEQ \n";
				strSql  += "And	b.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	c.ASSET_CLS_CODE = d.ASSET_CLS_CODE  \n";
				strSql  += "And	b.ITEM_CODE = d.ITEM_CODE  \n";
				strSql  += "And	a.WORK_SEQ =  ?  \n";
				strSql  += "And	b.COMP_CODE =  ?  \n";
				strSql  += "And	b.ASSET_CLS_CODE =  ?  \n";
				strSql  += "And	b.ITEM_CODE like '%' || ?  || '%' \n";
				strSql  += "Order by 2, 1 ";
			}

			lrArgData.addColumn("WORK_SEQ",CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("WORK_SEQ",strWORK_SEQ);
			lrArgData.setValue("COMP_CODE",strCOMP_CODE); 
			lrArgData.setValue("ASSET_CLS_CODE",strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE",strITEM_CODE);
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
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
				throw new Exception("USER-900001:MAIN Select ���� -> " + ex.getMessage());
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
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","ASSET_CLS_CODE Select ����-> "+ ex.getMessage());
				throw new Exception("USER-900001:ASSET_CLS_CODE Select ���� -> " + ex.getMessage());
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
			strSql  += "	'��ü' , \n";
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
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","DEPREC_FINISH Select ����-> "+ ex.getMessage());
				throw new Exception("USER-900001:DEPREC_FINISH Select ���� -> " + ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
		throw new Exception("SYS-100001:������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
			 throw new Exception("SYS-100002:������ ���� ���� -> " + ex.getMessage());
		}
	}
%>