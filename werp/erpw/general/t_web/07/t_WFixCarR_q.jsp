<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
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
			strSql += " 		to_char(a.BASE_AMT, '99,999,999,999') BASE_AMT,			--��ΰ��� \n";
			strSql += " 		to_char(a.OLD_DEPREC_AMT, '99,999,999,999') OLD_DEPREC_AMT,   	--��󰢾�			   \n";
			strSql += " 		to_char(a.GET_COST_AMT, '99,999,999,999') GET_COST_AMT ,		--������ \n";
			strSql += " 		to_char(a.INC_SUM_AMT, '99,999,999,999')   INC_SUM_AMT,		--���״��� \n";
			strSql += " 		to_char(a.SUB_SUM_AMT, '99,999,999,999')  SUB_SUM_AMT,		--���״��� \n";
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
			strSql += " 		d2.dept_name, \n";
			strSql += "		e4.name DEPREC_FINISH_NAME, \n";
			strSql += " 		f.fix_asset_seq r_fix_asset_seq, \n";
			strSql += " 		f.car_no, \n";
			strSql += " 		f.car_body_no, \n";
			strSql += " 		f.car_year, \n";
			strSql += " 		f.car_length, \n";
			strSql += " 		f.car_width, \n";
			strSql += " 		f.car_height, \n";
			strSql += " 		f.car_weight, \n";
			strSql += " 		f.car_cc, \n";
			strSql += " 		f.car_cylinder, \n";
			strSql += " 		f.car_form_no, \n";
			strSql += " 		f.car_oil, \n";
			strSql += " 		f.car_use, \n";
			strSql += " 		f.car_user, \n";
			strSql += " 		F_T_DATETOSTRING(f.regular_check_start) regular_check_start, \n";
			strSql += " 		F_T_DATETOSTRING(f.regular_check_end) regular_check_end, \n";
			strSql += " 		f.get_tax, \n";
			strSql += " 		f.reg_tax, \n";
			strSql += " 		f.vat_tax, \n";
			strSql += " 		F_T_DATETOSTRING(f.insurance_start) insurance_start, \n";
			strSql += " 		F_T_DATETOSTRING(f.insurance_end) insurance_end";
			strSql += " from	T_FIX_SHEET a, \n";
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
			strSql += " 			   CODE_LIST_NAME as NAME \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='DEPREC_FINISH') e4, \n";
			strSql += " 		T_FIX_CAR f \n";
			strSql += " where		a.cust_seq=c.cust_seq(+) \n";
			strSql += " and		a.mng_dept_code=d1.dept_code(+) \n";
			strSql += " and		a.dept_code=d2.dept_code(+) \n";
			strSql += " and		a.GET_CLS = e1.code_list_id(+) \n";
			strSql += " and		a.NEW_OLD_ASSET = e2.code_list_id(+) \n";
			strSql += " and		a.DEPREC_CLS = e3.code_list_id(+) \n";
			strSql += " and		a.DEPREC_FINISH = e4.code_list_id(+) \n";
			strSql += " and		a.fix_asset_seq = f.fix_asset_seq \n";
			strSql += " and		a.comp_code = ? \n";
			strSql += " and		a.asset_cls_code = ? \n";
			strSql += " and		a.item_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.item_nm_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.deprec_finish  like '%' ||   ?   || '%' \n";
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