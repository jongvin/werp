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

			String	strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String	strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			
			strSql  = " select e.dept_code, \n";
			strSql += " 	   e.dept_code ||' '||f.dept_NAME dept_NAME, \n";
			strSql += " 	   d.ASSET_MNG_NO, \n";
			strSql += " 	   d.asset_name, \n";
			strSql += " 	   a.asset_cls_name, \n";
			strSql += " 	   b.item_name, \n";
			strSql += " 	   c.item_nm_name, \n";
			strSql += " 	   decode(d.fixed_cls,'1','유형자산','2','무형자산') fixed_cls_name, \n";
			strSql += " 	   f_t_datetostring(d.get_dt) get_dt, \n";
			strSql += " 	   asset_cnt, \n";
			strSql += " 	   start_asset_amt, \n";
			strSql += " 	   inc_sum_amt, \n";
			strSql += " 	   sub_sum_amt, \n";
			strSql += " 	   start_asset_amt + inc_sum_amt - sub_sum_amt jan, \n";
			strSql += " 	   curr_asset_inc_amt, \n";
			strSql += " 	   curr_asset_sub_amt, \n";
			strSql += " 	   old_deprec_amt \n";
			strSql += " from t_fix_asset_cls_code a, \n";
			strSql += " 	 t_fix_item_code b, \n";
			strSql += " 	 t_fix_item_nm_code c, \n";
			strSql += " 	 t_fix_sheet d, \n";
			strSql += " 	( select a.fix_asset_seq, \n";
			strSql += " 	  		 b.dept_code \n";
			strSql += " 	  from \n";
			strSql += " 	  	 (select fix_asset_seq, \n";
			strSql += " 	 			 max(move_seq) move_seq \n";
			strSql += " 	 	  from t_fix_move \n";
			strSql += " 	      group by fix_asset_seq) a, \n";
			strSql += " 		  t_fix_move b \n";
			strSql += " 	  where a.fix_asset_seq = b.fix_asset_seq \n";
			strSql += " 	  and	a.move_seq		= b.move_seq) e, \n";
			strSql += " 	 t_dept_code f \n";
			strSql += " where a.ASSET_CLS_CODE (+)= b.ASSET_CLS_CODE \n";
			strSql += " and	  b.ASSET_CLS_CODE (+)= c.ASSET_CLS_CODE \n";
			strSql += " and	  b.item_code	   (+)= c.item_code \n";
			strSql += " and	  c.ASSET_CLS_CODE (+)= d.ASSET_CLS_CODE \n";
			strSql += " and	  c.item_code	   (+)= d.item_code \n";
			strSql += " and	  c.item_nm_code   (+)= d.item_nm_code \n";
			strSql += " and	  d.fix_asset_seq  = e.fix_asset_seq(+) \n";
			strSql += " and	  e.dept_code  = f.dept_code(+) \n";
			strSql += " and	  d.sale_dt is null \n";
			strSql += " and	  NVL(d.deprec_finish, ' ')   NOT in ('3','4') ";
			strSql += " and	  e.dept_code like '%'|| ? || '%'\n";
			strSql += " and	  d.asset_cls_code like '%'|| ? || '%'\n";
			strSql += " order by e.dept_code, d.asset_cls_code, d.item_code, d.item_nm_code \n";

			
			lrArgData.addColumn("DEPT_CODE",CITData.VARCHAR2);
			lrArgData.addColumn("ASSET_CLS_CODE",CITData.VARCHAR2);

			lrArgData.addRow();
			lrArgData.setValue("DEPT_CODE",strDEPT_CODE);
			lrArgData.setValue("ASSET_CLS_CODE",strASSET_CLS_CODE);
			
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

			
			strSql  += "Select 							\n";
			strSql  += "	'%' ASSET_CLS_CODE, 			\n";
			strSql  += "	'전체'  ASSET_CLS_NAME		\n";
			strSql  += "from dual 						\n";
			strSql  += "Union							\n";
			strSql  += "Select  							\n";
			strSql  += "	a.ASSET_CLS_CODE ,  			\n";
			strSql  += "	a.ASSET_CLS_NAME  			\n";
			strSql  += "From	T_FIX_ASSET_CLS_CODE a  	\n";
			


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