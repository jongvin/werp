<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 :  한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		if (strAct.equals("MAIN"))
		{

			String	strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String	strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			String	strITEM_NM_CODE = CITCommon.toKOR(request.getParameter("ITEM_NM_CODE"));
			String	strDEPREC_FINISH = CITCommon.toKOR(request.getParameter("DEPREC_FINISH"));
			String      strGET_YEAR = CITCommon.toKOR(request.getParameter("GET_YEAR"));
			String	strFIX_ASSET_SEQ = CITCommon.toKOR(request.getParameter("FIX_ASSET_SEQ"));
			
			String      strDIV = CITCommon.toKOR(request.getParameter("DIV"));
			strSql  = " select	 \n";
			strSql += " 		'F' CHK_CLS,	--구분 \n";
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
			strSql += " 		a.CUST_SEQ,			--거래처코드구입처 \n";
			strSql += " 		a.USAGE,				--용도 \n";
			strSql += " 		a.GET_CLS,			--취득구분 \n";
			strSql += " 		a.DEPREC_CLS,		--상각구분 \n";
			strSql += " 		a.SRVLIFE,			--내용년수 \n";
			strSql += " 		a.ASSET_CNT,			--수량 \n";
			strSql += " 		to_char(nvl(a.BASE_AMT,0), '99,999,999,999') BASE_AMT,			--장부가액 \n";
			strSql += " 		to_char(a.OLD_DEPREC_AMT, '99,999,999,999') OLD_DEPREC_AMT,   	--기상각액			   \n";
			strSql += " 		a.GET_COST_AMT, 		--취득원가 \n";
			strSql += " 		to_char(a.INC_SUM_AMT, '99,999,999,999')   INC_SUM_AMT,		--증액누계 \n";
			strSql += " 		to_char(a.SUB_SUM_AMT, '99,999,999,999')  SUB_SUM_AMT,		--감액누계 \n";
			strSql += " 		a.NEW_OLD_ASSET,	--신/구자산 \n";
			strSql += " 		a.INCNTRY_OUTCNTRY_CLS,--국내/해외구분 \n";
			strSql += " 		a.FIXED_CLS,		--고정자산여부 \n";
			strSql += " 		a.FIXTURES_CLS,		--비품여부 \n";
			strSql += " 		a.ETC_ASSET_TAG,	--부외자산여부 \n";
			strSql += " 		a.DISPOSE_YEAR,		--처분년수 \n";
			strSql += " 		a.DEPREC_FINISH,	--상각완료 \n";
			strSql += " 		a.CAPITAL_OUT_AMT,	--자본적지출		   \n";
			strSql += " 		a.GAIN_OUT_AMT,		--수익적지출 \n";
			strSql += " 		a.USE_REMARK,		--사용내역 \n";
			strSql += " 		a.MNG_DEPT_CODE,	--관리부서 \n";
			strSql += " 		a.DEPT_CODE,			--배치부서 \n";
			strSql += " 		a.ITEM_NM_SEQ,		--품명순번 \n";
			strSql += " 		a.CHG_GET_AMT,		--변경취득금액 \n";
			strSql += " 		F_T_DATETOSTRING(a.SALE_DT) SALE_DT,			--폐기매각일자 \n";
			strSql += " 		to_char(a.SLIP_ID) SLIP_ID,			--전표ID  \n";
			strSql += " 		to_char(a.SLIP_IDSEQ) SLIP_IDSEQ,		--전표ID순번 \n";
			strSql += " 		to_char(a.WORK_SEQ) WORK_SEQ,			--작업순번 \n";
			strSql += " 		c.cust_name, \n";
			strSql += " 		F_T_CUST_MASK(c.cust_code) cust_code, \n";
			strSql += " 		d1.dept_name mng_dept_name, \n";
			strSql += " 		d2.dept_name, \n";
			strSql += " 		f.make_comp_code, \n";
			strSql += " 		F_T_DATETOSTRING(f.make_dt) make_dt, \n";
			strSql += " 		f.make_seq, \n";
			strSql += " 		f.slip_kind_tag, \n";
			strSql += " 		f.make_slipno, \n";
			strSql += " 		vat_amt, \n";
			strSql += " 		' ' chg_tag, \n";
			strSql += " 		0 acc_amt \n";
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
			strSql += " 				code_group_id \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='DEPREC_FINISH') e4, \n";
			strSql += " 		T_ACC_SLIP_HEAD f \n";
			strSql += " where		a.cust_seq=c.cust_seq(+) \n";
			strSql += " and		a.mng_dept_code=d1.dept_code \n";
			strSql += " and		a.dept_code=d2.dept_code \n";
			strSql += " and		a.GET_CLS = e1.code_list_id(+) \n";
			strSql += " and		a.NEW_OLD_ASSET = e2.code_list_id(+) \n";
			strSql += " and		a.DEPREC_CLS = e3.code_list_id(+) \n";
			strSql += " and		a.DEPREC_FINISH = e4.code_list_id(+) \n";
			strSql += " and		a.slip_id = f.slip_id(+) \n";
			//strSql += " and		a.deprec_finish = 1 \n";
			strSql += " and		a.sale_dt is null \n";
			if(strDIV.equals("D"))
			{
			strSql += " and		a.fix_asset_seq =  ?    \n";
			}
			else
			{
			strSql += " and		a.comp_code = ?    \n";
			strSql += " and		a.asset_cls_code =   ?    \n";
			strSql += " and		a.item_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.item_nm_code like '%' ||   ?   || '%' \n";
			strSql += " and		a.deprec_finish  like '%' ||   ?   || '%' \n";
			strSql += " and		to_char(a.get_dt,'YYYY')  =  ?    \n";
			}
			strSql += " and		a.slip_id is null \n";
			strSql += "Order	By	a.fix_asset_seq desc ";
			if(strDIV.equals("D"))
			{
				lrArgData.addColumn("FIX_ASSET_SEQ",CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("FIX_ASSET_SEQ",strFIX_ASSET_SEQ);
			}
			else
			{
				lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("ASSET_CLS_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("ITEM_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("ITEM_NM_CODE",CITData.VARCHAR2);
				lrArgData.addColumn("DEPREC_FINISH",CITData.VARCHAR2);
				lrArgData.addColumn("GET_YEAR",CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("COMP_CODE",strCOMP_CODE);
				lrArgData.setValue("ASSET_CLS_CODE",strASSET_CLS_CODE);
				lrArgData.setValue("ITEM_CODE",strITEM_CODE);
				lrArgData.setValue("ITEM_NM_CODE",strITEM_NM_CODE);
				lrArgData.setValue("DEPREC_FINISH",strDEPREC_FINISH);
				lrArgData.setValue("GET_YEAR",strGET_YEAR);
			}
			
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		if (strAct.equals("MAIN2"))
		{

			String	strFIX_ASSET_SEQ = CITCommon.toKOR(request.getParameter("FIX_ASSET_SEQ"));
			
			strSql  = " select	 \n";
			strSql += " 		'F' CHK_CLS,	--구분 \n";
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
			strSql += " 		a.CUST_SEQ,			--거래처코드구입처 \n";
			strSql += " 		a.USAGE,				--용도 \n";
			strSql += " 		a.GET_CLS,			--취득구분 \n";
			strSql += " 		a.DEPREC_CLS,		--상각구분 \n";
			strSql += " 		a.SRVLIFE,			--내용년수 \n";
			strSql += " 		a.ASSET_CNT,			--수량 \n";
			strSql += " 		to_char(nvl(a.BASE_AMT,0), '99,999,999,999') BASE_AMT,			--장부가액 \n";
			strSql += " 		to_char(a.OLD_DEPREC_AMT, '99,999,999,999') OLD_DEPREC_AMT,   	--기상각액			   \n";
			strSql += " 		a.GET_COST_AMT, 		--취득원가 \n";
			strSql += " 		to_char(a.INC_SUM_AMT, '99,999,999,999')   INC_SUM_AMT,		--증액누계 \n";
			strSql += " 		to_char(a.SUB_SUM_AMT, '99,999,999,999')  SUB_SUM_AMT,		--감액누계 \n";
			strSql += " 		a.NEW_OLD_ASSET,	--신/구자산 \n";
			strSql += " 		a.INCNTRY_OUTCNTRY_CLS,--국내/해외구분 \n";
			strSql += " 		a.FIXED_CLS,		--고정자산여부 \n";
			strSql += " 		a.FIXTURES_CLS,		--비품여부 \n";
			strSql += " 		a.ETC_ASSET_TAG,	--부외자산여부 \n";
			strSql += " 		a.DISPOSE_YEAR,		--처분년수 \n";
			strSql += " 		a.DEPREC_FINISH,	--상각완료 \n";
			strSql += " 		a.CAPITAL_OUT_AMT,	--자본적지출		   \n";
			strSql += " 		a.GAIN_OUT_AMT,		--수익적지출 \n";
			strSql += " 		a.USE_REMARK,		--사용내역 \n";
			strSql += " 		a.MNG_DEPT_CODE,	--관리부서 \n";
			strSql += " 		a.DEPT_CODE,			--배치부서 \n";
			strSql += " 		a.ITEM_NM_SEQ,		--품명순번 \n";
			strSql += " 		a.CHG_GET_AMT,		--변경취득금액 \n";
			strSql += " 		F_T_DATETOSTRING(a.SALE_DT) SALE_DT,			--폐기매각일자 \n";
			strSql += " 		to_char(a.SLIP_ID) SLIP_ID,			--전표ID  \n";
			strSql += " 		to_char(a.SLIP_IDSEQ) SLIP_IDSEQ,		--전표ID순번 \n";
			strSql += " 		to_char(a.WORK_SEQ) WORK_SEQ,			--작업순번 \n";
			strSql += " 		c.cust_name, \n";
			strSql += " 		F_T_CUST_MASK(c.cust_code) cust_code, \n";
			strSql += " 		d1.dept_name mng_dept_name, \n";
			strSql += " 		d2.dept_name, \n";
			strSql += " 		f.make_comp_code, \n";
			strSql += " 		F_T_DATETOSTRING(f.make_dt) make_dt, \n";
			strSql += " 		f.make_seq, \n";
			strSql += " 		f.slip_kind_tag, \n";
			strSql += " 		vat_amt, \n";
			strSql += " 		' ' chg_tag, \n";
			strSql += " 		0 acc_amt \n";
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
			strSql += " 				code_group_id \n";
			strSql += " 		 from V_T_CODE_LIST  \n";
			strSql += " 		 where code_group_id ='DEPREC_FINISH') e4, \n";
			strSql += " 		T_ACC_SLIP_HEAD f \n";
			strSql += " where		a.cust_seq=c.cust_seq(+) \n";
			strSql += " and		a.mng_dept_code=d1.dept_code \n";
			strSql += " and		a.dept_code=d2.dept_code \n";
			strSql += " and		a.GET_CLS = e1.code_list_id(+) \n";
			strSql += " and		a.NEW_OLD_ASSET = e2.code_list_id(+) \n";
			strSql += " and		a.DEPREC_CLS = e3.code_list_id(+) \n";
			strSql += " and		a.DEPREC_FINISH = e4.code_list_id(+) \n";
			strSql += " and		a.slip_id = f.slip_id(+) \n";
			//strSql += " and		a.deprec_finish = 1 \n";
			strSql += " and		a.sale_dt is null \n";
			strSql += " and		a.fix_asset_seq = ? \n";
			
			lrArgData.addColumn("FIX_ASSET_SEQ",CITData.NUMBER);

			lrArgData.addRow();
			
			lrArgData.setValue("FIX_ASSET_SEQ",strFIX_ASSET_SEQ);

			
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
		
		if (strAct.equals("MAIN01"))
		{			
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DEPT_CODE = CITCommon.toKOR(request.getParameter("MAKE_DEPT_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			String strEXPR_DT_F = CITCommon.toKOR(request.getParameter("EXPR_DT_F"));
			String strEXPR_DT_T = CITCommon.toKOR(request.getParameter("EXPR_DT_T"));
			
			
			strSql  = " SELECT \n";
			strSql += " 	'F' CHK_CLS ,  \n";
			strSql += " 	b.SLIP_ID ,  \n";
			strSql += " 	b.SLIP_IDSEQ , \n";
			strSql += " 	b.ACC_CODE ,  \n";
			strSql += " 	b.ACC_NAME ,  \n";
			strSql += " 	b.ACC_REMAIN_POSITION ,  \n";
			strSql += " 	C.NAME ACC_REMAIN_POSITION_NAME ,   \n";
			strSql += " 	b.CUST_SEQ ,  \n";
			strSql += " 	b.CUST_CODE ,  \n";
			strSql += " 	b.CUST_NAME ,   \n";
			strSql += " 	A.SET_AMT, \n";
			strSql += " 	A.RESET_AMT,  \n";
			strSql += " 	A.NOT_RESET_AMT, \n";
			strSql += " 	A.SET_AMT - A.RESET_AMT REMAIN_AMT, \n";
			strSql += " 	0 INPUT_AMT, \n";
			strSql += " 	b.MAKE_SLIPNO||'-'||b.MAKE_SLIPLINE MAKE_SLIPNOLINE, \n";
			strSql += " 	b.SUMMARY1, \n";
			strSql += " 	-- 전표조회 인자 \n";
			strSql += " 	b.MAKE_COMP_CODE ,  \n";
			strSql += " 	F_T_DateToString(b.MAKE_DT) MAKE_DT,  \n";
			strSql += " 	b.MAKE_SEQ ,  \n";
			strSql += " 	b.SLIP_KIND_TAG,  \n";
			strSql += " 	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT \n";
			strSql += " FROM \n";
			strSql += " ( \n";
			strSql += " 	SELECT  \n";
			strSql += " 		X.SLIP_ID ,  \n";
			strSql += " 		X.SLIP_IDSEQ ,  \n";
			strSql += " 		X.EXPR_DT , \n";
			strSql += " 		SUM(X.SET_AMT) SET_AMT,  \n";
			strSql += " 		SUM(X.RESET_AMT) RESET_AMT,  \n";
			strSql += " 		SUM(X.NOT_RESET_AMT) NOT_RESET_AMT \n";
			strSql += " 	FROM  \n";
			strSql += " 		( \n";
			strSql += " 			SELECT  \n";
			strSql += " 				A.SLIP_ID ,  \n";
			strSql += " 				A.SLIP_IDSEQ, \n";
			strSql += " 				E.EXPR_DT , \n";
			strSql += " 				CASE -- 설정 \n";
			strSql += " 					WHEN (A.SLIP_ID = B.SLIP_ID) AND (A.SLIP_IDSEQ = B.SLIP_IDSEQ) THEN  \n";
			strSql += " 						NVL( \n";
			strSql += " 							( \n";
			strSql += " 							DECODE(D.ACC_REMAIN_POSITION, 'D', 1, 0)*B.DB_AMT \n";
			strSql += " 							+ \n";
			strSql += " 							DECODE(D.ACC_REMAIN_POSITION, 'C', 1, 0)*B.CR_AMT \n";
			strSql += " 							) \n";
			strSql += " 						,0) \n";
			strSql += " 					ELSE \n";
			strSql += " 						0 \n";
			strSql += " 				END SET_AMT, \n";
			strSql += " 				CASE \n";
			strSql += " 					WHEN ((A.SLIP_ID <> B.SLIP_ID) OR (A.SLIP_IDSEQ <> B.SLIP_IDSEQ)) AND A.KEEP_DT IS NOT NULL THEN  \n";
			strSql += " 						NVL( \n";
			strSql += " 							( \n";
			strSql += " 							DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*B.DB_AMT \n";
			strSql += " 							+ \n";
			strSql += " 							DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*B.CR_AMT \n";
			strSql += " 							) \n";
			strSql += " 						,0) \n";
			strSql += " 					ELSE \n";
			strSql += " 						0 \n";
			strSql += " 				END RESET_AMT, \n";
			strSql += " 				CASE \n";
			strSql += " 					WHEN ((A.SLIP_ID <> B.SLIP_ID) OR (A.SLIP_IDSEQ <> B.SLIP_IDSEQ)) AND A.KEEP_DT IS NULL THEN  \n";
			strSql += " 						NVL( \n";
			strSql += " 							( \n";
			strSql += " 							DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*B.DB_AMT \n";
			strSql += " 							+ \n";
			strSql += " 							DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*B.CR_AMT \n";
			strSql += " 							) \n";
			strSql += " 						,0) \n";
			strSql += " 					ELSE \n";
			strSql += " 						0 \n";
			strSql += " 				END NOT_RESET_AMT \n";
			strSql += " 			FROM \n";
			strSql += " 				T_ACC_SLIP_BODY1 A,  \n";
			strSql += " 				T_ACC_SLIP_BODY1 B, \n";
			strSql += " 				T_CUST_CODE C, \n";
			strSql += " 				T_ACC_CODE D, \n";
			strSql += " 				T_FIN_RECEIVE_CHK_BILL E \n";
			strSql += " 			WHERE \n";
			strSql += " 				A.SLIP_ID = A.RESET_SLIP_ID  \n";
			strSql += " 				AND	A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ  \n";
			strSql += " 				AND	A.SLIP_ID = B.RESET_SLIP_ID (+) \n";
			strSql += " 				AND	A.SLIP_IDSEQ = B.RESET_SLIP_IDSEQ (+) \n";
			strSql += " 				AND	A.CUST_SEQ = C.CUST_SEQ  \n";
			strSql += " 				AND	A.ACC_CODE = D.ACC_CODE \n";
			strSql += " 				AND	A.SLIP_ID = E.SLIP_ID  \n";
			strSql += " 				AND	A.SLIP_IDSEQ = E.SLIP_IDSEQ  \n";
			strSql += " 				AND	A.KEEP_DT IS NOT NULL \n";
			strSql += " 				AND	A.MAKE_COMP_CODE =  ?   \n";
			strSql += " 				AND	A.MAKE_DEPT_CODE  LIKE  ?   || '%' \n";
			strSql += " 				AND	A.COMP_CODE =  ?   \n";
			strSql += " 				AND	A.DEPT_CODE  LIKE  ?   || '%' \n";
			strSql += " 				AND	A.MAKE_DT BETWEEN F_T_STRINGTODATE( ? ) AND F_T_STRINGTODATE( ? ) \n";
			strSql += " 				AND	A.ACC_CODE LIKE  ?   || '%'  \n";
			/*
			strSql += " 				AND	A.ACC_CODE IN  \n";
			strSql += "				( \n";
			strSql += "					SELECT  \n";
			strSql += "						CHILD_ACC_CODE \n";
			strSql += "					FROM  \n";
			strSql += "						T_ACC_CODE_CHILD \n";
			strSql += "					WHERE  \n";
			strSql += "						PARENT_ACC_CODE = ? \n";
			strSql += "				) \n";
			*/
			strSql += " 				AND	C.CUST_CODE LIKE  ?   || '%' \n";
			strSql += " 				AND	E.EXPR_DT BETWEEN F_T_Stringtodate( ? ) AND F_T_Stringtodate( ? )  \n";
			//strSql += " 				AND D.Acc_REMAIN_MNG = 'T' \n";
			//strSql += " 				AND D.CHK_NO_MNG = 'F' \n";
			//strSql += " 				AND D.BILL_NO_MNG = 'F' \n";
			strSql += " 				AND D.REC_BILL_NO_MNG = 'T' \n";
			//strSql += " 				AND D.CP_NO_MNG = 'F' \n";
			//strSql += " 				AND D.SECU_MNG = 'F' \n";
			//strSql += " 				AND D.LOAN_NO_MNG = 'F' \n";
			//strSql += " 				AND D.FIXED_MNG = 'F' \n";
			//strSql += " 				AND D.BILL_EXPR_MNG = 'F' \n";
			strSql += " 		) X	 \n";
			strSql += " 	HAVING	SUM(X.SET_AMT) - SUM(X.RESET_AMT) > 0  \n";
			strSql += " 	GROUP BY  \n";
			strSql += " 		X.SLIP_ID ,  \n";
			strSql += " 		X.SLIP_IDSEQ,  \n";
			strSql += " 		X.EXPR_DT \n";
			strSql += " ) A, \n";
			strSql += " T_ACC_SLIP_VIEW B,  \n";
			strSql += " (  \n";
			strSql += "	 SELECT  \n";
			strSql += "		a.CODE_LIST_ID AS CODE,  \n";
			strSql += "		a.CODE_LIST_NAME AS NAME  \n";
			strSql += "	FROM  \n";
			strSql += "		V_T_CODE_LIST a  \n";
			strSql += "	WHERE  \n";
			strSql += "		a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION'  \n";
			strSql += " ) C  \n";
			strSql += " WHERE  \n";
			strSql += " 	A.SLIP_ID = B.SLIP_ID  \n";
			strSql += " 	AND	A.SLIP_IDSEQ = B.SLIP_IDSEQ \n";
			strSql += " 	AND	B.ACC_REMAIN_POSITION = C.CODE \n";
	
			lrArgData.addColumn("1MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("6DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("7ACC_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8CUST_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9EXPR_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("10EXPR_DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("2MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("5DT_F", strDT_F);
			lrArgData.setValue("6DT_T", strDT_T);
			lrArgData.setValue("7ACC_CODE", strACC_CODE);
			lrArgData.setValue("8CUST_CODE", strCUST_CODE);
			lrArgData.setValue("9EXPR_DT_F", strEXPR_DT_F);
			lrArgData.setValue("10EXPR_DT_T", strEXPR_DT_T);
			

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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}

		}
		//발의 번호 순번
		else if (strAct.equals("MAKE_SEQ"))
		{
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DT_TRANS = CITCommon.toKOR(request.getParameter("MAKE_DT_TRANS"));
			
			strSql  = " Select F_T_GET_NEW_MAKE_SEQ(?,?) MAKE_SEQ	From DUAL ";
			
			lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DT_TRANS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("MAKE_DT_TRANS", strMAKE_DT_TRANS);

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
				GauceInfo.response.writeException("USER", "900001","MAKE_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		
		else if (strAct.equals("WORK_SLIP_IDSEQ"))
		{
			String strGET_TYPE = CITCommon.toKOR(request.getParameter("GET_TYPE"));
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			if("NEW".equals(strGET_TYPE)) {
				strSql  = " Select SQ_T_WORK_SLIP_ID.NEXTVAL WORK_SLIP_ID, SQ_T_WORK_SLIP_IDSEQ.NEXTVAL WORK_SLIP_IDSEQ From DUAL ";
			} else if("CUR".equals(strGET_TYPE)) {
				strSql  = " Select \n";
				strSql += " 	NVL(B.SLIP_ID,0) WORK_SLIP_ID, \n";
				strSql += " 	NVL(B.SLIP_IDSEQ,0) WORK_SLIP_IDSEQ \n";
				strSql += " From DUAL A, \n";
				strSql += " ( \n";
				strSql += " 	Select ROWNUM RN \n";
				strSql += " 	From DUAL \n";
				strSql += " ) A, \n";
				strSql += " ( \n";
				strSql += " 	SELECT ROWNUM RN, SLIP_ID, SLIP_IDSEQ \n";
				strSql += " 	FROM T_WORK_ACC_SLIP_BODY \n";
				strSql += " 	WHERE \n";
				strSql += " 		WORK_CODE =  ?  \n";
				strSql += " 		AND DEPT_CODE =  ?  \n";
				strSql += " 		AND CRTDATE = ( \n";
				strSql += " 			SELECT MAX(CRTDATE) \n";
				strSql += " 			FROM T_WORK_ACC_SLIP_BODY \n";
				strSql += " 			WHERE \n";
				strSql += " 				WORK_CODE =  ?  \n";
				strSql += " 				AND DEPT_CODE =  ?  \n";
				strSql += " 		) \n";
				strSql += " ) B \n";
				strSql += " WHERE \n";
				strSql += " 	A.RN = B.RN(+) ";
				
				lrArgData.addColumn("1WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("2DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("3WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1WORK_CODE", strWORK_CODE);
				lrArgData.setValue("2DEPT_CODE", strDEPT_CODE);
				lrArgData.setValue("3WORK_CODE", strWORK_CODE);
				lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			} else {
			}

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
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("AUTO_BILL_FIX_GET_SEQ"))
		{
			strSql  = " Select SQ_T_AUTO_B_F_GET.NEXTVAL AUTO_BILL_FIX_GET_SEQ From DUAL ";
                     
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
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("NEW_WORK_SLIP"))
		{
			String strWORK_SLIP_ID = CITCommon.toKOR(request.getParameter("WORK_SLIP_ID"));
			String strWORK_SLIP_IDSEQ = CITCommon.toKOR(request.getParameter("WORK_SLIP_IDSEQ"));
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));

			try
			{
				strSql = "{call SP_T_WORK_ACC_SLIP_BODY_EMY_I(?,?,?,?,?)}";
				
				lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
				lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
				lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("SLIP_ID", strWORK_SLIP_ID);
				lrArgData.setValue("SLIP_IDSEQ", strWORK_SLIP_IDSEQ);
				lrArgData.setValue("CRTUSERNO", strUserNo);
				lrArgData.setValue("WORK_CODE", strWORK_CODE);
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				CITDatabase.executeProcedure(strSql, lrArgData);
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAKE_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DAY_CLOSE"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCLSE_DAY = CITCommon.toKOR(request.getParameter("CLSE_DAY"));
			
			strSql  = " SELECT \n";
			strSql += " 	ROWNUM, \n";
			strSql += " 	A.COMP_CODE,   \n";
			strSql += " 	A.CLSE_ACC_ID,   \n";
			strSql += " 	A.ACC_ID,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_FDT) ACCOUNT_FDT,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_EDT) ACCOUNT_EDT,   \n";
			strSql += " 	NVL(A.CLSE_CLS, 'F') ACC_CLSE_CLS,   \n";
			strSql += " 	B.CLSE_MONTH,   \n";
			strSql += " 	NVL(B.CLSE_CLS, 'F') MON_CLSE_CLS, 				  \n";
			strSql += " 	F_T_DateToString(C.CLSE_DAY) CLSE_DAY,   \n";
			strSql += " 	NVL(C.CLSE_CLS, 'F') DAY_CLSE_CLS ,  \n";
			strSql += " 	D.INPUT_DT_F, \n";
			strSql += " 	D.INPUT_DT_T, \n";
			strSql += " 	D.INPUT_DT_F||'~'||D.INPUT_DT_T INPUT_DT, \n";
			strSql += " 	D.DEPT_CLSE_CLS, \n";
			strSql += " 	(  \n";
			strSql += " 		CASE  \n";
			strSql += " 			WHEN (A.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (D.DEPT_CLSE_CLS='T') THEN 'T'  \n";
			strSql += " 			ELSE 'F'  \n";
			strSql += " 		END  \n";
			strSql += " 	) CLSE_CLS \n";
			strSql += " FROM  \n";
			strSql += " 	T_YEAR_CLOSE A,  \n";
			strSql += " 	T_MONTH_CLOSE B,  \n";
			strSql += " 	T_DAY_CLOSE C, \n";
			strSql += " 	( \n";
			strSql += " 	 	-- 부서 입력기간 체크 \n";
			strSql += " 		SELECT \n";
			strSql += " 			 ROWNUM RN, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) INPUT_DT_F, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) INPUT_DT_T, \n";
			strSql += " 			 CASE \n";
			strSql += " 			 	 WHEN ( F_T_DATETOSTRING(F_T_STRINGTODATE(?)) BETWEEN F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) AND F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) ) \n";
			strSql += " 				 THEN 'F' -- 입력기간 \n";
			strSql += " 				 ELSE 'T' -- 입력마감 \n";
			strSql += " 			END DEPT_CLSE_CLS \n";
			strSql += " 		FROM \n";
			strSql += " 			T_DEPT_CODE_ORG A \n";
			strSql += " 		WHERE   \n";
			strSql += " 			A.COMP_CODE = ? \n";
			strSql += " 			AND DEPT_CODE = ? \n";
			strSql += " 	) D \n";
			strSql += " WHERE   \n";
			strSql += " 	A.COMP_CODE = B.COMP_CODE  \n";
			strSql += " 	AND A.CLSE_ACC_ID = B.CLSE_ACC_ID  \n";
			strSql += " 	AND B.COMP_CODE = C.COMP_CODE  \n";
			strSql += " 	AND B.CLSE_ACC_ID = C.CLSE_ACC_ID  \n";
			strSql += " 	AND B.CLSE_MONTH = C.CLSE_MONTH  \n";
			strSql += " 	AND ROWNUM = D.RN(+) \n";
			strSql += " 	AND A.COMP_CODE = ? \n";
			strSql += " 	AND C.CLSE_DAY = ? ";

			lrArgData.addColumn("CLSE_DAY1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE1", CITData.VARCHAR2);
			
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_DAY2", CITData.VARCHAR2);
			
			lrArgData.addRow();
			
			lrArgData.setValue("CLSE_DAY1", strCLSE_DAY);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE1", strDEPT_CODE);

			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("CLSE_DAY2", strCLSE_DAY);
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
				GauceInfo.response.writeException("USER", "900001","CLSE_CLS Select 오류-> "+ ex.getMessage());
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