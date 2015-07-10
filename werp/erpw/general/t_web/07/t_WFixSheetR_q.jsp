<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
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
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String	strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String	strITEM_NM_CODE = CITCommon.toKOR(request.getParameter("ITEM_NM_CODE"));
			String	strDEPREC_FINISH = CITCommon.toKOR(request.getParameter("DEPREC_FINISH"));
			
			strSql  = " select	 \n";
			strSql += " 		a.FIX_ASSET_SEQ,	--취득 순번 \n";
			strSql += " 		a.ASSET_CLS_CODE,   --자산종류코드 \n";
			strSql += " 		a.ITEM_CODE,		--품목코드 \n";
			strSql += " 		a.ITEM_NM_CODE,		--품명코드 \n";
			strSql += " 		a.FIX_ASSET_NO,		--자산순번 \n";
			strSql += " 		a.ASSET_MNG_NO, 	--자산관리번호 \n";
			strSql += " 		a.COMP_CODE,		--사업장코드 \n";
			//strSql += " 		a.ACC_CODE,			--계정코드 \n";
			strSql += " 		F_T_DATETOSTRING(a.GET_DT)  GET_DT,			--취득일자 \n";
			strSql += " 		a.ASSET_NAME,		--자산명 \n";
			strSql += " 		a.ASSET_SIZE,		--규격 \n";
			strSql += " 		a.PRODUCTION,		--제작회사 \n";
			strSql += " 		to_char(a.CUST_SEQ) CUST_SEQ,			--거래처코드구입처 \n";
			strSql += " 		a.USAGE,				--용도 \n";
			strSql += " 		a.GET_CLS,			--취득구분 \n";
			strSql += " 		a.DEPREC_CLS,		--상각구분 \n";
			strSql += " 		a.SRVLIFE,			--내용년수 \n";
			strSql += " 		a.ASSET_CNT,			--수량 \n";
			strSql += " 		to_char(nvl(a.BASE_AMT,0), '99,999,999,999') BASE_AMT,			--장부가액 \n";
			strSql += " 		to_char(a.OLD_DEPREC_AMT, '99,999,999,999') OLD_DEPREC_AMT,   	--기상각액			   \n";
			strSql += " 		to_char(a.GET_COST_AMT, '99,999,999,999') GET_COST_AMT ,		--취득원가 \n";
			strSql += " 		to_char(a.INC_SUM_AMT, '99,999,999,999')   INC_SUM_AMT,		--증액누계 \n";
			strSql += " 		to_char(a.SUB_SUM_AMT, '99,999,999,999')  SUB_SUM_AMT,		--감액누계 \n";
			strSql += " 		a.NEW_OLD_ASSET,		--신/구자산 \n";
			strSql += " 		a.INCNTRY_OUTCNTRY_CLS,	--국내/해외구분 \n";
			strSql += " 		a.FIXED_CLS,				--고정자산여부 \n";
			strSql += " 		a.FIXTURES_CLS,			--비품여부 \n";
			strSql += " 		a.ETC_ASSET_TAG,			--부외자산여부 \n";
			strSql += " 		a.DISPOSE_YEAR,			--처분년수 \n";
			strSql += " 		a.DEPREC_FINISH,			--상각완료 \n";
			strSql += " 		a.CAPITAL_OUT_AMT,		--자본적지출		   \n";
			strSql += " 		a.GAIN_OUT_AMT,			--수익적지출 \n";
			strSql += " 		a.USE_REMARK,			--사용내역 \n";
			strSql += " 		a.MNG_DEPT_CODE,		--관리부서 \n";
			strSql += " 		a.DEPT_CODE,				--배치부서 \n";
			strSql += " 		a.ITEM_NM_SEQ,			--품명순번 \n";
			strSql += " 		a.CHG_GET_AMT,			--변경취득금액 \n";
			strSql += " 		F_T_DATETOSTRING(a.SALE_DT) SALE_DT,	--폐기매각일자 \n";
			strSql += " 		to_char(a.SLIP_ID) SLIP_ID,				--전표ID  \n";
			strSql += " 		to_char(a.SLIP_IDSEQ) SLIP_IDSEQ,		--전표ID순번 \n";
			strSql += " 		to_char(a.WORK_SEQ) WORK_SEQ,		--작업순번 \n";
			strSql += " 		a.START_ASSET_AMT,	--기초자산가액 \n";
			strSql += " 		a.CURR_ASSET_INC_AMT,--당기자산증가액 \n";
			strSql += " 		a.CURR_ASSET_SUB_AMT,--당기자산감소액 \n";
			strSql += " 		a.START_APPROP_AMT,	 --기초충당금액? \n";
			strSql += " 		a.CURR_APPROP_SUB_AMT,--당기충당금상각액 \n";
			strSql += " 		a.CURR_DEPREC_AMT,	 --당기상각액 \n";
			strSql += " 		a.REMARK,			 --비고 \n";
			strSql += " 		to_char(a.CUST_SEQ2) cust_seq2,			 --견적처 \n";
			strSql += " 		to_char(a.ESTIMATE_AMT1, '99,999,999,999')  ESTIMATE_AMT1,	--견적가 \n";
			strSql += " 		to_char(a.ESTIMATE_AMT2, '99,999,999,999')  ESTIMATE_AMT2,	 --복수견적가 \n";
			strSql += " 		to_char(a.FOREIGN_AMT, '99,999,999,999') FOREIGN_AMT,		 	--외환가격 \n";
			strSql += " 		a.MONEY_CLS,			 --화폐구분 \n";
			//strSql += " 		b.acc_name, \n";
			strSql += " 		c.cust_name,   --거래처 \n";        
			strSql += " 		c2.cust_name est_cust_name, --견적처\n";        
			strSql += " 		F_T_CUST_MASK(c.cust_code) cust_code, \n";
			strSql += " 		F_T_CUST_MASK(c2.cust_code) est_cust_code, \n";
			strSql += " 		d1.dept_name mng_dept_name, \n";
			strSql += " 		d2.dept_name, \n";
			strSql += " 		aa.MAKE_SLIPNO, \n";
			strSql += " 		aa.MAKE_COMP_CODE, \n";
			strSql += " 		aa.MAKE_SEQ, \n";
			strSql += " 		aa.SLIP_KIND_TAG, \n";
			strSql += " 		aa.MAKE_DT_TRANS, \n";
			strSql += " 		aa.MAKE_SLIPCLS \n";
			strSql += " from	T_FIX_SHEET a, \n";
			strSql += " 		T_CUST_CODE c, \n";
			strSql += " 		T_CUST_CODE c2, \n";
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
			strSql += " 		 where code_group_id ='DEPREC_FINISH') e4, \n";
			strSql += " 		(select    code_list_id, \n";
			strSql += " 				code_group_id \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='MONEY_CLS') e5, \n";
			strSql += " 		T_ACC_SLIP_HEAD aa \n";
			strSql += " where		a.cust_seq=c.cust_seq(+) \n";
			strSql += " and		a.cust_seq2=c2.cust_seq(+) \n";
			strSql += " and		a.mng_dept_code=d1.dept_code(+) \n";
			strSql += " and		a.dept_code=d2.dept_code(+) \n";
			strSql += " and		a.GET_CLS = e1.code_list_id(+) \n";
			strSql += " and		a.NEW_OLD_ASSET = e2.code_list_id(+) \n";
			strSql += " and		a.DEPREC_CLS = e3.code_list_id(+) \n";
			strSql += " and		a.DEPREC_FINISH = e4.code_list_id(+) \n";
			strSql += " and		a.MONEY_CLS = e5.code_list_id(+) \n";
			strSql += " And		a.SLIP_ID = aa.SLIP_ID (+) \n";
			strSql += " and		a.comp_code = ? \n";
			strSql += " and		a.asset_cls_code = ? \n";
			strSql += " and		a.item_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.item_nm_code like '%' ||   ?   || '%' \n";
			strSql += " and		nvl(a.deprec_finish,'%')  like '%' ||   ?   || '%' \n";
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
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
		//상각완료구분
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
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","DEPREC_FINISH Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:DEPREC_FINISH Select 오류 -> " + ex.getMessage());
			}
		}
		//취득순번
		else	if (strAct.equals("FIX_ASSET_SEQ"))
		{
			strSql  =  "SELECT SQ_T_FIX_SHEET.NEXTVAL FIX_ASSET_SEQ 		\n";
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
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
			}
		}
		//자산순번
		else	if (strAct.equals("FIX_ASSET_NO"))
		{
			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String	strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String	strITEM_NM_CODE = CITCommon.toKOR(request.getParameter("ITEM_NM_CODE"));

			strSql  = "Select \n";
			strSql  += "	TO_NUMBER(NVL(MAX(a.FIX_ASSET_NO),0) +1) FIX_ASSET_NO \n";
			strSql  += "From	T_FIX_SHEET a \n";
			strSql  += "Where	a.COMP_CODE =  ?  \n";
			strSql  += "And	a.ASSET_CLS_CODE =  ?  \n";
			strSql  += "And	a.ITEM_CODE =  ?  \n";
			strSql  += "And	a.ITEM_NM_CODE =  ? ";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ITEM_NM_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",strCOMP_CODE);
			lrArgData.setValue("ASSET_CLS_CODE",strASSET_CLS_CODE);
			lrArgData.setValue("ITEM_CODE",strITEM_CODE);
			lrArgData.setValue("ITEM_NM_CODE",strITEM_NM_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","FIX_ASSET_NO Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:FIX_ASSET_NO Select 오류 -> " + ex.getMessage());
			}
		}
		//자산복사
		else	if (strAct.equals("FIX_SHEET_COPY"))
		{
			

			strSql  = "Select \n";
			strSql  += "	0 FIX_ASSET_SEQ  \n";
			strSql  += "From	dual \n";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);




				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","FIX_ASSET_NO Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:FIX_ASSET_NO Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE"))
		{

			
			strSql  = " Select 0 FIX_ASSET_SEQ From Dual ";
			

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