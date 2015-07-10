<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxUserR_q(부서 등록)
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
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCOMPANY_CODE = CITCommon.toKOR(request.getParameter("COMPANY_CODE"));
			String strUSER_CODE = CITCommon.toKOR(request.getParameter("USER_CODE"));
			String strWEBTAX21_ID = CITCommon.toKOR(request.getParameter("WEBTAX21_ID"));
			String strUSER_NAME = CITCommon.toKOR(request.getParameter("USER_NAME"));

			strSql  = " Select	A.COM_ID		, \n";
			strSql += "       	A.EMP_NO 		, \n";
			strSql += "       	A.EMP_ID 		, \n";
			strSql += "       	A.EMP_NAME 	, \n";
			strSql += "       	A.PASSWORD	, \n";
			strSql += "       	A.REG_NUM  	, \n";
			strSql += "       	( select d.company from tb_wt_plant d 				\n";
			strSql += "       		where  d.reg_num = A.reg_num ) COMPANY ,		\n";
			strSql += "       	A.SECT_CODE , \n";
			strSql += "       	( select e.sect_name from tb_wt_sect e 						\n";
			strSql += "       		where  e.com_id 		= A.com_id 									\n";			
			strSql += "       		and    e.sect_code 	= A.sect_code ) SECT_NAME,	\n";			
			strSql += "       	A.GRADE   	, \n";			
			strSql += "       	A.TEL_NO 		, \n";
			strSql += "       	A.RES_NO 		, \n";
			strSql += "       	DECODE(A.RET_YN	,'Y','T','F') RET_YN	, \n";
			strSql += "       	A.EMAIL  		, \n";
			strSql += "       	A.MOBILE  	, \n";
			strSql += "       	A.DIV_GROUP  	, \n";
			strSql += "       	B.KN_CODE  DIV_NAME	, \n";
			strSql += "       	A.INPUT_DATE , \n";
			strSql += "       	A.UPDATE_DATE, \n";			
			strSql += "       	A.INPUT_EMP			, \n";	
			strSql += "       	A.UPDATE_EMP    ,	\n";	
			strSql += "       	( select c.com_name from tb_wt_company c 	\n";
			strSql += "       		where  c.com_id = A.com_id ) COM_NAME		\n";
			strSql += " From	TB_WT_USER A ,  \n";
			strSql += " 			TB_WT_COMMON_CODE B  \n";
			strSql += " Where	A.COM_ID    = ?   \n";
			strSql += " And  	A.DIV_GROUP = B.CD_CODE   \n";
			strSql += " And  	B.CD_CLASS  = 'ELE001'   \n";
			if(!"".equals(strUSER_CODE)) 		strSql += " And		A.EMP_NO like ? ||'%' \n";
			if(!"".equals(strWEBTAX21_ID)) 	strSql += " And		A.EMP_ID like ? ||'%' \n";
			if(!"".equals(strUSER_NAME)) 		strSql += " And		A.EMP_NAME like '%' || ? || '%' \n";
			
			lrArgData.addColumn("COMPANY_CODE", CITData.VARCHAR2);
			if(!"".equals(strUSER_CODE)) lrArgData.addColumn("USER_CODE", CITData.VARCHAR2);
			if(!"".equals(strWEBTAX21_ID)) lrArgData.addColumn("WEBTAX21_ID", CITData.VARCHAR2);
			if(!"".equals(strUSER_NAME)) lrArgData.addColumn("USER_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMPANY_CODE", strCOMPANY_CODE);
			if(!"".equals(strUSER_CODE)) lrArgData.setValue("USER_CODE", strUSER_CODE);
			if(!"".equals(strWEBTAX21_ID)) lrArgData.setValue("WEBTAX21_ID", strWEBTAX21_ID);
			if(!"".equals(strUSER_NAME)) lrArgData.setValue("USER_NAME", strUSER_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COM_ID", true);
				lrReturnData.setKey("EMP_NO", true);
				lrReturnData.setNotNull("EMP_NO", true);
				lrReturnData.setNotNull("COM_ID", true);
			
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