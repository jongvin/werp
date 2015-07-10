<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
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
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String	strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String	strITEM_NM_CODE = CITCommon.toKOR(request.getParameter("ITEM_NM_CODE"));
			String	strDEPREC_FINISH = CITCommon.toKOR(request.getParameter("DEPREC_FINISH"));
			
			strSql  = " select	 \n";
			strSql += " 		a.FIX_ASSET_SEQ,	--��� ���� \n";
			strSql += " 		a.ASSET_CLS_CODE,   --�ڻ������ڵ� \n";
			strSql += " 		a.ITEM_CODE,		--ǰ���ڵ� \n";
			strSql += " 		a.ITEM_NM_CODE,		--ǰ���ڵ� \n";
			strSql += " 		a.FIX_ASSET_NO,		--�ڻ���� \n";
			strSql += " 		a.ASSET_MNG_NO, 	--�ڻ������ȣ \n";
			strSql += " 		a.COMP_CODE,		--������ڵ� \n";
			strSql += " 		F_T_DATETOSTRING(a.GET_DT)  GET_DT,			--������� \n";
			strSql += " 		a.ASSET_NAME,		--�ڻ�� \n";
			strSql += " 		a.ASSET_SIZE,		--�԰� \n";
			strSql += " 		a.PRODUCTION,		--����ȸ�� \n";
			strSql += " 		a.CUST_SEQ,			--�ŷ�ó�ڵ屸��ó \n";
			strSql += " 		a.USAGE,				--�뵵 \n";
			strSql += " 		a.GET_CLS,			--��汸�� \n";
			strSql += " 		a.DEPREC_CLS,		--�󰢱��� \n";
			strSql += " 		a.SRVLIFE,			--������ \n";
			strSql += " 		a.ASSET_CNT,			--���� \n";
			strSql += " 		a.BASE_AMT, 			--��ΰ��� \n";
			strSql += " 		a.OLD_DEPREC_AMT,    	--��󰢾�			   \n";
			strSql += " 		a.GET_COST_AMT,  		--������ \n";
			strSql += " 		a.INC_SUM_AMT, 		--���״��� \n";
			strSql += " 		a.SUB_SUM_AMT, 		--���״��� \n";
			strSql += " 		a.NEW_OLD_ASSET,	--��/���ڻ� \n";
			strSql += " 		a.INCNTRY_OUTCNTRY_CLS,--����/�ؿܱ��� \n";
			strSql += " 		a.FIXED_CLS,		--�����ڻ꿩�� \n";
			strSql += " 		a.FIXTURES_CLS,		--��ǰ���� \n";
			strSql += " 		a.ETC_ASSET_TAG,	--�ο��ڻ꿩�� \n";
			strSql += " 		a.DISPOSE_YEAR,		--ó�г�� \n";
			strSql += " 		a.DEPREC_FINISH,	--�󰢿Ϸ� \n";
			strSql += " 		a.CAPITAL_OUT_AMT,	--�ں�������		   \n";
			strSql += " 		a.GAIN_OUT_AMT,		--���������� \n";
			strSql += " 		a.USE_REMARK,		--��볻�� \n";
			strSql += " 		a.MNG_DEPT_CODE,	--�����μ� \n";
			strSql += " 		a.DEPT_CODE,			--��ġ�μ� \n";
			strSql += " 		a.ITEM_NM_SEQ,		--ǰ����� \n";
			strSql += " 		a.CHG_GET_AMT,		--�������ݾ� \n";
			strSql += " 		F_T_DATETOSTRING(a.SALE_DT) SALE_DT,			--���Ű����� \n";
			strSql += " 		to_char(a.SLIP_ID) SLIP_ID,			--��ǥID  \n";
			strSql += " 		to_char(a.SLIP_IDSEQ) SLIP_IDSEQ,		--��ǥID���� \n";
			strSql += " 		to_char(a.WORK_SEQ) WORK_SEQ,			--�۾����� \n";
			strSql += " 		a.START_ASSET_AMT,	--�����ڻ갡�� \n";
			strSql += " 		a.CURR_ASSET_INC_AMT,--����ڻ������� \n";
			strSql += " 		a.CURR_ASSET_SUB_AMT,--����ڻ갨�Ҿ� \n";
			strSql += " 		a.START_APPROP_AMT,	 --�������ݾ�? \n";
			strSql += " 		a.CURR_APPROP_SUB_AMT,--������ݻ󰢾� \n";
			strSql += " 		a.CURR_DEPREC_AMT,	 --���󰢾� \n";
			strSql += " 		a.REMARK,			 --��� \n";
			strSql += " 		c.cust_name, \n";
			strSql += " 		F_T_CUST_MASK(c.cust_code) cust_code, \n";
			strSql += " 		d1.dept_name mng_dept_name, \n";
			strSql += " 		d2.dept_name \n";
			strSql += " from	T_FIX_SHEET_TEMP a, \n";
			strSql += " 		T_CUST_CODE c, \n";
			strSql += " 		T_DEPT_CODE d1, \n";
			strSql += " 		T_DEPT_CODE d2, \n";
			strSql += " 		(select code_list_id, \n";
			strSql += " 				code_group_id \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='GET_CLS') e1, \n";
			strSql += " 		(select code_list_id, \n";
			strSql += " 				code_group_id \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='NEW_OLD_ASSET') e2, \n";
			strSql += " 		(select code_list_id, \n";
			strSql += " 				code_group_id \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='DEPREC_CLS') e3, \n";
			strSql += " 		(select code_list_id, \n";
			strSql += " 				code_group_id \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='DEPREC_FINISH') e4 \n";
			strSql += " where		a.cust_seq=c.cust_seq(+) \n";
			strSql += " and		a.mng_dept_code=d1.dept_code(+) \n";
			strSql += " and		a.dept_code=d2.dept_code(+) \n";
			strSql += " and		a.GET_CLS = e1.code_list_id(+) \n";
			strSql += " and		a.NEW_OLD_ASSET = e2.code_list_id(+) \n";
			strSql += " and		a.DEPREC_CLS = e3.code_list_id(+) \n";
			strSql += " and		a.DEPREC_FINISH = e4.code_list_id(+) \n";
			strSql += " and		a.comp_code = ? \n";
			strSql += " and		a.asset_cls_code = ? \n";
			strSql += " and		a.item_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.item_nm_code like '%' ||   ?   || '%' \n";
			strSql += " and		nvl(a.deprec_finish,'%') like '%' ||   ?   || '%' \n";
			strSql += "Order	By	a.ASSET_MNG_NO ";
			
			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_NM_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("DEPREC_FINISH",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("ASSET_CLS_CODE",strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE",strITEM_CODE);
			lrArgData.setValue("ITEM_NM_CODE",strITEM_NM_CODE);
			lrArgData.setValue("DEPREC_FINISH",strDEPREC_FINISH);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("FIX_ASSET_SEQ", true);
				lrReturnData.setNotNull("ASSET_CLS_CODE", true);
				lrReturnData.setNotNull("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NM_CODE", true);
				lrReturnData.setNotNull("COMP_CODE", true);
				lrReturnData.setNotNull("ACC_CODE", true);
				lrReturnData.setNotNull("GET_DT", true);
				lrReturnData.setNotNull("ASSET_NAME", true);
				lrReturnData.setNotNull("ASSET_CNT", true);
				lrReturnData.setNotNull("BASE_AMT", true);
				lrReturnData.setNotNull("OLD_DEPREC_AMT", true);
				lrReturnData.setNotNull("GET_COST_AMT", true);
				lrReturnData.setNotNull("INC_SUM_AMT", true);
				lrReturnData.setNotNull("SUB_SUM_AMT", true);
				lrReturnData.setNotNull("FIXED_CLS", true);
				lrReturnData.setNotNull("FIXTURES_CLS", true);
				lrReturnData.setNotNull("ETC_ASSET_TAG", true);
				lrReturnData.setNotNull("CAPITAL_OUT_AMT", true);
				lrReturnData.setNotNull("GAIN_OUT_AMT", true);
				lrReturnData.setNotNull("ITEM_NM_SEQ", true);
				lrReturnData.setNotNull("CHG_GET_AMT", true);
				lrReturnData.setNotNull("START_ASSET_AMT", true);
				lrReturnData.setNotNull("CURR_ASSET_INC_AMT", true);
				lrReturnData.setNotNull("CURR_ASSET_SUB_AMT", true);
				lrReturnData.setNotNull("START_APPROP_AMT", true);
				lrReturnData.setNotNull("CURR_APPROP_SUB_AMT", true);
				lrReturnData.setNotNull("CURR_DEPREC_AMT", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("MAIN2"))
		{

			String	strFIX_ASSET_SEQ = CITCommon.toKOR(request.getParameter("FIX_ASSET_SEQ"));
			
			strSql  = " select a.fix_asset_seq, \n";
			strSql += " 	   a.move_seq, \n";
			strSql += " 	   F_T_DATETOSTRING(a.move_dt_from) move_dt_from, \n";
			strSql += " 	   F_T_DATETOSTRING(a.move_dt_to) move_dt_to, \n";
			strSql += " 	   a.dept_code, \n";
			strSql += " 	   a.emp_no, \n";
			strSql += " 	   a.mng_main, \n";
			strSql += " 	   a.mng_sub, \n";
			strSql += " 	   to_char(a.real_move_seq) real_move_seq, \n";
			strSql += " 	   b.dept_name, \n";
			strSql += " 	   c.name emp_nm, \n";
			strSql += " 	   c1.name mng_main_nm, \n";
			strSql += " 	   c2.name mng_sub_nm \n";
			strSql += " from   T_FIX_MOVE_TEMP a, \n";
			strSql += " 	   T_DEPT_CODE b, \n";
			strSql += " 	   Z_AUTHORITY_USER c, \n";
			strSql += " 	   Z_AUTHORITY_USER c1, \n";
			strSql += " 	   Z_AUTHORITY_USER c2 \n";
			strSql += " where  a.dept_code = b.dept_code(+) \n";
			strSql += " and	   a.emp_no	   = c.empno(+) \n";
			strSql += " and	   a.mng_main  = c1.empno(+) \n";
			strSql += " and	   a.mng_sub   = c2.empno(+) \n";
			strSql += " and	   a.fix_asset_seq = ?  \n";
			strSql += " order by real_move_seq desc ";
			
			lrArgData.addColumn("FIX_ASSET_SEQ",CITData.NUMBER);		
			lrArgData.addRow();
			lrArgData.setValue("FIX_ASSET_SEQ", strFIX_ASSET_SEQ);

			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("FIX_ASSET_SEQ", true);
				//lrReturnData.setKey("MOVE_SEQ", true);
				lrReturnData.setKey("MOVE_DT_FROM", true);
				lrReturnData.setNotNull("DEPT_CODE", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN2 Select ����-> "+ ex.getMessage());
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
		//�󰢿Ϸᱸ��
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
			strSql  += "From	V_T_CODE_LIST a \n";
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
		//��������
		else	if (strAct.equals("MOVE_SEQ"))
		{
			strSql  =  "SELECT SQ_T_FIX_MOVE.NEXTVAL MOVE_SEQ 		\n";
			strSql  += "FROM   DUAL ";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

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
		//���ó�¥
		else	if (strAct.equals("CUR_DATE"))
		{
			strSql  =  "SELECT to_char(sysdate,'YYYY-MM-DD') CUR_DATE 		\n";
			strSql  += "FROM   DUAL ";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

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
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>