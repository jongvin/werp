<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsPARAM = null;
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(끝)
	//Dataset이 여러개이면 아래 나타나는 부분중 '//복사시작' 에서 '//복사끝' 까지를 기존 갱신 페이지의 '//여기에 붙여넣으세요' 자리에 붙여넣으세요
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	CITData lrArgData;
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
	//복사시작
			dsPARAM = GauceInfo.request.getGauceDataSet("dsPARAM");
			
			if (dsPARAM == null) throw new Exception("dsPARAM이(가) 널(Null)입니다.");
			
			rows = dsPARAM.getDataRows();
			
			try
			{
				lrArgData = new CITData();
				
				strSql = "{call SP_T_FB_REPORT_TARGET2_ALL_D(?)}";
				
				lrArgData.addColumn("CREATION_EMP_NO", CITData.VARCHAR2);

				lrArgData.addRow();
				lrArgData.setValue("CREATION_EMP_NO", strUserNo);
				
				CITDatabase.executeProcedure(strSql, lrArgData, conn);
				for	(int i = 0;	i <	rows.length; i++)
				{
					lrArgData = new CITData();
					
					strSql = "{call SP_T_FB_REPORT_TARGET2_I(?,?)}";
					
					lrArgData.addColumn("CREATION_EMP_NO", CITData.VARCHAR2);
					lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("CREATION_EMP_NO", strUserNo);
					lrArgData.setValue("PAY_SEQ", rows[i].getString(dsPARAM.indexOfColumn("PAY_SEQ")));
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FB_REPORT_TARGET1 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요
		}
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>
