<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-01-14
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	
	String strSysID = "";
	String strUserNo = "";
	String strUserName = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strSysID = session.getAttribute("sys_id") == null ? "0" : session.getAttribute("sys_id").toString();
		strUserNo = session.getAttribute("emp_no") == null ? "0" : session.getAttribute("emp_no").toString();
		strUserName = session.getAttribute("user_nm") == null ? "" : session.getAttribute("user_nm").toString();
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("REQUEST_LIST"))
		{
			try
			{
				String	strRequestName = CITCommon.toKOR(request.getParameter("REQUEST_NAME"));
				String	strState = CITCommon.toKOR(request.getParameter("STATE"));
			
				lrArgData.addColumn("USER_NO", CITData.VARCHAR2);
				lrArgData.addColumn("REQUEST_NAME", CITData.VARCHAR2);
				lrArgData.addColumn("STATE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("USER_NO", strUserNo);
				lrArgData.setValue("REQUEST_NAME", "%" + strRequestName + "%");
				lrArgData.setValue("STATE", strState);
				
				strSql  = " Select a.REPORT_REQUEST_NO, ";
				strSql += "        a.USER_NO, ";
				strSql += "        a.REPORT_NO, ";
				strSql += "        a.SYS_ID, ";
				strSql += "        b.REPORT_NAME, ";
				strSql += "        a.REQUEST_NAME, ";
				strSql += "        to_char(a.REQUEST_DATE, 'yyyy-mm-dd hh24:mi:ss') as REQUEST_DATE, ";
				strSql += "        to_char(a.COMPLETE_DATE, 'yyyy-mm-dd hh24:mi:ss') as COMPLETE_DATE, ";
				strSql += "        a.REQUEST_FILE_NAME, ";
				strSql += "        F_T_DATETOSTRING(a.DELETE_EXPECT_DATE) as DELETE_EXPECT_DATE, ";
				strSql += "        a.STATE, ";
				strSql += "        c.CODE_LIST_NAME as STATE_NAME, ";
				strSql += "        a.REMARK ";
				strSql += " From   T_USER_REPORT_REQUEST a, ";
				strSql += "        T_REPORT b, ";
				strSql += "        V_T_CODE_LIST c ";
				strSql += " Where  a.REPORT_NO = b.REPORT_NO (+) ";
				strSql += "  And   a.STATE = c.CODE_LIST_ID(+) ";
				strSql += "  And   c.CODE_GROUP_ID(+) = 'REPORT_REQUEST_STATE' ";
				strSql += "  And   a.USER_NO = ? ";
				strSql += "  And   a.REQUEST_NAME Like ? ";
				strSql += "  And   a.STATE Like ? ";
				strSql += " Order by a.REQUEST_DATE desc ";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001", "T_USER_REPORT_REQUEST 테이블 Select 오류 -> " + ex.getMessage());
				throw new Exception("USER-900001:T_USER_REPORT_REQUEST 테이블 Select 오류 -> " + ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    	throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>