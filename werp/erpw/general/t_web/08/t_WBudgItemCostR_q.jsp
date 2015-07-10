<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-09)
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

			String	strCheck          		= CITCommon.toKOR(request.getParameter("CHECK"));
			String	strBUDG_CODE_NAME 	= CITCommon.toKOR(request.getParameter("BUDG_CODE_NAME"));
			String	strP_BUDG_CODE_NO   	= CITCommon.toKOR(request.getParameter("P_BUDG_CODE_NO"));
			String	strBUDG_CODE_NO   	= CITCommon.toKOR(request.getParameter("BUDG_CODE_NO"));
			String	strCOMP_CODE   		= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strCLSE_ACC_ID   		= CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
		
			strSql  = " select budg_code_no,    	 \n";
			strSql += " 	   clse_acc_id,     		 \n";
			strSql += " 	   comp_code,       		 \n";
			strSql += " 	   full_budg_code_name,   \n";
			strSql += " 	   P_budg_code_no,  	 \n";
			strSql += " 	   budg_code_name,  	 \n";
			strSql += " 	   item_no,       		 \n";
			strSql += " 	   item_name, 			 \n";
			strSql += " 	   day_calc_tag, 		 \n";
			strSql += " 	   unit_tag, 			 \n";
			strSql += " 	   grade_unit_tag, 		 \n";
			strSql += " 	   nvl(all_chg_tag, 'F') all_chg_tag,	\n";
			strSql += " 	   unit_cost, 			 \n";
			strSql += " 	   0 month_cost 		 \n";
			strSql += " from                         		\n";
			strSql += " (select                              	\n";
			strSql += " 	   a.budg_code_no,        \n";
			strSql += " 	   a.clse_acc_id	,        	\n";
			strSql += " 	   a.comp_code,          	\n";
			strSql += " 	   a.item_no,			\n";
			strSql += " 	   a.item_name, 		\n";
			strSql += " 	   a.day_calc_tag, 		\n";
			strSql += " 	   a.unit_tag, 			\n";
			strSql += " 	   a.grade_unit_tag,		\n";
			strSql += " 	   a. all_chg_tag,	 	\n";
			strSql += " 	   a.unit_cost, 			\n";
			strSql += " 	   b.p_budg_code_no,    \n";
			strSql += " 	   b.budg_code_name ,	\n";
			strSql += " 	   b.full_budg_code_name \n";
			strSql += " from T_BUDG_ITEM_COST a, \n";
			strSql += " 	( select p_budg_code_no, \n";
			strSql += " 	 	    budg_code_no,     \n";
			strSql += " 	 	    budg_code_name, \n";
			strSql += " 	 	    LTRIM(Replace(sys_connect_by_path(budg_code_name,'/'),'/',' ')) full_budg_code_name  \n";
			strSql += " 	  from   t_budg_code c  \n";
			strSql += " 	  where   comp_code = ?  \n";
			strSql += " 	 and  c.budg_code_no not in(  \n";
			strSql += " 	 							select p_budg_code_no \n";
			strSql += " 	 							from t_budg_code  \n";
			strSql += " 	 			      			      where   comp_code = ? ) \n";
			strSql += " 	 	start with  p_budg_code_no = ? \n";
			strSql += " 	 	connect by p_budg_code_no = prior budg_code_no \n";
			strSql += " 	 	order siblings by p_budg_code_no, budg_code_no, level_seq  \n";
			strSql += " 	) b\n";
			strSql += " where a.budg_code_no = b.BUDG_CODE_NO  \n";
			strSql += " and    COMP_CODE = ? \n";
			strSql += " and    CLSE_ACC_ID = ? \n";
			strSql += " and   a.BUDG_CODE_NO like '%' || ? ||'%' )\n";

				lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("P_BUDG_CODE_NO", CITData.NUMBER);
				lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("BUDG_CODE_NO", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("P_BUDG_CODE_NO", strP_BUDG_CODE_NO);
				lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("BUDG_CODE_NO", strBUDG_CODE_NO);

			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("BUDG_CODE_NO", true);
				lrReturnData.setKey("ITEM_NO", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				lrReturnData.setNotNull("DAY_CALC_TAG", true);
				lrReturnData.setNotNull("UNIT_TAG", true);
				lrReturnData.setNotNull("GRADE_UNIT_TAG", true);
				
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
		if (strAct.equals("SUB01"))
		{

			String	strBUDG_CODE_NO = CITCommon.toKOR(request.getParameter("BUDG_CODE_NO"));
			String	strITEM_NO      = CITCommon.toKOR(request.getParameter("ITEM_NO"));
			String	strCOMP_CODE   		= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String	strCLSE_ACC_ID   		= CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " select B.BUDG_CODE_NO, \n";
			strSql += "        B.ITEM_NO, \n";
			strSql += "        B.GRADE_CODE, \n";
			strSql += "        B.UNIT_COST,  \n";
			strSql += "        B.CLSE_ACC_ID,  \n";
			strSql += "        B.COMP_CODE  \n";
			strSql += " from   t_budg_item_cost a, \n";
			strSql += "         t_budg_item_grade_cost b, \n";
			strSql += "	  (Select \n";
			strSql += "			a.CODE_LIST_ID AS CODE, \n";
			strSql += "			a.CODE_LIST_NAME AS NAME, \n";
			strSql += "			a.SEQ \n";
			strSql += "	  From	V_T_CODE_LIST a \n";
			strSql += "	 Where	a.CODE_GROUP_ID = 'GRADE_CODE' \n";
			strSql += "	 And	a.USE_TAG = 'T' \n";
			strSql += "	 Order By \n";
			strSql += "	 a.SEQ ) c \n";
			strSql += " where  a.BUDG_CODE_NO = b.budg_code_no \n";
			strSql += " and    a.ITEM_NO = b.ITEM_NO \n";
			strSql += " and    b.grade_code = c.CODE \n";
			strSql += " and    a.BUDG_CODE_NO = ?  \n";
			strSql += " and    a.ITEM_NO = ? \n";
			strSql += " and    a.COMP_CODE = ? \n";
			strSql += " and    a.CLSE_ACC_ID = ? \n";
			strSql += " order  by item_no, grade_code ";
			
			lrArgData.addColumn("BUDG_CODE_NO", CITData.NUMBER);
			lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BUDG_CODE_NO", strBUDG_CODE_NO);
			lrArgData.setValue("ITEM_NO", strITEM_NO);
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("BUDG_CODE_NO", true);
				lrReturnData.setKey("ITEM_NO", true);
				lrReturnData.setKey("GRADE_CODE", true);

				
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
		
		else if (strAct.equals("BUDG_CODE_NO"))
		{

			
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));

			strSql  = " select \n";
			strSql += " 	p_budg_code_no, \n";
			strSql += " 	p_budg_code_no budg_code_no, \n";
			strSql += " 	budg_code_name || ' 전체'  budg_code_name \n";
			strSql += " from	(Select * From t_budg_code b Where comp_code =  ? ) b \n";
			strSql += " where	b.P_BUDG_CODE_NO Not In  \n";
			strSql += " 		( \n";
			strSql += " 			select \n";
			strSql += " 				x.BUDG_CODE_NO \n";
			strSql += " 			from t_budg_code x \n";
			strSql += " 			where comp_code =  ? ) \n";
			strSql += " union all \n";
			strSql += " select \n";
			strSql += " 	p_budg_code_no, \n";
			strSql += " 	budg_code_no, \n";
			strSql += " 	budg_code_name \n";
			strSql += " from	(Select * From t_budg_code Where comp_code =  ? ) c \n";
			strSql += " where	p_budg_code_no in  \n";
			strSql += " ( \n";
			strSql += " 	select \n";
			strSql += " 		budg_code_no \n";
			strSql += " 	from	(Select * From t_budg_code b Where comp_code =  ? ) b \n";
			strSql += " 	where	b.P_BUDG_CODE_NO Not In  \n";
			strSql += " 			( \n";
			strSql += " 				select \n";
			strSql += " 					x.BUDG_CODE_NO \n";
			strSql += " 				from t_budg_code x \n";
			strSql += " 				where comp_code =  ? ) \n";
			strSql += " ) \n";
			strSql += " order  by 2 \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("5COMP_CODE", strCOMP_CODE);

				
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
				GauceInfo.response.writeException("USER", "900001","BUDG_CODE_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CHILD_BUDG_CODE_NO"))
		{

			String	strBUDG_CODE_NO = CITCommon.toKOR(request.getParameter("BUDG_CODE_NO"));
			String	strCOMP_CODE   		= CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " select p_budg_code_no, \n";
			strSql += "        budg_code_no, \n";
			strSql += "        budg_code_name, \n";
			strSql += "        full_budg_code_name \n";
			strSql += " from \n";
			strSql += "  \n";
			strSql += " (	select p_budg_code_no, \n";
			strSql += " 	       budg_code_no, \n";
			strSql += " 	       budg_code_name, \n";
			strSql += " 	       LTRIM(Replace(sys_connect_by_path(budg_code_name,'/'),'/',' ')) full_budg_code_name \n";
			strSql += " 	from   t_budg_code c \n";
			strSql += " 	where   comp_code = ?  \n";
			strSql += " 	and c.budg_code_no not in( \n";
			strSql += " 				select p_budg_code_no \n";
			strSql += " 				from t_budg_code  \n";
			strSql += " 			       where comp_code = ?) \n";
			strSql += " 	start with  p_budg_code_no = ? \n";
			strSql += " 	connect by p_budg_code_no = prior budg_code_no \n";
			strSql += " 	order siblings by p_budg_code_no, budg_code_no, level_seq \n";
			strSql += " ) \n";
			//strSql += " where	 full_budg_code_name  Like Replace(?,'전체','%')||'%' \n";
                                  
			lrArgData.addColumn("1COMP_CODE", CITData.NUMBER);
			lrArgData.addColumn("2COMP_CODE", CITData.NUMBER);
			lrArgData.addColumn("P_BUDG_CODE_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("P_BUDG_CODE_NO", strBUDG_CODE_NO);
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
				GauceInfo.response.writeException("USER", "900001","BUDG_CODE_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ITEM_NO"))
		{

			strSql  = " select SQ_T_BUDG_ITEM_COST.nextval ITEM_NO 		\n";                                                   
			strSql += " from dual 										\n";                                      
		                             
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
				GauceInfo.response.writeException("USER", "900001","BUDG_CODE_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("GRADE_COPY"))
		{

			strSql  = " select '##########' COMP_CODE, '######' CLSE_ACC_ID, 000000000 BUDG_CODE_NO, 0 ITEM_NO \n";                                                   
			strSql += " from dual \n";                                      
		                             
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
				GauceInfo.response.writeException("USER", "900001","BUDG_CODE_NO Select 오류-> "+ ex.getMessage());
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