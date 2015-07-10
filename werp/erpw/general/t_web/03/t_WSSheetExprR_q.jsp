<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
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
			String strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.ITEM_CODE , \n";
			strSql += " 	To_Char(a.CRTUSERNO) CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	To_Char(a.MODUSERNO) MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.ITEM_NAME , \n";
			strSql += " 	Nvl(a.ITEM_LVL,0) ITEM_LVL , \n";
			strSql += " 	a.POSITION , \n";
			strSql += " 	a.SEQ_TYPE , \n";
			strSql += " 	Decode(a.BOLD_CLS,'T','1','0') BOLD_CLS , \n";
			strSql += " 	a.OUT_CLS, \n";
			strSql += " 	a.UPLINE_CLS, \n";
			strSql += " 	a.DOWNLINE_CLS, \n";
			strSql += " 	Decode(a.CURR_PROFIT_CLS,'T','1','0') CURR_PROFIT_CLS, \n";
			strSql += " 	a.CURR_PAST_CLS , \n";
			strSql += " 	a.EXPR_SEQ1 , \n";
			strSql += " 	a.ITEM_ENG_NAME , \n";
			strSql += " 	a.COST_CODE \n";
			strSql += " From	T_SHEET_EXPR_HEAD a \n";
			strSql += " Where	a.SHEET_CODE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.ITEM_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SHEET_CODE", strSHEET_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SHEET_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				lrReturnData.setNotNull("POSITION", true);
				
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
		else if (strAct.equals("SUB01"))
		{
			String strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			String strITEM_CODE = CITCommon.toKOR(request.getParameter("ITEM_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.ITEM_CODE , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	To_Char(a.CRTUSERNO) CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	To_Char(a.MODUSERNO) MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.POSITION , \n";
			strSql += " 	a.REMAIN_CLS , \n";
			strSql += " 	a.CALC_CLS, \n";
			strSql += " 	Decode \n";
			strSql += " 	(b.EXPR_SEQ1,'0', \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				c.ACC_NAME \n";
			strSql += " 			From	T_ACC_CODE c \n";
			strSql += " 			Where	a.ACC_CODE = c.ACC_CODE \n";
			strSql += " 		), \n";
			strSql += " 		'1', \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				c.ITEM_NAME \n";
			strSql += " 			From	T_SHEET_EXPR_HEAD c \n";
			strSql += " 			Where	a.SHEET_CODE = c.SHEET_CODE \n";
			strSql += " 			And		a.ACC_CODE = c.ITEM_CODE \n";
			strSql += " 		), \n";
			strSql += " 		'2', \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				c.ITEM_NAME \n";
			strSql += " 			From	T_SHEET_EXPR_HEAD c \n";
			strSql += " 			Where	a.SHEET_CODE = c.SHEET_CODE \n";
			strSql += " 			And		a.ACC_CODE = c.ITEM_CODE \n";
			strSql += " 		), \n";
			strSql += " 		'3', \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				c.ITEM_NAME \n";
			strSql += " 			From	T_SHEET_EXPR_HEAD c \n";
			strSql += " 			Where	a.SHEET_CODE = c.SHEET_CODE \n";
			strSql += " 			And		a.ACC_CODE = c.ITEM_CODE \n";
			strSql += " 		), \n";
			strSql += " 		'4', \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				c.ITEM_NAME \n";
			strSql += " 			From	T_SHEET_EXPR_HEAD c \n";
			strSql += " 			Where	a.SHEET_CODE = c.SHEET_CODE \n";
			strSql += " 			And		a.ACC_CODE = c.ITEM_CODE \n";
			strSql += " 		), \n";
			strSql += " 	'') ACC_CODE_NAME \n";
			strSql += " From	T_SHEET_EXPR_BODY a, \n";
			strSql += " 		T_SHEET_EXPR_HEAD b \n";
			strSql += " Where	a.SHEET_CODE = b.SHEET_CODE \n";
			strSql += " And		a.ITEM_CODE = b.ITEM_CODE \n";
			strSql += " And		a.SHEET_CODE =  ?  \n";
			strSql += " And		a.ITEM_CODE =  ?  \n";
			strSql += " Order By  a.ITEM_CODE,a.ACC_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2ITEM_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SHEET_CODE", strSHEET_CODE);
			lrArgData.setValue("2ITEM_CODE", strITEM_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SHEET_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setKey("SEQ", true);
				lrReturnData.setNotNull("ACC_CODE", true);
				lrReturnData.setNotNull("POSITION", true);
				lrReturnData.setNotNull("REMAIN_CLS", true);
				lrReturnData.setNotNull("CALC_CLS", true);
				
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
		else if (strAct.equals("SELECT01"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.ACC_NAME , \n";
			strSql += " 	a.ACC_GRP , \n";
			strSql += " 	a.ACC_LVL , \n";
			strSql += " 	a.ACC_REMAIN_POSITION, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.CODE_LIST_NAME \n";
			strSql += " 		From	V_T_CODE_LIST b \n";
			strSql += " 		Where	a.ACC_GRP = b.CODE_LIST_ID \n";
			strSql += " 		And		b.CODE_GROUP_ID = 'ACC_GRP' \n";
			strSql += " 	) ACC_GRP_NAME, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.CODE_LIST_NAME \n";
			strSql += " 		From	V_T_CODE_LIST b \n";
			strSql += " 		Where	a.ACC_LVL = b.CODE_LIST_ID \n";
			strSql += " 		And		b.CODE_GROUP_ID = 'ACC_LVL' \n";
			strSql += " 	) ACC_LVL_NAME, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.CODE_LIST_NAME \n";
			strSql += " 		From	V_T_CODE_LIST b \n";
			strSql += " 		Where	a.ACC_REMAIN_POSITION = b.CODE_LIST_ID \n";
			strSql += " 		And		b.CODE_GROUP_ID = 'ACC_REMAIN_POSITION' \n";
			strSql += " 	) ACC_REMAIN_POSITION_NAME, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			b.CODE_LIST_NAME \n";
			strSql += " 		From	V_T_CODE_LIST b \n";
			strSql += " 		Where	a.ACC_REMAIN_POSITION = b.CODE_LIST_ID \n";
			strSql += " 		And		b.CODE_GROUP_ID = 'OUT_CLS' \n";
			strSql += " 	) OUT_CLS_NAME \n";
			strSql += " From	T_ACC_CODE a \n";
			strSql += " Order By \n";
			strSql += " 	a.ACC_CODE \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","SELECT01 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SELECT02"))
		{
			String strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.ITEM_CODE , \n";
			strSql += " 	To_Char(a.CRTUSERNO) CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	To_Char(a.MODUSERNO) MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.ITEM_NAME , \n";
			strSql += " 	Nvl(a.ITEM_LVL,0) ITEM_LVL , \n";
			strSql += " 	a.POSITION , \n";
			strSql += " 	a.SEQ_TYPE , \n";
			strSql += " 	To_Number(Decode(a.BOLD_CLS,'T','1','0')) BOLD_CLS , \n";
			strSql += " 	a.OUT_CLS, \n";
			strSql += " 	To_Number(Decode(a.UPLINE_CLS,'T','1','0')) UPLINE_CLS, \n";
			strSql += " 	To_Number(Decode(a.DOWNLINE_CLS,'T','1','0')) DOWNLINE_CLS, \n";
			strSql += " 	To_Number(Decode(a.CURR_PROFIT_CLS,'T','1','0')) CURR_PROFIT_CLS, \n";
			strSql += " 	a.CURR_PAST_CLS , \n";
			strSql += " 	a.EXPR_SEQ1 , \n";
			strSql += " 	a.ITEM_ENG_NAME , \n";
			strSql += " 	a.COST_CODE \n";
			strSql += " From	T_SHEET_EXPR_HEAD a \n";
			strSql += " Where	a.SHEET_CODE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.ITEM_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1SHEET_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1SHEET_CODE", strSHEET_CODE);
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
				GauceInfo.response.writeException("USER", "900001","SELECT02 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SHEET_CODE"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.SHEET_CODE , \n";
			strSql += " 	a.SHEET_TYPE , \n";
			strSql += " 	a.SHEET_NAME \n";
			strSql += " From	T_SHEET_CODE a \n";
			strSql += " Order By \n";
			strSql += " 	a.SHEET_CODE \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","SHEET_CODE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CURR_PAST_CLS"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID , \n";
			strSql += " 	a.CODE_LIST_NAME , \n";
			strSql += " 	a.SEQ \n";
			strSql += " From	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'CURR_PAST_CLS' \n";
			strSql += " And		a.USE_TAG = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ, \n";
			strSql += " 	a.CODE_LIST_ID \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","CURR_PAST_CLS Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("EXPR_SEQ1"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID , \n";
			strSql += " 	a.CODE_LIST_NAME , \n";
			strSql += " 	a.SEQ \n";
			strSql += " From	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'EXPR_SEQ1' \n";
			strSql += " And		a.USE_TAG = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ, \n";
			strSql += " 	a.CODE_LIST_ID \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","EXPR_SEQ1 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("POSITION"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID , \n";
			strSql += " 	a.CODE_LIST_NAME , \n";
			strSql += " 	a.SEQ \n";
			strSql += " From	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'POSITION' \n";
			strSql += " And		a.USE_TAG = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ, \n";
			strSql += " 	a.CODE_LIST_ID \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","POSITION Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("CALC_CLS"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID , \n";
			strSql += " 	a.CODE_LIST_NAME , \n";
			strSql += " 	a.SEQ \n";
			strSql += " From	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'CALC_CLS' \n";
			strSql += " And		a.USE_TAG = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ, \n";
			strSql += " 	a.CODE_LIST_ID \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","CALC_CLS Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMAIN_CLS"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID , \n";
			strSql += " 	a.CODE_LIST_NAME , \n";
			strSql += " 	a.SEQ \n";
			strSql += " From	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'REMAIN_CLS' \n";
			strSql += " And		a.USE_TAG = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ, \n";
			strSql += " 	a.CODE_LIST_ID \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","REMAIN_CLS Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE"))
		{

			
			strSql  = "select \n";
			strSql  += "	RPad('X',40,'X') SHEET_CODE, \n";
			strSql  += "	0 CRTUSERNO \n";
			strSql  += "From	dual";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE2"))
		{

			
			strSql  = "select \n";
			strSql  += "	RPad('X',40,'X') SHEET_CODE_TARGET,RPad('X',40,'X') SHEET_CODE_SOURCE, \n";
			strSql  += "	0 CRTUSERNO \n";
			strSql  += "From	dual";
			

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
				GauceInfo.response.writeException("USER", "900001","MAKE2 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SEQ_TYPE"))
		{

			
			strSql  = "Select \n";
			strSql  += "	a.SEQ_TYPE, \n";
			strSql  += "	a.SEQ_TYPE_NAME \n";
			strSql  += "From	TIA_SHEET_SEQ_TYPE a \n";
			strSql  += "Union Select '0','기본유형' from dual \n";
			strSql  += "Order By \n";
			strSql  += "	1";
			

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
				GauceInfo.response.writeException("USER", "900001","SEQ_TYPE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ITEM_LVL"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID , \n";
			strSql += " 	a.CODE_LIST_NAME , \n";
			strSql += " 	a.SEQ \n";
			strSql += " From	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'ITEM_LVL' \n";
			strSql += " And		a.USE_TAG = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ, \n";
			strSql += " 	a.CODE_LIST_ID \n";
			strSql += "  ";
			

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
				GauceInfo.response.writeException("USER", "900001","ITEM_LVL Select 오류-> "+ ex.getMessage());
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