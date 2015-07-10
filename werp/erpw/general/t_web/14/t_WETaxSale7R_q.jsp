<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxDeptR_q(부서 등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-05-11)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	String	strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strDOC_COM_ID 	= CITCommon.toKOR(request.getParameter("DOC_COM_ID"));
			String strGEN_TM_S 		= CITCommon.toKOR(request.getParameter("GEN_TM_S"));
			String strGEN_TM_E 		= CITCommon.toKOR(request.getParameter("GEN_TM_E"));
			String strSUP_REGNUM 	= CITCommon.toKOR(request.getParameter("SUP_REGNUM"));
			String strDOC_NUMBER 	= CITCommon.toKOR(request.getParameter("DOC_NUMBER"));
			String strBUY_REGNUM 	= CITCommon.toKOR(request.getParameter("BUY_REGNUM"));
			
strSql  = " SELECT  LINE_FLAG,		 		\n";
strSql += "					COM_ID,          	\n";
strSql += "					GEN_TM,          	\n";
strSql += "					DOC_NUMBER,      	\n";
strSql += "					SUP_REGNUM,      	\n";
strSql += "					SUP_COMPANY,     	\n";
strSql += "					BUY_REGNUM,      	\n";
strSql += "					BUY_COMPANY,     	\n";
strSql += "					ITEM_SEQ,        	\n";
strSql += "					ITEM_CODE,				\n";
strSql += "					ITEM_NAME,				\n";
strSql += "					ITEM_UNIT,				\n";
strSql += "					ITEM_NUM,					\n";
strSql += "					ITEM_DANGA,				\n";
strSql += "					TAX_SUPPRICE,			\n";
strSql += "					TAX_TAXPRICE,			\n";
strSql += "					TAX_SUPPRICE + TAX_TAXPRICE SUM	\n";
strSql += "FROM (				           		\n";
strSql += "Select	'공급자:' || RTRIM(A.SUP_COMPANY) 	LINE_FLAG 	,		\n";	
strSql += "				RTRIM(A.DOC_COM_ID)    							COM_ID			,	  \n";
strSql += "				RTRIM(A.DOC_NUMBER)    							DOC_NUMBER  ,   \n";
strSql += "				F_T_DATETOSTRING(A.GEN_TM) 					GEN_TM			,   \n";
strSql += "				F_T_Cust_Mask(RTRIM(A.SUP_REGNUM))	SUP_REGNUM	,   \n";
strSql += "				RTRIM(A.SUP_COMPANY)								SUP_COMPANY	,   \n";
strSql += "				F_T_Cust_Mask(RTRIM(A.BUY_REGNUM))	BUY_REGNUM	,   \n";
strSql += "				RTRIM(A.BUY_COMPANY)								BUY_COMPANY	,   \n";
strSql += "				RTRIM(B.ITEM_SEQ)										ITEM_SEQ		,   \n";
strSql += "				RTRIM(B.ITEM_CODE)									ITEM_CODE		,   \n";
strSql += "				RTRIM(B.ITEM_NAME)									ITEM_NAME		,   \n";
strSql += "				RTRIM(B.ITEM_UNIT)									ITEM_UNIT		,   \n";
strSql += "				NVL(B.ITEM_NUM,0)										ITEM_NUM		,   \n";
strSql += "				NVL(B.ITEM_DANGA,0)									ITEM_DANGA	,   \n";
strSql += "				NVL(B.TAX_SUPPRICE,0)								TAX_SUPPRICE,		\n";
strSql += "				NVL(B.TAX_TAXPRICE,0)								TAX_TAXPRICE		\n";
strSql += " From	TB_WT_SALE A , 					                          	\n";
strSql += " 			TB_WT_SALE_ITEM B		                             		\n";
strSql += " Where	A.DOC_COM_ID  = B.COM_ID     		                		\n";
strSql += " And		A.DOC_NUMBER  = B.DOC_NUMBER 		                		\n";
strSql += " And		A.DOC_COM_ID	= ? 							                    \n";
strSql += " And		A.GEN_TM   		between ? and ?	          						\n";
if(!"".equals(strSUP_REGNUM)) strSql += " And	RTRIM(A.SUP_REGNUM) = ? \n";
if(!"".equals(strDOC_NUMBER)) strSql += " And	RTRIM(A.DOC_NUMBER) = ? \n";
if(!"".equals(strBUY_REGNUM)) strSql += " And	RTRIM(A.BUY_REGNUM) = ? \n";
strSql += " And		LOWER(A.DEL_STATUS) <> 'd'			                    \n";
strSql += ")                                                          \n";
strSql += "ORDER BY SUP_REGNUM	,BUY_REGNUM ,DOC_NUMBER, GEN_TM ,ITEM_SEQ        \n";

   
			lrArgData.addColumn("1DOC_COM_ID", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_S", CITData.VARCHAR2);
			lrArgData.addColumn("1GEN_TM_E", CITData.VARCHAR2);
			if(!"".equals(strSUP_REGNUM)) lrArgData.addColumn("1SUP_REGNUM", CITData.VARCHAR2);
			if(!"".equals(strDOC_NUMBER)) lrArgData.addColumn("1DOC_NUMBER", CITData.VARCHAR2);
			if(!"".equals(strBUY_REGNUM)) lrArgData.addColumn("1BUY_REGNUM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1DOC_COM_ID", 	strDOC_COM_ID);
			lrArgData.setValue("1GEN_TM_S", 		strGEN_TM_S);
			lrArgData.setValue("1GEN_TM_E", 		strGEN_TM_E);
			if(!"".equals(strSUP_REGNUM)) lrArgData.setValue("1SUP_REGNUM", strSUP_REGNUM);
			if(!"".equals(strDOC_NUMBER)) lrArgData.setValue("1DOC_NUMBER", strDOC_NUMBER);
			if(!"".equals(strBUY_REGNUM)) lrArgData.setValue("1BUY_REGNUM", strBUY_REGNUM);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				/*lrReturnData.setKey("DOC_COM_ID", true);
				lrReturnData.setKey("DOC_NUMBER", true);
				lrReturnData.setNotNull("DOC_COM_ID", true);
				lrReturnData.setNotNull("DOC_NUMBER", true);*/
			
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